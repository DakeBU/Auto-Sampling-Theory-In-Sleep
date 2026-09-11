# Actual two-noise RGO stage

For probability base mu on finite-dimensional real inner-product Borel E, b>=0,u,eta>=0,tau>0 and rho=mu.tilted(-b/2*norm(x-u)^2), prove actual GaussianSmoothing(H_eta rho,sqrt(tau))=H_(eta+tau)rho. Construct one Markov kernel K with every-y fiber rho.tilted(-norm(x-y)^2/(2*(eta+tau))) before all inputs nu,r, recover rho from K composed with H_tau(H_eta rho), and for every probability nu with actual quadratic transportCost(nu,H_eta rho)<=ofReal(r^2),r>=0 prove actual KL(K composed with H_tau nu,rho)<=ofReal(r^2/(2*tau)). Derive actual noise-sum law and heat semigroup; denominator is added time tau, not total eta+tau.

Fixed target and fixed stage parameters, not history-dependent approximate recursion. General probability base and raw infimum-cost budget explicitly abstract source Gibbs/P2 setting. Eta0 and precision0 included; positive added time. Source normalized times eta_j/beta_A and tau_j/beta_A need separate concrete parameter substitution. Joint parameter kernels, measurable proxies, accumulated errors and actual expected costs remain open.

Use actual characteristic-function uniqueness, convolution multiplication and scaled standard Gaussian characteristic functions to prove heat semigroup. Obtain one exact backward kernel at total time eta+tau from RGOBackward. Identify exact two-noise target recovery. Apply GaussianKL only to nu versus H_eta rho at added time tau, then same-kernel data processing. Do not substitute total time into the input-error denominator.

Root sole writer. Bounded publication packet precedes Lean development.
