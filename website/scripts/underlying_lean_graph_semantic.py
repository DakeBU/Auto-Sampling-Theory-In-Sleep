"""Add the ASTIS semantic round-trip and theorem-denoising branch."""

from __future__ import annotations

from typing import Any

from underlying_lean_graph_model import GraphBuilder


STAGES = [
    (
        "source-contract",
        "Pinned original theorem contract",
        "source text · anchor · hash",
        "The source theorem is immutable evidence. Normalization may expose notation, but may not silently change assumptions, quantifiers, domains, or conclusions.",
        1,
    ),
    (
        "lean-bottleneck",
        "Compiled Lean semantic bottleneck",
        "exact proposition · definitions · toolchain",
        "Lean checks the proposition that was actually written. This establishes Lean truth, not yet fidelity to the source theorem.",
        2,
    ),
    (
        "blind-reconstruction",
        "Blind theorem reconstruction",
        "Lean → text · source hidden",
        "An independent decoder receives the compiled Lean statement and approved definition context, but no source theorem, theorem number, prior semantic audit, or repair proposal.",
        3,
    ),
    (
        "semantic-diff",
        "Seven-slot semantic diff",
        "objects · domains · quantifiers · assumptions · conclusion · scopes · constants",
        "ASTIS compares semantic contracts slot by slot. Textual similarity is never accepted as theorem equivalence evidence.",
        4,
    ),
    (
        "fidelity-checker",
        "Theorem Fidelity Checker",
        "original text → Lean → blind reconstructed text",
        "Classifies exact equivalence, explicit elaboration, strengthened assumptions, weakened conclusions, domain or quantifier mismatch, source underspecification, and possible source error.",
        5,
    ),
    (
        "theorem-denoiser",
        "Lean Theorem Denoiser",
        "minimal repair proposals · no source mutation",
        "Turns exposed hidden conditions into separately reviewed micro-corrections or assumption proposals. A proof convenience is not automatically a source correction.",
        5,
    ),
    (
        "source-review",
        "Independent source review",
        "reviewer-owned semantic verdict",
        "The formalizer cannot approve its own fidelity verdict. Accepted repairs require independent evidence, minimality, and a reference or counterexample.",
        6,
    ),
]

MISMATCH_VERDICTS = {
    "implicit-assumption-exposed",
    "source-underspecified",
    "lean-strengthened-assumptions",
    "lean-weakened-conclusion",
    "domain-mismatch",
    "quantifier-mismatch",
    "possible-source-error",
}


def audit_status(audit: dict[str, Any]) -> str:
    verdict = str(audit.get("verdict", "pending"))
    review = audit.get("source_review", {}) if isinstance(audit.get("source_review"), dict) else {}
    repairs = audit.get("repairs", []) if isinstance(audit.get("repairs"), list) else []
    if review.get("state") == "accepted" and any(
        isinstance(repair, dict) and repair.get("status") == "accepted" for repair in repairs
    ):
        return "fidelity-repaired"
    if review.get("state") == "accepted" and verdict in {"exact", "equivalent-after-elaboration"}:
        return "fidelity-exact"
    if verdict in MISMATCH_VERDICTS or any(
        isinstance(delta, dict) and delta.get("severity") == "blocking"
        for delta in audit.get("deltas", [])
    ):
        return "fidelity-mismatch"
    return "review-required"


