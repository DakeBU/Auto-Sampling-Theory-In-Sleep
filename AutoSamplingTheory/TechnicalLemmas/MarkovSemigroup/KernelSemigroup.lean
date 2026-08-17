import Mathlib.Probability.Kernel.Composition.Comp

/-!
# Continuous-time Markov-kernel semigroup foundations

This file is the process-independent kernel layer for Chewi, Section 1.2.1.
It deliberately does **not** construct transition kernels from conditional
laws of a stochastic process and does not construct the Langevin diffusion.
Those source-facing bridges may depend on the Chapter 1.1 stochastic-process
API and are downstream obligations.

The purpose of this layer is to make the Chapman--Kolmogorov/semigroup algebra
available now, without duplicating any unfinished Chapter 1.1 lemma.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace MarkovSemigroup

open MeasureTheory
open ProbabilityTheory
open scoped ENNReal ProbabilityTheory

noncomputable section

/-- A continuous-time semigroup of Markov transition kernels, indexed by
nonnegative real time.

This is the kernel-level mathematical content underlying Chewi Definition
1.2.1 and Lemma 1.2.2.  The source formula
`P_t f(x) = E[f(X_t) | X_0 = x]` is a later bridge from an actual process to
this structure, not part of the structure itself. -/
structure KernelSemigroup (E : Type*) [MeasurableSpace E] where
  /-- Transition kernel at elapsed time `t`. -/
  kernel : ℝ≥0 → Kernel E E
  /-- Every transition kernel is probability preserving. -/
  isMarkovKernel : ∀ t : ℝ≥0, IsMarkovKernel (kernel t)
  /-- At zero elapsed time the state is unchanged. -/
  kernel_zero : kernel 0 = Kernel.id
  /-- Chapman--Kolmogorov composition law. -/
  kernel_add : ∀ s t : ℝ≥0, kernel (s + t) = kernel t ∘ₖ kernel s

namespace KernelSemigroup

variable {E : Type*} [MeasurableSpace E] (P : KernelSemigroup E)

/-- Expose the probability-kernel certificate without globally installing an
instance that could interfere with downstream typeclass search. -/
theorem isMarkovKernel_at (t : ℝ≥0) : IsMarkovKernel (P.kernel t) :=
  P.isMarkovKernel t

@[simp]
theorem kernel_zero_eq_id : P.kernel 0 = Kernel.id :=
  P.kernel_zero

/-- Kernel composition over consecutive elapsed times. -/
theorem kernel_comp (s t : ℝ≥0) :
    P.kernel t ∘ₖ P.kernel s = P.kernel (s + t) :=
  (P.kernel_add s t).symm

/-- Transition kernels belonging to the same one-parameter semigroup commute.
This is a consequence of the additive time parameter, not an additional
assumption. -/
theorem kernel_comp_comm (s t : ℝ≥0) :
    P.kernel t ∘ₖ P.kernel s = P.kernel s ∘ₖ P.kernel t := by
  calc
    P.kernel t ∘ₖ P.kernel s = P.kernel (s + t) := P.kernel_comp s t
    _ = P.kernel (t + s) := by rw [add_comm]
    _ = P.kernel s ∘ₖ P.kernel t := (P.kernel_comp t s).symm

/-- Kernel-level form of Chewi Lemma 1.2.2.

The first conjunct is the zero-time identity.  The second records the
semigroup/Chapman--Kolmogorov law in both orders, matching the source's
`P_{s+t} = P_s P_t = P_t P_s` statement. -/
theorem chewi_lemma_1_2_2 (s t : ℝ≥0) :
    P.kernel 0 = Kernel.id ∧
      P.kernel t ∘ₖ P.kernel s = P.kernel s ∘ₖ P.kernel t ∧
      P.kernel t ∘ₖ P.kernel s = P.kernel (s + t) := by
  exact ⟨P.kernel_zero_eq_id, P.kernel_comp_comm s t, P.kernel_comp s t⟩

/-- The Markov operator associated to a transition kernel, first at the
nonnegative extended-real level where no integrability hypothesis is needed. -/
noncomputable def lintegralOperator
    (t : ℝ≥0) (f : E → ℝ≥0∞) (x : E) : ℝ≥0∞ :=
  ∫⁻ y, f y ∂P.kernel t x

/-- At time zero the kernel Markov operator is the identity on measurable
nonnegative observables. -/
@[simp]
theorem lintegralOperator_zero
    {f : E → ℝ≥0∞} (hf : Measurable f) (x : E) :
    P.lintegralOperator 0 f x = f x := by
  change (∫⁻ y, f y ∂P.kernel 0 x) = f x
  rw [P.kernel_zero_eq_id]
  exact Kernel.lintegral_id' hf x

/-- Operator-level Chapman--Kolmogorov identity for measurable nonnegative
observables.  This is the expectation-free version of `P_{s+t} = P_s P_t`;
the later process bridge only has to identify the transition kernels. -/
theorem lintegralOperator_add
    {f : E → ℝ≥0∞} (hf : Measurable f)
    (s t : ℝ≥0) (x : E) :
    P.lintegralOperator (s + t) f x =
      ∫⁻ y, P.lintegralOperator t f y ∂P.kernel s x := by
  change (∫⁻ z, f z ∂P.kernel (s + t) x) =
    ∫⁻ y, (∫⁻ z, f z ∂P.kernel t y) ∂P.kernel s x
  rw [P.kernel_add s t]
  exact Kernel.lintegral_comp (P.kernel t) (P.kernel s) x hf

end KernelSemigroup

end

end MarkovSemigroup
end TechnicalLemmas
end AutoSamplingTheory
