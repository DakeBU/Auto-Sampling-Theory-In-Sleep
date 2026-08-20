#!/usr/bin/env python3
"""Refine the source-first reader before its final rendering pass.

This keeps audit metadata out of prose and makes the small amount of mathematics
that belongs inside assumption sentences explicit MathJax rather than ASCII.
"""

from __future__ import annotations

import re
from typing import Any


INLINE_REPLACEMENTS: tuple[tuple[re.Pattern[str], str], ...] = (
    (re.compile(r"\btau_m\s*<=\s*tau_n\b"), r"\\(\\tau_m\\le\\tau_n\\)"),
    (re.compile(r"\bt\s*->\s*A_t\b"), r"\\(t\\mapsto A_t\\)"),
    (re.compile(r"\bc\s*>=\s*0\b"), r"\\(c\\ge 0\\)"),
    (re.compile(r"\bL2\(Omega\)\b"), r"\\(L^2(\\Omega)\\)"),
    (re.compile(r"\bL2\b"), r"\\(L^2\\)"),
    (re.compile(r"\[0,T\]"), r"\\([0,T]\\)"),
)


def mathify(value: object) -> str:
    text = str(value)
    for pattern, replacement in INLINE_REPLACEMENTS:
        text = pattern.sub(lambda _m, replacement=replacement: replacement, text)
    return text


def patch(contract: Any) -> None:
    def render_mixed_list(values: list[str], css_class: str = "") -> str:
        cls = f' class="{css_class}"' if css_class else ""
        return (
            "<ul" + cls + ">"
            + "".join(f"<li>{contract.esc(mathify(value))}</li>" for value in values)
            + "</ul>"
        )

    def render_hidden_assumptions(source: dict[str, Any]) -> str:
        source_assumptions = [
            str(x) for x in source.get("source_assumptions", []) if str(x).strip()
        ]
        formal_assumptions = [
            str(x) for x in source.get("formal_assumptions", []) if str(x).strip()
        ]
        parts = [
            '<div class="source-contract-hidden-assumptions">',
            '<h3>Assumptions and implicit prerequisites</h3>',
        ]
        if source_assumptions:
            parts.append(
                '<h4>Source-level assumptions</h4>'
                + render_mixed_list(source_assumptions)
            )
        if formal_assumptions:
            parts.append(
                '<h4>Conditions made explicit by ASTIS</h4>'
                + contract._code_list(formal_assumptions)
            )
        parts.append('</div>')
        return "".join(parts)

    def render_astis_latex(
        source_id: str,
        source: dict[str, Any],
        statement: str,
        proof: dict[str, Any] | None,
    ) -> str:
        equations = contract._render_equations(
            proof, "astis-rigorous-proof-formula"
        )
        source_status = str(proof.get("source_status", "")) if proof else ""
        if source_status == "astis_expansion":
            proof_note = (
                "The equations below are the ASTIS expansion of a proof omitted "
                "or compressed in the source."
            )
        elif equations:
            proof_note = (
                "The source argument is restated here as a strict ASTIS LaTeX "
                "packet before the Lean correspondence."
            )
        else:
            proof_note = (
                "This packet records the strict ASTIS statement. No additional "
                "proof is attributed to the source."
            )
        return (
            '<details class="reader-disclosure source-contract-astis-latex">'
            '<summary>ASTIS rigorous LaTeX formalization</summary>'
            '<div class="disclosure-body">'
            f'<p>{contract.esc(proof_note)}</p>'
            f'{contract._display_math(statement, "astis-rigorous-statement")}'
            + equations
            + '</div></details>'
        )

    def render_implicit_card(item: dict[str, Any], url_map: dict[str, str]) -> str:
        item_id = str(item.get("id", ""))
        proof = contract.IMPLICIT_PROOF_OVERRIDES.get(item_id)
        raw_proof = str(item.get("proof", ""))
        if proof is None:
            if contract._raw_math_errors(raw_proof):
                raise RuntimeError(
                    f"{item_id}: implicit-prerequisite proof contains raw mathematics "
                    "and has no clean proof override"
                )
            proof = raw_proof
        assumptions = [
            str(x) for x in item.get("assumptions", []) if str(x).strip()
        ]
        declarations = [
            str(x) for x in item.get("lean_declarations", []) if str(x).strip()
        ]
        lean_rows: list[str] = []
        for name in declarations:
            url = url_map.get(name)
            if url:
                lean_rows.append(
                    f'<li><a href="../../{contract.esc(url)}">'
                    f'<code>{contract.esc(name)}</code></a></li>'
                )
            else:
                lean_rows.append(f'<li><code>{contract.esc(name)}</code></li>')
        return (
            '<article class="textbook-block implicit-prerequisite-card '
            'source-contract-implicit" '
            f'id="{contract.esc(item_id)}" '
            'data-provenance="astis-implicit-prerequisite">'
            '<div class="passage-label">ASTIS implicit prerequisite · not a '
            'standalone Chewi result</div>'
            f'<h2>{contract.esc(item.get("title", ""))}</h2>'
            '<p><strong>Why it is needed.</strong> '
            f'{contract.esc(mathify(item.get("why_needed", "")))}</p>'
            f'{contract._display_math(str(item.get("latex_statement", "")), "implicit-prerequisite-statement")}'
            '<h3>Assumptions</h3>'
            f'{render_mixed_list(assumptions)}'
            '<details class="reader-disclosure source-contract-implicit-proof">'
            '<summary>Mathematical proof</summary><div class="disclosure-body">'
            f'<p>{contract.esc(mathify(proof))}</p></div></details>'
            '<details class="reader-disclosure source-contract-lean">'
            '<summary>Lean formalization</summary><div class="disclosure-body"><ul>'
            + ''.join(lean_rows)
            + '</ul></div></details>'
            '</article>'
        )

    contract._render_hidden_assumptions = render_hidden_assumptions
    contract._render_astis_latex = render_astis_latex
    contract._render_implicit_card = render_implicit_card
