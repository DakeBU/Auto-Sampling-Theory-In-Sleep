import AutoSamplingTheory.Core
import AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor
import AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.LogSobolev
import AutoSamplingTheory.TechnicalLemmas.InformationTheory.DonskerVaradhan
import AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel
import AutoSamplingTheory.TechnicalLemmas.Probability.LawMap
import AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian

/-!
# Technical lemma memory registry

The registry is the compiled Lean side of ASTIS technical lemma memory.  It
records which reusable lemmas exist locally, what upstream/source material
motivated them, and which proof backend they support.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas

inductive LemmaMemoryStatus where
  | formalizedLocal
  | portCandidate
  | sourceGap
  | referenceOnly
deriving Repr, DecidableEq

/-- Metadata for a lemma-memory entry.  The executable proof is the declaration
named in `localDecl`; this structure is only the retrieval record used by
agents and documentation exports. -/
structure LemmaMemoryEntry where
  key : String
  localDecl : String
  upstreamDecl : String
  upstreamFile : String
  status : LemmaMemoryStatus
  tags : List String
  saldUse : String
  note : String
deriving Repr, DecidableEq

def sltSourceAnchor (file decl note : String) : SourceAnchor :=
  sourceAnchor
    ("slt-" ++ file ++ "-" ++ decl)
    "externalLean"
    "https://github.com/YuanheZ/lean-stat-learning-theory"
    (file ++ ":" ++ decl)
    note

def gaussianMemory : List LemmaMemoryEntry := [
  {
    key := "gaussian.product.coordinate-law",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.map_eval_stdGaussianPi",
    upstreamDecl := "map_eval_stdGaussianPi",
    upstreamFile := "SLT/GaussianMeasure.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "coordinate-law", "brownian-increment"],
    saldUse := "normalized scalar coordinate law in the Brownian/Ito EM backend",
    note := "ASTIS-native product-Gaussian coordinate projection theorem."
  },
  {
    key := "gaussian.product.coordinate-integrable",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integrable_eval_stdGaussianPi",
    upstreamDecl := "integrable_eval_stdGaussianPi",
    upstreamFile := "SLT/GaussianMeasure.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "integrability", "coordinate", "brownian-increment"],
    saldUse := "Brownian/Ito coordinate integrability for scalar Taylor moment and generator leaves",
    note := "Cycle 203 lower_3 ASTIS-owned port; uses Mathlib Gaussian exponential integrability and Measure.map transport."
  },
  {
    key := "gaussian.product.coordinate-square-integrable",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integrable_sq_eval_stdGaussianPi",
    upstreamDecl := "integrable_sq_eval_stdGaussianPi",
    upstreamFile := "SLT/GaussianMeasure.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "integrability", "quadratic-moment", "brownian-increment"],
    saldUse := "Brownian/Ito coordinate square integrability for polynomial moment leaves",
    note := "Cycle 203 lower_3 ASTIS-owned port; reuses the local quadratic Gaussian integrability lemma."
  },
  {
    key := "gaussian.product.coordinate-mean-zero",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integral_eval_stdGaussianPi",
    upstreamDecl := "integral_eval_stdGaussianPi",
    upstreamFile := "SLT/GaussianMeasure.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "mean", "coordinate", "brownian-increment"],
    saldUse := "coordinate mean-zero rewrite for Brownian/Ito scalar Taylor moment leaves",
    note := "Cycle 203 lower_3 ASTIS-owned port; combines product-coordinate law with the local centered Gaussian mean."
  },
  {
    key := "gaussian.unit-variance.nnreal",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.nnrealVarianceOneOfGaussianRealUnitLaw",
    upstreamDecl := "variance_id_gaussianReal",
    upstreamFile := "Mathlib.Probability.Distributions.Gaussian.Real",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "variance", "NNReal"],
    saldUse := "turn scalar Gaussian law and variance-field definition into normalized variance one",
    note := "Uses Mathlib Gaussian variance locally; no SLT import."
  },
  {
    key := "gaussian.quadratic-bound-integrable",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integrable_const_mul_sq_gaussianReal_zero",
    upstreamDecl := "integrable_exp_mul_gaussianReal / integrable_pow_of_integrable_exp_mul",
    upstreamFile := "Mathlib.Probability.Distributions.Gaussian.Real",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "integrability", "quadratic-bound", "brownian-increment"],
    saldUse := "supply normalized-remainder bound integrability once the source identifies remainderBound as C * z^2",
    note := "Cycle 196 lower_3 ASTIS-owned Gaussian quadratic integrability support; no SLT import."
  }
]

