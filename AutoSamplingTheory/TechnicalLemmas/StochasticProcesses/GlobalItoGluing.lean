import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalStoppedItoMartingale
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Localization

/-!
# Global gluing of the localized Ito martingales

This module closes the stochastic-calculus localization chain behind Chewi
Proposition 1.1.16.

For the cofinal dyadic localization ladder, let `M_k` be the genuine continuous
martingale obtained by integrating the globally stopped integrand and let
`tau_k` be its matching stopping time.  The preceding overlap theorem says that,
on one full-measure event for every pair `k <= ell`, `M_k` and `M_ell` agree at
all times before `tau_k`.  Since `tau_k -> infinity` almost surely, the sequence
`M_k(t, omega)` is therefore eventually constant for every fixed `(t, omega)`
on the good event.

We define the global Ito process by `limUnder` in the localization index and
patch the complementary null set by zero.  The patch gives an everywhere
continuous, strongly adapted representative.  Stopping this global process at
`tau_k` agrees almost surely with the already constructed stopped martingale
`M_k^{tau_k}`, hence is a martingale by `Martingale.congr`.  This supplies the
exact witness required by `Localization.IsLocalMartingale` without invoking
optional stopping.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace GlobalItoGluing

open Filter MeasureTheory Set WithTop
open scoped NNReal Topology

open BrownianMotion DyadicGlobalHorizon GlobalLocalProgressiveL2
  GlobalStoppedItoMartingale Localization ProgressiveL2 StoppingTime

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

/-- The common full-measure event used for global gluing: the localizers tend to
infinity and every later localized martingale agrees with an earlier one before
the earlier localizer fires. -/
def gluingGoodEvent [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) : Set Omega :=
  {omega |
    Tendsto
      (fun k =>
        (dyadicGlobalLocalizingTime hUsual eta k omega : WithTop ℝ≥0))
      atTop (𝓝 (⊤ : WithTop ℝ≥0)) ∧
    ∀ k ell : ℕ, k ≤ ell → ∀ t : ℝ≥0,
      t ≤ dyadicGlobalLocalizingTime hUsual eta k omega →
        globalStoppedItoProcess hUsual eta hB k t omega =
          globalStoppedItoProcess hUsual eta hB ell t omega}

