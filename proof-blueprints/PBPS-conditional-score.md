# Next mathematical edge: reflected conditional expectation

The initial route below has now produced the local theorem
`ConditionalScore.reflected_conditional_covariance`; its Frontier Cell and
semantic audit record the current admission state. This plan itself is not
proof or integration evidence.
Independent read-only route advice: `depth_commit_verifier`, after inspecting
the actual reflection-block theorem and its Gibbs-density consumer.

Primary target: arXiv:2609.06905v1 Appendix C.1, the conditional density of
$Y_-$ given $Y_+=y$ and the differentiated conditional expectation for smooth,
compactly supported test functions. This is an input to the gradient–variance
estimate, not a substitute for Lemma B.1.

Start with the already proved conditional kernel for $X\mid Y=y$ and push it
through $x\mapsto 2x-y$. Identify its actual normalized density

$$p_y(u)\propto\exp\left(-V((y+u)/2)-\frac{\|y-u\|^2}{8\eta}\right).$$

For a fixed smooth compactly supported observable $f$, define
$T_f(y)=\int f(u)p_y(u)\,du$. Prove the parameter derivative by differentiating
the numerator and normalizer, including the normalizer's noncompact integral.
The logarithmic unnormalized score is

$$s_y(u)=-\tfrac12\nabla V((y+u)/2)-\frac{y-u}{4\eta}.$$

The resulting gradient should be the actual conditional covariance of $f$ and
$s_y$, with centering from the normalizer derivative. Retain the source C²,
positive lower and finite upper Hessian bounds and positive scale. Derive the
local integrable domination from those assumptions; never accept domination,
interchange of derivative and integral, or the covariance formula as premises
merely to package the paper's conclusion.

Bounded reuse candidates: `GaussianConditionalKernel.exists_tilted_isCondKernel`,
`GibbsAugmentation.normalized_augmentation_density`,
`RGOCalculus.rgo_calculus`, pinned Mathlib
`hasFDerivAt_integral_of_dominated_of_fderiv_le`, and ASTIS
`GradientAlgebra.gradient_div_eq_of_differentiableAt`.
These are candidate interfaces, not evidence that the missing analytic steps
already exist or have compiled.

The genuine downstream consumer is Appendix C.1's conditional variance bound.
Conditional Poincaré constants, the extension from smooth tests to all L²/H¹,
macroscopic coercivity, square-root/inverse operators and the half-turn process
remain distinct proof obligations. Do not count this plan as another theorem
packet or reset the current reflection packet's stabilization work.

## Macroscopic representative and the remaining curvature criterion

`MacroscopicRepresentative.macroscopic_reflection_smooth_representative`
has passed independent source and fixed-commit review, aggregate and local
reader checks, and merged through PR #254. Its Frontier Cell records deployed
delivery separately. It joins the
actual reflected joint disintegration, the actual `PUP` representative and the
everywhere smooth-test derivative using one compatible kernel. This is not a
conditional variance estimate.

An independent bounded dependency audit by `depth_commit_verifier` found no
ready curvature-to-Poincare proof in the searched ASTIS FunctionalInequalities
and pinned Mathlib Gaussian/Convex slices. `Poincare.Satisfies`, `variance_le`
and `Generator.SatisfiesPoincare` are contracts, not curvature criteria. The
missing analytic theorem must derive the inequality with constant `1/m` from
the genuine lower Hessian bound `D2W >= m I`, including its test domain and
extension to noncompact score components. This search does not certify absence
from every library file.

The next dependency-ready source input is the actual conditional potential
`W_y(u) = V((y+u)/2) + norm(y-u)^2/(8 eta)`: prove its Hessian lower bound
`(alpha + eta^(-1))/4`, the score derivative norm bound
`(eta^(-1) - alpha)/4` under `beta*eta <= 1`, and integrability of directional
scores, their centered squares and gradient squares under the actual fiber.
`ConditionalScoreDomain.conditional_curvature_and_score_domain` now supplies
this noncompact input domain in locally compiled production Lean, with an
independent full-source replay. Formal source/commit admission and integration
remain separately tracked in its Frontier Cell. The theorem retains explicit
`alpha <= beta` even in dimension zero, and the score derivative is positive
semidefinite, possibly zero. Arbitrary directions retain their norm factor.
This must not be reported as the Poincare inequality or its variance conclusion. A later
Brascamp--Lieb/weighted Bochner route still needs actual integration by parts,
density or weak-solution arguments; an isolated Bochner identity is insufficient.

## Next dependency audit

The bounded lookup of
`AutoSamplingTheory/TechnicalLemmas/FunctionalInequalities/Poincare.lean`
shows definitions of variance, energy, admissibility and `Satisfies`, together
with nonnegativity and monotonicity. Its own header explicitly states that no
Bakry–Émery criterion, tensorization, localization or sharp constant is proved.
Consequently `Poincare.variance_le` only unpacks a supplied inequality; invoking
it with an assumed `Satisfies` cannot discharge the source's conditional
Poincaré requirement or count as the gradient–variance result.

Before the quantitative consumer, either prove the required curvature-to-
Poincaré theorem in a canonical shared cell or establish another independently
justified route to the exact source bound. Also identify the constructed
reflected kernel with the transformed joint disintegration and the existing
`PUP` representative before claiming an operator/Sobolev theorem. These are
actual missing dependencies; the compiled smooth-test derivative does not
silently provide them.

Independent bounded route advice (`log_depth_source_review`, read-only) selects
the following integration node before the new Poincaré foundation. For the
actual observation marginal $\nu=J_Y$ and reflected pair law
$\Lambda=((x,y)\mapsto(y,2x-y))_\#J$, prove that the constructed $S$
disintegrates $\Lambda$ and $\Lambda_{\rm fst}=\nu$. For every
$f\in C_c^\infty(E)$, construct $g_f=[f\circ\mathrm{snd}]\in L^2(J)$,
prove $Pg_f=g_f$, identify the actual $PUPg_f$ with
$T_f\circ\mathrm{snd}$ almost everywhere, and give $T_f\in L^2(\nu)$
with the existing everywhere classical derivative. The two parent theorems'
existential kernel witnesses require a.e. disintegration uniqueness; they must
not simply be treated as identical. Boundedness under probability supplies
$g_f\in L^2$, although $f\circ\mathrm{snd}$ need not have compact support.

These connected clauses form one proposed substantive integration node; the
isolated pushforward identity alone is not the planned completion boundary.
The optional actual conditional-variance energy identity can follow if ready.
After this bridge, the required curvature-to-Poincaré result must cover the
noncompact score components as well as the smooth compact test class. No new
cell or compiled theorem is asserted by this route advice.
