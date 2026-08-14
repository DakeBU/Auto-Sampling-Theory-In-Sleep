import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CompletedEnergy
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime
import Mathlib.Topology.Order.IntermediateValue

/-!
# Canonical energy localizers

For a completed continuous monotone energy path, the canonical localizer at
level `c` is the first time at which the path equals `c`, with terminal time
`T` as fallback.  Equality level sets, rather than strict crossings, make the
stopped-energy bound exact and expose the intermediate-value argument used by
Chewi's Proposition 1.1.13.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace CanonicalEnergyLocalizer

open MeasureTheory Set
open scoped NNReal Topology

open ProgressiveL2 LocalProgressiveL2 CompletedEnergy
open StoppingTime

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

/-- Times in `[0,T]` at which completed energy equals a prescribed level. -/
def energyLevelSet
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (level : ℝ) (omega : Omega) : Set ℝ≥0 :=
  {t | t ∈ Icc (0 : ℝ≥0) T ∧ completedEnergy hUsual eta t omega = level}

/-- An energy level set is closed. -/
theorem isClosed_energyLevelSet
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (level : ℝ) (omega : Omega) :
    IsClosed (energyLevelSet hUsual eta level omega) := by
  have heq : IsClosed
      {t | completedEnergy hUsual eta t omega = level} :=
    isClosed_eq (continuous_completedEnergy hUsual eta omega) continuous_const
  have hinter := isClosed_Icc.inter heq
  simpa [energyLevelSet, Set.ext_iff] using hinter

/-- First equality-level time, or `T` if the level is not reached. -/
noncomputable def canonicalEnergyLocalizer
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (level : ℝ) (omega : Omega) : ℝ≥0 :=
  if h : (energyLevelSet hUsual eta level omega).Nonempty then
    sInf (energyLevelSet hUsual eta level omega)
  else
    T

/-- If the level set is nonempty, the canonical localizer belongs to it. -/
theorem canonicalEnergyLocalizer_mem
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (level : ℝ) (omega : Omega)
    (hne : (energyLevelSet hUsual eta level omega).Nonempty) :
    canonicalEnergyLocalizer hUsual eta level omega ∈
      energyLevelSet hUsual eta level omega := by
  rw [canonicalEnergyLocalizer, dif_pos hne]
  have hclosed := isClosed_energyLevelSet hUsual eta level omega
  exact hclosed.csInf_mem hne ⟨0, fun x hx => zero_le x⟩

/-- The canonical localizer is no later than any member of its level set. -/
theorem canonicalEnergyLocalizer_le_of_mem
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (level : ℝ) (omega : Omega) {s : ℝ≥0}
    (hs : s ∈ energyLevelSet hUsual eta level omega) :
    canonicalEnergyLocalizer hUsual eta level omega ≤ s := by
  have hne : (energyLevelSet hUsual eta level omega).Nonempty := ⟨s, hs⟩
  rw [canonicalEnergyLocalizer, dif_pos hne]
  exact csInf_le ⟨0, fun y hy => zero_le y⟩ hs

/-- Every canonical localizer is capped by the terminal horizon. -/
theorem canonicalEnergyLocalizer_le_terminal
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (level : ℝ) (omega : Omega) :
    canonicalEnergyLocalizer hUsual eta level omega ≤ T := by
  by_cases hne : (energyLevelSet hUsual eta level omega).Nonempty
  · exact (canonicalEnergyLocalizer_mem hUsual eta level omega hne).1.2
  · simp [canonicalEnergyLocalizer, hne]

/-- If completed energy at time `t` dominates a nonnegative level, continuity
produces an equality-level time no later than `t`. -/
theorem exists_level_time_of_le
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    {level : ℝ} (hlevel : 0 ≤ level) {t : ℝ≥0} (htT : t ≤ T)
    (hcross : level ≤ completedEnergy hUsual eta t omega) :
    ∃ s ∈ Icc (0 : ℝ≥0) t,
      completedEnergy hUsual eta s omega = level := by
  have hcont := continuous_completedEnergy hUsual eta omega
  have hzero : completedEnergy hUsual eta 0 omega = 0 :=
    completedEnergy_zero hUsual eta omega
  rw [← hzero] at hlevel
  have himage := intermediate_value_Icc (zero_le t) hcont.continuousOn
  exact himage ⟨hlevel, hcross⟩

