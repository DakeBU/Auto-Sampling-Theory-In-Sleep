#!/usr/bin/env python3
"""Validate and summarize collaborative ASTIS Frontier Cell records.

A Frontier Cell is the GitHub-visible unit of mathematical progress used by the
SampleWiki, Riemannian Optimization, Optimisation, and shared-foundation lanes.
The validator is intentionally stdlib-only so it can run in every ASTIS CI job.
"""

from __future__ import annotations

import argparse
import json
import sys
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_CELL_ROOT = ROOT / "research-wiki" / "frontier-cells"

ROUTES = {"samplewiki-route", "riemannian-optimization", "optimisation", "statistical-optimal-transport", "higher-order-sampling", "discrete-sampling", "shared"}
MODES = {"faithfulPaper", "exploratoryProof"}
STATUSES = {
    "claimed",
    "proved_locally",
    "independently_verified",
    "stabilized",
    "merged",
    "blocked",
    "quarantined",
}
CLASSIFICATIONS = {"reuse", "adapt", "missing", "out_of_scope"}
DECISIONS = {
    "reuse_existing",
    "adapt_existing",
    "new_route_local",
    "new_canonical_shared",
    "out_of_scope",
}


def cell_paths(root: Path = DEFAULT_CELL_ROOT) -> list[Path]:
    if not root.exists():
        return []
    return sorted(
        path
        for path in root.rglob("*.json")
        if not path.name.startswith("_") and path.name != "schema.json"
    )


def load_cells(root: Path = DEFAULT_CELL_ROOT) -> list[dict[str, Any]]:
    cells: list[dict[str, Any]] = []
    for path in cell_paths(root):
        try:
            raw = json.loads(path.read_text(encoding="utf-8"))
        except (OSError, json.JSONDecodeError) as exc:
            cells.append({"__path__": str(path), "__load_error__": str(exc)})
            continue
        if not isinstance(raw, dict):
            cells.append({"__path__": str(path), "__load_error__": "top level must be an object"})
            continue
        raw["__path__"] = path.relative_to(ROOT).as_posix() if path.is_relative_to(ROOT) else str(path)
        cells.append(raw)
    return cells


def _nonempty(value: Any) -> bool:
    return isinstance(value, str) and bool(value.strip())


def _list(value: Any) -> list[Any]:
    return value if isinstance(value, list) else []


