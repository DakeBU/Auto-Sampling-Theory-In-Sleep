import Mathlib.Tactic
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicElementaryRefinement
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicGlobalHorizon
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2HorizonExtension

/-!
# Exact extension of dyadic elementary processes across dyadic horizons

For dyadic global horizons `H_a = 2^a ≤ H_b = 2^b`, a dyadic elementary
process on `H_a` can be represented on `H_b` without changing its mesh: if its
old dyadic level is `L`, use the new level `L + (b-a)`.  The first `2^L`
coefficients are copied and every later coefficient is zero.

This is the finite algebraic heart of cross-horizon Itô consistency.  The
resulting larger-horizon process is literally the zero extension of the old
one and its terminal finite Itô sum is unchanged pathwise.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace DyadicHorizonExtension

open MeasureTheory
open scoped BigOperators NNReal

open BrownianMotion DyadicElementaryRefinement DyadicGlobalHorizon
  ElementaryItoEmbedding ElementaryItoIntegral FiniteTimeGrid ProgressiveL2
  ProgressiveL2Density SampledElementaryApproximation

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

/-- New dyadic level after enlarging the horizon from `2^a` to `2^b` while
keeping the physical mesh fixed. -/
def extensionLevel {a : ℕ}
    (q : DyadicElementaryProcess filtration (dyadicHorizon a)) (b : ℕ) : ℕ :=
  q.level + (b - a)

/-- Exact mesh alignment under the level shift `L ↦ L + (b-a)`. -/
theorem dyadicMesh_dyadicHorizon_align
    (level a b : ℕ) (hab : a ≤ b) :
    dyadicMesh (dyadicHorizon a) level =
      dyadicMesh (dyadicHorizon b) (level + (b - a)) := by
  unfold dyadicMesh dyadicHorizon
  apply (div_eq_div_iff (by positivity) (by positivity)).2
  norm_cast
  have hba : a + (b - a) = b := Nat.add_sub_of_le hab
  calc
    2 ^ a * 2 ^ (level + (b - a)) =
        2 ^ a * (2 ^ level * 2 ^ (b - a)) := by rw [pow_add]
    _ = 2 ^ (a + (b - a)) * 2 ^ level := by
      rw [pow_add]
      ac_rfl
    _ = 2 ^ b * 2 ^ level := by rw [hba]

/-- The old cell count embeds into the enlarged dyadic cell count. -/
theorem oldCellCount_le_extension {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a)) :
    2 ^ q.level ≤ 2 ^ extensionLevel q b := by
  apply Nat.pow_le_pow_right (by decide)
  unfold extensionLevel
  omega

/-- Old cell index regarded as a prefix index of the enlarged grid. -/
def prefixIndex {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (i : Fin (2 ^ q.level)) : Fin (2 ^ extensionLevel q b) :=
  i.castLE (oldCellCount_le_extension hab q)

@[simp] theorem prefixIndex_val {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (i : Fin (2 ^ q.level)) :
    (prefixIndex hab q i).val = i.val :=
  rfl

/-- Prefix grid times are exactly preserved by the horizon extension. -/
theorem prefix_time_eq {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (i : Fin (2 ^ q.level + 1)) :
    q.process.times i =
      regularGridTimes
        (dyadicMesh (dyadicHorizon b) (extensionLevel q b))
        (2 ^ extensionLevel q b)
        ⟨i.val,
          lt_of_lt_of_le i.isLt
            (Nat.add_le_add_right (oldCellCount_le_extension hab q) 1)⟩ := by
  rw [congrFun q.times_eq i]
  simp only [regularGridTimes]
  rw [← dyadicMesh_dyadicHorizon_align q.level a b hab]

/-- Dyadic zero extension from `H_a` to `H_b`. -/
noncomputable def extendDyadicHorizon {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a)) :
    DyadicElementaryProcess filtration (dyadicHorizon b) where
  level := extensionLevel q b
  process :=
    { times := regularGridTimes
        (dyadicMesh (dyadicHorizon b) (extensionLevel q b))
        (2 ^ extensionLevel q b)
      times_strictMono := regularGridTimes_strictMono
        (dyadicMesh_pos (dyadicHorizon_pos b) (extensionLevel q b)) _
      coeff := fun j omega =>
        if hj : j.val < 2 ^ q.level then
          q.process.coeff ⟨j.val, hj⟩ omega
        else 0
      coeff_stronglyMeasurable := fun j => by
        classical
        by_cases hj : j.val < 2 ^ q.level
        · have hq := q.process.coeff_stronglyMeasurable
            (⟨j.val, hj⟩ : Fin (2 ^ q.level))
          have htime :
              q.process.times
                  (⟨j.val, hj⟩ : Fin (2 ^ q.level)).castSucc =
                regularGridTimes
                  (dyadicMesh (dyadicHorizon b) (extensionLevel q b))
                  (2 ^ extensionLevel q b) j.castSucc := by
            rw [congrFun q.times_eq
              (⟨j.val, Nat.lt.step hj⟩ : Fin (2 ^ q.level + 1))]
            simp only [regularGridTimes, Fin.val_castSucc]
            rw [← dyadicMesh_dyadicHorizon_align q.level a b hab]
          rw [htime] at hq
          simpa [hj] using hq
        · simp [hj]
      coeff_bounded := fun j => by
        classical
        by_cases hj : j.val < 2 ^ q.level
        · obtain ⟨C, hC⟩ := q.process.coeff_bounded
            (⟨j.val, hj⟩ : Fin (2 ^ q.level))
          exact ⟨C, by simpa [hj] using hC⟩
        · exact ⟨0, by simp [hj]⟩ }
  times_eq := rfl

@[simp] theorem extendDyadicHorizon_level {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a)) :
    (extendDyadicHorizon hab q).level = extensionLevel q b :=
  rfl

@[simp] theorem extendDyadicHorizon_times {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a)) :
    (extendDyadicHorizon hab q).process.times =
      regularGridTimes
        (dyadicMesh (dyadicHorizon b) (extensionLevel q b))
        (2 ^ extensionLevel q b) :=
  rfl

