import AutoSamplingTheory.Core
import AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability
import AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor
import AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.LogSobolev
import AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity
import AutoSamplingTheory.TechnicalLemmas.InformationTheory.DonskerVaradhan
import AutoSamplingTheory.TechnicalLemmas.InformationTheory.KLDensity
import AutoSamplingTheory.TechnicalLemmas.InformationTheory.Renyi
import AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs
import AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym
import AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel
import AutoSamplingTheory.TechnicalLemmas.Probability.LawMap
import AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses

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

def analysisMemory : List LemmaMemoryEntry := [
  {
    key := "analysis.integrability.of-real-lintegral-finite",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability.lintegral_ofReal_ne_top_of_integrable_nonneg",
    upstreamDecl := "lintegral_ofReal_ne_top_iff_integrable",
    upstreamFile := "Mathlib.MeasureTheory.Function.L1Space.Integrable",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "integrability", "lintegral", "ENNReal", "ofReal", "nonnegative"],
    saldUse := "Chewi DENS/ANALYSIS root: turn real-valued tail integrability estimates into finite ENNReal density integrals",
    note := "Generic bridge used by Gibbs and future Renyi/Hellinger finite-integral leaves."
  },
  {
    key := "analysis.integrability.gaussian-quadratic-tail",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability.integrable_exp_neg_mul_norm_sq",
    upstreamDecl := "GaussianFourier.integrable_cexp_neg_mul_sq_norm_add",
    upstreamFile := "Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "integrability", "Lebesgue", "Gaussian-tail", "quadratic", "finite-dimensional"],
    saldUse := "Chewi DENS/CONV root: finite-dimensional Lebesgue integrability of `exp (-a * ‖x‖^2)` for coercive Gibbs envelopes",
    note := "Mathlib-backed high-dimensional Gaussian tail integrability leaf; extracted from the complex Fourier Gaussian API."
  },
  {
    key := "analysis.integrability.shifted-gaussian-quadratic-tail",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability.integrable_exp_neg_add_mul_norm_sq",
    upstreamDecl := "integrable_exp_neg_mul_norm_sq / Real.exp_add",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "integrability", "Lebesgue", "Gaussian-tail", "quadratic", "shifted"],
    saldUse := "Chewi DENS/CONV root: integrability of shifted quadratic envelopes `exp (-(a‖x‖^2+b))`",
    note := "Keeps additive constants in coercive lower potentials separate from the Gaussian tail theorem."
  },
  {
    key := "measure.gibbs-density.integral-finite-quadratic-lower-bound",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability.lintegral_gibbsDensityENNReal_ne_top_of_ae_quadratic_lower_bound",
    upstreamDecl := "lintegral_exp_neg_add_mul_norm_sq_ne_top / lintegral_gibbsDensityENNReal_ne_top_of_ae_potential_ge",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability; AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "density", "Lebesgue", "coercivity", "quadratic-lower-bound", "finite"],
    saldUse := "Chewi DENS/CONV root: prove finite Gibbs normalizer on finite-dimensional Lebesgue space from a quadratic lower bound on the potential",
    note := "First concrete Lebesgue coercivity envelope leaf; stronger nonquadratic/coercive tails remain future analysis leaves."
  },
  {
    key := "measure.gibbs-density.normalized-probability-quadratic-lower-bound",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability.isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_quadratic_lower_bound",
    upstreamDecl := "lintegral_gibbsDensityENNReal_ne_zero / lintegral_gibbsDensityENNReal_ne_top_of_ae_quadratic_lower_bound",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability; AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "withDensity", "Lebesgue", "coercivity", "quadratic-lower-bound", "probability-measure"],
    saldUse := "Chewi DENS/CONV root: construct normalized finite-dimensional Lebesgue Gibbs targets from measurable potentials with quadratic lower bounds",
    note := "Turns the first concrete coercivity normalizer into the normalized target law consumed by Langevin and KL/FI branches."
  }
]

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
    key := "gaussian.product.linear-form-integrable",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integrable_linearForm_stdGaussianPi",
    upstreamDecl := "finite-sum closure of integrable_eval_stdGaussianPi",
    upstreamFile := "Mathlib.MeasureTheory.Function.L1Space.Integrable; ASTIS Gaussian",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "product-gaussian", "linear-form", "integrability", "brownian-increment", "Esscher"],
    saldUse := "finite-dimensional Gaussian linear-function integrability before MGF, Esscher tilt, and Brownian increment packaging",
    note := "Small ASTIS-owned closure lemma; keeps product-Gaussian linear forms separate from exponential tilt/MGF work."
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
    key := "gaussian.product.linear-form-mean-zero",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integral_linearForm_stdGaussianPi",
    upstreamDecl := "finite-sum closure of integral_eval_stdGaussianPi",
    upstreamFile := "Mathlib.MeasureTheory.Integral.Bochner.Basic; ASTIS Gaussian",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "product-gaussian", "linear-form", "mean-zero", "brownian-increment", "Esscher"],
    saldUse := "zero-mean finite-dimensional Gaussian linear forms before centered tilt/MGF and generator algebra",
    note := "Compiled finite-sum closure of centered coordinate means; full Gaussian Esscher density identity remains a separate target."
  },
  {
    key := "gaussian.product.linear-form-mgf",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integral_exp_linearForm_stdGaussianPi",
    upstreamDecl := "mgf_gaussianReal / integral_fintype_prod_eq_prod",
    upstreamFile := "Mathlib.Probability.Distributions.Gaussian.Real; Mathlib.MeasureTheory.Integral.Pi; external AST GaussianMGF.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "product-gaussian", "linear-form", "MGF", "Esscher", "Chewi"],
    saldUse := "Chewi GAUSS root: compute finite product-Gaussian exponential moments for tilt normalizers and Brownian increment laws",
    note := "ASTIS-owned finite-product MGF leaf distilled from the external GaussianMGF proof route; full density shift remains separate."
  },
  {
    key := "gaussian.product.centered-esscher-normalizer",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integral_exp_centered_linearForm_stdGaussianPi",
    upstreamDecl := "integral_exp_linearForm_stdGaussianPi plus elementary exponential algebra",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "product-gaussian", "Esscher", "tilt", "normalization", "Chewi"],
    saldUse := "Chewi GAUSS root: certify the centered exponential tilt has mass one before proving the shifted density/change-of-measure identity",
    note := "This is the compiled normalizer half of finite-dimensional Esscher; it does not yet prove the withDensity shifted-Gaussian identity."
  },
  {
    key := "gaussian.scalar.esscher-shift-density",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.gaussianReal_withDensity_exp_shift",
    upstreamDecl := "gaussianReal_of_var_ne_zero / gaussianPDFReal algebra",
    upstreamFile := "Mathlib.Probability.Distributions.Gaussian.Real; external AST GaussianShift.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "Esscher", "withDensity", "density-shift", "Chewi"],
    saldUse := "Chewi GAUSS root: one-dimensional Gaussian exponential tilt shifts the mean",
    note := "ASTIS-owned scalar density identity; product versions consume the finite-pi withDensity decomposition leaf."
  },
  {
    key := "gaussian.product.esscher-shift-density",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi_withDensity_exp_shift",
    upstreamDecl := "gaussianReal_withDensity_exp_shift / pi_withDensity_prod",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian; external AST GaussianShift.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "product-gaussian", "Esscher", "withDensity", "density-shift", "Chewi"],
    saldUse := "Chewi GAUSS root: finite product-Gaussian centered exponential tilt equals the shifted product Gaussian law",
    note := "Completes the shifted-density half of finite-dimensional Esscher; integral change-of-measure and Euclidean/path-space packaging remain separate."
  },
  {
    key := "gaussian.product.esscher-change-of-measure",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi_shift_integral",
    upstreamDecl := "stdGaussianPi_withDensity_exp_shift / integral_withDensity_eq_integral_toReal_smul",
    upstreamFile := "Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap; external AST GaussianShift.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "product-gaussian", "Esscher", "change-of-measure", "Girsanov", "Chewi"],
    saldUse := "Chewi GAUSS/PATH root: rewrite integrals under finite shifted product Gaussians as centered product-Gaussian weighted integrals",
    note := "Finite-dimensional product-Gaussian change-of-measure is compiled; EuclideanSpace pushforward, stdGaussian, and path-space/Girsanov packaging are separate entries."
  },
  {
    key := "gaussian.euclidean.pushforward-esscher-change-of-measure",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussianPi_shift_integral_map_toLp",
    upstreamDecl := "pi_gaussianReal_shift_integral / integral_map / WithLp.toLp",
    upstreamFile := "Mathlib.Probability.Distributions.Gaussian.Multivariate; AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "EuclideanSpace", "product-gaussian", "Esscher", "change-of-measure", "Girsanov", "Chewi"],
    saldUse := "Chewi GAUSS/PATH root: transport finite shifted product-Gaussian change-of-measure through the EuclideanSpace `WithLp.toLp 2` interface",
    note := "Compiled coordinate-exponent pushforward bridge; canonical `stdGaussian` inner-product form and path-space/Girsanov packaging are separate entries."
  },
  {
    key := "gaussian.euclidean.stdGaussian-esscher-change-of-measure",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.stdGaussian_shift_integral_map_toLp",
    upstreamDecl := "stdGaussianPi_shift_integral_map_toLp / map_pi_eq_stdGaussian / EuclideanSpace inner and norm coordinates",
    upstreamFile := "Mathlib.Probability.Distributions.Gaussian.Multivariate; Mathlib.Analysis.InnerProductSpace.PiL2",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["gaussian", "stdGaussian", "EuclideanSpace", "Esscher", "change-of-measure", "Girsanov", "Chewi"],
    saldUse := "Chewi GAUSS/PATH root: express finite-dimensional Gaussian Esscher change-of-measure against Mathlib `stdGaussian` with inner-product/norm exponent",
    note := "Compiled canonical finite-dimensional Hilbert-space form; Brownian/path-space Girsanov packaging remains separate."
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
  },
  {
    key := "conditional-kernel.named-field-integral",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel.condDistribIntegralNamedFieldIntegral",
    upstreamDecl := "condDistrib / compProd_map_condDistrib / integral_congr_ae",
    upstreamFile := "Mathlib.Probability.Kernel.CondDistrib and MeasureTheory integral APIs",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["conditional-law", "kernel", "Bochner-integral", "versioning"],
    saldUse := "turn a named conditional drift component version into the joint-law weak-generator integral",
    note := "Pro-assimilated leaf: conditional-pairing/versioning backend separated from weak FP and Ito."
  },
  {
    key := "measure.with-density.probability-normalization",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym.isProbabilityMeasure_withDensity_of_lintegral_eq_one",
    upstreamDecl := "withDensity_apply / IsProbabilityMeasure",
    upstreamFile := "Mathlib.MeasureTheory.Measure.WithDensity; Mathlib.MeasureTheory.Measure.Typeclasses.Probability",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "withDensity", "normalization", "probability-measure", "density"],
    saldUse := "Chewi DENS/MEAS root: turn normalized Gibbs or tilted density contracts into a probability measure",
    note := "Small measure-normalization wrapper; concrete Gibbs integrability remains a separate analytic leaf."
  },
  {
    key := "measure.density.normalized-lintegral-one",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym.lintegral_inv_lintegral_mul_eq_one",
    upstreamDecl := "lintegral_const_mul' / ENNReal.inv_mul_cancel",
    upstreamFile := "Mathlib.MeasureTheory.Integral.Lebesgue.Add; Mathlib.Data.ENNReal.Inv",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "density", "lintegral", "normalization", "ENNReal"],
    saldUse := "Chewi DENS/MEAS root: normalize any finite nonzero density before specializing to Gibbs densities",
    note := "Generic reciprocal-lintegral normalization; no concrete measurability or integrability proof is hidden."
  },
  {
    key := "measure.with-density.normalized-probability",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym.isProbabilityMeasure_withDensity_normalized_lintegral",
    upstreamDecl := "lintegral_inv_lintegral_mul_eq_one / withDensity_apply / IsProbabilityMeasure",
    upstreamFile := "Mathlib.MeasureTheory.Measure.WithDensity; Mathlib.MeasureTheory.Integral.Lebesgue.Add",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "withDensity", "density", "normalization", "probability-measure"],
    saldUse := "Chewi DENS/MEAS root: construct probability targets from finite nonzero unnormalized densities",
    note := "Bridges generic density normalization to the `withDensity` probability-measure contract."
  },
  {
    key := "measure.pi.lintegral-product-factorization",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym.lintegral_fintype_prod_eq_prod",
    upstreamDecl := "ENNReal analogue of integral_fintype_prod_eq_prod",
    upstreamFile := "Mathlib.MeasureTheory.Integral.Pi; external AST PiWithDensity.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Measure.pi", "lintegral", "product", "ENNReal", "Fubini"],
    saldUse := "Chewi MEAS/DENS root: factor finite-product ENNReal densities before tensorized withDensity or Gaussian shift leaves",
    note := "Compiled ASTIS-owned finite-product ENNReal Fubini leaf; useful beyond Gaussian tilts."
  },
  {
    key := "measure.pi.with-density-product",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym.pi_withDensity_prod",
    upstreamDecl := "lintegral_fintype_prod_eq_prod / withDensity_apply",
    upstreamFile := "Mathlib.MeasureTheory.Measure.WithDensity; external AST PiWithDensity.lean",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Measure.pi", "withDensity", "product-density", "tensorization"],
    saldUse := "Chewi MEAS/DENS root: decompose finite product density tilts into coordinatewise withDensity measures",
    note := "Shared root for product Gaussian Esscher, product Gibbs, and tensorization-style density constructions."
  },
  {
    key := "measure.with-density.absolute-continuity",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym.withDensity_absolutelyContinuous_base",
    upstreamDecl := "withDensity_absolutelyContinuous",
    upstreamFile := "Mathlib.MeasureTheory.Measure.WithDensity",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "withDensity", "absolute-continuity", "RN"],
    saldUse := "Chewi DENS/MEAS root before RN derivative and density-comparison leaves",
    note := "Callable ASTIS wrapper for the base absolute-continuity fact of withDensity."
  },
  {
    key := "measure.with-density.map-measurable-equiv",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym.measurableEquiv_map_withDensity",
    upstreamDecl := "Measure.map_apply / withDensity_apply / setLIntegral_map",
    upstreamFile := "Mathlib.MeasureTheory.Integral.Lebesgue.Map; Mathlib.MeasureTheory.Measure.WithDensity",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "withDensity", "measure-map", "measurable-equivalence", "density-transport"],
    saldUse := "Chewi MEAS/PATH root: transport explicit densities through coordinate changes such as product coordinates to EuclideanSpace cylinders",
    note := "Generic Mathlib-ready transport leaf; it keeps density pushforward separate from any Gaussian or path-space theorem."
  },
  {
    key := "measure.rn-deriv.reconstruction",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym.withDensity_rnDeriv_eq_of_absolutelyContinuous",
    upstreamDecl := "Measure.withDensity_rnDeriv_eq",
    upstreamFile := "Mathlib.MeasureTheory.Measure.Decomposition.RadonNikodym",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Radon-Nikodym", "withDensity", "absolute-continuity"],
    saldUse := "Chewi DENS/MEAS root for recognizing supplied density/RN derivative representations",
    note := "Thin Mathlib-facing RN reconstruction leaf."
  },
  {
    key := "measure.gibbs-density.pointwise-positive-finite",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal_pos",
    upstreamDecl := "ENNReal.ofReal_pos / ENNReal.ofReal_lt_top / Real.exp_pos",
    upstreamFile := "Mathlib.Data.ENNReal.Real; Mathlib.Analysis.SpecialFunctions.Exp",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "density", "positivity", "ENNReal"],
    saldUse := "Chewi DENS/MEAS root: expose positivity and finiteness of the Gibbs shape before integral contracts",
    note := "Companion finite-value theorem is `gibbsDensityENNReal_lt_top`; integral nonzero remains a measure-level hypothesis."
  },
  {
    key := "measure.gibbs-density.aemeasurable",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs.aemeasurable_gibbsDensityENNReal",
    upstreamDecl := "Real.measurable_exp / AEMeasurable.ennreal_ofReal",
    upstreamFile := "Mathlib.MeasureTheory.Function.SpecialFunctions.Basic; Mathlib.MeasureTheory.Constructions.BorelSpace.Real",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "density", "measurability", "ENNReal"],
    saldUse := "Chewi DENS/MEAS root: turn a measurable/a.e.-measurable potential into a measurable Gibbs density",
    note := "Keeps the measurable potential contract separate from convexity and integrability."
  },
  {
    key := "measure.gibbs-density.normalized-probability",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs.isProbabilityMeasure_withDensity_normalized_gibbs",
    upstreamDecl := "isProbabilityMeasure_withDensity_normalized_lintegral",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym; Mathlib.MeasureTheory.Measure.WithDensity",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "withDensity", "normalization", "probability-measure"],
    saldUse := "Chewi DENS/MEAS root: construct normalized Gibbs target measures once finite nonzero integral contracts are supplied",
    note := "First concrete Gibbs-density bridge; still does not prove coercivity or integrability of a specific potential."
  },
  {
    key := "measure.gibbs-density.integral-nonzero",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs.lintegral_gibbsDensityENNReal_ne_zero",
    upstreamDecl := "lintegral_eq_zero_iff' / Filter.eventually_false_iff_eq_bot / Real.exp_pos",
    upstreamFile := "Mathlib.MeasureTheory.Integral.Lebesgue.Basic; Mathlib.Order.Filter.Basic",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "density", "lintegral", "nonzero"],
    saldUse := "Chewi DENS/MEAS root: discharge the nonzero half of a Gibbs normalization constant over a nonzero base measure",
    note := "Requires a.e.-measurable potential and nonzero base measure; no growth or finiteness assumption is used."
  },
  {
    key := "measure.gibbs-density.integral-finite-envelope",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs.lintegral_gibbsDensityENNReal_ne_top_of_ae_le",
    upstreamDecl := "lintegral_mono_ae / ne_top_of_le_ne_top",
    upstreamFile := "Mathlib.MeasureTheory.Integral.Lebesgue.Basic",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "density", "lintegral", "envelope", "finite"],
    saldUse := "Chewi DENS/MEAS root: reduce Gibbs integrability to a finite ENNReal envelope",
    note := "This is the target interface for later coercivity, tail, or quadratic-growth leaves."
  },
  {
    key := "measure.gibbs-density.potential-envelope-pointwise",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs.gibbsDensityENNReal_le_of_potential_ge",
    upstreamDecl := "Real.exp_le_exp / ENNReal.ofReal_le_ofReal",
    upstreamFile := "Mathlib.MeasureTheory.Function.SpecialFunctions.Basic; Mathlib.Data.ENNReal.Real",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "density", "potential", "envelope", "monotonicity"],
    saldUse := "Chewi DENS/CONV root: turn a potential lower bound into a pointwise density envelope",
    note := "If `W ≤ V`, then `exp (-V) ≤ exp (-W)` as an ENNReal density."
  },
  {
    key := "measure.gibbs-density.integral-finite-potential-envelope",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs.lintegral_gibbsDensityENNReal_ne_top_of_ae_potential_ge",
    upstreamDecl := "gibbsDensityENNReal_ae_le_of_ae_potential_ge / lintegral_gibbsDensityENNReal_ne_top_of_ae_le",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs; Mathlib.MeasureTheory.Integral.Lebesgue.Basic",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "density", "potential", "lintegral", "envelope", "finite"],
    saldUse := "Chewi DENS/CONV root: prove finite normalization for `V` from an integrable lower-potential envelope `W`",
    note := "This is the compiled intermediate target before concrete coercivity or tail-growth leaves."
  },
  {
    key := "measure.gibbs-density.finite-measure-lower-bound",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs.isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_ge_const",
    upstreamDecl := "lintegral_const_lt_top / lintegral_gibbsDensityENNReal_ne_top_of_ae_le / lintegral_gibbsDensityENNReal_ne_zero",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs; Mathlib.MeasureTheory.Integral.Lebesgue.Basic",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "density", "finite-measure", "lower-bound", "normalization", "compact-domain"],
    saldUse := "Chewi DENS/CONV root: normalize Gibbs laws on finite or truncated base measures from a measurable potential with an a.e. constant lower bound",
    note := "Concrete compact-domain envelope leaf; full Lebesgue coercivity/growth tail integrability remains a separate analytic theorem."
  },
  {
    key := "measure.gibbs-density.normalized-probability-envelope",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs.isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_le",
    upstreamDecl := "lintegral_gibbsDensityENNReal_ne_zero / lintegral_gibbsDensityENNReal_ne_top_of_ae_le",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs; Mathlib.MeasureTheory.Measure.WithDensity",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "withDensity", "normalization", "envelope", "probability-measure"],
    saldUse := "Chewi DENS/MEAS root: turn a measurable potential plus finite envelope into a normalized Gibbs probability measure",
    note := "Keeps coercivity/growth work isolated as the proof of the envelope bound."
  },
  {
    key := "measure.gibbs-density.normalized-probability-potential-envelope",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs.isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_potential_ge",
    upstreamDecl := "lintegral_gibbsDensityENNReal_ne_zero / lintegral_gibbsDensityENNReal_ne_top_of_ae_potential_ge",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs; Mathlib.MeasureTheory.Measure.WithDensity",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "withDensity", "potential", "normalization", "envelope", "probability-measure"],
    saldUse := "Chewi DENS/CONV root: construct the normalized target law once a lower-potential integrable envelope is supplied",
    note := "Useful for Chewi coercivity/growth proofs because the analytic tail estimate only has to provide `W ≤ V` and finite integral for `exp(-W)`."
  }
]


