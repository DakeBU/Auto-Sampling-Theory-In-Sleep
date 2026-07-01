import AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs
import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform

/-!
# Integrability leaves

Reusable integrability bridges for Chewi-style log-concave sampling.

The Gibbs target-measure API lives in `Measure.Gibbs`; this file supplies the
analytic tail estimates that make those normalization contracts usable on
Lebesgue space.  The first concrete tail is a finite-dimensional quadratic
lower-bound envelope, built from Mathlib's Gaussian Fourier/integral API.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Analysis
namespace Integrability

open scoped ENNReal NNReal RealInnerProductSpace

open MeasureTheory
open Complex hiding exp continuous_exp

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

/-- A nonnegative integrable real function has finite `ℝ≥0∞` lintegral after
`ENNReal.ofReal`. -/
theorem lintegral_ofReal_ne_top_of_integrable_nonneg {f : α → ℝ}
    (hf : Integrable f μ) (hf_nonneg : 0 ≤ᵐ[μ] f) :
    ∫⁻ x, ENNReal.ofReal (f x) ∂μ ≠ ∞ :=
  (lintegral_ofReal_ne_top_iff_integrable hf.aestronglyMeasurable hf_nonneg).2 hf

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]

/-- Finite-dimensional Gaussian quadratic tails are Lebesgue-integrable. -/
theorem integrable_exp_neg_mul_norm_sq {a : ℝ} (ha : 0 < a) :
    Integrable (fun x : E => Real.exp (-a * ‖x‖ ^ 2)) volume := by
  have hcx : Integrable
      (fun x : E =>
        cexp (-(a : ℂ) * (‖x‖ : ℂ) ^ 2 + 0 * (⟪(0 : E), x⟫ : ℂ))) volume := by
    simpa using GaussianFourier.integrable_cexp_neg_mul_sq_norm_add (V := E)
      (b := (a : ℂ)) (w := (0 : E)) (c := 0) (by simpa using ha)
  have hre : Integrable
      (fun x : E => (cexp (-(a : ℂ) * (‖x‖ : ℂ) ^ 2)).re) volume := by
    simpa only [zero_mul, add_zero] using hcx.re
  refine hre.congr ?_
  filter_upwards with x
  have harg :
      (-(a : ℂ) * (‖x‖ : ℂ) ^ 2) = ((-(a * ‖x‖ ^ 2) : ℝ) : ℂ) := by
    norm_num [Complex.ofReal_mul, Complex.ofReal_pow]
  rw [harg, Complex.exp_ofReal_re]
  ring_nf

/-- A shifted finite-dimensional Gaussian quadratic tail is
Lebesgue-integrable. -/
theorem integrable_exp_neg_add_mul_norm_sq {a b : ℝ} (ha : 0 < a) :
    Integrable (fun x : E => Real.exp (-(a * ‖x‖ ^ 2 + b))) volume := by
  have h := (integrable_exp_neg_mul_norm_sq (E := E) ha).const_mul (Real.exp (-b))
  refine h.congr ?_
  filter_upwards with x
  rw [show -(a * ‖x‖ ^ 2 + b) = -b + (-a * ‖x‖ ^ 2) by ring]
  rw [Real.exp_add]

/-- The `ℝ≥0∞` integral of a shifted finite-dimensional Gaussian quadratic
tail is finite. -/
theorem lintegral_exp_neg_add_mul_norm_sq_ne_top {a b : ℝ} (ha : 0 < a) :
    ∫⁻ x : E, ENNReal.ofReal (Real.exp (-(a * ‖x‖ ^ 2 + b))) ∂volume ≠ ∞ :=
  lintegral_ofReal_ne_top_of_integrable_nonneg
    (integrable_exp_neg_add_mul_norm_sq (E := E) (b := b) ha)
    (ae_of_all _ fun _ => Real.exp_nonneg _)

/-- Exact `ℝ≥0∞` normalizer for the finite-dimensional quadratic Gaussian
tail. -/
theorem lintegral_exp_neg_mul_norm_sq_eq {a : ℝ} (ha : 0 < a) :
    ∫⁻ x : E, ENNReal.ofReal (Real.exp (-a * ‖x‖ ^ 2)) ∂volume =
      ENNReal.ofReal ((Real.pi / a) ^ ((Module.finrank ℝ E : ℝ) / 2)) := by
  rw [← ofReal_integral_eq_lintegral_ofReal
    (integrable_exp_neg_mul_norm_sq (E := E) ha)
    (ae_of_all _ fun _ => Real.exp_nonneg _)]
  rw [GaussianFourier.integral_rexp_neg_mul_sq_norm (V := E) ha]

/-- Exact `ℝ≥0∞` normalizer for a shifted finite-dimensional quadratic
Gaussian tail. -/
theorem lintegral_exp_neg_add_mul_norm_sq_eq {a b : ℝ} (ha : 0 < a) :
    ∫⁻ x : E, ENNReal.ofReal (Real.exp (-(a * ‖x‖ ^ 2 + b))) ∂volume =
      ENNReal.ofReal (Real.exp (-b) * (Real.pi / a) ^
        ((Module.finrank ℝ E : ℝ) / 2)) := by
  rw [← ofReal_integral_eq_lintegral_ofReal
    (integrable_exp_neg_add_mul_norm_sq (E := E) (b := b) ha)
    (ae_of_all _ fun _ => Real.exp_nonneg _)]
  have hInt :
      ∫ x : E, Real.exp (-(a * ‖x‖ ^ 2 + b)) ∂volume =
        Real.exp (-b) * ∫ x : E, Real.exp (-a * ‖x‖ ^ 2) ∂volume := by
    rw [← integral_const_mul]
    congr with x
    rw [show -(a * ‖x‖ ^ 2 + b) = -b + (-a * ‖x‖ ^ 2) by ring]
    rw [Real.exp_add]
  rw [hInt, GaussianFourier.integral_rexp_neg_mul_sq_norm (V := E) ha]