def add_semantic(builder: GraphBuilder, registry: dict[str, Any]) -> dict[str, int]:
    add, edge = builder.add, builder.edge
    protocol = registry.get("protocol", {}) if isinstance(registry.get("protocol"), dict) else {}
    # Keep public graph links deployable from the current commit. Linking a new
    # repository file through blob/main would falsely claim that the file has
    # already landed on main and is rejected by the site source-link gate.
    docs_url = "lean-foundations.html?view=semantic"

    for key, label, subtitle, summary, column in STAGES:
        add(
            f"semantic:{key}",
            "semantic-stage",
            label,
            status="shared",
            subtitle=subtitle,
            summary=summary,
            column=column,
            url=docs_url,
            details=[
                {"label": "Protocol status", "value": protocol.get("status", "active")},
                {"label": "Decoder blindness", "value": protocol.get("decoder_blindness", "required")},
                {"label": "Independent review", "value": protocol.get("independent_source_review", "required")},
                {"label": "Blind decoder inputs", "value": " · ".join(protocol.get("decoder_allowed_inputs", []))},
            ],
        )

    edge("library:samplinglib", "semantic:source-contract", "semantic contract")
    edge("library:samplinglib", "semantic:fidelity-checker", "semantic contribution")
    edge("library:samplinglib", "semantic:theorem-denoiser", "semantic contribution")
    edge("semantic:source-contract", "semantic:lean-bottleneck", "formalizes")
    edge("semantic:lean-bottleneck", "semantic:blind-reconstruction", "blind decode")
    edge("semantic:source-contract", "semantic:semantic-diff", "original semantics")
    edge("semantic:blind-reconstruction", "semantic:semantic-diff", "reconstructed semantics")
    edge("semantic:semantic-diff", "semantic:fidelity-checker", "classifies fidelity")
    edge("semantic:semantic-diff", "semantic:theorem-denoiser", "exposes repair candidate")
    edge("semantic:fidelity-checker", "semantic:source-review", "requires independent review")
    edge("semantic:theorem-denoiser", "semantic:source-review", "requires repair review")

    audits = registry.get("audits", []) if isinstance(registry.get("audits"), list) else []
    repair_count = 0
    accepted_repairs = 0
    for audit in audits:
        if not isinstance(audit, dict):
            continue
        audit_id = str(audit.get("id", "unnamed"))
        source = audit.get("source", {}) if isinstance(audit.get("source"), dict) else {}
        lean = audit.get("lean", {}) if isinstance(audit.get("lean"), dict) else {}
        reconstruction = audit.get("reconstruction", {}) if isinstance(audit.get("reconstruction"), dict) else {}
        review = audit.get("source_review", {}) if isinstance(audit.get("source_review"), dict) else {}
        slot_rows = []
        semantic_slots = audit.get("semantic_slots", {}) if isinstance(audit.get("semantic_slots"), dict) else {}
        for slot in protocol.get("semantic_slots", []):
            row = semantic_slots.get(slot, {}) if isinstance(semantic_slots.get(slot), dict) else {}
            slot_rows.append(
                {
                    "slot": str(slot).replace("_", " "),
                    "original": row.get("original", "not audited"),
                    "reconstructed": row.get("reconstructed", "not audited"),
                    "relation": row.get("relation", "not-audited"),
                    "evidence": row.get("evidence", ""),
                }
            )
        deltas = [delta for delta in audit.get("deltas", []) if isinstance(delta, dict)]
        repairs = [repair for repair in audit.get("repairs", []) if isinstance(repair, dict)]
        node_id = add(
            f"semantic-audit:{audit_id}",
            "semantic-audit",
            audit_id,
            status=audit_status(audit),
            subtitle=f"{source.get('source_id', 'source')} · {audit.get('verdict', 'pending')}",
            summary=f"Blind reconstruction and seven-slot semantic comparison for {lean.get('declaration', 'an unassigned Lean target')}.",
            column=7,
            url=source.get("reader_url", docs_url),
            source_url=source.get("url", ""),
            original_theorem=source.get("original_text", ""),
            reconstructed_theorem=reconstruction.get("text", ""),
            fidelity_verdict=audit.get("verdict", "pending"),
            blindness="source hidden from decoder" if reconstruction.get("source_text_visible") is False else "blindness not established",
            semantic_slots=slot_rows,
            semantic_deltas=deltas,
            repair_proposals=repairs,
            details=[
                {"label": "Audit state", "value": audit.get("state", "draft")},
                {"label": "Source anchor", "value": source.get("anchor", "")},
                {"label": "Lean declaration", "value": lean.get("declaration", "")},
                {"label": "Lean file", "value": lean.get("file", "")},
                {"label": "Lean compiled", "value": str(lean.get("compiled", False)).lower()},
                {"label": "Formalizer", "value": lean.get("formalizer", "")},
                {"label": "Decoder", "value": reconstruction.get("decoder", "")},
                {"label": "Blind packet", "value": reconstruction.get("decoder_packet_sha256", "")},
                {"label": "Source review", "value": review.get("state", "pending")},
                {"label": "Reviewer", "value": review.get("reviewer", "")},
            ],
        )
        edge("semantic:fidelity-checker", node_id, "applies fidelity gate")
        graph_node = str(audit.get("graph_node", ""))
        if graph_node:
            edge(graph_node, node_id, "source theorem under audit")
        declaration = str(lean.get("declaration", ""))
        if declaration:
            edge(f"decl:{declaration}", node_id, "Lean target under audit")

        for repair in repairs:
            repair_count += 1
            repair_id = str(repair.get("id", f"{audit_id}-repair-{repair_count}"))
            accepted = repair.get("status") == "accepted"
            accepted_repairs += int(accepted)
            repair_node = add(
                f"repair:{repair_id}",
                "repair-proposal",
                repair.get("proposed_change", repair_id),
                status="fidelity-repaired" if accepted else "proposal",
                subtitle=f"{repair.get('class', 'repair')} · {repair.get('necessity', 'uncertain')}",
                summary=repair.get("justification", ""),
                column=8,
                url=source.get("reader_url", docs_url),
                source_url=source.get("url", ""),
                repaired_theorem=repair.get("reconstructed_statement", ""),
                details=[
                    {"label": "Repair ID", "value": repair_id},
                    {"label": "Status", "value": repair.get("status", "proposed")},
                    {"label": "Minimality evidence", "value": repair.get("minimality_evidence", "")},
                    {"label": "Repaired statement hash", "value": repair.get("statement_sha256", "")},
                    {"label": "Reference / counterexample", "value": repair.get("reference_or_counterexample", "")},
                    {"label": "Source mutation", "value": "forbidden; proposal remains separate"},
                ],
            )
            edge(node_id, repair_node, "proposes minimal repair")
            edge("semantic:theorem-denoiser", repair_node, "generates repair proposal")
            edge(repair_node, "semantic:source-review", "requires source review")

    return {
        "protocol_nodes": len(STAGES),
        "audits": sum(isinstance(audit, dict) for audit in audits),
        "repair_proposals": repair_count,
        "accepted_repairs": accepted_repairs,
    }
