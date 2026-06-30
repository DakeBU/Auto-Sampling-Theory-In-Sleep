# ASTIS Lean Leaf Module Graph

This is the textual ledger behind `docs/module-graph.svg`.  The graph itself
shows only canonical ASTIS-owned Lean modules that are currently treated as the
Mathlib-ready SDE/Sampling proof-weapon library: compiled reusable leaves and
their parent import surfaces.

The graph is intentionally organized like a Lean module map, following the
style of the public QuantumComputing module graph.  Paper consumers, registry
metadata, compatibility files, and external references are not main graph
nodes.  They are documented below so the reusable arsenal stays visible at a
glance.

![ASTIS module graph](../../docs/module-graph.svg)

## Public Module Tree

```text
Main graph tree:

AutoSamplingTheory
|-- Probability.lean                  shared probability adapter surface
|-- TechnicalLemmas.lean              parent import surface for reusable lemmas
`-- TechnicalLemmas/
    |-- Analysis.lean                 parent for reusable analysis leaves
    |-- Analysis/
    |   |-- Calculus.lean             parent for calculus leaves
    |   `-- Calculus/
    |       `-- Taylor.lean           Mathlib-style Taylor/Hessian leaves
    |-- Probability.lean              parent for probability technical lemmas
    |-- Probability/
    |   |-- LawMap.lean               pushforward-law and weak-test rewrites
    |   `-- ConditionalKernel.lean    condDistrib and conditional-integral leaves
    |-- ProbabilityDistributions.lean parent for distribution-specific leaves
    |-- ProbabilityDistributions/
    |   `-- Gaussian.lean             Mathlib-style Gaussian coordinate leaves
    |-- Measure/
    |   |-- Gibbs.lean                ENNReal Gibbs density and normalization bridge
    |   `-- RadonNikodym.lean         withDensity, density transport, and RN normalization leaves
    |-- Geometry.lean                 parent for convex-geometric leaves
    |-- Geometry/
    |   `-- LogConcavity.lean         positive log-concavity API leaves
    |-- StochasticProcesses.lean      parent for SDE/weak-generator leaves
    |-- StochasticProcesses/
    |   |-- WeakGenerator.lean        sample-to-law weak-generator rewrites
    |   |-- FokkerPlanckAlgebra.lean  FP split and Fisher/IBP algebra leaves
    |   `-- Girsanov.lean             finite-dimensional cylindrical change-of-measure leaves
    |-- InformationTheory.lean        parent for KL/DV/Renyi/entropy leaves
    |-- InformationTheory/
    |   |-- DonskerVaradhan.lean      one-sided DV and energy bounds
    |   |-- KLDensity.lean            KL density derivative algebra leaves
    |   `-- Renyi.lean                Renyi integrand and derivative leaves
    |-- FunctionalInequalities.lean   parent for LSI/FI/PI-style leaves
    `-- FunctionalInequalities/
        `-- LogSobolev.lean           LSI-to-KL/FI bookkeeping leaves

Compatibility surfaces not shown in the main graph:
|-- TechnicalLemmas/Gaussian.lean
|-- TechnicalLemmas/Taylor.lean
|-- TechnicalLemmas/Measure.lean
`-- TechnicalLemmas/Variational.lean

Non-arsenal files documented separately:
|-- Core.lean, SDE.lean, Automation.lean, Literature.lean, OpenProblems.lean
|-- TechnicalLemmas/Registry.lean
|-- TechnicalLemmas/SALDExtracted.lean
|-- SALD.lean
`-- RMFLD.lean
```

## Chewi-Oriented Planned Extension

`ASTIS-CHEWI-001` extends the library goal from SALD-specific backfill to a
Chewi-led log-concave sampling foundation.  `Geometry.LogConcavity` now has
the first compiled leaves; the remaining planned modules are not callable
until they contain ASTIS-owned compiled declarations, but they define the
intended scientific organization for new leaves:

```text
Planned Chewi extension:

