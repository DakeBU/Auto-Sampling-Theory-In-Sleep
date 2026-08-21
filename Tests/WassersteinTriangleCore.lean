import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinTriangleCore

namespace AutoSamplingTheory.Tests.WassersteinTriangleCore

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinTriangleCore

#check edgeLength13_le_add
#check l2Seminorm_mono
#check l2Seminorm_add_le
#check l2_edge_triangle

example {E : Type*} [NormedAddCommGroup E] (p : ((E × E) × E)) :
    edgeLength13 p ≤ edgeLength12 p + edgeLength23 p :=
  edgeLength13_le_add p

example {E : Type*} [NormedAddCommGroup E] [MeasurableSpace E] [BorelSpace E]
    [SecondCountableTopology E] (γ : Measure ((E × E) × E)) :
    l2Seminorm γ (edgeLength13 (E := E)) ≤
      l2Seminorm γ (edgeLength12 (E := E)) +
        l2Seminorm γ (edgeLength23 (E := E)) :=
  l2_edge_triangle γ

end AutoSamplingTheory.Tests.WassersteinTriangleCore