def taylorMemory : List LemmaMemoryEntry := [
  {
    key := "taylor.hessian.source-field-to-opnorm",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor.hessianOpNormOfSourceHessianField",
    upstreamDecl := "deriv2_bounded_of_compactlySupported",
    upstreamFile := "SLT/GaussianPoincare/TaylorBound.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["taylor", "hessian", "source-contract"],
    saldUse := "convert source-supplied selected-test Hessian representative into downstream Hessian operator-norm bound",
    note := "Does not prove that the SALD source supplies the Hessian field; it only packages the local bridge once supplied."
  },
  {
    key := "taylor.fderiv-hessian-to-iterated",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor.iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm",
    upstreamDecl := "taylor_order_one / TaylorBound proof idiom",
    upstreamFile := "SLT/GaussianPoincare/TaylorBound.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["taylor", "iteratedFDeriv", "hessian"],
    saldUse := "feed selected-line Taylor bounds from a Hessian operator-norm field",
    note := "ASTIS-owned Mathlib bridge."
  },
  {
    key := "brownian.quadratic-variation-normalization",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor.quadraticVariationNormalizationOfCoeffDefAndVarianceOne",
    upstreamDecl := "not upstream; extracted from SALD local proof needs",
    upstreamFile := "ASTIS/SALD cycles 174-176",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["brownian", "ito", "quadratic-variation", "normalization"],
    saldUse := "assemble quadratic coefficient and variance-one fields without re-assuming the downstream normalization",
    note := "Pure algebraic bridge made reusable for later SDE papers."
  }
]

def measureMemory : List LemmaMemoryEntry := [
  {
    key := "measure.law-map.integral",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Probability.LawMap.lawMapIntegral",
    upstreamDecl := "Mathlib.MeasureTheory.Measure.map / integral_map",
    upstreamFile := "Mathlib measure/integration APIs",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["measure-map", "law", "integral"],
    saldUse := "rewrite weak-test integrals under endpoint laws and EM interpolation laws",
    note := "Alias to a compiled ASTIS theorem in Probability.lean."
  },
  {
    key := "measure.law-map.dominated-derivative",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Probability.LawMap.lawMapIntegralHasDerivAtOfDominated",
    upstreamDecl := "hasDerivAt_integral_of_dominated_loc_of_deriv_le",
    upstreamFile := "Mathlib.Analysis.Calculus.ParametricIntegral",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["parametric-integral", "dominated-convergence", "weak-test"],
    saldUse := "transport dominated sample-space derivatives to law-level weak-test derivatives",
    note := "Key backend for EM weak Fokker--Planck and KL-derivative handoffs."
  },
  {
    key := "measure.conditional-distribution.integral",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel.condDistribIntegralNamedLawIntegral",
    upstreamDecl := "condDistrib / condExpKernel map orientation",
    upstreamFile := "Mathlib.Probability.Kernel.CondDistrib and Condexp",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["conditional-law", "kernel", "Bochner-integral"],
    saldUse := "conditional frozen drift and named-law conditional integral interface",
    note := "Compiled ASTIS conditional-law bridge from Probability.lean."
  }
]

def variationalMemory : List LemmaMemoryEntry := [
  {
    key := "dv.scaled-test.energy-bound",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.InformationTheory.DonskerVaradhan.dvVariationalScaledTestEnergyBound",
    upstreamDecl := "Donsker--Varadhan one-sided variational consequence",
    upstreamFile := "Boucheron-style cited result / future SLT entropy-duality port",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["DV", "KL", "energy"],
    saldUse := "convert finite log-mgf and KL hypotheses into residual energy bounds",
    note := "Small compiled consequence; full DV theorem remains a cited-result obligation."
  },
  {
    key := "lsi.sqrt-density.fisher-chain",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.LogSobolev.lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar",
    upstreamDecl := "LSI density and Fisher-information bookkeeping",
    upstreamFile := "Mathlib/SLT-inspired entropy and LSI proof shape",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["LSI", "FI", "density"],
    saldUse := "bookkeeping for LSI-to-KL/FI handoff after density assumptions are supplied",
    note := "Compiled scalar/integral algebra; full LSI analytic theorem remains an obligation."
  }
]

