# AutoSamplingTheory.TechnicalLemmas.Measure

- File: `AutoSamplingTheory/TechnicalLemmas/Measure.lean`
- Layer: Mathlib-ready technical lemma
- Purpose: search surface for law-map, dominated derivative, conditional-distribution lemmas
- Mathlib-quality status: re-export surface over compiled generic probability lemmas

## Imports

- `AutoSamplingTheory.Probability`

## Representative Declarations And Exports

- `integrable_of_measure_eq`
- `condDistribAeEqCondExpKernelMap`
- `condDistribIntegralAEStronglyMeasurable`
- `condDistribIntegralIntegrable`
- `condDistribIntegralMapAEStronglyMeasurable`
- `condDistribIntegralMapIntegrable`
- `condDistribIntegralMapIntegral`
- `condDistribIntegralNamedFieldRegularity`
- `condDistribIntegralNamedLawAEStronglyMeasurable`
- `condDistribIntegralNamedLawIntegrable`
- `condDistribIntegralNamedLawIntegral`
- `condDistribIntegralSampleAeEqOfCondExpKernelMap`
- `lawIntegralHasDerivAtOfMeasureMapEqAndDominated`
- `lawIntegralHasDerivAtOfMeasureMapEqAndSample`
- `lawMapEqOfAEEq`
- `lawMapIntegral`
- `lawMapIntegralHasDerivAtOfDominated`
- `lawMapIntegralHasDerivAtOfSample`
- `lawMapProdEqOfAEEq`
- `lawMapProdFst`
- `lawMapProdSnd`
- `lawMapProdSwap`

## Agent Usage

Search this card before inventing a nearby technical lemma.  If the needed fact
is generic and missing, create a Mathlib-ready leaf packet rather than hiding
the requirement inside a paper-specific theorem.
