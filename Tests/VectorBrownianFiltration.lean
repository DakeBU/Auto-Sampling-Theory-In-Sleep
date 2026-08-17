import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.VectorBrownianFiltration

namespace AutoSamplingTheory
namespace Tests
namespace VectorBrownianFiltration

open MeasureTheory ProbabilityTheory
open scoped NNReal RealInnerProductSpace

open TechnicalLemmas.StochasticProcesses.BrownianMotion

example {Omega E : Type*} [MeasurableSpace Omega]
    [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    [MeasurableSpace E] [BorelSpace E]
    {B : ℝ≥0 → Omega → E} {mu : Measure Omega}
    (hB : IsStandardBrownianMotion B mu) :
    HasIndepIncrements B mu :=
  hB.hasIndepIncrements

example {Omega E : Type*} [MeasurableSpace Omega]
    [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    [MeasurableSpace E] [BorelSpace E]
    {B : ℝ≥0 → Omega → E} {mu : Measure Omega}
    (hB : IsStandardBrownianMotion B mu) (ell : StrongDual ℝ E) :
    HasIndepIncrements (fun t omega => ell (B t omega)) mu :=
  hB.projected_hasIndepIncrements ell

#check IsStandardBrownianMotionWithFiltration

end VectorBrownianFiltration
end Tests
end AutoSamplingTheory
