import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinTriangleExact

namespace AutoSamplingTheory.Tests.WassersteinTriangleExact

open MeasureTheory
open scoped ENNReal
open AutoSamplingTheory.TechnicalLemmas.Measure

#check WassersteinTriangleExact.wassersteinDistance_le_add_of_lt_left
#check WassersteinTriangleExact.wassersteinDistance_triangle

example {E : Type*} [NormedAddCommGroup E]
    [MeasurableSpace E] [BorelSpace E] [SecondCountableTopology E]
    [StandardBorelSpace E] [Nonempty E]
    (μ₁ μ₂ μ₃ : Measure E)
    [IsProbabilityMeasure μ₁] [IsProbabilityMeasure μ₂] [IsProbabilityMeasure μ₃] :
    WassersteinSpace.wassersteinDistance μ₁ μ₃ ≤
      WassersteinSpace.wassersteinDistance μ₁ μ₂ +
        WassersteinSpace.wassersteinDistance μ₂ μ₃ :=
  WassersteinTriangleExact.wassersteinDistance_triangle μ₁ μ₂ μ₃

end AutoSamplingTheory.Tests.WassersteinTriangleExact