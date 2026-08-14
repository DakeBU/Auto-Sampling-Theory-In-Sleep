import Mathlib.MeasureTheory.Measure.Comap
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic
import Mathlib.MeasureTheory.Constructions.BorelSpace.Real

/-!
# Nonnegative continuous-time measure

Shared Lebesgue-measure root for stochastic integration and localization.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace TimeMeasure

open MeasureTheory Set
open scoped NNReal

/-- Lebesgue measure on nonnegative real time, pulled back along the canonical
embedding into the real line. -/
noncomputable def nnrealLebesgue : Measure ℝ≥0 :=
  Measure.comap ((↑) : ℝ≥0 → ℝ)
    (@MeasureSpace.volume ℝ inferInstance)

/-- Finite Lebesgue measure on nonnegative time up to `T`. Defining the
restriction before pulling back supplies Mathlib's finite-measure instance. -/
noncomputable def upTo (T : ℝ≥0) : Measure ℝ≥0 :=
  Measure.comap ((↑) : ℝ≥0 → ℝ)
    ((@MeasureSpace.volume ℝ inferInstance).restrict (Icc 0 (T : ℝ)))

noncomputable instance (T : ℝ≥0) : IsFiniteMeasure (upTo T) := by
  unfold upTo
  infer_instance

/-- The total mass of nonnegative time stopped at `T` is `T`. -/
theorem upTo_univ (T : ℝ≥0) : upTo T Set.univ = T := by
  have himage : NNReal.toReal '' (Set.univ : Set ℝ≥0) = Ici (0 : ℝ) := by
    ext r
    constructor
    · rintro ⟨s, _, rfl⟩
      exact s.property
    · intro hr
      exact ⟨⟨r, hr⟩, Set.mem_univ _, rfl⟩
  have hinter : Ici (0 : ℝ) ∩ Icc 0 (T : ℝ) = Icc 0 (T : ℝ) := by
    exact inter_eq_right.mpr fun r hr ↦ hr.1
  calc
    upTo T Set.univ =
        (volume.restrict (Icc 0 (T : ℝ)))
          (NNReal.toReal '' (Set.univ : Set ℝ≥0)) := by
      unfold upTo
      exact Measure.comap_apply NNReal.toReal NNReal.coe_injective
        (fun _ hs => (MeasurableEmbedding.subtype_coe
          (measurableSet_Ici : MeasurableSet (Ici (0 : ℝ)))).measurableSet_image' hs)
        _ MeasurableSet.univ
    _ = T := by
      rw [himage, Measure.restrict_apply measurableSet_Ici, hinter, Real.volume_Icc]
      simp

/-- The mass of `(a, b]` under time measure stopped at `T` is the length of
the clipped interval. -/
theorem upTo_Ioc (T a b : ℝ≥0) (hab : a ≤ b) :
    upTo T (Ioc a b) = ↑(min b T - min a T) := by
  calc
    upTo T (Ioc a b) =
        (volume.restrict (Icc 0 (T : ℝ))) (NNReal.toReal '' Ioc a b) := by
      unfold upTo
      exact Measure.comap_apply NNReal.toReal NNReal.coe_injective
        (fun _ hs => (MeasurableEmbedding.subtype_coe
          (measurableSet_Ici : MeasurableSet (Ici (0 : ℝ)))).measurableSet_image' hs)
        _ (measurableSet_Ioc : MeasurableSet (Ioc a b))
    _ = ↑(min b T - min a T) := by
      rw [NNReal.image_coe_Ioc, Measure.restrict_apply measurableSet_Ioc]
      have hinter :
          Ioc (a : ℝ) (b : ℝ) ∩ Icc 0 (T : ℝ) =
            Ioc ((min a T : ℝ≥0) : ℝ) ((min b T : ℝ≥0) : ℝ) := by
        ext x
        simp only [mem_inter_iff, mem_Ioc, mem_Icc, NNReal.coe_min,
          min_lt_iff, le_min_iff]
        constructor
        · rintro ⟨⟨hax, hxb⟩, hx0, hxT⟩
          exact ⟨Or.inl hax, hxb, hxT⟩
        · rintro ⟨hax | hTx, hxb, hxT⟩
          · exact ⟨⟨hax, hxb⟩, le_trans a.property hax.le, hxT⟩
          · exact (not_lt_of_ge hxT hTx).elim
      rw [hinter, Real.volume_Ioc]
      rw [← NNReal.coe_sub (min_le_min hab le_rfl)]
      simp

/-- Stopped nonnegative Lebesgue time lies in `(0,T]` almost everywhere;
the omitted initial endpoint is null. -/
theorem ae_mem_Ioc_zero_upTo (T : ℝ≥0) :
    ∀ᵐ t ∂upTo T, t ∈ Ioc 0 T := by
  apply (ae_mem_iff_measure_eq measurableSet_Ioc.nullMeasurableSet).2
  rw [upTo_Ioc T 0 T (by simp), upTo_univ]
  simp

/-- Restricting stopped time to `(0,T]` leaves the measure unchanged. -/
theorem restrict_upTo_Ioc_zero (T : ℝ≥0) :
    (upTo T).restrict (Ioc 0 T) = upTo T :=
  Measure.restrict_eq_self_of_ae_mem (ae_mem_Ioc_zero_upTo T)

end TimeMeasure
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
