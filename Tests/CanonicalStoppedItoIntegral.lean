import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral

namespace AutoSamplingTheory.Tests.CanonicalStoppedItoIntegral

open MeasureTheory Set
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ProgressiveL2 BrownianMotion LocalProgressiveL2 CanonicalStoppedItoIntegral

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
must actually elaborate to strong adaptedness, the martingale property, and
sample-path continuity for the canonical stopped Ito process. -/
example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (hT : 0 < T)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (n : ℕ) :
    StronglyAdapted filtration
        (canonicalStoppedItoProcess hUsual eta hT hB n) ∧
      Martingale
        (canonicalStoppedItoProcess hUsual eta hT hB n) filtration mu ∧
      (∀ omega,
        ContinuousOn
          (fun t => canonicalStoppedItoProcess hUsual eta hT hB n t omega)
          (Icc (0 : ℝ≥0) T)) := by
  have hdisplay := chewi_display_1_1_14 hUsual eta hT hB n
  exact ⟨hdisplay.1, hdisplay.2.1, hdisplay.2.2.1⟩

end AutoSamplingTheory.Tests.CanonicalStoppedItoIntegral
