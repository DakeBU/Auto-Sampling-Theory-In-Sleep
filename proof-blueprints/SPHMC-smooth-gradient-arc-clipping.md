# Actual smooth gradient-arc clipping excess

For finite-dimensional real Hilbert E with d>0, eta,beta,B>0, ell>=2, differentiable f with actual beta-Lipschitz gradient and norm(h-xp)<=sqrt(d eta), suppose 1/eta^2>=64 beta^2(ell*d/B+ell^2). For the actual same independent Gaussian input and gradient arc estimator W_r, tau_B(w)=max(abs(w)-B,0), prove measurability and integrability of exp(2ell*tau_B(W_r))-1 and its expectation<=2 exp(-min(B^2/(40 beta^2 d eta^2),B/(8 beta eta))). All real r is a disclosed extension of source [0,1].

Actual smooth estimator clipping-excess moment only. Actual source center construction, target log-weight mean, normalized Renyi error, initialization and terminal query cost remain separate. No assumed MGF, surrogate estimator or full sampler completion.

Independent route review: write A=beta^2*d*eta^2 and lambda=min(1/(4 beta eta),B/(20 A)). Source condition yields2ell<=lambda; its first cap implies12beta^2eta^2lambda^2<=3/4<=1. The second cap gives10A lambda^2-B lambda<=-B lambda/2, and B lambda/2 is the displayed minimum. Pointwise split abs(w)<=B versus B<abs(w) proves0<=exp(2ell max(abs(w)-B,0))-1<=exp(-lambda B)*exp(lambda abs(w)). Apply the actual parent MGF as a proved integrable majorant before comparing integrals. No repeated Gaussian integration or Fubini.

The complete production theorem and focused test now compile (3121 jobs,
standard three axioms, no lint). Independent full scratch compilation and
development review accepted the actual parent call, exact same W and input
law, source parameter algebra and integrability order. The exported statement
expands both private path definitions and passes Meta.isDefEq, with no omitted
proof terms. Source preaudit, authored publication, fresh anonymous decoder
and formal admission remain separate; the lane stays EXPLORING.

Independent next-consumer route review (depth_commit_verifier): the next
mathematical edge is the actual unclipped path mean, before normalized Renyi.
For fixed x,z, FTC applied to r -> <gradient f(xp), gamma_r> - f(gamma_r)
should establish integral_0^1 W(r,x,z) dr =
<gradient f(xp), x-(h+z)> - f(x) + f(h+z).
The starting point is h+z. Reuse GaussianArcLaw.gaussian_arc_law's derivative
and endpoints, HasGradientAt.hasFDerivAt and
intervalIntegral.integral_eq_sub_of_hasDerivAt. This identity is not yet proved.

The actual auxiliary Gaussian and uniform-time expectation then needs joint
measurability and integrability, not just fixed-time integrability. A uniform
quadratic majorant on [0,1] is (pi/2)*beta*(norm(x-h)+norm(z))*
(norm(xp-h)+norm(x-h)+norm(z)). Gaussian second moments and the potential's
quadratic growth should establish the required integrals before Fubini.
The intended mean is <gradient f(xp),x>-f(x)+C with
C=E[f(h+Z)]-<gradient f(xp),h>; integrability of f(h+Z) must actually be proved.
These steps need no clipping small-step or center-distance assumptions.
The source consumer is D.1 before Eq.18. Substitution of the actual center,
completion of the Gaussian square, clipped target law, Jensen, normalization
and Renyi accuracy remain separate. This is route planning, not a new SAU,
Lean result or admission.
