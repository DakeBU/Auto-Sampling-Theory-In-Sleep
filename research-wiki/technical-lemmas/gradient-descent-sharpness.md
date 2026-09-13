# Constant-step distance sharpness via an actual quadratic witness

Source: Chewi arXiv:2605.07006v1 Exercises3.2-3.3, Section3.
SAU `ANDI-OPT-gd-sharpness-001`; cell
`ASTIS-SHARED-gradient-descent-sharpness`.
Declaration `Analysis.GradientDescentSharpness.exists_quadratic_worst_case` in
`AutoSamplingTheory/TechnicalLemmas/Analysis/GradientDescentSharpness.lean`.

For 0<α≤β and each real fixed h, choose μ∈{α,β} attaining
M_h=max(|1−hα|,|1−hβ|). The actual f(x)=μx²/2 is C², α-strongly convex,
satisfies the global β upper model using its true gradient, and is minimized at0.
The theorem proves all these certificates. For every natural N, starting at1:

- ‖T_h^N(1)‖=M_h^N≥q^N, where q=(β−α)/(α+β).
- ‖T_(2/(α+β))^N(1)‖=q^N on the same constructed objective.

The witness depends on h, not N. Its α,β are valid class bounds, not both tight
constants: its intrinsic scalar condition number is1. No fixed matrix with both
extremal eigenvalues is constructed. This is a class-level fixed-step distance
obstruction, not a lower bound for adaptive/variable steps, accelerated methods
or all first-order algorithms. Full Section3 sharpness remains uncovered.

## Reuse and proof route

1. Compare endpoint magnitudes to choose μ.
2. Differentiate the actual scalar polynomial. Subtract μ‖x‖²/2 to identify
   μ-strong convexity, then lower its modulus with Mathlib StrongConvexOn.mono.
   The exact quadratic remainder gives the upper model; μ>0 gives the minimizer.
3. Instantiate compiled QuadraticGradientDescent.quadratic_eigenmode with μI
   and initial point1. Its norm gives M_h^N without a supplied recurrence.
4. Apply compiled GradientDescentOptimalStep.optimal_gradient_step to the
   certified objective, obtaining q≤M_h; monotonicity of powers gives q^N≤M_h^N.
5. The balanced endpoint scalars are q and−q; the exact norm formula gives q^N.

Samplinglib's parents supply the two component formulas but not this admissible
witness. Pinned Mathlib db584cd6d46c92f209a44c0f1c829460d327499d supplies
strongConvexOn_iff_convex, StrongConvexOn.mono, HasDerivAt.hasGradientAt and
pow_le_pow_left₀. Optlib5da27c5 has GD interpolation and upper-rate theorems;
CvxLean c62c2f has spectral algebra. The independent bounded search found no
matching parameterized attained lower witness; no external code was copied.
Lean4.33.0. Canonical full source audit will be retained in the round-trip folder.

## Verification and integration notes

Focused Tests.Shared.GradientDescentSharpness PASS2871, standard axioms only.
Tests retain a genuine common witness for negative h (growth4^N versus balanced
2^(-N)), zero h (distance1), and α=β=2 (N=0 distance1, positive iterations0).
Production and tests compiled; independent review and aggregate admission pending.
Root Tests import, Registry, full ASTIS gate, reader and graph inspection pending.

Conceptual-mirror audit: none-found. This is attainment within the existing
Euclidean quadratic gradient mechanism, not a new cross-domain transport.
No graph-family or companion-paper completion claim follows.

Next boundary after admission: select another precise Exercise3.3 comparison
with its exact source assumptions (for example objective-gap estimates), or a
source polynomial-method consumer, after a fresh dependency/reuse audit. Do not
repeat the exact trajectory or fixed-step distance-witness targets.
