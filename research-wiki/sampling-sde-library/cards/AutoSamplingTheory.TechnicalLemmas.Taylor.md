# AutoSamplingTheory.TechnicalLemmas.Taylor

- File: `AutoSamplingTheory/TechnicalLemmas/Taylor.lean`
- Layer: Mathlib-ready technical lemma
- Purpose: Hessian/operator norm bridges, orthonormal basis unit, quadratic normalization
- Mathlib-quality status: small calculus/algebra leaves; SALD names need generalization before upstream

## Imports

- `Mathlib.Analysis.Calculus.FDeriv.Basic`
- `Mathlib.Analysis.Calculus.IteratedDeriv.Lemmas`
- `Mathlib.Analysis.InnerProductSpace.PiL2`
- `Mathlib.Analysis.Normed.Module.Multilinear.Basic`
- `Mathlib.LinearAlgebra.FiniteDimensional.Basic`

## Representative Declarations And Exports

- `hessianOpNormOfSourceHessianField`
- `iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm`
- `stdOrthonormalBasisUnit`
- `quadraticVariationNormalizationOfCoeffDefAndVarianceOne`

## Agent Usage

Search this card before inventing a nearby technical lemma.  If the needed fact
is generic and missing, create a Mathlib-ready leaf packet rather than hiding
the requirement inside a paper-specific theorem.
