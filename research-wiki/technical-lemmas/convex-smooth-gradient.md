# C1 convex smooth gradient interfaces

SAU `ANDI-OPT-cocoercivity-001`; base `e2307b21eed782c6a2718e8666ec3ce0bf6207cd`.
The user continued the optimisation lane. Companion execution/handoff was
checked; this shared textbook result is not companion-paper frontier progress.

Source: Chewi, arXiv:2605.07006v1, Exercise3.1 (3.4)–(3.5), using
Definition1.12 and Lemma3.1. Canonical module:
`AutoSamplingTheory/TechnicalLemmas/Analysis/ConvexSmoothGradient.lean`.

- `gradient_gap_sq_le_bregman`: positive beta; squared gradient difference
  bounded by `2 beta` times the ordered Bregman gap.
- `gradient_cocoercive`: nonnegative beta, including zero; division-free
  cocoercivity with coefficient beta.
- `gradient_lipschitz`: nonnegative beta encoded by NNReal; global beta-Lipschitz
  genuine gradient.

All require C1 convex f on the whole complete real inner-product space and the
actual quadratic upper model. Hilbert space is a disclosed source generalization.
The reciprocal source (3.4) has an implicit positive denominator domain; no
claim covers its undefined zero denominator. A positive relaxation and real
limit establish the scaled and Lipschitz zero cases without `inv_zero`.
No constrained-domain, Hessian, Riemannian, SALD or sampler theorem is asserted.

Reuse audit: Samplinglib StrongConvexFirstOrder supplies the actual first-order
support bound at modulus zero. SmoothnessEquivalences is composed in a focused
consumer. QuadraticRegularization only has a stronger C2 sandwich interface.
Pinned Mathlib db584cd6d46c92f209a44c0f1c829460d327499d had no exact interface
in the bounded search. Pinned Optlib5da27c5 Function/Lsmooth.lean
`convex_to_lower` and `lower_to_lipschitz` supply related mathematics under
positive modulus and a different quadratic-shift interface (Lean4.13,
Apache-2.0). No external Lean dependency is imported. Classification:
`adapt_existing`, with independent retrieval review by `smoothness_review`.

Proof route: use d=gradient f y-gradient f x and z=y-d/beta; combine convex
support at x with the upper model from y to z. This is the source tilted-function
descent algebra. Exchange endpoints, add, then pass positive relaxed beta+epsilon
to beta. Cauchy–Schwarz and cancellation of a positive gradient-difference norm
yield Lipschitz. The real right-neighborhood limit is nontrivial.

Conceptual-mirror audit: none-found. Existing gap-gradient and curvature-growth
families already retain the recurring convex-gradient mechanism. No new
cross-domain bridge or formal transport is inferred.

Independent `smoothness_review` checked frozen
`04ad482f3bf397c1d5fe40e8ced7772f4315f0b2`; focused build PASS2728, no warnings
or fake closures, standard axioms only. Four consumers cover reciprocal source
form, previous single-sided interface composition, zero-modulus gradient
constancy and nonexpansive gradient step. `coco_blind` reconstructed three
anonymous packets; independent `coco_source` accepted scoped source support:
implicit-assumption-exposed for (3.4), domain-mismatch for the Hilbert
cocoercivity/Lipschitz generalizations. No pinned-source repair was proposed.
Exact source, packets and result hashes live in the existing semantic registry.
Publication42items and semantic54audits validate. Root records the independent
recommendation with attribution; root is not the verifier.

Only the designated integration lane adds Analysis and Tests root imports,
three Registry entries (405→408), and the count check. Every new test must be
reachable from Tests.lean; a focused-only test is not CI coverage.
Reader lessons are authored once in convex-smooth-gradient.json; Exercise3.1
source binding is in optimisation.json. Global gate and rendered graph admission
remain required before actual main integration.

Next bounded candidate: a source-pinned gradient-descent convergence edge using
these interfaces, after a fresh reuse/ownership audit. Nonexpansive gradient-step
algebra already exists in the focused test and must not be reproved blindly.
