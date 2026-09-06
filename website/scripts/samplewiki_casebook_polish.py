#!/usr/bin/env python3
"""Reader-first polish for the SampleWiki mathematical casebook.

This layer deliberately optimizes the public page for learning before formal
infrastructure.  Exact source audits remain exact.  Cases that still await
primary-theorem audit receive a useful *reader derivation map* rather than an
empty warning box, but that map is never mislabeled as the paper's proof.

The public order stays:
Statement -> Proof / derivation -> Assumptions -> folded rigorous LaTeX ->
folded Lean.  The Lean fold is intentionally quiet while source mathematics is
being filled out case by case.
"""

from __future__ import annotations

from typing import Any

import samplewiki_reader_contract as reader


_BASE_PROOF_SECTION = reader.proof_section


SETTING_ASSUMPTIONS: dict[str, tuple[str, ...]] = {
    "setting-convex-body-membership": (
        "The target is supported on a convex body and access is through the membership-oracle model fixed by the source setting.",
        "Geometric quantities such as radius, warmness, and any Gaussian-annealing parameter keep the normalization used by the cited paper.",
        "The displayed divergence/accuracy target is part of the theorem contract, not an interchangeable metric.",
    ),
    "setting-functional-inequality-smooth": (
        "The target has a smooth log-density; the cited theorem specifies the smoothness normalization.",
        "A Poincaré or log-Sobolev inequality is assumed exactly where the cited result invokes it.",
        "Initialization and warm-start quantities such as KL or Rényi divergence remain theorem-specific.",
    ),
    "setting-holder-smooth-log-concave": (
        "The potential is convex and satisfies the weak/Hölder smoothness model of the cited theorem.",
        "The Hölder exponent and constant are source parameters; ASTIS does not silently replace them by ordinary smoothness.",
        "The initial transport scale and the requested KL accuracy are kept explicit in the rate.",
    ),
    "setting-log-concave-smooth": (
        "The target is log-concave with the source's smoothness hypothesis on the potential or score.",
        "The initialization scale, typically expressed through a Wasserstein or divergence quantity, is part of the bound.",
        "Implemented proximal results additionally require the restricted-Gaussian/proximal oracle promised by the source theorem.",
    ),
    "setting-nonlogconcave-fisher": (
        "No global log-concavity is assumed merely because Fisher information is the output criterion.",
        "The potential/score smoothness and finite initial-information quantity are inherited from the cited theorem.",
        "Relative Fisher information requires a legitimate density/score representative; ASTIS keeps this regularity obligation visible.",
    ),
    "setting-stochastic-finite-sum": (
        "The oracle model is part of the theorem: stochastic-gradient noise and finite-sum access are not interchangeable.",
        "Variance, component count, convexity/functional-inequality constants, and initialization are inherited from the cited result.",
        "The displayed query complexity counts the oracle calls used by that source model.",
    ),
    "setting-strongly-log-concave-smooth": (
        "The potential is strongly convex and smooth in the sense stated by the cited theorem.",
        "The condition number is the source's ratio of smoothness to strong-convexity scales.",
        "Warm-start assumptions are theorem-specific; when a result assumes bounded chi-squared divergence, that assumption is not hidden by the final TV guarantee.",
    ),
}


