import AutoSamplingTheory.TechnicalLemmas.Probability.GaussianConditionalKernel
import Mathlib.Probability.Kernel.Composition.MeasureComp

open MeasureTheory ProbabilityTheory
open scoped ENNReal ProbabilityTheory

-- Exercise the conditional-law identity with a singular input law, so a hidden
-- assumption that the input has a Lebesgue density cannot pass this test.
example {η : ℝ} (hη : 0 < η) :
    let J := Measure.map (fun p : ℝ × ℝ => (p.1, p.1 + Real.sqrt η * p.2))
      ((Measure.dirac (0 : ℝ)).prod (stdGaussian ℝ))
    ∃ R : Kernel ℝ ℝ, IsMarkovKernel R ∧
      (J.map Prod.swap).fst ⊗ₘ R = J.map Prod.swap := by
  obtain ⟨R, hR, _, hcond⟩ :=
    AutoSamplingTheory.TechnicalLemmas.Probability.GaussianConditionalKernel.exists_tilted_isCondKernel
      (Measure.dirac (0 : ℝ)) hη
  exact ⟨R, hR, hcond.disintegrate⟩

-- The backward-RGO consumer: start from the actual smoothed marginal, then
-- apply the constructed normalized kernel to recover the original law.
-- This is exact one-step law recovery, not PBPS process invariance or mixing.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    (μ : Measure E) [IsProbabilityMeasure μ] {η : ℝ} (hη : 0 < η) :
    let J := Measure.map (fun p : E × E => (p.1, p.1 + Real.sqrt η • p.2))
      (μ.prod (stdGaussian E))
    ∃ R : Kernel E E, IsMarkovKernel R ∧
      (∀ y, R y = μ.tilted (fun x => -‖x - y‖ ^ 2 / (2 * η))) ∧
      R ∘ₘ J.snd = μ := by
  obtain ⟨R, hR, hfiber, hcond⟩ :=
    AutoSamplingTheory.TechnicalLemmas.Probability.GaussianConditionalKernel.exists_tilted_isCondKernel
      μ hη
  refine ⟨R, hR, hfiber, ?_⟩
  have h := congrArg Measure.snd hcond.disintegrate
  rw [Measure.snd_compProd, Measure.fst_map_swap, Measure.snd_map_swap,
    Measure.fst_map_prodMk (by fun_prop), Measure.map_fst_prod, measure_univ, one_smul] at h
  exact h

#print axioms AutoSamplingTheory.TechnicalLemmas.Probability.GaussianConditionalKernel.exists_tilted_isCondKernel
