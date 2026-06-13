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

/-- Coordinate projections under the ASTIS product Gaussian are integrable. -/
theorem integrable_eval_stdGaussianPi {n : ℕ} (i : Fin n) :
    Integrable (fun w : Fin n → ℝ => w i) (stdGaussianPi n) := by
  have hExpPos :
      Integrable (fun z : ℝ => Real.exp ((1 : ℝ) * z))
        (gaussianReal 0 (1 : NNReal)) := by
    simpa using
      ProbabilityTheory.integrable_exp_mul_gaussianReal
        (μ := (0 : ℝ)) (v := (1 : NNReal)) (t := (1 : ℝ))
  have hExpNeg :
      Integrable (fun z : ℝ => Real.exp (-(1 : ℝ) * z))
        (gaussianReal 0 (1 : NNReal)) := by
    simpa using
      ProbabilityTheory.integrable_exp_mul_gaussianReal
        (μ := (0 : ℝ)) (v := (1 : NNReal)) (t := (-(1 : ℝ)))
  have hId :
      Integrable (fun z : ℝ => z) (gaussianReal 0 (1 : NNReal)) := by
    simpa using
      ProbabilityTheory.integrable_pow_of_integrable_exp_mul
        (X := fun z : ℝ => z)
        (μ := gaussianReal 0 (1 : NNReal))
        (t := (1 : ℝ)) (by norm_num) hExpPos hExpNeg 1
  have hStrong :
      AEStronglyMeasurable (fun z : ℝ => z)
        (Measure.map (fun w : Fin n → ℝ => w i) (stdGaussianPi n)) := by
    rw [map_eval_stdGaussianPi i]
    exact measurable_id.aestronglyMeasurable
  have hEval :
      AEMeasurable (fun w : Fin n → ℝ => w i) (stdGaussianPi n) :=
    (measurable_pi_apply i).aemeasurable
  have hMap :
      Integrable (fun z : ℝ => z)
        (Measure.map (fun w : Fin n → ℝ => w i) (stdGaussianPi n)) := by
    simpa [map_eval_stdGaussianPi i] using hId
  simpa [Function.comp_def] using
    (integrable_map_measure hStrong hEval).mp hMap

/-- A centered real Gaussian integrates every scalar quadratic bound.

This is the reusable Gaussian integrability fact needed by the SALD normalized
remainder bound `fun z => C * z ^ 2`.
-/
theorem integrable_const_mul_sq_gaussianReal_zero (v : NNReal) (C : ℝ) :
    Integrable (fun z : ℝ => C * z ^ 2) (gaussianReal 0 v) := by
  have hExpPos :
      Integrable (fun z : ℝ => Real.exp ((1 : ℝ) * z)) (gaussianReal 0 v) := by
    simpa using
      ProbabilityTheory.integrable_exp_mul_gaussianReal
        (μ := (0 : ℝ)) (v := v) (t := (1 : ℝ))
  have hExpNeg :
      Integrable (fun z : ℝ => Real.exp (-(1 : ℝ) * z)) (gaussianReal 0 v) := by
    simpa using
      ProbabilityTheory.integrable_exp_mul_gaussianReal
        (μ := (0 : ℝ)) (v := v) (t := (-(1 : ℝ)))
  have hSq :
      Integrable (fun z : ℝ => z ^ 2) (gaussianReal 0 v) := by
    exact
      ProbabilityTheory.integrable_pow_of_integrable_exp_mul
        (X := fun z : ℝ => z)
        (μ := gaussianReal 0 v)
        (t := (1 : ℝ)) (by norm_num) hExpPos hExpNeg 2
  exact hSq.const_mul C

/-- Coordinate squares under the ASTIS product Gaussian are integrable. -/
theorem integrable_sq_eval_stdGaussianPi {n : ℕ} (i : Fin n) :
    Integrable (fun w : Fin n → ℝ => (w i) ^ 2) (stdGaussianPi n) := by
  have hSq :
      Integrable (fun z : ℝ => z ^ 2) (gaussianReal 0 (1 : NNReal)) := by
    simpa using
      integrable_const_mul_sq_gaussianReal_zero (v := (1 : NNReal)) (C := (1 : ℝ))
  have hStrong :
      AEStronglyMeasurable (fun z : ℝ => z ^ 2)
        (Measure.map (fun w : Fin n → ℝ => w i) (stdGaussianPi n)) := by
    rw [map_eval_stdGaussianPi i]
    exact Measurable.aestronglyMeasurable (measurable_id.pow_const 2)
  have hEval :
      AEMeasurable (fun w : Fin n → ℝ => w i) (stdGaussianPi n) :=
    (measurable_pi_apply i).aemeasurable
  have hMap :
      Integrable (fun z : ℝ => z ^ 2)
        (Measure.map (fun w : Fin n → ℝ => w i) (stdGaussianPi n)) := by
    simpa [map_eval_stdGaussianPi i] using hSq
  simpa [Function.comp_def] using
    (integrable_map_measure hStrong hEval).mp hMap

/-- Coordinate projections under the ASTIS product Gaussian have zero mean. -/
theorem integral_eval_stdGaussianPi {n : ℕ} (i : Fin n) :
    ∫ w : Fin n → ℝ, w i ∂(stdGaussianPi n) = 0 := by
  have hStrong :
      AEStronglyMeasurable (fun z : ℝ => z)
        (Measure.map (fun w : Fin n → ℝ => w i) (stdGaussianPi n)) := by
    rw [map_eval_stdGaussianPi i]
    exact measurable_id.aestronglyMeasurable
  have hEval :
      AEMeasurable (fun w : Fin n → ℝ => w i) (stdGaussianPi n) :=
    (measurable_pi_apply i).aemeasurable
  calc
    ∫ w : Fin n → ℝ, w i ∂(stdGaussianPi n)
        = ∫ z : ℝ, z ∂(Measure.map (fun w : Fin n → ℝ => w i)
            (stdGaussianPi n)) := by
          rw [integral_map hEval hStrong]
    _ = ∫ z : ℝ, z ∂(gaussianReal 0 (1 : NNReal)) := by
          rw [map_eval_stdGaussianPi i]
    _ = 0 := integral_id_gaussianReal_zero (1 : NNReal)

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
