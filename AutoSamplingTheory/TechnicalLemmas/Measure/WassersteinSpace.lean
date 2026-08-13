import Mathlib.MeasureTheory.Measure.Haar.InnerProductSpace
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# Measure classes for Wasserstein space

This module begins the measure-theoretic layer of Chewi's Wasserstein-space
development.  It isolates Definition 1.3.12 from optimal-plan existence,
metric-space structure, and Otto calculus.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace WassersteinSpace

open MeasureTheory

/-- Chewi Definition 1.3.12: a probability measure in `P₂,ac` has finite
second moment and is absolutely continuous with respect to Lebesgue volume.

The generic finite-dimensional real inner-product space specializes to
Euclidean `R^d` in the source. -/
def IsAbsolutelyContinuousFiniteSecondMoment
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    (μ : Measure E) : Prop :=
  IsProbabilityMeasure μ ∧
    μ ≪ (volume : Measure E) ∧
    Integrable (fun x : E => ‖x‖ ^ 2) μ

/-- Expansion of the three conditions in the `P₂,ac` definition. -/
theorem isAbsolutelyContinuousFiniteSecondMoment_iff
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    (μ : Measure E) :
    IsAbsolutelyContinuousFiniteSecondMoment μ ↔
      IsProbabilityMeasure μ ∧
        μ ≪ (volume : Measure E) ∧
        Integrable (fun x : E => ‖x‖ ^ 2) μ :=
  Iff.rfl

end WassersteinSpace
end Measure
end TechnicalLemmas
end AutoSamplingTheory
