# Next packet: explicit RGO conditional kernel

Historical plan, now implemented by GaussianConditionalKernel. The exact
proposal, compiled tests and independent source review are linked from
ASTIS-SHARED-gaussian-rgo-conditional-kernel. Commit-bound verification and
publication are separate admission steps; this note does not certify them.

Read-only route synthesis by rgo_closure_worker; not a compiled result, frozen
statement or new Goal. Begin only after the preceding TV packet is stabilized.

For finite-dimensional real inner-product Borel E, probability μ and η>0,
let J be the actual Gaussian augmentation law of (X, X+sqrt(η)G).
Construct a Kernel R:E→Measure E such that IsMarkovKernel R,
R(y)=μ.tilted(x↦−‖x−y‖²/(2η)) for every y, and J.map Prod.swap
has IsCondKernel R. The certificate is a joint-law disintegration, not a
pointwise assertion about Mathlib's separately chosen conditional version.

Seven-step route: (1) jointly measurable positive bounded Gaussian weight;
(2) measurable strictly positive normalizer Z(y); (3) local Kernel.withDensity
of Kernel.const μ, identify every fiber with the existing tilted law and prove
Markov; (4) auxiliary ν=volume.withDensity(Cη Z); (5) existing GaussianAugmentation
density transported through product swap; (6) prove ν.compProd R=J.swap by
positive-normalizer cancellation; (7) take first marginals to identify ν with
J.snd and obtain IsCondKernel. No extra normalization wrapper is needed.

Candidate reuse: Kernel.withDensity, measurable parameter integrals,
Measure.compProd_withDensity, compProd_const, prod_withDensity_left,
withDensity_mul, fst_compProd, existing ASTIS RadonNikodym measurable-equivalence
density transport, GaussianAugmentation.augmentation_eq_withDensity.
Inspect exact pinned signatures before freezing; this synthesis is not an API
compilation certificate.

Consumers: PBPS v1 (2.8), Definition 2.2 and §3.2 explicit RGO/posterior
semantics; SPHMC v1 §3.4 backward-RGO recovery of the original law. The existing
normalized Gibbs certificate and quadratic_tilt_tilt supply later specialization.
No curvature, moments, convergence, nonexplosion, generator-domain or query-cost
conclusion belongs in this packet. Arbitrary conditional representatives agree
only marginal-a.e.; the explicit density is an everywhere-defined selected version.

## Planned successor after conditional-kernel publication

Primary source inspected: https://arxiv.org/html/2609.06906v1#S6.SS2,
Section6.2.2, Lemma6.4 and (6.1). Assemble the numbered calculus result from
existing parents rather than introducing a second quadratic or RGO library.
This is a source-audited plan, not a new claimed SAU or frozen Lean declaration.

Use nonnegative precision r=A^-1 so r=0 retains A=infinity. For C² U with
kappa^-1 I ≤ D²U ≤ I and a>0, put alpha=kappa^-1+r, beta=1+r,
K=beta/alpha. The source successor is r+=r+1/a and
u+=(r+1/a)^-1*(r*u+y/a), with
K+=(beta+1/a)/(alpha+1/a)=(a*beta+1)*K/(a*beta+K).
Positive alpha and a justify every division. The source scalar identity is
not a claim that RecursiveCondition's already compiled contraction bounds
construct or execute a recursive sampler.

Reuse QuadraticRegularization for genuine strong convexity and gradient
smoothness; HessianStrongConvexity plus StrongConvexGibbsIntegrability for a
positive finite Gibbs normalizer; RGOClosure.quadratic_tilt_tilt for normalized
composition; and the explicit conditional kernel only where the probability
law is interpreted as a backward oracle. Convert the mu-relative tilts to the
source potentials using Mathlib tilted_tilted under proved integrability.
Keep an implementable oracle, recursive accuracy, reference-point work and
actual-input expected query costs outside this calculus integration packet.

## Successor implemented locally

RGOCalculus.rgo_calculus and its focused test pass2945 jobs on Lean4.33.0.
The theorem returns the source curvature/smoothness, positive integrable Gibbs
weight, probability of current and updated source laws, normalized-law identity
and exact bound-ratio update. The r=0 case and the actual ratio-to-contraction
consumer are exercised. Admission remains separately tracked by
ASTIS-SW-SPHMC-rgo-calculus; do not infer it from this local record.

Preflight required explicit updated-law probability to exclude the zero fallback;
it was included without new assumptions. Independent mathematical review found
one lesson wording slip: the field identity multiplies by K=beta/alpha, not
divides by alpha. Corrected before the canonical source-review packet.

Next dependency-ready candidate: Lemma6.6(ii)'s well-conditioned variance
contraction, retaining r=0 initially and strictly positive finite variance after
the first update. Reuse the calculus and existing scalar route; inspect exact
source hypotheses before freezing. Stage termination, actual recursive sampler,
quantitative error and costs must not be bundled into the scalar branch.
