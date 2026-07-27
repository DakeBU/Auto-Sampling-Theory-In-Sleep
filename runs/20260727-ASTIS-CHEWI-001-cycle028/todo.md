# Next Todo Packet: ASTIS-CHEWI-001 cycle 28

Generated: `2026-07-27 17:42:58`

## Human Default

Use the reviewer-recorded active route: Prove integrability of the concrete Gibbs-weighted scalar Langevin generator display exp(-V) * (Delta f - <grad V, grad f>) under explicit potential and test-function assumptions; keep Gibbs-tail passage, whole-space IBP, domains, invariance, and second-order cutoff estimates separate.

## Mathlib-Ready Leaf Gate

Before assigning lower work, middle must fill the leaf packet shape from
`research-wiki/technical-lemmas/mathlib_ready_leaf_template.md`: theorem,
local APIs, hidden regularity, proof route, and failure policy.  If a proof has
already failed repeatedly, the next action is statement diagnosis, not another
proof-script rewrite.

## Lower 1

Write the natural-language proof route and exact potential/test-function assumptions for concrete Langevin generator-display integrability.  Name the Mathlib APIs and source correspondence before lower 2 edits Lean.

## Lower 2

Implement only the smallest concrete generator-display integrability declaration on the active route, or return one typed blocker.  Do not combine it with Gibbs-tail passage, whole-space IBP, domains, or invariance.

## Open Paper Contribution Obligations

_None._

## Open External Technical Lemma Obligations

| id | status | next action |
| --- | --- | --- |
| SLT/GaussianPoincare/TaylorBound.lean | port-candidate | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianPoincare/Limit.lean | future-port | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/DualityEntropy.lean | future-port | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/TensorizedGLSI.lean | future-port | Port to ASTIS-owned TechnicalLemmas before using. |
