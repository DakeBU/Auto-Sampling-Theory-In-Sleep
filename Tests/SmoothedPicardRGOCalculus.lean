import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOCalculus
import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RecursiveCondition

open MeasureTheory AutoSamplingTheory.ExampleCases.SmoothedPicardHMC
open scoped NNReal

#check RGOCalculus.rgo_calculus
#print axioms RGOCalculus.rgo_calculus

-- Zero precision is the source's infinite initial variance, not a removed case.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    {U : E → ℝ} {κ a : ℝ} (hκ : 0 < κ) (hU : ContDiff ℝ 2 U)
    (hH : ∀ x v : E, κ⁻¹ * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ U) x v) v ∧
      (fderiv ℝ (fderiv ℝ U) x v) v ≤ ‖v‖ ^ 2)
    (ha : 0 < a) (u y : E) :
    IsProbabilityMeasure ((volume : Measure E).tilted (fun x => -U x)) := by
  simpa using (RGOCalculus.rgo_calculus hκ hU hH 0 ha u y).2.2.2.2.1

-- The actual source curvature ratio now feeds the earlier scalar stage bound.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    {U : E → ℝ} {κ h : ℝ} (hκ : 0 < κ) (hU : ContDiff ℝ 2 U)
    (hH : ∀ x v : E, κ⁻¹ * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ U) x v) v ∧
      (fderiv ℝ (fderiv ℝ U) x v) v ≤ ‖v‖ ^ 2)
    (r : ℝ≥0) (u y : E) (hh : 0 < h) (hh' : h < 1 / 4)
    (hK : 2 ≤ (1 + (r : ℝ)) / (κ⁻¹ + r)) :
    let α := κ⁻¹ + (r : ℝ)
    let β := 1 + (r : ℝ)
    let K := β / α
    let a := (h + K) / β
    K / 2 ≤ (β + a⁻¹) / (α + a⁻¹) ∧
      (β + a⁻¹) / (α + a⁻¹) ≤ (4 / 5) * K := by
  let α := κ⁻¹ + (r : ℝ)
  let β := 1 + (r : ℝ)
  let K := β / α
  let a := (h + K) / β
  have hβ : 0 < β := by dsimp [β]; positivity
  have hKpos : 0 < K := lt_of_lt_of_le (by norm_num) hK
  have ha : 0 < a := div_pos (add_pos hh hKpos) hβ
  rcases RGOCalculus.rgo_calculus hκ hU hH r ha u y with
    ⟨_, _, _, _, _, _, _, hupdate⟩
  have hab : a * β = h + K := by
    exact div_mul_cancel₀ _ hβ.ne'
  have heq : (β + a⁻¹) / (α + a⁻¹) = K * (K + h + 1) / (2 * K + h) := by
    have hupdate' : (β + a⁻¹) / (α + a⁻¹) = (a * β + 1) * K / (a * β + K) := by
      simpa only [NNReal.coe_add, NNReal.coe_one] using hupdate
    rw [hupdate', hab]
    congr 1 <;> ring
  change K / 2 ≤ (β + a⁻¹) / (α + a⁻¹) ∧ _
  rw [heq]
  exact RecursiveCondition.contraction_bounds hK hh hh'
