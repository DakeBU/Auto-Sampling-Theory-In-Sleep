import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RecursiveDepth
import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOCalculus

open MeasureTheory AutoSamplingTheory.ExampleCases.SmoothedPicardHMC
open scoped NNReal

#check RecursiveDepth.finite_depth
#print axioms RecursiveDepth.finite_depth
#print axioms RecursiveDepth.exists_terminal

-- A=∞ and κ=1: the condition is already good at stage zero, but the
-- finite variance bound starts at stage one. No inverse-zero shortcut.
example (N : ℕ) :
    0 < (RecursiveDepth.precision 1 (1/8) 0 (fun _ => 1/8) (1 + N))⁻¹ ∧
      (RecursiveDepth.precision 1 (1/8) 0 (fun _ => 1/8) (1 + N))⁻¹ ≤
        (1/4) * (1/5 : ℝ)^N := by
  have h := RecursiveDepth.finite_depth (κ := 1) (c := 1/8) (r₀ := 0)
    (η := fun _ => 1/8) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by intro n; norm_num) 0 N (by norm_num [RecursiveDepth.condition])
  norm_num at h ⊢
  exact h

-- The same scheduled variance and precision define the actual next normalized
-- Gibbs law; normalizability is supplied by the proved calculus, not assumed.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    {U : E → ℝ} {κ c r₀ : ℝ} {η : ℕ → ℝ}
    (hκ : 1 ≤ κ) (hc : 0 < c) (hr₀ : 0 ≤ r₀) (hη : ∀ n, 0 < η n)
    (hU : ContDiff ℝ 2 U)
    (hH : ∀ x v : E, κ⁻¹ * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ U) x v) v ∧
      (fderiv ℝ (fderiv ℝ U) x v) v ≤ ‖v‖ ^ 2)
    (n : ℕ) (u y : E) :
    let r := RecursiveDepth.precision κ c r₀ η n
    let a := RecursiveDepth.stepVariance κ c r (η n)
    let rp := RecursiveDepth.precision κ c r₀ η (n + 1)
    let w := rp⁻¹ • (r • u + a⁻¹ • y)
    IsProbabilityMeasure ((volume : Measure E).tilted
      (fun x => -(U x + rp / 2 * ‖x - w‖ ^ 2))) := by
  have hr := RecursiveDepth.precision_nonneg hκ hc hr₀ hη n
  have ha := RecursiveDepth.stepVariance_pos hκ hc hr (hη n)
  have h := RGOCalculus.rgo_calculus (lt_of_lt_of_le zero_lt_one hκ) hU hH
    ⟨_, hr⟩ ha u y
  exact h.2.2.2.2.2.1
