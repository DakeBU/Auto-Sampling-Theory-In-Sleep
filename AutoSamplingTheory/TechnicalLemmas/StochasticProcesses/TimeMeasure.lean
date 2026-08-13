import Mathlib.MeasureTheory.Measure.Comap
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic

/-!
# Nonnegative continuous-time measure

Shared Lebesgue-measure root for stochastic integration and localization.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace TimeMeasure

open MeasureTheory Set
open scoped NNReal

/-- Lebesgue measure on nonnegative real time, pulled back along the canonical
embedding into the real line. -/
noncomputable def nnrealLebesgue : Measure ℝ≥0 :=
  Measure.comap ((↑) : ℝ≥0 → ℝ)
    (@MeasureSpace.volume ℝ inferInstance)

/-- Finite Lebesgue measure on nonnegative time up to `T`. Defining the
restriction before pulling back supplies Mathlib's finite-measure instance. -/
noncomputable def upTo (T : ℝ≥0) : Measure ℝ≥0 :=
  Measure.comap ((↑) : ℝ≥0 → ℝ)
    ((@MeasureSpace.volume ℝ inferInstance).restrict (Icc 0 (T : ℝ)))

noncomputable instance (T : ℝ≥0) : IsFiniteMeasure (upTo T) := by
  unfold upTo
  infer_instance

end TimeMeasure
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