/-- The explicitly normalized finite-dimensional quadratic Gibbs density is a
probability measure on Lebesgue space. -/
theorem isProbabilityMeasure_withDensity_exp_neg_add_mul_norm_sq
    {a b : ℝ} (ha : 0 < a) :
    IsProbabilityMeasure
      ((volume : Measure E).withDensity fun x =>
        (ENNReal.ofReal
          (Real.exp (-b) * (Real.pi / a) ^
            ((Module.finrank ℝ E : ℝ) / 2)))⁻¹ *
          ENNReal.ofReal (Real.exp (-(a * ‖x‖ ^ 2 + b)))) := by
  let f : E → ℝ≥0∞ := fun x => ENNReal.ofReal (Real.exp (-(a * ‖x‖ ^ 2 + b)))
  let Z : ℝ≥0∞ := ENNReal.ofReal
    (Real.exp (-b) * (Real.pi / a) ^ ((Module.finrank ℝ E : ℝ) / 2))
  have hZeq : (∫⁻ x, f x ∂(volume : Measure E)) = Z := by
    simpa [f, Z] using
      lintegral_exp_neg_add_mul_norm_sq_eq (E := E) (a := a) (b := b) ha
  have hZpos : 0 < Z := by
    dsimp [Z]
    rw [ENNReal.ofReal_pos]
    exact mul_pos (Real.exp_pos _) (Real.rpow_pos_of_pos (div_pos Real.pi_pos ha) _)
  have h0 : ∫⁻ x, f x ∂(volume : Measure E) ≠ 0 := by
    rw [hZeq]
    exact ne_of_gt hZpos
  have hfin : ∫⁻ x, f x ∂(volume : Measure E) ≠ ∞ := by
    rw [hZeq]
    exact ENNReal.ofReal_ne_top
  have h0G :
      ∫⁻ x, Measure.Gibbs.gibbsDensityENNReal
        (fun x : E => a * ‖x‖ ^ 2 + b) x ∂(volume : Measure E) ≠ 0 := by
    simpa [f, Measure.Gibbs.gibbsDensityENNReal] using h0
  have hfinG :
      ∫⁻ x, Measure.Gibbs.gibbsDensityENNReal
        (fun x : E => a * ‖x‖ ^ 2 + b) x ∂(volume : Measure E) ≠ ∞ := by
    simpa [f, Measure.Gibbs.gibbsDensityENNReal] using hfin
  have hprobG :=
    Measure.Gibbs.isProbabilityMeasure_withDensity_normalized_gibbs
      (volume : Measure E) (fun x : E => a * ‖x‖ ^ 2 + b) h0G hfinG
  have hprob :
      IsProbabilityMeasure
        ((volume : Measure E).withDensity fun x =>
          (∫⁻ y, f y ∂(volume : Measure E))⁻¹ * f x) := by
    simpa [f, Measure.Gibbs.gibbsDensityENNReal] using hprobG
  change IsProbabilityMeasure ((volume : Measure E).withDensity fun x => Z⁻¹ * f x)
  rw [← hZeq]
  exact hprob

/-- A quadratic lower bound on a potential gives a finite Gibbs normalization
constant on finite-dimensional Lebesgue space. -/
theorem lintegral_gibbsDensityENNReal_ne_top_of_ae_quadratic_lower_bound
    {V : E → ℝ} {a b : ℝ} (ha : 0 < a)
    (hquad : ∀ᵐ x ∂(volume : Measure E), a * ‖x‖ ^ 2 + b ≤ V x) :
    ∫⁻ x, Measure.Gibbs.gibbsDensityENNReal V x ∂(volume : Measure E) ≠ ∞ := by
  refine Measure.Gibbs.lintegral_gibbsDensityENNReal_ne_top_of_ae_potential_ge
    (volume : Measure E) hquad ?_
  simpa [Measure.Gibbs.gibbsDensityENNReal] using
    lintegral_exp_neg_add_mul_norm_sq_ne_top (E := E) (a := a) (b := b) ha

/-- A measurable potential with a quadratic lower bound defines a normalized
Gibbs probability measure on finite-dimensional Lebesgue space. -/
theorem isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_quadratic_lower_bound
    {V : E → ℝ} {a b : ℝ} (hV : AEMeasurable V (volume : Measure E))
    (ha : 0 < a)
    (hquad : ∀ᵐ x ∂(volume : Measure E), a * ‖x‖ ^ 2 + b ≤ V x) :
    IsProbabilityMeasure
      ((volume : Measure E).withDensity fun x =>
        (∫⁻ y, Measure.Gibbs.gibbsDensityENNReal V y ∂(volume : Measure E))⁻¹ *
          Measure.Gibbs.gibbsDensityENNReal V x) :=
  Measure.Gibbs.isProbabilityMeasure_withDensity_normalized_gibbs
    (volume : Measure E) V
    (Measure.Gibbs.lintegral_gibbsDensityENNReal_ne_zero (volume : Measure E) hV)
    (lintegral_gibbsDensityENNReal_ne_top_of_ae_quadratic_lower_bound
      (E := E) ha hquad)

end Integrability
end Analysis
end TechnicalLemmas
end AutoSamplingTheory
