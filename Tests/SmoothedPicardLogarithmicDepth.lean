import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.LogarithmicDepth
import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOCalculus

open MeasureTheory AutoSamplingTheory.ExampleCases.SmoothedPicardHMC
open scoped NNReal

#check LogarithmicDepth.terminal_depth
#print axioms LogarithmicDepth.terminal_depth

-- Terminal-target consumer: the actual scheduled precision supplies the
-- nonnegative regularization required by the proved Gibbs calculus. The law
-- is normalizable and its parameter meets the threshold. This is not FORS.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    {κ c r₀ q Δ γ C : ℝ} {η : ℕ → ℝ}
    (hκ : 1 ≤ κ) (hc : 0 < c) (hc1 : c < 1/4) (hr₀ : 0 ≤ r₀)
    (hη : ∀ n, 0 < η n ∧ η n ≤ c) (hd : 0 < Module.finrank ℝ E) (hq : 2 ≤ q)
    (hΔ : 0 < Δ) (hΔ1 : Δ ≤ 1/2) (hγ : 0 < γ) (hγ1 : γ ≤ 1) (hC : 8 ≤ C)
    {U : E → ℝ}
    (hU : ContDiff ℝ 2 U)
    (hH : ∀ x v : E, κ⁻¹ * ‖v‖^2 ≤ (fderiv ℝ (fderiv ℝ U) x v) v ∧
      (fderiv ℝ (fderiv ℝ U) x v) v ≤ ‖v‖^2) (u : E) :
    let K := fun r : ℝ => (1+r)/(κ⁻¹+r)
    let τ := fun r : ℝ => if 2 ≤ K r then K r else c
    let a := fun r h : ℝ => (h+τ r)/(1+r)
    let step := fun r h : ℝ => r+(a r h)⁻¹
    let r : ℕ → ℝ := Nat.rec r₀ (fun j r => step r (η j))
    let L := q+Real.log (K r₀*(Module.finrank ℝ E)*q/Δ)
    let B := γ/(Real.sqrt ((Module.finrank ℝ E)*L)+L)
    let J := Nat.ceil (C*Real.log (Real.exp 1*K r₀/B))
    0 < (r J)⁻¹ ∧ (r J)⁻¹ ≤ B ∧
      Integrable (fun x => Real.exp (-(U x + r J / 2 * ‖x-u‖^2)))
        (volume : Measure E) ∧
      IsProbabilityMeasure ((volume : Measure E).tilted
        (fun x => -(U x + r J / 2 * ‖x-u‖^2))) := by
  dsimp only
  have control := LogarithmicDepth.terminal_depth hκ hc hc1 hr₀ hη hd hq hΔ hΔ1 hγ hγ1 hC
  let K := fun r : ℝ => (1+r)/(κ⁻¹+r)
  let τ := fun r : ℝ => if 2 ≤ K r then K r else c
  let a := fun r h : ℝ => (h+τ r)/(1+r)
  let step := fun r h : ℝ => r+(a r h)⁻¹
  let r : ℕ → ℝ := Nat.rec r₀ (fun j r => step r (η j))
  let L := q+Real.log (K r₀*(Module.finrank ℝ E)*q/Δ)
  let B := γ/(Real.sqrt ((Module.finrank ℝ E)*L)+L)
  let J := Nat.ceil (C*Real.log (Real.exp 1*K r₀/B))
  have hpos : 0 < (r J)⁻¹ := control.2.2.2.1
  have hr : 0 ≤ r J := (inv_pos.mp hpos).le
  have calculus := RGOCalculus.rgo_calculus (by linarith : 0 < κ) hU hH
    (⟨r J, hr⟩ : ℝ≥0) (a := 1) (by norm_num) u u
  exact ⟨hpos, control.2.2.2.2.1, calculus.2.2.1, calculus.2.2.2.2.1⟩
