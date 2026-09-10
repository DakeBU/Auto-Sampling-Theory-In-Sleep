import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RecursiveCondition
import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RecursiveVariance
import Mathlib.Analysis.SpecificLimits.Basic

/-!
# Actual recursive RGO parameter schedule

Source: arXiv:2609.06906v1, (6.1)--(6.4) and Lemma 6.6.
The precision recursion retains the source's infinite initial regularization
parameter as zero precision. This is a deterministic parameter calculation;
it is not a construction of a random sampler or a query-cost bound.
-/

namespace AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RecursiveDepth

noncomputable def condition (κ r : ℝ) : ℝ := (1 + r) / (κ⁻¹ + r)

noncomputable def heat (κ c r : ℝ) : ℝ :=
  if 2 ≤ condition κ r then condition κ r else c

noncomputable def stepVariance (κ c r h : ℝ) : ℝ :=
  (h + heat κ c r) / (1 + r)

noncomputable def nextPrecision (κ c r h : ℝ) : ℝ :=
  r + (stepVariance κ c r h)⁻¹

noncomputable def precision (κ c r₀ : ℝ) (η : ℕ → ℝ) : ℕ → ℝ
  | 0 => r₀
  | n + 1 => nextPrecision κ c (precision κ c r₀ η n) (η n)

theorem condition_bounds {κ r : ℝ} (hκ : 1 ≤ κ) (hr : 0 ≤ r) :
    1 ≤ condition κ r := by
  have hkpos : 0 < κ := lt_of_lt_of_le zero_lt_one hκ
  have hbpos : 0 < κ⁻¹ := inv_pos.mpr hkpos
  have hble : κ⁻¹ ≤ 1 := (inv_le_one₀ hkpos).2 hκ
  unfold condition
  apply (one_le_div (add_pos_of_pos_of_nonneg hbpos hr)).2
  linarith

theorem condition_antitone {κ r s : ℝ} (hκ : 1 ≤ κ)
    (hr : 0 ≤ r) (hrs : r ≤ s) : condition κ s ≤ condition κ r := by
  have hkpos : 0 < κ := lt_of_lt_of_le zero_lt_one hκ
  have hbpos : 0 < κ⁻¹ := inv_pos.mpr hkpos
  have hble : κ⁻¹ ≤ 1 := (inv_le_one₀ hkpos).2 hκ
  unfold condition
  apply (div_le_div_iff₀ (add_pos_of_pos_of_nonneg hbpos (hr.trans hrs))
    (add_pos_of_pos_of_nonneg hbpos hr)).2
  nlinarith [mul_nonneg (sub_nonneg.mpr hrs) (sub_nonneg.mpr hble)]

theorem stepVariance_pos {κ c r h : ℝ} (_hκ : 1 ≤ κ)
    (hc : 0 < c) (hr : 0 ≤ r) (hh : 0 < h) :
    0 < stepVariance κ c r h := by
  have hheat : 0 < heat κ c r := by
    unfold heat
    split_ifs with hk
    · linarith
    · exact hc
  exact div_pos (add_pos hh hheat) (by linarith)

theorem nextPrecision_gt {κ c r h : ℝ} (hκ : 1 ≤ κ)
    (hc : 0 < c) (hr : 0 ≤ r) (hh : 0 < h) :
    r < nextPrecision κ c r h := by
  exact lt_add_of_pos_right r (inv_pos.mpr (stepVariance_pos hκ hc hr hh))

theorem precision_nonneg {κ c r₀ : ℝ} {η : ℕ → ℝ}
    (hκ : 1 ≤ κ) (hc : 0 < c) (hr₀ : 0 ≤ r₀) (hη : ∀ n, 0 < η n)
    (n : ℕ) : 0 ≤ precision κ c r₀ η n := by
  induction n with
  | zero => exact hr₀
  | succ n ih =>
    exact ih.trans (nextPrecision_gt hκ hc ih (hη n)).le

theorem precision_succ_pos {κ c r₀ : ℝ} {η : ℕ → ℝ}
    (hκ : 1 ≤ κ) (hc : 0 < c) (hr₀ : 0 ≤ r₀) (hη : ∀ n, 0 < η n)
    (n : ℕ) : 0 < precision κ c r₀ η (n + 1) := by
  have hr := precision_nonneg hκ hc hr₀ hη n
  exact lt_of_le_of_lt hr (nextPrecision_gt hκ hc hr (hη n))

