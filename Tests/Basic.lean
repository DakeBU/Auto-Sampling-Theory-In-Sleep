import AutoSamplingTheory

open scoped ENNReal

open AutoSamplingTheory

example : literatureCount = 4 := rfl

example : automationTaskCount = 2 := rfl

example : threeLayerAgentContracts.length = 4 := rfl

example : SALD.saldExcludedFiles = ["sald_version_2.tex"] := rfl

example : SALD.firstFaithfulLabels.length = 10 := rfl

example : SALD.saldGronwallCandidateContract.status = ProofStatus.obligation := rfl

example : SALD.saldGronwallCandidateContract.mathlibRoute.length = 9 := rfl

example : SALD.saldLsiKlFiDensityTestContract.status = ProofStatus.obligation := rfl

example : SALD.saldLsiKlFiDensityTestContract.dependencies.length = 17 := rfl

example : SALD.cycle42DvVariationMiddleObligation.status = ProofStatus.obligation := rfl

example : SALD.cycle42DvVariationLowerObligation.status = ProofStatus.obligation := rfl

example : SALD.cycle43LsiKlFiUpperPacket.status = ProofStatus.obligation := rfl

example : SALD.cycle43LsiKlFiUpperObligation.status = ProofStatus.obligation := rfl

example : SALD.cycle43LsiKlFiMiddleObligation.status = ProofStatus.obligation := rfl

example : SALD.cycle43LsiKlFiLowerObligation.status = ProofStatus.obligation := rfl

example : SALD.saldStatusForLabel "lem:dv_variation" = ProofStatus.sourceCited := rfl

example : RMFLD.exploratorySeedLabels.length = 5 := rfl

example : openProblemCount = 1 := rfl

example : forbiddenProofPatterns.length = 5 := rfl

example : TechnicalLemmas.formalizedTechnicalLemmaCount = 95 := rfl

example :
    MeasureTheory.Integrable
      (fun x : ℝ => Real.exp (-(2 : ℝ) * ‖x‖ ^ 2))
      MeasureTheory.volume :=
  TechnicalLemmas.Analysis.Integrability.integrable_exp_neg_mul_norm_sq
    (E := ℝ) (a := 2) (by norm_num)

example :
    ∫⁻ x : ℝ, ENNReal.ofReal (Real.exp (-(2 : ℝ) * ‖x‖ ^ 2))
        ∂(MeasureTheory.volume : MeasureTheory.Measure ℝ) =
      ENNReal.ofReal ((Real.pi / (2 : ℝ)) ^ ((Module.finrank ℝ ℝ : ℝ) / 2)) :=
  TechnicalLemmas.Analysis.Integrability.lintegral_exp_neg_mul_norm_sq_eq
    (E := ℝ) (a := 2) (by norm_num)

example :
    MeasureTheory.IsProbabilityMeasure
      ((MeasureTheory.volume : MeasureTheory.Measure ℝ).withDensity fun x =>
        (ENNReal.ofReal
          (Real.exp (-(0 : ℝ)) *
            (Real.pi / (1 : ℝ)) ^ ((Module.finrank ℝ ℝ : ℝ) / 2)))⁻¹ *
          ENNReal.ofReal (Real.exp (-((1 : ℝ) * ‖x‖ ^ 2 + 0)))) :=
  TechnicalLemmas.Analysis.Integrability.isProbabilityMeasure_withDensity_exp_neg_add_mul_norm_sq
    (E := ℝ) (a := 1) (b := 0) (by norm_num)

example :
    ∫⁻ x : ℝ, TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
      (fun z : ℝ => ‖z‖ ^ 2) x ∂(MeasureTheory.volume : MeasureTheory.Measure ℝ) ≠ ∞ :=
  TechnicalLemmas.Analysis.Integrability.lintegral_gibbsDensityENNReal_ne_top_of_ae_quadratic_lower_bound
    (E := ℝ) (V := fun z : ℝ => ‖z‖ ^ 2) (a := 1) (b := 0)
    (by norm_num)
    (by simp)