AutoSamplingTheory
`-- TechnicalLemmas/
    |-- Measure/
    |   |-- Transport.lean
    |   |-- Gibbs.lean
    |   `-- RadonNikodym.lean
    |-- Geometry/
    |   |-- Convex.lean
    |   |-- LogConcavity.lean  compiled core API; extend toward density/Gibbs leaves
    |   `-- PrekopaLeindler.lean
    |-- FunctionalInequalities/
    |   |-- Poincare.lean
    |   |-- Transport.lean
    |   `-- Isoperimetry.lean
    |-- StochasticProcesses/
    |   |-- MarkovSemigroup.lean
    |   |-- Ito.lean
    |   |-- Langevin.lean
    |   |-- Girsanov.lean
    |   |-- DoobTransform.lean
    |   `-- FollmerDrift.lean
    `-- SamplingAlgorithms/
        |-- LangevinMonteCarlo.lean
        |-- RandomizedMidpoint.lean
        |-- HamiltonianMonteCarlo.lean
        |-- UnderdampedLangevin.lean
        |-- MetropolisAdjustedLangevin.lean
        `-- ProximalSampler.lean
```

New modules should be added only when a small, source-anchored leaf is ready.
The next expected expansion is density-aware log-concavity and
Prekopa-Leindler support, with Mathlib searched first and
`Lean-Asymptotic-Statistical-Theory` used as an external reference project.

## Canonical Compiled Module And Leaf Families

