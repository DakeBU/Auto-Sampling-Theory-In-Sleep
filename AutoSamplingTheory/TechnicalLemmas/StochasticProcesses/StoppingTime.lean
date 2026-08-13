import Mathlib.Probability.Process.Stopping

/-!
# Continuous-time stopping times

This file gives Chewi's Definition 1.1.11 an ASTIS-owned entry point while
retaining Mathlib's filtration and stopping-time APIs.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace StoppingTime

open MeasureTheory
open scoped NNReal

/-- Chewi Definition 1.1.11: at time `t`, the information in the filtration
decides whether the extended nonnegative stopping time has occurred. -/
def IsChewiStoppingTime
    {Ω : Type*} {m : MeasurableSpace Ω}
    (filtration : Filtration ℝ≥0 m) (τ : Ω → WithTop ℝ≥0) : Prop :=
  MeasureTheory.IsStoppingTime filtration τ

/-- Constant nonnegative times satisfy the source stopping-time definition. -/
theorem isChewiStoppingTime_const
    {Ω : Type*} {m : MeasurableSpace Ω}
    (filtration : Filtration ℝ≥0 m) (t : ℝ≥0) :
    IsChewiStoppingTime filtration (fun _ : Ω => (t : WithTop ℝ≥0)) :=
  MeasureTheory.isStoppingTime_const filtration t

end StoppingTime
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
