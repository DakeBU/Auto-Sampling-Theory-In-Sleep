import AutoSamplingTheory.TechnicalLemmas.Measure.Transport
import Mathlib.Analysis.SpecialFunctions.Pow.NNReal
import Mathlib.MeasureTheory.Measure.Haar.InnerProductSpace
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Topology.Instances.ENNReal.Lemmas

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
open scoped ENNReal

/-- Squared Euclidean transport cost as an extended nonnegative function. -/
def quadraticCost
    {E : Type*} [NormedAddCommGroup E] : E × E → ℝ≥0∞ :=
  fun z => ENNReal.ofReal (‖z.1 - z.2‖ ^ 2)

/-- The quadratic cost is measurable on a second-countable Borel normed space.
The second-countability hypothesis is the honest regularity needed to identify
the Borel structure on the product with the product measurable structure used
by couplings. It is automatic in Chewi's finite-dimensional Euclidean setting. -/
theorem quadraticCost_measurable
    {E : Type*} [NormedAddCommGroup E] [MeasurableSpace E] [BorelSpace E]
    [SecondCountableTopology E] :
    Measurable (quadraticCost (E := E)) := by
  have hdist : Measurable (fun z : E × E => dist z.1 z.2) := measurable_dist
  have hsq : Measurable (fun z : E × E => (dist z.1 z.2) ^ (2 : ℕ)) :=
    hdist.pow_const 2
  simpa only [quadraticCost, dist_eq_norm] using hsq.ennreal_ofReal

/-- The quadratic transport cost vanishes on the diagonal. -/
@[simp]
theorem quadraticCost_diag
    {E : Type*} [NormedAddCommGroup E] (x : E) :
    quadraticCost (x, x) = 0 := by
  simp [quadraticCost]

/-- Chewi Definition 1.3.4: the 2-Wasserstein distance is the positive
square root of the quadratic Kantorovich transport cost. -/
noncomputable def wassersteinDistance
    {E : Type*} [NormedAddCommGroup E] [MeasurableSpace E]
    (μ ν : Measure E) : ℝ≥0∞ :=
  (Transport.transportCost (quadraticCost (E := E)) μ ν) ^ (1 / 2 : ℝ)

/-- Chewi display (1.3.5): the square of `W₂` is the infimum of the
quadratic costs over all couplings. -/
theorem wassersteinDistance_sq
    {E : Type*} [NormedAddCommGroup E] [MeasurableSpace E]
    (μ ν : Measure E) :
    wassersteinDistance μ ν ^ 2 =
      Transport.transportCost (quadraticCost (E := E)) μ ν := by
  rw [wassersteinDistance, ← ENNReal.rpow_two, ← ENNReal.rpow_mul]
  norm_num

/-- The diagonal coupling gives zero self-distance.  This is the reflexivity
piece of the eventual `W₂` metric structure and does not require existence of
an optimal coupling. -/
theorem wassersteinDistance_self
    {E : Type*} [NormedAddCommGroup E] [MeasurableSpace E] [BorelSpace E]
    [SecondCountableTopology E] (μ : Measure E) :
    wassersteinDistance μ μ = 0 := by
  rw [wassersteinDistance,
    Transport.transportCost_self_eq_zero_of_diagonal
      (quadraticCost (E := E)) quadraticCost_measurable quadraticCost_diag μ]
  exact ENNReal.zero_rpow_of_pos (by norm_num)

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