| Module | File | Layer | Purpose | Representative compiled leaves/exports | Curated memory entries | Mathlib-quality status |
| --- | --- | --- | --- | --- | --- | --- |
| `AutoSamplingTheory.Probability` | `AutoSamplingTheory/Probability.lean` | generic technical core | law-map rewrites, dominated law derivatives, conditional-law bridges, KL/DV/LSI bookkeeping | `lawMapEqOfAEEq`, `lawMapIntegral`, `lawMapIntegralHasDerivAtOfSample`, `lawIntegralHasDerivAtOfMeasureMapEqAndSample`, `lawMapIntegralHasDerivAtOfDominated`, `lawIntegralHasDerivAtOfMeasureMapEqAndDominated`, `lawMapProdEqOfAEEq`, `lawMapProdFst`, ... | 0 | main Mathlib-ready adapter surface after naming/generalization cleanup |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Taylor.lean` | Mathlib-ready technical lemma | Hessian/operator norm bridges, orthonormal-basis units, quadratic normalization | `hessianOpNormOfSourceHessianField`, `iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm`, `quadraticVariationNormalizationOfCoeffDefAndVarianceOne`, `stdOrthonormalBasisUnit` | 3 | preferred Mathlib-style location for Ito/Taylor local-error leaves |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus.lean` | Mathlib-ready technical lemma | parent import surface for calculus leaves used by SDE/Sampling proofs | exports/metadata only | 0 | preferred parent module for Taylor and Hessian leaves |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Integrability.lean` | Mathlib-ready technical lemma | ofReal lintegral/Integrable bridge, finite-dimensional Gaussian quadratic-tail integrability, and quadratic lower-bound Gibbs normalization leaves | `lintegral_ofReal_ne_top_of_integrable_nonneg`, `integrable_exp_neg_mul_norm_sq`, `integrable_exp_neg_add_mul_norm_sq`, `lintegral_exp_neg_add_mul_norm_sq_ne_top`, `lintegral_gibbsDensityENNReal_ne_top_of_ae_quadratic_lower_bound`, `isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_quadratic_lower_bound` | 5 | preferred Mathlib-style location for Lebesgue tail and coercive-envelope leaves |
| `AutoSamplingTheory.TechnicalLemmas.Analysis` | `AutoSamplingTheory/TechnicalLemmas/Analysis.lean` | Mathlib-ready technical lemma | parent import surface for reusable analysis and integrability leaves | exports/metadata only | 0 | preferred parent module for calculus, integrability, regularity, and future IBP leaves |
| `AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.LogSobolev` | `AutoSamplingTheory/TechnicalLemmas/FunctionalInequalities/LogSobolev.lean` | Mathlib-ready technical lemma | log-Sobolev to KL/FI bookkeeping leaves | `lsiKlFiRnDerivDensityMassOne`, `lsiKlFiRnDerivEntropyIntegral`, `lsiKlFiRnDerivLIntegralMassOne`, `lsiKlFiSqrtDensityEntropyIntegrandScalar`, `lsiKlFiSqrtDensityFisherChainFiniteSumHandoffScalar`, `lsiKlFiSqrtDensityFisherChainFiniteSumScalar`, `lsiKlFiSqrtDensityFisherChainIntegralFiniteSum`, `lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar`, ... | 1 | preferred Mathlib-style location for LSI/FI bookkeeping leaves |
| `AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities` | `AutoSamplingTheory/TechnicalLemmas/FunctionalInequalities.lean` | Mathlib-ready technical lemma | parent import surface for LSI/FI/PI-style technical lemmas | exports/metadata only | 0 | preferred parent module for functional-inequality leaves |
| `AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity` | `AutoSamplingTheory/TechnicalLemmas/Geometry/LogConcavity.lean` | Mathlib-ready technical lemma | positive-function log-concavity API over Mathlib ConcaveOn | `LogConcaveOn`, `logConcaveOn_iff`, `logConcaveOn_of_concave_log`, `LogConcaveOn.pos`, `LogConcaveOn.concaveOn_log`, `LogConcaveOn.convex_domain`, `LogConcaveOn.subset`, `LogConcaveOn.const_mul`, ... | 4 | first compiled Chewi CONV/DENS leaf; extend toward density and Prekopa-Leindler interfaces |
| `AutoSamplingTheory.TechnicalLemmas.Geometry` | `AutoSamplingTheory/TechnicalLemmas/Geometry.lean` | Mathlib-ready technical lemma | parent import surface for convex-geometric and log-concavity leaves | exports/metadata only | 0 | preferred parent module for Chewi CONV/DENS roots |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.DonskerVaradhan` | `AutoSamplingTheory/TechnicalLemmas/InformationTheory/DonskerVaradhan.lean` | Mathlib-ready technical lemma | Donsker--Varadhan one-sided and scaled-test energy leaves | `dvFiniteLogMgfOfLeAlpha`, `dvVariationalOneSidedConsequenceScalar`, `dvVariationalOneSidedFromSupremumScalar`, `dvVariationalOneSidedOfScaledTest`, `dvVariationalOneSidedOfTiltedRight`, `dvVariationalScaledTestEnergyBound`, `dvVariationalScaledTestEnergyBoundWithCoeff`, `dvVariationalTiltedRightOneSidedConsequence` | 1 | preferred Mathlib-style location for DV/KL energy leaves |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.KLDensity` | `AutoSamplingTheory/TechnicalLemmas/InformationTheory/KLDensity.lean` | Mathlib-ready technical lemma | KL-density pointwise derivative and mass-conservation algebra leaves | `klPointwiseDerivSimplify`, `klDerivativeRemoveMassTerm` | 2 | preferred Mathlib-style location for KL density algebra after analytic domination is supplied |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.Renyi` | `AutoSamplingTheory/TechnicalLemmas/InformationTheory/Renyi.lean` | Mathlib-ready technical lemma | Renyi density integrand positivity, measurability, finite-envelope, and pointwise derivative algebra leaves | `renyiIntegrand`, `renyiIntegrandENNReal`, `renyiIntegrand_nonneg`, `renyiIntegrand_pos`, `measurable_renyiIntegrand`, `measurable_renyiIntegrandENNReal`, `lintegral_renyiIntegrandENNReal_ne_top_of_ae_le`, `hasDerivAt_renyiIntegrand` | 4 | preferred Mathlib-style location for Renyi density algebra before integral/path regularity contracts |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory` | `AutoSamplingTheory/TechnicalLemmas/InformationTheory.lean` | Mathlib-ready technical lemma | parent import surface for KL/DV/Renyi/entropy technical lemmas | exports/metadata only | 0 | preferred parent module for information-theoretic leaves |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean` | Mathlib-ready technical lemma | ENNReal Gibbs density, positivity/finite-value, measurability, nonzero/finite-by-envelope, potential-envelope, and finite-measure lower-bound integral contracts, plus normalized withDensity probability bridges | `gibbsDensityENNReal`, `gibbsDensityENNReal_pos`, `gibbsDensityENNReal_lt_top`, `measurable_gibbsDensityENNReal`, `aemeasurable_gibbsDensityENNReal`, `lintegral_gibbsDensityENNReal_ne_zero`, `lintegral_gibbsDensityENNReal_ne_top_of_ae_le`, `gibbsDensityENNReal_le_of_potential_ge`, ... | 10 | preferred Mathlib-style location for Chewi Gibbs target-measure wrappers |
| `AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean` | Mathlib-ready technical lemma | withDensity mass, reciprocal-lintegral normalization, finite-pi product density decomposition, measurable-equivalence density transport, absolute-continuity, and RN reconstruction wrappers | `lintegral_fin_nat_prod_eq_prod`, `lintegral_fintype_prod_eq_prod`, `pi_withDensity_prod`, `withDensity_univ_eq_lintegral`, `isProbabilityMeasure_withDensity_of_lintegral_eq_one`, `isFiniteMeasure_withDensity_of_lintegral_ne_top`, `lintegral_inv_lintegral_mul_eq_one`, `isProbabilityMeasure_withDensity_normalized_lintegral`, ... | 8 | preferred Mathlib-style location for density normalization and RN derivative leaves |
| `AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel` | `AutoSamplingTheory/TechnicalLemmas/Probability/ConditionalKernel.lean` | Mathlib-ready technical lemma | condDistrib/condExpKernel bridges and conditional-integral regularity leaves | `condDistribIntegralNamedFieldIntegral`, `condDistribAeEqCondExpKernelMap`, `condDistribIntegralAEStronglyMeasurable`, `condDistribIntegralIntegrable`, `condDistribIntegralMapAEStronglyMeasurable`, `condDistribIntegralMapIntegrable`, `condDistribIntegralMapIntegral`, `condDistribIntegralNamedFieldRegularity`, ... | 2 | preferred Mathlib-style location for conditional-kernel leaves |
| `AutoSamplingTheory.TechnicalLemmas.Probability.LawMap` | `AutoSamplingTheory/TechnicalLemmas/Probability/LawMap.lean` | Mathlib-ready technical lemma | pushforward law, weak-test integral, and dominated derivative transport leaves | `lawIntegralHasDerivAtOfMeasureMapEqAndDominated`, `lawIntegralHasDerivAtOfMeasureMapEqAndSample`, `lawMapEqOfAEEq`, `lawMapIntegral`, `lawMapIntegralHasDerivAtOfDominated`, `lawMapIntegralHasDerivAtOfSample`, `lawMapProdEqOfAEEq`, `lawMapProdFst`, ... | 2 | preferred Mathlib-style location for law-map leaves |
| `AutoSamplingTheory.TechnicalLemmas.Probability` | `AutoSamplingTheory/TechnicalLemmas/Probability.lean` | Mathlib-ready technical lemma | parent import surface for probability technical lemmas | exports/metadata only | 0 | preferred parent module for law-map and conditional-kernel leaves |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean` | Mathlib-ready technical lemma | Gaussian coordinate laws, finite linear-form integrability/mean-zero, product MGF normalizers, Esscher shifted densities/change-of-measure, EuclideanSpace/stdGaussian change-of-measure bridges, and variance-one packaging | `gaussianReal_withDensity_exp_shift`, `inner_toLp_toLp_eq_sum_mul`, `integrable_const_mul_eval_stdGaussianPi`, `integrable_const_mul_sq_gaussianReal_zero`, `integrable_eval_stdGaussianPi`, `integrable_linearForm_stdGaussianPi`, `integrable_sq_eval_stdGaussianPi`, `integral_const_mul_eval_stdGaussianPi`, ... | 15 | preferred Mathlib-style location for Gaussian/Brownian increment leaves |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions` | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions.lean` | Mathlib-ready technical lemma | parent import surface for distribution-specific reusable leaves | exports/metadata only | 0 | preferred parent module for Gaussian and future Gamma/Ornstein--Uhlenbeck distribution leaves |
| `AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FokkerPlanckAlgebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/FokkerPlanckAlgebra.lean` | Mathlib-ready technical lemma | Fokker--Planck split and Fisher/IBP scalar algebra leaves | `fpRewriteScalarAlgebra`, `fisherIbpAlgebra` | 2 | preferred Mathlib-style location for weak FP and Fisher algebra handoffs |
| `AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Girsanov` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean` | Mathlib-ready technical lemma | finite-dimensional cylindrical Gaussian Girsanov weight, RN/withDensity identity, change-of-measure, and normalization leaves | `finiteShiftedGaussianPathMeasure`, `finiteGaussianGirsanovWeight`, `finiteGaussianGirsanovCylinderIntegral`, `finiteGaussianGirsanovCylinderMeasure_eq_withDensity`, `integral_finiteGaussianGirsanovWeight_eq_one` | 2 | preferred Mathlib-style location for PATH change-of-measure bridge leaves |
| `AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.WeakGenerator` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/WeakGenerator.lean` | Mathlib-ready technical lemma | sample-space generator derivative to named law weak-generator rewrite | `weakGeneratorFromSampleDerivative` | 1 | preferred Mathlib-style location for weak FP generator bridge leaves |
| `AutoSamplingTheory.TechnicalLemmas.StochasticProcesses` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses.lean` | Mathlib-ready technical lemma | parent import surface for weak-generator, Fokker--Planck algebra, and finite-dimensional Girsanov cylinder leaves | exports/metadata only | 0 | preferred parent module for SDE/Sampling stochastic-process leaves |
| `AutoSamplingTheory.TechnicalLemmas` | `AutoSamplingTheory/TechnicalLemmas.lean` | Mathlib-ready technical lemma | parent import surface for reusable ASTIS-owned technical lemmas | exports/metadata only | 0 | public import surface for the Mathlib-ready arsenal; excludes SALDExtracted quarantine |

