import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral

namespace AutoSamplingTheory.Tests.CanonicalStoppedItoIntegral

open MeasureTheory Set
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open BrownianMotion LocalProgressiveL2 CanonicalStoppedItoIntegral

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}
  {B : ℝ≥0 → Omega → ℝ}

#check canonicalStoppedItoProcess
#check canonicalStoppedItoProcess_stronglyAdapted
#check canonicalStoppedItoProcess_martingale
#check canonicalStoppedItoProcess_continuousOn
#check canonicalStoppedItoProcess_at_eq_terminal
#check chewi_display_1_1_14

/-- Focused smoke test for Chewi display (1.1.14): the source-facing theorem
must actually produce a strongly adapted continuous martingale for each
canonical stopped integrand. -/
example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (hT : 0 < T)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (n : ℕ) :
    ∃ M : ℝ≥0 → Omega → ℝ,
      M = canonicalStoppedItoProcess hUsual eta hT hB n ∧
      StronglyAdapted filtration M ∧
      Martingale M filtration mu ∧
      (∀ omega,
        ContinuousOn (fun t => M t omega) (Icc (0 : ℝ≥0) T)) := by
  let hdisplay := chewi_display_1_1_14 hUsual eta hT hB n
  refine ⟨canonicalStoppedItoProcess hUsual eta hT hB n, rfl,
    hdisplay.1, hdisplay.2.1, ?_⟩
  exact hdisplay.2.2.1

end AutoSamplingTheory.Tests.CanonicalStoppedItoIntegral
