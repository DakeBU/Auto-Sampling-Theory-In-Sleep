import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FellerGeneratorBridge

namespace AutoSamplingTheory.Tests.FellerGeneratorBridge

open MeasureTheory ProbabilityTheory
open scoped NNReal ProbabilityTheory BoundedContinuousFunction

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGenerator
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGeneratorDomain
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FellerSemigroup
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FellerGeneratorBridge

noncomputable section

#check fellerOperator_const
#check continuousLinearSemigroupOfFeller_op_const
#check hasRightGeneratorAt_const
#check const_mem_generatorDomainSubmodule

example {E : Type*} [TopologicalSpace E] [MeasurableSpace E] [BorelSpace E]
    {K : ℝ≥0 → Kernel E E} (hK : FellerTransitionKernelContract K)
    (t : ℝ≥0) (c : ℝ) :
    fellerOperator hK t (BoundedContinuousFunction.const E c) =
      BoundedContinuousFunction.const E c :=
  fellerOperator_const hK t c

example {E : Type*} [TopologicalSpace E] [MeasurableSpace E] [BorelSpace E]
    {K : ℝ≥0 → Kernel E E} (hK : FellerTransitionKernelContract K)
    (c : ℝ) :
    HasRightGeneratorAt (continuousLinearSemigroupOfFeller hK)
      (BoundedContinuousFunction.const E c) 0 :=
  hasRightGeneratorAt_const hK c

end

end AutoSamplingTheory.Tests.FellerGeneratorBridge
