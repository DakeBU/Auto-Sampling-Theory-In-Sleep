"""Add SampleWiki settings, audited theorems, and dependency-order phases."""

from __future__ import annotations

from typing import Any

from underlying_lean_graph_model import GraphBuilder, case_url, chewi_chapters, roots_for, status


def add_frontier(builder: GraphBuilder, manifest: dict[str, Any], audit_registry: dict[str, Any], chapter_ids: dict[int, str]) -> dict[str, str]:
    add, edge = builder.add, builder.edge
    audits = audit_registry.get("case_audits", {})
    setting_ids: dict[str, str] = {}
    for page in manifest.get("pages", []):
        setting_slug = str(page.get("setting_slug", ""))
        setting_ids[setting_slug] = add(
            f"setting:{setting_slug}", "setting", page.get("setting_title", setting_slug), status="partial",
            subtitle=f"{page.get('row_count', 0)} frontier rows", summary="SampleWiki comparison setting.",
            url=f"example-cases/samplewiki/settings/{setting_slug}.html", source_url=page.get("source_page", ""),
        )
        edge("library:samplewiki", setting_ids[setting_slug], "setting")

    phase_ids: dict[str, str] = {}
    for phase in audit_registry.get("formalization_phases", []):
        phase_key = str(phase.get("id", ""))
        phase_ids[phase_key] = add(
            f"phase:{phase_key}", "phase", f"Phase {phase_key}. {phase.get('title', '')}", status=status(phase.get("status")),
            subtitle=phase.get("status", ""), summary=" · ".join(phase.get("items", [])), url="example-cases/samplewiki/progress.html",
        )
        edge("library:samplewiki", phase_ids[phase_key], "formalization order")

    for case in manifest.get("cases", []):
        case_id = str(case.get("id", ""))
        audit = audits.get(case_id, {}) if isinstance(audits, dict) else {}
        audit_state = "audited" if audit else ("literature-open" if str(case.get("result_class", "")).lower() == "lower unknown" else "pending")
        theorem = audit.get("theorem_label", "Exact theorem audit pending") if isinstance(audit, dict) else "Exact theorem audit pending"
        proof_equations = audit.get("proof_equations", []) if isinstance(audit, dict) else []
        proof_rows = [{"formula": row.get("latex", ""), "meaning": row.get("meaning", "")} for row in proof_equations if isinstance(row, dict)]
        references = case.get("source_refs", [])
        first_source = references[0].get("url", "") if references and isinstance(references[0], dict) else ""
        node_id = add(
            f"case:{case_id}", "frontier-case", case.get("algorithm_or_model", case_id), status=status(audit_state, case=True),
            subtitle=f"{case.get('setting_title', '')} · {case.get('result_class', '')}", summary=case.get("guarantee", ""),
            formula=audit.get("statement_latex", case.get("complexity", "")) if isinstance(audit, dict) else case.get("complexity", ""),
            theorem=theorem, source_proof=audit.get("source_proof_status", "not yet audited") if isinstance(audit, dict) else "not yet audited",
            proof_equations=proof_rows, url=case_url(case_id), source_url=audit.get("source_url", first_source) if isinstance(audit, dict) else first_source,
            details=[
                {"label": "Primary theorem", "value": theorem},
                {"label": "Review state", "value": case.get("review_state", "")},
                {"label": "Prerequisites", "value": " · ".join(audit.get("prerequisites", [])) if isinstance(audit, dict) else "exact theorem audit pending"},
                {"label": "Next Lean target", "value": audit.get("lean_target", "source theorem audit first") if isinstance(audit, dict) else "source theorem audit first"},
                {"label": "Lean declarations", "value": " · ".join(case.get("lean_declarations", [])) or "none yet"},
            ],
        )
        setting_id = setting_ids.get(str(case.get("setting_slug", "")))
        if setting_id:
            edge(setting_id, node_id, "frontier result")
        phase = str(audit.get("phase", "")) if isinstance(audit, dict) else ""
        if phase in phase_ids:
            edge(phase_ids[phase], node_id, "scheduled assembly")
        text = " ".join([str(case.get("algorithm_or_model", "")), str(case.get("setting_title", "")), str(case.get("guarantee", "")), theorem, str(audit.get("lean_target", "")) if isinstance(audit, dict) else ""])
        for key in roots_for(text) or ["oracle"]:
            edge(f"root:{key}", node_id, "shared prerequisite")
        inferred = chewi_chapters(*(audit.get("prerequisites", []) if isinstance(audit, dict) else []), theorem, *(ref.get("label", "") for ref in references if isinstance(ref, dict)))
        for number in inferred:
            if number in chapter_ids:
                edge(chapter_ids[number], node_id, "textbook prerequisite")
    return setting_ids