DERIVATION_ROUTES: tuple[tuple[tuple[str, ...], str, tuple[str, ...]], ...] = (
    (
        ("in-and-out", "membership", "annealing", "constrained proximal"),
        "Geometry and annealing route",
        (
            "Construct the source's warm-start or annealing path inside the convex-body membership model.",
            "Control one transition/phase in the divergence used by the theorem.",
            "Compose the phases or restart epochs while preserving the required warmness/geometric control.",
            "Choose the annealing and accuracy parameters to obtain the displayed membership-query complexity.",
        ),
    ),
    (
        ("proximal", "rgo"),
        "Proximal contraction and implementation route",
        (
            "Analyze the ideal proximal transition, where the Gaussian augmentation exposes a tractable conditional step.",
            "Convert the ideal contraction into the theorem's requested divergence or transport guarantee.",
            "Implement each restricted-Gaussian/proximal call and track its approximation error without hiding it inside the ideal chain.",
            "Compose iteration count and per-call cost, then tune the internal accuracy to obtain the displayed total rate.",
        ),
    ),
    (
        ("exact uld", "fors"),
        "Continuous contraction and exact-simulation route",
        (
            "Use the continuous underdamped/Langevin contraction statement in the source divergence.",
            "Represent the diffusion path-law change and simulate the required correction with the FORS likelihood-ratio machinery.",
            "Control simulation error in Rényi divergence and transfer it from path space to the terminal marginal by data processing.",
            "Compose continuous-time contraction and simulation error, then optimize time horizon and internal accuracy.",
        ),
    ),
    (
        ("mala", "metropolis"),
        "Metropolis correction and conductance route",
        (
            "Control the proposal/rejection discrepancy on a high-probability region under the target law.",
            "Turn local overlap of proposal kernels into conductance or s-conductance for the Metropolis chain.",
            "Combine the conductance bound with the source warm-start condition to obtain quantitative mixing.",
            "Tune the proposal step size and failure scale to reach the displayed total-variation rate.",
        ),
    ),
    (
        ("randomized-midpoint", "ulmc", "underdamped"),
        "Underdamped contraction and discretization route",
        (
            "Obtain continuous-time contraction for the underdamped Langevin dynamics under the source functional inequality.",
            "Bound the randomized-midpoint/discretization error over one or several steps.",
            "Convert the path or local numerical error into the requested terminal divergence/TV guarantee.",
            "Balance contraction time against discretization error to choose step size and iteration count.",
        ),
    ),
    (
        ("averaged lmc",),
        "EVI / dissipation and averaging route",
        (
            "Derive a one-step evolution variational or entropy-dissipation inequality for the LMC interpolation.",
            "Separate the dissipative term from the discretization bias produced by freezing the drift.",
            "Sum/telescope the one-step inequality and use convexity when the output is a mixture of iterates.",
            "Choose the step size and number of iterates so the optimization term and discretization term meet the displayed accuracy.",
        ),
    ),
    (
        ("lmc rényi", "renyi interpolation"),
        "Rényi interpolation route",
        (
            "Interpolate the discrete LMC chain by a continuous process and differentiate a Rényi power functional.",
            "Use LSI/hypercontractivity to absorb the Rényi-Fisher term and control the discretization contribution.",
            "Run the source's waiting/interpolation phase to move from the initial order to the requested Rényi order.",
            "Unroll the recursion and tune step size/time to obtain the displayed Rényi guarantee.",
        ),
    ),
    (
        ("lmc",),
        "Langevin interpolation and entropy-dissipation route",
        (
            "Interpolate one LMC update by a diffusion with frozen drift.",
            "Differentiate KL along the interpolation: Langevin dissipation gives a negative Fisher-information term and discretization gives an error term.",
            "Use the source functional inequality or convex-optimization/EVI estimate to turn dissipation into contraction.",
            "Integrate/telescope and balance the contraction and discretization terms to choose the step size and iteration count.",
        ),
    ),
    (
        ("mirror",),
        "Mirror geometry and averaging route",
        (
            "Write the sampling dynamics in the source Bregman/mirror geometry rather than silently reverting to Euclidean distance.",
            "Establish the corresponding descent/evolution inequality and isolate the discretization term.",
            "Telescope or average the inequality in the geometry used by the theorem.",
            "Tune the step size to convert the geometric bound into the displayed KL/query complexity.",
        ),
    ),
    (
        ("stochastic-gradient", "variance-reduced", "finite-sum", "rm-ulmc"),
        "Oracle-noise and sampling-error route",
        (
            "Fix the stochastic/finite-sum oracle and the exact quantity controlled for one update or inner call.",
            "Bound the sampling/discretization error together with the oracle-noise or variance-reduction contribution.",
            "Propagate the error through the continuous or proximal mixing argument used by the source.",
            "Choose batch/epoch/step parameters so oracle cost and target sampling accuracy balance at the displayed rate.",
        ),
    ),
    (
        ("lower bound", "best lower", "lower"),
        "Hard-instance and oracle-separation route",
        (
            "Construct a family of targets satisfying the same model/regularity assumptions as the upper-bound problem.",
            "Show that too few oracle queries cannot reliably distinguish the hard instances or locate the relevant geometry.",
            "Translate indistinguishability into separation in the theorem's target accuracy metric.",
            "Solve the resulting information/query inequality to obtain the displayed lower-bound scaling.",
        ),
    ),
    (
        ("block-krylov", "gaussian"),
        "Polynomial approximation and Gaussian sampling route",
        (
            "Reduce Gaussian sampling to applying an appropriate matrix function to standard Gaussian noise.",
            "Approximate the matrix function in a Krylov subspace while controlling spectral error on the condition-number interval.",
            "Transfer the matrix approximation bound to the divergence metric of the Gaussian laws.",
            "Choose Krylov degree/block parameters to obtain the displayed dimension/condition-number dependence.",
        ),
    ),
)


