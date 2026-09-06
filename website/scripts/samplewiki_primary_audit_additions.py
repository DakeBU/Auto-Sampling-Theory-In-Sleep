#!/usr/bin/env python3
"""Overlay incremental primary-source audits onto the final SampleWiki reader."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any

import samplewiki_reader_contract as reader


ROOT = Path(__file__).resolve().parents[2]
ADDITIONS_PATH = ROOT / "website" / "content" / "samplewiki_primary_audit_additions.json"


def _load_additions() -> dict[str, dict[str, Any]]:
    raw = json.loads(ADDITIONS_PATH.read_text(encoding="utf-8"))
    audits = raw.get("case_audits", {})
    if not isinstance(audits, dict):
        raise RuntimeError("samplewiki_primary_audit_additions.case_audits must be an object")
    return {
        str(case_id): dict(audit)
        for case_id, audit in audits.items()
        if isinstance(audit, dict)
    }


def patch(module: Any = reader) -> None:
    base_audit_for = module.audit_for
    additions = _load_additions()

    def audit_for(case: dict[str, Any], audits: dict[str, Any]) -> dict[str, Any] | None:
        case_id = str(case.get("id", ""))
        if case_id in additions:
            return dict(additions[case_id])
        return base_audit_for(case, audits)

    module.audit_for = audit_for


if __name__ == "__main__":
    patch()
    reader.enrich_site()
