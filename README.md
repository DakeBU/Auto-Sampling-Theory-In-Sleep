<div align="center">

# Auto-Sampling-Theory-In-Sleep

### Samplinglib: a source-backed Lean graph for sampling and optimization

[![Samplinglib](https://img.shields.io/badge/Samplinglib-formal_knowledge_graph-155EEF?style=flat-square)](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
[![Lean 4](https://img.shields.io/badge/Lean-4-6B4FBB?style=flat-square)](https://lean-lang.org/)
[![Samplinglib site](https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/actions/workflows/blueprint-site.yml/badge.svg)](https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/actions/workflows/blueprint-site.yml)

[**Home**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
· [**Libraries**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/libraries/)
· [**SampleWiki progress**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/example-cases/samplewiki/progress.html)
· [**Underlying Lean Graph**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/underlying-lean-graph/)
· [**Harness**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/workflow/)

</div>

ASTIS builds **Samplinglib**: natural-language mathematics, source anchors, Lean declarations, and theorem dependencies in one inspectable graph. Textbooks provide stable coordinate systems; frontier papers are inserted into the same graph so that their actual mathematical contribution can be compared and reused.

## Libraries

| Library | Mathematical source | Current role | Owners |
|---|---|---|---|
| [Log-Concave Sampling](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/textbook/) | Sinho Chewi, *Log-Concave Sampling* | Active textbook formalization | Dake, Ji |
| [SampleWiki](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/example-cases/samplewiki.html) | Source-pinned frontier sampling results | Active frontier ingestion; [progress](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/example-cases/samplewiki/progress.html) | Dake, Ji |
| [Riemannian Optimization](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/libraries/riemannian-optimization/) | Nicolas Boumal, *An Introduction to Optimization on Smooth Manifolds* | Eleven-chapter scaffold; Euclidean → Riemannian transfer | Andi, Dake |
| [First-Order Optimization](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/libraries/first-order-optimization/) | Amir Beck, *First-Order Methods in Optimization* | Fifteen-chapter scaffold aligned with Optlib and CvxLean | Dake, Huanjian, Andi |

The immediate execution order remains **Chewi + SampleWiki first**, followed by the Boumal and Beck lanes. Each optimization theorem is classified as `reuse`, `adapt`, `missing`, or `out of scope`; existing formal work is connected rather than silently duplicated. Chapter-sized or theorem-sized volunteers are welcome.

## Research aim

```text
formalize → compare graph structure → compress → abstract/transfer → re-formalize
```

A paper may add a **LEAF**, **BRIDGE**, **SHORTCUT**, **HUB**, or **RE-ORGANIZATION**; these are overlapping structural signatures, not an automatic paper ranking. “A+B” is not inherently marginal: a reusable bridge that transports many later results can be major. A shallow A+B result instead leaves A and B as independent black boxes, joins them only in one terminal application, and creates little reusable transport, shortening, or downstream reach.

<p align="center">
  <img src="website/static/astis-formal-graph-value.svg" alt="How new mathematics changes the formal theorem graph" width="940">
</p>

Graph compression first removes Lean refactoring artifacts, then studies repeated proof supports and cross-field mechanisms. ZDD-style representations target families of alternative minimal supports; categorical or functor-like models test whether repeated subgraphs express a composition-preserving mathematical translation.

## Verification workflow

A **Frontier Cell** is one theorem-sized advance with an exact target, known parents, a truth boundary, and a focused test. A Universal Worker owns it end to end; independent review and one stabilization lane decide what becomes shared library truth.

```text
claimed → proved locally → independently verified → stabilized → merged
              │
              └→ blocked → smaller child theorem → verified → re-entry
```

Lean compilation does not by itself guarantee source fidelity. Source-facing nodes separately audit objects, domains, quantifiers, assumptions, and conclusions; denoising proposals remain explicit rather than silently changing the pinned theorem.

## Attribution & design lineage

| Source | Samplinglib use | Boundary |
|---|---|---|
| [Sinho Chewi, *Log-Concave Sampling*](https://chewisinho.github.io/main.pdf) | Sampling textbook order and theorem route | Original paraphrase, exact anchors, ASTIS-owned Lean |
| [Nicolas Boumal, *An Introduction to Optimization on Smooth Manifolds*](https://www.nicolasboumal.net/book/) | Riemannian geometry and optimization spine | Chapter scaffold and source correspondence; no wholesale republication |
| [Amir Beck, *First-Order Methods in Optimization*](https://epubs.siam.org/doi/book/10.1137/1.9781611974997) | Convex analysis and first-order-method spine | Chapter scaffold and source correspondence; no wholesale republication |
| [Optlib](https://github.com/optsuite/optlib) | Audited convex-analysis and algorithm theorem nodes | Provenance and version adapters stay explicit |
| [CvxLean](https://github.com/verified-optimization/CvxLean) | Formal optimization problems, reductions, relaxations, and transformations | Reference/integration layer until compatibility is locally verified |
| [Lean-Ridgelet](https://github.com/shosonoda/lean-ridgelet) | Blueprint and implementation-map presentation | Extended to textbooks, frontier insertion, fidelity, and graph comparison |
| [LeanMarathon](https://github.com/YuanheZ/LeanMarathon), [StatsMLlib](https://github.com/Lean-MoDS/StatsMLlib), [FrontierAgent](https://github.com/ApodexAI/FrontierAgent) | Proof-DAG scheduling, subject-library organization, bounded generalist workers | ASTIS requires source-backed theorem state, independent verification, and serialized stabilization |

Full provenance: [docs/attribution.md](docs/attribution.md). Library manifests and upstream pins: [Libraries/](Libraries/).

## Quick start

```bash
git clone https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep.git
cd Auto-Sampling-Theory-In-Sleep
python3 tools/astis.py check
```

```bibtex
@misc{bu2026astis,
  title  = {Auto-Sampling-Theory-In-Sleep: A Lean Formal Knowledge Graph
            and Theorem-Driven System for Sampling Theory},
  author = {Dake Bu and Ji Cheng and Atsushi Nitanda and
            Hau-San Wong and Qingfu Zhang},
  year   = {2026},
  url    = {https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep}
}
```

**Organizers:** Dake Bu, Ji Cheng, Atsushi Nitanda, Hau-San Wong, Qingfu Zhang