example :
    MeasureTheory.IsProbabilityMeasure
      ((MeasureTheory.volume : MeasureTheory.Measure ℝ).withDensity fun x =>
        (∫⁻ y, TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
          (fun z : ℝ => ‖z‖ ^ 2) y ∂(MeasureTheory.volume : MeasureTheory.Measure ℝ))⁻¹ *
          TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
            (fun z : ℝ => ‖z‖ ^ 2) x) :=
  TechnicalLemmas.Analysis.Integrability.isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_quadratic_lower_bound
    (E := ℝ) (V := fun z : ℝ => ‖z‖ ^ 2) (a := 1) (b := 0)
    (by fun_prop)
    (by norm_num)
    (by simp)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      (Set.Ioi (0 : ℝ)) (fun x : ℝ => x) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi

example : ConvexOn ℝ (Set.Ioi (0 : ℝ)) (fun x : ℝ => -Real.log x) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi.convexOn_neg_log

example : Convex ℝ {x : ℝ | x ∈ Set.Ioi (0 : ℝ) ∧ -Real.log x ≤ 1} :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi.convex_sublevel_neg_log 1

example : Convex ℝ {x : ℝ | x ∈ Set.Ioi (0 : ℝ) ∧ (1 : ℝ) ≤ x} :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi.convex_superlevel 1

