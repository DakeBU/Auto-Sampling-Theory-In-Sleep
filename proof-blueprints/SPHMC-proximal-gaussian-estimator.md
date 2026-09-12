# Actual parameterized proximal Gaussian estimator

SPHMC arXiv:2609.06906v1 equation (3.2), Algorithm3.1; explicit C2/Hessian source (1.1), normalized beta=1

Construct measurable exact proximal points for arbitrary measurable state-dependent eta and centers, prove equation and unique global argmin; construct the actual gradient-at-prox-plus-Gaussian Markov kernel and prove fiberwise L2 integrability and centered/total second moment bounds.

Normalized beta=1,kappa>=1,genuine C2 Hessian bounds; arbitrary measurable S, measurable eta,y,0<eta<=1/2. Exact proximal oracle; no finite gradient-query implementation, smoothed-score bias, global state-integrated moment, stage W2 accuracy, initialization cost or full paper theorem.

# Actual parameterized proximal Gaussian estimator

Primary source: SPHMC arXiv:2609.06906v1, equation (3.2), Algorithm 3.1; normalized beta=1 and explicit C2/Hessian hypotheses from (1.1), Section 2. Exact proximal oracle, not Appendix D finite gradient implementation.

For arbitrary measurable S, measurable eta:S->R and y:S->E, with 0<eta(s)<=1/2, construct a single measurable p:S->E. Its equation is p(s)+eta(s)*gradient V(p(s))=y(s); it is the unique global minimizer of V(x)+norm(x-y(s))^2/(2 eta(s)). E is finite-dimensional real inner product, with its Borel sigma algebra; V is C2 and has Hessian between kappa^-1 and 1, kappa>=1.

Construct actual g(s,z)=gradient V(p(s)+sqrt(eta(s))*z), prove joint measurability, and return a Markov kernel whose fiber is exactly stdGaussian.map(g(s)). Prove fiberwise squared-norm integrability and E norm(g-grad V(p))^2<=eta*d, E norm(g)^2<=2 norm(grad V(p))^2+2 eta*d.

Independent route/source review by log_depth_source_review accepted this boundary: arbitrary S requires no topology, standard Borel structure or probability law. Uniform contraction factor 1/2 works without uniform lower bound on eta. Banach fixed point uniqueness alone is not the argmin proof. Moments are centered at gradient V(p), not the actual smoothed score. No global state-integrated moment, score bias, stage output W2 accuracy, initialization or query-cost theorem follows automatically.

Reuse search: Samplinglib QuadraticRegularization supplies strong convexity and gradient Lipschitz from genuine Hessian bounds, including r=0. ApproximateInitialGradientMoment private gaussian_square and lipschitz_square_bound supply adaptable Gaussian moment proofs. Scoped TechnicalLemmas Prox/Minim/Resolvent filenames and RGOCalculus/QuadraticRegularization/JointReferenceGradientDescent text searches found no existing actual proximal map. GaussianRGOErrorBudget, GaussianKL, TwoNoiseRGO and NormalizedReferenceCall assume/transport output accuracy and do not construct this oracle.

Pinned Mathlib ContractingWith.fixedPoint, fixedPoint_isFixedPt, fixedPoint_unique, tendsto_iterate_fixedPoint; measurable_of_tendsto_metrizable in MeasureTheory/Constructions/BorelSpace/Metrizable. Construct iterates from common zero, prove parameter measurability by induction, then pass to pointwise limit. Prove argmin from genuine regularized gradient and strong convexity. Optional sharp proximal Lipschitz constant requires strong monotonicity; omit it if it delays the actual consumer.

Actual paper consumer: both random Picard evaluation nodes in Algorithm 3.1. Remaining separate boundaries: identify actual smoothed score, Lemma 4.2 bias, implement Picard/HMC and prove local/global Wp accuracy, then actual M stage bound and its cost. No public theorem or SAU admission yet.

Second independent argmin API review: adapt TerminalReferenceGradientDescent private regularized-gradient proof near line275, without invoking its positive-dimension whole GD contract. HasFDerivAt norm_sq after sub_const, const_mul, then hasGradientAt_iff_hasFDerivAt and HasGradientAt.gradient gives gradF=gradV+eta^-1*(x-y). Fixed point and eta!=0 imply gradF(p)=0. StrongConvexFirstOrder.firstOrder_lower_bound_of_strongConvexOn with grad=gradient F yields F(p)+((kappa^-1+eta^-1)/2)*norm(z-p)^2<=F(z); positive coefficient gives uniqueness. No separate minimizer existence theorem needed. Coordinate-free zero-dimensional extension is mathematically allowed but must be disclosed.

Actual parameterized kernel reuse: TerminalFORSKernel private gaussian_proposal (line160) constructs (Kernel.id x_kernel Kernel.const S stdGaussian).map f; IsMarkovKernel.map and Measure.dirac_prod/map_map identify the exact fiber. Compose f with the actual continuous gradient. This requires only MeasurableSpace S, not a topology or standard Borel instance on S.

## Next actual consumer: Lemma 4.2 score bias

Independent bounded source/dependency audit by log_depth_source_review identified the primary route at https://arxiv.org/html/2609.06906v1#S4.SS1, equation (4.6). With the actual proximal point p, define rho(u)=V(p+sqrt(eta)u)-V(p)-sqrt(eta)<gradient V(p),u> and r=standardGaussian.tilted(-rho). The source comparison is W2(r,gamma)^2 <= 2 KL(r||gamma) <= Fisher(r||gamma) = E_r norm(gradient rho)^2 <= eta^2 E_r norm(U)^2 <= eta^2 d. Both KL and Fisher directions are r relative to gamma. The reference measure is the standard Gaussian, not an arbitrary strong-convexity transport theorem. Gaussian Talagrand and Gaussian LSI are not separately cited in this paragraph; neighboring Brascamp-Lieb references must not be misattributed.

The resulting bias constant is exactly one: norm(b_eta(y)) <= eta^(3/2)*sqrt(d), using eta-Lipschitz gradient rho and the inverse-sqrt(eta) scaling. The current estimator theorem does not establish this bias. Its eta<=1/2 domain is a sufficient construction condition, not a necessary threshold stated specifically for (4.6).

The targeted reuse search did not find the required Gaussian transport-Fisher theorem. FisherTransport is scalar algebra with a supplied KL/Fisher/W2 inequality; GeodesicFisherTransport receives geodesic/first-variation premises. CanonicalFisherTransportPairing proves an actual Cauchy-Schwarz pairing under score-domain and coupling/moment hypotheses, but not W2^2<=Fisher. FunctionalInequalities/LogSobolev is bookkeeping. Pinned Mathlib Probability/MeasureTheory search found no directly usable Gaussian Talagrand/LSI declaration. These are explicit mathematical gaps, not accepted interfaces that can be renamed into bias.

The next dependency-ready actual edge is the standardized RGO law and its position moment: use the proximal equation to identify the affine-normalized true RGO with r, prove normalization and polynomial L1, and establish d=E_r <U,U+gradient rho(U)> >= E_r norm(U)^2 by justified noncompact integration by parts. GibbsGradientMoment supplies a reusable proof method, but its existing gradient-square conclusion is not this position moment. Actual smoothed-score/RGO mean identification and the genuine Gaussian transport-Fisher proof remain separate necessary dependencies. No next SAU or completed result is asserted by this audit.
