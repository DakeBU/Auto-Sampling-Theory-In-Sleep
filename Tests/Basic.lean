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
