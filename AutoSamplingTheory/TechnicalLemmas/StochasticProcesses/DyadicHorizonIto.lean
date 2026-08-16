import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicHorizonExtension

/-!
# Itô finite-sum invariance under dyadic horizon extension

The larger dyadic-horizon representation copies the old grid as a prefix and
adds only zero coefficients afterwards.  Therefore its terminal elementary
Itô integral is literally the same finite Brownian-increment sum.

This file isolates that exact finite algebra from the later completed-`L²`
cross-horizon argument.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace DyadicHorizonIto

open MeasureTheory
open scoped BigOperators NNReal

open BrownianMotion DyadicElementaryRefinement DyadicGlobalHorizon
  DyadicHorizonExtension ElementaryItoIntegral ProgressiveL2Density

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

/-- A finite sum over a larger `Fin M` reduces to a prefix `Fin N` if every
new tail term is zero and the prefix terms agree. -/
theorem fin_sum_eq_sum_prefix_of_tail_zero
    {N M : ℕ} (hNM : N ≤ M)
    (F : Fin M → ℝ) (G : Fin N → ℝ)
    (hprefix : ∀ i : Fin N, F (i.castLE hNM) = G i)
    (htail : ∀ j : Fin M, N ≤ j.val → F j = 0) :
    (∑ j, F j) = ∑ i, G i := by
  let R := M - N
  have hdecomp : N + R = M := by
    dsimp [R]
    exact Nat.add_sub_of_le hNM
  calc
    (∑ j : Fin M, F j) =
        ∑ j : Fin (N + R), F (j.cast hdecomp) := by
      symm
      exact Fin.sum_congr' F hdecomp
    _ = ∑ i : Fin N, F ((Fin.castAdd R i).cast hdecomp) := by
      apply Fin.sum_trunc
      intro j
      apply htail
      change N ≤ N + j.val
      omega
    _ = ∑ i : Fin N, G i := by
      apply Finset.sum_congr rfl
      intro i _
      have hidx : ((Fin.castAdd R i).cast hdecomp) = i.castLE hNM := by
        apply Fin.ext
        rfl
      rw [hidx, hprefix i]

/-- Every old grid endpoint lies below the old terminal horizon. -/
theorem old_time_le_horizon
    {a : ℕ}
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (i : Fin (2 ^ q.level + 1)) :
    q.process.times i ≤ dyadicHorizon a := by
  have hlast :
      q.process.times (Fin.last (2 ^ q.level)) = dyadicHorizon a := by
    rw [congrFun q.times_eq (Fin.last (2 ^ q.level))]
    exact regularDyadic_last_time _ _
  exact (q.process.times_strictMono.monotone (Fin.le_last i)).trans_eq hlast

/-- Left endpoint of an old cell is unchanged in the enlarged grid. -/
theorem extend_time_castSucc_eq
    {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (i : Fin (2 ^ q.level)) :
    (extendDyadicHorizon hab q).process.times
        (prefixIndex hab q i).castSucc =
      q.process.times i.castSucc := by
  rw [extendDyadicHorizon_times]
  simpa [prefixIndex] using (prefix_time_eq hab q i.castSucc).symm

/-- Right endpoint of an old cell is unchanged in the enlarged grid. -/
theorem extend_time_succ_eq
    {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (i : Fin (2 ^ q.level)) :
    (extendDyadicHorizon hab q).process.times
        (prefixIndex hab q i).succ =
      q.process.times i.succ := by
  rw [extendDyadicHorizon_times]
  simpa [prefixIndex] using (prefix_time_eq hab q i.succ).symm

/-- **Exact finite-sum cross-horizon identity.**  Extending a dyadic elementary
integrand from `2^a` to `2^b` by zero leaves its terminal Itô integral
unchanged for every sample point. -/
theorem extendDyadicHorizon_elementaryItoIntegral_eq
    {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (B : ℝ≥0 → Omega → ℝ) (omega : Omega) :
    elementaryItoIntegral (extendDyadicHorizon hab q).process B
        (dyadicHorizon b) omega =
      elementaryItoIntegral q.process B (dyadicHorizon a) omega := by
  let hNM := oldCellCount_le_extension hab q
  change
    (∑ j : Fin (2 ^ extensionLevel q b),
      (extendDyadicHorizon hab q).process.coeff j omega *
        (B (min ((extendDyadicHorizon hab q).process.times j.succ)
              (dyadicHorizon b)) omega -
          B (min ((extendDyadicHorizon hab q).process.times j.castSucc)
              (dyadicHorizon b)) omega)) =
    ∑ i : Fin (2 ^ q.level),
      q.process.coeff i omega *
        (B (min (q.process.times i.succ) (dyadicHorizon a)) omega -
          B (min (q.process.times i.castSucc) (dyadicHorizon a)) omega)
  apply fin_sum_eq_sum_prefix_of_tail_zero hNM
  · intro i
    have hcoeff :
        (extendDyadicHorizon hab q).process.coeff (i.castLE hNM) omega =
          q.process.coeff i omega := by
      have hp := extendDyadicHorizon_coeff_prefix hab q (i.castLE hNM)
        (by simpa using i.isLt) omega
      simpa using hp
    have hleft := extend_time_castSucc_eq hab q i
    have hright := extend_time_succ_eq hab q i
    have hleftOld := old_time_le_horizon q i.castSucc
    have hrightOld := old_time_le_horizon q i.succ
    have hleftBig := hleftOld.trans (dyadicHorizon_mono hab)
    have hrightBig := hrightOld.trans (dyadicHorizon_mono hab)
    rw [hcoeff]
    change
      q.process.coeff i omega *
          (B (min ((extendDyadicHorizon hab q).process.times
                    (prefixIndex hab q i).succ) (dyadicHorizon b)) omega -
            B (min ((extendDyadicHorizon hab q).process.times
                    (prefixIndex hab q i).castSucc) (dyadicHorizon b)) omega) = _
    rw [hright, hleft, min_eq_left hrightBig, min_eq_left hleftBig,
      min_eq_left hrightOld, min_eq_left hleftOld]
  · intro j hj
    rw [extendDyadicHorizon_coeff_tail hab q j hj omega]
    simp

/-- The same finite-sum identity in terminal `L²(mu)`. -/
theorem extendDyadicHorizon_terminalToLp_eq
    {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    terminalToLp (extendDyadicHorizon hab q) hB = terminalToLp q hB := by
  apply Lp.ext
  simp only [terminalToLp, ElementaryItoL2.elementaryItoTerminalToLp]
  filter_upwards [
    (ElementaryItoL2.elementaryItoIntegral_memLp_two
      (extendDyadicHorizon hab q).process hB (dyadicHorizon b)).coeFn_toLp,
    (ElementaryItoL2.elementaryItoIntegral_memLp_two
      q.process hB (dyadicHorizon a)).coeFn_toLp]
      with omega hext hold
  rw [hext, hold]
  exact extendDyadicHorizon_elementaryItoIntegral_eq hab q B omega

end DyadicHorizonIto
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
