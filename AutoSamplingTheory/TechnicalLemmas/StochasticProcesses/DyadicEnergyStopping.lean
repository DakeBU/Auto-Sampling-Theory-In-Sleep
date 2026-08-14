import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CompletedLocalIntegrand
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FiniteTimeGrid
import Mathlib.Probability.Process.HittingTime

/-!
# Dyadic energy stopping times

The canonical continuous energy hitting time is approximated from the right by
finite dyadic hitting times.  This file constructs each finite approximation
as a genuine stopping time.  The later limit theorem uses right continuity of
the filtration and continuity of the accumulated energy.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace DyadicEnergyStopping

open MeasureTheory Set
open scoped ENNReal NNReal

open ElementaryItoIntegral ProgressiveL2 LocalSquareIntegrable
  CompletedLocalIntegrand SampledElementaryApproximation

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

/-- Zero extension of a completed local integrand from `[0,b]`. -/
noncomputable def localExtensionAt
    (eta : LocallySquareIntegrableProgressive filtration mu T) (b : ℝ≥0) :
    ℝ≥0 × Omega → ℝ :=
  Function.extend
    (Prod.map ((↑) : Set.Iic b → ℝ≥0) id)
    (fun p : Set.Iic b × Omega => eta.process p.1 p.2)
    0

theorem localExtensionAt_stronglyMeasurable
    (eta : LocallySquareIntegrableProgressive filtration mu T) (b : ℝ≥0) :
    @StronglyMeasurable (ℝ≥0 × Omega) ℝ inferInstance
      (MeasurableSpace.prod inferInstance (filtration b))
      (localExtensionAt eta b) := by
  apply ((MeasurableEmbedding.subtype_coe measurableSet_Iic).prodMap
    MeasurableEmbedding.id).stronglyMeasurable_extend
  · exact eta.progressive b
  · exact stronglyMeasurable_const

@[simp] theorem localExtensionAt_apply_of_le
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    {s b : ℝ≥0} (hsb : s ≤ b) (omega : Omega) :
    localExtensionAt eta b (s, omega) = eta.process s omega := by
  let p : Set.Iic b × Omega := (⟨s, hsb⟩, omega)
  exact ((MeasurableEmbedding.subtype_coe measurableSet_Iic).prodMap
    MeasurableEmbedding.id).injective.extend_apply
      (fun q : Set.Iic b × Omega => eta.process q.1 q.2) 0 p

