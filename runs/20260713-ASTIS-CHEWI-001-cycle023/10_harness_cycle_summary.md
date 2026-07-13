# ASTIS-CHEWI-001 Cycle 23

Run id: `20260713-ASTIS-CHEWI-001-cycle023`

## Textbook Frontier

The active source edge is Chewi, Chapter 1, Example 1.2.8 -> Corollary 1.2.9.
Example 1.2.8 uses a whole-space integration-by-parts equality to identify the
adjoint Langevin generator, then Corollary 1.2.9 identifies the Gibbs density
proportional to `exp(-V)` as stationary.  Section 1.2 separately warns that
generator domains and symmetric/self-adjoint distinctions are omitted.

The exact dependency retained by the reviewer is:

```text
finite-box divergence and zero-face cancellation                 [blue]
  -> compact-in-open / inner-box plateau                         [blue]
  -> positive-scale radial compact-support exhaustion base       [blue]
  -> O(R^-1) fderiv and O(R^-2) Hessian/Laplacian estimates       [red]
  -> integrable domination and Gibbs-tail passage                 [red]
  -> whole-space Gibbs-weighted integration by parts              [red]
  -> generator/semigroup domain semantics                         [red]
  -> invariant Gibbs law                                          [red]
```

## Hierarchical Agent Decisions

| Role | Decision |
|---|---|
| upper | Keep Chapter 1 Example 1.2.8 as the active textbook edge; do not drift to a downstream sampler theorem. |
| source/math | The textbook explicitly sketches the analysis and points to Steele, Pavliotis, Le Gall, Bakry-Gentil-Ledoux, and van Handel for detailed foundations. |
| middle | Use a generic compact-in-open plateau theorem and a separate radial exhaustion family so later chapters can reuse both nodes. |
| lower Lean | Port only the audited radial cutoff base and prove a general plateau with Mathlib compactness/bump/smooth-transition APIs. |
| reviewer | PASS the support, smoothness, compactness, range, plateau, and pointwise-exhaustion leaves; keep all derivative, tail, whole-space IBP, and invariance claims red. |

## External Reference Audit

- Checkout:
  `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/lean-stat-learning-theory`
- `HEAD == origin/main == 216e578c9576bab6b0abc3ba6c65762536768e96`
  after `git fetch --prune origin` on 2026-07-13.
- The checkout has no source edits; only an untracked `.lake/` cache.
- Full external `lake build` passed at this commit with 8630 jobs.
- Ported proof surface:
  `SLT/GaussianSobolevDense/Defs.lean` radial support/compactness/exhaustion
  base, rewritten as ASTIS-owned declarations.
- Still only a reference/port target:
  `SLT/GaussianSobolevDense/Cutoff.lean` derivative estimates and dominated
  cutoff convergence.

## Compiled Lean Progress

New module:
`AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Cutoff.lean`.

It contributes 14 registered theorem leaves:

- unit cutoff formula, smoothness, inner-one, outer-zero, and range;
- radial inner-one, outer-zero, range, smoothness, support, topological support,
  compact support, and pointwise convergence to one;
- a generic smooth compactly supported `[0,1]` plateau equal to one on a compact
  subset of an open finite-dimensional real normed space.

`Analysis/Calculus/Divergence.lean` contributes one additional registered leaf:
the generic plateau specialized to an inner closed finite Pi-box inside a
strictly larger open finite Pi-box.

Registry total: `247` compiled local technical leaves.

## Typed Verification History

1. A direct first compile of `Divergence.lean` failed only because the new
   `Cutoff.olean` had not yet been built.
2. The first `Tests` build exposed three integration issues: recursive reduction
   of the enlarged registry count, an unavailable `𝓝` notation in the smoke
   test context, and a qualified-name line break.  They were fixed with
   `native_decide`, `nhds`, and a corrected qualified name.
3. The focused Cutoff/Divergence build and `lake build Tests` then passed.

## Documentation And Visuals

- Added `Cutoff` to the public calculus import and generated module graph.
- Added an independent module card for the 14 cutoff leaves.
- Reworked the generated Chapter 1 tree to show plateau/radial bases in blue and
  derivative/tail/IBP/domain/invariance nodes in red.
- Fixed the generated blue/red status SVG height and spacing so no node is
  clipped.
- Added the exact Example 1.2.8 -> Corollary 1.2.9 source contract and Chapter 1
  cited-textbook audit.

## Next Exact Red Packet

Prove the first scale-uniform derivative package for
`radialSmoothCutoff R` under the explicit finite-dimensional real inner-product
space and `0 < R` assumptions.  The first target is an operator-norm `fderiv`
bound of order `R^-1`; the Hessian/Laplacian `R^-2` package remains a separate
leaf unless the proof naturally shares a stable local API.

This cycle does not claim whole-space weighted integration by parts, generator
domains, semigroup invariance, reversibility, or KL/FI dissipation.
