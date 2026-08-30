import AutoSamplingTheory.TechnicalLemmas.InformationTheory.SimultaneousFDivergenceAbstractIntegral
import AutoSamplingTheory.TechnicalLemmas.InformationTheory.SimultaneousFDivergenceIntegral

/-!
# Density-level abstract simultaneous f-divergence dissipation join

This module is the thin join immediately below the source-facing form of Chewi
Theorem 8.3.1.  The hard ingredients remain separate parents:

* dominated differentiation supplies the derivative of
  `∫ q_t f(p_t/q_t)` as the integral of `derivativeIntegrand`;
* the weak-adjoint step rewrites that derivative value as two generator
  pairings;
* the abstract diffusion cancellation plus integrability rewrites those two
  pairings as the negative carré-du-champ dissipation integral.

The theorem below only composes those edges.  It does not manufacture a weak
forward equation, density ratio, diffusion chain rule, or integrability fact.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace InformationTheory
namespace SimultaneousFDivergenceAbstractDissipation

open MeasureTheory
open StochasticProcesses

noncomputable section

/-- Compose dominated differentiation, the selected-time weak-adjoint rewrite,
and the abstract integral cancellation into the density-level dissipation
derivative.

`hWeakAdjoint` is exactly the output shape of the weak-adjoint adapter (#224).
All remaining hypotheses are the explicit analytic/algebraic parents consumed
by the integral cancellation (#225). -/
theorem hasDerivAt_eq_abstract_dissipation
    {X : Type*} [MeasurableSpace X]
    (base : Measure X)
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (domain : Set (X → ℝ))
    (hDiffusion : DiffusionChainRule.DiffusionChainRuleOn generator domain)
    (p q pDot qDot : ℝ → X → ℝ)
    (mu rho nu : X → ℝ)
    (hrho : rho ∈ domain)
    (f fPrime fSecond : ℝ → ℝ)
    (hfPrime : ∀ r : ℝ, HasDerivAt fPrime (fSecond r) r)
    (s0 : ℝ)
    (hTimeDerivative :
      HasDerivAt
        (fun s => ∫ x, q s x * f (p s x / q s x) ∂base)
        (∫ x,
          SimultaneousFDivergenceIntegral.derivativeIntegrand
            p q pDot qDot f fPrime s0 x ∂base) s0)
    (hWeakAdjoint :
      (∫ x,
          SimultaneousFDivergenceIntegral.derivativeIntegrand
            p q pDot qDot f fPrime s0 x ∂base) =
        (∫ x,
          SimultaneousFDivergenceAbstractIntegral.numeratorGeneratorPairing
            generator mu rho fPrime x ∂base) +
        ∫ x,
          SimultaneousFDivergenceAbstractIntegral.referenceGeneratorPairing
            generator rho nu f fPrime x ∂base)
    (hNumeratorInt :
      Integrable
        (SimultaneousFDivergenceAbstractIntegral.numeratorGeneratorPairing
          generator mu rho fPrime) base)
    (hReferenceInt :
      Integrable
        (SimultaneousFDivergenceAbstractIntegral.referenceGeneratorPairing
          generator rho nu f fPrime) base)
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
    HasDerivAt
      (fun s => ∫ x, q s x * f (p s x / q s x) ∂base)
      (∫ x,
        SimultaneousFDivergenceAbstractIntegral.abstractDissipationIntegrand
          generator rho nu fSecond x ∂base) s0 := by
  have hDissipation :=
    SimultaneousFDivergenceAbstractIntegral.generator_pairing_integrals_eq_dissipation
      base generator domain hDiffusion mu rho nu hrho f fPrime fSecond hfPrime
      hNumeratorInt hReferenceInt hmu hProduct hGeneratorChain
  have hDerivativeValue :
      (∫ x,
          SimultaneousFDivergenceIntegral.derivativeIntegrand
            p q pDot qDot f fPrime s0 x ∂base) =
        ∫ x,
          SimultaneousFDivergenceAbstractIntegral.abstractDissipationIntegrand
            generator rho nu fSecond x ∂base :=
    hWeakAdjoint.trans hDissipation
  rw [hDerivativeValue] at hTimeDerivative
  exact hTimeDerivative

end

end SimultaneousFDivergenceAbstractDissipation
end InformationTheory
end TechnicalLemmas
end AutoSamplingTheory
