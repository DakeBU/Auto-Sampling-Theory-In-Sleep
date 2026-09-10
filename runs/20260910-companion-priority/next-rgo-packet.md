# Next packet: explicit RGO conditional kernel

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
