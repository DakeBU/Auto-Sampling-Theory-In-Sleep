import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoIntegralProcess

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses

#check ItoIntegralProcess.measure_uniformBadEvent_le
#check ItoIntegralProcess.tsum_measure_uniformBadEvent_ne_top
#check ItoIntegralProcess.canonicalItoProcess_uniformCauchyOn
#check ItoIntegralProcess.tendstoUniformlyOn_canonicalPathLimit
#check ItoIntegralProcess.itoIntegralProcess_continuous_ae
#check ItoIntegralProcess.itoIntegralProcess_stronglyAdapted
#check ItoIntegralProcess.terminalRepresentative_ae_eq_actual
#check ItoIntegralProcess.itoIntegralTerminal_restrictAt_elementary_ae
#check ItoIntegralProcess.itoIntegralProcess_at_eq_terminal_of_pos
#check ItoIntegralProcess.itoIntegralProcess_at_zero
#check ItoIntegralProcess.itoIntegralProcess_at_eq_terminal
#check ItoIntegralProcess.itoIntegralProcess_isometry_restrictAt
#check ItoIntegralProcess.itoIntegralProcess_zero
#check ItoIntegralProcess.itoIntegralProcess_add
#check ItoIntegralProcess.itoIntegralProcess_smul
#check ItoIntegralProcess.itoIntegralProcess_unique
#check ItoIntegralProcess.itoIntegralProcess_martingale
#check ItoIntegralProcess.itoIntegralProcess_integrable
#check ItoIntegralProcess.itoIntegralProcess_terminal_eq
#check ItoIntegralProcess.chewi_display_1_1_9
#check ItoIntegralProcess.chewi_display_1_1_9_terminal
#check ItoIntegralProcess.chewi_theorem_1_1_8

namespace AutoSamplingTheory.Tests.GeneralItoIntegral

open MeasureTheory Set
open scoped NNReal ENNReal
open BrownianMotion ElementaryItoIntegral ElementaryItoProcess ItoTerminalCompletion
  ProgressiveL2 ProgressiveL2Density SampledElementaryApproximation

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}
  {B : ℝ≥0 → Omega → ℝ}

/-- A one-cell deterministic unit integrand used to exercise the complete
general-Ito construction rather than only checking its declaration names. -/
noncomputable def unitElementary (hT : 0 < T) :
    ElementaryAdaptedProcess filtration 1 where
    times := regularGridTimes T 1
    times_strictMono := regularGridTimes_strictMono hT 1
    coeff := fun _ _ => 1
    coeff_stronglyMeasurable := fun _ => stronglyMeasurable_const
    coeff_bounded := fun _ => ⟨1, fun _ => by simp⟩

noncomputable def unitDyadic (hT : 0 < T) :
    DyadicElementaryProcess filtration T where
  level := 0
  process := unitElementary hT
  times_eq := by simp [unitElementary, dyadicMesh]

theorem unitDyadic_elementaryItoProcess
    (hT : 0 < T) {t : ℝ≥0} (htT : t ≤ T) (omega : Omega) :
    elementaryItoProcess (unitElementary (filtration := filtration) hT) B T t omega =
      B t omega - B 0 omega := by
  simp [elementaryItoProcess, elementaryItoIntegral, unitElementary,
    regularGridTimes]
  rw [min_eq_left htT]

example [IsFiniteMeasure mu]
    (hT : 0 < T) (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    {t : ℝ≥0} (ht : 0 < t) (htT : t ≤ T) :
    ItoIntegralProcess.itoIntegralProcess
        (elementaryIntegrand (unitDyadic (filtration := filtration) hT) hB)
        hT hB hUsual t =ᵐ[mu]
      fun omega => B t omega - B 0 omega := by
  have hprocess :=
    ItoIntegralProcess.itoIntegralProcess_at_eq_terminal
      (elementaryIntegrand (unitDyadic (filtration := filtration) hT) hB)
      hT hB hUsual htT
  have helementary :=
    ItoIntegralProcess.itoIntegralTerminal_restrictAt_elementary_ae
      (unitDyadic (filtration := filtration) hT) hT hB ht htT
  exact hprocess.trans (helementary.trans
    (Filter.Eventually.of_forall fun omega => by
      simpa [unitDyadic] using unitDyadic_elementaryItoProcess hT htT omega))

example [IsFiniteMeasure mu]
    (hT : 0 < T) (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    {t : ℝ≥0} (htT : t ≤ T) :
    ItoIntegralProcess.itoIntegralProcess
        (ProgressiveL2Algebra.zero : ProgressiveL2Integrand filtration mu T)
        hT hB hUsual t =ᵐ[mu] fun _ => 0 :=
  ItoIntegralProcess.itoIntegralProcess_zero hT hB hUsual htT

example [IsFiniteMeasure mu]
    (eta xi : ProgressiveL2Integrand filtration mu T)
    (hT : 0 < T) (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    {t : ℝ≥0} (htT : t ≤ T) :
    ItoIntegralProcess.itoIntegralProcess
        (ProgressiveL2Algebra.add eta xi) hT hB hUsual t =ᵐ[mu]
      fun omega =>
        ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual t omega +
          ItoIntegralProcess.itoIntegralProcess xi hT hB hUsual t omega :=
  ItoIntegralProcess.itoIntegralProcess_add eta xi hT hB hUsual htT

example [IsFiniteMeasure mu]
    (c : ℝ) (eta : ProgressiveL2Integrand filtration mu T)
    (hT : 0 < T) (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    {t : ℝ≥0} (htT : t ≤ T) :
    ItoIntegralProcess.itoIntegralProcess
        (ProgressiveL2Algebra.smul c eta) hT hB hUsual t =ᵐ[mu]
      fun omega => c *
        ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual t omega :=
  ItoIntegralProcess.itoIntegralProcess_smul c eta hT hB hUsual htT

example [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T)
    (hT : 0 < T) (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    {t : ℝ≥0} (htT : t ≤ T) :
    ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual t =ᵐ[mu]
      fun omega => itoIntegralTerminal (eta.restrictAt t) hT hB omega :=
  ItoIntegralProcess.itoIntegralProcess_at_eq_terminal
    eta hT hB hUsual htT

example [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T)
    (hT : 0 < T) (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    {t : ℝ≥0} (htT : t ≤ T) :
    ∫ omega,
        (ItoIntegralProcess.itoIntegralProcess
          eta hT hB hUsual t omega) ^ 2 ∂mu =
      ∫ z, (processFunction (eta.restrictAt t).process z) ^ 2
        ∂(processTimeMeasure mu T) :=
  ItoIntegralProcess.chewi_display_1_1_9 eta hT hB hUsual htT

example [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T)
    (hT : 0 < T) (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu) :
    Martingale
        (ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual)
        filtration mu ∧
      (∀ᵐ omega ∂mu, ContinuousOn
        (fun t => ItoIntegralProcess.itoIntegralProcess
          eta hT hB hUsual t omega) (Icc 0 T)) :=
  ⟨ItoIntegralProcess.itoIntegralProcess_martingale
      eta hT hB hUsual,
    ItoIntegralProcess.itoIntegralProcess_continuous_ae
      eta hT hB hUsual⟩

end AutoSamplingTheory.Tests.GeneralItoIntegral
