import AutoSamplingTheory.TechnicalLemmas.InformationTheory.SimultaneousFDivergenceAbstract
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Tactic

/-!
# Integral join for abstract simultaneous f-divergence dissipation

Chewi Theorem 8.3.1 reaches, after the weak-adjoint rewrite, the sum of two
spatial generator pairings.  `SimultaneousFDivergenceAbstract` already proves
the source-shaped pointwise cancellation of their combined integrand to

`- f''(rho) * Gamma(rho,rho) * nu`.

This module performs only the next measure-theoretic join: under explicit
integrability of the two generator-pairing terms, combine their integrals and
transport the pointwise cancellation through the integral.

The public pairing order is chosen to match the upstream weak-adjoint adapter:
the reference term contains `rho * (f' ∘ rho)`.  The downstream pointwise
cancellation branch currently uses the commuted product `(f' ∘ rho) * rho`, so
that harmless commutativity rewrite stays internal to the proof rather than
becoming another graph/API edge.

The integrability hypotheses are intentionally visible.  Mathlib's Bochner
integral is totalized, so omitting them from the step that rewrites a sum of
integrals as the integral of a sum would silently hide a genuine analytic
obligation.

No time derivative, adjoint operator, density-ratio construction, or final
source-facing Theorem 8.3.1 is asserted here.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace InformationTheory
namespace SimultaneousFDivergenceAbstractIntegral

open MeasureTheory
open StochasticProcesses

noncomputable section

/-- The first generator pairing after the weak-adjoint rewrite. -/
def numeratorGeneratorPairing
    {X : Type*}
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (mu rho : X → ℝ) (fPrime : ℝ → ℝ) : X → ℝ :=
  fun x => generator (fPrime ∘ rho) x * mu x

/-- The reference-density generator pairing after expanding
`L(f(rho) - rho f'(rho))` by linearity.  The product order deliberately matches
`SimultaneousFDivergenceWeakAdjoint.referenceObservable`. -/
def referenceGeneratorPairing
    {X : Type*}
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (rho nu : X → ℝ) (f fPrime : ℝ → ℝ) : X → ℝ :=
  fun x =>
    (generator (f ∘ rho) x -
      generator (rho * (fPrime ∘ rho)) x) * nu x

/-- The source dissipation integrand after the diffusion cancellation. -/
def abstractDissipationIntegrand
    {X : Type*}
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (rho nu : X → ℝ) (fSecond : ℝ → ℝ) : X → ℝ :=
  fun x =>
    -fSecond (rho x) *
      CarreDuChamp.carreDuChamp generator rho rho x * nu x

/-- The source generator integrand and the dissipation integrand agree almost
everywhere once the three pointwise parent contracts hold almost everywhere. -/
theorem source_generator_integrand_ae_eq_dissipation
    {X : Type*} [MeasurableSpace X]
    (base : Measure X)
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (domain : Set (X → ℝ))
    (hDiffusion : DiffusionChainRule.DiffusionChainRuleOn generator domain)
    (mu rho nu : X → ℝ)
    (hrho : rho ∈ domain)
    (f fPrime fSecond : ℝ → ℝ)
    (hfPrime : ∀ r : ℝ, HasDerivAt fPrime (fSecond r) r)
    (hmu : ∀ᵐ x ∂base, mu x = rho x * nu x)
    (hProduct :
      ∀ᵐ x ∂base,
        generator ((fPrime ∘ rho) * rho) x =
          2 * CarreDuChamp.carreDuChamp generator (fPrime ∘ rho) rho x +
            fPrime (rho x) * generator rho x +
            rho x * generator (fPrime ∘ rho) x)
    (hGeneratorChain :
      ∀ᵐ x ∂base,
        generator (f ∘ rho) x =
          fPrime (rho x) * generator rho x +
            fSecond (rho x) *
              CarreDuChamp.carreDuChamp generator rho rho x) :
    (fun x =>
        numeratorGeneratorPairing generator mu rho fPrime x +
          referenceGeneratorPairing generator rho nu f fPrime x) =ᵐ[base]
      abstractDissipationIntegrand generator rho nu fSecond := by
  have hmul : rho * (fPrime ∘ rho) = (fPrime ∘ rho) * rho := by
    funext y
    simp [mul_comm]
  filter_upwards [hmu, hProduct, hGeneratorChain] with x hmu_x hprod_x hchain_x
  have hcancel :=
    SimultaneousFDivergenceAbstract.source_pointwise_cancellation
      generator domain hDiffusion mu rho nu hrho f fPrime fSecond hfPrime x
      hmu_x hprod_x hchain_x
  dsimp [numeratorGeneratorPairing, referenceGeneratorPairing,
    abstractDissipationIntegrand]
  rw [hmul]
  calc
    generator (fPrime ∘ rho) x * mu x +
        (generator (f ∘ rho) x -
          generator ((fPrime ∘ rho) * rho) x) * nu x =
      generator (fPrime ∘ rho) x * mu x -
        generator ((fPrime ∘ rho) * rho) x * nu x +
        generator (f ∘ rho) x * nu x := by
      ring
    _ =
      -fSecond (rho x) *
        CarreDuChamp.carreDuChamp generator rho rho x * nu x :=
      hcancel

/-- Integral form of the abstract pointwise cancellation.

The two integrability assumptions are exactly what is needed to turn the sum of
the two generator-pairing integrals into one integral before applying the a.e.
source cancellation. -/
theorem generator_pairing_integrals_eq_dissipation
    {X : Type*} [MeasurableSpace X]
    (base : Measure X)
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (domain : Set (X → ℝ))
    (hDiffusion : DiffusionChainRule.DiffusionChainRuleOn generator domain)
    (mu rho nu : X → ℝ)
    (hrho : rho ∈ domain)
    (f fPrime fSecond : ℝ → ℝ)
    (hfPrime : ∀ r : ℝ, HasDerivAt fPrime (fSecond r) r)
    (hNumeratorInt :
      Integrable (numeratorGeneratorPairing generator mu rho fPrime) base)
    (hReferenceInt :
      Integrable (referenceGeneratorPairing generator rho nu f fPrime) base)
    (hmu : ∀ᵐ x ∂base, mu x = rho x * nu x)
    (hProduct :
      ∀ᵐ x ∂base,
        generator ((fPrime ∘ rho) * rho) x =
          2 * CarreDuChamp.carreDuChamp generator (fPrime ∘ rho) rho x +
            fPrime (rho x) * generator rho x +
            rho x * generator (fPrime ∘ rho) x)
    (hGeneratorChain :
      ∀ᵐ x ∂base,
        generator (f ∘ rho) x =
          fPrime (rho x) * generator rho x +
            fSecond (rho x) *
              CarreDuChamp.carreDuChamp generator rho rho x) :
    (∫ x, numeratorGeneratorPairing generator mu rho fPrime x ∂base) +
        ∫ x, referenceGeneratorPairing generator rho nu f fPrime x ∂base =
      ∫ x, abstractDissipationIntegrand generator rho nu fSecond x ∂base := by
  rw [← integral_add hNumeratorInt hReferenceInt]
  exact integral_congr_ae
    (source_generator_integrand_ae_eq_dissipation
      base generator domain hDiffusion mu rho nu hrho f fPrime fSecond hfPrime
      hmu hProduct hGeneratorChain)

end

end SimultaneousFDivergenceAbstractIntegral
end InformationTheory
end TechnicalLemmas
end AutoSamplingTheory
