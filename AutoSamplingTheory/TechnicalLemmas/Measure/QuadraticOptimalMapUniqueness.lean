import AutoSamplingTheory.TechnicalLemmas.Measure.QuadraticOptimalMap
import AutoSamplingTheory.TechnicalLemmas.Measure.QuadraticOptimalUniqueness

/-!
# Almost-everywhere uniqueness of quadratic optimal maps

Once the quadratic optimal plan is unique, uniqueness of an optimal transport
map is a graph-law statement.  Two optimal maps induce two optimal graph
couplings; plan uniqueness identifies those joint laws, and equality of graph
laws identifies the maps almost everywhere under the common source marginal.

This is deliberately separate from optimizer existence.  It proves the
uniqueness clause of Brenier's theorem conditional only on the two maps already
being optimal.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace QuadraticOptimalMapUniqueness

open MeasureTheory
open QuadraticOptimalMap QuadraticOptimalUniqueness WassersteinSpace

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [CompleteSpace E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] [SecondCountableTopology E]

/-- Quadratic optimal transport maps are unique `mu`-almost everywhere when
the source is absolutely continuous and both marginals have finite second
moments. -/
theorem ae_eq_of_quadraticOptimalMap
    {T S : E → E} {mu nu : Measure E}
    [IsProbabilityMeasure mu]
    (hT : IsQuadraticOptimalMap T mu nu)
    (hS : IsQuadraticOptimalMap S mu nu)
    (hmuac : mu ≪ (volume : Measure E))
    (hmu : Integrable (fun x : E => ‖x‖ ^ 2) mu)
    (hnu : Integrable (fun y : E => ‖y‖ ^ 2) nu) :
    T =ᵐ[mu] S := by
  apply ae_eq_of_graphCoupling_eq hT.1 hS.1
  exact eq_of_quadraticOptimal hT.2.2 hS.2.2 hmuac hmu hnu

/-- `P₂,ac` source wrapper, without imposing absolute continuity on the target. -/
theorem ae_eq_of_quadraticOptimalMap_p2ac_source
    {T S : E → E} {mu nu : Measure E}
    (hmu : IsAbsolutelyContinuousFiniteSecondMoment mu)
    (hnu : Integrable (fun y : E => ‖y‖ ^ 2) nu)
    (hT : IsQuadraticOptimalMap T mu nu)
    (hS : IsQuadraticOptimalMap S mu nu) :
    T =ᵐ[mu] S := by
  letI : IsProbabilityMeasure mu := hmu.1
  exact ae_eq_of_quadraticOptimalMap hT hS hmu.2.1 hmu.2.2 hnu

end

end QuadraticOptimalMapUniqueness
end Measure
end TechnicalLemmas
end AutoSamplingTheory