/-- Pairwise coherence can be placed on one full-measure event because the
localization indices are countable. -/
theorem pairwise_gluing_coherence_ae [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    ∀ᵐ omega ∂mu, ∀ k ell : ℕ, k ≤ ell → ∀ t : ℝ≥0,
      t ≤ dyadicGlobalLocalizingTime hUsual eta k omega →
        globalStoppedItoProcess hUsual eta hB k t omega =
          globalStoppedItoProcess hUsual eta hB ell t omega := by
  rw [ae_all_iff]
  intro k
  rw [ae_all_iff]
  intro ell
  by_cases hkell : k ≤ ell
  · filter_upwards [globalStoppedItoProcess_eq_of_le_localizer_ae
      hUsual eta hB hkell] with omega homega
    intro _
    exact homega
  · filter_upwards [] with omega
    intro hcontra
    exact (hkell hcontra).elim

/-- The gluing event has full measure. -/
theorem gluingGoodEvent_ae [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    ∀ᵐ omega ∂mu, omega ∈ gluingGoodEvent hUsual eta hB := by
  filter_upwards [dyadicGlobalLocalizingTime_tendsto_top_ae hUsual eta,
    pairwise_gluing_coherence_ae hUsual eta hB] with omega htau hpair
  exact ⟨htau, hpair⟩

/-- The null exceptional set patched by zero in the final global process. -/
def gluingBadSet [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) : Set Omega :=
  (gluingGoodEvent hUsual eta hB)ᶜ

/-- The gluing exceptional set is null. -/
theorem measure_gluingBadSet_zero [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    mu (gluingBadSet hUsual eta hB) = 0 := by
  simpa only [gluingBadSet] using
    (ae_iff.1 (gluingGoodEvent_ae hUsual eta hB))

/-- Completeness of the filtration makes the gluing null set measurable at
every time. -/
theorem measurableSet_gluingBadSet_at [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (t : ℝ≥0) :
    MeasurableSet[filtration t] (gluingBadSet hUsual eta hB) :=
  hUsual.completeAt t _ (measure_gluingBadSet_zero hUsual eta hB)

/-- Raw pointwise gluing of the localized martingales.  On the good event this
is an eventually constant limit, rather than a new analytic limit. -/
noncomputable def globalItoLimit [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (t : ℝ≥0) (omega : Omega) : ℝ :=
  atTop.limUnder
    (fun k => globalStoppedItoProcess hUsual eta hB k t omega)

/-- The raw `limUnder` process is strongly adapted; no convergence assumption is
needed for this measurability statement. -/
theorem globalItoLimit_stronglyAdapted [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    StronglyAdapted filtration (globalItoLimit hUsual eta hB) := by
  intro t
  let _ : MeasurableSpace Omega := filtration t
  exact StronglyMeasurable.limUnder fun k =>
    (globalStoppedItoProcess_stronglyAdapted hUsual eta hB k) t

/-- Before `tau_k`, the localized process values are eventually constant in the
localization index. -/
theorem eventually_globalStoppedItoProcess_eq_of_good
    [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {omega : Omega} (homega : omega ∈ gluingGoodEvent hUsual eta hB)
    (k : ℕ) {t : ℝ≥0}
    (ht : t ≤ dyadicGlobalLocalizingTime hUsual eta k omega) :
    ∀ᶠ ell : ℕ in atTop,
      globalStoppedItoProcess hUsual eta hB ell t omega =
        globalStoppedItoProcess hUsual eta hB k t omega := by
  filter_upwards [eventually_ge_atTop k] with ell hkell
  exact (homega.2 k ell hkell t ht).symm

/-- On the good event, the raw limit equals any localization level whose
stopping time still lies to the right of the queried time. -/
theorem globalItoLimit_eq_localized_of_good [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {omega : Omega} (homega : omega ∈ gluingGoodEvent hUsual eta hB)
    (k : ℕ) {t : ℝ≥0}
    (ht : t ≤ dyadicGlobalLocalizingTime hUsual eta k omega) :
    globalItoLimit hUsual eta hB t omega =
      globalStoppedItoProcess hUsual eta hB k t omega := by
  have hev :
      (fun ell => globalStoppedItoProcess hUsual eta hB ell t omega) =ᶠ[atTop]
        (fun _ : ℕ => globalStoppedItoProcess hUsual eta hB k t omega) :=
    eventually_globalStoppedItoProcess_eq_of_good hUsual eta hB homega k ht
  have htend : Tendsto
      (fun ell => globalStoppedItoProcess hUsual eta hB ell t omega)
      atTop (𝓝 (globalStoppedItoProcess hUsual eta hB k t omega)) :=
    tendsto_const_nhds.congr' hev.symm
  have hlim : Tendsto
      (fun ell => globalStoppedItoProcess hUsual eta hB ell t omega)
      atTop (𝓝 (globalItoLimit hUsual eta hB t omega)) := by
    change Tendsto
      (fun ell => globalStoppedItoProcess hUsual eta hB ell t omega)
      atTop
      (𝓝 (atTop.limUnder
        (fun ell => globalStoppedItoProcess hUsual eta hB ell t omega)))
    exact htend.cauchySeq.tendsto_limUnder
  exact tendsto_nhds_unique hlim htend

/-- The final global Ito process, patched by zero on the common null exceptional
set. -/
noncomputable def globalItoProcess [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    ℝ≥0 → Omega → ℝ := by
  classical
  exact fun t omega =>
    if omega ∈ gluingBadSet hUsual eta hB then 0
    else globalItoLimit hUsual eta hB t omega

/-- On the good event the patched process is exactly the stabilized localized
martingale. -/
theorem globalItoProcess_eq_localized_of_good [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {omega : Omega} (homega : omega ∈ gluingGoodEvent hUsual eta hB)
    (k : ℕ) {t : ℝ≥0}
    (ht : t ≤ dyadicGlobalLocalizingTime hUsual eta k omega) :
    globalItoProcess hUsual eta hB t omega =
      globalStoppedItoProcess hUsual eta hB k t omega := by
  have hnot : omega ∉ gluingBadSet hUsual eta hB := by
    simpa only [gluingBadSet, mem_compl_iff, not_not] using homega
  simp only [globalItoProcess, hnot, if_false]
  exact globalItoLimit_eq_localized_of_good hUsual eta hB homega k ht

/-- The patched global process is strongly adapted. -/
theorem globalItoProcess_stronglyAdapted [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    StronglyAdapted filtration (globalItoProcess hUsual eta hB) := by
  intro t
  classical
  exact StronglyMeasurable.ite
    (measurableSet_gluingBadSet_at hUsual eta hB t)
    stronglyMeasurable_const
    ((globalItoLimit_stronglyAdapted hUsual eta hB) t)

/-- The global process has an everywhere-continuous path.  On a good path,
`tau_k -> infinity` gives a localization time strictly to the right of any
queried deterministic time, and the process agrees with the continuous `M_k`
on a whole neighborhood of that time. -/
theorem globalItoProcess_continuous [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (omega : Omega) :
    Continuous (fun t => globalItoProcess hUsual eta hB t omega) := by
  classical
  by_cases hbad : omega ∈ gluingBadSet hUsual eta hB
  · simp only [globalItoProcess, hbad, if_pos]
    exact continuous_const
  · have hgood : omega ∈ gluingGoodEvent hUsual eta hB := by
      simpa only [gluingBadSet, mem_compl_iff, not_not] using hbad
    rw [continuous_iff_continuousAt]
    intro t
    have heventTop :=
      (WithTop.tendsto_nhds_top_iff.mp hgood.1) t
    obtain ⟨k, hk⟩ := eventually_atTop.1 heventTop
    have htTop := hk k le_rfl
    have htTau : t < dyadicGlobalLocalizingTime hUsual eta k omega :=
      WithTop.coe_lt_coe.mp htTop
    have hEqAt := globalItoProcess_eq_localized_of_good
      hUsual eta hB hgood k htTau.le
    have hEqNhds :
        (fun s => globalItoProcess hUsual eta hB s omega) =ᶠ[𝓝 t]
          (fun s => globalStoppedItoProcess hUsual eta hB k s omega) := by
      filter_upwards [Iio_mem_nhds htTau] with s hs
      exact globalItoProcess_eq_localized_of_good
        hUsual eta hB hgood k hs.le
    change Tendsto (fun s => globalItoProcess hUsual eta hB s omega)
      (𝓝 t) (𝓝 (globalItoProcess hUsual eta hB t omega))
    rw [hEqAt]
    exact (globalStoppedItoProcess_continuous hUsual eta hB k omega).continuousAt.congr'
      hEqNhds.symm

/-- The global process starts from zero exactly, including on the patched null
set. -/
@[simp] theorem globalItoProcess_zero [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    globalItoProcess hUsual eta hB 0 = 0 := by
  funext omega
  classical
  by_cases hbad : omega ∈ gluingBadSet hUsual eta hB
  · simp [globalItoProcess, hbad]
  · have hgood : omega ∈ gluingGoodEvent hUsual eta hB := by
      simpa only [gluingBadSet, mem_compl_iff, not_not] using hbad
    have hEq := globalItoProcess_eq_localized_of_good
      hUsual eta hB hgood 0 (zero_le _)
    rw [hEq]
    exact congrFun (globalStoppedItoProcess_zero hUsual eta hB 0) omega

/-- Stopping the global glued process at `tau_k` is a genuine martingale.  The
proof transfers the already proved martingale property of `M_k^{tau_k}` by
almost-sure process congruence. -/
theorem stopped_globalItoProcess_martingale [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (k : ℕ) :
    Martingale
      (stoppedProcess (globalItoProcess hUsual eta hB)
        (fun w =>
          (dyadicGlobalLocalizingTime hUsual eta k w : WithTop ℝ≥0)))
      filtration mu := by
  let tau : Omega → WithTop ℝ≥0 := fun w =>
    (dyadicGlobalLocalizingTime hUsual eta k w : WithTop ℝ≥0)
  let S : ℝ≥0 → Omega → ℝ :=
    stoppedProcess (globalItoProcess hUsual eta hB) tau
  have hbase := stopped_globalStoppedItoProcess_martingale hUsual eta hB k
  have hSadapted : StronglyAdapted filtration S := by
    have hIadapted := globalItoProcess_stronglyAdapted hUsual eta hB
    have hIcont : ∀ omega, Continuous (fun t =>
        globalItoProcess hUsual eta hB t omega) :=
      globalItoProcess_continuous hUsual eta hB
    have htau : MeasureTheory.IsStoppingTime filtration tau := by
      simpa only [tau] using
        dyadicGlobalLocalizingTime_isChewiStoppingTime hUsual eta k
    simpa only [S] using hIadapted.stoppedProcess hIcont htau
  have hEq : ∀ t,
      stoppedProcess (globalStoppedItoProcess hUsual eta hB k) tau t =ᵐ[mu]
        S t := by
    intro t
    filter_upwards [gluingGoodEvent_ae hUsual eta hB] with omega hgood
    rw [stoppedProcess_coe_apply]
    change globalStoppedItoProcess hUsual eta hB k
        (min t (dyadicGlobalLocalizingTime hUsual eta k omega)) omega =
      globalItoProcess hUsual eta hB
        (min t (dyadicGlobalLocalizingTime hUsual eta k omega)) omega
    exact (globalItoProcess_eq_localized_of_good hUsual eta hB hgood k
      (min_le_right _ _)).symm
  simpa only [S, tau] using hbase.congr hSadapted hEq

/-- The glued global Ito process is a local martingale in the exact ASTIS
encoding of Chewi Definition 1.1.15. -/
theorem globalItoProcess_isLocalMartingale [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    IsLocalMartingale (globalItoProcess hUsual eta hB) filtration mu := by
  refine ⟨(globalItoProcess_stronglyAdapted hUsual eta hB).adapted, ?_⟩
  refine ⟨(fun k omega =>
    (dyadicGlobalLocalizingTime hUsual eta k omega : WithTop ℝ≥0)), ?_, ?_, ?_, ?_⟩
  · intro k
    exact dyadicGlobalLocalizingTime_isChewiStoppingTime hUsual eta k
  · intro k ell hkell omega
    exact WithTop.coe_le_coe.mpr
      ((dyadicGlobalLocalizingTime_mono hUsual eta hkell) omega)
  · exact dyadicGlobalLocalizingTime_tendsto_top_ae hUsual eta
  · intro k
    have hmart := stopped_globalItoProcess_martingale hUsual eta hB k
    simpa only [globalItoProcess_zero, Pi.zero_apply, sub_zero] using hmart

/-- **Chewi, Proposition 1.1.16 (continuous local-martingale conclusion).**

A globally progressive integrand satisfying the source local square-integrability
condition on every finite horizon has a canonical glued Ito process with
continuous paths, and that process is a local martingale.  The localizing
sequence is the explicit cofinal dyadic subsequence of the canonical energy
hitting times. -/
theorem chewi_proposition_1_1_16 [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    (∀ omega, Continuous (fun t => globalItoProcess hUsual eta hB t omega)) ∧
      IsLocalMartingale (globalItoProcess hUsual eta hB) filtration mu := by
  exact ⟨globalItoProcess_continuous hUsual eta hB,
    globalItoProcess_isLocalMartingale hUsual eta hB⟩

end GlobalItoGluing
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
