import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalEnergyStoppingTime
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Localization

/-!
# Source-facing canonical localizers for the raw integrand

The completed energy construction replaces the null set of non-integrable
sample paths by the zero path.  Its hitting times are therefore ideal for
constructing globally square-integrable completed stopped integrands, but on a
bad raw path they eventually equal the terminal horizon `T`.

Chewi's Definition 1.1.12 is stated for the original integrand.  For that
source-facing predicate we therefore use the same energy hitting time on good
paths and stop immediately at zero on the null bad-energy set.  This makes the
raw stopped energy harmless on exceptional paths, while convergence to `T` is
still required only almost surely.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace CanonicalRawLocalization

open Filter MeasureTheory Set
open scoped NNReal Topology

open ProgressiveL2 LocalProgressiveL2 CompletedEnergy
  CanonicalEnergyLocalizer CanonicalEnergyStoppingTime StoppingTime

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

/-- Source-facing canonical time: use the completed-energy localizer off the
null bad-energy set and stop immediately on that exceptional set. -/
noncomputable def canonicalRawLocalizingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (n : ℕ) (omega : Omega) : ℝ≥0 := by
  classical
  exact if omega ∈ badEnergySet eta then 0
    else canonicalLocalizingTime hUsual eta n omega

@[simp] theorem canonicalRawLocalizingTime_of_bad
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (n : ℕ) {omega : Omega} (homega : omega ∈ badEnergySet eta) :
    canonicalRawLocalizingTime hUsual eta n omega = 0 := by
  simp [canonicalRawLocalizingTime, homega]

@[simp] theorem canonicalRawLocalizingTime_of_good
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (n : ℕ) {omega : Omega} (homega : omega ∉ badEnergySet eta) :
    canonicalRawLocalizingTime hUsual eta n omega =
      canonicalLocalizingTime hUsual eta n omega := by
  simp [canonicalRawLocalizingTime, homega]

/-- The raw localizers increase with the energy level. -/
theorem canonicalRawLocalizingTime_mono
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T) :
    Monotone (fun n => canonicalRawLocalizingTime hUsual eta n) := by
  intro n k hnk omega
  classical
  by_cases hbad : omega ∈ badEnergySet eta
  · simp [canonicalRawLocalizingTime, hbad]
  · simpa [canonicalRawLocalizingTime, hbad] using
      (canonicalLocalizingTime_mono hUsual eta omega hnk)

/-- Fixed-time occurrence events for the raw localizer are measurable. -/
theorem measurableSet_canonicalRawLocalizingTime_le
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (n : ℕ) (t : ℝ≥0) :
    MeasurableSet[filtration t]
      {omega | canonicalRawLocalizingTime hUsual eta n omega ≤ t} := by
  classical
  have hbad : MeasurableSet[filtration t] (badEnergySet eta) :=
    measurableSet_badEnergySet hUsual eta t
  have hcanonical : MeasurableSet[filtration t]
      {omega | canonicalLocalizingTime hUsual eta n omega ≤ t} := by
    simpa only [canonicalLocalizingTime] using
      (measurableSet_canonicalEnergyLocalizer_le hUsual eta
        (show 0 ≤ (n + 1 : ℝ) by positivity) t)
  have hset :
      {omega | canonicalRawLocalizingTime hUsual eta n omega ≤ t} =
        badEnergySet eta ∪
          {omega | canonicalLocalizingTime hUsual eta n omega ≤ t} := by
    ext omega
    by_cases homega : omega ∈ badEnergySet eta
    · simp [canonicalRawLocalizingTime, homega]
    · simp [canonicalRawLocalizingTime, homega]
  rw [hset]
  exact hbad.union hcanonical

/-- Each raw canonical localizer is a stopping time. -/
theorem canonicalRawLocalizingTime_isChewiStoppingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (n : ℕ) :
    IsChewiStoppingTime filtration
      (fun omega =>
        (canonicalRawLocalizingTime hUsual eta n omega : WithTop ℝ≥0)) := by
  intro t
  simpa only [WithTop.coe_le_coe] using
    measurableSet_canonicalRawLocalizingTime_le hUsual eta n t

/-- Mathlib-native stopping-time version. -/
theorem canonicalRawLocalizingTime_isStoppingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (n : ℕ) :
    IsStoppingTime filtration
      (fun omega =>
        (canonicalRawLocalizingTime hUsual eta n omega : WithTop ℝ≥0)) :=
  canonicalRawLocalizingTime_isChewiStoppingTime hUsual eta n

/-- Outside the null bad-energy set, the raw localizer is eventually the
terminal horizon. -/
theorem canonicalRawLocalizingTime_eventually_eq_terminal_of_good
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    {omega : Omega} (homega : omega ∉ badEnergySet eta) :
    ∀ᶠ n in atTop,
      canonicalRawLocalizingTime hUsual eta n omega = T := by
  filter_upwards
    [canonicalLocalizingTime_eventually_eq_terminal hUsual eta omega] with n hn
  simpa [canonicalRawLocalizingTime, homega] using hn

/-- The source-facing raw localizing times converge to `T` almost surely,
with the codomain exactly matching Definition 1.1.12. -/
theorem canonicalRawLocalizingTime_tendsto_terminal_ae
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T) :
    ∀ᵐ omega ∂mu,
      Tendsto
        (fun n =>
          (canonicalRawLocalizingTime hUsual eta n omega : WithTop ℝ≥0))
        atTop (𝓝 (T : WithTop ℝ≥0)) := by
  have hgood : ∀ᵐ omega ∂mu, omega ∉ badEnergySet eta := by
    rw [ae_iff]
    simpa using measure_badEnergySet_zero eta
  filter_upwards [hgood] with omega homega
  have hev : ∀ᶠ n in atTop,
      (canonicalRawLocalizingTime hUsual eta n omega : WithTop ℝ≥0) =
        (T : WithTop ℝ≥0) := by
    filter_upwards
      [canonicalRawLocalizingTime_eventually_eq_terminal_of_good
        hUsual eta homega] with n hn
    exact congrArg (fun s : ℝ≥0 => (s : WithTop ℝ≥0)) hn
  exact (tendsto_congr' hev).2 tendsto_const_nhds

end CanonicalRawLocalization
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
