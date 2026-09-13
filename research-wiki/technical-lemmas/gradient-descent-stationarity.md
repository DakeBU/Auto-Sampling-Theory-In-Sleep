# Gradient descent: accumulated descent and approximate stationarity

Source: Chewi, *Lectures on Optimization*, arXiv:2605.07006v1,
Theorem 3.7 and proof; Section 2 attained-minimum convention; Lemma 3.1.

SAU: `ANDI-OPT-gd-stationarity-001`.
Cells: `ASTIS-SHARED-gradient-descent-sum-sq` and
`ASTIS-SHARED-gradient-descent-stationarity`.
Candidate proof commit: `c592c86` (resolve full SHA from review evidence).

For a complete real Hilbert space, actual gradient update `T(x)=x-h∇f(x)`,
and the global quadratic upper model with `βh≤1`, the new shared module
`Analysis/GradientDescentStationarity.lean` supplies:

- `gradient_descent_sum_sq_bound`: for `h≥0` and any natural `N`,
  `(h/2) Σ_{k<N} ‖∇f(T^k x₀)‖² ≤ f(x₀)-f(T^N x₀)`.
- `exists_gradient_descent_norm_le`: for `h>0`, `N≥1` and a supplied global
  minimizer `z`, some `k<N` satisfies
  `‖∇f(T^k x₀)‖ ≤ sqrt(2(f(x₀)-f(z))/(N*h))`.

The mathematical increment is cumulative dissipation and a nonconvex
best-iterate certificate for actual updates. It does not assume convexity, PL,
a scalar recurrence, or a small-gradient witness. It does not construct the
minimizer, prove last-iterate convergence or global optimality, or close a
companion-paper theorem. The generic stopping consumer in the cell is planned,
not an existing Lean dependency.

## Retrieval and reuse

- Reuse `GradientDescentBasic.gradient_step_descent_of_quadratic_upper_bound`.
  Its production file and existing audits are unchanged.
- Pinned Mathlib `db584cd`: `Finset.mul_sum`, `Finset.sum_le_sum`,
  `Finset.sum_range_sub'`, `Finset.exists_le_of_sum_le`,
  `Real.le_sqrt_of_sq_le` and actual iterate successor identities.
- Existing `GradientDescentPL` needs PL; `GradientDescentValue` uses convexity.
  Neither is the nonconvex stationary-iterate bound.
- SPHMC `TerminalReferenceGradientDescent.gradient_decay` is a private,
  strongly-convex geometric bound with stronger hypotheses. It is not a duplicate
  of the present result and is not modified or used as a parent.
- Scoped pinned Optlib `5da27c5` GD and CvxLean `c62c2f` searches did not locate
  the exact nonconvex bound. This is a bounded retrieval result, not a claim of
  exhaustive absence across formal libraries. No external code is ported.

## Source and regularity boundary

The source's smooth Euclidean problem supplies the upper model. The local proof
consumes that model algebraically on a complete real Hilbert space and uses the
actual, totalized Lean gradient. It makes no claim that notation alone supplies
differentiability. Signed `β` are an explicit model-domain extension; the
reciprocal source restriction agrees with the product restriction when `β>0`.

The printed normalized theorem omits explicit `h>0,N≥1`. The zero-step and empty
range expressions are not valid ordinary normalized bounds. With
`f(t)=t²/2,β=1,z=0,x₀=1,N=1`, steps `h=0` and `h=-1` yield the false Lean-totalized
comparison `1≤0`. The original source, local proposition, semantic mismatch and
independently reviewed source overlay remain distinct in the publication audit.
The unnormalized cumulative theorem legitimately includes `h=0,N=0`.

## Verification and next boundary

Focused test `Tests.Shared.GradientDescentStationarity` passes (2436 jobs),
with only `propext`, `Classical.choice`, `Quot.sound`. Tests instantiate the actual
quadratic gradient, a constant objective with `β=0`, and zero-step accumulation.
Independent proof/source/repair artifacts are stored in
`runs/semantic-roundtrip/andi-opt-gd-stationarity/`.

Conceptual-mirror audit: none-found. Accumulated energy dissipation is already
represented in `family:metric-gradient-flow`; no new cross-space transport or
PL/coercivity implication is asserted by the averaging argument.

Before final admission: finish independent reviews, root imports and Registry,
full canonical gate, source-bound site/graph checks and visual inspection.
Do not repeat the historical missing-root-test mistake: put the new import in
`Tests.lean`'s initial import block, before module documentation.

Next optimization target is selected only after this source boundary is admitted;
Chewi Exercise 3.2 optimal-step contraction is a candidate requiring a fresh
reuse/source audit. The unmerged curvature proposal remains separate.
