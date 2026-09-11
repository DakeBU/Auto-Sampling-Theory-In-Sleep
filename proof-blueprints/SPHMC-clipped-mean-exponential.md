# Actual clipped-output exponential mean error

For the actual source center h=x0-eta*gradient f(xp), actual Gaussian proposal q, independent uniform-time/Gaussian auxiliary nu and unclipped gradient-arc W, let m=E_nu W, mB=E_nu clipB(W), VB=E_nu(max(absW-B,0)), and qhat=q.tilted(mB). Under differentiable f with actual beta-Lipschitz gradient, d>0,eta,beta,B>0,ell>=2,center residual<=sqrt(d*eta), and64beta^2(ell*d/B+ell^2)<=eta^-2, prove actual measurability and needed exponential L1, E_q[exp(2ell VB)-1]<=2exp(-K), and E_qhat[exp(2ell abs(m-mB))-1]<=2exp(2B-K), where K=min(B^2/(40beta^2*d*eta^2),B/(8beta*eta)). Retain the same qhat VB bound if useful. Establish actual product L1 before a.e. Jensen, then transfer under the actual clipped output density.

Actual clipped-output exponential mean-error input to normalized Renyi comparison only. q-a.e. auxiliary exponential L1 must not be upgraded to everyx. Preserve factor2 and resulting log2 if logarithms are later taken. No bidirectional RN-power/divergence result, joint adaptive kernel,initialization,cost or fullpaper completion is asserted. No TV transport of unbounded cost.

Next packet: actual clipped-output exponential moment of mean error.
Source preaudit log_depth_source_review, primary2602.01338v1D1Eq18/LemmaB12,
SPHMC2609.06906v1A4(2). No Lean result claimed by this note.

Use actual center h=x0-eta gradf xp, d>0,eta beta B>0,ell>=2,
||h-xp||<=sqrt(d eta),64 beta^2(ell d/B+ell^2)<=eta^-2.
Same actual W,nu=U.prodP,q. m=E_nu W,mB=E_nu clipB(W),
VB=E_nu(max(absW-B,0)),qhat=q.tilted mB.
K=min(B^2/(40 beta^2 d eta^2), B/(8 beta eta)).
Prove joint measurability, relevant exponential L1 and
E_q(exp(2ell VB)-1)<=2exp(-K),
E_qhat(exp(2ell abs(m-mB))-1)<=2exp(2B-K).
May retain qhat VB exponential bound too.

Tonelli fixed-r clipping bound and U probability first give actual triple L1.
Product rearrangement yields q-a.e. x auxiliary exponential L1, not everyx.
Excess L1 everyx already parent-supported. Jensen after both L1 premises gives
exp(2ellVB)-1 <= E_nu F q-a.e. Nonnegative domination gives outer L1.
Actual clipped normalizer bounds yield density exp(mB)/ZB<=exp(2B).
Transfer under true qhat then use abs(m-mB)<=VB. Never use ideal law in place
of source Eq18 clipped-output expectation. Factor2 implies log2 if logging.
Separate moment-excess convention and log Renyi API; both normalized RNpowers
still required later. No cost transport, initialization or full sampler claim.

Mathlib: Analysis/Convex/Integral.lean ConvexOn.map_integral_le requires both
input and composition L1. Integral/Prod integrable_prod_iff, integral_prod,
integral_prod_symm and lintegral_prod. Measure/Tilted integral_tilted,
integrable_tilted_iff and absolute continuity. Existing InformationTheory/Renyi
API does not already supply full bidirectional normalized tilt comparison.

Alternative shorter true-L1 assembly: integrable_prod_iff directly uses each-r
parent L1 and outer integrability of r -> integral norm F. Since F>=0,
the norm integral equals its bounded real integral; joint strong measurability
supplies measurability of the parameter integral, and the constant bound on the
finite uniform-time measure gives outer L1. This avoids assuming section L1
from totalized integrals. Then measurePreserving_prodAssoc and swap transfer
from U.prod(q.prodP) to q.prod(U.prodP). integrable_prod_iff/prod_right_ae yield
q-a.e. auxiliary exponential L1. Both this route and Tonelli are valid;
choose focused shortest compile. No new theorem or execution state asserted.
