#!/usr/bin/env python3
"""Substantive-advance coordination for ASTIS Harness vNext.

The legacy ASTIS harness remains available as durable typed memory.  This
module makes a mathematically substantive theorem-DAG delta the active unit of
work.  A generalist worker owns that delta end to end; specialties are temporary
modes rather than role boundaries.

Harness vNext.1 additionally keeps the global coordinator thin:

* advances are partitioned into explicit frontier cells;
* any generalist worker may publish a cell-level synthesis discovery;
* the coordinator capsule is synthesis-first and never embeds raw transcripts;
* unchanged route/progress checkpoints trigger a deterministic no-progress
  diagnosis instead of indefinite retries;
* exploration stays parallel while shared repository stabilization is single
  owner.

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
except ImportError:  # direct ``python3 tools/astis_advance.py ...``
    import astis_harness as durable  # type: ignore


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_ADVANCE_LEDGER = ROOT / "runs" / "substantive_advances.jsonl"
DEFAULT_DISCOVERY_LEDGER = ROOT / "runs" / "substantive_discoveries.jsonl"
ADVANCE_SCHEMA_VERSION = 2


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
WORKER_LANE_STATES = frozenset({"CLAIMED", "EXPLORING", "PROVED_LOCAL"})
WORKER_LANE_TARGETS = frozenset({"EXPLORING", "PROVED_LOCAL", "BLOCKED"})
SUBSTANTIVE_RESULT_KINDS = frozenset(
    {"theorem-edge", "reusable-interface", "integration-node"}
)

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
    {
        "lemma",
        "interface",
        "counterexample",
        "source-gap",
        "refactor",
        "conjecture",
        "process",
        "synthesis",
    }
)
DISCOVERY_STATUSES = frozenset({"raw", "validated", "scheduled", "merged", "rejected"})
ALLOWED_DISCOVERY_TRANSITIONS: dict[str, frozenset[str]] = {
    "raw": frozenset({"validated", "rejected"}),
    "validated": frozenset({"scheduled", "merged", "rejected"}),
    "scheduled": frozenset({"merged", "rejected"}),
    "merged": frozenset(),
    "rejected": frozenset(),
}
DUPLICATE_DISCOVERY_STATUSES = frozenset({"raw", "validated", "scheduled", "merged"})

NO_PROGRESS_FREEZE_AT = 3


def _require_text(name: str, value: str) -> None:
    if not isinstance(value, str) or not value.strip():
        raise HarnessError(f"{name} must be nonempty text")


def _as_list(values: Sequence[str] | None) -> list[str]:
    return list(values or ())


def _meaningful(value: Any) -> bool:
    if isinstance(value, str):
        return bool(value.strip())
    if isinstance(value, (list, tuple, set, dict)):
        return bool(value)
    return value is not None and value is not False


def _semantic_text(value: str) -> str:
    """Normalize harmless presentation differences without pretending semantic equivalence."""

    return " ".join(value.split()).casefold()


def _semantic_list(values: Sequence[str]) -> list[str]:
    return sorted(_semantic_text(value) for value in values if value.strip())


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
    frontier_cell: str = "global"
    target_declarations: tuple[str, ...] = ()
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
            "frontier_cell",
        ):
            _require_text(name, getattr(self, name))
        if not isinstance(self.priority, int) or not 0 <= self.priority <= 100:
            raise HarnessError("priority must be an integer in [0, 100]")
        if not self.dag_inputs:
            raise HarnessError("a substantive advance must name at least one DAG input")
        if not self.focused_checks:
            raise HarnessError("a substantive advance must name at least one focused check")

    def semantic_fingerprint(self) -> str:
        """Fingerprint the mathematical target, intentionally excluding ids and owners."""

        payload = {
            "task_id": _semantic_text(self.task_id),
            "source_anchor": _semantic_text(self.source_anchor),
            "goal": _semantic_text(self.goal),
            "theorem_delta": _semantic_text(self.theorem_delta),
            "truth_boundary": _semantic_text(self.truth_boundary),
            "dag_inputs": _semantic_list(self.dag_inputs),
            "target_declarations": _semantic_list(self.target_declarations),
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
        for key in (
            "dag_inputs",
            "proposed_files",
            "focused_checks",
            "modes",
            "target_declarations",
        ):
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
    frontier_cell: str = "global"
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
            "frontier_cell",
        ):
            _require_text(name, getattr(self, name))
        if self.kind not in DISCOVERY_KINDS:
            raise HarnessError(f"unsupported discovery kind: {self.kind}")

    def semantic_fingerprint(self) -> str:
        return durable.digest(
            {
                "kind": self.kind,
                "statement": _semantic_text(self.statement),
                "where_it_matters": _semantic_text(self.where_it_matters),
                "frontier_cell": _semantic_text(self.frontier_cell),
            }
        )

    def as_event(self) -> dict[str, Any]:
        self.validate()
        return {
            **dataclasses.asdict(self),
            "schema_version": ADVANCE_SCHEMA_VERSION,
            "event": "discovery",
            "status": "raw",
            "fingerprint": self.semantic_fingerprint(),
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
            item = dict(record)
            item.setdefault("frontier_cell", "global")
            item.setdefault("target_declarations", [])
            item.setdefault("checkpoint_count", 0)
            item.setdefault("no_progress_streak", 0)
            item.setdefault("needs_diagnosis", False)
            state[advance_id] = item
            continue
        if advance_id not in state:
            continue
        current = state[advance_id]
        if event == "transition":
            to_state = record.get("to_state", current.get("state"))
            current["state"] = to_state
            current["last_actor"] = record.get("worker_id", current.get("last_actor", ""))
            if to_state == "CLAIMED":
                current["owner_id"] = record.get("worker_id", "")
                current["no_progress_streak"] = 0
                current["needs_diagnosis"] = False
            current["modes"] = list(record.get("modes") or current.get("modes") or [])
            if record.get("evidence"):
                current["latest_evidence"] = record["evidence"]
            current["updated_at"] = record.get("created_at", current.get("updated_at"))
        elif event == "checkpoint":
            previous = current.get("latest_checkpoint") or {}
            same_signature = (
                previous.get("route_fingerprint") == record.get("route_fingerprint")
                and previous.get("progress_signature") == record.get("progress_signature")
            )
            streak = int(current.get("no_progress_streak", 0)) + 1 if same_signature else 1
            current["checkpoint_count"] = int(current.get("checkpoint_count", 0)) + 1
            current["no_progress_streak"] = streak
            current["needs_diagnosis"] = streak >= NO_PROGRESS_FREEZE_AT
            current["latest_checkpoint"] = dict(record)
            current["updated_at"] = record.get("created_at", current.get("updated_at"))
    return state


def current_advances(path: Path = DEFAULT_ADVANCE_LEDGER) -> dict[str, dict[str, Any]]:
    """Recover an interrupted tail and replay current substantive-advance state."""

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


def _validate_transition_evidence(
    to_state: str, evidence: dict[str, Any], *, schema_version: int
) -> None:
    if to_state == "PROVED_LOCAL":
        required = ("theorem_delta", "lean_files", "focused_checks", "truth_boundary")
        if schema_version >= 2:
            required += ("result_kind", "lean_declarations")
        missing = [key for key in required if not _meaningful(evidence.get(key))]
        if missing:
            raise HarnessError("PROVED_LOCAL lacks evidence: " + ", ".join(missing))
        if schema_version >= 2 and evidence.get("result_kind") not in SUBSTANTIVE_RESULT_KINDS:
            raise HarnessError(
                "PROVED_LOCAL result_kind must be one of: "
                + ", ".join(sorted(SUBSTANTIVE_RESULT_KINDS))
            )
    elif to_state == "VERIFIED":
        required = ("gate",)
        if schema_version >= 2:
            required += (
                "verifier_id",
                "verified_commit",
                "source_audit",
                "fake_closure_scan",
            )
        missing = [key for key in required if not _meaningful(evidence.get(key))]
        if missing:
            raise HarnessError("VERIFIED lacks evidence: " + ", ".join(missing))
    elif to_state == "STABILIZING":
        required = ("canonical_branch", "integration_owner")
        missing = [key for key in required if not _meaningful(evidence.get(key))]
        if missing:
            raise HarnessError("STABILIZING lacks evidence: " + ", ".join(missing))
    elif to_state == "MERGED":
        if evidence.get("pr") in (None, "") or not str(evidence.get("commit", "")).strip():
            raise HarnessError("MERGED lacks evidence: pr, commit")
    elif to_state == "BLOCKED":
        if schema_version < 2:
            if not evidence or not any(_meaningful(value) for value in evidence.values()):
                raise HarnessError("BLOCKED requires an exact blocker or reason")
            return
        required = ("blocker_class", "blocker", "strict_reduction")
        missing = [key for key in required if not _meaningful(evidence.get(key))]
        alternatives = (
            "next_smaller_delta",
            "retired_route",
            "counterexample",
            "minimal_reproducer",
        )
        if not any(_meaningful(evidence.get(key)) for key in alternatives):
            missing.append("one of next_smaller_delta/retired_route/counterexample/minimal_reproducer")
        if missing:
            raise HarnessError("BLOCKED lacks substantive evidence: " + ", ".join(missing))
    elif to_state == "QUARANTINED":
        if not evidence or not any(_meaningful(value) for value in evidence.values()):
            raise HarnessError("QUARANTINED requires an exact reason")


def _assert_worker_lane_owner(
    item: dict[str, Any], *, current: str, to_state: str, worker_id: str
) -> None:
    owner_id = str(item.get("owner_id", ""))
    if (
        owner_id
        and current in WORKER_LANE_STATES
        and to_state in WORKER_LANE_TARGETS
        and worker_id != owner_id
    ):
        raise HarnessError(
            f"advance {item.get('advance_id')} is owned by {owner_id}; "
            f"{worker_id} cannot mutate the worker lane"
        )


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
        item = state[advance_id]
        current = str(item.get("state", ""))
        if to_state not in ALLOWED_ADVANCE_TRANSITIONS.get(current, frozenset()):
            raise HarnessError(f"illegal substantive-advance transition: {current} -> {to_state}")
        schema_version = int(item.get("schema_version", 1))
        _validate_transition_evidence(to_state, evidence, schema_version=schema_version)
        _assert_worker_lane_owner(item, current=current, to_state=to_state, worker_id=worker_id)

        if schema_version >= 2 and current == "BLOCKED" and to_state == "EXPLORING":
            raise HarnessError(
                "a BLOCKED v2 advance must be re-CLAIMED before EXPLORING"
            )

        if schema_version >= 2 and current == "VERIFIED" and to_state == "EXPLORING":
            owner_id = str(item.get("owner_id", ""))
            if owner_id and worker_id != owner_id:
                raise HarnessError(
                    "a VERIFIED advance may return to EXPLORING only through its owning Worker"
                )

        if to_state == "VERIFIED" and schema_version >= 2:
            verifier_id = str(evidence.get("verifier_id", ""))
            if verifier_id != worker_id:
                raise HarnessError("VERIFIED worker_id must equal evidence.verifier_id")
            owner_id = str(item.get("owner_id", ""))
            if owner_id and verifier_id == owner_id:
                raise HarnessError("VERIFIED must be published by an independent verifier")

        if schema_version >= 2 and current == "STABILIZING" and to_state == "MERGED":
            integration_owner = str(
                item.get("latest_evidence", {}).get("integration_owner", "")
            )
            if integration_owner and worker_id != integration_owner:
                raise HarnessError(
                    "MERGED must be published by the current stabilization owner"
                )

        if to_state == "STABILIZING":
            stabilizing = [
                other
                for other_id, other in state.items()
                if other_id != advance_id and other.get("state") == "STABILIZING"
            ]
            if stabilizing:
                owner = stabilizing[0].get("latest_evidence", {}).get(
                    "integration_owner", "unknown"
                )
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


def checkpoint_advance(
    advance_id: str,
    *,
    worker_id: str,
    route_fingerprint: str,
    progress_signature: str,
    mathematical_delta: str,
    exact_residual: str,
    context_characters: int = 0,
    path: Path = DEFAULT_ADVANCE_LEDGER,
) -> dict[str, Any]:
    """Record bounded worker progress and freeze a repeatedly unchanged route.

    The third identical ``(route_fingerprint, progress_signature)`` occurrence
    is recorded and flagged for diagnosis.  A fourth identical checkpoint is
    rejected until the worker changes route or produces a new progress
    signature.
    """

    for name, value in (
        ("advance_id", advance_id),
        ("worker_id", worker_id),
        ("route_fingerprint", route_fingerprint),
        ("progress_signature", progress_signature),
        ("mathematical_delta", mathematical_delta),
        ("exact_residual", exact_residual),
    ):
        _require_text(name, value)
    if not isinstance(context_characters, int) or context_characters < 0:
        raise HarnessError("context_characters must be a nonnegative integer")

    path = path.resolve()
    path.parent.mkdir(parents=True, exist_ok=True)
    with durable.file_lock(path):
        records = _recover_unlocked(path)
        state = _replay_advances(records)
        if advance_id not in state:
            raise HarnessError(f"unknown substantive advance: {advance_id}")
        item = state[advance_id]
        if item.get("state") not in {"CLAIMED", "EXPLORING"}:
            raise HarnessError("checkpoints are allowed only in CLAIMED or EXPLORING")
        owner_id = str(item.get("owner_id", ""))
        if owner_id and owner_id != worker_id:
            raise HarnessError(f"advance {advance_id} is owned by {owner_id}")
        previous = item.get("latest_checkpoint") or {}
        unchanged = (
            previous.get("route_fingerprint") == route_fingerprint
            and previous.get("progress_signature") == progress_signature
        )
        if unchanged and bool(item.get("needs_diagnosis")):
            raise HarnessError(
                "route frozen after two unchanged repeats; publish a diagnosis, "
                "strict blocker, or changed route fingerprint"
            )
        streak = int(item.get("no_progress_streak", 0)) + 1 if unchanged else 1
        record = {
            "schema_version": ADVANCE_SCHEMA_VERSION,
            "event": "checkpoint",
            "advance_id": advance_id,
            "worker_id": worker_id,
            "route_fingerprint": route_fingerprint,
            "progress_signature": progress_signature,
            "mathematical_delta": mathematical_delta,
            "exact_residual": exact_residual,
            "context_characters": context_characters,
            "no_progress_streak": streak,
            "needs_diagnosis": streak >= NO_PROGRESS_FREEZE_AT,
            "created_at": durable.utc_stamp(),
        }
        _append_unlocked(path, record)
        return record


def _replay_discoveries(records: Iterable[dict[str, Any]]) -> dict[str, dict[str, Any]]:
    state: dict[str, dict[str, Any]] = {}
    for record in records:
        discovery_id = record.get("discovery_id")
        if not isinstance(discovery_id, str) or not discovery_id:
            continue
        if record.get("event") == "discovery":
            item = dict(record)
            item.setdefault("frontier_cell", "global")
            state[discovery_id] = item
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
        for item in state.values():
            if (
                item.get("status") in DUPLICATE_DISCOVERY_STATUSES
                and item.get("fingerprint") == event["fingerprint"]
            ):
                raise HarnessError(
                    "duplicate active discovery: "
                    f"{discovery.discovery_id} duplicates {item.get('discovery_id')}"
                )
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


def _frontier_cell_summaries(
    advances: Sequence[dict[str, Any]],
    discoveries: Sequence[dict[str, Any]],
    *,
    max_cells: int,
) -> tuple[list[dict[str, Any]], int]:
    cells: dict[str, dict[str, Any]] = {}

    def cell(name: str) -> dict[str, Any]:
        return cells.setdefault(
            name,
            {
                "frontier_cell": name,
                "active_advances": [],
                "verified_advances": [],
                "blocked_advances": [],
                "needs_diagnosis": [],
                "validated_syntheses": [],
                "top_priority": 0,
            },
        )

    for item in advances:
        name = str(item.get("frontier_cell") or "global")
        summary = cell(name)
        advance_id = str(item.get("advance_id", ""))
        state = str(item.get("state", ""))
        summary["top_priority"] = max(summary["top_priority"], int(item.get("priority", 0)))
        if state in ACTIVE_ADVANCE_STATES:
            summary["active_advances"].append(advance_id)
        if state == "VERIFIED":
            summary["verified_advances"].append(advance_id)
        if state == "BLOCKED":
            summary["blocked_advances"].append(advance_id)
        if item.get("needs_diagnosis"):
            summary["needs_diagnosis"].append(advance_id)

    for item in discoveries:
        if item.get("kind") != "synthesis" or item.get("status") not in {
            "validated",
            "scheduled",
            "merged",
        }:
            continue
        name = str(item.get("frontier_cell") or "global")
        cell(name)["validated_syntheses"].append(str(item.get("discovery_id", "")))

    summaries = list(cells.values())
    for summary in summaries:
        summary["requires_local_synthesis"] = bool(summary["needs_diagnosis"]) or (
            len(summary["active_advances"]) > 1 and not summary["validated_syntheses"]
        )
        for key in (
            "active_advances",
            "verified_advances",
            "blocked_advances",
            "needs_diagnosis",
            "validated_syntheses",
        ):
            summary[key] = summary[key][:8]
    summaries.sort(
        key=lambda item: (
            bool(item["requires_local_synthesis"]),
            bool(item["verified_advances"]),
            int(item["top_priority"]),
            item["frontier_cell"],
        ),
        reverse=True,
    )
    selected = summaries[: max(0, max_cells)]
    return selected, max(0, len(summaries) - len(selected))


def coordinator_capsule(
    advance_path: Path = DEFAULT_ADVANCE_LEDGER,
    discovery_path: Path = DEFAULT_DISCOVERY_LEDGER,
    *,
    max_advances: int = 8,
    max_discoveries: int = 12,
    max_cells: int = 8,
) -> dict[str, Any]:
    """Return bounded synthesis-first state; never include raw worker transcripts."""

    advances = list(current_advances(advance_path).values())
    advances.sort(
        key=lambda item: (
            item.get("state") == "STABILIZING",
            item.get("state") in ACTIVE_ADVANCE_STATES,
            bool(item.get("needs_diagnosis")),
            int(item.get("priority", 0)),
            str(item.get("updated_at") or item.get("created_at") or ""),
        ),
        reverse=True,
    )
    discoveries = list(current_discoveries(discovery_path).values())
    discovery_rank = {"validated": 4, "scheduled": 3, "raw": 2, "merged": 1, "rejected": 0}
    discoveries.sort(
        key=lambda item: (
            item.get("kind") == "synthesis",
            discovery_rank.get(str(item.get("status")), -1),
            str(item.get("updated_at") or item.get("created_at") or ""),
        ),
        reverse=True,
    )
    selected_advances = advances[: max(0, max_advances)]
    selected_discoveries = discoveries[: max(0, max_discoveries)]
    frontier_cells, omitted_cell_count = _frontier_cell_summaries(
        advances, discoveries, max_cells=max_cells
    )
    capsule: dict[str, Any] = {
        "schema_version": ADVANCE_SCHEMA_VERSION,
        "generated_at": durable.utc_stamp(),
        "control_model": "substantive-advance-frontier-mesh-vnext.1",
        "coordinator_policy": "cell-synthesis-first; raw transcripts forbidden",
        "frontier_cells": frontier_cells,
        "advances": selected_advances,
        "discoveries": selected_discoveries,
        "omitted_cell_count": omitted_cell_count,
        "omitted_advance_count": max(0, len(advances) - len(selected_advances)),
        "omitted_discovery_count": max(0, len(discoveries) - len(selected_discoveries)),
        "single_stabilization_lane": [
            item.get("advance_id") for item in advances if item.get("state") == "STABILIZING"
        ],
        "no_progress_advances": [
            item.get("advance_id") for item in advances if item.get("needs_diagnosis")
        ][:8],
        "raw_worker_transcripts_included": False,
    }
    capsule["arbiter_queue"] = [
        item["frontier_cell"]
        for item in frontier_cells
        if item["requires_local_synthesis"] or item["verified_advances"]
    ][:8]
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
    p_capsule.add_argument("--max-cells", type=int, default=8)

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
                max_cells=args.max_cells,
            )
        )
        return 0
    raise AssertionError(args.command)


if __name__ == "__main__":
    raise SystemExit(main())