def stochasticProcessMemory : List LemmaMemoryEntry := [
  {
    key := "weak-generator.sample-to-law-derivative",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.WeakGenerator.weakGeneratorFromSampleDerivative",
    upstreamDecl := "law-map integral rewrite plus supplied Ito-generator derivative",
    upstreamFile := "Mathlib Measure.map / ASTIS lawIntegralHasDerivAtOfMeasureMapEqAndSample",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["weak-generator", "weak-FP", "law-map", "HasDerivAt", "SDE"],
    saldUse := "rewrite frozen EM/Ito sample-space weak-test derivative into a named law-level weak-generator identity",
    note := "Pro-assimilated leaf: does not prove Ito, density PDE, or conditional drift construction."
  },
  {
    key := "fokker-planck.scalar-divergence-rewrite",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FokkerPlanckAlgebra.fpRewriteScalarAlgebra",
    upstreamDecl := "elementary scalar algebra after supplied FP/divergence identities",
    upstreamFile := "local Mathlib ring proof",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["weak-FP", "Fokker-Planck", "scalar-algebra", "divergence"],
    saldUse := "post-process supplied weak FP and score-split identities before Fisher/IBP handoff",
    note := "Small Mathlib-ready algebra leaf; analytic PDE hypotheses remain explicit contracts."
  },
  {
    key := "fisher.ibp.scalar-algebra",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FokkerPlanckAlgebra.fisherIbpAlgebra",
    upstreamDecl := "elementary scalar algebra after supplied IBP identities",
    upstreamFile := "local Mathlib ring proof",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Fisher-information", "IBP", "scalar-algebra"],
    saldUse := "combine two no-boundary IBP identities into the Fisher/cross-term display",
    note := "Small Mathlib-ready algebra leaf; no-boundary/divergence theorem remains a separate analytic contract."
  },
  {
    key := "girsanov.finite-gaussian-cylinder-integral",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Girsanov.finiteGaussianGirsanovCylinderIntegral",
    upstreamDecl := "stdGaussian_shift_integral_map_toLp / finite-dimensional Gaussian Esscher",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian; Chewi finite-dimensional Girsanov cylinder route",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Girsanov", "Gaussian", "cylindrical", "path-space", "change-of-measure"],
    saldUse := "Chewi PATH root: package the finite-dimensional Gaussian change-of-measure as a cylindrical Girsanov likelihood ratio before full Brownian path-space RN derivatives",
    note := "Compiled finite-dimensional PATH-facing wrapper; does not assert filtrations, martingales, Novikov, Ito, or continuous-time Brownian path-space Girsanov."
  },
  {
    key := "girsanov.finite-gaussian-cylinder-rn-density",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Girsanov.finiteGaussianGirsanovCylinderMeasure_eq_withDensity",
    upstreamDecl := "measurableEquiv_map_withDensity / pi_gaussianReal_withDensity_exp_shift / map_pi_eq_stdGaussian",
    upstreamFile := "AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym; AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Girsanov", "Radon-Nikodym", "withDensity", "Gaussian", "cylindrical", "path-space"],
    saldUse := "Chewi PATH root: identify the finite-dimensional cylindrical shifted Gaussian path measure as a withDensity tilt of centered stdGaussian",
    note := "Measure-level RN-style finite-dimensional Girsanov identity; full Brownian path-space RN derivative remains a separate analytic theorem."
  }
]

