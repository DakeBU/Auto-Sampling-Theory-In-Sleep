import AutoSamplingTheory.TechnicalLemmas.InformationTheory.SimultaneousFDivergenceIntegral
import Mathlib.Tactic

/-!
# Weak-adjoint rewrite for simultaneous f-divergence

Chewi Theorem 8.3.1 first differentiates the simultaneous `f`-divergence and
then uses

`∂ₜ μₜ = Lₜ* μₜ`,  `∂ₜ νₜ = Lₜ* νₜ`

to move the two time derivatives onto the generator acting on frozen
observables.  `SimultaneousFDivergenceIntegral` already formalizes the first
step in a fixed dominating-measure density presentation.  This file isolates
only the second, weak-adjoint rewrite.

No adjoint operator is constructed here.  The two weak pairing identities are
kept explicit because the source theorem allows a time-dependent generator,
whereas the existing `WeakForwardEquation` theorem in Samplinglib concerns a
fixed continuous linear semigroup.  A later bridge may discharge these
pairing identities from a time-dependent weak evolution contract.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace InformationTheory
namespace SimultaneousFDivergenceWeakAdjoint

open MeasureTheory

noncomputable section

/-- Density ratio at the selected time in the common-reference presentation. -/
def densityRatioAt
    {X : Type*} (p q : ℝ → X → ℝ) (s0 : ℝ) : X → ℝ :=
  fun x => p s0 x / q s0 x

/-- The observable paired with the numerator-density time derivative. -/
def numeratorObservable
    {X : Type*} (p q : ℝ → X → ℝ) (fPrime : ℝ → ℝ) (s0 : ℝ) : X → ℝ :=
  fPrime ∘ densityRatioAt p q s0

/-- The observable paired with the reference-density time derivative:
`f(rho) - rho f'(rho)`. -/
def referenceObservable
    {X : Type*}
    (p q : ℝ → X → ℝ) (f fPrime : ℝ → ℝ) (s0 : ℝ) : X → ℝ :=
  (f ∘ densityRatioAt p q s0) -
    densityRatioAt p q s0 * numeratorObservable p q fPrime s0

@[simp]
theorem numeratorObservable_apply
    {X : Type*} (p q : ℝ → X → ℝ) (fPrime : ℝ → ℝ) (s0 : ℝ) (x : X) :
    numeratorObservable p q fPrime s0 x =
      fPrime (p s0 x / q s0 x) :=
  rfl

@[simp]
theorem referenceObservable_apply
    {X : Type*}
    (p q : ℝ → X → ℝ) (f fPrime : ℝ → ℝ) (s0 : ℝ) (x : X) :
    referenceObservable p q f fPrime s0 x =
      f (p s0 x / q s0 x) -
        (p s0 x / q s0 x) * fPrime (p s0 x / q s0 x) :=
  rfl

/-- Linearity of the generator exposes the two source terms in the reference
observable. -/
theorem generator_referenceObservable_apply
    {X : Type*}
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (p q : ℝ → X → ℝ) (f fPrime : ℝ → ℝ) (s0 : ℝ) (x : X) :
    generator (referenceObservable p q f fPrime s0) x =
      generator (f ∘ densityRatioAt p q s0) x -
        generator
          (densityRatioAt p q s0 * numeratorObservable p q fPrime s0) x := by
  change
    generator
        ((f ∘ densityRatioAt p q s0) -
          densityRatioAt p q s0 * numeratorObservable p q fPrime s0) x = _
  rw [map_sub]
  rfl

/-- Weak-adjoint rewrite of the differentiated simultaneous `f`-divergence.

`hNumeratorWeak` and `hReferenceWeak` are exactly the selected-time weak forms
of the two adjoint equations for the frozen observables
`f' ∘ rho` and `f ∘ rho - rho * (f' ∘ rho)`.

