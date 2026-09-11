# Ideal RGO normalization and gradient-arc identification

For finite-dimensional real inner-product Borel E, differentiable f with actual beta-Lipschitz gradient, beta>=0, eta>0 and beta*eta<1, fix x0,xp, g=gradient f xp,h=x0-eta*g. Let G0=N(x0,eta I),q=N(h,eta I),nu=Uniform time prod N(0,eta I), and m(x)=integral actual unclipped gradient-arc W under nu with common C from GradientArcMean. Prove exp(-f) integrable under G0 and exp(m) integrable under q, strictly positive real normalizers, and the actual identity q.tilted(m)=G0.tilted(-f). Also prove integrability and strictly positive normalization of exp(-(f(x)+norm(x-x0)^2/(2eta))) under canonical volume, and identify the same law with its normalized volume density. Prove the precise beta/2 lower Taylor bound and Gaussian envelope rather than assume ideal exponential integrability or extra convexity.

Ideal untruncated target identification and actual positive finite normalization only. No clipping approximation/Renyi bound, adaptive kernel, initialization or cost transport. beta*eta<1 includes the source Claim2 permitted range; no C2 or convexity is silently added. Zero dimension and beta0 are valid disclosed extensions. Neither full companion paper complete.

Prove f(x0+u)>=f(x0)+inner(grad f x0,u)-(beta/2)*norm(u)^2. With k=eta^-1-beta>0, Young gives f(x0+u)+norm(u)^2/(2eta)>=f(x0)-norm(grad f x0)^2/k+k*norm(u)^2/4. Actual Gaussian envelope integrability yields ideal volume weight L1. Convert via public isotropic density and a proved translation adapter; positive integrals follow nonzero actual measures. Public translated likelihood q=G0.withDensity L simplifies to log L=-inner(g,x-x0)-eta*norm(g)^2/2. Parent actual mean implies L*exp(m)=exp(C+inner(g,x0)-eta*norm(g)^2/2)*exp(-f). Transfer true integrability, compute positive normalizers, cancel constant and conclude both actual tilted and normalized-volume identities. Do not call private translated-density helpers.

Bounded route refinement while current candidate 895c48b stays frozen.

For the sharp beta/2 lower Taylor estimate, an equivalent first-derivative
barrier proof may be shorter than explicitly integrating the linear remainder:
H(t)=f(x0+t*u)-f(x0)-t*inner(gradient f x0,u)+(beta/2)*t^2*norm(u)^2.
Its derivative is inner(gradient f(x0+t*u)-gradient f x0,u)+beta*t*norm(u)^2.
For t>=0, actual Lipschitz gradient and Cauchy-Schwarz show H'(t)>=0.
Use Mathlib.Analysis.Calculus.Deriv.MeanValue.monotoneOn_of_deriv_nonneg on
Icc(0,1), then H(0)<=H(1). No C2 or convexity premise is introduced; coefficient
beta/2 remains exact, so beta*eta<1 is retained. This is a candidate proof
route, not Lean work or a theorem completion.

Exact checked Mathlib signature:
monotoneOn_of_deriv_nonneg (hD : Convex R D) (hf : ContinuousOn H D)
  (hf' : DifferentiableOn R H (interior D))
  (hn : forall t in interior D, 0 <= deriv H t) : MonotoneOn H D.

True Gaussian density adapters are in
AutoSamplingTheory/TechnicalLemmas/Measure/GaussianLikelihood.lean and
AutoSamplingTheory/TechnicalLemmas/Measure/IsotropicGaussianDensity.lean.
The translated-density helper inside GaussianLikelihood is not public.
Reuse the public likelihood theorem and the public scaled-density theorem;
any needed translation adapter must be proved, not called by a private name.

Development checkpoint: scratcha66ad076d1a28ba3422bfc4dae7e341187803f0edef7e22b17fba703a38a0b5a compiled exit0 session54602, standard3nolint. Exact beta/2 Taylor lower bound uses first-derivative barrier monotonicity; k=1/eta-beta and Young give k/4 envelope; actual volume exponential weight L1 and positive integral proved. Full Gaussian-input normalization and tilted/volume identity remain open. This is not a complete packet or public production admission.
