# Actual unclipped gradient-arc mean

For finite-dimensional real inner-product Borel E, differentiable f with actual beta-Lipschitz gradient, beta>=0 and eta>0, arbitrary h,xp, use the actual arc and velocity with W(r,z,x)=<v_r,gradient f xp-gradient f arc_r>. For P=N(0,eta I) and U=volume restricted to Ioc(0,1), prove integrability of f(h+Z), joint measurability and integrability of W under U.prod P for every x, the fixed x,z time-integral identity <gradient f xp,x-(h+z)>-f(x)+f(h+z), and integral W=<gradient f xp,x>-f(x)+C with C=integral f(h+Z)-<gradient f xp,h> fixed before all x.

Actual unclipped path mean and true auxiliary-input integrability only. No center residual, clipping step, convexity or assumed mean/integrability premise. Source center h=x0-eta gradient f xp, positive finite target normalization, clipped output law, Renyi comparison, initialization and costs remain separate. Neither paper main result complete.

# Next actual gradient-arc mean packet (planning only)

Independent read-only route reviews: depth_commit_verifier and
log_depth_source_review, 2026-09-11. Route reviewed before SAU registration; proof implementation is pending.

Target one substantive packet: finite-dimensional real inner-product Borel E;
differentiable f and actual beta-Lipschitz gradient, beta>=0, eta>0; arbitrary
h,xp. Set P=stdGaussian.map(z -> sqrt(eta) z), U=volume.restrict(Ioc 0 1).
Using the same arc and velocity, W(r,z,x)=<v_r,gradient f xp-gradient f arc_r>.
Prove jointly measurable W, integrability in U.prod P for every x,
integrability of z -> f(h+z), the fixed x,z FTC identity, and
integral W d(U.prod P)=<gradient f xp,x>-f(x)+C for every x, with
C=integral f(h+z) dP - <gradient f xp,h> determined before x.

FTC identity: integral_0^1 W dr =
<gradient f xp,x-(h+z)>-f(x)+f(h+z). Starting point h+z.
Reuse GaussianArcLaw.gaussian_arc_law public conjunction; do not call its
private helpers. Derivative chain uses DifferentiableAt.hasGradientAt,
HasGradientAt.fderiv_apply, HasFDerivAt.comp_hasDerivAt;
intervalIntegral.integral_eq_sub_of_hasDerivAt and integral_of_le bridge U.

Potential integrability need not optimize a coefficient: MeanValue's
norm_image_sub_le_of_norm_deriv_le_segment_01' on h+t*z gives
abs(f(h+z))<=abs(f(h))+norm(gradient f h)*norm(z)+beta*norm(z)^2.
Actual W domination for r in [0,1], A=norm(x-h), D=norm(xp-h):
abs(W)<=pi/2*beta*(A+norm(z))*(D+A+norm(z)). This is a uniform quadratic
majorant. Reuse IsGaussian.integrable_id, IsGaussian.memLp_two_id,
memLp_two_iff_integrable_sq_norm, integral_id_stdGaussian via scaling map,
integrable_prod_iff and integral_prod. No fixed-time-only inference to joint
integrability; prove it before Fubini.

Source: arXiv:2602.01338v1 D.1 before Eq18, consumed SPHMC A.4(2).
No residual, clipping step, B,ell or convexity needed. Zero dimension and beta0
are valid disclosed extensions. A later consumer MUST substitute
h=x0-eta*gradient f xp, complete the Gaussian square and establish positive
finite target normalization, clipped output law and Renyi comparison.
Quadratic potential growth alone does not give arbitrary-eta Gibbs
normalization. No existing source-faithful ASTIS double-sided growth lemma
found by bounded search; ConvexSmoothGradient requires inappropriate extra
convexity or assumes the model and is not a replacement proof here.


Earlier development checkpoint: the actual fixed-path FTC identity compiled in the
registered scratch module with only standard three axioms. The proof extracts
public GaussianArcLaw derivative/endpoints, differentiates the actual potential
along that arc, proves estimator continuity and applies interval FTC. No
production theorem or admission: joint input integrability and common-C mean
remained to be proved at that checkpoint.

Current production checkpoint: the complete actual path mean and auxiliary
input integrability theorem now compiles (focused PASS3648, only the standard
three axioms, no lint). Independent full scratch and fixed production
d5f56d043d2a44b0a928c8fa845f59780f32ce6f reviews accepted the mathematical
proof. The public constant C precedes every x. Three private path definitions
were expanded from the actual compiled type, and independent Meta.isDefEq
replay matched all 3028 characters. Six authored reader steps and explicit
source-domain differences are now bound for a fresh anonymous reconstruction.
Formal source admission, aggregate integration and reader delivery remain
separate; the SAU stays EXPLORING.
