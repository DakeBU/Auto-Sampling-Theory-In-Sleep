import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral

namespace AutoSamplingTheory.Tests.CanonicalStoppedItoIntegral

open MeasureTheory Set

namespace SP := AutoSamplingTheory.TechnicalLemmas.StochasticProcesses

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : MeasureTheory.Filtration NNReal m}
  {mu : Measure Omega} {T : NNReal}
  {B : NNReal → Omega → ℝ}

#check SP.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess
#check SP.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess_stronglyAdapted
#check SP.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess_martingale
#check SP.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess_continuousOn
#check SP.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess_at_eq_terminal
#check SP.CanonicalStoppedItoIntegral.chewi_display_1_1_14

/-- Focused smoke test for Chewi display (1.1.14).

The source-facing theorem must elaborate to the concrete conjunction of strong
adaptedness, martingale structure, and path continuity.  Fully qualified types
make the stochastic interface visible to readers instead of hiding it behind
namespace openings. -/
example [IsProbabilityMeasure mu]
    (hUsual : SP.ProgressiveL2.SatisfiesUsualConditions filtration mu)
    (eta : SP.LocalProgressiveL2.LocalProgressiveL2Integrand filtration mu T)
    (hT : 0 < T)
    (hB : SP.BrownianMotion.IsBrownianMotionWithFiltration B filtration mu)
    (n : ℕ) :
    MeasureTheory.StronglyAdapted filtration
        (SP.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess hUsual eta hT hB n) ∧
      MeasureTheory.Martingale
        (SP.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess hUsual eta hT hB n) filtration mu ∧
      (∀ omega,
        ContinuousOn
          (fun t => SP.CanonicalStoppedItoIntegral.canonicalStoppedItoProcess hUsual eta hT hB n t omega)
          (Icc (0 : NNReal) T)) := by
  have hdisplay := SP.CanonicalStoppedItoIntegral.chewi_display_1_1_14 hUsual eta hT hB n
  exact ⟨hdisplay.1, hdisplay.2.1, hdisplay.2.2.1⟩

end AutoSamplingTheory.Tests.CanonicalStoppedItoIntegral