/-- Prefix coefficients are copied exactly. -/
theorem extendDyadicHorizon_coeff_prefix {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (j : Fin (2 ^ extensionLevel q b))
    (hj : j.val < 2 ^ q.level) (omega : Omega) :
    (extendDyadicHorizon hab q).process.coeff j omega =
      q.process.coeff ⟨j.val, hj⟩ omega := by
  simp [extendDyadicHorizon, hj]

/-- Every new tail coefficient is exactly zero. -/
theorem extendDyadicHorizon_coeff_tail {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (j : Fin (2 ^ extensionLevel q b))
    (hj : 2 ^ q.level ≤ j.val) (omega : Omega) :
    (extendDyadicHorizon hab q).process.coeff j omega = 0 := by
  simp [extendDyadicHorizon, not_lt.mpr hj]

/-- The enlarged process agrees with the old elementary process on the whole
old horizon. -/
theorem extendDyadicHorizon_value_eq_of_le {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    {t : ℝ≥0} (ht : t ≤ dyadicHorizon a) (omega : Omega) :
    (extendDyadicHorizon hab q).process.value t omega =
      q.process.value t omega := by
  by_cases ht0 : t = 0
  · subst t
    have hq0 : q.process.times 0 = 0 := by
      rw [congrFun q.times_eq 0]
      simp [regularGridTimes]
    have he0 : (extendDyadicHorizon hab q).process.times 0 = 0 := by
      simp [extendDyadicHorizon, regularGridTimes]
    rw [q.process.value_eq_zero_of_le_first (by simp [hq0]) omega,
      (extendDyadicHorizon hab q).process.value_eq_zero_of_le_first
        (by simp [he0]) omega]
  · have htpos : 0 < t := pos_of_ne_zero ht0
    obtain ⟨i, hi, _⟩ :=
      dyadic_activeCell (DyadicElementaryProcess.horizon_pos q) q.level htpos ht
    have hqcell :
        q.process.times i.castSucc < t ∧ t ≤ q.process.times i.succ := by
      simpa only [q.times_eq] using hi
    rw [q.process.value_eq_coeff_of_mem_cell hqcell]
    let j : Fin (2 ^ extensionLevel q b) := prefixIndex hab q i
    have hjcell :
        (extendDyadicHorizon hab q).process.times j.castSucc < t ∧
          t ≤ (extendDyadicHorizon hab q).process.times j.succ := by
      change
        regularGridTimes
              (dyadicMesh (dyadicHorizon b) (extensionLevel q b))
              (2 ^ extensionLevel q b) j.castSucc < t ∧
          t ≤ regularGridTimes
              (dyadicMesh (dyadicHorizon b) (extensionLevel q b))
              (2 ^ extensionLevel q b) j.succ
      simpa [j, prefixIndex, regularGridTimes,
        dyadicMesh_dyadicHorizon_align q.level a b hab] using hi
    rw [(extendDyadicHorizon hab q).process.value_eq_coeff_of_mem_cell hjcell]
    exact extendDyadicHorizon_coeff_prefix hab q j i.isLt omega

/-- The enlarged process is zero strictly after the old horizon. -/
theorem extendDyadicHorizon_value_eq_zero_of_old_lt {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    {t : ℝ≥0} (ht : dyadicHorizon a < t) (omega : Omega) :
    (extendDyadicHorizon hab q).process.value t omega = 0 := by
  by_cases htb : t ≤ dyadicHorizon b
  · obtain ⟨j, hj, _⟩ :=
      dyadic_activeCell (dyadicHorizon_pos b) (extensionLevel q b)
        (lt_of_le_of_lt (by simp) ht) htb
    have hjcell :
        (extendDyadicHorizon hab q).process.times j.castSucc < t ∧
          t ≤ (extendDyadicHorizon hab q).process.times j.succ := by
      simpa only [extendDyadicHorizon_times] using hj
    rw [(extendDyadicHorizon hab q).process.value_eq_coeff_of_mem_cell hjcell]
    apply extendDyadicHorizon_coeff_tail hab q j
    by_contra hprefix
    have hjlt : j.val < 2 ^ q.level := Nat.lt_of_not_ge hprefix
    have hleftOld :
        (extendDyadicHorizon hab q).process.times j.castSucc <
          dyadicHorizon a := by
      change
        regularGridTimes
            (dyadicMesh (dyadicHorizon b) (extensionLevel q b))
            (2 ^ extensionLevel q b) j.castSucc < dyadicHorizon a
      rw [← dyadicMesh_dyadicHorizon_align q.level a b hab]
      have hjSucc : j.val + 1 ≤ 2 ^ q.level := Nat.succ_le_iff.2 hjlt
      calc
        (j.val : ℝ≥0) * dyadicMesh (dyadicHorizon a) q.level <
            ((j.val + 1 : ℕ) : ℝ≥0) * dyadicMesh (dyadicHorizon a) q.level := by
              gcongr
              · exact_mod_cast Nat.lt_succ_self j.val
              · exact (dyadicMesh_pos (dyadicHorizon_pos a) q.level)
        _ ≤ ((2 ^ q.level : ℕ) : ℝ≥0) *
            dyadicMesh (dyadicHorizon a) q.level := by
              gcongr
              exact_mod_cast hjSucc
        _ = dyadicHorizon a := by
              rw [dyadicMesh, mul_comm, div_mul_cancel₀]
              positivity
    exact (not_lt_of_ge ht.le) (hleftOld.trans_le hj.1.le)
  · have hlast :
        (extendDyadicHorizon hab q).process.times
          (Fin.last (2 ^ extensionLevel q b)) = dyadicHorizon b := by
      simpa only [extendDyadicHorizon_times] using
        regularDyadic_last_time (dyadicHorizon b) (extensionLevel q b)
    exact (extendDyadicHorizon hab q).process.value_eq_zero_of_last_lt
      (by rw [hlast]; exact lt_of_not_ge htb) omega

/-- Pointwise process form of dyadic horizon zero extension. -/
theorem extendDyadicHorizon_value_eq_restrictProcess {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (t : ℝ≥0) (omega : Omega) :
    (extendDyadicHorizon hab q).process.value t omega =
      ProgressiveL2Integrand.restrictProcess (dyadicHorizon a)
        q.process.value t omega := by
  by_cases ht : t < dyadicHorizon a
  · rw [ProgressiveL2Integrand.restrictProcess, if_pos ht]
    exact extendDyadicHorizon_value_eq_of_le hab q ht.le omega
  · rw [ProgressiveL2Integrand.restrictProcess, if_neg ht]
    by_cases hta : t = dyadicHorizon a
    · subst t
      exact (extendDyadicHorizon_value_eq_of_le hab q le_rfl omega).trans
        (by
          have hlast : q.process.times (Fin.last (2 ^ q.level)) =
              dyadicHorizon a := by
            rw [congrFun q.times_eq (Fin.last (2 ^ q.level))]
            exact regularDyadic_last_time _ _
          have hzero : q.process.value (dyadicHorizon a) omega =
              q.process.coeff (Fin.last' (by positivity)) omega := by
            apply q.process.value_eq_coeff_of_mem_cell
            constructor
            · exact q.process.times_strictMono
                (Fin.castSucc_lt_last (Fin.last' (by positivity)))
                |>.trans_eq hlast
            · exact hlast.ge
          rw [hzero]
          rfl)
    · have hlt : dyadicHorizon a < t := lt_of_le_of_ne (le_of_not_gt ht) (Ne.symm hta)
      exact extendDyadicHorizon_value_eq_zero_of_old_lt hab q hlt omega

end DyadicHorizonExtension
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
