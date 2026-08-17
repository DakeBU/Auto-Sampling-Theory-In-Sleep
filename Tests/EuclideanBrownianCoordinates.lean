import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.EuclideanBrownianCoordinates

namespace AutoSamplingTheory
namespace Tests
namespace EuclideanBrownianCoordinates

open MeasureTheory ProbabilityTheory
open scoped NNReal RealInnerProductSpace Topology

open TechnicalLemmas.StochasticProcesses
open TechnicalLemmas.StochasticProcesses.BrownianMotion
open TechnicalLemmas.StochasticProcesses.EuclideanBrownianCoordinates
open TechnicalLemmas.StochasticProcesses.FiniteDimensionalItoProcess

variable {Omega kappa : Type*} [MeasurableSpace Omega]
  [Fintype kappa] [DecidableEq kappa]

example (j : kappa) (x : EuclideanSpace ℝ kappa) :
    coordinateDual j x = x j :=
  coordinateDual_apply j x

example (j : kappa) : ‖coordinateDual j‖ = 1 :=
  norm_coordinateDual j

example {B : ℝ≥0 → Omega → EuclideanSpace ℝ kappa} {mu : Measure Omega}
    (hB : IsStandardBrownianMotion B mu) (j : kappa) :
    IsBrownianReal (fun t omega => B t omega j) mu :=
  IsStandardBrownianMotion.coordinate_isBrownianReal hB j

variable {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → EuclideanSpace ℝ kappa}

example (hB : IsStandardBrownianMotionWithFiltration B filtration mu)
    (j : kappa) :
    IsBrownianMotionWithFiltration
      (fun t omega => B t omega j) filtration mu :=
  IsStandardBrownianMotionWithFiltration.coordinate hB j

noncomputable example (hB : IsStandardBrownianMotionWithFiltration B filtration mu) :
    CoordinateBrownianFamilyWithFiltration
      (Omega := Omega) (filtration := filtration) (mu := mu) kappa :=
  coordinateFamily hB

end EuclideanBrownianCoordinates
end Tests
end AutoSamplingTheory
