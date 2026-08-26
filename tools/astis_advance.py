#!/usr/bin/env python3
"""Substantive-advance coordination for ASTIS Harness vNext.

The legacy ASTIS harness deliberately remains available: its typed source,
formalization, proof-attempt, and review artifacts are useful durable memory.
This module changes the *unit of active work*.  A worker now owns one
mathematically substantive theorem-DAG advance end to end instead of stopping
at an Upper/Middle/Lower role boundary.

The deterministic control plane is intentionally small:

* an append-only substantive-advance ledger;
* semantic duplicate suppression while an advance is active;
* a strict state machine with evidence requirements at `PROVED_LOCAL`;
* one repository-wide stabilization lane for shared imports/Registry/site work;
* a separate discovery ledger so reusable insights survive worker completion;
* bounded coordinator capsules rather than transcript replay.

All durable I/O reuses ``tools.astis_harness``: canonical-path locks, fsync,
atomic JSONL appends, and interrupted-tail recovery therefore stay compatible
with the existing ASTIS runtime.
"""

from __future__ import annotations

import argparse
import dataclasses
import json
from pathlib import Path
from typing import Any, Iterable, Sequence

try:  # package import under unit tests
    from tools import astis_harness as durable
except ImportError:  # direct `python3 tools/astis_advance.py ...`
    import astis_harness as durable  # type: ignore


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_ADVANCE_LEDGER = ROOT / "runs" / "substantive_advances.jsonl"
DEFAULT_DISCOVERY_LEDGER = ROOT / "runs" / "substantive_discoveries.jsonl"
ADVANCE_SCHEMA_VERSION = 1


class HarnessError(RuntimeError):
    """A deterministic Harness-vNext contract was violated."""


ADVANCE_STATES = (
    "PROPOSED",
    "CLAIMED",
    "EXPLORING",
    "PROVED_LOCAL",
    "VERIFIED",
    "STABILIZING",
    "MERGED",
    "BLOCKED",
    "QUARANTINED",
)

ACTIVE_ADVANCE_STATES = frozenset(
    {"PROPOSED", "CLAIMED", "EXPLORING", "PROVED_LOCAL", "VERIFIED", "STABILIZING"}
)
TERMINAL_ADVANCE_STATES = frozenset({"MERGED", "QUARANTINED"})

ALLOWED_ADVANCE_TRANSITIONS: dict[str, frozenset[str]] = {
    "PROPOSED": frozenset({"CLAIMED", "BLOCKED", "QUARANTINED"}),
    "CLAIMED": frozenset({"EXPLORING", "BLOCKED", "QUARANTINED"}),
    "EXPLORING": frozenset({"PROVED_LOCAL", "BLOCKED", "QUARANTINED"}),
    "PROVED_LOCAL": frozenset({"VERIFIED", "EXPLORING", "BLOCKED", "QUARANTINED"}),
    "VERIFIED": frozenset({"STABILIZING", "EXPLORING", "BLOCKED", "QUARANTINED"}),
    "STABILIZING": frozenset({"MERGED", "VERIFIED", "BLOCKED", "QUARANTINED"}),
    "BLOCKED": frozenset({"CLAIMED", "EXPLORING", "QUARANTINED"}),
    "QUARANTINED": frozenset(),
    "MERGED": frozenset(),
}

DISCOVERY_KINDS = frozenset(
    {"lemma", "interface", "counterexample", "source-gap", "refactor", "conjecture", "process"}
)
DISCOVERY_STATUSES = frozenset({"raw", "validated", "scheduled", "merged", "rejected"})
ALLOWED_DISCOVERY_TRANSITIONS: dict[str, frozenset[str]] = {
    "raw": frozenset({"validated", "rejected"}),
    "validated": frozenset({"scheduled", "merged", "rejected"}),
    "scheduled": frozenset({"merged", "rejected"}),
    "merged": frozenset(),
    "rejected": frozenset(),
}


def _require_text(name: str, value: str) -> None:
    if not isinstance(value, str) or not value.strip():
        raise HarnessError(f"{name} must be nonempty text")


def _as_list(values: Sequence[str] | None) -> list[str]:
    return list(values or ())


