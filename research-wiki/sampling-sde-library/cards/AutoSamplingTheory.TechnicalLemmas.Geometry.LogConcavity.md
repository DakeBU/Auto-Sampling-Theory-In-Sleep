# AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity

- File: `AutoSamplingTheory/TechnicalLemmas/Geometry/LogConcavity.lean`
- Layer: Mathlib-ready technical lemma
- Purpose: positive-function log-concavity API over Mathlib ConcaveOn
- Mathlib-quality status: first compiled Chewi CONV/DENS leaf; extend toward density and Prekopa-Leindler interfaces

## Imports

- `Mathlib.Analysis.Convex.SpecificFunctions.Basic`

## Representative Declarations And Exports

- `LogConcaveOn`
- `logConcaveOn_iff`
- `logConcaveOn_of_concave_log`
- `LogConcaveOn.pos`
- `LogConcaveOn.concaveOn_log`
- `LogConcaveOn.convex_domain`
- `LogConcaveOn.subset`
- `LogConcaveOn.const_mul`
- `logConcaveOn_const`
- `logConcaveOn_exp_neg_of_convexOn`
- `logConcaveOn_const_mul_exp_neg_of_convexOn`
- `logConcaveOn_id_Ioi`

## Curated Formalized Memory Entries

- `geometry.log-concavity.def` -> `LogConcaveOn` (Mathlib.Analysis.Convex.Function; Mathlib.Analysis.Convex.SpecificFunctions.Basic)
- `geometry.log-concavity.positive-ray-id` -> `logConcaveOn_id_Ioi` (Mathlib.Analysis.Convex.SpecificFunctions.Basic)
- `geometry.log-concavity.positive-rescale` -> `const_mul` (Mathlib.Analysis.Convex.Function; Mathlib.Analysis.SpecialFunctions.Log.Basic)
- `geometry.gibbs-density.convex-potential` -> `logConcaveOn_const_mul_exp_neg_of_convexOn` (Mathlib.Analysis.Convex.Function; Mathlib.Analysis.SpecialFunctions.Log.Basic)

## Agent Usage

Search this card before inventing a nearby technical lemma.  If the needed fact
is generic and missing, create a Mathlib-ready leaf packet rather than hiding
the requirement inside a paper-specific theorem.
