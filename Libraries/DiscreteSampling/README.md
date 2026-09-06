# Discrete Sampling

A peer source library for **discrete configuration spaces**, not numerical time steps for continuous-state Langevin sampling.

**Primary:** Zongchen Chen, Daniel Štefankovič and Eric Vigoda, *Spectral Independence and Local-to-Global Techniques for Optimal Mixing of Markov Chains*, [arXiv:2307.13826v4](https://arxiv.org/abs/2307.13826v4). The 100-page edition has 12 top-level sections. `source-map.json` pins the PDF bytes, authors, full section contents and page anchors. Pal–Mesikepp, [arXiv:2510.14165v1](https://arxiv.org/abs/2510.14165v1), supplies an introductory companion; Levin–Peres is an additional classical background reference, not mislabeled as an arXiv book.

**Source limitation:** §12 (p.90) explicitly states that the Ising/coloring results are surveyed without proofs. The §12.1 model definition can be pulled forward, but a mixing theorem must retrieve its exact cited original proof, normalize its conventions, and record omitted details. Do not infer all-temperature rapid mixing, arbitrary external fields, or an extension from hard-core to Ising without the corresponding theorem.

## Shared graph, not a new probability library

`route-plan.json` is a machine-readable dependency plan, linked to `../frontloaded-shared-spine.json` and `../cross-domain-program.json`. First audit local `ConditionalKernel`, `MarkovSemigroup.TransitionKernelContract`, `Generator.dirichletForm`, `Generator.SatisfiesPoincare`, and `Generator.SatisfiesLogSobolev` alongside pinned Mathlib. They are source-present reuse candidates; finite-state compatibility still needs proof. In particular, the existing generator density-entropy inequality already has the shape of a jump MLSI after a constant/domain adapter. Do not create a duplicate simply because a book calls it by a different name.

The first useful DAG is finite probability/conditioning → heat-bath detailed balance → reversible forms and influence bounds in parallel → local-to-global / entropy methods → model-specific regimes. Scalar decay and kernel algebra are shared with continuous sampling. Finite foundations must not wait for Itô theory, Langevin existence, Brenier maps or complete textbook chapters. A common gap belongs to one `route: shared` Frontier Cell, with source-facing adapters for every consumer.

Use `.agents/prompts/discrete-sampling.md` and `research-wiki/frontier-cells/_discrete_example.json`. The example is not an active theorem claim. The schema-v2 cell validator enforces state space, support/pinning, clock/update unit, kernel/generator, ergodicity, regime, metric, start and cost. Schema-v3 SAUs additionally require the existing conceptual-mirror audit.

## Conceptual admission

New discrete bridges are **pending review proposals**, hidden from the default Functor atlas. They can be inspected explicitly; independent source/mathematical review is required for admission. The creator cannot validate their own mirror. Metadata tests and browser checks do not certify mathematics. No bridge in this integration is Lean-certified, and no new chapter or theorem closure is claimed.

See `docs/discrete-sampling.md` for normalizations and `Libraries/conceptual-mirror-protocol.json` for the existing discovery → independent validation → stabilization → graph-memory pipeline. Root README and project Citation authors are not a source-author list.
