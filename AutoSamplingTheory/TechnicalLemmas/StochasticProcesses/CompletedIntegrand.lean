import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CompletedEnergy

/-!
# Completion of locally square-integrable progressive integrands

The source local-`L2` condition only holds almost surely.  Under the usual
completeness condition, replacing the null set of bad sample paths by the zero
path preserves progressiveness and gives an everywhere time-integrable
representative whose prefix energy is the completed energy process.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace CompletedIntegrand

open MeasureTheory Set
open scoped NNReal

open ProgressiveL2 LocalProgressiveL2 EnergyPathContinuity CompletedEnergy
open TechnicalLemmas.Analysis.PrefixIntegral

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

/-- The original progressive integrand with every nonintegrable sample path
replaced by zero. -/
noncomputable def completedIntegrand
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (t : ℝ≥0) (omega : Omega) : ℝ :=
  if omega ∈ badEnergySet eta then 0 else eta.process t omega

/-- Completion preserves strong progressiveness. -/
theorem completedIntegrand_stronglyProgressive
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T) :
    IsStronglyProgressive filtration (completedIntegrand hUsual eta) := by
  intro terminal
  have hbad : @MeasurableSet (Set.Iic terminal × Omega)
      (Subtype.instMeasurableSpace.prod (filtration terminal))
      {p | p.2 ∈ badEnergySet eta} :=
    (measurableSet_badEnergySet hUsual eta terminal).preimage measurable_snd
  exact StronglyMeasurable.ite hbad stronglyMeasurable_const (eta.progressive terminal)

/-- Every completed sample path has an integrable square on the finite time
horizon. -/
theorem sectionSquare_integrable
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (omega : Omega) :
    Integrable (fun s => (completedIntegrand hUsual eta s omega) ^ 2)
      (TimeMeasure.upTo T) := by
  by_cases hbad : omega ∈ badEnergySet eta
  · simp [completedIntegrand, hbad]
  · have homega : Integrable (fun s => (eta.process s omega) ^ 2)
        (TimeMeasure.upTo T) := by
      simpa [badEnergySet] using hbad
    simpa [completedIntegrand, hbad] using homega

/-- Prefix energy of the completed integrand is exactly the completed energy
process. -/
theorem completedEnergy_eq_prefixIntegral
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (t : ℝ≥0) (omega : Omega) :
    completedEnergy hUsual eta t omega =
      prefixIntegral
        (fun s => (completedIntegrand hUsual eta s omega) ^ 2) T t := by
  by_cases hbad : omega ∈ badEnergySet eta
  · simp [completedEnergy, completedIntegrand, prefixIntegral, hbad]
  · simpa [completedEnergy, completedIntegrand, hbad] using
      (accumulatedEnergyReal_eq_prefixIntegral eta t omega).symm

/-- The completed energy process is strongly progressive. -/
theorem completedEnergy_stronglyProgressive
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T) :
    IsStronglyProgressive filtration (completedEnergy hUsual eta) := by
  have hadapted : StronglyAdapted filtration (completedEnergy hUsual eta) :=
    fun t => completedEnergy_stronglyMeasurable hUsual eta t
  exact hadapted.isStronglyProgressive_of_continuous
    (fun omega => continuous_completedEnergy hUsual eta omega)

end CompletedIntegrand
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