## Mathlib-Ready Callable Arsenal

The table below is generated from
`AutoSamplingTheory/TechnicalLemmas/Registry.lean`.  These are the currently
compiled local entries that agents may retrieve as proven technical lemma
memory for future Mathlib-style cleanup.  External Lean projects may motivate
a row, but the callable proof is the ASTIS-owned declaration listed here.

| Module | Memory key | Local declaration | Upstream or source orientation |
| --- | --- | --- | --- |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor` | `taylor.hessian.source-field-to-opnorm` | `hessianOpNormOfSourceHessianField` | SLT/GaussianPoincare/TaylorBound.lean |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor` | `taylor.fderiv-hessian-to-iterated` | `iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm` | SLT/GaussianPoincare/TaylorBound.lean |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor` | `brownian.quadratic-variation-normalization` | `quadraticVariationNormalizationOfCoeffDefAndVarianceOne` | ASTIS/SALD cycles 174-176 |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability` | `analysis.integrability.of-real-lintegral-finite` | `lintegral_ofReal_ne_top_of_integrable_nonneg` | Mathlib.MeasureTheory.Function.L1Space.Integrable |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability` | `analysis.integrability.gaussian-quadratic-tail` | `integrable_exp_neg_mul_norm_sq` | Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability` | `analysis.integrability.shifted-gaussian-quadratic-tail` | `integrable_exp_neg_add_mul_norm_sq` | AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability` | `measure.gibbs-density.integral-finite-quadratic-lower-bound` | `lintegral_gibbsDensityENNReal_ne_top_of_ae_quadratic_lower_bound` | AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability; AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability` | `measure.gibbs-density.normalized-probability-quadratic-lower-bound` | `isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_quadratic_lower_bound` | AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability; AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs |
| `AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.LogSobolev` | `lsi.sqrt-density.fisher-chain` | `lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar` | Mathlib/SLT-inspired entropy and LSI proof shape |
| `AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity` | `geometry.log-concavity.def` | `LogConcaveOn` | Mathlib.Analysis.Convex.Function; Mathlib.Analysis.Convex.SpecificFunctions.Basic |
| `AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity` | `geometry.log-concavity.positive-ray-id` | `logConcaveOn_id_Ioi` | Mathlib.Analysis.Convex.SpecificFunctions.Basic |
| `AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity` | `geometry.log-concavity.positive-rescale` | `const_mul` | Mathlib.Analysis.Convex.Function; Mathlib.Analysis.SpecialFunctions.Log.Basic |
| `AutoSamplingTheory.TechnicalLemmas.Geometry.LogConcavity` | `geometry.gibbs-density.convex-potential` | `logConcaveOn_const_mul_exp_neg_of_convexOn` | Mathlib.Analysis.Convex.Function; Mathlib.Analysis.SpecialFunctions.Log.Basic |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.DonskerVaradhan` | `dv.scaled-test.energy-bound` | `dvVariationalScaledTestEnergyBound` | Boucheron-style cited result / future SLT entropy-duality port |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.KLDensity` | `kl-density.pointwise-derivative-simplify` | `klPointwiseDerivSimplify` | local Mathlib field_simp/ring proof |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.KLDensity` | `kl-density.remove-mass-term` | `klDerivativeRemoveMassTerm` | local Mathlib HasDerivAt congruence/simp proof |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.Renyi` | `renyi-density.integrand-positivity` | `renyiIntegrand_pos` | Mathlib.Analysis.SpecialFunctions.Pow.Real |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.Renyi` | `renyi-density.integrand-measurable` | `measurable_renyiIntegrandENNReal` | Mathlib.Analysis.SpecialFunctions.Pow.Continuity; Mathlib.MeasureTheory.Constructions.BorelSpace.Real |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.Renyi` | `renyi-density.integral-finite-envelope` | `lintegral_renyiIntegrandENNReal_ne_top_of_ae_le` | Mathlib.MeasureTheory.Integral.Lebesgue.Basic |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.Renyi` | `renyi-density.pointwise-derivative` | `hasDerivAt_renyiIntegrand` | Mathlib.Analysis.SpecialFunctions.Pow.Deriv |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `measure.gibbs-density.pointwise-positive-finite` | `gibbsDensityENNReal_pos` | Mathlib.Data.ENNReal.Real; Mathlib.Analysis.SpecialFunctions.Exp |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `measure.gibbs-density.aemeasurable` | `aemeasurable_gibbsDensityENNReal` | Mathlib.MeasureTheory.Function.SpecialFunctions.Basic; Mathlib.MeasureTheory.Constructions.BorelSpace.Real |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `measure.gibbs-density.normalized-probability` | `isProbabilityMeasure_withDensity_normalized_gibbs` | AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym; Mathlib.MeasureTheory.Measure.WithDensity |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `measure.gibbs-density.integral-nonzero` | `lintegral_gibbsDensityENNReal_ne_zero` | Mathlib.MeasureTheory.Integral.Lebesgue.Basic; Mathlib.Order.Filter.Basic |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `measure.gibbs-density.integral-finite-envelope` | `lintegral_gibbsDensityENNReal_ne_top_of_ae_le` | Mathlib.MeasureTheory.Integral.Lebesgue.Basic |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `measure.gibbs-density.potential-envelope-pointwise` | `gibbsDensityENNReal_le_of_potential_ge` | Mathlib.MeasureTheory.Function.SpecialFunctions.Basic; Mathlib.Data.ENNReal.Real |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `measure.gibbs-density.integral-finite-potential-envelope` | `lintegral_gibbsDensityENNReal_ne_top_of_ae_potential_ge` | AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs; Mathlib.MeasureTheory.Integral.Lebesgue.Basic |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `measure.gibbs-density.finite-measure-lower-bound` | `isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_ge_const` | AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs; Mathlib.MeasureTheory.Integral.Lebesgue.Basic |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `measure.gibbs-density.normalized-probability-envelope` | `isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_le` | AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs; Mathlib.MeasureTheory.Measure.WithDensity |
| `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs` | `measure.gibbs-density.normalized-probability-potential-envelope` | `isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_potential_ge` | AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs; Mathlib.MeasureTheory.Measure.WithDensity |
| `AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym` | `measure.with-density.probability-normalization` | `isProbabilityMeasure_withDensity_of_lintegral_eq_one` | Mathlib.MeasureTheory.Measure.WithDensity; Mathlib.MeasureTheory.Measure.Typeclasses.Probability |
| `AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym` | `measure.density.normalized-lintegral-one` | `lintegral_inv_lintegral_mul_eq_one` | Mathlib.MeasureTheory.Integral.Lebesgue.Add; Mathlib.Data.ENNReal.Inv |
| `AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym` | `measure.with-density.normalized-probability` | `isProbabilityMeasure_withDensity_normalized_lintegral` | Mathlib.MeasureTheory.Measure.WithDensity; Mathlib.MeasureTheory.Integral.Lebesgue.Add |
| `AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym` | `measure.pi.lintegral-product-factorization` | `lintegral_fintype_prod_eq_prod` | Mathlib.MeasureTheory.Integral.Pi; external AST PiWithDensity.lean |
| `AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym` | `measure.pi.with-density-product` | `pi_withDensity_prod` | Mathlib.MeasureTheory.Measure.WithDensity; external AST PiWithDensity.lean |
| `AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym` | `measure.with-density.absolute-continuity` | `withDensity_absolutelyContinuous_base` | Mathlib.MeasureTheory.Measure.WithDensity |
| `AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym` | `measure.with-density.map-measurable-equiv` | `measurableEquiv_map_withDensity` | Mathlib.MeasureTheory.Integral.Lebesgue.Map; Mathlib.MeasureTheory.Measure.WithDensity |
| `AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym` | `measure.rn-deriv.reconstruction` | `withDensity_rnDeriv_eq_of_absolutelyContinuous` | Mathlib.MeasureTheory.Measure.Decomposition.RadonNikodym |
| `AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel` | `measure.conditional-distribution.integral` | `condDistribIntegralNamedLawIntegral` | Mathlib.Probability.Kernel.CondDistrib and Condexp |
| `AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel` | `conditional-kernel.named-field-integral` | `condDistribIntegralNamedFieldIntegral` | Mathlib.Probability.Kernel.CondDistrib and MeasureTheory integral APIs |
| `AutoSamplingTheory.TechnicalLemmas.Probability.LawMap` | `measure.law-map.integral` | `lawMapIntegral` | Mathlib measure/integration APIs |
| `AutoSamplingTheory.TechnicalLemmas.Probability.LawMap` | `measure.law-map.dominated-derivative` | `lawMapIntegralHasDerivAtOfDominated` | Mathlib.Analysis.Calculus.ParametricIntegral |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.coordinate-law` | `map_eval_stdGaussianPi` | SLT/GaussianMeasure.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.coordinate-integrable` | `integrable_eval_stdGaussianPi` | SLT/GaussianMeasure.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.coordinate-square-integrable` | `integrable_sq_eval_stdGaussianPi` | SLT/GaussianMeasure.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.linear-form-integrable` | `integrable_linearForm_stdGaussianPi` | Mathlib.MeasureTheory.Function.L1Space.Integrable; ASTIS Gaussian |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.coordinate-mean-zero` | `integral_eval_stdGaussianPi` | SLT/GaussianMeasure.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.linear-form-mean-zero` | `integral_linearForm_stdGaussianPi` | Mathlib.MeasureTheory.Integral.Bochner.Basic; ASTIS Gaussian |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.linear-form-mgf` | `integral_exp_linearForm_stdGaussianPi` | Mathlib.Probability.Distributions.Gaussian.Real; Mathlib.MeasureTheory.Integral.Pi; external AST GaussianMGF.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.centered-esscher-normalizer` | `integral_exp_centered_linearForm_stdGaussianPi` | AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.scalar.esscher-shift-density` | `gaussianReal_withDensity_exp_shift` | Mathlib.Probability.Distributions.Gaussian.Real; external AST GaussianShift.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.esscher-shift-density` | `stdGaussianPi_withDensity_exp_shift` | AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian; external AST GaussianShift.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.esscher-change-of-measure` | `stdGaussianPi_shift_integral` | Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap; external AST GaussianShift.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.euclidean.pushforward-esscher-change-of-measure` | `stdGaussianPi_shift_integral_map_toLp` | Mathlib.Probability.Distributions.Gaussian.Multivariate; AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.euclidean.stdGaussian-esscher-change-of-measure` | `stdGaussian_shift_integral_map_toLp` | Mathlib.Probability.Distributions.Gaussian.Multivariate; Mathlib.Analysis.InnerProductSpace.PiL2 |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.unit-variance.nnreal` | `nnrealVarianceOneOfGaussianRealUnitLaw` | Mathlib.Probability.Distributions.Gaussian.Real |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.quadratic-bound-integrable` | `integrable_const_mul_sq_gaussianReal_zero` | Mathlib.Probability.Distributions.Gaussian.Real |
| `AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FokkerPlanckAlgebra` | `fokker-planck.scalar-divergence-rewrite` | `fpRewriteScalarAlgebra` | local Mathlib ring proof |
| `AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FokkerPlanckAlgebra` | `fisher.ibp.scalar-algebra` | `fisherIbpAlgebra` | local Mathlib ring proof |
| `AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Girsanov` | `girsanov.finite-gaussian-cylinder-integral` | `finiteGaussianGirsanovCylinderIntegral` | AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian; Chewi finite-dimensional Girsanov cylinder route |
| `AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Girsanov` | `girsanov.finite-gaussian-cylinder-rn-density` | `finiteGaussianGirsanovCylinderMeasure_eq_withDensity` | AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym; AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian |
| `AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.WeakGenerator` | `weak-generator.sample-to-law-derivative` | `weakGeneratorFromSampleDerivative` | Mathlib Measure.map / ASTIS lawIntegralHasDerivAtOfMeasureMapEqAndSample |

