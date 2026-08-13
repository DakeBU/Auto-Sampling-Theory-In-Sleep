import Mathlib.Analysis.ODE.Gronwall

/-!
# Functional inequalities imply semigroup decay

This file isolates the scalar analytic mechanism behind the forward directions
of Chewi's Theorems 1.2.21, 1.2.22, and 1.2.26.

A nonnegative-time energy curve is supplied together with its exact
right-derivative dissipation identity.  A coercive functional inequality then
turns the identity into a differential inequality, and Mathlib's one-sided
Grönwall theorem yields exponential decay.

The declarations here do not construct a concrete Markov semigroup, identify
its variance, chi-square divergence, KL divergence, or Fisher information, or
prove any converse implication.  Those interfaces remain explicit downstream
obligations.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace FunctionalInequalities
namespace SemigroupDecay

open Filter Set
open scoped Topology

noncomputable section

/-- A scalar energy/dissipation curve with an exact right-derivative identity.

`scale` records the coefficient in
`d/dt energy(t) = -scale * dissipation(t)`.  The derivative is taken within
`[t, ∞)`, so the contract is compatible with semigroups defined only at
nonnegative time increments. -/
structure DissipationCurve (scale : ℝ) where
  energy : ℝ → ℝ
  dissipation : ℝ → ℝ
  energy_continuous : Continuous energy
  energy_hasDerivWithinAt :
    ∀ t : ℝ,
      HasDerivWithinAt energy (-scale * dissipation t) (Ici t) t

/-- A coercive inequality along a dissipation curve implies exponential decay.

If

`rate * energy(t) ≤ scale * dissipation(t)`

and the energy derivative is `-scale * dissipation(t)`, then

`energy(t) ≤ energy(0) * exp(-rate * t)`

for every nonnegative time.  No sign assumption on the energy is needed for
this scalar Grönwall step. -/
theorem exponential_decay_of_scaled_dissipation
    {scale rate : ℝ} (curve : DissipationCurve scale)
    (hcoercive : ∀ s : ℝ,
      rate * curve.energy s ≤ scale * curve.dissipation s)
    {t : ℝ} (ht : 0 ≤ t) :
    curve.energy t ≤ curve.energy 0 * Real.exp (-rate * t) := by
  have hbound : ∀ x ∈ Ico (0 : ℝ) t,
      -scale * curve.dissipation x ≤
        (-rate) * curve.energy x + 0 := by
    intro x hx
    have hneg := neg_le_neg (hcoercive x)
    simpa [neg_mul] using hneg
  have hgronwall :=
    le_gronwallBound_of_liminf_deriv_right_le
      (f := curve.energy)
      (f' := fun x => -scale * curve.dissipation x)
      (δ := curve.energy 0)
      (K := -rate)
      (ε := 0)
      (a := 0)
      (b := t)
      curve.energy_continuous.continuousOn
      (fun x hx r hr => by
        simpa [slope] using
          (curve.energy_hasDerivWithinAt x).liminf_right_slope_le hr)
      le_rfl
      hbound
      t
      ⟨ht, le_rfl⟩
  rw [gronwallBound_ε0] at hgronwall
  simpa [sub_zero] using hgronwall

/-- Forward direction of Chewi, Theorem 1.2.21.

Under the variance dissipation identity `V'(t) = -2 E(t)`, a Poincaré-type
coercivity estimate `V(t) ≤ C E(t)` implies decay at rate `2 / C`. -/
theorem chewi_theorem_1_2_21_forward
    {C : ℝ} (hC : 0 < C) (curve : DissipationCurve 2)
    (hPI : ∀ s : ℝ,
      curve.energy s ≤ C * curve.dissipation s)
    {t : ℝ} (ht : 0 ≤ t) :
    curve.energy t ≤
      curve.energy 0 * Real.exp (-(2 / C) * t) := by
  apply exponential_decay_of_scaled_dissipation
    (curve := curve) (rate := 2 / C) ?_ ht
  intro s
  have hfactor : 0 ≤ (2 : ℝ) / C := by positivity
  calc
    (2 / C) * curve.energy s ≤
        (2 / C) * (C * curve.dissipation s) :=
      mul_le_mul_of_nonneg_left (hPI s) hfactor
    _ = 2 * curve.dissipation s := by
      field_simp [hC.ne']

/-- Forward direction of Chewi, Theorem 1.2.22.

The same scalar mechanism gives chi-square decay once the concrete semigroup
supplies the derivative identity and the Poincaré coercivity estimate. -/
theorem chewi_theorem_1_2_22_forward
    {C : ℝ} (hC : 0 < C) (curve : DissipationCurve 2)
    (hPI : ∀ s : ℝ,
      curve.energy s ≤ C * curve.dissipation s)
    {t : ℝ} (ht : 0 ≤ t) :
    curve.energy t ≤
      curve.energy 0 * Real.exp (-(2 / C) * t) :=
  chewi_theorem_1_2_21_forward hC curve hPI ht

/-- Forward direction of Chewi, Theorem 1.2.26.

Under the entropy dissipation identity `KL'(t) = -FI(t)`, an LSI written as
`KL(t) ≤ (C / 2) FI(t)` implies KL decay at rate `2 / C`. -/
theorem chewi_theorem_1_2_26_forward
    {C : ℝ} (hC : 0 < C) (curve : DissipationCurve 1)
    (hLSI : ∀ s : ℝ,
      curve.energy s ≤ (C / 2) * curve.dissipation s)
    {t : ℝ} (ht : 0 ≤ t) :
    curve.energy t ≤
      curve.energy 0 * Real.exp (-(2 / C) * t) := by
  apply exponential_decay_of_scaled_dissipation
    (curve := curve) (rate := 2 / C) ?_ ht
  intro s
  have hfactor : 0 ≤ (2 : ℝ) / C := by positivity
  calc
    (2 / C) * curve.energy s ≤
        (2 / C) * ((C / 2) * curve.dissipation s) :=
      mul_le_mul_of_nonneg_left (hLSI s) hfactor
    _ = 1 * curve.dissipation s := by
      field_simp [hC.ne']

end

end SemigroupDecay
end FunctionalInequalities
end TechnicalLemmas
end AutoSamplingTheory
