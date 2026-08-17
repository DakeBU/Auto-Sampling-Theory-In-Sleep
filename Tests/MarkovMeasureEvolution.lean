import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.MarkovMeasureEvolution

namespace AutoSamplingTheory.Tests.MarkovMeasureEvolution

open MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal ProbabilityTheory

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.MarkovSemigroup

noncomputable section

#check evolveMeasure
#check evolveMeasure_add
#check isProbabilityMeasure_evolveMeasure
#check IsStationary
#check isStationary_iff_kernel_invariant
#check isStationary_of_kernel_reversible
#check IsStationary.evolveMeasure_eq
#check IsStationary.after

example {E : Type*} [MeasurableSpace E]
    {K : ℝ≥0 → Kernel E E} (hK : TransitionKernelContract K)
    (mu : Measure E) (s t : ℝ≥0) :
    evolveMeasure hK (s + t) mu =
      evolveMeasure hK t (evolveMeasure hK s mu) :=
  evolveMeasure_add hK mu s t

example {E : Type*} [MeasurableSpace E]
    {K : ℝ≥0 → Kernel E E} (hK : TransitionKernelContract K)
    (pi : Measure E) :
    IsStationary hK pi ↔ ∀ t : ℝ≥0, Kernel.Invariant (K t) pi :=
  isStationary_iff_kernel_invariant hK pi

example {E : Type*} [MeasurableSpace E]
    {K : ℝ≥0 → Kernel E E} (hK : TransitionKernelContract K)
    (pi : Measure E)
    (hrev : ∀ t : ℝ≥0, Kernel.IsReversible (K t) pi) :
    IsStationary hK pi :=
  isStationary_of_kernel_reversible hK pi hrev

example {E : Type*} [MeasurableSpace E]
    {K : ℝ≥0 → Kernel E E} {hK : TransitionKernelContract K}
    {pi : Measure E} (hpi : IsStationary hK pi) (t : ℝ≥0) :
    evolveMeasure hK t pi = pi :=
  IsStationary.evolveMeasure_eq hpi t

example {E : Type*} [MeasurableSpace E]
    {K : ℝ≥0 → Kernel E E} {hK : TransitionKernelContract K}
    {pi : Measure E} (hpi : IsStationary hK pi) (s : ℝ≥0) :
    IsStationary hK (evolveMeasure hK s pi) :=
  IsStationary.after hpi s

end

end AutoSamplingTheory.Tests.MarkovMeasureEvolution