## Paper-Extracted Quarantine

These declarations also compile, but they are not counted as the Mathlib-ready
arsenal until the paper-specific names and assumptions are generalized.  The
main graph omits `SALDExtracted.lean` for this reason.

| Module | Memory key | Local declaration | Source orientation |
| --- | --- | --- | --- |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.gronwall.scalar-rewrites` | `gronwallExpProductRewriteScalar` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.em-endpoint-law-handoff` | `discreteForwardKlEmEndpointLawPairHandoff` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.brownian-normalization-bridges` | `selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.remainder-meas-gaussian-law` | `selectedWeakTestRemainderMeasOfStdGaussianVectorLaw` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.remainder-bound-gaussian-law` | `selectedWeakTestRemainderBoundOfStdGaussianVectorLaw` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.remainder-bound-integrable-gaussian-law` | `selectedWeakTestRemainderBoundIntegrableOfStdGaussianVectorLaw` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.normalized-remainder-bound-int-quadratic` | `selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound` | AutoSamplingTheory/SALD.lean |

## Current Library Boundary

| Layer | Rule |
|---|---|
| Main graph surface | `Probability.lean`, `TechnicalLemmas/Probability/*`, `TechnicalLemmas/ProbabilityDistributions/Gaussian.lean`, `TechnicalLemmas/Analysis/Calculus/Taylor.lean`, `TechnicalLemmas/Analysis/Integrability.lean`, `TechnicalLemmas/StochasticProcesses/*`, `TechnicalLemmas/InformationTheory/*`, and `TechnicalLemmas/FunctionalInequalities/*`. |
| Compatibility surfaces | `TechnicalLemmas/Gaussian.lean`, `TechnicalLemmas/Taylor.lean`, `TechnicalLemmas/Measure.lean`, and `TechnicalLemmas/Variational.lean` remain stable imports but are omitted from the main graph. |
| Contract and automation surfaces | `Core.lean`, `SDE.lean`, `Automation.lean`, `Literature.lean`, and `OpenProblems.lean` are system interfaces, not Mathlib-ready leaf families. |
| Paper-extracted compiled leaves | `TechnicalLemmas/SALDExtracted.lean` exposes useful local theorems, but they remain paper-derived until generalized. |
| Consumers | `SALD.lean` and `RMFLD.lean` are downstream users of the arsenal; they are not the public foundation. |

## External Reference Memory

External Lean code and textbooks are preserved as reference cards under
`research-wiki/external-lean-libraries/`.  They are port sources and proof-style
memory, not local proof certificates.

| Reference | Card |
|---|---|
| Mathlib | `research-wiki/external-lean-libraries/mathlib.md` |
| `YuanheZ/lean-stat-learning-theory` | `research-wiki/external-lean-libraries/lean-stat-learning-theory.md` |
| `auto-res/lean-rademacher` | `research-wiki/external-lean-libraries/lean-rademacher.md` |
| Chewisinho stochastic-process notes | `research-wiki/external-lean-libraries/chewisinho-stochastic-processes.md` |
| `junwei-lu/Lean-Asymptotic-Statistical-Theory` | `research-wiki/external-lean-libraries/lean-asymptotic-statistical-theory.md` |

## Agent Rule

Upper agents use this graph to choose the likely proof family.  Middle agents
turn the selected family into one or two Mathlib-ready leaves and must search
Mathlib plus this arsenal before assigning generic infrastructure.  Lower Lean
workers prove one stable leaf at a time.  Persistent failure means the
statement probably needs a hidden regularity contract, a missing assumption, or
a counterexample audit.