theorem condition_sequence_antitone {κ c r₀ : ℝ} {η : ℕ → ℝ}
    (hκ : 1 ≤ κ) (hc : 0 < c) (hr₀ : 0 ≤ r₀) (hη : ∀ n, 0 < η n) :
    Antitone (fun n => condition κ (precision κ c r₀ η n)) := by
  apply antitone_nat_of_succ_le
  intro n
  have hr := precision_nonneg hκ hc hr₀ hη n
  exact condition_antitone hκ hr (nextPrecision_gt hκ hc hr (hη n)).le

theorem well_conditioned_persists {κ c r₀ : ℝ} {η : ℕ → ℝ}
    (hκ : 1 ≤ κ) (hc : 0 < c) (hr₀ : 0 ≤ r₀) (hη : ∀ n, 0 < η n)
    {m n : ℕ} (hmn : m ≤ n) (hm : condition κ (precision κ c r₀ η m) < 2) :
    condition κ (precision κ c r₀ η n) < 2 :=
  lt_of_le_of_lt (condition_sequence_antitone hκ hc hr₀ hη hmn) hm

private theorem ratio_update {b r t : ℝ} (hb : 0 < b) (hr : 0 ≤ r)
    (ht : 0 < t) :
    (1 + (r + (t / (1 + r))⁻¹)) / (b + (r + (t / (1 + r))⁻¹)) =
      ((1 + r) / (b + r)) * (t + 1) / (t + (1 + r) / (b + r)) := by
  have hB : 0 < 1 + r := by linarith
  have hD : 0 < b + r := add_pos_of_pos_of_nonneg hb hr
  have hnext : 0 < b + (r + (t / (1 + r))⁻¹) := by positivity
  have hden : 0 < t + (1 + r) / (b + r) := by positivity
  rw [inv_div]
  field_simp
  ring

theorem large_branch_contraction {κ c r h : ℝ}
    (hκ : 1 ≤ κ) (hr : 0 ≤ r) (hh : 0 < h) (hhc : h ≤ c)
    (hc : c < 1 / 4) (hk : 2 ≤ condition κ r) :
    condition κ (nextPrecision κ c r h) ≤ (4 / 5) * condition κ r := by
  have hkpos : 0 < κ := lt_of_lt_of_le zero_lt_one hκ
  have ht : 0 < h + condition κ r := by linarith
  have heq := ratio_update (inv_pos.mpr hkpos) hr ht
  have hb := (RecursiveCondition.contraction_bounds hk hh (lt_of_le_of_lt hhc hc)).2
  unfold nextPrecision stepVariance heat
  rw [if_pos hk]
  unfold condition at *
  rw [heq]
  convert hb using 1
  congr 1 <;> ring

theorem enters_well_conditioned {κ c r₀ : ℝ} {η : ℕ → ℝ}
    (hκ : 1 ≤ κ) (hc : 0 < c) (hc_upper : c < 1 / 4) (hr₀ : 0 ≤ r₀)
    (hη : ∀ n, 0 < η n ∧ η n ≤ c) (M : ℕ)
    (hM : (4 / 5 : ℝ) ^ M * condition κ r₀ < 2) :
    condition κ (precision κ c r₀ η M) < 2 := by
  by_contra hnot
  have hlarge : 2 ≤ condition κ (precision κ c r₀ η M) := le_of_not_gt hnot
  have hanti := condition_sequence_antitone hκ hc hr₀ (fun n => (hη n).1)
  have hbound := le_geom (u := fun n => condition κ (precision κ c r₀ η n))
    (c := (4 / 5 : ℝ)) (by norm_num) M (by
      intro n hn
      have hnlarge := hlarge.trans (hanti (Nat.le_of_lt hn))
      exact large_branch_contraction hκ
        (precision_nonneg hκ hc hr₀ (fun j => (hη j).1) n)
        (hη n).1 (hη n).2 hc_upper hnlarge)
  have : condition κ (precision κ c r₀ η M) < 2 := lt_of_le_of_lt hbound hM
  exact (not_lt_of_ge hlarge) this

theorem well_branch_variance {κ c r h : ℝ} (hr : 0 ≤ r)
    (hh : 0 < h) (hhc : h ≤ c) (hk : condition κ r < 2) :
    0 < (nextPrecision κ c r h)⁻¹ ∧
      (nextPrecision κ c r h)⁻¹ ≤ 2 * c ∧
      (0 < r → (nextPrecision κ c r h)⁻¹ ≤ (2 * c / (1 + 2 * c)) * r⁻¹) := by
  rcases RecursiveVariance.variance_update_bounds hr hh hhc with
    ⟨_, hpos, hbound, _, _, hcontract⟩
  unfold nextPrecision stepVariance heat
  rw [if_neg (not_le_of_gt hk)]
  exact ⟨hpos, hbound, hcontract⟩

