# AutoSamplingTheory.TechnicalLemmas.Registry

- File: `AutoSamplingTheory/TechnicalLemmas/Registry.lean`
- Layer: memory index
- Purpose: compiled lemma-memory metadata and external port queue
- Mathlib-quality status: agent retrieval registry, not theorem content

## Imports

- `AutoSamplingTheory.Core`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian`
- `AutoSamplingTheory.TechnicalLemmas.Measure`
- `AutoSamplingTheory.TechnicalLemmas.Taylor`
- `AutoSamplingTheory.TechnicalLemmas.Variational`

## Representative Declarations And Exports

- `LemmaMemoryStatus`
- `LemmaMemoryEntry`
- `sltSourceAnchor`
- `gaussianMemory`
- `taylorMemory`
- `measureMemory`
- `variationalMemory`
- `saldExtractedMemory`
- `portQueueMemory`
- `technicalLemmaMemory`
- `formalizedTechnicalLemmaCount`

## Agent Usage

Search this card before inventing a nearby technical lemma.  If the needed fact
is generic and missing, create a Mathlib-ready leaf packet rather than hiding
the requirement inside a paper-specific theorem.
