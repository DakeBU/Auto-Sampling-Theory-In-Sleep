# Acceleration × Geometry shared-spine handoff

This packet is the collaboration entry point for the cross-library acceleration work requested on 2026-09-11.

## Read first

Canonical program metadata:

- `Libraries/acceleration-geometry-program.json`
- `Libraries/formalization-routes.yml`
- `Libraries/frontloaded-shared-spine.json`
- `Libraries/conceptual-mirror-protocol.json`
- `website/content/functor_hypergraph.json`

Working branch at creation: `codex/acceleration-geometry-shared-spine`.

## Scope and truth boundary

The goal is **not** to declare Nesterov, underdamped Langevin, Linear Coupling, Katyusha, Riemannian acceleration, Wasserstein acceleration, and differing-norm acceleration equivalent. The goal is to formalize the smallest reusable theorem/certificate substrate first, then attach domain-specific adapters, and only then compress the verified graph into conceptual families.

Use five truth classes throughout:

1. `formal-lean`: compiled ASTIS theorem/declaration plus focused tests **and** the normal publication/semantic-review evidence chain;
2. `lean-prototype`: compile-checked Lean in `Tests/` only; useful for validating a proposed common algebraic shape, but not Samplinglib theorem truth;
3. `source-theorem`: theorem proved in a pinned source but not yet a local Lean dependency;
4. `proof-pattern-transfer`: a reviewed proof schema whose target-domain adapters are still obligations;
5. `research-hypothesis`: speculative design edge; never render as theorem implication.

Conceptual mirrors belong in the Functor Hypergraph/Graph Memory, not in the Lean dependency DAG, until an exact local certificate exists.

## Public naming change

Public branding is being widened from sampling-only language to:

- **Auto-Sampling-Theory-In-Sleep** — `An Automated Theorem Proving System and Visualized Lean Library for Sampling, Optimisation, and Geometry`;
- **Samplinglib** — `Verified Sampling, Optimisation, Geometry Theory in Lean`.

Public library cards that are textbook routes must say `教材` / `Textbook`, not `Chapter scaffold`. Internal implementation states may retain machine-oriented lifecycle labels when validators depend on them.

## Canonical mathematical placement

### Optimisation textbook first

Formalize the acceleration architecture in the Optimisation library before transporting it elsewhere.

- **Chapter 5 — Acceleration**: Nesterov theorem route; deterministic Lyapunov/estimate-sequence route; Allen-Zhu--Orecchia Linear Coupling as a supplementary source-backed proof architecture.
- **Chapter 10 — Mirror methods**: Bregman divergence, mirror step, dual norm/duality-map ingredients. This is the canonical geometric substrate for Linear Coupling.
- **Chapter 12 — Stochastic optimization**: variance reduction, snapshot/anchor state, inexact progress, and Katyusha negative momentum.

The shared Lean layer should contain algebraic progress-coupling and Lyapunov extraction lemmas. It should **not** contain a copy of each algorithm for every target geometry.

### Riemannian Optimisation transport

Reuse the common certificate algebra. Replace Euclidean subtraction/addition only at the adapter boundary by the appropriate manifold primitives: tangent/cotangent conversion, Riemannian gradient, log/retraction, vector transport, geodesic convexity, and curvature/retraction defects. Do not hide these errors inside the common core.

### Statistical Optimal Transport transport

Reuse the same high-level certificate layer but supply Wasserstein-specific objects: continuity equation/tangent velocity, OT displacement as a log-map analogue, displacement convexity, and moving optimal-map identities. AIG/Hamiltonian material is supplementary literature rather than the sole canonical route.

### Sampling transport

Keep three graph layers distinct:

1. structural mirror: position + momentum + damping;
2. continuous-time theorem: hypocoercive/entropy/L2 acceleration;
3. discretized algorithm theorem: local error + composition + final sampler complexity.

The current mainline source sequence is:

- Ma et al. 2019, *Is There an Analog of Nesterov Acceleration for MCMC?* — optimization-on-measures/Lyapunov bridge;
- Cao--Lu--Wang, *On explicit L2-convergence rate estimate for underdamped Langevin dynamics* — continuous-time square-root scale;
- Zhang--Chewi--Li--Balasubramanian--Erdogdu 2023 — discretization transfer, but not yet full discrete acceleration;
- Altschuler--Chewi--Zhang, *Shifted Composition IV* — first discrete-time ballistic acceleration result for log-concave sampling;
- Lu 2026 — sharp `sqrt(rho)` entropy decay using an OT/Brenier corrector;
- Borkowski--Nüsken 2026, *The Fenchel Game of Underdamped Langevin Dynamics* — positional KL rates matching the canonical accelerated-gradient-flow rates through an online/Fenchel-game proof route.