@dataclasses.dataclass(frozen=True)
class AdvanceProposal:
    advance_id: str
    task_id: str
    goal: str
    source_anchor: str
    theorem_delta: str
    truth_boundary: str
    created_by: str
    dag_inputs: tuple[str, ...] = ()
    proposed_files: tuple[str, ...] = ()
    focused_checks: tuple[str, ...] = ()
    modes: tuple[str, ...] = ()
    priority: int = 50
    created_at: str = dataclasses.field(default_factory=durable.utc_stamp)

    def validate(self) -> None:
        for name in (
            "advance_id",
            "task_id",
            "goal",
            "source_anchor",
            "theorem_delta",
            "truth_boundary",
            "created_by",
        ):
            _require_text(name, getattr(self, name))
        if not isinstance(self.priority, int) or not 0 <= self.priority <= 100:
            raise HarnessError("priority must be an integer in [0, 100]")
        if not self.dag_inputs:
            raise HarnessError("a substantive advance must name at least one DAG input")
        if not self.focused_checks:
            raise HarnessError("a substantive advance must name at least one focused check")

    def semantic_fingerprint(self) -> str:
        """Fingerprint the mathematical advance, intentionally excluding its id/owner."""

        payload = {
            "task_id": self.task_id,
            "goal": self.goal,
            "source_anchor": self.source_anchor,
            "theorem_delta": self.theorem_delta,
            "truth_boundary": self.truth_boundary,
            "dag_inputs": list(self.dag_inputs),
        }
        return durable.digest(payload)

    def as_event(self) -> dict[str, Any]:
        self.validate()
        value = dataclasses.asdict(self)
        value.update(
            {
                "schema_version": ADVANCE_SCHEMA_VERSION,
                "event": "proposal",
                "state": "PROPOSED",
                "fingerprint": self.semantic_fingerprint(),
            }
        )
        for key in ("dag_inputs", "proposed_files", "focused_checks", "modes"):
            value[key] = list(value[key])
        return value


@dataclasses.dataclass(frozen=True)
class Discovery:
    discovery_id: str
    advance_id: str
    kind: str
    statement: str
    evidence: str
    where_it_matters: str
    provenance: str
    created_by: str
    created_at: str = dataclasses.field(default_factory=durable.utc_stamp)

    def validate(self) -> None:
        for name in (
            "discovery_id",
            "advance_id",
            "kind",
            "statement",
            "evidence",
            "where_it_matters",
            "provenance",
            "created_by",
        ):
            _require_text(name, getattr(self, name))
        if self.kind not in DISCOVERY_KINDS:
            raise HarnessError(f"unsupported discovery kind: {self.kind}")

    def as_event(self) -> dict[str, Any]:
        self.validate()
        return {
            **dataclasses.asdict(self),
            "schema_version": ADVANCE_SCHEMA_VERSION,
            "event": "discovery",
            "status": "raw",
        }


def _recover_unlocked(path: Path) -> list[dict[str, Any]]:
    records, _ = durable._recover_jsonl_unlocked(path)  # reuse the legacy durable primitive
    return records


def _append_unlocked(path: Path, record: dict[str, Any]) -> None:
    durable._append_jsonl_unlocked(path, record)


def _replay_advances(records: Iterable[dict[str, Any]]) -> dict[str, dict[str, Any]]:
    state: dict[str, dict[str, Any]] = {}
    for record in records:
        event = record.get("event")
        advance_id = record.get("advance_id")
        if not isinstance(advance_id, str) or not advance_id:
            continue
        if event == "proposal":
            state[advance_id] = dict(record)
            continue
        if event == "transition" and advance_id in state:
            current = state[advance_id]
            current["state"] = record.get("to_state", current.get("state"))
            current["worker_id"] = record.get("worker_id", current.get("worker_id", ""))
            current["modes"] = list(record.get("modes") or current.get("modes") or [])
            if record.get("evidence"):
                current["latest_evidence"] = record["evidence"]
            current["updated_at"] = record.get("created_at", current.get("updated_at"))
    return state


def current_advances(path: Path = DEFAULT_ADVANCE_LEDGER) -> dict[str, dict[str, Any]]:
    """Recover an interrupted tail and replay the current substantive-advance state."""

    return _replay_advances(durable.load_jsonl(path))


def propose_advance(proposal: AdvanceProposal, path: Path = DEFAULT_ADVANCE_LEDGER) -> None:
    proposal.validate()
    path = path.resolve()
    path.parent.mkdir(parents=True, exist_ok=True)
    event = proposal.as_event()
    with durable.file_lock(path):
        records = _recover_unlocked(path)
        state = _replay_advances(records)
        if proposal.advance_id in state:
            raise HarnessError(f"duplicate substantive advance id: {proposal.advance_id}")
        fingerprint = event["fingerprint"]
        for item in state.values():
            if item.get("state") in ACTIVE_ADVANCE_STATES and item.get("fingerprint") == fingerprint:
                raise HarnessError(
                    "duplicate active substantive advance: "
                    f"{proposal.advance_id} duplicates {item.get('advance_id')}"
                )
        _append_unlocked(path, event)


