<div align="center">

# Auto-Sampling-Theory-In-Sleep

### A Lean Formal Knowledge Graph and Theorem-Driven Workflow for Sampling Theory

[![Samplinglib](https://img.shields.io/badge/Samplinglib-verified_sampling_theory-155EEF?style=flat-square)](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
[![Lean 4](https://img.shields.io/badge/Lean-4-6B4FBB?style=flat-square)](https://lean-lang.org/)
[![Mathlib](https://img.shields.io/badge/Mathlib-pinned_revision-008F78?style=flat-square)](https://mathlib.org/)
[![Samplinglib site](https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/actions/workflows/blueprint-site.yml/badge.svg)](https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/actions/workflows/blueprint-site.yml)

[**Samplinglib**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
· [**Textbook**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/textbook/chapter-01/section-1-2.html)
· [**Underlying Lean Graph**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/underlying-lean-graph/)
· [**Theorem Fidelity**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/lean-foundations.html?view=semantic)
· [**Harness**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/workflow/)

</div>

ASTIS builds **Samplinglib**: a source-backed Lean library and reader-facing formal graph for sampling theory. The goal is not only to make individual proofs compile. We want the mathematical dependencies of the field to become explicit enough that beginners can follow them, experts can inspect them, and new results can be understood by what they actually add to the existing structure.

## Three contributions

### 1. Samplinglib — verified memory and a structural map of sampling theory

Samplinglib aligns **natural-language mathematics ↔ Lean declarations ↔ theorem dependencies**. Its first large program follows Sinho Chewi's *Log-Concave Sampling*; the SampleWiki lane attaches frontier sampling results to the same reusable library. Readers can move between the source exposition, the formal statement, its prerequisites, and the later results that reuse it.

<p align="center">
  <img src="website/static/samplinglib-architecture.svg" alt="Samplinglib architecture" width="940">
</p>

The formal graph is part of the product, not a visualization added afterward. A theorem is a node; the facts it genuinely uses form incoming edges; reusable consequences form outgoing edges. This gives us a concrete way to **digest new results**. Instead of reading a new paper only as an isolated theorem and proof, we can ask where its mathematics attaches to the existing graph and what topology it changes.

A new result might add another leaf on a known branch, create a bridge between previously separate branches, replace a long route by a shorter reusable argument, weaken an assumption so that many downstream results become available, or introduce a new hub that reorganizes a whole part of the proof spine. Those are very different mathematical contributions even when their paper-level theorem statements look superficially similar. The graph is not meant to produce an automatic ranking of papers; it is an auditable substrate for seeing **what new mathematical mechanism was actually added**.

We also expect the library itself to be periodically **re-organized and compressed**: duplicated local lemmas can be factored into common interfaces, unnecessarily long dependency paths can be shortened, and a collection of theorem branches can be exposed as one cleaner reusable spine. We treat this graph compression as re-organization of existing formal knowledge, distinct from claiming that it is new mathematics.

<p align="center">
  <img src="website/static/astis-formal-graph-value.svg" alt="How new mathematics changes the formal theorem graph" width="940">
</p>

### 2. ASTIS Harness — how theorem-sized advances enter the shared graph

The Harness is the workflow used to turn an open mathematical dependency into a stable Samplinglib node. The unit of work is a **Frontier Cell**: one theorem-sized advance with an exact target statement, known parent nodes, a clear truth boundary, and a focused test. One **Universal Worker** owns that cell end to end. It may read the source, search Mathlib and Samplinglib, try proofs, repair an interface, construct a counterexample, or split the problem further; those are activities inside one mathematical task rather than fixed roles that work must be handed through.

Independent Frontier Cells can move in parallel. If a proof hits a real blocker, the worker isolates a **strictly smaller child cell**—for example a missing analytic lemma or API bridge—and returns to the original theorem once that child has been verified. Useful lemmas, failed routes, blocker boundaries, and dependency discoveries are written to shared graph memory so that another worker does not have to rediscover them. The **Thin Master** only chooses frontiers, resolves cross-cell conflicts and joins, and controls publication order.

<p align="center">
  <img src="website/static/astis-harness-current.svg" alt="Current ASTIS Harness theorem-driven workflow" width="980">
</p>

Before a result becomes shared library truth, it goes through independent theorem review and then a **single stabilization lane**. The exact reviewed head must still compile through its focused test and the repository root build, and the public imports and graph/index views are regenerated from that same result. This is intentionally serialized: mathematical exploration can be parallel, but there should be one unambiguous version of what Samplinglib currently claims.

In short, the state transition we care about is

```text
claimed -> proved locally -> independently verified -> stabilized -> merged
              |
              +--> blocked -> smaller child theorem -> verified -> re-entry
```

The important invariant is not concurrency itself. Every published node should have an explicit statement, dependencies, evidence, ownership, and a stable place in the graph.

### 3. Theorem fidelity and denoising

Lean can correctly prove the wrong formalization of a source theorem, so source-facing nodes receive a separate statement review: do the mathematical objects, domains, quantifiers, assumptions and conclusion still express what we meant to formalize? The same review also exposes assumptions or statement clutter introduced only by a particular Lean proof route. We call that second task **denoising**. It can motivate a cleaner reusable interface or an explicit follow-up theorem, but it does not silently rewrite the pinned source or the history of an already verified result. The detailed evidence is available in the reader's [**Theorem Fidelity**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/lean-foundations.html?view=semantic) view when it is useful.

## Attribution & design lineage

| Source | What ASTIS learns from it | ASTIS-specific boundary |
|---|---|---|
| [Sinho Chewi, *Log-Concave Sampling*](https://chewisinho.github.io/main.pdf) | Textbook order, theorem route, calculations, background results | Faithful ASTIS paraphrase + exact source anchors + ASTIS-owned Lean declarations; no endorsement implied |
| [Lean-Ridgelet](https://github.com/shosonoda/lean-ridgelet) | Blueprint / implementation-map presentation | Extended from one formalization map to a sampling-theory textbook, frontier results, reusable theorem graph, and source-aware statement review |
| [ARIS](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep) | Long-running research, recovery, separate review | The durable state is source-backed Lean theorem progress rather than plausible research narrative |
| [Learning Beyond Gradients](https://github.com/Trinkle23897/learning-beyond-gradients) | Durable failures, rejected routes, system self-improvement | Keeps negative memory without permanent intellectual role boundaries |
| [EoH](https://github.com/FeiLiu36/EoH) | Competing candidate routes | Search is allowed only around fixed Lean-checkable targets; faithful source statements do not mutate |
| [LeanMarathon](https://github.com/YuanheZ/LeanMarathon) | Blueprint, proof-DAG leaves, bounded workers, deterministic gates | ASTIS makes theorem-graph memory, source correspondence, statement fidelity, and sampling-analysis obligations first-class |
| [MathCode](https://github.com/math-ai-org/mathcode) | Lean diagnostics and theorem-reuse ideas | Diagnostics are advisory; ASTIS's pinned Lean/source checks and independent verification are authoritative |
| [lean-stat-learning-theory](https://github.com/YuanheZ/lean-stat-learning-theory) | Mathlib probability / concentration / functional-inequality proof idioms | External declarations become ASTIS truth only after a local audited port compiles |
| [StatsMLlib](https://github.com/Lean-MoDS/StatsMLlib) | Subject-owned modules, reuse-first formalization | Samplinglib adds textbook correspondence, SampleWiki ingestion, statement fidelity, and graph-level contribution views |
| [FrontierAgent](https://github.com/ApodexAI/FrontierAgent) | Parallel generalist agents, bounded task boards, no-progress control | ASTIS schedules theorem-DAG advances with Lean evidence, truth boundaries, independent verification, and serialized stabilization |
| [Quantum-Computing-Block-Encoding](https://github.com/DakeBU/Quantum-Computing-Block-Encoding) | Experience building automated formalization workflows | ASTIS specializes the machinery for sampling/SDE mathematics with theorem-sized Universal Workers and Frontier Cells |

Full provenance and boundaries: [docs/attribution.md](docs/attribution.md).

## Citation 📝

```bibtex
@misc{bu2026astis,
  title        = {Auto-Sampling-Theory-In-Sleep: A Lean Formal Knowledge Graph
                  and Theorem-Driven System for Sampling Theory},
  author       = {Dake Bu and Ji Cheng and Atsushi Nitanda and
                  Hau-San Wong and Qingfu Zhang},
  year         = {2026},
  howpublished = {GitHub repository and Samplinglib formalization website},
  url          = {https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep}
}
```

## Quick start

```bash
git clone https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep.git
cd Auto-Sampling-Theory-In-Sleep
python3 tools/astis.py check
```

**Organizers:** Dake Bu, Ji Cheng, Atsushi Nitanda, Hau-San Wong, Qingfu Zhang
