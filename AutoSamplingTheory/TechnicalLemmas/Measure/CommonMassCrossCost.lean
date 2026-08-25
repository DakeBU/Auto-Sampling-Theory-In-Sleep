import AutoSamplingTheory.TechnicalLemmas.Measure.CommonMassNormalizedProduct
import AutoSamplingTheory.TechnicalLemmas.Measure.CommonMassProductMap
import AutoSamplingTheory.TechnicalLemmas.Measure.PermutedMarginalReplacement
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# Cross quadratic cost of an equal-mass replacement block

This module identifies the true finite-measure cost of a source-target
`commonMassProduct` block with the common mass times a normalized pair-pair
cross expectation.

The proof deliberately factors through the pair-pair common-mass product and
then pushes forward by `((x,y),(x',y')) ↦ (x,y')`.  This keeps normalization
away from marginal maps and uses only the already verified common-mass scaling
and pushforward naturality nodes.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace CommonMassCrossCost

open MeasureTheory
open CommonMass CommonMassNormalizedProduct CommonMassProductMap
open PermutedMarginalReplacement

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [MeasurableSpace E]

/-- The projection from two pair samples to the source of the first sample and
the target of the second sample. -/
def crossPairMap : (E × E) × (E × E) → E × E :=
  Prod.map Prod.fst Prod.snd

/-- A source-target common-mass replacement block has cost equal to the common
mass times the cross expectation under the product of the two normalized pair
laws. -/
theorem integral_commonMassProduct_source_target_eq_mass_mul_normalized_cross
    (rho eta : FiniteMeasure (E × E))
    (hmass : rho.mass = eta.mass) (hpos : 0 < rho.mass)
    (hquad : AEStronglyMeasurable (fun z : E × E => ‖z.1 - z.2‖ ^ 2)
      (commonMassProduct (sourceMarginal rho) (targetMarginal eta) : Measure (E × E))) :
    (∫ z : E × E, ‖z.1 - z.2‖ ^ 2
        ∂(commonMassProduct (sourceMarginal rho) (targetMarginal eta) : Measure (E × E))) =
      (rho.mass : ℝ) *
        ∫ w : (E × E) × (E × E), ‖w.1.1 - w.2.2‖ ^ 2
          ∂((rho.normalize : Measure (E × E)).prod
            (eta.normalize : Measure (E × E))) := by
  have hmap :
      (commonMassProduct rho eta).map (crossPairMap (E := E)) =
        commonMassProduct (sourceMarginal rho) (targetMarginal eta) := by
    simpa [crossPairMap, sourceMarginal, targetMarginal] using
      commonMassProduct_map_prodMap rho eta Prod.fst Prod.snd measurable_fst measurable_snd
  rw [← hmap] at hquad ⊢
  change
    (∫ z : E × E, ‖z.1 - z.2‖ ^ 2
      ∂Measure.map (crossPairMap (E := E))
        (commonMassProduct rho eta : Measure ((E × E) × (E × E)))) = _
  rw [integral_map]
  · rw [commonMassProduct_toMeasure_eq_mass_smul_normalized_prod rho eta hmass hpos,
      integral_smul_nnreal_measure]
    rfl
  · exact (measurable_fst.prodMap measurable_snd).aemeasurable
  · simpa [hmap] using hquad

end

end CommonMassCrossCost
end Measure
end TechnicalLemmas
end AutoSamplingTheory
