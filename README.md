<div align="center">

# Auto-Sampling-Theory-In-Sleep

### Lean-verified formal memory and structural maps for sampling theory

[![Samplinglib](https://img.shields.io/badge/Samplinglib-verified_sampling_theory-155EEF?style=flat-square)](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
[![Lean 4](https://img.shields.io/badge/Lean-4-6B4FBB?style=flat-square)](https://lean-lang.org/)
[![Mathlib](https://img.shields.io/badge/Mathlib-pinned_revision-008F78?style=flat-square)](https://mathlib.org/)
[![Samplinglib site](https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/actions/workflows/blueprint-site.yml/badge.svg)](https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/actions/workflows/blueprint-site.yml)

[**Samplinglib**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
· [**Textbook**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/textbook/chapter-01/section-1-2.html)
· [**Underlying Lean Graph**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/underlying-lean-graph/)
· [**Harness**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/workflow/)

</div>

ASTIS turns sampling-theory mathematics into **source-backed Lean declarations and a reusable dependency graph**. The first major program follows Sinho Chewi's *Log-Concave Sampling*; the SampleWiki lane places frontier results into the same formal graph.

<p align="center">
  <img src="website/static/samplinglib-architecture.svg" alt="Samplinglib architecture" width="940">
</p>

## Harness

<p align="center">
  <img src="website/static/astis-harness-evolution.svg" alt="Earlier and current ASTIS Harness architectures" width="940">
</p>

Universal Workers own theorem-sized advances end to end; Frontier Cells compress local progress; a Thin Master handles only global conflicts and joins; independent verification and one stabilization lane protect shared library truth. [Design details](docs/multi_agent_orchestration.md).

## Why a formal graph?

<p align="center">
  <img src="website/static/astis-formal-graph-value.svg" alt="From AI proof text to Lean-verified graph contributions" width="940">
</p>

The goal is not only to accumulate formalized theorems. The graph should make the **conceptual spine of sampling theory** visible and let readers inspect whether new work adds a leaf, bridge, shortcut, reusable interface, or a deeper reorganization of existing mathematics.

## Quick start

```bash
git clone https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep.git
cd Auto-Sampling-Theory-In-Sleep
python3 tools/astis.py check
```

**Organizers:** Dake Bu, Ji Cheng, Atsushi Nitanda, Hau-San Wong, Qingfu Zhang  
**Design lineage / attribution:** [docs/attribution.md](docs/attribution.md)
