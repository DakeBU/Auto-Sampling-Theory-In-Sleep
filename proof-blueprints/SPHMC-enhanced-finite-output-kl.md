# Actual enhanced-state finite output KL

SPHMC arXiv:2609.06906v1 Section6.3 KL recursion and actual terminal stage,Theorem6.5 A1 q=2

For the actual EnhancedTerminalExecution P,Lt at q=2,derive KL((Lt composed P^J)s0||T_s0)<=sum(j<J,integral actual observation error d(P^j)s0)+Delta^2/(J+1). Identify the actual nested Gibbs target with the terminal Gaussian tilt,derive terminal KL from the actual RN second moment,then accumulate the actual enhanced one-step inequality. Preserve cap stability beyond J.

Normalized beta=1,kappa>=1,genuine C2 Hessian bounds and source positive measurable eta<=c<1/4,Delta in(0,1/2]. Actual M remains arbitrary;its observation error is explicit and may be infinite. No assumed terminal target identity or terminal KL budget. No implemented stage accuracy,final Delta² bound,total query cost or legal initialization claim. q=2 is the A1 consumer;general q remains separate.

# Next substantive consumer after EnhancedKLOneStep

Planning only, not a registered proof packet or a completed theorem.
Read-only independent route review: log_depth_source_review, 2026-09-12.

Target A1, q = 2: the actual EnhancedTerminalExecution kernels P and Lt satisfy
KL((Lt comp P^J)(s0) || T(s0)) <= sum(j<J, integral e d(P^j(s0))) + Delta^2/(J+1).
Derive terminal KL and target identification, rather than requiring them as premises.
The actual accumulated observation error remains explicit until an actual stage
sampler supplies its source W2 accuracy. No final paper accuracy or cost claim.

1. On terminal support b > 0 and capped precision equals b. Identify nested
volume Gibbs tilt T with Gaussian(u, sqrt(1/b)).tilted(-V).
Use tilted_tilted. Its exp(-V) integrability follows from actual Gibbs probability:
tilted_of_not_integrable would otherwise give the zero measure. Reuse
IdealRGOIdentification's two final density equalities under the terminal step
condition; check the required gradient Lipschitz adapter from the genuine Hessian.
Do not assert this Gaussian identity at b = 0.

2. Use the terminal RN moment in the direction r = dLt/dT integrated against T.
With q = 2, prove KL(Lt||T) <= integral (r-1)^2 dT
= integral r^2 dT - 1 <= eps^2. Required steps include probability mass, RN
integral one, square integrability, scalar klFun comparison and the finite
real-integral/nonnegative-integral bridge. Never use toReal infinity as zero.

3. Adapt the private finite kernel error induction to the actual enhanced state.
Identify the P kernels by their actual update formulas and T by its public fiber
formula. Use the actual P^J terminal support to integrate the terminal bound.
Cap stability extends actual output law to J+m. Do not project to the old state.

4. Source anchor: SPHMC Section 6.3, (6.5), ensuing KL recurrence and terminal
stage. Separate later task: actual per-stage error <= Delta^2/(J+1), from the
implemented M and Gaussian reverse transport. Actual-input random-history
cost, GD initialization and accumulated stage query counts remain separate.

Narrow local API reads confirmed tilted_tilted needs only integrability of the
first exponential; IdealRGOIdentification publicly returns the two equalities
through its actual q tilt and a normalized canonical-volume density.
