import Mathlib.Probability.Process.Stopping

/-!
# Continuous-time stopping times

This file gives Chewi's Definition 1.1.11 an ASTIS-owned entry point while
retaining Mathlib's filtration and stopping-time APIs.

For the localized Ito route we also record the two elementary stopping-time
algebra facts used repeatedly below: minima of stopping times are stopping
times, and hence truncation by a deterministic horizon preserves the stopping
time property.  These are thin source-facing wrappers around Mathlib and do
not assert any stochastic-integral stopping identity.
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

/-- The pointwise minimum of two Chewi stopping times is again a stopping
time.  This is the stopping-time algebra needed for repeated stopping. -/
theorem IsChewiStoppingTime.min
    {Ω : Type*} {m : MeasurableSpace Ω}
    {filtration : Filtration ℝ≥0 m} {τ σ : Ω → WithTop ℝ≥0}
    (hτ : IsChewiStoppingTime filtration τ)
    (hσ : IsChewiStoppingTime filtration σ) :
    IsChewiStoppingTime filtration (fun ω => min (τ ω) (σ ω)) := by
  exact MeasureTheory.IsStoppingTime.min hτ hσ

/-- Truncating a stopping time by a deterministic nonnegative horizon preserves
the stopping-time property. -/
theorem IsChewiStoppingTime.min_const
    {Ω : Type*} {m : MeasurableSpace Ω}
    {filtration : Filtration ℝ≥0 m} {τ : Ω → WithTop ℝ≥0}
    (hτ : IsChewiStoppingTime filtration τ) (T : ℝ≥0) :
    IsChewiStoppingTime filtration
      (fun ω => min (τ ω) (T : WithTop ℝ≥0)) :=
  hτ.min (isChewiStoppingTime_const filtration T)

end StoppingTime
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
