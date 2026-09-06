import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Convex.Strong

open Filter Set
open scoped Topology

namespace ReviewLibrary.TechnicalLemmas.Geometry.GeodesicConvexity

/-- A curve-wise first-order lower bound obtained from a quadratic chord inequality and
an exact derivative at the initial point. The theorem is deliberately phrased only in
terms of the chosen curve; it does not assert that the ambient space is a geodesic or
Riemannian space. -/
theorem firstOrder_geodesicConvexity
    {X : Type*} {f : X → ℝ} {γ : ℝ → X} {a b : X} {m d : ℝ}
    (hγ0 : γ 0 = a) (hγ1 : γ 1 = b)
    (hpath : ∀ t ∈ Set.Icc (0 : ℝ) 1, γ t ∈ Set.univ)
    (hchord : ∀ t ∈ Set.Icc (0 : ℝ) 1,
      f (γ t) ≤ (1 - t) * f a + t * f b - m / 2 * t * (1 - t) * d)
    (hderiv : HasDerivAt (fun t => f (γ t)) d 0) :
    f b ≥ f a + d + m / 2 * d := by
  have hzero : f (γ 0) = f a := by simpa [hγ0]
  have hone : f (γ 1) = f b := by simpa [hγ1]
  have hlim := hderiv.tendsto
  have hseq : ∀ n : ℕ, (0 : ℝ) < 1 / (n + 1 : ℝ) := by
    intro n
    positivity
  have hbound : ∀ n : ℕ,
      (f (γ (1 / (n + 1 : ℝ))) - f (γ 0)) / (1 / (n + 1 : ℝ)) ≤
        f b - f a - m / 2 * (1 - 1 / (n + 1 : ℝ)) * d := by
    intro n
    have ht0 : (0 : ℝ) ≤ 1 / (n + 1 : ℝ) := le_of_lt (hseq n)
    have ht1 : 1 / (n + 1 : ℝ) ≤ 1 := by
      have hn : (1 : ℝ) ≤ n + 1 := by exact_mod_cast Nat.succ_le_succ (Nat.zero_le n)
      exact one_div_le_one₀ (by positivity) hn
    have h := hchord (1 / (n + 1 : ℝ)) ⟨ht0, ht1⟩
    rw [hzero] at h
    have hpos := hseq n
    apply (div_le_iff₀ hpos).2
    nlinarith
  have hconv : Tendsto (fun n : ℕ => (1 / (n + 1 : ℝ))) atTop (𝓝 0) := by
    simpa using tendsto_one_div_add_atTop_nhds_zero_nat
  have hq : Tendsto (fun n : ℕ =>
      (f (γ (1 / (n + 1 : ℝ))) - f (γ 0)) / (1 / (n + 1 : ℝ))) atTop (𝓝 d) := by
    simpa [HasDerivAt, HasDerivAtFilter, HasDerivWithinAt, HasDerivWithinAtFilter] using
      hderiv.tendsto_slope_zero.comp hconv
  have hr : Tendsto (fun n : ℕ =>
      f b - f a - m / 2 * (1 - 1 / (n + 1 : ℝ)) * d) atTop
      (𝓝 (f b - f a - m / 2 * d)) := by
    convert (tendsto_const_nhds.sub
      ((tendsto_const_nhds.mul (tendsto_const_nhds.sub hconv)).mul tendsto_const_nhds)) using 1 <;>
      ring
  have hle := le_of_tendsto_of_tendsto hq hr hbound
  linarith

end ReviewLibrary.TechnicalLemmas.Geometry.GeodesicConvexity
