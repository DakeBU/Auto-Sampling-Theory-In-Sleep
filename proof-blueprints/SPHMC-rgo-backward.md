# Actual RGO backward kernel

For probability base mu on finite-dimensional real inner-product Borel E, precision b>=0, center u and a>0, put rho=mu.tilted(-b/2*norm(x-u)^2). Construct one Markov kernel K, before all input laws nu and budgets r, whose every fiber equals rho.tilted(-norm(x-y)^2/(2*a)) and equals the base tilt with precision b+a^-1 and center (b+a^-1)^-1*(b*u+a^-1*y). Prove K composed with actual GaussianSmoothing rho sqrt(a) equals rho. For every probability nu and r>=0 with actual quadratic transportCost(nu,rho)<=ofReal(r^2), prove actual klDiv(K composed with GaussianSmoothing nu sqrt(a),rho)<=ofReal(r^2/(2*a)).

Exact measurable backward kernel and normalized precision-update fiber, not the approximate recursive sampler. General probability base and raw transport budget explicitly generalize source Gibbs/P2 presentation. No marginal moment inference, measurable proxy selection, convolution time identification, recursive error or expected query cost completion. Precision zero retains the source infinite-A case.

Derive probability of the initial quadratic tilt from bounded positive weights. Construct GaussianConditionalKernel for that actual target. Identify the joint noisy marginal with GaussianSmoothing and the other marginal with the target; take the second marginal of the disintegration identity. Identify every fiber via normalized RGOClosure with s=a^-1. Apply actual KL data processing and GaussianKL only after choosing that same kernel.

Root sole writer. Bounded publication packet precedes Lean development.

Independent fixed-commit VERIFIED at ebaa88025ba28ebc2013c959e9a0d6fca3ffc2b6. Root now sole STABILIZING owner; aggregate and original reader/graph delivery pending. Full paper Goal remains active.
