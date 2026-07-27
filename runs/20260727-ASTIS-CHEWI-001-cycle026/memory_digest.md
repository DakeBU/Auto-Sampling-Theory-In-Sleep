# Memory Digest: ASTIS-CHEWI-001 cycle 26

Generated: `2026-07-27 16:47:51`

Run directory: `runs\20260727-ASTIS-CHEWI-001-cycle026`

This is the ABEIS-style compact retrieval packet for ASTIS.  Upper and middle
should read this before replaying long logs.

## Plain-Language Status

The active textbook edge is Chapter 1, Example 1.2.8 to Corollary 1.2.9.  Generator algebra, finite-box cancellation, smooth plateau cutoffs, the radial compact-support pointwise-exhaustion base, a scale-uniform O(R^-1) first-derivative bound, closed outer-region derivative vanishing, finite-Pi cutoff derivative/trace bridges, and the generic L1 cutoff-gradient limit for Integrable fields are compiled locally.  Gibbs/source-field integrability, main-term dominated convergence, Gibbs tails, whole-space weighted integration by parts, generator/semigroup domains, and the invariant Gibbs law remain explicit red nodes.

## Active Proof-DAG Leaves

- Prove the Gibbs-specific source-field integrability consumed by the compiled generic L1 cutoff-gradient theorem; keep main-term dominated convergence, Gibbs tail, whole-space IBP, domains, invariance, and Hessian/Laplacian separate.

## Open Obligation Signals

- Prove the Gibbs-specific source-field integrability consumed by the compiled generic L1 cutoff-gradient theorem; keep main-term dominated convergence, Gibbs tail, whole-space IBP, domains, invariance, and Hessian/Laplacian separate.

## Mathlib-Ready Leaf Discipline

- Decompose aggressively: one lower packet should target one small lemma.
- Specify the theorem together with local APIs, imports, hidden regularity
  contracts, and an intended proof route.
- Search Mathlib and `AutoSamplingTheory/TechnicalLemmas` before inventing a
  local bridge.
- Treat repeated failure as a mathematical signal: missing assumption, false
  statement, representative mismatch, API mismatch, or over-large target.
- Do not churn the theorem shape or proof route without reviewer diagnosis.
- Protocol: `docs/mathlib_ready_leaf_protocol.md`.
- Skill tree: `research-wiki/lemma-dags/SDE_Sampling_skill_tree.md`.
- Compressed Pro leaf targets:
  `research-wiki/lemma-dags/Pro_assimilated_leaf_targets.md`.

## Open Paper Contribution Obligations

_None._

## Open External Technical Lemma Obligations

| id | source | status | used by | next action |
| --- | --- | --- | --- | --- |
| SLT/GaussianPoincare/TaylorBound.lean | SLT/GaussianPoincare/TaylorBound.lean | port-candidate | selected scalar Taylor integral/remainder and bounded-Hessian leaves | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianPoincare/Limit.lean | SLT/GaussianPoincare/Limit.lean | future-port | Taylor remainder limits and Gaussian Poincare backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/DualityEntropy.lean | SLT/GaussianLSI/DualityEntropy.lean | future-port | DV/KL variational formula backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/TensorizedGLSI.lean | SLT/GaussianLSI/TensorizedGLSI.lean | future-port | product Gaussian LSI backend | Port to ASTIS-owned TechnicalLemmas before using. |

## Recent Typed Verifier Feedback

| leaf | class | build | measure | technical lemma | next |
| --- | --- | --- | --- | --- | --- |
| analysis.calculus.pilp-radial-cutoff-gradient-L1-tendsto-zero | None | True | True | True | Prove the Gibbs-specific source-field integrability consumed by the compiled generic L1 cutoff-gradient theorem; keep main-term dominated convergence, Gibbs tail, whole-space IBP, domains, invariance, and Hessian/Laplacian separate. |
| outer cutoff fderiv zero plus PiLp derivative and smulRight trace consumer bridges | None | True | True | True | Prove a generic L1 cutoff-gradient integral limit for the PiLp-wrapped radial cutoff from Integrable G and the compiled C/R bound; separately keep main-term dominated convergence and source-field integrability red. |
| analysis.calculus.radial-smooth-cutoff-fderiv-bound | compiled-strengthened-upstream | True | True | True | Prove that the radial cutoff fderiv vanishes outside radius 2R, then use that support fact and the compiled C/R bound to formulate the smallest integrable cutoff-gradient tail lemma; keep Hessian/Laplacian separate. |
| analysis.calculus.radial-smooth-cutoff-fderiv-bound | next-red-leaf | True |  | True | Prove an operator-norm fderiv bound of order R^-1 for radialSmoothCutoff at positive scale in a finite-dimensional real inner-product space; keep Hessian/Laplacian bounds and dominated tails separate. |

## Next Lower-Agent Split

| role | goal | artifact |
| --- | --- | --- |
| lower-1-textbook-proof-scout | Audit the natural-language proof and exact assumptions for this active route: Prove the Gibbs-specific source-field integrability consumed by the compiled generic L1 cutoff-gradient theorem; keep main-term dominated convergence, Gibbs tail, whole-space IBP, domains, invariance, and Hessian/Laplacian separate. | proof-attempts/<task>/...-textbook-dag.md or a dialogue handoff. |
| lower-2-lean-implementation-worker | Compile the smallest Mathlib-ready leaf on this route, or return one typed blocker: Prove the Gibbs-specific source-field integrability consumed by the compiled generic L1 cutoff-gradient theorem; keep main-term dominated convergence, Gibbs tail, whole-space IBP, domains, invariance, and Hessian/Laplacian separate. | Lean declaration plus typed verifier feedback fields. |
