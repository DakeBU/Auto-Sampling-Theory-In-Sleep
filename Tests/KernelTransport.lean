import AutoSamplingTheory.TechnicalLemmas.Probability.KernelTransport
import AutoSamplingTheory.TechnicalLemmas.Probability.HeatBath
import AutoSamplingTheory.TechnicalLemmas.Probability.KernelMixture
import AutoSamplingTheory.TechnicalLemmas.Probability.KernelInvariance
import Mathlib.MeasureTheory.MeasurableSpace.Embedding

namespace AutoSamplingTheory.Tests.KernelTransport

open MeasureTheory ProbabilityTheory
open scoped NNReal
open AutoSamplingTheory.TechnicalLemmas.Probability

-- The reusable statement imposes no finiteness, Markov or topological contract.
example {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (e : α ≃ᵐ β) (κ : Kernel α α) (μ : Measure α) (hκ : κ.Invariant μ) :
    ((κ.comap e.symm e.symm.measurable).map e).Invariant (μ.map e) :=
  KernelTransport.invariant_map_comap e hκ

variable {n : ℕ} (X : Fin (n + 1) → Type*) [∀ j, MeasurableSpace (X j)]

-- Test-local abbreviations only: use Mathlib's actual dependent coordinate
-- split and swap. The public library adds no coordinate algorithm or wrapper.
private def coordinateSplit (i : Fin (n + 1)) :
    (∀ j, X j) ≃ᵐ ((∀ j, X (i.succAbove j)) × X i) :=
  (MeasurableEquiv.piFinSuccAbove X i).trans MeasurableEquiv.prodComm

-- Check which coordinate is resampled and which coordinates are retained.
example (i : Fin (n + 1)) (x : ∀ j, X j) :
    (coordinateSplit X i x).2 = x i := rfl

example (i : Fin (n + 1)) (x : ∀ j, X j) (j : Fin n) :
    (coordinateSplit X i x).1 j = x (i.succAbove j) := rfl

private noncomputable def coordinateUpdate (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ]
    (i : Fin (n + 1)) [StandardBorelSpace (X i)] [Nonempty (X i)] :
    Kernel (∀ j, X j) (∀ j, X j) :=
  ((HeatBath.heatBathSnd (μ.map (coordinateSplit X i))).comap
    (coordinateSplit X i) (coordinateSplit X i).measurable).map (coordinateSplit X i).symm

-- A genuine dependent finite-product coordinate update. Only the selected
-- coordinate is Standard Borel/nonempty; all retained coordinates are arbitrary.
private theorem coordinateUpdate_invariant (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ]
    (i : Fin (n + 1)) [StandardBorelSpace (X i)] [Nonempty (X i)] :
    (coordinateUpdate X μ i).Invariant μ := by
  unfold coordinateUpdate
  simpa only [MeasurableEquiv.symm_symm, MeasurableEquiv.map_symm_map] using
    KernelTransport.invariant_map_comap (coordinateSplit X i).symm
      (HeatBath.heatBathSnd_invariant (μ.map (coordinateSplit X i)))

private instance (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ]
    (i : Fin (n + 1)) [StandardBorelSpace (X i)] [Nonempty (X i)] :
    IsMarkovKernel (coordinateUpdate X μ i) := by
  unfold coordinateUpdate
  exact Kernel.IsMarkovKernel.map _ (coordinateSplit X i).symm.measurable

-- In particular, the transport direction is tested with a nontrivial middle
-- coordinate split, not only with the identity equivalence or a one-point space.
example (μ : Measure (Fin 3 → Bool)) [IsFiniteMeasure μ] :
    (coordinateUpdate (fun _ : Fin 3 => Bool) μ 1).Invariant μ :=
  coordinateUpdate_invariant _ μ 1

-- Updating all coordinates requires the resampling contract at every coordinate.
-- Weights are fixed, may vanish, and do not assert positive holding probability.
variable [∀ j, StandardBorelSpace (X j)] [∀ j, Nonempty (X j)]

example (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ] (w : Fin (n + 1) → ℝ≥0)
    (hsum : ∑ i, w i = 1) :
    IsMarkovKernel (KernelMixture.finiteMixture w (fun i => coordinateUpdate X μ i)) :=
  KernelMixture.finiteMixture_isMarkovKernel w (fun i => coordinateUpdate X μ i) hsum

-- Literal reuse joins transported heat-bath, fixed random scan and finite powers.
-- No reversibility, null-fiber support or mixing conclusion is inferred.
example (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ] (w : Fin (n + 1) → ℝ≥0)
    (hsum : ∑ i, w i = 1) (k : ℕ) :
    ((KernelMixture.finiteMixture w (fun i => coordinateUpdate X μ i)) ^ k).Invariant μ := by
  apply KernelInvariance.invariant_pow
  exact KernelMixture.finiteMixture_invariant w (fun i => coordinateUpdate X μ i) μ hsum
    (fun i => coordinateUpdate_invariant X μ i)

#print axioms AutoSamplingTheory.TechnicalLemmas.Probability.KernelTransport.invariant_map_comap

end AutoSamplingTheory.Tests.KernelTransport
