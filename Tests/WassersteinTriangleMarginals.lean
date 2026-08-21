import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinTriangleMarginals

namespace AutoSamplingTheory.Tests.WassersteinTriangleMarginals

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure
open WassersteinTriangleCore WassersteinTriangleMarginals

#check pair12
#check pair23
#check pair13
#check l2Seminorm_edge12_eq_pairCost
#check l2Seminorm_edge23_eq_pairCost
#check l2Seminorm_edge13_eq_pairCost

variable {E : Type*} [NormedAddCommGroup E]
  [MeasurableSpace E] [BorelSpace E] [SecondCountableTopology E]

example (gamma : Measure ((E × E) × E)) :
    l2Seminorm gamma (edgeLength13 (E := E)) =
      (∫⁻ z, WassersteinSpace.quadraticCost (E := E) z
        ∂Measure.map (pair13 (E := E)) gamma) ^ (1 / (2 : ℝ)) :=
  l2Seminorm_edge13_eq_pairCost gamma

end AutoSamplingTheory.Tests.WassersteinTriangleMarginals
