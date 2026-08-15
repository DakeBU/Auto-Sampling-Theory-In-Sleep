import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral

namespace AutoSamplingTheory.Tests.CanonicalStoppedItoIntegral

open MeasureTheory Set

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : MeasureTheory.Filtration NNReal m}
  {mu : Measure Omega} {T : NNReal}
  {B : NNReal → Omega → ℝ}

#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess
#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess_stronglyAdapted
#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess_martingale
#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess_continuousOn
#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess_at_eq_terminal
#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral.chewi_display_1_1_14

/-- Focused smoke test for Chewi display (1.1.14).

The source-facing theorem must elaborate to the concrete conjunction of strong
adaptedness, martingale structure, and path continuity. Fully qualified types
make the stochastic interface visible to readers instead of hiding it behind
namespace openings. -/
example [IsProbabilityMeasure mu]
    (hUsual :
      AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2.SatisfiesUsualConditions
        filtration mu)
    (eta :
      AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.LocalProgressiveL2.LocalProgressiveL2Integrand
        filtration mu T)
    (hT : 0 < T)
    (hB :
      AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion.IsBrownianMotionWithFiltration
        B filtration mu)
    (n : ℕ) :
    MeasureTheory.StronglyAdapted filtration
        (AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess
          hUsual eta hT hB n) ∧
      MeasureTheory.Martingale
        (AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess
          hUsual eta hT hB n) filtration mu ∧
      (∀ omega,
        ContinuousOn
          (fun t =>
            AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess
              hUsual eta hT hB n t omega)
          (Icc (0 : NNReal) T)) := by
  have hdisplay :=
    AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral.chewi_display_1_1_14
      hUsual eta hT hB n
  exact ⟨hdisplay.1, hdisplay.2.1, hdisplay.2.2.1⟩

end AutoSamplingTheory.Tests.CanonicalStoppedItoIntegral
