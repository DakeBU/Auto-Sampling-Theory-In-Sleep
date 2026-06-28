import AutoSamplingTheory

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

example : TechnicalLemmas.formalizedTechnicalLemmaCount = 27 := rfl

example :
    ∫ x : ℝ, x ∂(ProbabilityTheory.gaussianReal 0 (1 : NNReal)) = 0 :=
  TechnicalLemmas.Gaussian.integral_id_gaussianReal_zero 1

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
