# Gradient descent: comparator energy and weighted values

SAU: `ANDI-OPT-gd-value-001`; baseline `38f7c55b21bb71d051f1c0bbad192b0a58117531`.
Source: [Chewi arXiv:2605.07006v1 §3](https://arxiv.org/html/2605.07006v1#S3), Theorem3.4 (3.1),(3.3), Lemma3.1 and weighted calculation following Lemma3.5.
This is user-directed shared optimization textbook work, not companion-paper progress.

## Exact delta and retrieval

Two public declarations in `Analysis.GradientDescentValue`: `gradient_step_energy_bound` and `gradient_descent_weighted_value_bound`. The former is the arbitrary-comparator distance/function energy inequality. The latter applies it to actual iterates and gives
`2h (Σ k<N q^k) (f(T^N x0)-f(z)) ≤ q^N ||x0-z||²`, with `q=1-alpha*h≥0`.
The comparator gap may be negative; no minimizer is assumed. Private `step_descent` is an implementation of source Lemma3.1, reviewed with the whole production file, not a separate credited leaf.

Search before implementation: ASTIS existing strong first-order support and gradient modules/frontier cells; pinned Mathlib db584cd6 `discrete_gronwall_prod_general`, `geom_sum_mul_neg`, finite sums and actual iteration; Optlib 5da27c5 `point_descent_for_convex` and `gradient_method` in GradientDescent.lean (existing alpha=0 estimates, Lean4.13, Apache2); pinned CvxLean c62c2f bounded search found no matching API. Classification `adapt_existing`. No external implementation imported or copied. Independent source/reuse review: smoothness_review, `/private/tmp/andi-gd-value-source-plan.md`.

The recurrence reuses Mathlib's signed-forcing product form. Its exponential Gronwall theorem requires nonnegative forcing and cannot be substituted. First-order support is the existing local StrongConvexFirstOrder theorem. No generic recurrence wrapper was introduced.

## Domains and source fidelity

Global C1 on a complete real Hilbert space extends the source C2 Euclidean setting. Signed curvature parameters are permitted by the two explicit model hypotheses; the source uses nonnegative moduli. The step is explicitly nonnegative, with division-free beta*h≤1. The weighted adapter exposes alpha*h≤1; no negative-weight comparison occurs. Source A>0 is extended to q=0 by the product recurrence.

The source printed h≤1/beta alone is insufficient: f(t)=t²/2, alpha=0,beta=1,x=0,z=1,h=-1 gives energy left2>right1. This missing nonnegative-step domain requires independently reviewed source-gap handling. h=0,N=0,q=0,q=1 are valid division-free cases, not totalized reciprocal formulas. Tests derive the convex 1/(2Nh) rate, the positive-alpha form alpha*q^N/[2(1-q^N)] with strictly positive denominator, and one-step function optimality at q=0 with a supplied actual minimizer. The exact inverse-power identity and published normalized rates remain separate uncovered obligations; do not mark all of Theorem3.4 complete.

## Conceptual-mirror audit

`none-found`: the existing curvature-growth / gap-gradient families already retain the curvature-to-discrete-energy mechanism. This SAU adds compiled Euclidean/Hilbert edges, not a new cross-domain transport or a certified equivalence.

## Validation and integration

Focused target: `lake build Tests.Shared.GradientDescentValue`. Independent review, source-blind decoding, source review, publication validation, root Tests import, full gate and graph/site validation are required before integration. Keep the existing Tests.lean coverage lesson: adding a test file alone does not add CI coverage.

### Verified integration candidate

Proof commit `417d096d91565a8e287fa957cbda1d49ccb5ad2e`; root integration candidate `fccbf94e9310f9dd7ec5de65d5594a0edd71f58a`. Independent proof and integration reviewer `smoothness_review`; source-blind decoder `value_blind`; anti-anchored source reviewer `coco_source`; separate exact-proposal repair reviewer `converse_source_review`. Raw bound reports are preserved under `runs/semantic-roundtrip/andi-opt-gd-value/`. The private descent helper has explicit whole-module publication coverage and no separate Registry entry. Source verdicts remain `possible-source-error` and `domain-mismatch`; accepting the nonnegative-step overlay does not relabel them as exact source equivalence.

Validation completed: independently repeated focused build PASS2472 without warnings; standard axioms only; canonical `website/scripts/lean_gate.py` → `tools/astis.py check` PASS9150 at `fccbf94`, recorded `2026-09-11T12:08:26.616759+00:00`; actual Tests root imports the new tests. ATLAS and fake-closure gate passed. Harness PASS255 with 6 configured skips. Frontier checks PASS73; semantic registry PASS65 audits / 3 repairs; diff publication PASS51 source items with private-helper owner printed. Registry count410→412 includes exactly the two public results.

Graph/reader integration notes: `build_site.py`, both bounded `graph-check --cell` calls and `check_site.py` passed (620 modules,3756 declarations,412 compiled local leaves). The existing chapter03 source item exposes two covered edges and two unclosed normalized-rate obligations. Both Lean statements/proofs remain initially closed beside the mathematical exposition. Browser inspection at desktop1280 and mobile390 confirmed complete weighted formulas, zero KaTeX errors, no page-width overflow, and exact hypotheses/source-gap display. The Lean Branches focused view shows the new module declaring both public nodes, the first-order-support → energy → weighted-value source-reference chain, chapter correspondence and separate fidelity audit nodes. Structural edges are solid; source-scanner references/correspondence remain dashed, not asserted elaborated theorem dependencies. No new conceptual bridge or module-scope audit was fabricated.

Focused nodes: `decl:AutoSamplingTheory.TechnicalLemmas.Analysis.GradientDescentValue.gradient_step_energy_bound` and `decl:AutoSamplingTheory.TechnicalLemmas.Analysis.GradientDescentValue.gradient_descent_weighted_value_bound`, with generated `lean-foundations.html?view=lean&focus=...` links returned by the bounded graph checks. No maintained static diagram changed.

Historical integration hygiene: `smoothness_review` independently audited exact preservation of merged PR277 PoissonQueryTail artifacts from historical VERIFIED3124c1a to actual canonical merge38f7c55. After fresh fetch, sole writer appended an attributed STABILIZING→VERIFIED reservation release, preserving original events and not impersonating the original owner's MERGED transition. Baseline63 audit objects and ledger byte prefixes remain intact.

Next boundary: retain Theorem3.4 inverse-power equivalence and normalized convex public-source obligations as open. The normalized tests already provide real reusable proof material; do not manufacture a new mathematical SAU merely by turning these examples into wrappers. Choose the next substantive descent/PL consumer after checking live ownership and source dependencies. No complete chapter or companion-paper progress is claimed.
