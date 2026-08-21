import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSymmetry

namespace AutoSamplingTheory.Tests.WassersteinSymmetry

open MeasureTheory
open scoped ENNReal
open AutoSamplingTheory.TechnicalLemmas.Measure

#check WassersteinSymmetry.isCoupling_map_swapPair
#check WassersteinSymmetry.lintegral_quadraticCost_map_swapPair
#check WassersteinSymmetry.wassersteinDistance_le_reverse
#check WassersteinSymmetry.wassersteinDistance_comm

example {E : Type*} [NormedAddCommGroup E]
    [MeasurableSpace E] [BorelSpace E] [SecondCountableTopology E]
    (μ ν : Measure E) :
    WassersteinSpace.wassersteinDistance μ ν =
      WassersteinSpace.wassersteinDistance ν μ :=
  WassersteinSymmetry.wassersteinDistance_comm μ ν

end AutoSamplingTheory.Tests.WassersteinSymmetry