@[simp] theorem localExtensionAt_eq_zero_of_not_le
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    {s b : ℝ≥0} (hsb : ¬s ≤ b) (omega : Omega) :
    localExtensionAt eta b (s, omega) = 0 := by
  rw [localExtensionAt, Function.extend_apply']
  · rfl
  · rintro ⟨u, hu⟩
    apply hsb
    have htime := congrArg Prod.fst hu
    change (u.1 : ℝ≥0) = s at htime
    have hub : (u.1 : ℝ≥0) ≤ b := u.1.property
    rwa [← htime]

/-- Pathwise squared energy accumulated through `min t T`. -/
noncomputable def localAccumulatedEnergy
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (t : ℝ≥0) (omega : Omega) : ℝ≥0∞ :=
  ∫⁻ s, ENNReal.ofReal
      ((localExtensionAt eta (min t T) (s, omega)) ^ 2)
    ∂(TimeMeasure.upTo T)

theorem localAccumulatedEnergy_measurable_min
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (t : ℝ≥0) :
    @Measurable Omega ℝ≥0∞ (filtration (min t T)) inferInstance
      (localAccumulatedEnergy eta t) := by
  have hreal := (localExtensionAt_stronglyMeasurable eta (min t T)).measurable
  have hsquare :
      @Measurable (ℝ≥0 × Omega) ℝ
        (MeasurableSpace.prod inferInstance (filtration (min t T))) inferInstance
        (fun z => (localExtensionAt eta (min t T) z) ^ 2) :=
    hreal.pow_const 2
  have hnonnegative :
      @Measurable (ℝ≥0 × Omega) ℝ≥0∞
        (MeasurableSpace.prod inferInstance (filtration (min t T))) inferInstance
        (fun z => ENNReal.ofReal ((localExtensionAt eta (min t T) z) ^ 2)) :=
    ENNReal.measurable_ofReal.comp hsquare
  exact @Measurable.lintegral_prod_left'
    ℝ≥0 Omega inferInstance (filtration (min t T))
    (TimeMeasure.upTo T) inferInstance
    (fun z => ENNReal.ofReal ((localExtensionAt eta (min t T) z) ^ 2))
    hnonnegative

private theorem localExtension_sq_mono
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    {a b : ℝ≥0} (hab : a ≤ b) (s : ℝ≥0) (omega : Omega) :
    ENNReal.ofReal ((localExtensionAt eta a (s, omega)) ^ 2) ≤
      ENNReal.ofReal ((localExtensionAt eta b (s, omega)) ^ 2) := by
  by_cases hsa : s ≤ a
  · rw [localExtensionAt_apply_of_le eta hsa omega,
      localExtensionAt_apply_of_le eta (hsa.trans hab) omega]
  · rw [localExtensionAt_eq_zero_of_not_le eta hsa omega]
    simp

theorem localAccumulatedEnergy_mono
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    {s t : ℝ≥0} (hst : s ≤ t) (omega : Omega) :
    localAccumulatedEnergy eta s omega ≤ localAccumulatedEnergy eta t omega := by
  unfold localAccumulatedEnergy
  apply lintegral_mono
  intro u
  exact localExtension_sq_mono eta (min_le_min hst le_rfl) u omega

/-- Time of a node of the level-`level` dyadic grid on `[0,T]`. -/
noncomputable def dyadicGridTime
    (T : ℝ≥0) (level : ℕ) (i : Fin (2 ^ level + 1)) : ℝ≥0 :=
  regularGridTimes (dyadicMesh T level) (2 ^ level) i

theorem dyadicGridTime_strictMono
    {T : ℝ≥0} (hT : 0 < T) (level : ℕ) :
    StrictMono (dyadicGridTime T level) :=
  regularGridTimes_strictMono (dyadicMesh_pos hT level) _

theorem dyadicGridTime_last
    {T : ℝ≥0} (hT : 0 < T) (level : ℕ) :
    dyadicGridTime T level (Fin.last (2 ^ level)) = T := by
  simp only [dyadicGridTime, regularGridTimes, Fin.val_last, Nat.cast_pow,
    Nat.cast_ofNat, dyadicMesh]
  rw [mul_comm, div_mul_cancel₀]
  positivity

theorem dyadicGridTime_le_terminal
    {T : ℝ≥0} (hT : 0 < T) (level : ℕ)
    (i : Fin (2 ^ level + 1)) :
    dyadicGridTime T level i ≤ T := by
  exact (dyadicGridTime_strictMono hT level).monotone (Fin.le_last i) |>.trans_eq
    (dyadicGridTime_last hT level)

/-- The original filtration restricted to the finite dyadic grid. -/
def dyadicFiltration
    (filtration : Filtration ℝ≥0 m) (T : ℝ≥0) (level : ℕ) :
    Filtration (Fin (2 ^ level + 1)) m where
  seq i := filtration (dyadicGridTime T level i)
  mono' _ _ hij := filtration.mono
    ((dyadicGridTime_strictMono (T := T) (by positivity) level).monotone hij)
  le' i := filtration.le _

/-- Completed accumulated energy sampled on a finite dyadic grid. -/
noncomputable def dyadicEnergyProcess
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (level : ℕ) : Fin (2 ^ level + 1) → Omega → ℝ≥0∞ :=
  fun i => localAccumulatedEnergy (completed hUsual eta)
    (dyadicGridTime T level i)

theorem dyadicEnergyProcess_adapted
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (hT : 0 < T) (level : ℕ) :
    Adapted (dyadicFiltration filtration T level)
      (dyadicEnergyProcess hUsual eta level) := by
  intro i
  have hmeas := localAccumulatedEnergy_measurable_min
    (completed hUsual eta) (dyadicGridTime T level i)
  have hle := dyadicGridTime_le_terminal hT level i
  simpa [dyadicFiltration, min_eq_left hle] using hmeas

/-- First dyadic grid index at which accumulated energy reaches the natural
threshold, or the final grid index if it does not. -/
noncomputable def dyadicEnergyHitIndex
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (level threshold : ℕ) : Omega → Fin (2 ^ level + 1) :=
  hittingBtwn (dyadicEnergyProcess hUsual eta level)
    (Set.Ici (threshold : ℝ≥0∞)) 0 (Fin.last (2 ^ level))

theorem dyadicEnergyHitIndex_isStoppingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (hT : 0 < T) (level threshold : ℕ) :
    IsStoppingTime (dyadicFiltration filtration T level)
      (fun omega =>
        (dyadicEnergyHitIndex hUsual eta level threshold omega :
          WithTop (Fin (2 ^ level + 1)))) := by
  exact (dyadicEnergyProcess_adapted hUsual eta hT level)
    .isStoppingTime_hittingBtwn measurableSet_Ici

/-- The corresponding actual nonnegative time on the finite dyadic grid. -/
noncomputable def dyadicEnergyHitTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (level threshold : ℕ) : Omega → WithTop ℝ≥0 :=
  fun omega => dyadicGridTime T level
    (dyadicEnergyHitIndex hUsual eta level threshold omega)

/-- Every finite dyadic energy-hitting approximation is a genuine stopping
time for the original continuous-time filtration. -/
theorem dyadicEnergyHitTime_isStoppingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (hT : 0 < T) (level threshold : ℕ) :
    IsStoppingTime filtration
      (dyadicEnergyHitTime hUsual eta level threshold) := by
  intro t
  have hindex := dyadicEnergyHitIndex_isStoppingTime hUsual eta hT level threshold
  let times := dyadicGridTime T level
  let hit := dyadicEnergyHitIndex hUsual eta level threshold
  have hevent :
      {omega | dyadicEnergyHitTime hUsual eta level threshold omega ≤ t} =
        ⋃ i : Fin (2 ^ level + 1),
          if times i ≤ t then
            {omega | (hit omega : WithTop (Fin (2 ^ level + 1))) ≤ i}
          else ∅ := by
    ext omega
    constructor
    · intro homega
      refine Set.mem_iUnion.2 ⟨hit omega, ?_⟩
      have htime : times (hit omega) ≤ t := by
        exact_mod_cast homega
      simp [htime]
    · intro homega
      rcases Set.mem_iUnion.1 homega with ⟨i, hi⟩
      by_cases htime : times i ≤ t
      · simp only [htime, if_true, Set.mem_setOf_eq] at hi
        have hhit : hit omega ≤ i := by exact_mod_cast hi
        have hmono : times (hit omega) ≤ times i :=
          (dyadicGridTime_strictMono hT level).monotone hhit
        exact_mod_cast hmono.trans htime
      · simp [htime] at hi
  rw [hevent]
  refine MeasurableSet.iUnion fun i => ?_
  by_cases htime : times i ≤ t
  · simp only [htime, if_true]
    have hi := hindex i
    change MeasurableSet[(dyadicFiltration filtration T level) i]
      {omega | (hit omega : WithTop (Fin (2 ^ level + 1))) ≤ i} at hi
    exact (filtration.mono htime) _ (by simpa [dyadicFiltration, times, hit] using hi)
  · simp [htime]

end DyadicEnergyStopping
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
