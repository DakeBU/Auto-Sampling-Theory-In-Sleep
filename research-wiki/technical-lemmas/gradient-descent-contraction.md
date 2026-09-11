# Gradient descent: contraction and distance bounds

SAU `ANDI-OPT-gd-contraction-001`; source Chewi arXiv:2605.07006v1,
Theorem3.3 and the following distance-rate paragraph. Baseline main bad36aa;
proof candidate b965caf. This continues the user's optimization lane; the
companion execution/handoff was read, and no companion-paper credit is claimed.

Canonical module: Analysis/GradientDescentContraction. Two declarations:
`gradient_step_contraction` and `gradient_descent_distance_bound`.
For C1 f on a complete real inner-product space, global alpha-strong convexity,
the beta quadratic upper model, alpha,beta,h>=0 and beta*h<=1 give the actual
step T(x)=x-h grad f(x) Lipschitz factor sqrt(1-alpha*h). About a supplied global
minimizer, its Nth iterate has geometric and exponential distance control,
including N=0. Fermat proves stationarity; it is not an extra assumption.

Source boundary: C1/Hilbert and division-free zero-modulus cases are explicit
generalizations. The printed source h<=1/beta omits essential h>=0: f(t)=t²/2,
alpha=beta=1,h=-1 gives T(t)=2t, violating the sqrt2 contraction for distinct
points. Positive beta is the reciprocal domain. The source's stray gradient
before the displacement in its middle proof display is a transcription typo.
No unjustified alpha<=beta hypothesis is imposed on singleton spaces: a negative
coefficient in the proved squared bound forces all pairwise distances zero.
For 0<alpha<=beta and h=1/beta, natural powers of the square root recover the
source kappa=beta/alpha half-exponent formulation. The logarithmic complexity
consequence remains an uncovered obligation; so do function-value rates,
Exercise3.2 optimal step, and constrained/Riemannian/stochastic variants.

Reuse: compiled Samplinglib StrongConvexFirstOrder gradient monotonicity and
ConvexSmoothGradient cocoercivity are the actual two mathematical parents.
Pinned Mathlib db584cd supplies Fermat, LipschitzWith.iterate, fixed-point
iteration, sqrt and exponential order APIs. Pinned Optlib5da27c5's
GradientDescentStronglyConvex.gradient_method_strong_convex uses stronger mixed
interpolation and a larger-step sharper factor; this adjacent route is not a
direct substitute for the requested source proof. A bounded search of pinned CvxLean c62c2f2 found no gradient-descent,
cocoercivity, strong-convexity or contraction declaration. No external Lean
module is imported. Shared-floor classification: adapt_existing. No duplicate GD
production declaration or active target was found in the bounded ownership scan.

Proof route: set v=y-x,d=grad f(y)-grad f(x),p=<d,v>. Parents give
alpha||v||²<=p and ||d||²<=beta*p. Thus h²||d||²<=h*p; expansion yields
||v-h*d||²<=(1-alpha*h)||v||². Take sqrt, apply the Lipschitz iteration to the
Fermat fixed point, and use 1-a<=exp(-a). This is one mathematical mechanism,
not a new conceptual bridge: conceptual-mirror audit none-found; existing
curvature-growth and gap-gradient families already retain the mechanism.

Focused test PASS2449 with standard axioms only. Consumers recover reciprocal
step exponential rate, exact one-step minimizer at equal unit moduli, and the
actual constant objective with zero curvature/smoothness at arbitrary h>=0 and
N. Integration must import Tests.Shared.GradientDescentContraction from
Tests.lean before the full gate. Independent verification, semantic round trip,
source repair and final graph publication are still pending at this checkpoint.

Next bounded candidate: Theorem3.4's distance-plus-function-gap one-step
inequality and scalar weighted summation, after a fresh reuse and ownership
scan. Do not count the current distance theorem as that function-value result.
