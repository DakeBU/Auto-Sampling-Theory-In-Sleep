import Mathlib.Probability.Distributions.Gaussian.Real
import Mathlib.Probability.Distributions.Gaussian.Multivariate
import Mathlib.Probability.Independence.Basic

/-!
# ASTIS-native Gaussian technical lemmas

This module stores the local ASTIS versions of Gaussian facts that are useful
for SDE/Sampling proof backends.  Some statements were selected after auditing
nearby results in `YuanheZ/lean-stat-learning-theory`, but the declarations
below are ASTIS-owned Lean code and do not import that project.
-/

noncomputable section

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Gaussian

open MeasureTheory ProbabilityTheory

/-- Product standard Gaussian measure on coordinate functions. -/
noncomputable def stdGaussianPi (n : ℕ) : Measure (Fin n → ℝ) :=
  Measure.pi fun _ : Fin n => gaussianReal 0 1

instance stdGaussianPi_isProbabilityMeasure (n : ℕ) :
    IsProbabilityMeasure (stdGaussianPi n) := by
  unfold stdGaussianPi
  infer_instance

instance stdGaussianPi_isFiniteMeasure (n : ℕ) :
    IsFiniteMeasure (stdGaussianPi n) :=
  inferInstance

/-- Coordinate projections under the ASTIS product Gaussian are standard normal. -/
theorem map_eval_stdGaussianPi {n : ℕ} (i : Fin n) :
    Measure.map (fun w : Fin n → ℝ => w i) (stdGaussianPi n) =
      gaussianReal 0 1 := by
  unfold stdGaussianPi
  exact (measurePreserving_eval (fun _ : Fin n => gaussianReal 0 1) i).map_eq

/-- The centered real Gaussian has zero mean. -/
theorem integral_id_gaussianReal_zero (v : NNReal) :
    ∫ x : ℝ, x ∂(gaussianReal 0 v) = 0 := by
  simp

/-- The unit real Gaussian has unit variance in the real-valued Mathlib variance convention. -/
theorem variance_id_gaussianReal_zero_one :
    ProbabilityTheory.variance (id : ℝ → ℝ) (gaussianReal 0 (1 : NNReal)) =
      (1 : ℝ) := by
  simp

/-- Package a scalar-coordinate Gaussian law and a variance-field definition
into the `NNReal` unit-variance field used by Brownian/Ito normalizations. -/
theorem nnrealVarianceOneOfGaussianRealUnitLaw
    {α : Type*} (varianceField : α → NNReal)
    (coordinateLaw : α → Measure ℝ)
    (hVarianceDef :
      ∀ a,
        (varianceField a : ℝ) =
          ProbabilityTheory.variance (id : ℝ → ℝ) (coordinateLaw a))
    (hCoordinateLaw :
      ∀ a, coordinateLaw a = gaussianReal 0 (1 : NNReal)) :
    ∀ a, varianceField a = (1 : NNReal) := by
  intro a
  exact NNReal.coe_injective (by
    calc
      (varianceField a : ℝ) =
          ProbabilityTheory.variance (id : ℝ → ℝ) (coordinateLaw a) :=
        hVarianceDef a
      _ =
          ProbabilityTheory.variance (id : ℝ → ℝ)
            (gaussianReal 0 (1 : NNReal)) := by
        rw [hCoordinateLaw a]
      _ = (1 : ℝ) := variance_id_gaussianReal_zero_one)

/-- Convert an `NNReal` unit-variance field into the real-valued unit field
that often appears after algebraic normalization. -/
theorem realVarianceOneOfNNRealVarianceOne
    {α : Type*} (varianceField : α → NNReal)
    (hVarianceOne : ∀ a, varianceField a = (1 : NNReal)) :
    ∀ a, (varianceField a : ℝ) = 1 := by
  intro a
  rw [hVarianceOne a]
  norm_num

end Gaussian
end TechnicalLemmas
end AutoSamplingTheory

