# ASTIS Technical Lemma Memory

This directory is the agent-facing memory layer for reusable SDE/Sampling
lemmas.  It is not a runtime dependency on any external Lean project.

## Rule

Agents must search local ASTIS declarations first.  A lemma is callable only if
it appears as a compiled local declaration under `AutoSamplingTheory`.

External repositories such as
`YuanheZ/lean-stat-learning-theory` are used only as audited source material for
porting.  Do not write "SLT proves this" in a proof packet unless the packet
also names a compiled ASTIS declaration or records a precise port obligation.

## Lean Module

Compiled lemma memory lives in:

- `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean`
- `AutoSamplingTheory/TechnicalLemmas/Taylor.lean`
- `AutoSamplingTheory/TechnicalLemmas/Measure.lean`
- `AutoSamplingTheory/TechnicalLemmas/Variational.lean`
- `AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean`
- `AutoSamplingTheory/TechnicalLemmas/Registry.lean`

The Lean registry entry point is:

```lean
AutoSamplingTheory.TechnicalLemmas.technicalLemmaMemory
```

Human-readable compiled inventory:

- `research-wiki/technical-lemma-memory/compiled_sublemma_inventory.md`

## Agent Search Order

1. Search `AutoSamplingTheory/TechnicalLemmas`.
2. Search current theorem files such as `AutoSamplingTheory/SALD.lean`.
3. Search this directory's registry and SALD map.
4. Only then inspect external SLT files as port candidates.
5. If a useful upstream theorem is found, add an ASTIS-native Lean declaration
   or a precise proof obligation.  Do not add the upstream repo as a Lake
   dependency.
