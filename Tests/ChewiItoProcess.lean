import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ChewiItoProcess

namespace AutoSamplingTheory
namespace Tests
namespace ChewiItoProcess

open MeasureTheory
open TechnicalLemmas.StochasticProcesses
open TechnicalLemmas.StochasticProcesses.ChewiItoProcess

#check SourceData.initial_coordinate_stronglyMeasurable
#check SourceData.drift_coordinate_progressive
#check SourceData.drift_coordinate_integrable
#check SourceData.diffusion_entry_progressive
#check SourceData.toCoordinateItoData
#check process
#check definition_1_1_17_coordinate_display
#check ChewiSourceData

/-! Regression guard: the public source layer takes one Euclidean Brownian
motion; it is not parameterized by an arbitrary scalar Brownian family. -/
example {Omega : Type*} [MeasurableSpace Omega]
    {iota kappa : Type*} [Fintype iota] [DecidableEq iota]
    [Fintype kappa] [DecidableEq kappa]
    {m : MeasurableSpace Omega}
    {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
    [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (data : SourceData (Omega := Omega) (filtration := filtration) (mu := mu)
      iota kappa)
    {B : ℝ≥0 → Omega → EuclideanSpace ℝ kappa}
    (hB : TechnicalLemmas.StochasticProcesses.BrownianMotion.IsStandardBrownianMotionWithFiltration
      B filtration mu) :
    ℝ≥0 → Omega → EuclideanSpace ℝ iota :=
  process hUsual data hB

end ChewiItoProcess
end Tests
end AutoSamplingTheory
