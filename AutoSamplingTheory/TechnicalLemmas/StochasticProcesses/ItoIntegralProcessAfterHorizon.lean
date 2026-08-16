import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoIntegralProcess
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime

/-!
# Deterministic horizon constancy

All finite-horizon Itô processes in ASTIS are indexed by every nonnegative
time, but the elementary construction is explicitly clamped by `min t T`.
Consequently the completed continuous version is exactly constant after its
construction horizon.  We record that fact, together with the corresponding
pure stopped-process identity, so later local-martingale congruence theorems can
be stated for every time rather than repeatedly splitting at the horizon.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace ItoIntegralProcessAfterHorizon

open MeasureTheory
open scoped NNReal

open BrownianMotion ElementaryItoProcess ItoIntegralProcess ProgressiveL2

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}
  {B : ℝ≥0 → Omega → ℝ}

/-- Every canonical elementary Itô approximant is exactly constant after the
construction horizon. -/
theorem canonicalItoProcess_eq_terminal_of_le
    [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T) (hT : 0 < T)
    (B : ℝ≥0 → Omega → ℝ) (n : ℕ)
    {t : ℝ≥0} (hTt : T ≤ t) :
    canonicalItoProcess eta hT B n t =
      canonicalItoProcess eta hT B n T := by
  funext omega
  simp [canonicalItoProcess, elementaryItoProcess, min_eq_right hTt]

/-- The pointwise complete-space path limit is constant after the horizon. -/
theorem canonicalPathLimit_eq_terminal_of_le
    [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T) (hT : 0 < T)
    (B : ℝ≥0 → Omega → ℝ) (omega : Omega)
    {t : ℝ≥0} (hTt : T ≤ t) :
    canonicalPathLimit eta hT B t omega =
      canonicalPathLimit eta hT B T omega := by
  unfold canonicalPathLimit
  congr 1
  funext n
  exact congrFun
    (canonicalItoProcess_eq_terminal_of_le eta hT B n hTt) omega

/-- The patched continuous Itô process is exactly constant after its finite
construction horizon, on every sample path including the null-set patch. -/
theorem itoIntegralProcess_eq_terminal_of_le
    [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T) (hT : 0 < T)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    {t : ℝ≥0} (hTt : T ≤ t) :
    itoIntegralProcess eta hT hB hUsual t =
      itoIntegralProcess eta hT hB hUsual T := by
  funext omega
  classical
  by_cases hbad : omega ∈ uniformBadSet eta hT B
  · simp [itoIntegralProcess, hbad]
  · simp only [itoIntegralProcess, hbad, if_false]
    exact canonicalPathLimit_eq_terminal_of_le eta hT B omega hTt

/-- If a stopping time is pointwise bounded by `T`, its stopped process is
exactly constant after `T`, independently of any stochastic assumptions. -/
theorem stoppedProcess_eq_terminal_of_le
    {beta : Type*} (u : ℝ≥0 → Omega → beta)
    (tau : Omega → WithTop ℝ≥0)
    (htauT : ∀ omega, tau omega ≤ (T : WithTop ℝ≥0))
    {t : ℝ≥0} (hTt : T ≤ t) :
    stoppedProcess u tau t = stoppedProcess u tau T := by
  funext omega
  unfold stoppedProcess
  have htau_t : tau omega ≤ (t : WithTop ℝ≥0) :=
    (htauT omega).trans (WithTop.coe_le_coe.mpr hTt)
  rw [min_eq_right htau_t, min_eq_right (htauT omega)]

end ItoIntegralProcessAfterHorizon
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
