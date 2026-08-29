import AutoSamplingTheory.TechnicalLemmas.Measure.QuadraticOptimalMap
import AutoSamplingTheory.TechnicalLemmas.Measure.QuadraticOptimalUniqueness

/-!
# Almost-everywhere uniqueness of quadratic optimal maps

Once the quadratic optimal plan is unique, uniqueness of an optimal transport
map is a graph-law statement. Two optimal maps induce two optimal graph
couplings; plan uniqueness identifies those joint laws, and equality of graph
laws identifies the maps almost everywhere under the common source marginal.

## Source boundary

This module is a reusable technical edge for the uniqueness part of Chewi,
*Log-Concave Sampling*, Theorem 1.3.8(4) (Brenier's theorem). It is **not** the
source theorem itself. The source theorem also asserts existence and uniqueness
of the optimal plan and identifies the optimal map as the `mu`-a.s. unique
gradient of a proper convex lower-semicontinuous potential pushing `mu` to
`nu`. Here we prove only the conditional implication

`two already-quadratic-optimal maps -> mu-a.e. equality`.

Accordingly this theorem-edge must not be labeled source-reviewed or an exact
formalization of Theorem 1.3.8(4). The later source-facing Brenier assembly must
carry the full source statement through the ASTIS semantic round-trip gate.
Only the source marginal is assumed absolutely continuous; no absolute
continuity assumption is imposed on the target.
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
