import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RecursiveDepth
import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOCalculus

open MeasureTheory AutoSamplingTheory.ExampleCases.SmoothedPicardHMC
open scoped NNReal

#check RecursiveDepth.parameter_control
#print axioms RecursiveDepth.parameter_control

namespace RecursiveDepthTest

noncomputable def condition (κ r : ℝ) : ℝ := (1 + r) / (κ⁻¹ + r)

noncomputable def heat (κ c r : ℝ) : ℝ :=
  if 2 ≤ condition κ r then condition κ r else c

noncomputable def stepVariance (κ c r h : ℝ) : ℝ :=
  (h + heat κ c r) / (1 + r)

noncomputable def nextPrecision (κ c r h : ℝ) : ℝ :=
  r + (stepVariance κ c r h)⁻¹

noncomputable def precision (κ c r₀ : ℝ) (η : ℕ → ℝ) : ℕ → ℝ :=
  Nat.rec r₀ (fun j r => nextPrecision κ c r (η j))



-- A=∞ and κ=1: the condition is already good at stage zero, but the
-- finite variance bound starts at stage one. No inverse-zero shortcut.
example (N : ℕ) :
    0 < (precision 1 (1/8) 0 (fun _ => 1/8) (1 + N))⁻¹ ∧
      (precision 1 (1/8) 0 (fun _ => 1/8) (1 + N))⁻¹ ≤
        (1/4) * (1/5 : ℝ)^N := by
  have control := RecursiveDepth.parameter_control (κ := 1) (c := 1/8) (r₀ := 0)
    (η := fun _ => 1/8) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by intro n; norm_num)
  have h := control.2.2.2.1 0 N (by norm_num)
  norm_num [precision, nextPrecision, stepVariance, heat, condition] at h ⊢
  exact h

-- The same scheduled variance and precision define the actual next normalized
-- Gibbs law; normalizability is supplied by the proved calculus, not assumed.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    {U : E → ℝ} {κ c r₀ : ℝ} {η : ℕ → ℝ}
    (hκ : 1 ≤ κ) (hc : 0 < c) (hc_upper : c < 1/4)
    (hr₀ : 0 ≤ r₀) (hη : ∀ n, 0 < η n ∧ η n ≤ c)
    (hU : ContDiff ℝ 2 U)
    (hH : ∀ x v : E, κ⁻¹ * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ U) x v) v ∧
      (fderiv ℝ (fderiv ℝ U) x v) v ≤ ‖v‖ ^ 2)
    (n : ℕ) (u y : E) :
    let r := precision κ c r₀ η n
    let a := stepVariance κ c r (η n)
    let rp := precision κ c r₀ η (n + 1)
    let w := rp⁻¹ • (r • u + a⁻¹ • y)
    IsProbabilityMeasure ((volume : Measure E).tilted
      (fun x => -(U x + rp / 2 * ‖x - w‖ ^ 2))) := by
  have control := RecursiveDepth.parameter_control hκ hc hc_upper hr₀ hη
  have hr : 0 ≤ precision κ c r₀ η n := (control.1 n).1
  have ha : 0 < stepVariance κ c (precision κ c r₀ η n) (η n) := by
    unfold stepVariance heat
    split_ifs with hk
    · apply div_pos
      · linarith [(hη n).1]
      · linarith
    · exact div_pos (add_pos (hη n).1 hc) (by linarith)
  have h := RGOCalculus.rgo_calculus (lt_of_lt_of_le zero_lt_one hκ) hU hH
    ⟨_, hr⟩ ha u y
  exact h.2.2.2.2.2.1

end RecursiveDepthTest