theorem finite_depth {κ c r₀ : ℝ} {η : ℕ → ℝ}
    (hκ : 1 ≤ κ) (hc : 0 < c) (hc_upper : c < 1 / 4) (hr₀ : 0 ≤ r₀)
    (hη : ∀ n, 0 < η n ∧ η n ≤ c) (M N : ℕ)
    (hM : (4 / 5 : ℝ) ^ M * condition κ r₀ < 2) :
    0 < (precision κ c r₀ η (M + 1 + N))⁻¹ ∧
      (precision κ c r₀ η (M + 1 + N))⁻¹ ≤
        2 * c * (2 * c / (1 + 2 * c)) ^ N := by
  have hm := enters_well_conditioned hκ hc hc_upper hr₀ hη M hM
  have hn (n : ℕ) := precision_nonneg hκ hc hr₀ (fun j => (hη j).1) n
  have hp (n : ℕ) := precision_succ_pos hκ hc hr₀ (fun j => (hη j).1) n
  have hw (n : ℕ) (hmn : M ≤ n) :=
    well_conditioned_persists hκ hc hr₀ (fun j => (hη j).1) hmn hm
  have hstep (n : ℕ) (hmn : M ≤ n) :=
    well_branch_variance (hn n) (hη n).1 (hη n).2 (hw n hmn)
  have hrho : 0 ≤ 2 * c / (1 + 2 * c) := by positivity
  have hbase : (precision κ c r₀ η (M + 1))⁻¹ ≤ 2 * c :=
    (hstep M le_rfl).2.1
  constructor
  · apply inv_pos.mpr
    simpa only [Nat.add_assoc, Nat.add_comm 1 N] using hp (M + N)
  · induction N with
    | zero => simpa using hbase
    | succ N ih =>
      have hs := (hstep (M + 1 + N) (by omega)).2.2
        (by simpa only [Nat.add_assoc, Nat.add_comm 1 N] using hp (M + N))
      change (precision κ c r₀ η ((M + 1 + N) + 1))⁻¹ ≤
        (2 * c / (1 + 2 * c)) * (precision κ c r₀ η (M + 1 + N))⁻¹ at hs
      calc
        (precision κ c r₀ η (M + 1 + (N + 1)))⁻¹
            ≤ (2 * c / (1 + 2 * c)) * (precision κ c r₀ η (M + 1 + N))⁻¹ :=
          by simpa only [Nat.add_assoc] using hs
        _ ≤ (2 * c / (1 + 2 * c)) * (2 * c * (2 * c / (1 + 2 * c)) ^ N) :=
          mul_le_mul_of_nonneg_left ih hrho
        _ = 2 * c * (2 * c / (1 + 2 * c)) ^ (N + 1) := by rw [pow_succ]; ring

theorem exists_terminal {κ c r₀ B : ℝ} {η : ℕ → ℝ}
    (hκ : 1 ≤ κ) (hc : 0 < c) (hc_upper : c < 1 / 4) (hr₀ : 0 ≤ r₀)
    (hη : ∀ n, 0 < η n ∧ η n ≤ c) (hB : 0 < B) :
    ∃ J : ℕ, 0 < J ∧ 0 < (precision κ c r₀ η J)⁻¹ ∧
      (precision κ c r₀ η J)⁻¹ ≤ B := by
  have hK : 0 < condition κ r₀ := lt_of_lt_of_le zero_lt_one (condition_bounds hκ hr₀)
  obtain ⟨M, hM⟩ := exists_pow_lt_of_lt_one (div_pos (by norm_num : (0 : ℝ) < 2) hK)
    (by norm_num : (4 / 5 : ℝ) < 1)
  have hM' : (4 / 5 : ℝ) ^ M * condition κ r₀ < 2 := (lt_div_iff₀ hK).mp hM
  have htwo : 0 < 2 * c := by positivity
  have hrho : 2 * c / (1 + 2 * c) < 1 :=
    (div_lt_one (by positivity)).2 (by linarith)
  obtain ⟨N, hN⟩ := exists_pow_lt_of_lt_one (div_pos hB htwo) hrho
  have hN' : 2 * c * (2 * c / (1 + 2 * c)) ^ N < B := by
    simpa only [mul_comm] using (lt_div_iff₀ htwo).mp hN
  have hf := finite_depth hκ hc hc_upper hr₀ hη M N hM'
  exact ⟨M + 1 + N, by omega, hf.1, hf.2.trans hN'.le⟩

end AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RecursiveDepth
