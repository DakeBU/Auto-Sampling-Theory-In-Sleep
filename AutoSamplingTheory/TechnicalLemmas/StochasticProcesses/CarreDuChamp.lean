import Mathlib.Algebra.Module.LinearMap.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

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

end CarreDuChamp
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
