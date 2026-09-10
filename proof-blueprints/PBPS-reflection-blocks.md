# Actual reflection and conditional projection blocks

Planning only. No new SAU or Lean result is admitted by this document.
Independent read-only route reviewer `log_depth_source_review` recommended
this dependency-ready successor while the logarithmic-depth packet stabilizes.

Source: arXiv:2609.06905v1 Appendix B.1, (B.1)–(B.5).
Candidate public consumer: `ProximalBPS.ReflectionL2.actual_reflection_block_identities`.
The primary target is the actual augmented law, not an assumed unitary or
an assumed abstract projection.

For the generative Gaussian augmentation J of an arbitrary probability μ on a
finite-dimensional real inner-product Borel space and η>0, let H=L²(J;ℝ).
Define U by pullback along (x,y)↦(x,2x−y), P by conditional expectation onto
σ(Y), Q=I−P, and A=PUP, B=QUP, D=QUQ. Prove the actual U is an isometric
self-adjoint involution, then the whole-space identities

\[
B^*B=P-A^2,\qquad B^*D=-AB^*,\qquad
Pf=f\Longrightarrow\|Bf\|^2=\|f\|^2-\|Af\|^2.
\]

The first right-hand side is P−A² on all H, not I−A². Identity occurs only
after restriction to the macroscopic subspace. The first block subscript in
the source denotes output space, the second denotes input space.

To make this a substantive actual-operator packet, also identify P using the
existing conditional kernel R:

\[
(Pf)(x,y)=\int f(x',y)R_y(dx')\quad J\text{-almost everywhere}.
\]

Do not silently strengthen this representative-dependent formula to every y.
For arbitrary L² classes, use almost-everywhere integrability and equality.
Instantiate the same law with `GibbsAugmentation.normalized_augmentation_density`
in a genuine Gibbs consumer, retaining its curvature/regularity/scale premises.

## Existing inputs and bounded retrieval

- `GaussianReflection.reflection_preserves_augmentation` supplies the state
  involution and map equality. Prove the map measurable to form MeasurePreserving.
- `GaussianConditionalKernel.exists_tilted_isCondKernel` supplies
  `(J.map Prod.swap).IsCondKernel R` and the normalized quadratic-tilt formula.
  The actual module is `TechnicalLemmas/Probability/GaussianConditionalKernel.lean`.
- Mathlib `Lp.compMeasurePreservingₗᵢ`, `compMeasurePreserving_comp_apply` and
  `compMeasurePreserving_id_apply` construct the actual U and its involution.
  Pullbacks compose in reverse order.
- `condExpL2` lands in `lpMeas`, requiring its subspace inclusion to obtain
  P:H→L H. `inner_condExpL2_left_eq_right` and
  `Submodule.isIdempotentElem_starProjection` expose its projection structure.
- Candidate conditional-kernel adapter chain:
  `MemLp.condExpL2_ae_eq_condExp`,
  `condExp_prod_ae_eq_integral_condDistrib'`,
  `eq_condKernel_of_measure_eq_compProd`. Coordinate swap and almost-everywhere
  kernel uniqueness are real obligations, not compilation-verified yet.
- `ContinuousLinearMap.adjoint_comp` supports block algebra. Any separate
  generic helper must justify reuse instead of generating wrapper declarations.

The augmentation layer needs no curvature, finite moment or βη≤1 assumption
for these algebraic identities. Those are not discarded from downstream source
claims; the Gibbs instance and later quantitative coercivity have their own domains.

This route is currently closer than terminal FORS: the latter has a proved
parameter entrance but still lacks algorithm/output-law semantics, reference-point
and localized-scale analysis, divergence control and actual-input expected work.
The reflection packet does not prove macro coercivity, Sobolev regularity,
operator square roots/inverses, half-turn construction, event-process invariance
or nonexplosion, modified-energy contraction, mixing time, or either main paper.
