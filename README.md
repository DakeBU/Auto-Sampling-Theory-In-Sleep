# An Automated Theorem Proving System and Visualized Lean Library for Sampling Theory

> **Anonymous frozen review snapshot.** This branch is a source-complete snapshot of the development state used for the workshop submission. It preserves the Lean library, Harness, source maps, textbook/frontier routes, graph memory, website generators, tests, and documentation from the frozen development revision while removing the project-author surface from reviewer-facing entry points. It is not the live development branch.

## What this repository contains

This project builds a source-backed Lean library for sampling theory together with an automated formalization Harness and a reader that exposes the same mathematics at three different graph levels.

| Route / library | Primary mathematical source | Role in the shared graph |
|---|---|---|
| **Log-Concave Sampling** | Sinho Chewi, *Log-Concave Sampling* and official supplement | Sampling spine: couplings, Langevin dynamics, functional inequalities, convergence arguments |
| **Optimisation** | Sinho Chewi, *Lectures on Optimization* | Euclidean convexity, first-order methods, energy-dissipation and proximal foundations |
| **Riemannian Optimisation** | Nicolas Boumal, *An Introduction to Optimization on Smooth Manifolds* | Geometry-aware gradients, geodesics and manifold optimisation adapters |
| **Statistical Optimal Transport** | Sinho Chewi, Jonathan Niles-Weed and Philippe Rigollet | Couplings, duality, Wasserstein geometry and statistical transport foundations |
| **SampleWiki frontier route** | Source-pinned frontier papers | Frontier upper/lower-bound results inserted against the same formal foundation |

The routes are deliberately **dependency-first rather than cover-to-cover**. Shared mathematical prerequisites are formalized once and reused across books and frontier results instead of being duplicated inside each route.

## Two contributions in one system

### 1. The theorem-driven Harness

The unit of work is a theorem-sized **Substantive Advance Unit / Frontier Cell**. A generalist Worker owns a bounded mathematical delta end-to-end: source reading, theorem retrieval, proof design, counterexample search, Lean implementation, compiler diagnosis and exposition are temporary modes rather than rigid intellectual roles.

The publication protocol separates:

```text
claimed -> proved locally -> independently verified -> stabilized -> merged
               \
                -> blocked -> smaller typed child / retired route
```

Important contracts include:

- **reuse-first search:** inspect the local library, Mathlib and compatible upstreams before creating a declaration;
- **truth boundaries:** Lean compilation, source fidelity and conceptual similarity are separate claims;
- **semantic round trip / denoising:** original theorem text -> Lean statement -> reconstructed theorem text -> semantic-slot comparison; repair proposals never silently overwrite the source;
- **durable discovery:** a useful lemma, counterexample, proof mechanism or conceptual mirror must survive Worker termination in typed memory;
- **independent review:** the proving Worker cannot self-publish verification, and a conceptual-mirror creator cannot validate its own mirror;
- **serialized stabilization:** shared imports, registries and graph/site truth are integrated through one controlled lane.

The canonical formal gate is:

```bash
python3 tools/astis.py check
```

### 2. The visualized sampling-theory Lean library

The reader separates three graph views because they answer different questions and have different truth contracts:

- **Overview Graph:** where the books, source sections, shared stages and frontier routes live. This is project/source topology, not theorem implication.
- **Lean Branches Graph:** compiler-backed module/declaration structure and exact formal dependencies.
- **Functor Hypergraph:** source-backed recurring mathematical mechanisms after changing the state space, metric, energy, oracle or discrepancy. These are typed conceptual correspondences with explicit failure boundaries, not automatically certified functors or Lean implications.

Current compact conceptual families include:

- metric gradient flow: gradient -> dissipation -> coercivity -> scalar Gronwall/exponential decay;
- curvature/growth: lower curvature or strong-convexity style hypotheses -> quadratic models or growth/coercivity controls;
- gap/gradient: Euclidean, Riemannian and Wasserstein PL-shaped mechanisms together with the KL/Fisher/LSI mirror, with settings kept distinct;
- L2 coercivity: Poincare/Dirichlet control -> chi-square decay for reversible semigroups;
- proximal energy: one quadratic-regularized energy viewed through proximal minimization or Gibbs/RGO sampling.

The conceptual layer is intended for **proof digestion and cross-pollination**: readers can first recognize a reusable mechanism, then expand the exact assumptions and Lean leaves. Compression must retain provenance and failure boundaries rather than flattening distinct geometries or functional inequalities into false equivalences.

## Current formal evidence in this frozen snapshot

A shared Euclidean strong-convexity leaf is compiler-backed:

```text
AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexFirstOrder
  .firstOrder_lower_bound_of_strongConvexOn
```

It formalizes the first-order quadratic lower model

```text
f(y) >= f(x) + <grad f(x), y-x> + (m/2) ||y-x||^2
```

for the domain-local strong-convexity/gradient interface used by the project. It is a compiled Euclidean substrate for the curvature-to-growth family; it does **not** by itself certify Riemannian, Wasserstein, Bakry--Emery, PL, Poincare or LSI arrows.

The repository also contains the semantic round-trip infrastructure, shared-foundation route program, source correspondence, Frontier Cell protocol and graph-memory machinery. Infrastructure for a semantic audit is not reported as evidence of semantic-repair accuracy until an audit instance is separately completed and reviewed.

## Repository map

```text
AutoSamplingTheory/          Lean production library
Tests/                       compiler-backed focused and integration tests
Libraries/                   source maps, shared-spine and cross-route programs
research-wiki/               source correspondence, frontier cells, proof memory
.agents/                     theorem-sized Worker / Harness protocols
proof-blueprints/            durable proof architecture
website/content/             textbook, frontier and graph-memory data
website/scripts/             source-derived reader and graph generation
website/static/              interactive reader assets
tools/                       gates, Harness, source and semantic-roundtrip tooling
docs/                        protocols, diagrams and design documentation
review/                      review-only freeze/anonymization tooling
```

## Reproduce the frozen library

```bash
lake exe cache get
lake build
python3 tools/astis.py check
```

Build the full reader locally with:

```bash
python3 website/scripts/build_site.py
python3 website/scripts/check_site.py
python3 -m http.server 8000 --directory _site
```

The anonymous review workflow additionally runs the formal/source gates, builds the complete reader, removes reviewer-facing identity surfaces from the generated static site, rechecks the result and archives a deployable Cloudflare Pages bundle.

## Source and attribution boundary

Mathematical source authors remain named where they are bibliographic sources. Project authorship is intentionally withheld during double-blind review. Existing formal systems and libraries are credited in `docs/attribution.md`, `NOTICE.md`, source maps and the related-work documentation. Source attribution is not evidence that the source author participates in or endorses this project.

## Review status

This branch is frozen relative to the live development line. New mathematical progress belongs to the live branch and does not enter the review snapshot unless the submission snapshot is deliberately regenerated and re-verified.