/-- Fixed-time characterization of the canonical localizer. -/
theorem canonicalEnergyLocalizer_le_iff
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    {level : ℝ} (hlevel : 0 ≤ level) (omega : Omega) (t : ℝ≥0) :
    canonicalEnergyLocalizer hUsual eta level omega ≤ t ↔
      T ≤ t ∨ level ≤ completedEnergy hUsual eta t omega := by
  constructor
  · intro hstop
    by_cases hTt : T ≤ t
    · exact Or.inl hTt
    · right
      have hne : (energyLevelSet hUsual eta level omega).Nonempty := by
        by_contra hempty
        have hterminal : canonicalEnergyLocalizer hUsual eta level omega = T := by
          simp [canonicalEnergyLocalizer, hempty]
        exact hTt (hterminal ▸ hstop)
      have hmem := canonicalEnergyLocalizer_mem hUsual eta level omega hne
      have hmono := monotone_completedEnergy hUsual eta omega hstop
      exact hmem.2.trans_le hmono
  · rintro (hTt | hcross)
    · exact (canonicalEnergyLocalizer_le_terminal hUsual eta level omega).trans hTt
    · by_cases htT : t ≤ T
      · rcases exists_level_time_of_le hUsual eta hlevel htT hcross with
          ⟨s, hs, hvalue⟩
        have hmem : s ∈ energyLevelSet hUsual eta level omega :=
          ⟨⟨hs.1, hs.2.trans htT⟩, hvalue⟩
        exact (canonicalEnergyLocalizer_le_of_mem hUsual eta level omega hmem).trans hs.2
      · exact (canonicalEnergyLocalizer_le_terminal hUsual eta level omega).trans
          (le_of_not_ge htT)

/-- Canonical-localizer events are measurable at the observation time. -/
theorem measurableSet_canonicalEnergyLocalizer_le
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    {level : ℝ} (hlevel : 0 ≤ level) (t : ℝ≥0) :
    MeasurableSet[filtration t]
      {omega | canonicalEnergyLocalizer hUsual eta level omega ≤ t} := by
  rw [show {omega | canonicalEnergyLocalizer hUsual eta level omega ≤ t} =
      {omega | T ≤ t} ∪
        {omega | level ≤ completedEnergy hUsual eta t omega} by
    ext omega
    simp [canonicalEnergyLocalizer_le_iff hUsual eta hlevel omega t]]
  exact MeasurableSet.union measurableSet_const
    (measurableSet_completedEnergy_ge hUsual eta level t)

/-- On a reached level, completed energy at the canonical localizer equals the
level exactly. -/
theorem completedEnergy_at_canonical_eq_of_nonempty
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (level : ℝ) (omega : Omega)
    (hne : (energyLevelSet hUsual eta level omega).Nonempty) :
    completedEnergy hUsual eta
      (canonicalEnergyLocalizer hUsual eta level omega) omega = level :=
  (canonicalEnergyLocalizer_mem hUsual eta level omega hne).2

/-- Whether or not the level is reached before `T`, stopped completed energy is
bounded by the requested nonnegative level. -/
theorem completedEnergy_at_canonical_le
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    {level : ℝ} (hlevel : 0 ≤ level) (omega : Omega) :
    completedEnergy hUsual eta
      (canonicalEnergyLocalizer hUsual eta level omega) omega ≤ level := by
  by_cases hne : (energyLevelSet hUsual eta level omega).Nonempty
  · rw [completedEnergy_at_canonical_eq_of_nonempty hUsual eta level omega hne]
  · have hstop : canonicalEnergyLocalizer hUsual eta level omega = T := by
      simp [canonicalEnergyLocalizer, hne]
    rw [hstop]
    by_contra hnot
    have hcross : level ≤ completedEnergy hUsual eta T omega :=
      le_of_not_ge hnot
    rcases exists_level_time_of_le hUsual eta hlevel le_rfl hcross with
      ⟨s, hs, hvalue⟩
    apply hne
    exact ⟨s, ⟨hs, hvalue⟩⟩

