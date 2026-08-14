import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.LocalSquareIntegrable

/-!
# Completion of locally square-integrable integrands

The local square-integrability assumption is almost sure, while a canonical
hitting-time construction is most convenient for a representative whose
terminal energy is finite on every sample path.  Under the usual conditions,
the null exceptional set belongs to every filtration sigma-algebra.  We may
therefore set the process to zero on that set without losing progressiveness.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace CompletedLocalIntegrand

open MeasureTheory Set
open scoped ENNReal NNReal

open ElementaryItoIntegral ProgressiveL2 LocalSquareIntegrable

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

/-- Sample paths with finite squared energy on the fixed horizon. -/
def goodEnergySet
    (eta : LocallySquareIntegrableProgressive filtration mu T) : Set Omega :=
  {omega |
    (∫⁻ t, ENNReal.ofReal ((eta.process t omega) ^ 2)
      ∂(TimeMeasure.upTo T)) < ∞}

/-- The exceptional set has measure zero by the local square-integrability
assumption. -/
theorem badEnergySet_null
    (eta : LocallySquareIntegrableProgressive filtration mu T) :
    mu (goodEnergySet eta)ᶜ = 0 := by
  rw [measure_eq_zero_iff_ae_notMem]
  filter_upwards [eta.locallySquareIntegrable] with omega homega
  exact fun hbad => hbad homega

/-- Under the usual completeness assumption, the good path set is measurable
in every filtration sigma-algebra. -/
theorem goodEnergySet_measurable
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (t : ℝ≥0) :
    MeasurableSet[filtration t] (goodEnergySet eta) := by
  simpa only [compl_compl] using
    (hUsual.completeAt t (goodEnergySet eta)ᶜ
      (badEnergySet_null eta)).compl

/-- Replace the process by zero on the null exceptional set. -/
noncomputable def completedProcess
    (eta : LocallySquareIntegrableProgressive filtration mu T) :
    ℝ≥0 → Omega → ℝ := by
  classical
  exact fun t omega =>
    if omega ∈ goodEnergySet eta then eta.process t omega else 0

/-- Completion on the null exceptional set preserves strong progressiveness. -/
theorem completedProcess_progressive
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T) :
    IsStronglyProgressive filtration (completedProcess eta) := by
  classical
  intro t
  have hset : @MeasurableSet (Set.Iic t × Omega)
      (Subtype.instMeasurableSpace.prod (filtration t))
      {p | p.2 ∈ goodEnergySet eta} :=
    (goodEnergySet_measurable hUsual eta t).preimage measurable_snd
  simpa only [completedProcess] using
    (StronglyMeasurable.ite hset (eta.progressive t) stronglyMeasurable_const)

/-- The completed representative agrees almost surely with the original
process at every time. -/
theorem completedProcess_ae_eq
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (t : ℝ≥0) :
    completedProcess eta t =ᵐ[mu] eta.process t := by
  classical
  filter_upwards [eta.locallySquareIntegrable] with omega homega
  have hgood : omega ∈ goodEnergySet eta := homega
  simp [completedProcess, hgood]

/-- Every completed sample path has finite terminal squared energy. -/
theorem completedProcess_energy_lt_top
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (omega : Omega) :
    (∫⁻ t, ENNReal.ofReal ((completedProcess eta t omega) ^ 2)
      ∂(TimeMeasure.upTo T)) < ∞ := by
  classical
  by_cases hgood : omega ∈ goodEnergySet eta
  · have hfinite :
        (∫⁻ t, ENNReal.ofReal ((eta.process t omega) ^ 2)
          ∂(TimeMeasure.upTo T)) < ∞ := hgood
    simpa only [completedProcess, if_pos hgood] using hfinite
  · simp [completedProcess, hgood]

/-- The completed representative, packaged again as a progressive local
integrand. -/
noncomputable def completed
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T) :
    LocallySquareIntegrableProgressive filtration mu T where
  process := completedProcess eta
  progressive := completedProcess_progressive hUsual eta
  locallySquareIntegrable := ae_of_all mu
    (completedProcess_energy_lt_top eta)

@[simp] theorem completed_process
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T) :
    (completed hUsual eta).process = completedProcess eta :=
  rfl

end

end CompletedLocalIntegrand
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
