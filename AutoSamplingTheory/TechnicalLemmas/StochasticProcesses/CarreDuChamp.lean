import Mathlib.Algebra.Module.LinearMap.Basic
import Mathlib.Data.Real.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Tactic.Ring
import AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.Generator

noncomputable section

/-!
# Carre du champ and Bakry-Emery curvature

This file formalizes Chewi's Definitions 1.2.12, 1.2.28, and 1.2.29 for a
linear generator acting on real-valued observables.  It is the algebraic
interface shared by Markov semigroup arguments and the later concrete
Langevin identification.

No positivity, diffusion chain rule, invariant measure, or Bakry-Emery
theorem is assumed here.  Those are mathematical properties of a particular
generator and remain separate downstream results.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace CarreDuChamp

open MeasureTheory

variable {X : Type*}

/-- Chewi Definition 1.2.12: the carre du champ of a linear generator. -/
def carreDuChamp
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (f g : X → ℝ) : X → ℝ :=
  fun x => (2 : ℝ)⁻¹ *
    (generator (f * g) x - f x * generator g x - g x * generator f x)

/-- The carre du champ is symmetric in its observable arguments. -/
theorem carreDuChamp_comm
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (f g : X → ℝ) :
    carreDuChamp generator f g = carreDuChamp generator g f := by
  funext x
  have hfg : f * g = g * f := by
    funext y
    exact mul_comm (f y) (g y)
  simp only [carreDuChamp, hfg]
  ring

/-- Chewi Definition 1.2.28: the iterated carre du champ. -/
def iteratedCarreDuChamp
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (f g : X → ℝ) : X → ℝ :=
  fun x => (2 : ℝ)⁻¹ *
    (generator (carreDuChamp generator f g) x
      - carreDuChamp generator f (generator g) x
      - carreDuChamp generator g (generator f) x)

/-- The iterated carre du champ inherits symmetry from the first one. -/
theorem iteratedCarreDuChamp_comm
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (f g : X → ℝ) :
    iteratedCarreDuChamp generator f g =
      iteratedCarreDuChamp generator g f := by
  funext x
  simp only [iteratedCarreDuChamp, carreDuChamp_comm]
  ring

/-- Chewi Definition 1.2.29: the curvature-dimension condition
`CD(alpha, infinity)`, including the source requirement `alpha > 0`. -/
def SatisfiesBakryEmery
    (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (alpha : ℝ) : Prop :=
  0 < alpha ∧ ∀ (f : X → ℝ) (x : X),
    alpha * carreDuChamp generator f f x ≤
      iteratedCarreDuChamp generator f f x

/-- Chewi Theorem 1.2.14: stationarity and generator symmetry imply the
fundamental integration-by-parts identity between the Dirichlet form and the
integrated carre du champ.

The three integrability hypotheses are the exact terms expanded from Gamma;
they prevent the totalized Bochner integral from hiding a domain failure. -/
theorem fundamental_integration_by_parts
    [MeasurableSpace X]
    (mu : Measure X) (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (f g : X → ℝ)
    (hLfg : Integrable (generator (f * g)) mu)
    (hfLg : Integrable (fun x => f x * generator g x) mu)
    (hgLf : Integrable (fun x => g x * generator f x) mu)
    (hstationary : (∫ x, generator (f * g) x ∂mu) = 0)
    (hsymmetric :
      (∫ x, f x * generator g x ∂mu) =
        ∫ x, g x * generator f x ∂mu) :
    FunctionalInequalities.Generator.dirichletForm mu generator f g =
        FunctionalInequalities.Generator.dirichletForm mu generator g f ∧
      FunctionalInequalities.Generator.dirichletForm mu generator f g =
        ∫ x, carreDuChamp generator f g x ∂mu := by
  have hsub : Integrable
      (fun x => generator (f * g) x - f x * generator g x) mu :=
    hLfg.sub hfLg
  have hgammaIntegral :
      (∫ x, carreDuChamp generator f g x ∂mu) =
        (2 : ℝ)⁻¹ *
          ((∫ x, generator (f * g) x ∂mu) -
            (∫ x, f x * generator g x ∂mu) -
            ∫ x, g x * generator f x ∂mu) := by
    change
      (∫ x, (2 : ℝ)⁻¹ *
        (generator (f * g) x - f x * generator g x -
          g x * generator f x) ∂mu) = _
    rw [integral_const_mul,
      integral_sub hsub hgLf, integral_sub hLfg hfLg]
  constructor
  · simp only [FunctionalInequalities.Generator.dirichletForm]
    rw [hsymmetric]
  · simp only [FunctionalInequalities.Generator.dirichletForm]
    rw [hgammaIntegral, hstationary, hsymmetric]
    ring

/-- Chewi Corollary 1.2.15: the negative reversible generator has a
nonnegative quadratic form once Gamma is pointwise nonnegative. -/
theorem negativeGenerator_quadratic_nonneg
    [MeasurableSpace X]
    (mu : Measure X) (generator : (X → ℝ) →ₗ[ℝ] (X → ℝ))
    (f : X → ℝ)
    (hLf2 : Integrable (generator (f * f)) mu)
    (hfLf : Integrable (fun x => f x * generator f x) mu)
    (hstationary : (∫ x, generator (f * f) x ∂mu) = 0)
    (hgamma : ∀ x, 0 ≤ carreDuChamp generator f f x) :
    0 ≤ FunctionalInequalities.Generator.dirichletForm mu generator f f := by
  have hibp := fundamental_integration_by_parts mu generator f f
    hLf2 hfLf hfLf hstationary rfl
  rw [hibp.2]
  exact integral_nonneg_of_ae (Filter.Eventually.of_forall hgamma)

end CarreDuChamp
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
