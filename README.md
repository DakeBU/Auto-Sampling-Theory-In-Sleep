<div align="center">

# Auto-Sampling-Theory-In-Sleep

### A Hierarchical Automated Theorem Proving and Semantic Auditing System for Sampling Theory

[![Samplinglib](https://img.shields.io/badge/Samplinglib-verified_sampling_theory-155EEF?style=flat-square)](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
[![Lean 4](https://img.shields.io/badge/Lean-4-6B4FBB?style=flat-square)](https://lean-lang.org/)
[![Mathlib](https://img.shields.io/badge/Mathlib-pinned_revision-008F78?style=flat-square)](https://mathlib.org/)
[![Samplinglib site](https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/actions/workflows/blueprint-site.yml/badge.svg)](https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/actions/workflows/blueprint-site.yml)

[**Samplinglib**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
· [**Textbook**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/textbook/chapter-01/section-1-2.html)
· [**Underlying Lean Graph**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/underlying-lean-graph/)
· [**Semantic Fidelity & Repair**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/lean-foundations.html?view=semantic)
· [**Harness**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/workflow/)

</div>

ASTIS turns sampling-theory mathematics into **source-backed Lean declarations, reusable formal memory, an inspectable theorem graph, and auditable source↔Lean semantic contracts**. We want both beginners and experts to see not only whether a Lean proposition is correct, but whether it is still the theorem the source intended, where it sits in the field, and what mathematical structure a new result actually adds.

## Four contributions

### 1. ASTIS Harness — theorem-sized AI research with Lean truth

Universal Workers own a mathematical advance end to end; dynamic Frontier Cells parallelize nearby proof work; a Thin Master handles only cross-frontier joins and conflicts. Independent Lean/source verification and a single stabilization lane prevent fluent AI reasoning from being mistaken for shared mathematical truth.

<p align="center">
  <img src="website/static/astis-harness-evolution.svg" alt="Earlier and current ASTIS Harness architectures" width="940">
</p>

### 2. Samplinglib — verified memory and a structural map of sampling theory

Samplinglib aligns **natural-language mathematics ↔ Lean declarations ↔ dependency graph**. Its first program follows Sinho Chewi's *Log-Concave Sampling*, while the SampleWiki lane attaches frontier results to the same reusable graph; readers can inspect calculation routes, hidden analytic assumptions, exact Lean foundations, and the Underlying Lean Graph.

<p align="center">
  <img src="website/static/samplinglib-architecture.svg" alt="Samplinglib architecture" width="940">
</p>

### 3. Theorem Fidelity Checker — did Lean prove the theorem we meant?

Lean compilation establishes that the formal proposition is proved; it does **not** establish that the proposition faithfully represents its source. ASTIS therefore audits the round trip

```text
original theorem (text)
  -> compiled Lean statement
  -> blind reconstructed theorem (text)
  -> seven-slot semantic diff
  -> independent source review
```

The Lean-to-text decoder receives an anonymous packet: no original theorem, source identity, theorem number, audit ID, Lean file/declaration identity, prior semantic audit, or repair proposal. ASTIS then compares mathematical objects, domains, quantifiers, assumptions, conclusion, scopes/senses of equality, and constant dependencies. Verdicts distinguish exact equivalence from explicit elaboration, strengthened Lean assumptions, weakened conclusions, domain or quantifier mismatch, source underspecification, and possible source error. Text similarity is never treated as theorem equivalence.

### 4. Lean Theorem Denoiser — expose hidden assumptions without rewriting history

Formalization can reveal omitted measurability, integrability, smoothness, positivity, boundary, representative, or constant-dependence conditions. ASTIS converts such discrepancies into **minimal repair proposals** with a reconstructed statement, justification, minimality evidence, and reference or counterexample. A proposal remains separate from the pinned source theorem and becomes accepted only after independent source review; a condition introduced merely because one Lean proof route needed it is marked as a formalization-artifact risk and cannot silently mutate a faithful source statement.

The machine-readable contract lives in [`research-wiki/semantic-roundtrip/registry.json`](research-wiki/semantic-roundtrip/registry.json), the protocol is documented in [`research-wiki/semantic-roundtrip/README.md`](research-wiki/semantic-roundtrip/README.md), and the same evidence appears as a dedicated **Semantic fidelity & repair** view in the Underlying Lean Graph.

## Semantic round-trip gate

```bash
# Reject source-visible decoders, incomplete semantic slots,
# self-approved reviews, and unsupported accepted repairs.
python3 tools/astis_semantic_roundtrip.py check

# Inspect fidelity and repair counts.
python3 tools/astis_semantic_roundtrip.py summary

# Export an anonymous decoder packet that contains the Lean proposition but no
# source/audit/declaration identity.
python3 tools/astis_semantic_roundtrip.py decoder-packet \
  --audit-id ASTIS-RT-... \
  --output runs/semantic-roundtrip/ASTIS-RT-....decoder.json

# After blind reconstruction, export an anti-anchored independent-review packet.
python3 tools/astis_semantic_roundtrip.py reviewer-packet \
  --audit-id ASTIS-RT-... \
  --output runs/semantic-roundtrip/ASTIS-RT-....review.json
```

The canonical lifecycle is therefore:

```text
discovered -> sourcePinned -> normalized -> leanTarget -> compiled
           -> blindReconstructed -> semanticDiffed -> sourceReviewed -> assimilated
```

`compiled` is not synonymous with `sourceReviewed`, and a proposed denoising repair is not synonymous with a corrected source theorem.

## Why a formal graph?

<p align="center">
  <img src="website/static/astis-formal-graph-value.svg" alt="From AI proof text to Lean-verified graph contributions" width="940">
</p>

A new theorem can then be read structurally: **another leaf, a bridge, a shortcut, a reusable hub, or a reorganization of the field's proof spine**. Its source-facing declaration can additionally be inspected for semantic fidelity, hidden assumptions, and reviewed repairs. This gives a sharper lens on mathematical contribution than isolated theorem/proof text or a green Lean build alone.

## Attribution & design lineage

| Source | What ASTIS learns from it | ASTIS-specific boundary |
|---|---|---|
| [Sinho Chewi, *Log-Concave Sampling*](https://chewisinho.github.io/main.pdf) | Textbook order, theorem route, calculations, background results | Faithful ASTIS paraphrase + exact source anchors + ASTIS-owned Lean declarations; no endorsement implied |
| [Lean-Ridgelet](https://github.com/shosonoda/lean-ridgelet) | Blueprint / implementation-map presentation | Extended from one formalization map to a sampling-theory textbook, frontier results, reusable theorem graph, and source↔Lean semantic audits |
| [ARIS](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep) | Long-running research, recovery, separate review | The durable state is source-backed Lean theorem progress rather than plausible research narrative |
| [Learning Beyond Gradients](https://github.com/Trinkle23897/learning-beyond-gradients) | Durable failures, rejected routes, system self-improvement | Keeps negative memory without permanent intellectual role boundaries |
| [EoH](https://github.com/FeiLiu36/EoH) | Competing candidate routes | Search is allowed only around fixed Lean-checkable targets; faithful source statements do not mutate |
| [LeanMarathon](https://github.com/YuanheZ/LeanMarathon) | Blueprint, proof-DAG leaves, bounded workers, deterministic gates | ASTIS makes source contracts, theorem-graph memory, semantic round trips, and sampling-analysis obligations first-class |
| [MathCode](https://github.com/math-ai-org/mathcode) | Lean diagnostics and theorem-reuse ideas | Diagnostics are advisory; ASTIS's pinned Lean/source/semantic gates are authoritative |
| [lean-stat-learning-theory](https://github.com/YuanheZ/lean-stat-learning-theory) | Mathlib probability / concentration / functional-inequality proof idioms | External declarations become ASTIS truth only after a local audited port compiles |
| [StatsMLlib](https://github.com/Lean-MoDS/StatsMLlib) | Subject-owned modules, reuse-first formalization | Samplinglib adds textbook correspondence, SampleWiki ingestion, semantic fidelity, and graph-level contribution views |
| [FrontierAgent](https://github.com/ApodexAI/FrontierAgent) | Parallel generalist agents, bounded task boards, no-progress control | ASTIS schedules theorem-DAG advances with Lean evidence, truth boundaries, independent verification, and serialized stabilization |
| [Quantum-Computing-Block-Encoding](https://github.com/DakeBU/Quantum-Computing-Block-Encoding) | Earlier Upper/Middle/Lower/Reviewer Harness lineage | ASTIS specializes the machinery for sampling/SDE mathematics and now uses Universal Workers + Frontier Cells |

Full provenance and boundaries: [docs/attribution.md](docs/attribution.md).

## Citation 📝

```bibtex
@misc{bu2026astis,
  title        = {Auto-Sampling-Theory-In-Sleep: A Hierarchical Automated
                  Theorem Proving System for Sampling Theory},
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
python3 tools/astis_semantic_roundtrip.py check
```

**Organizers:** Dake Bu, Ji Cheng, Atsushi Nitanda, Hau-San Wong, Qingfu Zhang
