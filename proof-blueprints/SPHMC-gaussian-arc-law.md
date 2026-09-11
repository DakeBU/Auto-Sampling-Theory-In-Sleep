# Actual Gaussian gradient-arc joint law

On a finite-dimensional real inner product space, eta>0 and fixed center h, for actual independent X~N(h,eta I), Z~N(0,eta I), gamma_r=h+sin(pi*r/2)(X-h)+cos(pi*r/2)Z and v_r=(pi/2)(cos(pi*r/2)(X-h)-sin(pi*r/2)Z), prove the actual joint pushforward N(h,eta I) product N(0,(pi/2)^2 eta I), path derivative, endpoints and necessary joint measurability. Prove independence through the product law, not separate Gaussian marginals.

All real r is a disclosed extension of source r in [0,1]. Starting position is h+Z, not h. No gradient regularity is required for the Gaussian path law. The actual W inner-product consumer later needs Holder gradients and center-distance hypotheses. No MGF, clipping accuracy, terminal sampler or paper main result is claimed. Printed D.1 Claim 1 missing log 2 is a separately source-audited possible-source-error; no silent repair is admitted.

# Next dependency source audit: Gaussian gradient arc

Read-only independent reviewer: log_depth_source_review. Pending SAU registration and publication packet; no new Lean declaration or source repair admitted.

Source: https://arxiv.org/html/2602.01338v1 Appendix D.1, Claim 1 and Claim 2; consumed by SPHMC https://arxiv.org/html/2609.06906v1 Appendix A.1 / A.4(2).

For a finite-dimensional real inner product space, fixed center h and eta>0, actual independent X~N(h,eta I), Z~N(0,eta I), theta=pi*r/2:
gamma_r=h+sin(theta)(X-h)+cos(theta)Z;
v_r=(pi/2)(cos(theta)(X-h)-sin(theta)Z).
Required substantive result is the actual joint pushforward law N(h,eta I) product N(0,(pi/2)^2 eta I), with path derivative, endpoints and joint measurability. All real r is a disclosed generalization; source uses [0,1]. Start is h+Z, not h. Consumer is W=<v_r,grad f(x_plus)-grad f(gamma_r)>, which needs genuine joint independence for conditional Gaussian integration. Later Holder-gradient and center-distance hypotheses stay separate.

Possible-source-error, not an admitted formal repair: Claim 1 printed log E exp(lambda |W|) <= 10 d^s eta^(1+s) lambda^2 beta_s^2 omits log 2. Its proof ends with a factor 2 in the exponential moment and Claim 2 uses that factor. Reviewer counterexample: d=s=beta=1, f(x)=x^2/2, centers zero; E|W|=eta, Jensen gives log MGF>=lambda eta, violating printed bound when 0<lambda eta<1/10. This is an independent mathematical audit, not a Lean-certified counterexample. Preserve possible-source-error classification and independently review any future factor-2 contract. Source s=0 range containing 1/s also needs separate treatment; smooth SPHMC consumer can use s=1.

Targeted reuse search found no existing arc theorem. Candidate Mathlib routes: stdGaussian_map under a linear isometry on WithLp 2 (E x E), or characteristic functions on the actual product measure. Existing scaledStdGaussian is in TechnicalLemmas/Measure/GaussianSmoothing.lean. No theorem code yet.