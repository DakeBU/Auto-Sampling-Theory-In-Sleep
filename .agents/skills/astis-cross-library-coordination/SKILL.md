# ASTIS Cross-Library Coordination

Use this skill whenever a theorem-sized task in the SampleWiki, Riemannian Optimization, or First-Order Optimization route may touch mathematics that another route could also need.

## Goal

Let the routes advance independently without creating duplicate or incompatible lower-level Lean declarations. Source-facing theorems remain attached to their own source; only genuinely shared mathematical foundations are shared.

## Before creating a declaration

1. Recover the exact target statement, assumptions, domains, conclusion, and source convention.
2. Search Samplinglib and Mathlib first. For optimization work, also search the pinned Optlib and CvxLean upstream surfaces before inventing a new API.
3. Compare semantic theorem fingerprints, not names alone: mathematical objects, quantifiers, assumptions, conclusion, normalization, and intended reuse.
4. Classify the candidate as `reuse`, `adapt`, `missing`, or `out_of_scope`.

## Collision rule

- **Exact shared theorem:** keep one canonical shared declaration. Every route imports or depends on that declaration.
- **Near-equivalent theorem:** factor the genuinely common mathematical core once and keep a small route-specific adapter for convention or source differences.
- **Genuinely different theorem:** keep separate declarations even if the prose names look similar. Do not force a common abstraction merely to reduce file count.
- **Missing shared foundation:** open one canonical shared Frontier Cell. Do not open parallel copies in multiple route folders.
- **Conflicting existing interfaces:** do not overwrite a stable declaration. Isolate the smallest common child theorem or adapter and serialize the shared-file change through stabilization.

When a route discovers an existing declaration that another active route is also rebuilding, stop the duplicate route-local implementation, record the reusable node, and rebase the dependent task on the canonical declaration.

## Verification contract

Every new or adapted shared node follows the normal ASTIS Harness:

`source audit -> search/reuse -> theorem-sized Frontier Cell -> focused compile/test -> independent theorem review -> source-fidelity review when source-facing -> repository root build -> graph/index regeneration -> single stabilization lane -> merge`

A local proof is not a published route milestone until the exact reviewed result has passed the shared verification workflow.

## Shared-floor checkpoints

Treat these as intersection checkpoints, not automatic equivalences:

- Chewi §2.5 Riemannian Manifolds ↔ Boumal geometry foundations.
- Chewi §4.3 convex-optimization proof route ↔ Beck/Optlib convex analysis.
- Chewi Chapter 8 proximal sampler ↔ Beck proximal/composite interfaces and relevant frontier sampling results.
- Chewi Chapter 10 structured sampling ↔ stochastic gradients, coordinate methods, mirror geometry, and corresponding Beck/Optlib/CvxLean interfaces.

At every checkpoint, prove compatibility before reuse. If hypotheses or conventions differ, keep the difference explicit in an adapter.
