import AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.SemigroupDecay

namespace AutoSamplingTheory.Tests.SemigroupDecay

open Set

open AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.SemigroupDecay

noncomputable section

/-- The identically zero curve exercises every interface without adding an
analytic assumption hidden inside the tests. -/
def zeroDissipationCurve (scale : ℝ) : DissipationCurve scale where
  energy := fun _ => 0
  dissipation := fun _ => 0
  energy_continuous := continuous_const
  energy_hasDerivWithinAt := by
    intro t
    simpa using
      (hasDerivWithinAt_const
        (x := t) (s := Ici t) (c := (0 : ℝ)))

example {rate s t : ℝ} (hst : s ≤ t) :
    (zeroDissipationCurve 3).energy t ≤
      (zeroDissipationCurve 3).energy s *
        Real.exp (-rate * (t - s)) := by
  apply exponential_decay_of_scaled_dissipation_from
    (curve := zeroDissipationCurve 3) (rate := rate)
  · intro u
    simp [zeroDissipationCurve]
  · exact hst

example {rate t : ℝ} (ht : 0 ≤ t) :
    (zeroDissipationCurve 3).energy t ≤
      (zeroDissipationCurve 3).energy 0 * Real.exp (-rate * t) := by
  apply exponential_decay_of_scaled_dissipation
    (curve := zeroDissipationCurve 3) (rate := rate)
  · intro s
    simp [zeroDissipationCurve]
  · exact ht

example {scale rate : ℝ} :
    ∀ s : ℝ,
      rate * (zeroDissipationCurve scale).energy s ≤
        scale * (zeroDissipationCurve scale).dissipation s := by
  apply scaled_dissipation_of_exponential_decay
    (curve := zeroDissipationCurve scale) (rate := rate)
  intro s t ht
  simp [zeroDissipationCurve]

example {C t : ℝ} (hC : 0 < C) (ht : 0 ≤ t) :
    (zeroDissipationCurve 2).energy t ≤
      (zeroDissipationCurve 2).energy 0 * Real.exp (-(2 / C) * t) := by
  apply chewi_theorem_1_2_21_forward hC (zeroDissipationCurve 2)
  · intro s
    simp [zeroDissipationCurve]
  · exact ht

example {C : ℝ} (hC : 0 < C) :
    (∀ s : ℝ,
      (zeroDissipationCurve 2).energy s ≤
        C * (zeroDissipationCurve 2).dissipation s) ↔
    (∀ s t : ℝ, 0 ≤ t →
      (zeroDissipationCurve 2).energy (s + t) ≤
        (zeroDissipationCurve 2).energy s *
          Real.exp (-(2 / C) * t)) :=
  chewi_theorem_1_2_21_scalar_equivalence
    hC (zeroDissipationCurve 2)

example {C : ℝ} (hC : 0 < C) :
    (∀ s : ℝ,
      (zeroDissipationCurve 2).energy s ≤
        C * (zeroDissipationCurve 2).dissipation s) ↔
    (∀ s t : ℝ, 0 ≤ t →
      (zeroDissipationCurve 2).energy (s + t) ≤
        (zeroDissipationCurve 2).energy s *
          Real.exp (-(2 / C) * t)) :=
  chewi_theorem_1_2_22_scalar_equivalence
    hC (zeroDissipationCurve 2)

example {C t : ℝ} (hC : 0 < C) (ht : 0 ≤ t) :
    (zeroDissipationCurve 1).energy t ≤
      (zeroDissipationCurve 1).energy 0 * Real.exp (-(2 / C) * t) := by
  apply chewi_theorem_1_2_26_forward hC (zeroDissipationCurve 1)
  · intro s
    simp [zeroDissipationCurve]
  · exact ht

example {C : ℝ} (hC : 0 < C) :
    (∀ s : ℝ,
      (zeroDissipationCurve 1).energy s ≤
        (C / 2) * (zeroDissipationCurve 1).dissipation s) ↔
    (∀ s t : ℝ, 0 ≤ t →
      (zeroDissipationCurve 1).energy (s + t) ≤
        (zeroDissipationCurve 1).energy s *
          Real.exp (-(2 / C) * t)) :=
  chewi_theorem_1_2_26_scalar_equivalence
    hC (zeroDissipationCurve 1)

end

end AutoSamplingTheory.Tests.SemigroupDecay
