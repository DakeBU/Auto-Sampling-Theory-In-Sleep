import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoIntegralProcess
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2Algebra

/-!
# Congruence of completed Itô processes

The completed Itô process is represented by a particular pathwise-continuous
version, but its stochastic content depends only on the product-space `L²`
class of the integrand.  This module records the deterministic-time congruence
principle needed for localization and gluing.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace ItoIntegralProcessCongruence

open Filter MeasureTheory
open scoped NNReal

open BrownianMotion ItoIntegralProcess ItoTerminalCompletion ProgressiveL2
  ProgressiveL2Algebra

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}
  {B : ℝ≥0 → Omega → ℝ}

/-- Equal product-space `L²` integrands have almost-surely equal completed Itô
process values at every deterministic time in the construction horizon. -/
theorem itoIntegralProcess_congr_toLp_ae [IsFiniteMeasure mu]
    (eta xi : ProgressiveL2Integrand filtration mu T)
    (hT : 0 < T)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    (hEq : eta.toLp = xi.toLp)
    {t : ℝ≥0} (htT : t ≤ T) :
    itoIntegralProcess eta hT hB hUsual t =ᵐ[mu]
      itoIntegralProcess xi hT hB hUsual t := by
  have hrestrict : (eta.restrictAt t).toLp = (xi.restrictAt t).toLp :=
    restrictAt_toLp_eq_of_toLp_eq eta xi hEq t
  have hterminal :
      itoIntegralTerminal (eta.restrictAt t) hT hB =
        itoIntegralTerminal (xi.restrictAt t) hT hB := by
    apply itoIntegralTerminal_congr_toLp
    simpa only [integrandToLp] using hrestrict
  have heta := itoIntegralProcess_at_eq_terminal eta hT hB hUsual htT
  have hxi := itoIntegralProcess_at_eq_terminal xi hT hB hUsual htT
  filter_upwards [heta, hxi] with omega hetaOmega hxiOmega
  rw [hetaOmega, hxiOmega, hterminal]

end ItoIntegralProcessCongruence
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
