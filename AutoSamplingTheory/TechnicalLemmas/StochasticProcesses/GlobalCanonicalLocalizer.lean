import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalLocalProgressiveL2
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalEnergyLocalizer

/-!
# Global canonical energy localizers

For Proposition 1.1.16 we need one localizing sequence tending to infinity,
not merely a sequence tending to a fixed terminal horizon.  We first remove a
single null set on which local square integrability fails at some integer
horizon.  Outside that set, the `n`-th candidate is the first time the energy
reaches level `n+1`, capped at the integer horizon `n+1`.

The shared null-set completion is essential: it makes the exceptional branch
identical at every level, so the eventual global sequence can be proved
pointwise monotone rather than merely almost surely monotone.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace GlobalCanonicalLocalizer

open MeasureTheory Set
open scoped NNReal Topology

open CanonicalEnergyLocalizer CompletedEnergy GlobalLocalProgressiveL2
  LocalProgressiveL2 ProgressiveL2 StoppingTime

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}

/-- Positive integer horizon used by the global localization ladder. -/
def integerHorizon (n : ℕ) : ℝ≥0 := (n + 1 : ℕ)

@[simp] theorem integerHorizon_pos (n : ℕ) : 0 < integerHorizon n := by
  simp [integerHorizon]

@[simp] theorem integerHorizon_succ (n : ℕ) :
    integerHorizon (n + 1) = integerHorizon n + 1 := by
  simp [integerHorizon]

/-- The countable exceptional set where local square integrability fails on at
least one positive integer horizon. -/
def globalBadSet
    (eta : GlobalLocalProgressiveL2Integrand filtration mu) : Set Omega :=
  ⋃ n : ℕ, badEnergySet (eta.onHorizon (integerHorizon n))

/-- The global exceptional set is null. -/
theorem measure_globalBadSet_zero
    (eta : GlobalLocalProgressiveL2Integrand filtration mu) :
    mu (globalBadSet eta) = 0 := by
  apply measure_iUnion_null
  intro n
  exact measure_badEnergySet_zero (eta.onHorizon (integerHorizon n))

/-- Completeness puts the shared exceptional set in every filtration sigma
algebra. -/
theorem measurableSet_globalBadSet
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu) (t : ℝ≥0) :
    MeasurableSet[filtration t] (globalBadSet eta) :=
  hUsual.completeAt t (globalBadSet eta) (measure_globalBadSet_zero eta)

/-- A globally good path is good on every positive integer horizon. -/
theorem not_bad_on_integerHorizon
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    {omega : Omega} (homega : omega ∉ globalBadSet eta) (n : ℕ) :
    omega ∉ badEnergySet (eta.onHorizon (integerHorizon n)) := by
  intro hbad
  apply homega
  exact Set.mem_iUnion.mpr ⟨n, hbad⟩

/-- Global canonical localizer: zero on the shared null set; otherwise use the
usual finite-horizon energy hitting time at matching level and horizon. -/
noncomputable def globalLocalizingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (n : ℕ) (omega : Omega) : ℝ≥0 :=
  if omega ∈ globalBadSet eta then 0 else
    canonicalEnergyLocalizer hUsual
      (eta.onHorizon (integerHorizon n)) (n + 1 : ℝ) omega

@[simp] theorem globalLocalizingTime_of_bad
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu) (n : ℕ)
    {omega : Omega} (homega : omega ∈ globalBadSet eta) :
    globalLocalizingTime hUsual eta n omega = 0 := by
  simp [globalLocalizingTime, homega]

@[simp] theorem globalLocalizingTime_of_good
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu) (n : ℕ)
    {omega : Omega} (homega : omega ∉ globalBadSet eta) :
    globalLocalizingTime hUsual eta n omega =
      canonicalEnergyLocalizer hUsual
        (eta.onHorizon (integerHorizon n)) (n + 1 : ℝ) omega := by
  simp [globalLocalizingTime, homega]

/-- Every global localizer is capped by its matching integer horizon. -/
theorem globalLocalizingTime_le_horizon
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (n : ℕ) (omega : Omega) :
    globalLocalizingTime hUsual eta n omega ≤ integerHorizon n := by
  by_cases homega : omega ∈ globalBadSet eta
  · simp [globalLocalizingTime, homega]
  · rw [globalLocalizingTime_of_good hUsual eta n homega]
    exact canonicalEnergyLocalizer_le_terminal hUsual
      (eta.onHorizon (integerHorizon n)) (n + 1 : ℝ) omega

/-- Each global localizer is a Chewi stopping time. -/
theorem globalLocalizingTime_isChewiStoppingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu) (n : ℕ) :
    IsChewiStoppingTime filtration
      (fun omega => (globalLocalizingTime hUsual eta n omega : WithTop ℝ≥0)) := by
  intro t
  have hbad := measurableSet_globalBadSet hUsual eta t
  have hcan : MeasurableSet[filtration t]
      {omega |
        canonicalEnergyLocalizer hUsual
          (eta.onHorizon (integerHorizon n)) (n + 1 : ℝ) omega ≤ t} :=
    measurableSet_canonicalEnergyLocalizer_le hUsual
      (eta.onHorizon (integerHorizon n)) (by positivity : (0 : ℝ) ≤ n + 1) t
  have heq :
      {omega |
        (globalLocalizingTime hUsual eta n omega : WithTop ℝ≥0) ≤ t} =
        globalBadSet eta ∪
          ((globalBadSet eta)ᶜ ∩
            {omega |
              canonicalEnergyLocalizer hUsual
                (eta.onHorizon (integerHorizon n)) (n + 1 : ℝ) omega ≤ t}) := by
    ext omega
    by_cases homega : omega ∈ globalBadSet eta
    · simp [globalLocalizingTime, homega]
    · simp [globalLocalizingTime, homega]
  rw [heq]
  exact hbad.union (hbad.compl.inter hcan)

end GlobalCanonicalLocalizer
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