example : QuasiconcaveOn ℝ (Set.Ioi (0 : ℝ)) (fun x : ℝ => x) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi.quasiconcaveOn

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      {x : ℝ | x ∈ Set.Ioi (0 : ℝ) ∧ (1 : ℝ) ≤ x} (fun x : ℝ => x) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi.restrict_superlevel 1

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      ((LinearMap.id : ℝ →ₗ[ℝ] ℝ) ⁻¹' Set.Ioi (0 : ℝ))
      (fun x : ℝ => ((LinearMap.id : ℝ →ₗ[ℝ] ℝ) x)) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi.comp_linearMap
    (LinearMap.id : ℝ →ₗ[ℝ] ℝ)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      ((AffineMap.id ℝ ℝ) ⁻¹' Set.Ioi (0 : ℝ))
      (fun x : ℝ => (AffineMap.id ℝ ℝ) x) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi.comp_affineMap
    (AffineMap.id ℝ ℝ)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      (Set.univ : Set ℝ) (fun x : ℝ => 2 * Real.exp (-x)) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_const_mul_exp_neg_of_convexOn
    (convexOn_id convex_univ) (by norm_num)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      (Set.Ioi (0 : ℝ)) (fun x : ℝ => x * x) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi.mul
    TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      (Set.Ioi (0 : ℝ)) (fun x : ℝ => x ^ ((1 : ℝ) / 2)) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi.rpow (by norm_num)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      ((Set.Ioi (0 : ℝ)) ×ˢ (Set.Ioi (0 : ℝ))) (fun x : ℝ × ℝ => x.1 * x.2) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi.prod
    TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi

example : ConvexOn ℝ (Set.univ : Set ℝ) (fun x : ℝ => ‖x‖ ^ 2) :=
  TechnicalLemmas.Geometry.LogConcavity.convexOn_univ_norm_sq

example : ConvexOn ℝ (Set.univ : Set ℝ) (fun x : ℝ => (2 : ℝ) * ‖x‖ ^ 2 + 3) :=
  TechnicalLemmas.Geometry.LogConcavity.convexOn_univ_const_mul_norm_sq_add
    (E := ℝ) (a := 2) (b := 3) (by norm_num)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      (Set.univ : Set ℝ)
      (fun x : ℝ => Real.exp (-((1 : ℝ) * ‖x‖ ^ 2 + 0))) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_exp_neg_quadratic_norm
    (E := ℝ) (a := 1) (b := 0) (by norm_num)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      (Set.univ : Set ℝ)
      (fun x : ℝ =>
        (Real.exp (-(0 : ℝ)) *
            (Real.pi / (1 : ℝ)) ^ ((Module.finrank ℝ ℝ : ℝ) / 2))⁻¹ *
          Real.exp (-((1 : ℝ) * ‖x‖ ^ 2 + 0))) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_explicit_quadratic_normalized_density
    (E := ℝ) (a := 1) (b := 0) (by norm_num)

example : ConvexOn ℝ (Set.univ : Set ℝ) (fun x : ℝ => (2 : ℝ) * ‖x - 3‖ ^ 2 + 1) :=
  TechnicalLemmas.Geometry.LogConcavity.convexOn_univ_const_mul_norm_sub_sq_add
    (E := ℝ) (a := 2) (b := 1) (3 : ℝ) (by norm_num)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      (Set.univ : Set ℝ)
      (fun x : ℝ => Real.exp (-((1 : ℝ) * ‖x - 3‖ ^ 2 + 0))) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_exp_neg_shifted_quadratic_norm
    (E := ℝ) (a := 1) (b := 0) (3 : ℝ) (by norm_num)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      (Set.univ : Set ℝ)
      (fun x : ℝ =>
        (Real.exp (-(0 : ℝ)) *
            (Real.pi / (1 : ℝ)) ^ ((Module.finrank ℝ ℝ : ℝ) / 2))⁻¹ *
          Real.exp (-((1 : ℝ) * ‖x - 3‖ ^ 2 + 0))) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_explicit_shifted_quadratic_normalized_density
    (E := ℝ) (a := 1) (b := 0) (3 : ℝ) (by norm_num)

example : ConvexOn ℝ (Set.univ : Set (ℝ × ℝ))
    (fun z : ℝ × ℝ => (2 : ℝ) * ‖z.1 - z.2‖ ^ 2 + 1) :=
  TechnicalLemmas.Geometry.LogConcavity.convexOn_univ_const_mul_norm_fst_sub_snd_sq_add
    (E := ℝ) (a := 2) (b := 1) (by norm_num)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      (Set.univ : Set (ℝ × ℝ))
      (fun z : ℝ × ℝ => Real.exp (-((1 : ℝ) * ‖z.1 - z.2‖ ^ 2 + 0))) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_exp_neg_pair_sub_quadratic_norm
    (E := ℝ) (a := 1) (b := 0) (by norm_num)

example :
    TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn
      (Set.univ : Set (ℝ × ℝ))
      (fun z : ℝ × ℝ =>
        (Real.exp (-(0 : ℝ)) *
            (Real.pi / (1 : ℝ)) ^ ((Module.finrank ℝ ℝ : ℝ) / 2))⁻¹ *
          Real.exp (-((1 : ℝ) * ‖z.1 - z.2‖ ^ 2 + 0))) :=
  TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_explicit_pair_sub_quadratic_kernel
    (E := ℝ) (a := 1) (b := 0) (by norm_num)

example :
    MeasureTheory.IsProbabilityMeasure
      ((MeasureTheory.Measure.dirac (0 : ℝ)).withDensity (fun _ : ℝ => (1 : ℝ≥0∞))) :=
  TechnicalLemmas.Measure.RadonNikodym.isProbabilityMeasure_withDensity_of_lintegral_eq_one
    (MeasureTheory.Measure.dirac (0 : ℝ)) (fun _ : ℝ => (1 : ℝ≥0∞)) (by simp)

example :
    MeasureTheory.IsProbabilityMeasure
      ((MeasureTheory.Measure.dirac (0 : ℝ)).withDensity
        fun x : ℝ =>
          (∫⁻ y, (if y = y then (1 : ℝ≥0∞) else 1) ∂(MeasureTheory.Measure.dirac (0 : ℝ)))⁻¹ *
            (if x = x then (1 : ℝ≥0∞) else 1)) :=
  TechnicalLemmas.Measure.RadonNikodym.isProbabilityMeasure_withDensity_normalized_lintegral
    (MeasureTheory.Measure.dirac (0 : ℝ)) (fun x : ℝ => if x = x then (1 : ℝ≥0∞) else 1)
    (by simp) (by simp)

example :
    AEMeasurable
      (TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal (fun x : ℝ => x))
      (MeasureTheory.Measure.dirac (0 : ℝ)) :=
  TechnicalLemmas.Measure.Gibbs.aemeasurable_gibbsDensityENNReal
    (MeasureTheory.Measure.dirac (0 : ℝ)) measurable_id.aemeasurable

example :
    MeasureTheory.IsProbabilityMeasure
      ((MeasureTheory.Measure.dirac (0 : ℝ)).withDensity
        fun x : ℝ =>
          (∫⁻ y, TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
            (fun z : ℝ => z) y ∂(MeasureTheory.Measure.dirac (0 : ℝ)))⁻¹ *
            TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal (fun z : ℝ => z) x) :=
  TechnicalLemmas.Measure.Gibbs.isProbabilityMeasure_withDensity_normalized_gibbs
    (MeasureTheory.Measure.dirac (0 : ℝ)) (fun x : ℝ => x)
    (by simp [TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal])
    (by simp [TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal])

example :
    ∫⁻ x, TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
      (fun z : ℝ => z) x ∂(MeasureTheory.Measure.dirac (0 : ℝ)) ≠ 0 :=
  TechnicalLemmas.Measure.Gibbs.lintegral_gibbsDensityENNReal_ne_zero
    (MeasureTheory.Measure.dirac (0 : ℝ)) measurable_id.aemeasurable

example :
    ∫⁻ x, TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
      (fun z : ℝ => z) x ∂(MeasureTheory.Measure.dirac (0 : ℝ)) ≠ ∞ :=
  TechnicalLemmas.Measure.Gibbs.lintegral_gibbsDensityENNReal_ne_top_of_ae_le
    (MeasureTheory.Measure.dirac (0 : ℝ)) (fun z : ℝ => z)
    (fun _ : ℝ => (1 : ℝ≥0∞))
    (by simp [TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal])
    (by simp)

example :
    TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
        (fun _ : ℝ => 1) (0 : ℝ) ≤
      TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
        (fun _ : ℝ => 0) (0 : ℝ) :=
  TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal_le_of_potential_ge
    (by norm_num)

example :
    ∫⁻ x, TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
      (fun z : ℝ => z) x ∂(MeasureTheory.Measure.dirac (0 : ℝ)) ≠ ∞ :=
  TechnicalLemmas.Measure.Gibbs.lintegral_gibbsDensityENNReal_ne_top_of_ae_potential_ge
    (MeasureTheory.Measure.dirac (0 : ℝ)) (W := fun z : ℝ => z)
    (by simp)
    (by simp [TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal])

example :
    ∫⁻ x, TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
      (fun z : ℝ => z) x ∂(MeasureTheory.Measure.dirac (0 : ℝ)) ≠ ∞ :=
  TechnicalLemmas.Measure.Gibbs.lintegral_gibbsDensityENNReal_ne_top_of_ae_ge_const
    (MeasureTheory.Measure.dirac (0 : ℝ)) (c := 0)
    (by simp)

example :
    MeasureTheory.IsProbabilityMeasure
      ((MeasureTheory.Measure.dirac (0 : ℝ)).withDensity
        fun x : ℝ =>
          (∫⁻ y, TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
            (fun z : ℝ => z) y ∂(MeasureTheory.Measure.dirac (0 : ℝ)))⁻¹ *
            TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal (fun z : ℝ => z) x) :=
  TechnicalLemmas.Measure.Gibbs.isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_le
    (MeasureTheory.Measure.dirac (0 : ℝ)) (fun _ : ℝ => (1 : ℝ≥0∞))
    measurable_id.aemeasurable
    (by simp [TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal])
    (by simp)

example :
    MeasureTheory.IsProbabilityMeasure
      ((MeasureTheory.Measure.dirac (0 : ℝ)).withDensity
        fun x : ℝ =>
          (∫⁻ y, TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
            (fun z : ℝ => z) y ∂(MeasureTheory.Measure.dirac (0 : ℝ)))⁻¹ *
            TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal (fun z : ℝ => z) x) :=
  TechnicalLemmas.Measure.Gibbs.isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_potential_ge
    (MeasureTheory.Measure.dirac (0 : ℝ)) (W := fun z : ℝ => z)
    measurable_id.aemeasurable
    (by simp)
    (by simp [TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal])

example :
    MeasureTheory.IsProbabilityMeasure
      ((MeasureTheory.Measure.dirac (0 : ℝ)).withDensity
        fun x : ℝ =>
          (∫⁻ y, TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal
            (fun z : ℝ => z) y ∂(MeasureTheory.Measure.dirac (0 : ℝ)))⁻¹ *
            TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal (fun z : ℝ => z) x) :=
  TechnicalLemmas.Measure.Gibbs.isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_ge_const
    (MeasureTheory.Measure.dirac (0 : ℝ)) (c := 0)
    measurable_id.aemeasurable
    (by simp)

example :
    ((MeasureTheory.Measure.dirac (0 : ℝ)).withDensity
        (fun _ : ℝ => (1 : ℝ≥0∞))).map (MeasurableEquiv.refl ℝ) =
      ((MeasureTheory.Measure.dirac (0 : ℝ)).map (MeasurableEquiv.refl ℝ)).withDensity
        (fun _ : ℝ => (1 : ℝ≥0∞)) :=
  TechnicalLemmas.Measure.RadonNikodym.measurableEquiv_map_withDensity
    (MeasurableEquiv.refl ℝ) (MeasureTheory.Measure.dirac (0 : ℝ)) measurable_const

example :
    ∫ x : ℝ, x ∂(ProbabilityTheory.gaussianReal 0 (1 : NNReal)) = 0 :=
  TechnicalLemmas.Gaussian.integral_id_gaussianReal_zero 1

example :
    (ProbabilityTheory.gaussianReal 0 (1 : NNReal)).withDensity
        (fun x : ℝ => ENNReal.ofReal (Real.exp ((2 : ℝ) * x - (2 : ℝ) ^ 2 / 2))) =
      ProbabilityTheory.gaussianReal 2 (1 : NNReal) :=
  TechnicalLemmas.ProbabilityDistributions.Gaussian.gaussianReal_withDensity_exp_shift 2

example :
    ∫ x : ℝ, Real.exp ((3 : ℝ) * x)
        ∂(ProbabilityTheory.gaussianReal 0 (1 : NNReal)) =
      Real.exp ((3 : ℝ) ^ 2 / 2) :=
  TechnicalLemmas.ProbabilityDistributions.Gaussian.integral_exp_mul_gaussianReal_zero_one 3

example :
    MeasureTheory.Integrable
      (fun w : Fin 2 → ℝ => ∑ i : Fin 2, (2 : ℝ) * w i)
      (TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi 2) :=
  TechnicalLemmas.ProbabilityDistributions.Gaussian.integrable_linearForm_stdGaussianPi
    (n := 2) (fun _ => 2)

example :
    ∫ w : Fin 2 → ℝ, (∑ i : Fin 2, (2 : ℝ) * w i)
        ∂(TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi 2) = 0 :=
  TechnicalLemmas.ProbabilityDistributions.Gaussian.integral_linearForm_stdGaussianPi
    (n := 2) (fun _ => 2)

example :
    ∫ w : Fin 2 → ℝ,
        Real.exp ((∑ i : Fin 2, (1 : ℝ) * w i) - (∑ _ : Fin 2, (1 : ℝ) ^ 2) / 2)
          ∂(TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi 2) = 1 :=
  TechnicalLemmas.ProbabilityDistributions.Gaussian.integral_exp_centered_linearForm_stdGaussianPi
    (n := 2) (fun _ => 1)

example :
    (TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi 2).withDensity
        (fun y : Fin 2 → ℝ =>
          ENNReal.ofReal
            (Real.exp ((∑ i : Fin 2, (1 : ℝ) * y i) -
              (∑ _ : Fin 2, (1 : ℝ) ^ 2) / 2))) =
      MeasureTheory.Measure.pi
        (fun _ : Fin 2 => ProbabilityTheory.gaussianReal 1 (1 : NNReal)) :=
  TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi_withDensity_exp_shift
    (n := 2) (fun _ => 1)

example :
    ∫ _ : Fin 2 → ℝ, (1 : ℝ)
        ∂MeasureTheory.Measure.pi
          (fun _ : Fin 2 => ProbabilityTheory.gaussianReal 1 (1 : NNReal)) =
      ∫ X : Fin 2 → ℝ,
        Real.exp ((∑ i : Fin 2, (1 : ℝ) * X i) -
          (∑ _ : Fin 2, (1 : ℝ) ^ 2) / 2) * (1 : ℝ)
          ∂(TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi 2) :=
  TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi_shift_integral
    (n := 2) (fun _ => 1) (fun _ => 1)

example :
    ∫ _ : EuclideanSpace ℝ (Fin 2), (1 : ℝ)
        ∂(MeasureTheory.Measure.pi
          (fun _ : Fin 2 => ProbabilityTheory.gaussianReal 1 (1 : NNReal))).map
            (WithLp.toLp 2) =
      ∫ X : Fin 2 → ℝ,
        Real.exp ((∑ i : Fin 2, (1 : ℝ) * X i) -
          (∑ _ : Fin 2, (1 : ℝ) ^ 2) / 2) * (1 : ℝ)
          ∂(TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi 2) :=
  TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi_shift_integral_map_toLp
    (n := 2) (fun _ => 1) (f := fun _ => (1 : ℝ)) measurable_const

example :
    ∫ _ : EuclideanSpace ℝ (Fin 2), (1 : ℝ)
        ∂(MeasureTheory.Measure.pi
          (fun _ : Fin 2 => ProbabilityTheory.gaussianReal 1 (1 : NNReal))).map
            (WithLp.toLp 2) =
      ∫ Z : EuclideanSpace ℝ (Fin 2),
        Real.exp (inner ℝ (WithLp.toLp 2 (fun _ : Fin 2 => (1 : ℝ))
            : EuclideanSpace ℝ (Fin 2)) Z -
          ‖(WithLp.toLp 2 (fun _ : Fin 2 => (1 : ℝ))
            : EuclideanSpace ℝ (Fin 2))‖ ^ 2 / 2) * (1 : ℝ)
          ∂(ProbabilityTheory.stdGaussian (EuclideanSpace ℝ (Fin 2))) :=
  TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussian_shift_integral_map_toLp
    (ι := Fin 2) (fun _ => 1) (f := fun _ => (1 : ℝ)) measurable_const

example :
    ∫ _ : EuclideanSpace ℝ (Fin 2), (1 : ℝ)
        ∂(TechnicalLemmas.StochasticProcesses.Girsanov.finiteShiftedGaussianPathMeasure
          (fun _ : Fin 2 => (1 : ℝ))) =
      ∫ Z : EuclideanSpace ℝ (Fin 2),
        TechnicalLemmas.StochasticProcesses.Girsanov.finiteGaussianGirsanovWeight
          (fun _ : Fin 2 => (1 : ℝ)) Z * (1 : ℝ)
          ∂(ProbabilityTheory.stdGaussian (EuclideanSpace ℝ (Fin 2))) :=
  TechnicalLemmas.StochasticProcesses.Girsanov.finiteGaussianGirsanovCylinderIntegral
    (ι := Fin 2) (fun _ => 1) (F := fun _ => (1 : ℝ)) measurable_const

example :
    ∫ Z : EuclideanSpace ℝ (Fin 2),
        TechnicalLemmas.StochasticProcesses.Girsanov.finiteGaussianGirsanovWeight
          (fun _ : Fin 2 => (1 : ℝ)) Z
          ∂(ProbabilityTheory.stdGaussian (EuclideanSpace ℝ (Fin 2))) = 1 :=
  TechnicalLemmas.StochasticProcesses.Girsanov.integral_finiteGaussianGirsanovWeight_eq_one
    (ι := Fin 2) (fun _ => 1)

example :
    TechnicalLemmas.StochasticProcesses.Girsanov.finiteShiftedGaussianPathMeasure
        (fun _ : Fin 2 => (1 : ℝ)) =
      (ProbabilityTheory.stdGaussian (EuclideanSpace ℝ (Fin 2))).withDensity
        (fun Z =>
          ENNReal.ofReal
            (TechnicalLemmas.StochasticProcesses.Girsanov.finiteGaussianGirsanovWeight
              (fun _ : Fin 2 => (1 : ℝ)) Z)) :=
  TechnicalLemmas.StochasticProcesses.Girsanov.finiteGaussianGirsanovCylinderMeasure_eq_withDensity
    (ι := Fin 2) (fun _ => 1)

example :
    @TechnicalLemmas.Probability.LawMap.lawMapIntegral =
      @lawMapIntegral := rfl

example :
    @TechnicalLemmas.Probability.ConditionalKernel.condDistribIntegralNamedLawIntegral =
      @condDistribIntegralNamedLawIntegral := rfl

example :
    @TechnicalLemmas.InformationTheory.DonskerVaradhan.dvVariationalScaledTestEnergyBound =
      @dvVariationalScaledTestEnergyBound := rfl

example :
    @TechnicalLemmas.InformationTheory.KLDensity.klPointwiseDerivSimplify =
      @TechnicalLemmas.InformationTheory.KLDensity.klPointwiseDerivSimplify := rfl

example :
    @TechnicalLemmas.InformationTheory.KLDensity.klDerivativeRemoveMassTerm =
      @TechnicalLemmas.InformationTheory.KLDensity.klDerivativeRemoveMassTerm := rfl

example :
    0 < TechnicalLemmas.InformationTheory.Renyi.renyiIntegrand
      ((1 : ℝ) / 2) 2 3 :=
  TechnicalLemmas.InformationTheory.Renyi.renyiIntegrand_pos
    (by norm_num) (by norm_num)

example :
    Measurable fun x : ℝ =>
      TechnicalLemmas.InformationTheory.Renyi.renyiIntegrand
        ((1 : ℝ) / 2) x x :=
  TechnicalLemmas.InformationTheory.Renyi.measurable_renyiIntegrand
    (by norm_num) (by norm_num) measurable_id measurable_id

example :
    ∫⁻ x, TechnicalLemmas.InformationTheory.Renyi.renyiIntegrandENNReal
      ((1 : ℝ) / 2) (fun _ : ℝ => 1) (fun _ : ℝ => 1) x
        ∂(MeasureTheory.Measure.dirac (0 : ℝ)) ≠ ∞ :=
  TechnicalLemmas.InformationTheory.Renyi.lintegral_renyiIntegrandENNReal_ne_top_of_ae_le
    (MeasureTheory.Measure.dirac (0 : ℝ)) ((1 : ℝ) / 2)
    (fun _ : ℝ => 1) (fun _ : ℝ => 1) (fun _ : ℝ => (1 : ℝ≥0∞))
    (by simp [TechnicalLemmas.InformationTheory.Renyi.renyiIntegrandENNReal,
      TechnicalLemmas.InformationTheory.Renyi.renyiIntegrand])
    (by simp)

example :
    HasDerivAt
      (fun s : ℝ =>
        TechnicalLemmas.InformationTheory.Renyi.renyiIntegrand
          ((1 : ℝ) / 2) ((fun _ : ℝ => 2) s) ((fun _ : ℝ => 3) s))
      0 0 := by
  simpa using
    TechnicalLemmas.InformationTheory.Renyi.hasDerivAt_renyiIntegrand
      (a := ((1 : ℝ) / 2)) (p := fun _ : ℝ => 2) (q := fun _ : ℝ => 3)
      (t := 0) (pdot := 0) (qdot := 0)
      (hasDerivAt_const (0 : ℝ) (2 : ℝ))
      (hasDerivAt_const (0 : ℝ) (3 : ℝ))
      (by norm_num) (by norm_num)

example :
    @TechnicalLemmas.StochasticProcesses.WeakGenerator.weakGeneratorFromSampleDerivative =
      @TechnicalLemmas.StochasticProcesses.WeakGenerator.weakGeneratorFromSampleDerivative := rfl

example :
    @TechnicalLemmas.StochasticProcesses.FokkerPlanckAlgebra.fpRewriteScalarAlgebra =
      @TechnicalLemmas.StochasticProcesses.FokkerPlanckAlgebra.fpRewriteScalarAlgebra := rfl

example :
    @TechnicalLemmas.StochasticProcesses.FokkerPlanckAlgebra.fisherIbpAlgebra =
      @TechnicalLemmas.StochasticProcesses.FokkerPlanckAlgebra.fisherIbpAlgebra := rfl

example :
    @TechnicalLemmas.FunctionalInequalities.LogSobolev.lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar =
      @lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar := rfl

example :
    @TechnicalLemmas.ProbabilityDistributions.Gaussian.integral_id_gaussianReal_zero =
      @TechnicalLemmas.Gaussian.integral_id_gaussianReal_zero := rfl

example :
    @TechnicalLemmas.Analysis.Calculus.Taylor.iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm =
      @TechnicalLemmas.Taylor.iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm := rfl