def saldExtractedMemory : List LemmaMemoryEntry := [
  {
    key := "sald.gronwall.scalar-rewrites",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.SALDExtracted.gronwallExpProductRewriteScalar",
    upstreamDecl := "SALD appendix Gronwall proof plus elementary exponential algebra",
    upstreamFile := "AutoSamplingTheory/SALD.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Gronwall", "scalar-algebra", "SALD-extracted"],
    saldUse := "forward-KL and discrete forward-KL Gronwall display algebra",
    note := "Compiled in SALD and exposed through TechnicalLemmas.SALDExtracted."
  },
  {
    key := "sald.em-endpoint-law-handoff",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.SALDExtracted.discreteForwardKlEmEndpointLawPairHandoff",
    upstreamDecl := "SALD discrete EM endpoint law bookkeeping",
    upstreamFile := "AutoSamplingTheory/SALD.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Euler-Maruyama", "endpoint-law", "SALD-extracted"],
    saldUse := "endpoint-law pair handoff for discrete SALD/VA-SALD proofs",
    note := "SALD-derived local theorem exposed as a searchable memory item."
  },
  {
    key := "sald.brownian-normalization-bridges",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw",
    upstreamDecl := "SALD Brownian/Ito normalized-coordinate law bridge",
    upstreamFile := "AutoSamplingTheory/SALD.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Brownian", "Ito", "Gaussian", "SALD-extracted"],
    saldUse := "active Brownian/Ito scalar generator backend and coordinate variance leaves",
    note := "Domain-specific SALD bridge; can be generalized later if reused."
  },
  {
    key := "sald.remainder-meas-gaussian-law",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw",
    upstreamDecl := "SALD Brownian/Ito normalized-remainder measurability bridge",
    upstreamFile := "AutoSamplingTheory/SALD.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Brownian", "Ito", "Gaussian", "measurability", "SALD-extracted"],
    saldUse := "discharge hRemainderMeas in the active Brownian/Ito Taylor moment backend",
    note := "Cycle 194 bridge transporting AEStronglyMeasurable across the normalized coordinate-law and variance equalities."
  },
  {
    key := "sald.remainder-bound-gaussian-law",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw",
    upstreamDecl := "SALD Brownian/Ito normalized-remainder domination bridge",
    upstreamFile := "AutoSamplingTheory/SALD.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Brownian", "Ito", "Gaussian", "domination", "SALD-extracted"],
    saldUse := "narrow hRemainderBound to normalized-coordinate-law domination in the active Brownian/Ito Taylor moment backend",
    note := "Cycle 194 bridge transporting ae domination across the normalized coordinate-law and variance equalities."
  },
  {
    key := "sald.remainder-bound-integrable-gaussian-law",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestRemainderBoundIntegrableOfStdGaussianVectorLaw",
    upstreamDecl := "SALD Brownian/Ito normalized-remainder dominating-bound integrability bridge",
    upstreamFile := "AutoSamplingTheory/SALD.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Brownian", "Ito", "Gaussian", "integrability", "SALD-extracted"],
    saldUse := "narrow hRemainderBoundInt to normalized-coordinate-law integrability in the active Brownian/Ito Taylor moment backend",
    note := "Cycle 195 bridge transporting MeasureTheory.Integrable across the normalized coordinate-law and variance equalities."
  },
  {
    key := "sald.normalized-remainder-bound-int-quadratic",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound",
    upstreamDecl := "SALD Brownian/Ito normalized-remainder quadratic domination integrability bridge",
    upstreamFile := "AutoSamplingTheory/SALD.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Brownian", "Ito", "Gaussian", "integrability", "quadratic-bound", "SALD-extracted"],
    saldUse := "narrow hNormalizedRemainderBoundInt to hNormalizedRemainderBoundDef plus normalized-coordinate-law integrability",
    note := "Cycle 196 bridge from source-cited remainderBound = C * z ^ 2 to normalized-coordinate-law integrability."
  }
]

def portQueueMemory : List LemmaMemoryEntry := [
  {
    key := "dv.entropy-duality",
    localDecl := "",
    upstreamDecl := "entropy_duality",
    upstreamFile := "SLT/GaussianLSI/DualityEntropy.lean",
    status := LemmaMemoryStatus.portCandidate,
    tags := ["DV", "entropy", "KL"],
    saldUse := "Donsker--Varadhan variational backend for KL energy bounds",
    note := "Port only when DV becomes the active dynamic leaf."
  },
  {
    key := "lsi.product-gaussian",
    localDecl := "",
    upstreamDecl := "gaussian_logSobolev_W12_pi",
    upstreamFile := "SLT/GaussianLSI/TensorizedGLSI.lean",
    status := LemmaMemoryStatus.portCandidate,
    tags := ["LSI", "Gaussian", "product"],
    saldUse := "LSI-to-KL/FI backend when the faithful proof reaches this cited-result boundary",
    note := "Large theorem; keep as queue entry until a local ASTIS declaration compiles."
  }
]

def technicalLemmaMemory : List LemmaMemoryEntry :=
  gaussianMemory ++ taylorMemory ++ measureMemory ++ variationalMemory ++
    saldExtractedMemory ++ portQueueMemory

def formalizedTechnicalLemmaCount : Nat :=
  (technicalLemmaMemory.filter fun entry =>
    entry.status == LemmaMemoryStatus.formalizedLocal).length

end TechnicalLemmas
end AutoSamplingTheory