def _route_for(case: dict[str, Any]) -> tuple[str, tuple[str, ...]]:
    haystack = " ".join(
        str(case.get(field, ""))
        for field in ("algorithm_or_model", "result_class", "setting_title")
    ).lower()
    for needles, title, steps in DERIVATION_ROUTES:
        if any(needle in haystack for needle in needles):
            return title, steps
    return (
        "Source-to-rate derivation route",
        (
            "Start from the cited source theorem in its exact oracle/model and initialization regime.",
            "Identify the contraction, discretization, implementation, or hard-instance estimate that controls the requested accuracy.",
            "Compose that estimate across the source algorithm without changing the divergence metric.",
            "Tune the theorem parameters to recover the displayed complexity/rate.",
        ),
    )


def _formula_lines(case: dict[str, Any], audit: dict[str, Any] | None) -> str:
    return "".join(
        '<div class="sw-statement-line">'
        f'<span>{reader.esc(kind)}</span>'
        f'{reader.formula_html(formula, css="sw-main-statement")}'
        '</div>'
        for kind, formula in reader.statement_formulas(case, audit)
    )


def statement_section(case: dict[str, Any], audit: dict[str, Any] | None) -> str:
    status, label = reader.statement_status(case, audit)
    formulas = _formula_lines(case, audit)
    refs = reader.source_refs(case)

    if audit is not None:
        source_url = str(audit.get("source_url", "")).strip()
        source_title = str(audit.get("source_title", "")).strip() or label
        source_version = str(audit.get("source_version", "")).strip()
        source = (
            '<div class="sw-paper-line">'
            f'<a href="{reader.esc(source_url)}">{reader.esc(source_title)}</a>'
            f'<span>{reader.esc(source_version)}</span>'
            '</div>'
        )
        note = (
            "Primary-source audit complete. The displayed theorem statement is the controlling mathematical contract for this case."
        )
    elif reader.literature_open(case):
        source = '<div class="sw-paper-line"><span>Literature frontier</span></div>'
        note = (
            "Open problem: SampleWiki records the matching result as unknown. ASTIS shows the target regime but does not manufacture a theorem or rate."
        )
    else:
        if refs:
            ref = refs[0]
            source = (
                '<div class="sw-paper-line">'
                f'<a href="{reader.esc(ref["url"])}">{reader.esc(ref["label"])}</a>'
                '<span>primary theorem audit in progress</span></div>'
            )
        else:
            source = '<div class="sw-paper-line"><span>Primary reference audit pending</span></div>'
        note = (
            "Primary theorem audit pending. The formulas below are the cleaned SampleWiki normalization of the cited result, not a claim of verbatim theorem transcription."
        )

    reading = (
        "Read the accuracy guarantee together with the complexity/rate: the source assumptions and its notion of oracle cost are part of the result."
        if not reader.literature_open(case)
        else "The useful mathematical content is the missing matching rate under exactly this setting and accuracy notion."
    )
    return f"""
<section id="sw-statement" class="sw-casebook-section sw-casebook-statement" data-reader-layer="statement">
  <div class="sw-reader-step">Statement</div>
  <div class="sw-statement-heading"><div><p class="sw-statement-status">{reader.esc(status)}</p><h2>{reader.esc(label)}</h2></div>{source}</div>
  {formulas or '<p class="sw-open-statement">No finite matching rate is asserted by the pinned literature record.</p>'}
  <p class="sw-reading-note"><strong>Reading.</strong> {reader.esc(reading)}</p>
  <p class="sw-truth-note">{reader.esc(note)}</p>
</section>
"""


