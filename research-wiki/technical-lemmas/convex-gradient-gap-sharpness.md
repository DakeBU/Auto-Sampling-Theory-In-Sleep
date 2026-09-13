# Convex gradient-descent gap order sharpness

Source: Chewi arXiv:2605.07006v1 Exercise3.3 testing Theorem3.4, Section3.
SAU `ANDI-OPT-convex-gap-sharpness-001`, cell
`ASTIS-SHARED-convex-gradient-gap-sharpness`.

For beta>0 and each natural N, set D=N+1, mu=beta/(2D), f_N(x)=mu*x²/2.
Prove C2, positive strong convexity mu, global beta upper model and minimizer0.
Actual GD step1/beta from1 has gap beta/(4D)*(1-1/(2D))^(2N)>=beta/(16D).
Bernoulli gives q^N>=1+N(q-1)=(D+1)/(2D)>=1/2, then square and multiply.
For N>=1 the lower bound is at least beta/(32N), matching the source beta/(2N)
upper rate in order. The Lean theorem states the finite N+1 bound.

Quantifiers: forall N construct f_N. Curvature shrinks with N. Beta is a class
upper bound, not the tight smoothness constant. No one fixed strongly convex
quadratic is claimed to have a reciprocal asymptotic tail. The constant1/16 is
an authored convenient bound, not an optimal or source-printed constant. N0
retains actual gap beta/4; no singular1/N upper formula is interpreted.
Only step1/beta, initial distance1; no adaptive or general oracle lower bound,
all-section sharpness, acceleration or companion-paper completion.

## Reuse and diagnosis

Reuse GradientDescentSharpness.exists_quadratic_worst_case at equal endpoints
mu to obtain the exact objective, its certificates and true gradient norm.
Use Mathlib one_add_mul_sub_le_pow, abs_mul_abs_self and pow_mul. Same-witness test
composes GradientDescentValue.gradient_descent_weighted_value_bound; the upper
rate is a test consumer, not a fabricated production dependency.
Independent bounded source/reuse audit in
runs/semantic-roundtrip/andi-opt-convex-gap-sharpness/upstream-review.json.
Mathlib db584cd6d46c92f209a44c0f1c829460d327499d; Lean4.33.0.

Compiler diagnosis: local function abbreviations must be aligned before
nonlinear arithmetic; squaring via explicit multiplication avoids overloaded square normalization.
In the consumer test, clear only the outer scalar denominator rather than
rewriting inside the actual gradient function.
These are representation issues, with no mathematical assumption change.

## Verification and integration notes

Focused compilation PASS2875; same-witness upper/lower sandwich and zero/one
horizon tests, standard axioms only. Frozen independent proof/source review, root imports,
Registry, aggregate gate and reader/graph inspection pending.
Conceptual-mirror audit: none-found; horizon choice plus elementary scalar
Bernoulli within the existing quadratic GD mechanism, no new transport family.

Next boundary: audit remaining Section3 comparisons or Section5 polynomial
consumer; do not repeat scalar trajectories or this horizon-dependent witness.
