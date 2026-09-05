<div align="center">

# Auto-Sampling-Theory-In-Sleep

**Samplinglib · source-aligned Lean mathematics across sampling, optimisation and transport**

[Website](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
· [Current Progress](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/progress/)
· [Functor Hypergraph](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/lean-foundations.html?view=functor)
· [ASTIS Harness](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/workflow/)

</div>

Five peer libraries share one reader and one underlying Lean graph:

| Library | Primary source |
|---|---|
| Log-Concave Sampling | Sinho Chewi, textbook and official supplement |
| SampleWiki | Source-pinned frontier papers, including lower bounds |
| Riemannian Optimisation | Nicolas Boumal, *An Introduction to Optimization on Smooth Manifolds* |
| Optimisation | Sinho Chewi, *Lectures on Optimization* |
| Statistical Optimal Transport | Sinho Chewi, Jonathan Niles-Weed, Philippe Rigollet |

**Reuse first:** search Samplinglib, Mathlib and compatible Lean upstreams before proving a new lemma. When a source omits necessary details, consult authoritative background texts: Bubeck (2015), Beck (2017), Nesterov (2018) for optimisation; Villani, Santambrogio, Ambrosio–Gigli–Savaré for transport; corresponding geometry, probability and sampling references [here](docs/cross-domain-program.md). Record exact anchors, conventions and added hypotheses; never silently replace the primary theorem.

Shared gaps get **one canonical Frontier Cell**, not route-local duplicates. Five coordinated routes include statistical OT and **Higher-Order Smoothness × Sampling**; upper-bound and SampleWiki lower-bound techniques remain independent until comparison contracts match. The **Functor Hypergraph** records conditional conceptual transports separately from compiled Lean dependencies; analogy is not a certified functor.

```bash
python3 tools/astis.py check
python3 tools/astis_frontier_cells.py check
```

[Protocol](docs/formalization-protocol.md) · [Research plan](docs/cross-domain-program.md) · [Attribution](docs/attribution.md) · [Design lineage and upstream licenses](docs/readme-design-lineage.md) · [Cite](CITATION.bib)

**Project contributors:** Dake Bu, Ji Cheng, Huanjian Zhou, Andi Han, Sinho Chewi, Matthew S. Zhang, Hau-San Wong, Qingfu Zhang, Atsushi Nitanda.