def klDensityMemory : List LemmaMemoryEntry := [
  {
    key := "kl-density.pointwise-derivative-simplify",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.InformationTheory.KLDensity.klPointwiseDerivSimplify",
    upstreamDecl := "pointwise real-field algebra for d/ds q log(q/p)",
    upstreamFile := "local Mathlib field_simp/ring proof",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["KL", "density", "log", "pointwise-algebra"],
    saldUse := "separate KL density derivative algebra from dominated differentiation and density regularity assumptions",
    note := "Pro-assimilated leaf; positivity/nonzero and domination stay explicit."
  },
  {
    key := "kl-density.remove-mass-term",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.InformationTheory.KLDensity.klDerivativeRemoveMassTerm",
    upstreamDecl := "mass-conservation derivative simplification",
    upstreamFile := "local Mathlib HasDerivAt congruence/simp proof",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["KL", "density", "mass-conservation", "HasDerivAt"],
    saldUse := "remove the integral qdot term in KL differentiation after mass conservation is supplied",
    note := "Small derivative-target rewrite; mass conservation itself remains a separate theorem or hypothesis."
  }
]

def renyiDensityMemory : List LemmaMemoryEntry := [
  {
    key := "renyi-density.integrand-positivity",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.InformationTheory.Renyi.renyiIntegrand_pos",
    upstreamDecl := "Real.rpow_pos_of_pos / Real.rpow_nonneg",
    upstreamFile := "Mathlib.Analysis.SpecialFunctions.Pow.Real",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Renyi", "density", "positivity", "rpow"],
    saldUse := "Chewi DENS/FI root: expose Renyi integrand positivity before integral and derivative contracts",
    note := "Companion nonnegative theorem is `renyiIntegrand_nonneg`; full Renyi divergence remains separate."
  },
  {
    key := "renyi-density.integrand-measurable",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.InformationTheory.Renyi.measurable_renyiIntegrandENNReal",
    upstreamDecl := "Real.continuous_rpow_const / Measurable.ennreal_ofReal",
    upstreamFile := "Mathlib.Analysis.SpecialFunctions.Pow.Continuity; Mathlib.MeasureTheory.Constructions.BorelSpace.Real",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Renyi", "density", "measurability", "ENNReal"],
    saldUse := "Chewi DENS/FI root: turn measurable density representatives into a measurable Renyi lintegrand",
    note := "Requires order `a ∈ [0,1]`; representative choice and absolute continuity stay explicit."
  },
  {
    key := "renyi-density.integral-finite-envelope",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.InformationTheory.Renyi.lintegral_renyiIntegrandENNReal_ne_top_of_ae_le",
    upstreamDecl := "lintegral_mono_ae / ne_top_of_le_ne_top",
    upstreamFile := "Mathlib.MeasureTheory.Integral.Lebesgue.Basic",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Renyi", "density", "lintegral", "envelope", "finite"],
    saldUse := "Chewi DENS/FI root: reduce Renyi integrability to a finite ENNReal envelope",
    note := "This mirrors the Gibbs finite-envelope contract and keeps tail/domination estimates outside the algebra leaf."
  },
  {
    key := "renyi-density.pointwise-derivative",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.InformationTheory.Renyi.hasDerivAt_renyiIntegrand",
    upstreamDecl := "HasDerivAt.rpow_const / HasDerivAt.mul",
    upstreamFile := "Mathlib.Analysis.SpecialFunctions.Pow.Deriv",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Renyi", "density", "pointwise-derivative", "rpow"],
    saldUse := "Chewi chapter 6 root: isolate pointwise Renyi derivative algebra before dominated differentiation under the integral",
    note := "Positivity/nonzero, domination, and path-space regularity remain explicit source contracts."
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

def geometryMemory : List LemmaMemoryEntry := [
  {
    key := "geometry.log-concavity.def",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn",
    upstreamDecl := "ConcaveOn / strictConcaveOn_log_Ioi",
    upstreamFile := "Mathlib.Analysis.Convex.Function; Mathlib.Analysis.Convex.SpecificFunctions.Basic",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "log-concavity", "convex-analysis", "density"],
    saldUse := "Chewi CONV/DENS root: shared definition for positive density log-concavity leaves",
    note := "Small ASTIS-owned wrapper around Mathlib ConcaveOn with explicit positivity."
  },
  {
    key := "geometry.log-concavity.positive-ray-id",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_id_Ioi",
    upstreamDecl := "strictConcaveOn_log_Ioi",
    upstreamFile := "Mathlib.Analysis.Convex.SpecificFunctions.Basic",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "log-concavity", "positive-ray", "convex-analysis"],
    saldUse := "Chewi CONV sanity leaf before density/Gibbs and Prekopa--Leindler ports",
    note := "Compiled one-dimensional leaf reusing Mathlib's strict concavity of log."
  },
  {
    key := "geometry.log-concavity.positive-rescale",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity.LogConcaveOn.const_mul",
    upstreamDecl := "ConcaveOn.add / Real.log_mul",
    upstreamFile := "Mathlib.Analysis.Convex.Function; Mathlib.Analysis.SpecialFunctions.Log.Basic",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "log-concavity", "normalization", "density"],
    saldUse := "Chewi DENS/CONV root: keep normalized-density positive constants out of later convexity proofs",
    note := "Separates positive scalar normalization from measure/integral normalization."
  },
  {
    key := "geometry.gibbs-density.convex-potential",
    localDecl := "AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity.logConcaveOn_const_mul_exp_neg_of_convexOn",
    upstreamDecl := "ConvexOn.neg / Real.log_exp",
    upstreamFile := "Mathlib.Analysis.Convex.Function; Mathlib.Analysis.SpecialFunctions.Log.Basic",
    status := LemmaMemoryStatus.formalizedLocal,
    tags := ["Chewi", "Gibbs", "convex-potential", "log-concavity", "density"],
    saldUse := "Chewi DENS/CONV root for Gibbs target densities before withDensity normalization",
    note := "Compiled convex-analytic Gibbs leaf; no measure normalization or integrability is claimed."
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
  analysisMemory ++ gaussianMemory ++ taylorMemory ++ measureMemory ++ stochasticProcessMemory ++
    klDensityMemory ++ renyiDensityMemory ++ variationalMemory ++ geometryMemory ++
    saldExtractedMemory ++ portQueueMemory

def formalizedTechnicalLemmaCount : Nat :=
  (technicalLemmaMemory.filter fun entry =>
    entry.status == LemmaMemoryStatus.formalizedLocal).length

end TechnicalLemmas
end AutoSamplingTheory
