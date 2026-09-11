# Actual clipped-gradient Poisson retry program

For finite-dimensional real inner-product Borel E, differentiable f with beta-Lipschitz actual gradient, beta>=0, eta>0, B>0, fix x0,xp and h=x0-eta gradient f xp. Use actual q=N(h,eta I), nu=Uniform time prod N(0,eta I), W=<actual arc velocity,gradient f xp-gradient f arc>, clipped W=min B(max(-B)W), mB=integral clipped W, and common C from the actual unclipped mean. Prove joint measurability including x, unclipped/clipped/excess L1 for each x, abs(mB)<=B and abs(mB-(<gradient f xp,x>-f x+C))<=integral max(abs W-B,0). Prove exp(-B)<=ZB=integral exp(mB) dq<=exp B, actual iid Poisson(2B) full-batch retry output law=q.tilted mB with explicit never-hit default and null never-hit event, and actual full-batch expected estimator count=2B/p<=2B exp(2B), p=exp(-B)ZB.

Fixed-center actual clipped program and mean truncation error only. No ideal Gibbs normalization/identification, normalized Renyi accuracy, adaptive eta kernel, initialization, or full gradient query accounting. Auxiliary time differs from acceptance uniform. Count includes successful batch; cached reference gradient preparation is separate. Uniform O(1) cost still needs source B=Theta(1) and accuracy parameters. Neither main paper complete.

Route: prove the real clipping identity by ordered cases, L1 domination before integral subtraction, and measurability in all proposal/auxiliary variables. Invoke the actual GradientArcMean public theorem with source h, preserving the common C before x. Bound exp(mB) above and below to obtain the clipped normalizer. Instantiate PoissonRejection on a singleton parameter and constant q kernel; restate the exact first-hit output and full-batch cost definitions definitionally, not an arbitrary output law. Acceptance and cost belong to the same iid attempt law. Independent planning source review accepted this route; no compiled claim yet.

Development checkpoint: complete actual clipped-gradient program compiled in production, focused PASS3722, standard three axioms, no lint. Independent depth reviewer compiled complete scratch050abeb1 and accepted actual program/mean/cost; independent source reviewer accepted full preaudit. Public contract does not separately return potential L1 or RN bound. Formal anonymous reconstruction/source admission, exact-commit verification and reader integration remain open. This is not either paper completion.

Next-consumer planning review (depth_commit_verifier; planning only): prove the
actual unclipped mean tilt equals the positive finite ideal RGO law. Set
G0=N(x0,eta I), g=gradient f xp, h=x0-eta*g, q=N(h,eta I), m=E W. Target
q.tilted(m)=G0.tilted(-f), with exp(m) integrable under q, exp(-f) integrable
under G0, positive finite normalizers and the normalized volume-density form.
Use beta*eta<1, no additional convexity. The source Claim2 clipping condition
implies beta*eta<=1/(8ell)<=1/16, so this does not shrink its step range.

Prove the sharp lower Taylor estimate by actual gradient FTC along x0+t*u:
f(x0+u)>=f(x0)+inner(gradient f x0,u)-(beta/2)*norm(u)^2. The prior mean module's
coarse coefficient beta would not cover the whole beta*eta<1 range. With
kappa=eta^(-1)-beta>0, Young yields
f(x0+u)+norm(u)^2/(2eta)>=f(x0)-norm(gradient f x0)^2/kappa+kappa*norm(u)^2/4.
Use Integrability.integrable_exp_neg_add_mul_norm_sub_sq for the Gaussian
volume envelope, then IsotropicGaussianDensity's public density adapter.
Continuity/positive weights and nonzero measure give positive normalization.

GaussianLikelihood.translated_gaussian_likelihood h x0 eta heta supplies the
actual likelihood L. Its log simplifies to -inner(g,x-x0)-eta*norm(g)^2/2.
The actual parent mean gives L(x)*exp(m(x))=
exp(C+inner(g,x0)-eta*norm(g)^2/2)*exp(-f(x)). Use the true withDensity identity
to transport integrability, compute normalizers and cancel this positive
constant. Measure.isProbabilityMeasure_tilted, integral_exp_pos and
tilted_eq_withDensity_nnreal are reuse candidates. StrongConvexGibbsIntegrability
would require first proving regularized strong convexity; the Hessian adapter
adds C2 and is not the shortest route for the current differentiable/Lipschitz
contract. Later normalized Renyi still needs both directions of normalized
perturbation, uniform-time Jensen and exponential integrability. This plan
creates no additional SAU, theorem or completion claim.
