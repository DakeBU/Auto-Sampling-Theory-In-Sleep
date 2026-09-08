import AutoSamplingTheory.TechnicalLemmas.Probability.CoordinateHeatBath
import AutoSamplingTheory.TechnicalLemmas.Probability.KernelMixture
import AutoSamplingTheory.TechnicalLemmas.Probability.KernelInvariance

namespace AutoSamplingTheory.Tests.CoordinateHeatBath

open MeasureTheory ProbabilityTheory
open scoped NNReal
open AutoSamplingTheory.TechnicalLemmas.Probability

variable {n : ℕ} (X : Fin (n + 1) → Type*) [∀ j, MeasurableSpace (X j)]

-- Only the selected coordinate has the conditional-law hypotheses.
example (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ]
    (i : Fin (n + 1)) [StandardBorelSpace (X i)] [Nonempty (X i)] :
    IsMarkovKernel (CoordinateHeatBath.heatBath X μ i) := inferInstance

example (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ]
    (i : Fin (n + 1)) [StandardBorelSpace (X i)] [Nonempty (X i)] :
    (CoordinateHeatBath.heatBath X μ i).Invariant μ :=
  CoordinateHeatBath.heatBath_invariant X μ i

-- The retained marginal law needs no measurable-singleton assumption anywhere.
-- This test expands the one public construction, not a second algorithm.
private theorem retained_marginal (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ]
    (i : Fin (n + 1)) [StandardBorelSpace (X i)] [Nonempty (X i)] (x : ∀ j, X j) :
    (CoordinateHeatBath.heatBath X μ i x).map (fun y k => y (i.succAbove k)) =
      Measure.dirac (fun k => x (i.succAbove k)) := by
  let e := (MeasurableEquiv.piFinSuccAbove X i).trans MeasurableEquiv.prodComm
  have hcomp : (fun y k => y (i.succAbove k)) ∘ e.symm = Prod.fst := by
    funext p
    exact congrArg Prod.fst (e.apply_symm_apply p)
  change (((HeatBath.heatBathSnd (μ.map e)).comap e e.measurable).map e.symm x).map
    (fun y k => y (i.succAbove k)) = Measure.dirac (fun k => x (i.succAbove k))
  rw [Kernel.map_apply _ e.symm.measurable, Kernel.comap_apply, HeatBath.heatBathSnd_apply,
    Measure.map_map (measurable_pi_iff.2 fun k => measurable_pi_apply (i.succAbove k))
      e.symm.measurable, hcomp, Measure.map_fst_prod]
  simp only [measure_univ, one_smul]
  rfl

-- Literal equality requires singleton measurability only at this retained j.
example (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ]
    (i : Fin (n + 1)) [StandardBorelSpace (X i)] [Nonempty (X i)]
    (j : Fin (n + 1)) [MeasurableSingletonClass (X j)] (hji : j ≠ i) (x : ∀ j, X j) :
    ∀ᵐ y ∂CoordinateHeatBath.heatBath X μ i x, y j = x j :=
  CoordinateHeatBath.heatBath_ae_apply_eq X μ i j hji x

-- Simultaneous retention is a finite intersection consumer, not another API.
example (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ]
    (i : Fin (n + 1)) [StandardBorelSpace (X i)] [Nonempty (X i)]
    [∀ j, MeasurableSingletonClass (X j)] (x : ∀ j, X j) :
    ∀ᵐ y ∂CoordinateHeatBath.heatBath X μ i x, ∀ j, j ≠ i → y j = x j := by
  apply ae_all_iff.2
  intro j
  exact ae_all_iff.2 (fun hji => CoordinateHeatBath.heatBath_ae_apply_eq X μ i j hji x)

-- A genuine three-coordinate middle update: both other coordinates are retained.
example (μ : Measure (Fin 3 → Bool)) [IsFiniteMeasure μ] (x : Fin 3 → Bool) :
    ∀ᵐ y ∂CoordinateHeatBath.heatBath (fun _ : Fin 3 => Bool) μ 1 x,
      y 0 = x 0 ∧ y 2 = x 2 :=
  (CoordinateHeatBath.heatBath_ae_apply_eq _ μ 1 0 (by decide) x).and
    (CoordinateHeatBath.heatBath_ae_apply_eq _ μ 1 2 (by decide) x)