def validate_cells(cells: list[dict[str, Any]]) -> list[str]:
    errors: list[str] = []
    seen: dict[str, str] = {}
    common = (
        "schema_version",
        "cell_id",
        "route",
        "title",
        "mode",
        "source_anchor",
        "target_statement",
        "status",
        "parents",
        "consumers",
        "shared_floor_audit",
        "evidence",
        "blocked",
    )

    for cell in cells:
        path = str(cell.get("__path__", "<unknown>"))
        if "__load_error__" in cell:
            errors.append(f"{path}: unreadable cell: {cell['__load_error__']}")
            continue
        missing = [key for key in common if key not in cell]
        if missing:
            errors.append(f"{path}: missing required fields {missing}")
            continue

        cell_id = str(cell.get("cell_id", "")).strip()
        if not cell_id:
            errors.append(f"{path}: empty cell_id")
        elif cell_id in seen:
            errors.append(f"{path}: duplicate cell_id {cell_id!r}; first seen in {seen[cell_id]}")
        else:
            seen[cell_id] = path

        route = str(cell.get("route", ""))
        status = str(cell.get("status", ""))
        mode = str(cell.get("mode", ""))
        if route not in ROUTES:
            errors.append(f"{path}: invalid route {route!r}")
        if status not in STATUSES:
            errors.append(f"{path}: invalid status {status!r}")
        if mode not in MODES:
            errors.append(f"{path}: invalid mode {mode!r}")
        if not _nonempty(cell.get("title")):
            errors.append(f"{path}: title must be non-empty")
        if not _nonempty(cell.get("source_anchor")):
            errors.append(f"{path}: source_anchor must pin an exact source location")
        if not _nonempty(cell.get("target_statement")):
            errors.append(f"{path}: target_statement must be non-empty")
        if not isinstance(cell.get("parents"), list) or not isinstance(cell.get("consumers"), list):
            errors.append(f"{path}: parents and consumers must be lists")

        audit = cell.get("shared_floor_audit")
        if not isinstance(audit, dict):
            errors.append(f"{path}: shared_floor_audit must be an object")
            audit = {}
        searched = audit.get("searched")
        classification = str(audit.get("classification", ""))
        decision = str(audit.get("decision", ""))
        canonical = str(audit.get("canonical_declaration", "")).strip()
        canonical_shared_cell = str(audit.get("canonical_shared_cell", "")).strip()
        if not isinstance(searched, list) or not searched:
            errors.append(f"{path}: shared_floor_audit.searched must record at least one reuse search")
        if classification not in CLASSIFICATIONS:
            errors.append(f"{path}: invalid shared-floor classification {classification!r}")
        if decision not in DECISIONS:
            errors.append(f"{path}: invalid shared-floor decision {decision!r}")
        if decision in {"reuse_existing", "adapt_existing"} and not canonical:
            errors.append(f"{path}: {decision} requires canonical_declaration")
        if decision == "new_canonical_shared":
            if route == "shared":
                if len(_list(cell.get("consumers"))) < 2:
                    errors.append(f"{path}: a shared Frontier Cell must name at least two consuming routes")
            elif not canonical_shared_cell:
                errors.append(
                    f"{path}: route-local detection of a missing shared foundation must name canonical_shared_cell"
                )
            if route != "shared" and status not in {"claimed", "blocked", "quarantined"}:
                errors.append(
                    f"{path}: route-local cell may not implement a new shared foundation; open/use the shared cell first"
                )

        if route in {"statistical-optimal-transport", "higher-order-sampling", "discrete-sampling"} and cell.get("schema_version") != 2:
            errors.append(f"{path}: new cross-domain routes require schema_version 2")
        if cell.get("schema_version") not in {1, 2}:
            errors.append(f"{path}: unsupported schema_version")
        if cell.get("schema_version") == 2:
            searches = " ".join(map(str, searched or [])).lower()
            for library in ("samplinglib", "mathlib"):
                if library not in searches:
                    errors.append(f"{path}: schema-2 cells must search {library}")
            detail = cell.get("source_detail_audit")
            if not isinstance(detail, dict):
                errors.append(f"{path}: schema-2 cells require source_detail_audit")
                detail = {}
            for key in ("primary_edition", "primary_anchor", "fidelity_boundary"):
                if not _nonempty(detail.get(key)):
                    errors.append(f"{path}: source_detail_audit.{key} must be explicit")
            detail_status = detail.get("detail_status")
            if detail_status not in {"sufficient", "omitted", "cites_external"}:
                errors.append(f"{path}: invalid source detail status")
            if detail_status in {"omitted", "cites_external"}:
                if not _nonempty(detail.get("gap")):
                    errors.append(f"{path}: omitted source detail requires an exact gap")
                consulted = detail.get("consulted")
                if not isinstance(consulted, list) or not consulted:
                    errors.append(f"{path}: omitted source detail requires a consulted background theorem")
                else:
                    for reference in consulted:
                        if not isinstance(reference, dict) or any(not _nonempty(reference.get(k)) for k in ("source", "anchor", "hypothesis_adapter")):
                            errors.append(f"{path}: background reference needs source, anchor, hypothesis_adapter")
            if route == "higher-order-sampling":
                comparison = cell.get("comparison_contract", {})
                if not isinstance(comparison, dict):
                    comparison = {}
                for key in ("potential_class", "smoothness_p", "oracle_q", "dynamics_k", "accuracy_r", "metric", "start", "cost"):
                    if not _nonempty(comparison.get(key)):
                        errors.append(f"{path}: higher-order sampling needs comparison_contract.{key}")

        if route == "discrete-sampling" or "discrete-sampling" in _list(cell.get("consumers")):
            contract = cell.get("discrete_state_contract")
            if not isinstance(contract, dict):
                errors.append(f"{path}: discrete consumers require discrete_state_contract")
                contract = {}
            for key in ("state_space", "support", "target", "operator", "time_model", "clock", "reversibility", "pinning", "regime", "metric", "cost", "source_proof_status"):
                if not _nonempty(contract.get(key)):
                    errors.append(f"{path}: discrete_state_contract.{key} must be explicit")
            if contract.get("time_model") not in {"discrete-time", "continuous-time", "static"}:
                errors.append(f"{path}: discrete time_model must be discrete-time, continuous-time or static")
            if contract.get("time_model") == "discrete-time" and not _nonempty(contract.get("aperiodicity_or_absolute_gap")):
                errors.append(f"{path}: discrete-time claims require aperiodicity_or_absolute_gap (or explicit not-applicable reason)")
            # Static/shared algebra may say why a field is not applicable, but
            # cannot silently omit the finite-state consumer's contract.

        evidence = cell.get("evidence")
        if not isinstance(evidence, dict):
            errors.append(f"{path}: evidence must be an object")
            evidence = {}
        checks = evidence.get("focused_checks")
        if status in {"proved_locally", "independently_verified", "stabilized", "merged"}:
            if not isinstance(checks, list) or not checks:
                errors.append(f"{path}: status {status} requires focused_checks evidence")
        if status in {"independently_verified", "stabilized", "merged"}:
            if not _nonempty(evidence.get("independent_verification")):
                errors.append(f"{path}: status {status} requires independent_verification")
        if status in {"stabilized", "merged"}:
            if not _nonempty(evidence.get("root_build")):
                errors.append(f"{path}: status {status} requires root_build evidence")
            if not _nonempty(evidence.get("graph_regeneration")):
                errors.append(f"{path}: status {status} requires graph_regeneration evidence")
        if status == "merged" and not _nonempty(evidence.get("pr")):
            errors.append(f"{path}: merged cell requires a PR/merge reference")

        blocked = cell.get("blocked")
        if not isinstance(blocked, dict):
            errors.append(f"{path}: blocked must be an object")
            blocked = {}
        if status == "blocked":
            if not _nonempty(blocked.get("reason")):
                errors.append(f"{path}: blocked cell requires an exact blocker reason")
            if not isinstance(blocked.get("children"), list) or not blocked.get("children"):
                errors.append(f"{path}: blocked cell must name at least one smaller child Frontier Cell")
        if status == "quarantined" and not _nonempty(blocked.get("reason")):
            errors.append(f"{path}: quarantined cell requires a reason")

    return errors


def summarize(cells: list[dict[str, Any]]) -> dict[str, dict[str, int]]:
    by_route: dict[str, Counter[str]] = defaultdict(Counter)
    for cell in cells:
        if "__load_error__" in cell:
            continue
        route = str(cell.get("route", ""))
        status = str(cell.get("status", ""))
        if route in ROUTES and status in STATUSES:
            by_route[route][status] += 1
    return {route: dict(counter) for route, counter in sorted(by_route.items())}


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("command", choices=("check", "summary"))
    parser.add_argument("--root", default=str(DEFAULT_CELL_ROOT))
    args = parser.parse_args(argv)
    root = Path(args.root).resolve()
    cells = load_cells(root)
    errors = validate_cells(cells)
    if errors:
        print("ASTIS Frontier Cell protocol check failed:", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1
    if args.command == "summary":
        print(json.dumps(summarize(cells), indent=2, sort_keys=True))
    else:
        print(f"ASTIS Frontier Cell protocol check passed: {len(cells)} registered cells")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
