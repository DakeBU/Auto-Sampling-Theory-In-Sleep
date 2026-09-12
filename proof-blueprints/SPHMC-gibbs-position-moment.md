# Actual Gibbs position moment

SPHMC arXiv:2609.06906v1 Lemma4.2, equation4.6 final standardized RGO position moment; explicit C2/Hessian source1.1

For the actual volume.tilted(-U), genuine C2 Hessian bounds 0<alpha<=beta and an actual stationary point p, derive probability, position-square and position-gradient pairing L1, exact E< X-p,gradient U(X)>=d, and E||X-p||^2<=d/alpha.

Finite-dimensional real inner product Borel space including dimension zero; explicit genuine Hessian and stationary-point assumptions. Supplies the source standardized-potential position moment; does not yet identify the affine RGO law, prove Gaussian transport-Fisher, score mean identity, estimator bias, Picard accuracy or query cost.

# Next bounded route: actual Gibbs position moment about a stationary point

Planning only; no Lean declaration or SAU admission is asserted here.

Consumer: SPHMC v1 Lemma 4.2, standardized true RGO potential U(u) = ||u||^2/2 + rho(u), where cancellation of the defining linear term supplies gradient U(0)=0; the actual proximal equation is needed for identification with the original RGO. The paper needs E||u||^2 <= d, not beta*d/alpha^2.

Proposed substantive theorem: for actual volume.tilted(-U), genuine C2 Hessian bounds 0<alpha<=beta and a supplied actual stationary point p, derive probability, position-square and position-gradient-pairing integrability, the exact identity E< X-p, gradient U(X)> = d, and E||X-p||^2 <= d/alpha. The stationary point is an explicit input; the already verified actual proximal point supplies it at the consumer. This theorem alone does not identify the standardized RGO law or prove Gaussian transport/Fisher or score bias.

Reuse route avoiding duplicated Gaussian-weight estimates:
1. Reuse public GibbsGradientMoment.gibbs_gradient_moment for the actual probability measure and actual gradient-square L1. Reuse QuadraticRegularization at r=0 and StrongConvexFirstOrder in both directions. With gradient U(p)=0 obtain alpha*||x-p||^2 <= <gradient U(x),x-p>, and hence ||x-p|| <= ||gradient U(x)||/alpha (handle zero norm explicitly).
2. Domination by the already established gradient-square integral proves actual position-square L1. Probability plus square domination proves linear L1. Cauchy/Young gives integrability of coordinate position times coordinate gradient. This is integrability only; the weaker gradient-derived numerical bound is not the final source bound.
3. Reuse StrongConvexGibbsIntegrability for exp(-U) L1. Convert the actual tilted L1 facts to unnormalized volume integrability using integrable_tilted_iff, rather than copy private weighted_square or weighted_gradient.
4. For each unit basis vector v, set f=exp(-U), q(x)=<x-p,v>. Differentiate actual f and linear q. Apply integral_mul_fderiv_eq_neg_fderiv_mul_of_integrable only after its three integrability inputs are proved. This yields integral f*q*<gradient U,v> = integral f.
5. Sum the finite orthonormal basis (empty sum in dimension zero), identify the genuine inner product by basis expansion, and normalize the actual tilt. Obtain E<X-p,gradient U(X)>=d.
6. Integrate the strong-convexity pointwise inequality to get alpha*E||X-p||^2<=d and divide by positive alpha. For the standardized RGO application alpha>=1 gives the paper's d bound with constant1.

Remaining separate proofs: actual affine-standardized RGO equals Gaussian.tilted(-rho); true Gaussian W2^2<=Fisher in the paper's r-relative-to-Gaussian direction; actual smoothed-score/RGO-gradient-mean identity; resulting estimator bias and downstream Picard accuracy/cost.

Independent planning review: log_depth_source_review accepted the route, no circularity, and authorized faithful recording. Use StrongConvexFirstOrder.gradient_inner_lower_bound_of_strongConvexOn directly. Explicitly prove 0<Z<infinity before normalization. This is planning review only, not Lean or formal source admission.
