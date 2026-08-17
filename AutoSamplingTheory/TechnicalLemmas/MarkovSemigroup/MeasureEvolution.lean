import AutoSamplingTheory.TechnicalLemmas.MarkovSemigroup.KernelSemigroup
import Mathlib.Probability.Kernel.Composition.MeasureComp

/-!
# Evolution of laws under a Markov-kernel semigroup

This module is still independent of any concrete stochastic process.  Given an
abstract `KernelSemigroup`, it records the induced evolution of measures and
the stationary-measure interface needed later in Chewi Section 1.2.1.

The theorem identifying this evolution with the law of a concrete Langevin
solution is intentionally downstream of the unfinished Section 1.1 SDE bridge.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace MarkovSemigroup

open MeasureTheory
open ProbabilityTheory
open scoped ENNReal ProbabilityTheory

noncomputable section

namespace KernelSemigroup

variable {E : Type*} [MeasurableSpace E] (P : KernelSemigroup E)

/-- Evolve a measure for elapsed time `t` by composing it with the transition
kernel `P_t`. -/
noncomputable def evolve (t : ℝ≥0) (mu : Measure E) : Measure E :=
  P.kernel t ∘ₘ mu

/-- Evolution over `s+t` agrees with first evolving for `s` and then for `t`.
This is the measure-level Chapman--Kolmogorov identity. -/
theorem evolve_add (mu : Measure E) (s t : ℝ≥0) :
    P.evolve (s + t) mu = P.evolve t (P.evolve s mu) := by
  change P.kernel (s + t) ∘ₘ mu =
    P.kernel t ∘ₘ (P.kernel s ∘ₘ mu)
  rw [P.kernel_add s t]
  exact (Measure.comp_assoc
    (μ := mu) (κ := P.kernel s) (η := P.kernel t)).symm

/-- Markov evolution preserves probability normalization. -/
theorem isProbabilityMeasure_evolve
    (mu : Measure E) [IsProbabilityMeasure mu] (t : ℝ≥0) :
    IsProbabilityMeasure (P.evolve t mu) := by
  letI : IsMarkovKernel (P.kernel t) := P.isMarkovKernel t
  dsimp [evolve]
  infer_instance

/-- A stationary measure is fixed by every elapsed-time transition kernel.
This is the measure-level part of the stationary-distribution notion used in
Chewi Proposition 1.2.7.  Generator/adjoint characterizations are separate
analytic theorems with explicit domain hypotheses. -/
def IsStationary (pi : Measure E) : Prop :=
  ∀ t : ℝ≥0, P.evolve t pi = pi

/-- Stationarity is exactly fixedness under each named evolution map. -/
theorem isStationary_iff (pi : Measure E) :
    P.IsStationary pi ↔ ∀ t : ℝ≥0, P.evolve t pi = pi :=
  Iff.rfl

/-- Once a law is stationary, evolving it for any additional time leaves it
unchanged. -/
theorem IsStationary.evolve_eq
    {pi : Measure E} (hpi : P.IsStationary pi) (t : ℝ≥0) :
    P.evolve t pi = pi :=
  hpi t

end KernelSemigroup

end

end MarkovSemigroup
end TechnicalLemmas
end AutoSamplingTheory
