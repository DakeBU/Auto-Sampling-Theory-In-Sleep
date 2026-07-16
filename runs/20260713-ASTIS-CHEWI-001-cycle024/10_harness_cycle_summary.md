# ASTIS-CHEWI-001 Cycle 24

Run id: `20260713-ASTIS-CHEWI-001-cycle024`

## Textbook Frontier

The active source edge remains Chewi, Chapter 1, Example 1.2.8 to Corollary
1.2.9.  The cutoff branch now has a compiled scale-uniform first-derivative
estimate.  This does not yet prove whole-space weighted integration by parts,
generator-domain semantics, stationarity, invariance, reversibility, or KL/FI
dissipation.

```text
radial support, smoothness, compact support, pointwise exhaustion     [blue]
  -> bounded derivative of the one-dimensional unit cutoff           [blue]
  -> fderiv bound for x |-> ||x|| / R                                 [blue]
  -> one C for all R > 0: ||fderiv chi_R(x)|| <= C / R                [blue]
  -> derivative support outside radius 2R                             [red]
  -> integrable cutoff-gradient tail passage                          [red]
  -> whole-space Gibbs-weighted integration by parts                  [red]
  -> generator/semigroup domain semantics                             [red]
  -> invariant Gibbs law                                              [red]

separate branch:
radial cutoff -> Hessian/Laplacian O(R^-2) for a named consumer       [red]
```

## Hierarchical Agent Decisions

| Role | Decision |
|---|---|
| upper | Keep the Chapter 1 Gibbs-invariance edge active and accept only the first-derivative cutoff package this cycle. |
| middle | Split the package into a scalar derivative bound, a generic norm-scaling bound, and the radial theorem; put the existential constant before the radius quantifier. |
| lower source/API | Port the current SLT proof pattern through ASTIS-owned declarations and adapt two APIs that differ under the local Mathlib version. |
| lower Lean | Compile the three declarations in `Analysis/Calculus/Cutoff.lean` without adding finite-dimensionality to the first-derivative theorem. |
| reviewer | Accept the package under a real inner-product-space norm; reject any claim that arbitrary normed-space norms are genuinely differentiable at the origin, and keep all second-order, tail, IBP, domain, and invariance nodes red. |

## External Reference Audit

- Checkout:
  `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/lean-stat-learning-theory`
- `HEAD == origin/main == 216e578c9576bab6b0abc3ba6c65762536768e96`.
- The checkout has no source edits; only an untracked `.lake/` cache.
- The source pattern is `SLT/GaussianSobolevDense/Cutoff.lean`.
- The ASTIS theorem strengthens the public quantifier order from a
  radius-local existential constant to one constant chosen before every
  positive radius.

## Compiled Lean Progress

Three registered leaves were added:

- `smoothUnitCutoff_deriv_bounded`;
- `fderiv_norm_div_bound`;
- `radialSmoothCutoff_fderiv_bound`.

The final theorem has the public boundary

```lean
exists C : Real, 0 < C /\
  forall R : Real, 0 < R -> forall x : E,
    ||fderiv Real (radialSmoothCutoff R) x|| <= C / R
```

for a real inner-product space `E`.  No finite-dimensionality hypothesis is
needed for this first-derivative estimate.  The registry total is now `250`.

## Documentation And Visuals

- The Chapter 1 ladder now draws `O(R^-1)` first derivative in blue and
  `O(R^-2)` Hessian/Laplacian in red as separate nodes.
- The root README, foundation DAG, status SVG/PNG, roadmap, retrieval index,
  module graph, Cutoff card, and six-hour execution packet were regenerated.
- The module card lists all three new declarations and registry keys.

## Next Exact Red Packet

Prove that `fderiv Real (radialSmoothCutoff R) x = 0` outside the radius-`2R`
ball.  Then combine that support theorem with the compiled `C / R` bound to
state the smallest integrable cutoff-gradient tail lemma needed by the
Chapter 1 whole-space passage.  Keep Hessian/Laplacian estimates separate
unless a named theorem consumer requires them.