-- The same behavior holds at a concrete nonconstant input, even for zero target.
example : ∀ᵐ y ∂CoordinateHeatBath.heatBath (fun _ : Fin 3 => Bool) 0 1
    ![false, true, false], y 0 = false ∧ y 2 = false := by
  exact (CoordinateHeatBath.heatBath_ae_apply_eq _ 0 1 0 (by decide)
    ![false, true, false]).and
      (CoordinateHeatBath.heatBath_ae_apply_eq _ 0 1 2 (by decide) ![false, true, false])

example : (CoordinateHeatBath.heatBath (fun _ : Fin 3 => Bool) 0 1).Invariant 0 :=
  CoordinateHeatBath.heatBath_invariant _ 0 1

-- The first space has the indiscrete sigma-algebra on two distinct points;
-- the second space is ordinary Bool. No literal first-coordinate AE equality
-- is asserted here: its singleton measurability contract is unavailable.
private def coarseCoordinates : Fin 2 → Type := Fin.cases (Fin 2) (fun _ => Bool)

private instance (j : Fin 2) : MeasurableSpace (coarseCoordinates j) :=
  Fin.cases (⊥ : MeasurableSpace (Fin 2))
    (fun _ => inferInstanceAs (MeasurableSpace Bool)) j

private instance : StandardBorelSpace (coarseCoordinates 1) := by
  change StandardBorelSpace Bool
  infer_instance

private instance : Nonempty (coarseCoordinates 1) := by
  change Nonempty Bool
  infer_instance

example (μ : Measure (∀ j, coarseCoordinates j)) [IsFiniteMeasure μ] :
    (CoordinateHeatBath.heatBath coarseCoordinates μ 1).Invariant μ :=
  CoordinateHeatBath.heatBath_invariant coarseCoordinates μ 1

example (μ : Measure (∀ j, coarseCoordinates j)) [IsFiniteMeasure μ]
    (x : ∀ j, coarseCoordinates j) :
    (CoordinateHeatBath.heatBath coarseCoordinates μ 1 x).map
      (fun y k => y ((1 : Fin 2).succAbove k)) =
      Measure.dirac (fun k => x ((1 : Fin 2).succAbove k)) :=
  retained_marginal coarseCoordinates μ 1 x

-- Fixed random scan needs the resampling contract at every chosen coordinate.
variable [∀ j, StandardBorelSpace (X j)] [∀ j, Nonempty (X j)]

example (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ] (w : Fin (n + 1) → ℝ≥0)
    (hsum : ∑ i, w i = 1) :
    IsMarkovKernel (KernelMixture.finiteMixture w
      (fun i => CoordinateHeatBath.heatBath X μ i)) :=
  KernelMixture.finiteMixture_isMarkovKernel w
    (fun i => CoordinateHeatBath.heatBath X μ i) hsum

example (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ] (w : Fin (n + 1) → ℝ≥0)
    (hsum : ∑ i, w i = 1) (k : ℕ) :
    ((KernelMixture.finiteMixture w
      (fun i => CoordinateHeatBath.heatBath X μ i)) ^ k).Invariant μ := by
  apply KernelInvariance.invariant_pow
  exact KernelMixture.finiteMixture_invariant w (fun i => CoordinateHeatBath.heatBath X μ i)
    μ hsum (fun i => CoordinateHeatBath.heatBath_invariant X μ i)

#check CoordinateHeatBath.heatBath
#check CoordinateHeatBath.heatBath_isMarkovKernel
#check CoordinateHeatBath.heatBath_invariant
#check CoordinateHeatBath.heatBath_ae_apply_eq
#print axioms CoordinateHeatBath.heatBath
#print axioms CoordinateHeatBath.heatBath_isMarkovKernel
#print axioms CoordinateHeatBath.heatBath_invariant
#print axioms CoordinateHeatBath.heatBath_ae_apply_eq

end AutoSamplingTheory.Tests.CoordinateHeatBath