def _pending_derivation(case: dict[str, Any]) -> str:
    title, steps = _route_for(case)
    guarantee = reader.row_formula(case, "guarantee")
    complexity = reader.row_formula(case, "complexity")
    refs = reader.source_refs(case)
    paper = refs[0]["label"] if refs else "the cited source"

    rows = []
    for index, step in enumerate(steps, start=1):
        extra = ""
        if index == len(steps) - 1 and guarantee:
            extra = reader.formula_html(guarantee, css="sw-derivation-formula")
        if index == len(steps) and complexity and complexity != guarantee:
            extra = reader.formula_html(complexity, css="sw-derivation-formula")
        rows.append(
            '<article class="sw-proof-equation sw-derivation-step">'
            f'<span class="sw-proof-index">{index:02d}</span>'
            f'<div><h3>{reader.esc(step)}</h3>{extra}</div>'
            '</article>'
        )

    return f"""
<section id="sw-derivation" class="sw-casebook-section sw-casebook-proof" data-reader-layer="proof" data-derivation-kind="reader-map">
  <div class="sw-reader-step">Proof / derivation</div>
  <h2>Reader derivation map · {reader.esc(title)}</h2>
  <p class="sw-derivation-boundary">This is a source-linked reading map for {reader.esc(paper)}, not a transcription of the paper's proof. Exact source proof equations replace this map once theorem-level audit is complete.</p>
  <div class="sw-proof-equations">{''.join(rows)}</div>
</section>
"""


def proof_section(case: dict[str, Any], audit: dict[str, Any] | None) -> str:
    if audit is None and not reader.literature_open(case):
        return _pending_derivation(case)
    html = _BASE_PROOF_SECTION(case, audit)
    html = html.replace(
        '<section class="sw-casebook-section sw-casebook-proof"',
        '<section id="sw-derivation" class="sw-casebook-section sw-casebook-proof"',
        1,
    )
    return html


def assumptions_section(case: dict[str, Any], audit: dict[str, Any] | None) -> str:
    setting_slug = str(case.get("setting_slug", ""))
    setting_items = SETTING_ASSUMPTIONS.get(
        setting_slug,
        (
            "The model, oracle, regularity, and initialization conventions are inherited from the linked source setting.",
            "The displayed accuracy metric and complexity notion are not silently exchanged for a different one.",
        ),
    )
    qualifiers = reader.material_qualifiers(case)
    prerequisites = [str(item) for item in (audit or {}).get("prerequisites", [])]

    if audit is None and not reader.literature_open(case):
        prerequisites.append(
            "Exact theorem-level parameter ranges and technical hypotheses remain controlled by the cited paper until primary-source audit is complete."
        )
    if reader.literature_open(case):
        prerequisites.append(
            "No additional hypothesis is introduced merely to turn the open lower-bound question into a theorem."
        )

    def panel(title: str, items: list[str] | tuple[str, ...]) -> str:
        if not items:
            return ""
        return (
            '<div class="sw-assumption-panel">'
            f'<h3>{reader.esc(title)}</h3><ul>'
            + "".join(f'<li>{reader.esc(item)}</li>' for item in items)
            + '</ul></div>'
        )

    qualifier_items = [
        f"Comparison-row qualifier: {value}." for value in qualifiers
    ]
    return f"""
<section id="sw-assumptions" class="sw-casebook-section sw-casebook-assumptions" data-reader-layer="assumptions">
  <div class="sw-reader-step">Assumptions and implicit prerequisites</div>
  <h2>What must be true before the rate can be read</h2>
  <div class="sw-assumption-grid">
    {panel('Model and geometry', setting_items)}
    {panel('Case-specific qualifiers', qualifier_items)}
    {panel('Analytic / proof prerequisites', prerequisites)}
  </div>
</section>
"""