def _validate_transition_evidence(to_state: str, evidence: dict[str, Any]) -> None:
    if to_state == "PROVED_LOCAL":
        required = ("theorem_delta", "lean_files", "focused_checks", "truth_boundary")
        missing = []
        for key in required:
            value = evidence.get(key)
            if isinstance(value, str):
                ok = bool(value.strip())
            elif isinstance(value, (list, tuple)):
                ok = bool(value)
            else:
                ok = value is not None
            if not ok:
                missing.append(key)
        if missing:
            raise HarnessError(
                "PROVED_LOCAL lacks evidence: " + ", ".join(missing)
            )
    elif to_state == "VERIFIED":
        if not evidence.get("gate"):
            raise HarnessError("VERIFIED lacks evidence: gate")
    elif to_state == "STABILIZING":
        if not str(evidence.get("canonical_branch", "")).strip() or not str(
            evidence.get("integration_owner", "")
        ).strip():
            raise HarnessError(
                "STABILIZING lacks evidence: canonical_branch, integration_owner"
            )
    elif to_state == "MERGED":
        if evidence.get("pr") in (None, "") or not str(evidence.get("commit", "")).strip():
            raise HarnessError("MERGED lacks evidence: pr, commit")
    elif to_state in {"BLOCKED", "QUARANTINED"}:
        if not evidence or not any(bool(value) for value in evidence.values()):
            raise HarnessError(f"{to_state} requires an exact blocker or reason")


def transition_advance(
    advance_id: str,
    to_state: str,
    *,
    worker_id: str,
    modes: Sequence[str] = (),
    evidence: dict[str, Any] | None = None,
    path: Path = DEFAULT_ADVANCE_LEDGER,
) -> None:
    _require_text("advance_id", advance_id)
    _require_text("worker_id", worker_id)
    if to_state not in ADVANCE_STATES:
        raise HarnessError(f"unsupported substantive-advance state: {to_state}")
    evidence = dict(evidence or {})
    path = path.resolve()
    path.parent.mkdir(parents=True, exist_ok=True)
    with durable.file_lock(path):
        records = _recover_unlocked(path)
        state = _replay_advances(records)
        if advance_id not in state:
            raise HarnessError(f"unknown substantive advance: {advance_id}")
        current = str(state[advance_id].get("state", ""))
        if to_state not in ALLOWED_ADVANCE_TRANSITIONS.get(current, frozenset()):
            raise HarnessError(f"illegal substantive-advance transition: {current} -> {to_state}")
        _validate_transition_evidence(to_state, evidence)

        if to_state == "STABILIZING":
            stabilizing = [
                item
                for other_id, item in state.items()
                if other_id != advance_id and item.get("state") == "STABILIZING"
            ]
            if stabilizing:
                owner = stabilizing[0].get("latest_evidence", {}).get("integration_owner", "unknown")
                raise HarnessError(
                    "single stabilization lane already occupied "
                    f"by {stabilizing[0].get('advance_id')} ({owner})"
                )
            integration_owner = str(evidence.get("integration_owner", ""))
            if integration_owner != worker_id:
                raise HarnessError(
                    "STABILIZING worker_id must equal the declared integration_owner"
                )

        _append_unlocked(
            path,
            {
                "schema_version": ADVANCE_SCHEMA_VERSION,
                "event": "transition",
                "advance_id": advance_id,
                "from_state": current,
                "to_state": to_state,
                "worker_id": worker_id,
                "modes": _as_list(modes),
                "evidence": evidence,
                "created_at": durable.utc_stamp(),
            },
        )


def _replay_discoveries(records: Iterable[dict[str, Any]]) -> dict[str, dict[str, Any]]:
    state: dict[str, dict[str, Any]] = {}
    for record in records:
        discovery_id = record.get("discovery_id")
        if not isinstance(discovery_id, str) or not discovery_id:
            continue
        if record.get("event") == "discovery":
            state[discovery_id] = dict(record)
        elif record.get("event") == "discovery_transition" and discovery_id in state:
            current = state[discovery_id]
            current["status"] = record.get("to_status", current.get("status"))
            current["updated_at"] = record.get("created_at", current.get("updated_at"))
            if record.get("note"):
                current["latest_note"] = record["note"]
            current["latest_actor"] = record.get("actor", current.get("latest_actor", ""))
    return state


def current_discoveries(path: Path = DEFAULT_DISCOVERY_LEDGER) -> dict[str, dict[str, Any]]:
    return _replay_discoveries(durable.load_jsonl(path))