/-- Higher energy levels are reached no earlier than lower levels. -/
theorem canonicalEnergyLocalizer_mono_level
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    {c d : ℝ} (hc : 0 ≤ c) (hcd : c ≤ d) (omega : Omega) :
    canonicalEnergyLocalizer hUsual eta c omega ≤
      canonicalEnergyLocalizer hUsual eta d omega := by
  by_cases hne : (energyLevelSet hUsual eta d omega).Nonempty
  · have hdmem := canonicalEnergyLocalizer_mem hUsual eta d omega hne
    have hcross : c ≤ completedEnergy hUsual eta
        (canonicalEnergyLocalizer hUsual eta d omega) omega := by
      rw [hdmem.2]
      exact hcd
    rcases exists_level_time_of_le hUsual eta hc hdmem.1.2 hcross with
      ⟨s, hs, hvalue⟩
    have hcmem : s ∈ energyLevelSet hUsual eta c omega :=
      ⟨⟨hs.1, hs.2.trans hdmem.1.2⟩, hvalue⟩
    exact (canonicalEnergyLocalizer_le_of_mem hUsual eta c omega hcmem).trans hs.2
  · have hd : canonicalEnergyLocalizer hUsual eta d omega = T := by
      simp [canonicalEnergyLocalizer, hne]
    rw [hd]
    exact canonicalEnergyLocalizer_le_terminal hUsual eta c omega

/-- Chewi's canonical localizer uses the positive integer level `n+1`. -/
noncomputable def canonicalLocalizingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (n : ℕ) (omega : Omega) : ℝ≥0 :=
  canonicalEnergyLocalizer hUsual eta (n + 1 : ℝ) omega

/-- Canonical localizing times increase with `n`. -/
theorem canonicalLocalizingTime_mono
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (omega : Omega) :
    Monotone (fun n => canonicalLocalizingTime hUsual eta n omega) := by
  intro n k hnk
  apply canonicalEnergyLocalizer_mono_level hUsual eta (by positivity)
  exact_mod_cast Nat.succ_le_succ hnk

/-- Every path is eventually left unstopped: once the integer level exceeds
terminal energy, the localizer equals `T`. -/
theorem canonicalLocalizingTime_eventually_eq_terminal
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (omega : Omega) :
    ∀ᶠ n in Filter.atTop,
      canonicalLocalizingTime hUsual eta n omega = T := by
  obtain ⟨N, hN⟩ := exists_nat_gt
    (completedEnergy hUsual eta T omega)
  filter_upwards [Filter.eventually_ge_atTop N] with n hn
  have hlevel : completedEnergy hUsual eta T omega < (n + 1 : ℝ) := by
    have hNn : (N : ℝ) ≤ n := by exact_mod_cast hn
    exact hN.trans_le (hNn.trans (by norm_num))
  have hempty :
      ¬(energyLevelSet hUsual eta (n + 1 : ℝ) omega).Nonempty := by
    rintro ⟨t, ht, hvalue⟩
    have hmono := monotone_completedEnergy hUsual eta omega ht.1.2
    rw [hvalue] at hmono
    exact (not_le_of_gt hlevel) hmono
  simp [canonicalLocalizingTime, canonicalEnergyLocalizer, hempty]

/-- Canonical localizing times converge pointwise to the terminal horizon. -/
theorem tendsto_canonicalLocalizingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (omega : Omega) :
    Filter.Tendsto (fun n => canonicalLocalizingTime hUsual eta n omega)
      Filter.atTop (𝓝 T) := by
  apply Filter.tendsto_congr'
      (canonicalLocalizingTime_eventually_eq_terminal hUsual eta omega) |>.2
  exact Filter.tendsto_const_nhds

/-- The stopped completed energy at the `n`-th localizer is bounded by `n+1`. -/
theorem completedEnergy_at_canonicalLocalizingTime_le
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (n : ℕ) (omega : Omega) :
    completedEnergy hUsual eta
      (canonicalLocalizingTime hUsual eta n omega) omega ≤ (n + 1 : ℝ) := by
  exact completedEnergy_at_canonical_le hUsual eta (by positivity) omega

end CanonicalEnergyLocalizer
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
