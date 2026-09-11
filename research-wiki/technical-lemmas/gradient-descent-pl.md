# Actual gradient descent under PL

SAU `ANDI-OPT-gd-pl-001`; baseline `25e2670d736a381123408023181e3b70a9a945ce`.
This is shared optimization textbook work, not companion-paper progress.

## Source and exact boundary

Chewi [arXiv:2605.07006v1](https://arxiv.org/html/2605.07006v1#S3),
Lemma3.1 and Theorem3.6; Section2 opening assumes a minimizer, and Definition2.5
uses `2α(f(x)−f(x★)) ≤ ‖∇f(x)‖²`, α>0. Section3 assumes C² Euclidean objectives.
The printed step restriction omits h≥0. For f(t)=t²/2, α=β=1,h=−1,x₀=1,N=1,
the claimed PL bound would be 2≤1. A separate exact-proposal repair review is
required; adding only h≥0 does not redefine the pinned source.

The local theorem supplies a genuine global minimizer z and global quadratic
upper/PL models using the actual (totalized) gradient on a complete real
inner-product space. No separate differentiability premise is needed for this
algebraic implication. Signed α,β are disclosed generalizations. The ordinary
geometric-decay interpretation requires α>0,h>0 and q=1−αh∈[0,1).
No convexity, arbitrary oracle, supplied scalar recurrence, or optimizer
existence conclusion is introduced.

## Shared-first retrieval and proof

- Samplinglib's existing private `GradientDescentValue.step_descent` is the exact
  reusable algebra. Extracted once as
  `GradientDescentBasic.gradient_step_descent_of_quadratic_upper_bound`.
  Both original public value theorems now call it; their statement bytes are
  unchanged. Public exposure is not counted as new mathematical discovery.
- Pinned Mathlib `db584cd6d46c92f209a44c0f1c829460d327499d`: `le_geom` is the
  existing homogeneous recurrence bound, with nonnegative coefficient and no
  sign assumption on u. `Function.iterate_succ_apply'` links real iterates.
- Pinned Optlib `5da27c5f95aa6a8a45b8c14b968ade4c13ff18c3`:
  `Optlib/Algorithm/GD/GradientDescent.lean:133`, `convex_lipschitz`, needs
  positive step and positive Lipschitz-gradient modulus; despite its name it
  does not need convexity. It is adjacent prior mathematics, not the exact
  one-sided upper-model/h=0 interface. No code copied or upstream build claimed.
- Pinned CvxLean `c62c2f292c6420f31a12e738ebebdfed50f6f840`, and scoped
  Samplinglib/Mathlib searches: no existing exact PL iterate-rate theorem found.

For T(x)=x−h∇f(x), G(x)=f(x)−f(z), q=1−αh:

1. The canonical descent estimate gives G(Tx)≤G(x)−h‖∇f(x)‖²/2.
2. Multiply the PL inequality by h/2≥0: G(Tx)≤qG(x).
3. If q≥0, apply Mathlib `le_geom` to G(Tⁿx₀).
4. If q<0, 0≤G(Tx)≤qG(x) and G(x)≥0 imply G(x)=0 for every x.
   This closes every N without multiplying inequalities by a negative q.

Thus `GradientDescentPL.gradient_descent_pl_value_bound` proves
`G(T^N x₀) ≤ q^N G(x₀)` for every N, with h≥0,βh≤1. No αh≤1 restriction
is added. Constant functions explain why α≤β cannot simply be inferred from PL.
At h=0 or N=0 the bound is equality; at q=0 every positive-time gap is zero.

## Verification and publication

Proof candidate `16dcffe`; focused tests pass2477 jobs without warnings, standard
Lean axioms only. The concrete quadratic test supplies its actual derivative,
upper model, global minimum and PL inequality for every h∈[0,1], including
h=0 and q=0. A constant-objective test supplies q<0. Existing GDValue tests
compile through the extracted helper.

Fresh decoder `pl_blind` sees only anonymous packets. Source reviewer
`coco_source` rechecks all four current public declarations and whole modules;
old decoder reconstruction is reused only because the two old statements and
minimal definition contexts are byte-identical. Old module/source acceptance is
not reused. Separate exact-proposal repair and proof reviews are required.
Artifacts: `runs/semantic-roundtrip/andi-opt-gd-pl/`.
Aggregate gate, root Tests import, Registry and graph publication remain pending
until serialized stabilization.

Conceptual-mirror audit: none-found. Existing gap-gradient/metric-gradient-flow
families already retain descent-plus-coercivity-to-scalar-decay. This work adds
no new cross-domain transport certificate or solid conceptual Lean edge.

Next substantive consumer: smooth nonconvex gradient-norm bound, Chewi
Theorem3.7, reusing this same canonical descent and existing finite-sum APIs.
Do not count re-exposing old normalized tests as a new mathematical advance.