def publish_discovery(discovery: Discovery, path: Path = DEFAULT_DISCOVERY_LEDGER) -> None:
    discovery.validate()
    path = path.resolve()
    path.parent.mkdir(parents=True, exist_ok=True)
    event = discovery.as_event()
    with durable.file_lock(path):
        records = _recover_unlocked(path)
        state = _replay_discoveries(records)
        if discovery.discovery_id in state:
            raise HarnessError(f"duplicate discovery id: {discovery.discovery_id}")
        _append_unlocked(path, event)


def transition_discovery(
    discovery_id: str,
    to_status: str,
    *,
    actor: str,
    note: str,
    path: Path = DEFAULT_DISCOVERY_LEDGER,
) -> None:
    _require_text("discovery_id", discovery_id)
    _require_text("actor", actor)
    _require_text("note", note)
    if to_status not in DISCOVERY_STATUSES:
        raise HarnessError(f"unsupported discovery status: {to_status}")
    path = path.resolve()
    path.parent.mkdir(parents=True, exist_ok=True)
    with durable.file_lock(path):
        records = _recover_unlocked(path)
        state = _replay_discoveries(records)
        if discovery_id not in state:
            raise HarnessError(f"unknown discovery: {discovery_id}")
        current = str(state[discovery_id].get("status", "raw"))
        if to_status not in ALLOWED_DISCOVERY_TRANSITIONS.get(current, frozenset()):
            raise HarnessError(f"illegal discovery transition: {current} -> {to_status}")
        _append_unlocked(
            path,
            {
                "schema_version": ADVANCE_SCHEMA_VERSION,
                "event": "discovery_transition",
                "discovery_id": discovery_id,
                "from_status": current,
                "to_status": to_status,
                "actor": actor,
                "note": note,
                "created_at": durable.utc_stamp(),
            },
        )


def coordinator_capsule(
    advance_path: Path = DEFAULT_ADVANCE_LEDGER,
    discovery_path: Path = DEFAULT_DISCOVERY_LEDGER,
    *,
    max_advances: int = 8,
    max_discoveries: int = 12,
) -> dict[str, Any]:
    """Return a bounded state capsule; never include raw worker transcripts."""

    advances = list(current_advances(advance_path).values())
    advances.sort(
        key=lambda item: (
            item.get("state") == "STABILIZING",
            item.get("state") in ACTIVE_ADVANCE_STATES,
            int(item.get("priority", 0)),
            str(item.get("updated_at") or item.get("created_at") or ""),
        ),
        reverse=True,
    )
    discoveries = list(current_discoveries(discovery_path).values())
    discovery_rank = {"validated": 4, "scheduled": 3, "raw": 2, "merged": 1, "rejected": 0}
    discoveries.sort(
        key=lambda item: (
            discovery_rank.get(str(item.get("status")), -1),
            str(item.get("updated_at") or item.get("created_at") or ""),
        ),
        reverse=True,
    )
    selected_advances = advances[: max(0, max_advances)]
    selected_discoveries = discoveries[: max(0, max_discoveries)]
    capsule: dict[str, Any] = {
        "schema_version": ADVANCE_SCHEMA_VERSION,
        "generated_at": durable.utc_stamp(),
        "control_model": "substantive-advance-vnext",
        "advances": selected_advances,
        "discoveries": selected_discoveries,
        "omitted_advance_count": max(0, len(advances) - len(selected_advances)),
        "omitted_discovery_count": max(0, len(discoveries) - len(selected_discoveries)),
        "single_stabilization_lane": [
            item.get("advance_id")
            for item in advances
            if item.get("state") == "STABILIZING"
        ],
    }
    capsule["serialized_characters"] = len(durable.canonical_json(capsule))
    return capsule


def _json_print(value: Any) -> None:
    print(json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True))


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)

    p_state = sub.add_parser("state", help="show current substantive advances")
    p_state.add_argument("--ledger", type=Path, default=DEFAULT_ADVANCE_LEDGER)

    p_capsule = sub.add_parser("capsule", help="emit a bounded coordinator capsule")
    p_capsule.add_argument("--advance-ledger", type=Path, default=DEFAULT_ADVANCE_LEDGER)
    p_capsule.add_argument("--discovery-ledger", type=Path, default=DEFAULT_DISCOVERY_LEDGER)
    p_capsule.add_argument("--max-advances", type=int, default=8)
    p_capsule.add_argument("--max-discoveries", type=int, default=12)

    args = parser.parse_args(argv)
    if args.command == "state":
        _json_print(current_advances(args.ledger))
        return 0
    if args.command == "capsule":
        _json_print(
            coordinator_capsule(
                args.advance_ledger,
                args.discovery_ledger,
                max_advances=args.max_advances,
                max_discoveries=args.max_discoveries,
            )
        )
        return 0
    raise AssertionError(args.command)


if __name__ == "__main__":
    raise SystemExit(main())
