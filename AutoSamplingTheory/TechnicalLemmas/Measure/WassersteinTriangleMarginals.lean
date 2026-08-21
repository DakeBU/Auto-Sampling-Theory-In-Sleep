import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace
import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinTriangleCore
import Mathlib.MeasureTheory.Integral.Lebesgue.Map
import Mathlib.Tactic

/-!
# Pair-marginal transport costs of a triple joint law

The gluing argument for the Wasserstein triangle inequality produces one law
of a triple `(X,Y,Z)`.  `WassersteinTriangleCore` controls the three edge
lengths in the `L²` seminorm of that triple law.  To pass from this joint-law
Minkowski inequality back to transport plans, we must identify each edge
seminorm with the square root of the quadratic transport cost of the
corresponding pair marginal.

This file proves exactly that representation bridge.  It contains no
near-optimal coupling selection and does not yet claim the Wasserstein triangle
inequality.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace WassersteinTriangleMarginals

open MeasureTheory
open scoped ENNReal

noncomputable section

open WassersteinTriangleCore

variable {E : Type*} [NormedAddCommGroup E]
  [MeasurableSpace E] [BorelSpace E] [SecondCountableTopology E]

/-- The `(x,y)` projection from triples encoded as `((x,y),z)`. -/
def pair12 : ((E × E) × E) → E × E := fun p => p.1

/-- The `(y,z)` projection from triples encoded as `((x,y),z)`. -/
def pair23 : ((E × E) × E) → E × E := fun p => (p.1.2, p.2)

/-- The `(x,z)` projection from triples encoded as `((x,y),z)`. -/
def pair13 : ((E × E) × E) → E × E := fun p => (p.1.1, p.2)

@[fun_prop]
theorem measurable_pair12 : Measurable (pair12 (E := E)) := by
  exact measurable_fst

@[fun_prop]
theorem measurable_pair23 : Measurable (pair23 (E := E)) := by
  exact (measurable_snd.comp measurable_fst).prodMk measurable_snd

@[fun_prop]
theorem measurable_pair13 : Measurable (pair13 (E := E)) := by
  exact (measurable_fst.comp measurable_fst).prodMk measurable_snd

@[fun_prop]
theorem measurable_quadraticCost :
    Measurable (WassersteinSpace.quadraticCost (E := E)) := by
  unfold WassersteinSpace.quadraticCost
  fun_prop

/-- Squaring the first ENNReal edge length gives the quadratic cost of the
`(x,y)` pair. -/
theorem edgeLength12_rpow_two_eq_quadraticCost_pair12
    (p : ((E × E) × E)) :
    edgeLength12 (E := E) p ^ (2 : ℝ) =
      WassersteinSpace.quadraticCost (E := E) (pair12 p) := by
  rw [ENNReal.rpow_two]
  simp [edgeLength12, WassersteinSpace.quadraticCost, pair12,
    ENNReal.ofReal_pow, norm_nonneg]

/-- Squaring the second edge length gives the quadratic cost of `(y,z)`. -/
theorem edgeLength23_rpow_two_eq_quadraticCost_pair23
    (p : ((E × E) × E)) :
    edgeLength23 (E := E) p ^ (2 : ℝ) =
      WassersteinSpace.quadraticCost (E := E) (pair23 p) := by
  rw [ENNReal.rpow_two]
  simp [edgeLength23, WassersteinSpace.quadraticCost, pair23,
    ENNReal.ofReal_pow, norm_nonneg]

/-- Squaring the endpoint edge length gives the quadratic cost of `(x,z)`. -/
theorem edgeLength13_rpow_two_eq_quadraticCost_pair13
    (p : ((E × E) × E)) :
    edgeLength13 (E := E) p ^ (2 : ℝ) =
      WassersteinSpace.quadraticCost (E := E) (pair13 p) := by
  rw [ENNReal.rpow_two]
  simp [edgeLength13, WassersteinSpace.quadraticCost, pair13,
    ENNReal.ofReal_pow, norm_nonneg]

/-- The first-edge `L²` seminorm is the square root of the quadratic cost of
its pair marginal. -/
theorem l2Seminorm_edge12_eq_pairCost
    (gamma : Measure ((E × E) × E)) :
    l2Seminorm gamma (edgeLength12 (E := E)) =
      (∫⁻ z, WassersteinSpace.quadraticCost (E := E) z
        ∂Measure.map (pair12 (E := E)) gamma) ^ (1 / (2 : ℝ)) := by
  unfold l2Seminorm
  rw [lintegral_map measurable_quadraticCost measurable_pair12]
  congr 1
  apply lintegral_congr
  intro p
  exact edgeLength12_rpow_two_eq_quadraticCost_pair12 p

/-- The second-edge `L²` seminorm is the square root of the `(y,z)` pair cost. -/
theorem l2Seminorm_edge23_eq_pairCost
    (gamma : Measure ((E × E) × E)) :
    l2Seminorm gamma (edgeLength23 (E := E)) =
      (∫⁻ z, WassersteinSpace.quadraticCost (E := E) z
        ∂Measure.map (pair23 (E := E)) gamma) ^ (1 / (2 : ℝ)) := by
  unfold l2Seminorm
  rw [lintegral_map measurable_quadraticCost measurable_pair23]
  congr 1
  apply lintegral_congr
  intro p
  exact edgeLength23_rpow_two_eq_quadraticCost_pair23 p

/-- The endpoint-edge `L²` seminorm is the square root of the `(x,z)` pair
marginal cost. -/
theorem l2Seminorm_edge13_eq_pairCost
    (gamma : Measure ((E × E) × E)) :
    l2Seminorm gamma (edgeLength13 (E := E)) =
      (∫⁻ z, WassersteinSpace.quadraticCost (E := E) z
        ∂Measure.map (pair13 (E := E)) gamma) ^ (1 / (2 : ℝ)) := by
  unfold l2Seminorm
  rw [lintegral_map measurable_quadraticCost measurable_pair13]
  congr 1
  apply lintegral_congr
  intro p
  exact edgeLength13_rpow_two_eq_quadraticCost_pair13 p

end

end WassersteinTriangleMarginals
end Measure
end TechnicalLemmas
end AutoSamplingTheory
