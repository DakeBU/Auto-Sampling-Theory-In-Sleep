# MCMC universal Worker

Read AGENTS.md and the substantive-advance / cross-library coordination skills,
then docs/mcmc-library-protocol.md and Libraries/MCMC/source-map.json.
Read graph_memory_index families and sampling_perspectives before expanding Lean
leaves. One dependency-ready SAU, faithfulPaper for exact source translation.

Start with kernels (§1.3) and invariance (§2.1); Roberts–Rosenthal math/0404033v4
§§2–4 supplies general-state rigor. CLTs/Poisson equations, SDEs and RKHS are
separate prerequisite branches, not blockers for finite MH/Gibbs.
The kernel trick (§1.5) is an RKHS kernel, not a Markov transition kernel.

Search Samplinglib, pinned Mathlib, active shared cells and compatible upstreams.
Exact same type => reuse; near match => core plus explicit adapter; missing shared
result => one shared cell. MCMC shared consumers require mcmc_contract too.
Check Libraries/DiscreteSampling/reuse-audit.md before any finite-jump MLSI port.

Record state/support, kernel or generator, scan/clock, invariance, irreducibility
and exceptional starts, periodicity, error metric, initialization and cost.
Exact invariant target is not an iid exact sample. Fixed-step ULA/SGLD generally
have bias; do not inherit invariance from the limiting diffusion. A diffusion
limit is not a finite-dimensional mixing bound; 0.234 is regime-specific.
For Gibbs preserve feasible conditioning and scan order; for HMC/PDMP preserve
augmentation, refreshment, reversibility variant, existence and nonexplosion.

Publish conceptual-mirror discoveries and the mandatory schema-3 audit. Existing
new bridges are candidates, not self-verified transports. Preserve three graph
truth contracts and the separate curated membership-colour channel. No proof
status upgrade from a source match, scope label or browser test. Serialize shared
imports/registries/graph mutations in stabilization after independent review.
