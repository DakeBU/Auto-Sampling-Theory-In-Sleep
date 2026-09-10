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
