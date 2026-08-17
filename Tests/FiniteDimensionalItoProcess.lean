import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FiniteDimensionalItoProcess

namespace AutoSamplingTheory
namespace Tests
namespace FiniteDimensionalItoProcess

open MeasureTheory
open scoped BigOperators NNReal

open TechnicalLemmas.StochasticProcesses
open TechnicalLemmas.StochasticProcesses.BrownianMotion
open TechnicalLemmas.StochasticProcesses.FiniteDimensionalItoProcess
open TechnicalLemmas.StochasticProcesses.GlobalItoProcessGluing
open TechnicalLemmas.StochasticProcesses.GlobalLocalProgressiveL2

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}

/-- Focused application of the finite-coordinate display.  This test is
separate from source completion for Chewi Definition 1.1.17: the vector
Brownian projection bridge and Hilbert--Schmidt norm bridge remain explicit
next dependencies. -/
example {iota kappa : Type*} [Fintype kappa]
    [IsProbabilityMeasure mu]
    (hUsual : TechnicalLemmas.StochasticProcesses.ProgressiveL2.SatisfiesUsualConditions filtration mu)
    (data : CoordinateItoData (filtration := filtration) (mu := mu) iota kappa)
    (brownian : CoordinateBrownianFamilyWithFiltration
      (filtration := filtration) (mu := mu) kappa)
    (t : ℝ≥0) (omega : Omega) (i : iota) :
    coordinateItoProcess hUsual data brownian t omega i =
      data.initial omega i +
        (∫ s, data.drift i s omega ∂(TimeMeasure.upTo t)) +
        ∑ j,
          globalItoProcess hUsual (data.diffusion i j)
            (brownian.isBrownian j) t omega := by
  exact chewi_definition_1_1_17_coordinate_display
    hUsual data brownian t omega i

#check ChewiItoData
#check ChewiBrownianCoordinates

end FiniteDimensionalItoProcess
end Tests
end AutoSamplingTheory
