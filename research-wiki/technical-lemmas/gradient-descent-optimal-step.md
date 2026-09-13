# Optimal gradient step from the curvature interval

Source: Chewi, *Lectures on Optimization*, arXiv:2605.07006v1 Exercise3.2,
with the Section3 C² convention and the earlier convexity/smoothness equivalences.
SAU: `ANDI-OPT-gd-optimal-step-001`.
Cells: `ASTIS-SHARED-gradient-step-endpoint-bound` and
`ASTIS-SHARED-gradient-descent-optimal-step`.
Frozen proof/lesson candidate: `81eec4b2ced5d8cd3d13a33e21a852ec7783f265`.

For a C² objective on a complete real Hilbert space, global α-strong convexity
and the β quadratic upper model in the actual gradient, the module
`Analysis/GradientDescentOptimalStep.lean` supplies:

- `gradient_step_endpoint_bound`: for h≥0,
  `‖T_h(y)-T_h(x)‖ ≤ max(|1-hα|,|1-hβ|) ‖y-x‖`, where `T_h=id-h∇f`.
  The moduli may be signed; both actual global curvature models are premises.
- `optimal_gradient_step`: for 0≤α≤β and β>0, h★=2/(α+β) gives
  factor q=(β−α)/(α+β), and q≤max(|1-hα|,|1-hβ|) for every real h.

The optimality is of the uniform endpoint envelope. It is not an assertion of
the best actual Lipschitz factor for each particular objective, an oracle lower
bound, or a convergence theorem for iterates. No minimizer is assumed or found.
For α>0, q=(κ−1)/(κ+1)<1 with κ=β/α. α=0 is a nonexpansive extension (κ undefined);
α=β>0 gives a constant update map. α≤β is explicit even in the zero space.

## Reuse and proof route

Existing `GradientDescentContraction` only handles βh≤1 and gives the weaker
square-root factor; it does not cover the balanced step in general. Existing
`ConvexSmoothGradient` and pinned Optlib `Strong_convex_Lipschitz_smooth` provide
an alternative C¹ shifted-cocoercivity route, not the source Hessian/FTC route.
The independent scoped Optlib/CvxLean audit found no exact pairwise update-map
Hessian bound. No external code is copied, and no exhaustive absence is claimed.

The proof reuses `StrongConvexFirstOrder.gradient_inner_lower_bound_of_strongConvexOn`,
`ConvexityC2.gradient_mono_iff_fderiv2_lower` and
`SmoothnessEquivalences.upper_model_iff_fderiv2_upper`. The actual Riesz Hessian
operator is symmetric by C²; the derivative of T_h is I−hH. Mathlib's
`ContinuousLinearMap.norm_eq_iSup_rayleighQuotient` bounds its norm by M_h.
The Rayleigh interval argument concerns nonzero vectors; the zero-vector quotient
is assigned zero. A continuous vector derivative along the segment is integrated
with `intervalIntegral.integral_eq_sub_of_hasDerivAt` and bounded by
`intervalIntegral.norm_integral_le_of_norm_le_const`. C² supplies symmetry and
integrability rather than adding hidden assumptions or an arbitrary Hessian field.
Finally β(1-hα)+α(hβ-1)=β-α proves the envelope lower bound algebraically.

Pinned Mathlib: `db584cd6d46c92f209a44c0f1c829460d327499d`, Lean4.33.0.
The existing quadratic-regularization Riesz construction is an implementation
pattern only; that module and its audits are unchanged.

## Verification and remaining boundary

Focused production and `Tests.Shared.GradientDescentOptimalStep` pass (2869 jobs),
using only propext, Classical.choice, Quot.sound. Actual unit quadratic tests
exercise arbitrary nonnegative steps, equal moduli, and α=1,β=3; the constant
objective tests α=0 with β=1. The root Tests.lean and Analysis.lean imports are integrated before the module documentation.
Independent source-blind decoder: `gdo_blind`; proof verifier: `optimal_route_audit`;
source reviewer: `gdo_source`. Independent source/proof admission passed; full aggregate checks are pending.
Artifacts belong in `runs/semantic-roundtrip/andi-opt-gd-optimal-step/`.

Conceptual-mirror audit: none-found. The existing curvature-growth and metric-
gradient families already retain curvature controls; balancing the two scalar
endpoints adds no new cross-domain transport. No graph-family update is justified.
The cell's generic contractive-gradient-map consumer is explicitly planned, not
an existing Lean dependency. This is textbook optimisation, not companion-paper
completion. A subsequent candidate should be selected from the live source/DAG;
no additional theorem is claimed in this cycle.

## Integration notes

Independent source and proof admission accepted, with disclosed domain-mismatch
(Hilbert/parameter extensions) and no repair proposal. Root imports and Registry
entries are integrated (418 local leaves). Full gate, generated branch checks and
reader visual inspection remain pending.
