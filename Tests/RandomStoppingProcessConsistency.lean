import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingProcessConsistency

namespace AutoSamplingTheory.Tests.RandomStoppingProcessConsistency

open MeasureTheory Set
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2Stopping
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingProcessConsistency
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}
  {B : ℝ≥0 → Omega → ℝ}

#check ae_time_ne
#check minStoppingValue_isChewiStoppingTime
#check restrictAt_stop_toLp_eq_stop_min
#check itoIntegralProcess_stop_ae
#check itoIntegralProcess_stop_eq_stoppedProcess_ae
#check stoppedProcess_coe_apply
#check itoIntegralProcess_stop_eq_stoppedProcess_pathwise_ae

example [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T) (hT : 0 < T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    {t : ℝ≥0} (htT : t ≤ T) :
    ItoIntegralProcess.itoIntegralProcess
        (stop eta (fun omega => (tau omega : WithTop ℝ≥0)) htau)
        hT hB hUsual t =ᵐ[mu]
      stoppedProcess (ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual)
        (fun omega => (tau omega : WithTop ℝ≥0)) t :=
  itoIntegralProcess_stop_eq_stoppedProcess_ae
    eta hT tau htau htauT hB hUsual htT

example [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T) (hT : 0 < T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu) :
    ∀ᵐ omega ∂mu, ∀ t ∈ Icc (0 : ℝ≥0) T,
      ItoIntegralProcess.itoIntegralProcess
          (stop eta (fun omega => (tau omega : WithTop ℝ≥0)) htau)
          hT hB hUsual t omega =
        stoppedProcess (ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual)
          (fun omega => (tau omega : WithTop ℝ≥0)) t omega :=
  itoIntegralProcess_stop_eq_stoppedProcess_pathwise_ae
    eta hT tau htau htauT hB hUsual

end AutoSamplingTheory.Tests.RandomStoppingProcessConsistency
