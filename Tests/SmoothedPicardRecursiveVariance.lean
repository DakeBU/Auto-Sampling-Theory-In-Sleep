import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RecursiveVariance
import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOCalculus

open MeasureTheory AutoSamplingTheory.ExampleCases.SmoothedPicardHMC
open scoped NNReal

#check RecursiveVariance.variance_update_bounds
#print axioms RecursiveVariance.variance_update_bounds

-- Infinite initial regularization variance means zero precision. The next
-- variance is h+c, not the totalized real inverse of zero.
example {h c : ℝ} (hh : 0 < h) (hhc : h ≤ c) :
    let a := (h + c) / (1 + (0 : ℝ))
    let Aplus := ((0 : ℝ) + a⁻¹)⁻¹
    a = h + c ∧ Aplus = h + c ∧ 0 < Aplus ∧ Aplus ≤ 2 * c := by
  have hb := RecursiveVariance.variance_update_bounds (r := 0) (by rfl) hh hhc
  exact ⟨by simp, by simp, by simpa using hb.2.1, by simpa using hb.2.2.1⟩

-- The same update parameters define an actual normalized Gibbs target.
-- No integrability, normalizer or probability premise is supplied.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    {U : E → ℝ} {κ h c : ℝ} (hκ : 0 < κ) (hU : ContDiff ℝ 2 U)
    (hH : ∀ x v : E, κ⁻¹ * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ U) x v) v ∧
      (fderiv ℝ (fderiv ℝ U) x v) v ≤ ‖v‖ ^ 2)
    (r : ℝ≥0) (u y : E) (hh : 0 < h) (hhc : h ≤ c) :
    let a := (h + c) / (1 + (r : ℝ))
    let rp := (r : ℝ) + a⁻¹
    let w := rp⁻¹ • ((r : ℝ) • u + a⁻¹ • y)
    IsProbabilityMeasure ((volume : Measure E).tilted
      (fun x => -(U x + rp / 2 * ‖x - w‖ ^ 2))) ∧
      0 < rp⁻¹ ∧ rp⁻¹ ≤ 2 * c ∧
      (0 < (r : ℝ) → rp⁻¹ ≤ (2 * c / (1 + 2 * c)) * (r : ℝ)⁻¹) := by
  have hc : 0 < c := lt_of_lt_of_le hh hhc
  have ha : 0 < (h + c) / (1 + (r : ℝ)) := by positivity
  rcases RGOCalculus.rgo_calculus hκ hU hH r ha u y with
    ⟨_, _, _, _, _, hprob, _, _⟩
  rcases RecursiveVariance.variance_update_bounds r.coe_nonneg hh hhc with
    ⟨_, hpos, hbound, _, _, hcontract⟩
  exact ⟨hprob, hpos, hbound, hcontract⟩
