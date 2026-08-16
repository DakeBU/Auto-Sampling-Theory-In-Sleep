import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoIntegralProcessCongruence

namespace AutoSamplingTheory.Tests.ItoIntegralProcessCongruence

open MeasureTheory Set
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoIntegralProcessCongruence
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}
  {B : ℝ≥0 → Omega → ℝ}

#check itoIntegralProcess_congr_toLp_ae
#check itoIntegralProcess_congr_toLp_pathwise_ae

example [IsFiniteMeasure mu]
    (eta xi : ProgressiveL2Integrand filtration mu T)
    (hT : 0 < T)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    (hEq : eta.toLp = xi.toLp)
    {t : ℝ≥0} (htT : t ≤ T) :
    ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual t =ᵐ[mu]
      ItoIntegralProcess.itoIntegralProcess xi hT hB hUsual t :=
  itoIntegralProcess_congr_toLp_ae eta xi hT hB hUsual hEq htT

example [IsFiniteMeasure mu]
    (eta xi : ProgressiveL2Integrand filtration mu T)
    (hT : 0 < T)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    (hEq : eta.toLp = xi.toLp) :
    ∀ᵐ omega ∂mu, ∀ t ∈ Icc (0 : ℝ≥0) T,
      ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual t omega =
        ItoIntegralProcess.itoIntegralProcess xi hT hB hUsual t omega :=
  itoIntegralProcess_congr_toLp_pathwise_ae eta xi hT hB hUsual hEq

end AutoSamplingTheory.Tests.ItoIntegralProcessCongruence
