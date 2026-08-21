import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinTriangle

namespace AutoSamplingTheory.Tests.WassersteinTriangle

open MeasureTheory
open scoped ENNReal
open AutoSamplingTheory.TechnicalLemmas.Measure

#check WassersteinSpace.wassersteinDistance_le_sqrt_lintegral_of_isCoupling
#check WassersteinTriangleMarginals.isCoupling_map_pair13_of_pair12_pair23
#check WassersteinTriangle.wassersteinDistance_lt_add_of_lt

example {E : Type*} [NormedAddCommGroup E]
    [MeasurableSpace E] [BorelSpace E] [SecondCountableTopology E]
    [StandardBorelSpace E] [Nonempty E]
    (μ₁ μ₂ μ₃ : Measure E)
    [IsProbabilityMeasure μ₁] [IsProbabilityMeasure μ₂] [IsProbabilityMeasure μ₃]
    {r₁₂ r₂₃ : ℝ≥0∞}
    (hr₁₂ : WassersteinSpace.wassersteinDistance μ₁ μ₂ < r₁₂)
    (hr₂₃ : WassersteinSpace.wassersteinDistance μ₂ μ₃ < r₂₃) :
    WassersteinSpace.wassersteinDistance μ₁ μ₃ < r₁₂ + r₂₃ :=
  WassersteinTriangle.wassersteinDistance_lt_add_of_lt μ₁ μ₂ μ₃ hr₁₂ hr₂₃

end AutoSamplingTheory.Tests.WassersteinTriangle