This theorem does not infer those weak equations; it joins them to the already
formalized derivative integrand without hiding any PDE or adjoint-domain
assumption. -/
theorem integral_derivativeIntegrand_eq_generator_pairings
    {X : Type*} [MeasurableSpace X]
    (mu : Measure X)
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (p q pDot qDot : ℝ → X → ℝ)
    (f fPrime : ℝ → ℝ) (s0 : ℝ)
    (hNumeratorTimeInt :
      Integrable
        (fun x => numeratorObservable p q fPrime s0 x * pDot s0 x) mu)
    (hReferenceTimeInt :
      Integrable
        (fun x => referenceObservable p q f fPrime s0 x * qDot s0 x) mu)
    (hNumeratorWeak :
      (∫ x, numeratorObservable p q fPrime s0 x * pDot s0 x ∂mu) =
        ∫ x,
          generator (numeratorObservable p q fPrime s0) x * p s0 x ∂mu)
    (hReferenceWeak :
      (∫ x, referenceObservable p q f fPrime s0 x * qDot s0 x ∂mu) =
        ∫ x,
          generator (referenceObservable p q f fPrime s0) x * q s0 x ∂mu) :
    (∫ x,
        SimultaneousFDivergenceIntegral.derivativeIntegrand
          p q pDot qDot f fPrime s0 x ∂mu) =
      (∫ x,
        generator (numeratorObservable p q fPrime s0) x * p s0 x ∂mu) +
      ∫ x,
        generator (referenceObservable p q f fPrime s0) x * q s0 x ∂mu := by
  have hsplit :
      (∫ x,
          SimultaneousFDivergenceIntegral.derivativeIntegrand
            p q pDot qDot f fPrime s0 x ∂mu) =
        (∫ x, numeratorObservable p q fPrime s0 x * pDot s0 x ∂mu) +
        ∫ x, referenceObservable p q f fPrime s0 x * qDot s0 x ∂mu := by
    rw [← integral_add hNumeratorTimeInt hReferenceTimeInt]
    apply integral_congr_ae
    filter_upwards with x
    simp only [SimultaneousFDivergenceIntegral.derivativeIntegrand,
      numeratorObservable_apply, referenceObservable_apply]
  calc
    (∫ x,
        SimultaneousFDivergenceIntegral.derivativeIntegrand
          p q pDot qDot f fPrime s0 x ∂mu) =
        (∫ x, numeratorObservable p q fPrime s0 x * pDot s0 x ∂mu) +
        ∫ x, referenceObservable p q f fPrime s0 x * qDot s0 x ∂mu :=
      hsplit
    _ =
        (∫ x,
          generator (numeratorObservable p q fPrime s0) x * p s0 x ∂mu) +
        ∫ x,
          generator (referenceObservable p q f fPrime s0) x * q s0 x ∂mu := by
      rw [hNumeratorWeak, hReferenceWeak]

/-- Source-expanded version of the weak-adjoint rewrite.  This is the integral
form immediately before the pointwise generator/carré-du-champ cancellation in
Chewi Theorem 8.3.1. -/
theorem integral_derivativeIntegrand_eq_source_generator_pairings
    {X : Type*} [MeasurableSpace X]
    (mu : Measure X)
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (p q pDot qDot : ℝ → X → ℝ)
    (f fPrime : ℝ → ℝ) (s0 : ℝ)
    (hNumeratorTimeInt :
      Integrable
        (fun x => numeratorObservable p q fPrime s0 x * pDot s0 x) mu)
    (hReferenceTimeInt :
      Integrable
        (fun x => referenceObservable p q f fPrime s0 x * qDot s0 x) mu)
    (hNumeratorWeak :
      (∫ x, numeratorObservable p q fPrime s0 x * pDot s0 x ∂mu) =
        ∫ x,
          generator (numeratorObservable p q fPrime s0) x * p s0 x ∂mu)
    (hReferenceWeak :
      (∫ x, referenceObservable p q f fPrime s0 x * qDot s0 x ∂mu) =
        ∫ x,
          generator (referenceObservable p q f fPrime s0) x * q s0 x ∂mu) :
    (∫ x,
        SimultaneousFDivergenceIntegral.derivativeIntegrand
          p q pDot qDot f fPrime s0 x ∂mu) =
      (∫ x,
        generator (numeratorObservable p q fPrime s0) x * p s0 x ∂mu) +
      ∫ x,
        (generator (f ∘ densityRatioAt p q s0) x -
            generator
              (densityRatioAt p q s0 * numeratorObservable p q fPrime s0) x) *
          q s0 x ∂mu := by
  calc
    (∫ x,
        SimultaneousFDivergenceIntegral.derivativeIntegrand
          p q pDot qDot f fPrime s0 x ∂mu) =
      (∫ x,
        generator (numeratorObservable p q fPrime s0) x * p s0 x ∂mu) +
      ∫ x,
        generator (referenceObservable p q f fPrime s0) x * q s0 x ∂mu :=
      integral_derivativeIntegrand_eq_generator_pairings
        mu generator p q pDot qDot f fPrime s0
        hNumeratorTimeInt hReferenceTimeInt hNumeratorWeak hReferenceWeak
    _ =
      (∫ x,
        generator (numeratorObservable p q fPrime s0) x * p s0 x ∂mu) +
      ∫ x,
        (generator (f ∘ densityRatioAt p q s0) x -
            generator
              (densityRatioAt p q s0 * numeratorObservable p q fPrime s0) x) *
          q s0 x ∂mu := by
      congr 1
      apply integral_congr_ae
      filter_upwards with x
      rw [generator_referenceObservable_apply]

end

end SimultaneousFDivergenceWeakAdjoint
end InformationTheory
end TechnicalLemmas
end AutoSamplingTheory