def lean_details(
    case: dict[str, Any],
    audit: dict[str, Any] | None,
    active_meta: dict[str, Any] | None,
) -> str:
    del case, audit, active_meta
    return """
<details id="sw-lean" class="sw-casebook-disclosure sw-lean-formalization" data-reader-layer="lean">
  <summary>Lean formalization</summary>
  <div class="sw-casebook-disclosure-body sw-lean-reserved">
    <p>This fold is intentionally quiet while the source statement, proof route, and assumptions are being completed case by case. A source-facing Lean theorem will appear here only after it compiles and its statement has been matched to the audited source.</p>
  </div>
</details>
"""


def case_main(
    rel_path: str,
    case: dict[str, Any],
    audit: dict[str, Any] | None,
    active_meta: dict[str, Any] | None,
) -> str:
    status, _ = reader.statement_status(case, audit)
    rigorous = reader.rigorous_details(case, audit, active_meta).replace(
        '<details class="sw-casebook-disclosure sw-rigorous-latex"',
        '<details id="sw-rigorous" class="sw-casebook-disclosure sw-rigorous-latex"',
        1,
    )
    return f"""
<article class="sw-casebook-reader" data-samplewiki-case="{reader.esc(case.get('id', ''))}">
  <nav class="reader-breadcrumb" aria-label="Breadcrumb">
    <a href="{reader.esc(reader.href_from(rel_path, reader.OVERVIEW))}">SampleWiki</a><span>/</span>
    <a href="{reader.esc(reader.href_from(rel_path, reader.setting_path(str(case.get('setting_slug', '')))))}">{reader.esc(case.get('setting_title', ''))}</a>
  </nav>
  <header class="sw-casebook-header">
    <div class="sw-casebook-kicker">{reader.esc(case.get('result_class', 'Result'))} · {reader.esc(status)}</div>
    <h1>{reader.esc(case.get('algorithm_or_model', 'SampleWiki result'))}</h1>
    <p class="sw-casebook-lede">A paper-first mathematical case study: read the theorem, the derivation route, and the hidden prerequisites before opening formal infrastructure.</p>
  </header>
  <nav class="sw-casebook-jump" aria-label="Case sections">
    <a href="#sw-statement">Statement</a>
    <a href="#sw-derivation">Proof / derivation</a>
    <a href="#sw-assumptions">Assumptions</a>
    <a href="#sw-rigorous">ASTIS LaTeX</a>
    <a href="#sw-lean">Lean</a>
  </nav>
  {statement_section(case, audit)}
  {proof_section(case, audit)}
  {assumptions_section(case, audit)}
  {rigorous}
  {lean_details(case, audit, active_meta)}
  {reader.references_section(case, audit)}
</article>
"""


def patch(module: Any = reader) -> None:
    module.statement_section = statement_section
    module.proof_section = proof_section
    module.assumptions_section = assumptions_section
    module.lean_details = lean_details
    module.case_main = case_main


if __name__ == "__main__":
    patch()
    reader.enrich_site()
