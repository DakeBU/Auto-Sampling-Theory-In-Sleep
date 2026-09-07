# An Automated Theorem Proving System and Visualized Lean Library for Sampling Theory

> **Anonymous frozen review snapshot.** This branch is a source-complete snapshot for double-blind review. It preserves the Lean library, Harness, source maps, source/frontier routes, graph memory, website generators, tests, protocols, and documentation used by the submission while withholding project authorship from reviewer-facing entry points.

## What this repository contains

Samplinglib is a source-backed Lean library and mathematical reader for sampling theory. Six primary source spines, a frontier index, and cross-cutting research routes are organized against one shared prerequisite graph.

| Library / route | Primary mathematical source | Role in the shared graph |
|---|---|---|
| **Log-Concave Sampling** | Sinho Chewi, *Log-Concave Sampling* and official supplement | Continuous/log-concave sampling: couplings, Langevin dynamics, functional inequalities, convergence arguments |
| **Optimisation** | Sinho Chewi, *Lectures on Optimization* | Euclidean convexity, first-order methods, energy-dissipation and proximal foundations |
| **Riemannian Optimisation** | Nicolas Boumal, *An Introduction to Optimization on Smooth Manifolds* | Tangent, metric, geodesic, and manifold-optimisation adapters |
| **Statistical Optimal Transport** | Sinho Chewi, Jonathan Niles-Weed, Philippe Rigollet | Couplings, duality, Wasserstein geometry, and statistical transport |
| **Discrete Sampling** | Zongchen Chen, Daniel Štefankovič, Eric Vigoda, *Spectral Independence and Local-to-Global Techniques for Optimal Mixing of Markov Chains* (arXiv:2307.13826v4) | Finite-state kernels, spectral independence, Dirichlet/entropy methods, local-to-global mixing |
| **Markov Chain Monte Carlo** | Paul Fearnhead, Christopher Nemeth, Chris J. Oates, Chris Sherlock, *Scalable Monte Carlo for Bayesian Learning* (arXiv:2407.12751v1) | General-state MCMC, MH/Gibbs/HMC/PDMP, scalable and approximate kernels |
| **SampleWiki frontier route** | Source-pinned frontier papers | Frontier upper/lower bounds inserted against the same formal foundations |

The project also keeps a **Higher-Order Smoothness × Sampling** route. Source order does not dictate Lean implementation order: dependency-ready shared prerequisites may be pulled forward without conferring chapter-completion credit.

### Orthogonal sampling perspectives

The field is not represented as a false hierarchy. **MCMC is a method family; log-concavity is a target property; discreteness is a state-space property; Riemannian/Wasserstein structure is geometric or analytic; oracle access is an information contract.** Thus Gibbs/Glauber belongs simultaneously to MCMC and discrete sampling, Hit-and-Run is continuous-state MCMC, and ULA/MALA overlap MCMC with smooth log-concave targets. The Overview Graph contains a curated **Methods × Targets** view for these intersections. Its edges are taxonomy/conditional applicability, not proof implications.

## 1. The theorem-driven Harness

The unit of work is a theorem-sized **Substantive Advance Unit / Frontier Cell**. A generalist Worker owns a bounded mathematical delta end-to-end: source reading, theorem retrieval, proof design, counterexample search, Lean implementation, compiler diagnosis, and exposition are temporary modes rather than rigid intellectual roles.

```text
claimed -> proved locally -> independently verified -> stabilized -> merged
               \
                -> blocked -> smaller typed child / retired route
```

Important contracts include:

- **reuse-first search:** inspect Samplinglib, Mathlib, active shared cells, and compatible upstreams before creating a declaration;
- **truth boundaries:** Lean compilation, source fidelity, and conceptual similarity are separate claims;
- **semantic round trip / denoising:** original theorem text -> Lean statement -> reconstructed theorem text -> semantic-slot comparison; repair proposals never silently overwrite the source;
- **durable discovery:** a useful lemma, counterexample, proof mechanism, or conceptual mirror must survive Worker termination in typed memory;
- **independent review:** a proving Worker cannot self-publish verification, and a conceptual-mirror creator cannot validate its own mirror;
- **serialized stabilization:** shared imports, registries, and graph/site truth enter the canonical library through one controlled lane.

Route-specific contracts preserve the mathematical setting. Finite-state work records support, kernel/generator, discrete- or continuous-time clock, reversibility/periodicity, feasible pinnings, discrepancy, and cost. MCMC work records state/support, kernel or generator, scan/clock, invariance class, irreducibility/exceptional starts, error metric, cost, and an explicit bias contract whenever the implemented kernel is only approximate-target.

The canonical formal gate is:

```bash
python3 tools/astis.py check
```

## 2. The visualized sampling-theory Lean library

Three graph views deliberately answer different questions and carry different truth contracts:

- **Overview Graph:** source libraries, shared prerequisite stages, active routes, and the curated Methods × Targets perspective. This is source/project topology and taxonomy, not theorem implication.
- **Lean Branches Graph:** compiler-backed modules/declarations and actual formal dependencies.
- **Functor Hypergraph:** recurring mathematical mechanisms after changing state space, metric, energy, kernel, oracle, or discrepancy. These are typed conceptual correspondences with explicit failure boundaries, not automatically certified functors or Lean implications.

The current compact graph memory contains ten conceptual families: **metric-gradient-flow, curvature-growth, gap-gradient, L2-coercivity, proximal-energy, conditional-dependence, invariance-correction, scaling-limit, augmented-state, and kernel-perturbation.** Representative correspondences include:

- PL-shaped gradient dissipation and the KL/Fisher/LSI mirror in continuous sampling;
- Poincaré/Dirichlet coercivity and chi-square decay;
- finite reversible Dirichlet/spectral-gap arguments as a discrete gap -> dissipation -> decay branch;
- finite entropy/MLSI as a related but distinct branch: standard jump dissipation uses `E(r, log r)`, so it is not silently identified with the diffusion Fisher chain rule, especially at zero density;
- Metropolis correction as proposal -> target-invariant kernel construction;
- Gibbs/Glauber as conditional resampling, with stationarity kept distinct from rapid mixing;
- ULA/SGLD mixing versus target bias as separate obligations;
- HMC/lifting/PDMP as augmented-state mechanisms;
- scaling-limit arguments with an explicit clock, never promoted by themselves to finite-dimensional mixing bounds.

The conceptual layer is intended for **agent memory, proof digestion, and cross-pollination**: readers can recognize a reusable mechanism first, then expand its exact assumptions and Lean leaves. Compression must retain provenance and failure boundaries rather than flattening distinct geometries, state spaces, clocks, or functional inequalities into false equivalences.

## Current evidence in this frozen snapshot

The generated graph inventory contains **7 source-library hubs, 7 formalization/research routes, 10 conceptual families, 22 typed conceptual hyperedges, 53 peer-library chapter/section scaffolds, 501 Lean modules, and 395 registry declarations**. These are mixed source/graph/formal inventories and are **not theorem-completion metrics**.

The discrete source map pins a 100-page source with 12 reader sections and 72 subordinate anchors. Its sections are scaffolds: no discrete Lean theorem closure is asserted merely from the source map. The MCMC source map pins a 244-page primary source with 6 chapters and 85 primary anchors, together with 10 auxiliary source-backed extended reading paths. Those pages are likewise source scaffolds/outlines, not proof certificates.

A shared Euclidean strong-convexity leaf is compiler-backed:

```text
AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexFirstOrder
  .firstOrder_lower_bound_of_strongConvexOn
```

It formalizes the standard first-order quadratic lower model

```text
f(y) >= f(x) + <grad f(x), y-x> + (m/2) ||y-x||^2
```

for the project’s domain-local strong-convexity/gradient interface. It is a compiled Euclidean substrate for the curvature-to-growth family; it does **not** certify Riemannian, Wasserstein, Bakry--Émery, PL, Poincaré, LSI, discrete-sampling, or MCMC bridges.

The repository also contains source-to-Lean semantic round-trip infrastructure, shared-foundation route planning, Frontier Cell protocols, and graph-memory machinery. The frozen generated graph reports `semantic_audits = 0`, `repair_proposals = 0`, and `accepted_repairs = 0`; implemented audit infrastructure is therefore not presented as measured repair accuracy.

## Repository map

```text
AutoSamplingTheory/          Lean production library
Tests/                       compiler-backed focused and integration tests
Libraries/                   six source spines, shared foundations, route programs
research-wiki/               source correspondence, frontier cells, proof memory
.agents/                     theorem-sized Worker / Harness protocols
proof-blueprints/            durable proof architecture
website/content/             source, frontier, perspective, and graph-memory data
website/scripts/             source-derived reader and graph generation
website/static/              interactive reader assets
tools/                       gates, Harness, source and semantic-roundtrip tooling
docs/                        protocols, diagrams, and design documentation
review/                      review-only anonymization tooling
```

## Reproduce the frozen library

```bash
lake exe cache get
lake build
python3 tools/astis.py check
```

Build the complete reader locally with:

```bash
python3 website/scripts/build_site.py
python3 website/scripts/check_site.py
python3 -m http.server 8000 --directory _site
```

The review workflow runs the formal/source gates, the Discrete Sampling and MCMC source/route regressions, the complete reader build, browser checks over all discrete and MCMC pages, reviewer-facing identity post-processing, and a second graph/browser pass before archiving the deployable static site.

## Source and attribution boundary

Mathematical source authors remain named where they are bibliographic sources. Project authorship is withheld during double-blind review. Existing formal systems and libraries are credited in `docs/attribution.md`, `NOTICE.md`, source maps, and related-work documentation. Source attribution does not imply that a source author participates in or endorses this project.

## Review status

This branch is a deliberate frozen submission snapshot. It does not auto-sync with the development line; any refresh requires an explicit freeze and a complete verification run.
