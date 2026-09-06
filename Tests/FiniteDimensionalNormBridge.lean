import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FiniteDimensionalNormBridge
import Mathlib.Analysis.Normed.Operator.NNNorm

namespace AutoSamplingTheory
namespace Tests
namespace FiniteDimensionalNormBridge

open MeasureTheory
open scoped ENNReal NNReal

open TechnicalLemmas.StochasticProcesses.ElementaryItoIntegral
open TechnicalLemmas.StochasticProcesses.FiniteDimensionalNormBridge

example {ι κ : Type*} [Fintype ι] [Fintype κ]
    (sigma : ι → κ → ℝ) (i : ι) (j : κ) :
    (sigma i j) ^ 2 ≤ matrixSquareEnergy sigma :=
  entry_sq_le_matrixSquareEnergy sigma i j

example {Omega : Type*} [MeasurableSpace Omega]
    {ι κ : Type*} [Fintype ι] [Fintype κ]
    {sigma : ℝ≥0 → Omega → ι → κ → ℝ}
    {mu : Measure Omega} {T : ℝ≥0}
    (hSigma : MatrixLocallySquareIntegrableOn sigma mu T)
    (i : ι) (j : κ) :
    IsLocallySquareIntegrableOn (fun t omega => sigma t omega i j) mu T :=
  hSigma.entry i j

/-! Pin the exact operator-`NNNorm` API used by the source-facing coefficient bridge.
These declarations are provided by the repository's locked Mathlib v4.33.0 revision. -/
#check ContinuousLinearMap.le_opNNNorm
#check ContinuousLinearMap.opNNNorm_le_iff

#check matrixSquareEnergy_nonneg
#check norm_sq_matrixAsEuclidean

end FiniteDimensionalNormBridge
end Tests
end AutoSamplingTheory