When source statements disagree in assumptions/normalizations/metrics, keep them as separate theorem nodes and use explicit adapters.

## Linear Coupling and Katyusha policy

`Linear Coupling` is the foundational proof/design schema: gradient descent supplies primal progress and mirror descent supplies dual progress; weights couple their certificates.

`Katyusha` is a later stochastic finite-sum instantiation. Its negative momentum and snapshot anchor are **not** a sampling theorem. The only current sampling migration is a research hypothesis: investigate whether an anchor distribution/snapshot score plus explicit estimator-error bookkeeping stabilizes finite-particle accelerated sampling.

Never draw a solid Lean edge from Katyusha to a sampler before such a theorem is actually formalized.

## Differing-norm / Site Bai policy

Bai--Bullins 2025 is important because primal and dual iterate sequences are measured in **differing norms** and coupled through an implicit interpolation parameter.

The correct migration order is:

1. extract proof inequalities in norm/dual-norm language;
2. isolate the coupling algebra from the specific norm geometry;
3. specialize quadratic Hilbert norms to metric/Riemannian instances;
4. route genuinely nonquadratic cases through Banach/Finsler/Legendre geometry;
5. only then investigate Wasserstein/Finsler or cross-geometry sampling analogues.

Do **not** model general `p != 2` geometry by simply inserting two Riemannian metric tensors into the Hamiltonian. That can destroy the Legendre/Hamiltonian cancellation being used.

## Shared Lean prototypes and publication rule

The first low-conflict algebra has been written only as compile-checked prototypes in:

- `Tests/AccelerationGeometry.lean`

The current prototypes check:

- weighted coupling of two certified progress bounds;
- affine three-way weight identities used by anchored momentum schemes;
- nonnegativity of the residual anchor weight;
- scalar damping/force cancellation and dissipation.

They are intentionally **not** declarations under `AutoSamplingTheory/`: the ASTIS publication gate correctly requires every new public declaration to have a publication binding, authored lesson, Frontier Cell, blind reconstruction, and independent semantic source review. Because that independent evidence does not yet exist for this new route, publishing the prototypes as canonical Samplinglib lemmas would be premature.

Promotion order:

1. ACC-OPT-LC-01 pins the exact Chewi/Allen-Zhu source statements and the common scalar proof obligation;
2. the normal theorem-publication packet and independent semantic round-trip are completed;
3. only then promote the genuinely common declarations to `AutoSamplingTheory.TechnicalLemmas.Optimization.Acceleration.*` and the canonical shared aggregator/Registry;
4. downstream Riemannian/OT/Sampling routes import those declarations rather than creating route-local copies.

This is deliberate Lean-first staging, not a status downgrade: the proposed algebra is machine-checked before we claim a source-corresponding theorem edge.

## Parallel-work rule

At the time this packet was created, SPHMC/RGO work was active on separate branches/PRs. Do not edit their theorem files or the high-conflict append-only ledgers just to advertise this route.

In particular, avoid opportunistic edits to:

- `research-wiki/semantic-roundtrip/registry.json`;
- `runs/substantive_advances.jsonl`;
- files explicitly owned by active SPHMC/RGO Frontier Cells.

If another worker needs one of the acceleration shared interfaces now, reuse the prototype shape but do not publish a duplicate canonical declaration. After the source audit and stabilization merge, consume the canonical shared module.

## Next bounded formalization cells

1. **ACC-OPT-LC-01** — audit Chewi Ch. 5 acceleration statements and Allen-Zhu--Orecchia source; identify the exact two progress inequalities and common scalar coupling lemma.
2. **ACC-OPT-MIRROR-01** — audit Ch. 10 Bregman/mirror ingredients and Mathlib/Optlib reuse.
3. **ACC-OPT-KAT-01** — audit Ch. 12 stochastic/variance-reduction ingredients before Katyusha theorem reconstruction.
4. **ACC-ULD-STPI-01** — pin the space-time Poincare/hypocoercive continuous-time acceleration theorem and its exact assumptions.
5. **ACC-ULD-DISC-01** — separate continuous-time rate from discrete local-error/composition theorems (2023 ULMC versus Shifted Composition IV).
6. **ACC-NORM-01** — decompose Bai--Bullins into geometry-dependent and geometry-independent proof nodes.
7. **ACC-RIEM-ADAPTER-01** — only after ACC-OPT-LC-01/ACC-OPT-MIRROR-01: state manifold adapter obligations.
8. **ACC-WASS-ADAPTER-01** — only after the Euclidean certificate and OT displacement/moving-map substrate are pinned.

Do not spawn all cells blindly. Follow DAG readiness and the existing Harness ownership rules.
