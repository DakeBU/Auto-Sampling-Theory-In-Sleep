# AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.WeakGenerator

- File: `AutoSamplingTheory\TechnicalLemmas\StochasticProcesses\WeakGenerator.lean`
- Layer: Mathlib-ready technical lemma
- Purpose: sample-space generator derivative to named law weak-generator rewrite
- Mathlib-quality status: preferred Mathlib-style location for weak FP generator bridge leaves

## Imports

- `AutoSamplingTheory.Probability`

## Representative Declarations And Exports

- `weakGeneratorFromSampleDerivative`

## Curated Formalized Memory Entries

- `weak-generator.sample-to-law-derivative` -> `weakGeneratorFromSampleDerivative` (Mathlib Measure.map / ASTIS lawIntegralHasDerivAtOfMeasureMapEqAndSample)

## Agent Usage

Search this card before inventing a nearby technical lemma.  If the needed fact
is generic and missing, create a Mathlib-ready leaf packet rather than hiding
the requirement inside a paper-specific theorem.
