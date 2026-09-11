# Gradient descent: comparator energy and weighted values

SAU: `ANDI-OPT-gd-value-001`; baseline `38f7c55b21bb71d051f1c0bbad192b0a58117531`.
Source: [Chewi arXiv:2605.07006v1 §3](https://arxiv.org/html/2605.07006v1#S3), Theorem3.4 (3.1),(3.3), Lemma3.1 and weighted calculation following Lemma3.5.
This is user-directed shared optimization textbook work, not companion-paper progress.

## Exact delta and retrieval

Two public declarations in `Analysis.GradientDescentValue`: `gradient_step_energy_bound` and `gradient_descent_weighted_value_bound`. The former is the arbitrary-comparator distance/function energy inequality. The latter applies it to actual iterates and gives
`2h (Σ k<N q^k) (f(T^N x0)-f(z)) ≤ q^N ||x0-z||²`, with `q=1-alpha*h≥0`.
The comparator gap may be negative; no minimizer is assumed. Private `step_descent` is an implementation of source Lemma3.1, reviewed with the whole production file, not a separate credited leaf.

Search before implementation: ASTIS existing strong first-order support and gradient modules/frontier cells; pinned Mathlib db584cd6 `discrete_gronwall_prod_general`, `geom_sum_mul_neg`, finite sums and actual iteration; Optlib 5da27c5 `point_descent_for_convex` and `gradient_method` in GradientDescent.lean (existing alpha=0 estimates, Lean4.13, Apache2); pinned CvxLean c62c2f bounded search found no matching API. Classification `adapt_existing`. No external implementation imported or copied. Independent source/reuse review: smoothness_review, `/private/tmp/andi-gd-value-source-plan.md`.

The recurrence reuses Mathlib's signed-forcing product form. Its exponential Gronwall theorem requires nonnegative forcing and cannot be substituted. First-order support is the existing local StrongConvexFirstOrder theorem. No generic recurrence wrapper was introduced.

## Domains and source fidelity

Global C1 on a complete real Hilbert space extends the source C2 Euclidean setting. Signed curvature parameters are permitted by the two explicit model hypotheses; the source uses nonnegative moduli. The step is explicitly nonnegative, with division-free beta*h≤1. The weighted adapter exposes alpha*h≤1; no negative-weight comparison occurs. Source A>0 is extended to q=0 by the product recurrence.

The source printed h≤1/beta alone is insufficient: f(t)=t²/2, alpha=0,beta=1,x=0,z=1,h=-1 gives energy left2>right1. This missing nonnegative-step domain requires independently reviewed source-gap handling. h=0,N=0,q=0,q=1 are valid division-free cases, not totalized reciprocal formulas. Tests derive the convex 1/(2Nh) rate, the positive-alpha form alpha*q^N/[2(1-q^N)] with strictly positive denominator, and one-step function optimality at q=0 with a supplied actual minimizer. The exact inverse-power identity and published normalized rates remain separate uncovered obligations; do not mark all of Theorem3.4 complete.

## Conceptual-mirror audit

`none-found`: the existing curvature-growth / gap-gradient families already retain the curvature-to-discrete-energy mechanism. This SAU adds compiled Euclidean/Hilbert edges, not a new cross-domain transport or a certified equivalence.

## Validation and integration

Focused target: `lake build Tests.Shared.GradientDescentValue`. Independent review, source-blind decoding, source review, publication validation, root Tests import, full gate and graph/site validation are required before integration. Keep the existing Tests.lean coverage lesson: adding a test file alone does not add CI coverage.
