# Proof Obligations: ASTIS-SALD-001

## Analytic Backend

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| KL/FI definitions with smooth densities | contract-only | `main_body.tex:212-215` | `SALD.saldKLContract`, `SALD.saldFIContract` |
| LSI definition and LSI implies KL/FI inequality | obligation | `main_body.tex:202-215` | `SALD.saldLSIContract`, `SALD.saldLsiKlFiBridgeContract`, `SALD.saldLsiKlFiDensityTestContract`, `SALD.lsiKlFiDensityTestObligation`, `SALD.lsiKlFiVocabularyContract`, `lsiToKlFiObligation` |
| Poincare inequality definition | contract-only | `appendix.tex:86-94` | `SALD.saldPIContract`, `SALD.piDefinitionContract` |
| PI weighted Sobolev/Riesz velocity-norm backend | obligation | `appendix.tex:96-151` | `SALD.saldPiVelocityNormDependencyContract`, `SALD.piVelocityNormBackendObligation` |
| Gronwall integrating-factor lemma | obligation | `appendix.tex:47-71` | `SALD.gronwallContract`, `SALD.saldGronwallCandidateContract`, `SALD.saldGronwallEndpointCalculusContract`, `SALD.saldGronwallExponentRewriteContract`, `SALD.gronwallAnalyticObligation`, `SALD.gronwallEndpointCalculusObligation`, `SALD.gronwallExponentRewriteObligation` |
| Cycle 31 Gronwall integrating-factor derivative slice | formalized sublemmas + obligation | `appendix.tex:58-61` | `SALD.gronwallIntegratingFactorProductDerivative`, `SALD.gronwallIntegratingFactorDerivativeInequalityScalar`, `SALD.gronwallIntegratingFactorDerivativeLe`, `SALD.gronwallIntegratingFactorDerivativeLeOfIntegral`; global closed-interval endpoint semantics remain in `SALD.gronwallEndpointCalculusObligation` |
| Cycle 31 Gronwall order-integration and endpoint scalar slice | formalized sublemmas + obligation | `appendix.tex:62-65` | `SALD.gronwallOrderIntegrationOfHasDerivAt`, `SALD.gronwallEndpointEvaluationScalar`, `SALD.gronwallEndpointMultiplyByExpNegScalar`; global production of interval-integrable derivative/input functions and the final exponent rewrite remain in `SALD.gronwallEndpointCalculusObligation` and `SALD.gronwallExponentRewriteObligation` |
| Gronwall final exponent rewrite | obligation | `appendix.tex:63-69` | `SALD.saldGronwallExponentRewriteContract`, `SALD.gronwallExponentRewriteObligation` |
| Gronwall scalar/adjacent-interval exponent bridge | formalized sublemma | `appendix.tex:65-69` | `SALD.gronwallNegIntegralRewriteScalar`, `SALD.gronwallExpProductRewriteScalar`, `SALD.gronwallIntervalIntegralAdditivityScalar`, `SALD.gronwallExpProductRewriteIntervalIntegral`, `SALD.gronwallExpProductRewriteIntegralCongr`; theorem-specific adjacent interval-integrability still remains in `SALD.gronwallExponentRewriteObligation` |
| Cycle 36 Gronwall upper assembly packet | workflow obligation | `appendix.tex:47-71` | `SALD.cycle36GronwallUpperPacket`, `SALD.cycle36GronwallUpperObligation`, `sald.gronwall.cycle36_upper_packet`; lower target is the global Gronwall assembly using the cycle 31 pointwise/order/endpoint helpers plus `SALD.gronwallExpProductRewriteIntegralCongr`, while closed-interval calculus and integrability backends remain obligations |
| Cycle 36 Gronwall global assembly | formalized local assembly + obligation | `appendix.tex:58-69` | `SALD.gronwallEndpointIntegralRewrite`, `SALD.gronwallIntegratingFactorBoundOfDerivatives`, `SALD.gronwallIntegratingFactorBoundOfIntegral`, `SALD.gronwallCoefficientSideConditionsOfContinuous`, `SALD.gronwallIntegratingFactorBoundOfContinuousData`, `SALD.cycle36GronwallMiddleObligation`, `sald.gronwall.cycle36_middle_assembly`; proves the paper's displayed Gronwall bound under explicit global Mathlib derivative/integrability/FTC side conditions, and also from continuous `a,b,K,K'`; deriving the faithful endpoint-safe derivative witness from the source's concise differentiability hypothesis remains in `SALD.gronwallEndpointCalculusObligation` |
| Cycle 41 Gronwall source-derivative wrapper | formalized local wrapper + obligation | `appendix.tex:47-71` | `SALD.gronwallIntegratingFactorBoundOfDifferentiable`, `SALD.gronwallIntegratingFactorBoundOfC1`, `SALD.cycle41GronwallMiddleObligation`, `sald.gronwall.cycle41_deriv_wrapper`; rewrites the paper derivative as `deriv K` and proves the displayed bound from continuous `a,b`, differentiable `K`, source-shaped `deriv K <= -a*K+b`, and either one explicit product-derivative interval-integrability hypothesis or a continuous `deriv K`; endpoint-safe/absolute-continuity interpretation of bare differentiability on `[0,t1]` remains an obligation |
| Cycle 41 Gronwall interior endpoint bridge | formalized local bridge + obligation | `appendix.tex:62-69` | `SALD.gronwallOrderIntegrationOfHasDerivRight`, `SALD.gronwallIntegratingFactorBoundOfInteriorDerivatives`, `SALD.gronwallIntegratingFactorBoundOfInteriorContinuousData`, `SALD.gronwallIntegratingFactorBoundOfInteriorC1`, `SALD.cycle41GronwallLowerObligation`, `sald.gronwall.cycle41_interior_endpoint_bridge`; uses Mathlib's right-derivative FTC with continuity on `[0,t1]` and differentiability only on `(0,t1)`, so the Gronwall assembly no longer differentiates at closed endpoints; identifying the paper's bare differentiability wording with this C1-compatible or absolute-continuity backend remains an obligation |
| Donsker--Varadhan variational formula | source-cited | `appendix.tex:73-79`, Boucheron et al. | `SALD.dvContract`, `dvVariationalObligation`, `dvVariationalFormulaInterface saldDvVariationSource` |
| Cycle 32 Donsker--Varadhan source-cited interface | source-cited interface | `appendix.tex:73-79`, Boucheron Cor. 4.15 | `SALD.cycle32DvVariationUpperPacket`, `SALD.cycle32DvVariationInterfaceObligation`; same-space probabilities, measurable tests, finite log-mgf predicate, supremum equality, and one-sided consequence exposed without proving DV locally |
| Cycle 32 Donsker--Varadhan middle scalar bridge | formalized scalar sublemma + obligation | `appendix.tex:73-79`, Mathlib v4.29.1 KL/tilted audit | `SALD.cycle32DvVariationMiddleAuditContract`, `SALD.cycle32DvVariationMiddleObligation`, `AutoSamplingTheory.dvVariationalOneSidedConsequenceScalar`; only the rearrangement `E_nu[Z]-logMgf <= KL -> E_nu[Z] <= KL+logMgf` is proved locally, while DV equality and admissible-test witnesses remain source-cited/obligation data |
| Cycle 32 Donsker--Varadhan lower supremum bridge | formalized scalar sublemma + obligation | `appendix.tex:73-79`, Boucheron Cor. 4.15 | `SALD.cycle32DvVariationLowerObligation`, `AutoSamplingTheory.dvVariationalOneSidedFromSupremumScalar`; proves only the real-order step from a bounded admissible-value set, selected-test membership, and the source supremum identity to the one-sided bound, while the DV equality, boundedness/admissibility, common-space, measurability, and finite-log-mgf inputs remain explicit dependencies |
| Cycle 37 Donsker--Varadhan upper proof-closure packet | source-cited workflow obligation | `appendix.tex:73-79`, Boucheron Cor. 4.15, local Mathlib KL/tilted infrastructure | `SALD.cycle37DvVariationUpperPacket`, `SALD.cycle37DvVariationUpperObligation`; after cycle 36 Gronwall assembly, selects proof-closure item (2) `lem:dv_variation`; lower target is one DV theorem interface or genuinely compiling backend sublemma, with DV still source-cited |
| Cycle 37 Donsker--Varadhan one-sided tilted backend | formalized one-sided sublemma + obligation | `appendix.tex:73-79`, Mathlib `klDiv`, `Measure.tilted`, tilted log-likelihood identities | `AutoSamplingTheory.dvVariationalOneSidedOfTiltedRight`, `SALD.cycle37DvVariationMiddleAuditContract`, `SALD.cycle37DvVariationMiddleObligation`; proves the admissible-test inequality `E_nu[Z]-log E_mu[exp Z] <= KL(nu||mu)` under explicit Mathlib hypotheses, while the Boucheron supremum equality and theorem-specific SALD witnesses remain source-cited/obligations |
| Cycle 37 Donsker--Varadhan lower one-sided consequence | formalized one-sided consequence + obligation | `appendix.tex:73-79`, Mathlib tilted backend plus local scalar rearrangement | `AutoSamplingTheory.dvVariationalTiltedRightOneSidedConsequence`, `SALD.cycle37DvVariationLowerObligation`; proves the paper-consumed consequence `E_nu[Z] <= KL(nu||mu)+log E_mu[exp Z]` under the same explicit selected-test hypotheses, while the Boucheron supremum equality and SALD theorem-specific test witnesses remain source-cited/obligations |
| Cycle 42 Donsker--Varadhan selected scaled-test interface | formalized finite-mgf/one-sided sublemmas + obligation | `appendix.tex:73-79`, first SALD use `appendix.tex:230-241`, Mathlib `ProbabilityTheory.integrable_exp_mul_of_nonneg_of_le` | `AutoSamplingTheory.dvFiniteLogMgfOfLeAlpha`, `AutoSamplingTheory.dvVariationalOneSidedOfScaledTest`, `SALD.cycle42DvVariationMiddleAuditContract`, `SALD.cycle42DvVariationMiddleObligation`; proves the alpha0-to-alpha finite-log-mgf handoff and one-sided tilted inequality for `Z=alpha*q` under explicit selected-test hypotheses, while the Boucheron supremum equality and theorem-specific common-space/absolute-continuity/log-likelihood witnesses remain source-cited/obligations |
| Cycle 42 Donsker--Varadhan lower scaled-energy bridge | formalized selected-test energy sublemmas + obligation | `appendix.tex:73-79`, first SALD use `appendix.tex:230-241` | `AutoSamplingTheory.dvVariationalScaledTestEnergyBound`, `AutoSamplingTheory.dvVariationalScaledTestEnergyBoundWithCoeff`, `SALD.cycle42DvVariationLowerObligation`; divides the selected-test one-sided inequality by `alpha>0`, rewrites the log-mgf quotient as `eAlpha`, and preserves a nonnegative downstream coefficient, while the Boucheron supremum equality and theorem-specific common-space/absolute-continuity/q-integrability/log-likelihood witnesses remain obligations |
| DV finite-log-mgf/common-space instantiation interface | obligation | `appendix.tex:73-79`, theorem-specific alpha-complexity assumptions | `SALD.saldDvFiniteLogMgfContract`, `SALD.dvFiniteLogMgfInterfaceObligation` |
| Cycle 13 first appendix source-index audit | obligation | `appendix.tex:47-94`, `main_body.tex:202-215`, `research-wiki/source-index/SALD_original.jsonl` | `SALD.cycle13FirstAppendixVocabularyPacket`, `SALD.cycle13FirstAppendixSourceIndexAuditContract`, `SALD.firstAppendixSourceIndexAuditObligation` |
| Cycle 13 first appendix middle source-to-Lean map | obligation | `appendix.tex:47-151`, `main_body.tex:202-215`, `research-wiki/source-index/SALD_original.jsonl` | `SALD.cycle13FirstAppendixMiddleAuditContract`, `SALD.firstAppendixMiddleAuditObligation` |
| Cycle 17 first appendix middle source-to-Lean rebaseline | obligation | `appendix.tex:47-151`, `main_body.tex:202-215`, `research-wiki/source-index/SALD_original.jsonl` | `SALD.cycle17FirstAppendixMiddleAuditContract`, `SALD.firstAppendixMiddleAuditObligation`; lower target is `SALD.saldGronwallExponentRewriteContract` / `sald.gronwall.exponent_rewrite` |
| Cycle 21 first appendix source-index/vocabulary rebaseline | workflow obligation | `appendix.tex:47-151`, `main_body.tex:202-215`, `research-wiki/source-index/SALD_original.jsonl` | `SALD.cycle21FirstAppendixVocabularyPacket`, `SALD.cycle21FirstAppendixMiddleAuditContract`, `SALD.firstAppendixSourceIndexAuditObligation`, `SALD.firstAppendixMiddleAuditObligation`; preferred lower target remains `SALD.saldGronwallExponentRewriteContract` / `sald.gronwall.exponent_rewrite` |
| Cycle 25 first appendix source-index/PI velocity-norm rebaseline | workflow obligation | `appendix.tex:47-151`, `main_body.tex:202-215`, `research-wiki/source-index/SALD_original.jsonl` | `SALD.cycle25FirstAppendixVocabularyPacket`, `SALD.firstAppendixSourceIndexAuditObligation`, `SALD.firstAppendixMiddleAuditObligation`; lower target is exactly `SALD.saldPiVelocityNormDependencyContract` / `SALD.piVelocityNormBackendObligation` / `sald.pi.velocity_norm_backend`, first sub-slice `appendix.tex:96-129` |
| Cycle 25 middle PI velocity-norm source-to-Lean map | workflow obligation | `appendix.tex:96-129`, immediate continuation `appendix.tex:130-138` | `SALD.cycle25FirstAppendixMiddleAuditContract`, `SALD.cycle25FirstAppendixPiVelocityNormMiddleObligation`, `SALD.firstAppendixMiddleAuditObligation`; lower-ready target remains `sald.pi.velocity_norm_backend` |
| Cycle 25 lower PI velocity-norm scalar core | formalized scalar sublemmas + obligation | `appendix.tex:104-129` | `SALD.piVelocityNormMeanZeroH1UpperScalar`, `SALD.piVelocityNormBoundedFunctionalScalar`, `SALD.cycle25PiVelocityNormLowerObligation`; weighted Sobolev, L2 pairing, Riesz, weak-PDE, and velocity-bound backends remain in `SALD.piVelocityNormBackendObligation` |
| Cycle 29 first appendix source-index/LSI density-test rebaseline | workflow obligation | `appendix.tex:47-151`, `main_body.tex:202-215`, `research-wiki/source-index/SALD_original.jsonl` | `SALD.cycle29FirstAppendixVocabularyPacket`, `SALD.firstAppendixSourceIndexAuditObligation`, `SALD.firstAppendixMiddleAuditObligation`; lower target is exactly `SALD.saldLsiKlFiDensityTestContract` / `SALD.lsiKlFiDensityTestObligation` / `sald.lsi_kl_fi.density_test_interface`, first sub-slice `main_body.tex:208-215` |
| Cycle 29 lower LSI/KL/FI coefficient audit | formalized scalar sublemma + obligation | `main_body.tex:205-210` | `SALD.lsiKlFiCoefficientAuditScalar`, `SALD.cycle29LsiKlFiDensityTestLowerObligation`; density, normalization, smooth-test/approximation, entropy rewrite, zero-density convention, and FI chain-rule backends remain in `SALD.lsiKlFiDensityTestObligation` |
| Cycle 33 LSI/KL/FI density-test upper packet | lower-ready proof-closure packet | `main_body.tex:202-215`, first slice `main_body.tex:208-215` | Target `SALD.saldLsiKlFiDensityTestContract`, `SALD.lsiKlFiDensityTestObligation`, and `sald.lsi_kl_fi.density_test_interface`; lower should first prove a narrow `phi=sqrt(r)` pointwise normalization/entropy handoff under explicit density and zero-set side conditions, then only interface the FI chain rule. `eq:LSI-KL-FI` remains an obligation. |
| Cycle 33 LSI/KL/FI density-test middle scalar slice | formalized scalar sublemmas + obligation | `main_body.tex:208-215` | `AutoSamplingTheory.lsiKlFiSqrtDensitySquareScalar`, `AutoSamplingTheory.lsiKlFiSqrtDensityEntropyIntegrandScalar`, `AutoSamplingTheory.lsiKlFiSqrtDensityNormalizationScalar`, `SALD.cycle33LsiKlFiDensityTestMiddleObligation`; Radon-Nikodym density backend, integral transport, smooth/admissible `sqrt(r)` or approximation, finite KL/FI, zero-density convention, and FI chain rule remain in `SALD.lsiKlFiDensityTestObligation` |
| Cycle 33 LSI/KL/FI density-test lower scalar bridge | formalized scalar sublemma + obligation | `main_body.tex:208-215` | `SALD.lsiKlFiDensityTestBridgeScalar`, `SALD.cycle33LsiKlFiDensityTestLowerObligation`; proves only the real-order handoff from a normalized LSI test inequality plus entropy-to-KL and Dirichlet-to-FI identities to `KL <= FI/(2*C_LSI)`, while the Radon-Nikodym, admissibility/approximation, finite KL/FI, zero-density, and FI chain-rule backends remain in `SALD.lsiKlFiDensityTestObligation` |
| Cycle 38 LSI/KL/FI upper proof-closure packet | workflow obligation | `main_body.tex:202-215`, next slice `main_body.tex:208-215` | `SALD.cycle38LsiKlFiUpperPacket`, `SALD.cycle38LsiKlFiUpperObligation`; after cycle 36 Gronwall and cycle 37 DV progress, selects proof-closure item (3) `eq:LSI-KL-FI`; lower target is a proof-producing Fisher chain-rule/admissibility bridge for `phi=sqrt(rho/pi)` or a precise source-cited interface with explicit density, zero-set, smoothness/approximation, and finite KL/FI hypotheses; full `probability.lsi_to_kl_fi` remains an obligation |
| Cycle 38 LSI/KL/FI middle Fisher-chain scalar slice | formalized scalar sublemmas + obligation | `main_body.tex:208-215` | `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainScalar`, `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainOfDerivativesScalar`, `SALD.lsiKlFiHalfFisherScalar`, `SALD.lsiKlFiDensityTestHalfFisherScalar`, `SALD.cycle38LsiKlFiMiddleObligation`; proves only the positive-density scalar `1/4` Fisher coefficient and the half-Fisher coefficient handoff, while vector gradients, integral transport, admissibility/approximation, zero-density, finite KL/FI, and full `probability.lsi_to_kl_fi` remain obligations |
| Cycle 38 LSI/KL/FI lower finite-coordinate Fisher-chain slice | formalized finite-coordinate sublemmas + obligation | `main_body.tex:208-215` | `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainFiniteSumScalar`, `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainFiniteSumHandoffScalar`, `SALD.cycle38LsiKlFiLowerObligation`; sums the pointwise chain-rule coefficient over finite coordinates and supplies the `dirichlet=(1/4)*FI` handoff after explicit finite-sum identifications, while Radon-Nikodym density, vector-gradient equivalence, integral transport, admissibility/approximation, zero-density, finite KL/FI, and full `probability.lsi_to_kl_fi` remain obligations |
| Cycle 43 LSI/KL/FI upper density-test backend packet | workflow obligation | `main_body.tex:202-215`, next slice `main_body.tex:208-215` | `SALD.cycle43LsiKlFiUpperPacket`, `SALD.cycle43LsiKlFiUpperObligation`; after cycle 41 Gronwall and cycle 42 DV progress, explicitly selects proof-closure item (3) `eq:LSI-KL-FI`; lower target is one proof-producing or source-cited density/test-function backend for Radon-Nikodym normalization, entropy integral transport, admissibility/approximation of `sqrt(rho/pi)`, zero-density handling, or the vector/integral Fisher chain rule; full `probability.lsi_to_kl_fi` remains an obligation |
| Cycle 43 LSI/KL/FI middle Radon-Nikodym density and entropy transport | formalized measure-level sublemmas + obligation | `main_body.tex:208-215` | `AutoSamplingTheory.lsiKlFiRnDerivLIntegralMassOne`, `AutoSamplingTheory.lsiKlFiRnDerivDensityMassOne`, `AutoSamplingTheory.lsiKlFiSqrtRnDerivTestMassOne`, `AutoSamplingTheory.lsiKlFiRnDerivEntropyIntegral`, `AutoSamplingTheory.lsiKlFiSqrtRnDerivEntropyIntegral`, `SALD.cycle43LsiKlFiMiddleObligation`; proves the probability RN density mass, sqrt-test mass, and entropy transport to the KL log-likelihood integral under `rho << pi`, while smooth/admissible test approximation, zero-density Sobolev handling, vector/integral Fisher chain rule, finite theorem-level KL/FI interfaces, and full `probability.lsi_to_kl_fi` remain obligations |
| Cycle 43 LSI/KL/FI lower integral finite-coordinate Fisher chain | formalized finite-coordinate integral sublemmas + obligation | `main_body.tex:208-215` | `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainIntegralFiniteSum`, `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar`, `SALD.cycle43LsiKlFiLowerObligation`; pushes the cycle-38 finite-coordinate Fisher-chain coefficient through an arbitrary measure under a.e. positivity and supplied coordinate derivative identities, and packages the exact `dirichlet=(1/4)*FI` scalar input once finite-coordinate Dirichlet/Fisher integral identifications are supplied; vector-gradient equivalence, zero-density Sobolev handling, smooth/admissible `sqrt(r)` approximation, finite theorem-level KL/FI interfaces, and full `probability.lsi_to_kl_fi` remain obligations |
| Cycle 44 main skeleton analytic interface ledger | workflow obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-228`, `appendix.tex:260-385`, `appendix.tex:724-1603` | `SALD.cycle44MainSkeletonAnalyticInterfaceLedger`, `SALD.cycle44MainSkeletonAnalyticInterfaceObligation`, `SALD.cycle44MainSkeletonAnalyticInterfaceDag`; records the five slow analytic interfaces and wires them into `thm:forward-KL`, `thm:forward-KL-discrete`, `prop:guided_path_residual`, `thm:general-moving-target-SALD`, `thm:unified-forward-KL`, and `thm:general-moving-target-SALD-discrete` while keeping unproved backends below formalized |
| Cycle 45 continuous forward-KL theorem skeleton route | workflow obligation | `main_body.tex:238-247`, `appendix.tex:164-252` | `SALD.cycle45ForwardKlSkeletonUpperPacket`, `SALD.cycle45ForwardKlSkeletonObligation`, `SALD.cycle45ForwardKlSkeletonDag`, `ASTIS.SALD.forward_KL.cycle45_theorem_skeleton_route`; wires the checked Gronwall, DV, LSI/KL/FI, continuous KL derivative/Fokker--Planck, and downstream EM interpolation interfaces into the faithful `thm:forward-KL` proof route while keeping all slow analytic backends below formalized |
| Cycle 45 middle continuous forward-KL route audit | workflow obligation | `main_body.tex:238-247`, `appendix.tex:168-252` | `SALD.cycle45ForwardKlSkeletonMiddleContract`, `SALD.cycle45ForwardKlSkeletonMiddleObligation`, `ASTIS.SALD.forward_KL.cycle45_middle_route_audit`; checks the theorem-level source-to-Lean route after the upper wrapper, keeps `thm:forward-KL` contract-only and unchanged, and selects `sald.forward_kl.gronwall_side_conditions` as the next lower backend for theorem-display matching |
| Cycle 45 lower forward-KL Gronwall display algebra | formalized local integral/order sublemmas + obligation | `appendix.tex:244-252`, `main_body.tex:243-246` | `SALD.forwardKlGronwallCoeffIntegralSub`, `SALD.forwardKlGronwallInitialExponentSplitScalar`, `SALD.forwardKlGronwallInitialExponentSplitOfPieces`, `SALD.forwardKlGronwallResidualExponentDropScalar`, `SALD.forwardKlGronwallResidualExponentDropIntegral`; proves the initial exponent split and residual exponent drop only after explicit interval-integrability, nonnegative LSI-integral, and nonnegative residual-integrand hypotheses are supplied; endpoint rewrites, theorem-specific coefficient regularity, `b(t)` regularity/nonnegativity, and full Gronwall remain in `sald.forward_kl.gronwall_side_conditions` |
| Cycle 50 upper continuous forward-KL post-readiness route | workflow obligation | `main_body.tex:238-247`, `appendix.tex:164-252` | `SALD.cycle50ForwardKlSkeletonUpperPacket`, `SALD.cycle50ForwardKlSkeletonObligation`, `SALD.cycle50ForwardKlSkeletonDag`, `ASTIS.SALD.forward_KL.cycle50_theorem_skeleton_route`; consumes the cycle-49 five-backend readiness check and re-wires `thm:forward-KL` through the continuous KL derivative, LSI/KL/FI, DV finite-log-mgf, Gronwall endpoint/exponent, and downstream EM interpolation interfaces without changing theorem status or source constants |
| Cycle 50 middle continuous forward-KL route audit | workflow obligation | `main_body.tex:238-247`, `appendix.tex:168-252` | `SALD.cycle50ForwardKlSkeletonMiddleContract`, `SALD.cycle50ForwardKlSkeletonMiddleObligation`, `ASTIS.SALD.forward_KL.cycle50_middle_route_audit`; verifies the post-readiness route after the cycle-50 upper wrapper, keeps `thm:forward-KL` contract-only and unchanged, and selects `SALD.forwardKlDerivativeCandidateContract` / `SALD.forwardKlDerivativeObligation` / `sald.forward_kl.kl_derivative` as the next lower backend over `appendix.tex:168-228` |
| Cycle 50 lower continuous forward-KL derivative/DV scalar handoff | formalized scalar sublemma + obligation | `appendix.tex:168-241` | `SALD.forwardKlDerivativeDvGronwallCoefficientOfKlFiVelocityScalingScalar`, `SALD.cycle50ForwardKlDerivativeLowerObligation`, `ASTIS.SALD.forward_KL.cycle50_derivative_dv_lower`; composes the selected KL derivative scalar pipeline, source KL/FI comparison, inverse-schedule velocity scaling, and selected-test DV input into the pre-Gronwall differential inequality with the exact coefficient `dot{s}(t)*C_LSI(t) - (1/2)*dot{s}(t)^(-1)*alpha^(-1)`; KL derivative/Fokker--Planck, LSI density-test, DV finite-log-mgf/common-space, Gronwall, and `thm:forward-KL` remain obligations |
| Cycle 51 upper discrete forward-KL interface route | workflow obligation | `main_body.tex:299-323`, `appendix.tex:260-592` | `SALD.cycle51DiscreteForwardKlSkeletonUpperPacket`, `SALD.cycle51DiscreteForwardKlSkeletonObligation`, `ASTIS.SALD.forward_KL_discrete.cycle51_theorem_interface_route`; consumes the cycle-49 five-backend readiness check and cycle-50 continuous derivative/DV scalar handoff, then re-wires `thm:forward-KL-discrete` through source-cited EM endpoint/conditional-Fokker--Planck, frozen-defect/LSI, DV velocity, Gronwall, and accumulated-error interfaces while keeping the theorem `contractOnly` |
| Cycle 51 middle discrete forward-KL derivative route audit | workflow obligation | `main_body.tex:299-323`, `appendix.tex:334-491` with EM inputs from `appendix.tex:260-385` | `SALD.cycle51DiscreteForwardKlSkeletonMiddleContract`, `SALD.cycle51DiscreteForwardKlSkeletonMiddleObligation`, `ASTIS.SALD.forward_KL_discrete.cycle51_middle_route_audit`; verifies the post-upper discrete route, keeps the theorem statement unchanged, and selects `SALD.discreteForwardKlDerivativeCandidateContract` / `SALD.discreteForwardKlDerivativeObligation` / `sald.discrete_forward_kl.kl_derivative` as the lower backend while consuming EM endpoint/conditional-FP as source-cited obligations rather than reproving them |
| Cycle 51 lower discrete forward-KL derivative scalar handoff | proof-producing scalar core plus obligation | `appendix.tex:388-491` | `SALD.discreteForwardKlPostLsiDerivativeBoundScalar`, `SALD.discreteForwardKlPostLsiDerivativeBoundOfKlFiScalar`, `SALD.cycle51DiscreteForwardKlDerivativeLowerObligation`, `ASTIS.SALD.forward_KL_discrete.cycle51_derivative_lower`; composes supplied EM-FP derivative identity, frozen-cross bound, moving Young estimate, and LSI half-Fisher comparison into the source pre-DV inequality without proving or promoting the analytic backends |
| Cycle 56 upper discrete forward-KL theorem interface route | workflow obligation | `main_body.tex:299-323`, `appendix.tex:260-592` | `SALD.cycle56DiscreteForwardKlSkeletonUpperPacket`, `SALD.cycle56DiscreteForwardKlSkeletonObligation`, `ASTIS.SALD.forward_KL_discrete.cycle56_theorem_interface_route`; re-checks the five slow interfaces after the cycle-55 continuous route, wires `thm:forward-KL-discrete` through explicit EM endpoint/conditional-FP, derivative/LSI, DV velocity, Gronwall, and accumulated-error interfaces, and selects `sald.discrete_forward_kl.gronwall_accumulation` as the next theorem-level lower backend while keeping the theorem `contractOnly` |
| Cycle 56 middle discrete forward-KL route audit | workflow obligation | `main_body.tex:299-323`, `appendix.tex:260-592`, lower slice `appendix.tex:526-592` | `SALD.cycle56DiscreteForwardKlSkeletonMiddleContract`, `SALD.cycle56DiscreteForwardKlSkeletonMiddleObligation`, `ASTIS.SALD.forward_KL_discrete.cycle56_middle_route_audit`; verifies the upper route in paper order, consumes EM/Fokker--Planck only through named source-cited interfaces, adds the middle obligation to `SALD.discreteSaldContract`, and keeps lower work on `sald.discrete_forward_kl.gronwall_accumulation` while derivative, LSI/KL/FI, DV, endpoint stitching, and accumulated-error collection stay separate obligations |
| Cycle 56 lower discrete forward-KL Gronwall time-change handoff | proof-producing scalar core plus obligation | `appendix.tex:526-553` | `SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`, `SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged`, `SALD.cycle56DiscreteForwardKlGronwallLowerObligation`, `ASTIS.SALD.forward_KL_discrete.cycle56_gronwall_lower`; compiles the real-order handoff from the supplied post-DV `s`-time inequality to the exact pointwise `t`-time Gronwall coefficient and residual, while EM/KL differentiation, frozen-defect, LSI/KL/FI, DV, schedule calculus, Gronwall, endpoint stitching, and accumulated-error collection remain obligations |
| Cycle 46 discrete forward-KL theorem skeleton route | workflow obligation | `main_body.tex:299-323`, `appendix.tex:260-592` | `SALD.cycle46DiscreteForwardKlSkeletonUpperPacket`, `SALD.cycle46DiscreteForwardKlSkeletonObligation`, `SALD.cycle46DiscreteForwardKlSkeletonDag`, `ASTIS.SALD.forward_KL_discrete.cycle46_theorem_skeleton_route`; wires the theorem-level EM endpoint/conditional-FP, frozen-defect, LSI/KL/FI, DV velocity, Gronwall, and accumulated-error interfaces into `thm:forward-KL-discrete` while preserving the main-body constants and keeping all slow backends below formalized |
| Cycle 46 middle discrete forward-KL route audit | workflow obligation | `main_body.tex:299-323`, `appendix.tex:260-592` | `SALD.cycle46DiscreteForwardKlSkeletonMiddleContract`, `SALD.cycle46DiscreteForwardKlSkeletonMiddleObligation`, `ASTIS.SALD.forward_KL_discrete.cycle46_middle_route_audit`; verifies the source-to-Lean route after the upper wrapper, keeps `thm:forward-KL-discrete` contract-only and unchanged, and selects `sald.discrete_forward_kl.accumulated_error_bridge` as the next lower theorem-display backend |
| Cycle 47 guided/general theorem skeleton route | workflow obligation | `appendix.tex:619-951` | `SALD.cycle47GuidedGeneralSkeletonUpperPacket`, `SALD.cycle47GuidedGeneralSkeletonObligation`, `SALD.cycle47GuidedGeneralSkeletonDag`, `ASTIS.SALD.guided_general.cycle47_theorem_skeleton_route`; wires `prop:guided_path_residual` and `thm:general-moving-target-SALD` through the guided residual, general KL derivative, LSI/KL/FI, residual DV, Gronwall, and pure-contraction interfaces while preserving source statements and keeping all slow backends below formalized |
| Cycle 47 middle guided/general route audit | workflow obligation | `appendix.tex:619-951` | `SALD.cycle47GuidedGeneralSkeletonMiddleContract`, `SALD.cycle47GuidedGeneralSkeletonMiddleObligation`, `ASTIS.SALD.guided_general.cycle47_middle_route_audit`; verifies the source-to-Lean route after the upper wrapper, keeps `prop:guided_path_residual` and `thm:general-moving-target-SALD` contract-only and unchanged, and selects `sald.general_moving_target.kl_derivative` as the next lower theorem-level backend |
| Cycle 47 lower continuous general derivative scalar handoff | compiled scalar/order core plus obligation refinement | `appendix.tex:835-884` | `SALD.generalMovingTargetPostYoungDerivativeBoundScalar`, `SALD.generalMovingTargetLsiDerivativeBoundScalar`, `SALD.generalMovingTargetTimeChangedDerivativeBoundScalar`, `SALD.generalMovingTargetPreDvDerivativeBoundScalar`; compiles the real/order handoff from the supplied residual Young bound through LSI half-Fisher substitution and inverse-schedule coefficient rewrite for `sald.general_moving_target.kl_derivative`, while Fokker--Planck, integration by parts, LSI density-test, and schedule calculus remain obligations |
| Forward-KL DV alpha0-to-alpha log-mgf monotonicity | obligation | `main_body.tex:240-241`, `appendix.tex:230-241` | `SALD.forwardKlDvAlphaMonotonicityContract`, `SALD.forwardKlDvAlphaMonotonicityObligation` |
| Alpha-complexity definition and finite log-mgf use | contract + obligation | `main_body.tex:218-228`, `appendix.tex:230-241` | `SALD.saldAlphaComplexityContract`, `SALD.forwardKlDvEnergyCandidateContract` |
| Forward-KL density, boundary, and differentiation side conditions | obligation | `appendix.tex:168-208` | `SALD.forwardKlDerivativeSideConditionContract`, `SALD.forwardKlDensityBoundaryObligation` |
| Forward-KL inverse-schedule time change | obligation | `appendix.tex:191-228` | `SALD.forwardKlDerivativeSideConditionContract`, `SALD.forwardKlScheduleTimeChangeObligation` |
| Forward-KL Fokker--Planck/KL derivative identity | obligation | `appendix.tex:168-228` | `SALD.forwardKlDerivativeObligation`, `SALD.forwardKlDerivativeCandidateContract` |
| Forward-KL DV velocity-energy bound | obligation + source-cited | `appendix.tex:230-241` | `SALD.forwardKlDvEnergyObligation`, `SALD.forwardKlDvEnergyCandidateContract`, `SALD.forwardKlDvAlphaMonotonicityObligation`, `dvVariationalObligation` |
| Forward-KL Gronwall instantiation | obligation | `appendix.tex:244-252` | `SALD.forwardKlGronwallApplicationObligation`, `SALD.forwardKlGronwallInstantiationContract`, `SALD.gronwallAnalyticObligation` |
| Forward-KL moving-target dependency chain | obligation | `main_body.tex:238-247`, `appendix.tex:168-252` | `SALD.forwardKlMovingTargetDependencyContract`, `SALD.forwardKlMovingTargetDependencyObligation` |
| Forward-KL LSI/DV/Gronwall coefficient chain audit | obligation | `main_body.tex:243-246`, `appendix.tex:210-252` | `SALD.forwardKlDependencyChainAuditContract`, `SALD.forwardKlCoefficientChainObligation`; includes source-line ledger, scalar side conditions, and dependency classifications |
| Forward-KL Gronwall endpoint/exponent side conditions | obligation | `main_body.tex:243-246`, `appendix.tex:244-252` | `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlGronwallSideConditionObligation` |
| Cycle 14 continuous forward-KL upper moving-target packet | workflow obligation | `main_body.tex:238-247`, `appendix.tex:164-252` | `SALD.cycle14ForwardKlUpperPacket`; lower target is one of `SALD.forwardKlEndpointScheduleContract`, `SALD.forwardKlMovingTargetDependencyContract`, `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlDerivativeSideConditionContract`, `sald.forward_kl.endpoint_schedule_identities`, `sald.forward_kl.moving_target_dependency_chain`, or `sald.forward_kl.gronwall_side_conditions` |
| Cycle 14 continuous forward-KL middle source-to-Lean map | workflow obligation | `main_body.tex:238-247`, `appendix.tex:168-252` | `SALD.cycle14ForwardKlMiddleContract`, `SALD.forwardKlMiddleSourceToLeanMapObligation`; lower target is `SALD.forwardKlEndpointScheduleContract` and `sald.forward_kl.endpoint_schedule_identities` |
| Cycle 14 continuous forward-KL endpoint schedule lower slice | obligation | `main_body.tex:9-13`, `main_body.tex:238-247`, `appendix.tex:218-252` | `SALD.forwardKlEndpointScheduleContract`, `SALD.forwardKlEndpointScheduleObligation`; isolates `s(0)=0`, `S=s(T)`, `t(s(T))=T`, `tilde_pi_{s(t)}=pi_t`, and `K(0)`/`K(T)` rewrites |
| Cycle 18 continuous forward-KL upper Gronwall/DV/LSI chain packet | workflow obligation | `main_body.tex:238-247`, `appendix.tex:164-252`, `appendix.tex:63-69` | `SALD.cycle18ForwardKlUpperPacket`; lower target is exactly `SALD.forwardKlGronwallSideConditionContract` / `SALD.forwardKlGronwallSideConditionObligation` / `sald.forward_kl.gronwall_side_conditions`, with cycle-17 scalar Gronwall helpers used only as partial local algebra |
| Cycle 22 continuous forward-KL upper coefficient/integrability packet | workflow obligation | `main_body.tex:238-247`, `appendix.tex:210-252`, `appendix.tex:63-69` | `SALD.cycle22ForwardKlUpperPacket`; lower target remains exactly `SALD.forwardKlGronwallSideConditionContract` / `SALD.forwardKlGronwallSideConditionObligation` / `sald.forward_kl.gronwall_side_conditions`, now narrowed to theorem-specific coefficient regularity and adjacent interval-integrability needed before using `SALD.gronwallExpProductRewriteIntegralCongr` |
| Cycle 22 continuous forward-KL middle coefficient/integrability map | workflow obligation | `appendix.tex:210-252`, `main_body.tex:243-246` | `SALD.cycle22ForwardKlMiddleContract`; lower target is still `sald.forward_kl.gronwall_side_conditions`, narrowed to regularity/integrability of `a(t)`, `dot{s}(t) C_LSI(t)`, `(1/2) dot{s}(t)^(-1) alpha^(-1)`, and `b(t)` before applying the compiled exponent congruence |
| Cycle 22 continuous forward-KL coefficient-piece interval bridge | formalized sublemma with remaining theorem-specific hypotheses | `appendix.tex:244-250`, reusable `appendix.tex:63-69` | `SALD.forwardKlGronwallCoeffIntervalIntegrable`, `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable`, `SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces`; regularity/integrability of the LSI piece, alpha piece, and `b(t)`, endpoint rewrites, residual-exponent monotonicity, and full Gronwall remain in `SALD.forwardKlGronwallSideConditionObligation` |
| Cycle 26 continuous forward-KL upper DV witness packet | workflow obligation | `main_body.tex:218-248`, `appendix.tex:73-79`, `appendix.tex:230-241` | `SALD.cycle26ForwardKlUpperPacket`; lower target is exactly `SALD.forwardKlDvFiniteLogMgfWitnessContract` / `SALD.forwardKlDvFiniteLogMgfWitnessObligation` / `sald.forward_kl.dv_finite_log_mgf_witness`, narrowed to common-space, absolute-continuity, measurability, alpha0-to-alpha finite-log-mgf, and positive-alpha scaling for `Z=alpha*||v_t||^2` |
| Cycle 26 continuous forward-KL middle DV witness map | workflow/source-dependency obligation | `main_body.tex:218-248`, `appendix.tex:73-79`, `appendix.tex:230-241` | `SALD.cycle26ForwardKlMiddleContract`, `SALD.cycle26ForwardKlDvWitnessMiddleObligation`, `ASTIS.SALD.forward_KL.cycle26_middle_dv_witness`; lower target remains exactly `SALD.forwardKlDvFiniteLogMgfWitnessContract` / `sald.forward_kl.dv_finite_log_mgf_witness`; dependency classes: DV external-cited result, alpha-complexity internal-paper definition, alpha0-to-alpha finite-log-mgf local measure/order lemma, common-space/absolute-continuity/measurability source-contract gaps, and positive-alpha scaling local algebra |
| Cycle 26 lower forward-KL DV positive-alpha scalar core | formalized scalar sublemmas + obligation | `appendix.tex:237-241`, downstream `appendix.tex:239-244` and `main_body.tex:243-246` | `SALD.forwardKlDvPositiveAlphaScalingScalar`, `SALD.forwardKlDvPositiveAlphaCoefficientScalar`, `SALD.forwardKlPostDvGronwallCoefficientScalar`, `SALD.forwardKlPostDvGronwallCoefficientOfScheduleScalar`, `SALD.cycle26ForwardKlDvPositiveAlphaLowerObligation`; common-space, measurability, finite log-mgf, source-cited DV, and coefficient-instantiation inputs remain in `SALD.forwardKlDvFiniteLogMgfWitnessObligation` and `SALD.forwardKlDvEnergyObligation` |
| Cycle 30 continuous forward-KL upper derivative-side packet | workflow obligation | `main_body.tex:238-247`, `appendix.tex:168-228` | `SALD.cycle30ForwardKlUpperPacket`, `SALD.cycle30ForwardKlDerivativeSideUpperObligation`; lower target is exactly `SALD.forwardKlDerivativeSideConditionContract` / `SALD.forwardKlDensityBoundaryObligation` / `sald.forward_kl.density_boundary_regular`, narrowed first to `appendix.tex:168-185` mass conservation, KL differentiation, SALD Fokker--Planck, and integration by parts before target-side transport and time change |
| Cycle 30 continuous forward-KL middle derivative-side packet | workflow obligation | `appendix.tex:168-208`, first sub-slice `appendix.tex:168-185` | `SALD.cycle30ForwardKlMiddleContract`, `SALD.cycle30ForwardKlDerivativeSideMiddleObligation`, `ASTIS.SALD.forward_KL.cycle30_derivative_side_middle`; lower target remains exactly `SALD.forwardKlDerivativeSideConditionContract` / `SALD.forwardKlDensityBoundaryObligation` / `sald.forward_kl.density_boundary_regular`, with density, domination, mass-conservation, boundary/no-flux, and `-FI` identification exposed before target-side transport, LSI, time-change, DV, or Gronwall |
| Cycle 30 lower forward-KL first-term scalar substitution | formalized scalar sublemma + obligation | `appendix.tex:168-185` | `SALD.forwardKlFirstTermFisherSubstitutionScalar`, `SALD.cycle30ForwardKlDensityBoundaryLowerObligation`, `ASTIS.SALD.forward_KL.cycle30_density_boundary_lower`; analytic KL differentiation, SALD Fokker--Planck, boundary/no-flux, and FI identification remain in `SALD.forwardKlDensityBoundaryObligation` |
| Cycle 34 forward-KL derivative scalar proof slice | formalized scalar sublemmas + obligation | `appendix.tex:168-228` | `SALD.cycle34ForwardKlDerivativeUpperPacket`, `SALD.cycle34ForwardKlDerivativeMiddleContract`, `SALD.forwardKlTargetTransportYoungBoundScalar`, `SALD.forwardKlPostYoungDerivativeBoundScalar`, `SALD.forwardKlPostYoungDerivativeBoundOfCauchyScalar`, `SALD.forwardKlLsiDerivativeBoundScalar`, `SALD.forwardKlTimeChangedDerivativeBoundScalar`, `SALD.cycle34ForwardKlDerivativeScalarObligation`, `SALD.cycle34ForwardKlTargetYoungLowerObligation`, `SALD.cycle34ForwardKlDerivativeMiddleObligation`; proves only the Real arithmetic/order handoff from supplied first-term, target Cauchy/Young, LSI half-Fisher, chain-rule, velocity-square scaling, and inverse-schedule inputs, while Fokker--Planck, integration by parts, target transport/Cauchy backend, LSI density-test, analytic time change, DV, and Gronwall remain obligations/source-cited |
| Inverse slowdown schedule interface | source-contract gap plus scalar handoff | `main_body.tex:9`, `main_body.tex:238`, `appendix.tex:218-228` | `SALD.forwardKlDerivativeCandidateContract`, `SALD.forwardKlGronwallInstantiationContract`, `SALD.forwardKlScheduleTimeChangeObligation`, `SALD.forwardKlTimeChangedDerivativeBoundScalar`; chain rule, inverse-function identity, velocity-square scaling, and positivity/nonzero facts remain in the schedule obligation |
| Density regularity and integration by parts for KL derivative | source-contract gap | `appendix.tex:168-208` | `SALD.forwardKlDerivativeCandidateContract` |
| Fokker--Planck KL derivative identity | obligation | `appendix.tex` | `SALD.forwardKlDerivativeObligation`; planned general backend |
| Continuity-equation transport identity | obligation | `main_body.tex`, `appendix.tex` | `TransportVelocityContract` |
| EM frozen interpolation local defect bound | obligation | `appendix.tex:260-330` | `DiscretizationErrorContract`, `SALD.discreteSaldEulerMaruyamaContract`, `SALD.frozenDeltaCrossLipSaldContract` |
| Discrete forward-KL interpolation Fokker--Planck equation | obligation | `appendix.tex:260-381` | `SALD.discreteForwardKlEmInterpolationObligation`, `SALD.discreteForwardKlDerivativeCandidateContract` |
| Discrete EM interpolation endpoint laws | obligation | `appendix.tex:260-266`, `appendix.tex:334-335` | `SALD.discreteForwardKlEmEndpointObligation`, `SALD.discreteForwardKlEmInterpolationSideConditionContract` |
| Discrete EM conditional drift/Fokker--Planck backend | obligation | `appendix.tex:347-385` | `SALD.discreteForwardKlEmConditionalFpObligation`, `SALD.discreteForwardKlEmInterpolationSideConditionContract` |
| Cycle 15 conditional drift density sub-obligation | obligation | `appendix.tex:347-354` | `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract`, `SALD.cycle15DiscreteForwardKlConditionalDriftDensityObligation`; regular conditional law, density, measurability, and integrability input for `bar b_{k,s}` |
| Cycle 15 conditional Fokker--Planck lower packet | obligation | `appendix.tex:347-385` | `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerContract`, `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerObligation`; line ledger for `bar b_{k,s}`, conditional law/density, FP equation, Laplacian split, and KL-derivative handoff |
| Cycle 35 EM interpolation Fokker--Planck upper packet | workflow obligation | `appendix.tex:260-385`, endpoint use `appendix.tex:334-335` | `SALD.cycle35DiscreteForwardKlEmFpUpperPacket`, `SALD.cycle35DiscreteForwardKlEmFpUpperObligation`, `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_upper`; lower target returns to `SALD.discreteForwardKlEmInterpolationSideConditionContract` and `SALD.discreteForwardKlEmConditionalFpObligation` after the Gronwall, DV, LSI/KL/FI, and continuous derivative proof-sprint slices |
| Cycle 35 EM interpolation middle algebra slice | formalized local algebra + obligation | `appendix.tex:260-385`, endpoint use `appendix.tex:334-335` | `SALD.discreteForwardKlEmInterpolationLeftEndpointVector`, `SALD.discreteForwardKlEmInterpolationRightEndpointVector`, `SALD.discreteForwardKlConditionalFpDivergenceDriftSplit`, `SALD.cycle35DiscreteForwardKlEmFpMiddleContract`, `SALD.cycle35DiscreteForwardKlEmFpMiddleObligation`, `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_middle`; stochastic endpoint law, conditional drift density, conditional-FP, Laplacian split, boundary integration by parts, and stitched interval regularity remain obligations |
| Cycle 35 EM conditional-FP lower split handoff | formalized local algebra + obligation | `appendix.tex:357-385` | `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff`, `SALD.cycle35DiscreteForwardKlEmFpLowerObligation`, `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_lower`; the conditional drift density, conditional-FP theorem, Laplacian/chain-rule split, KL derivative integration by parts, endpoint stitching, LSI, DV, Gronwall, and accumulated-error collection remain obligations |
| Cycle 40 EM endpoint law middle handoff | formalized abstract equality handoff + obligation | `appendix.tex:260-385`, endpoint use `appendix.tex:334-335` | `SALD.discreteForwardKlLawEqOfPointwise`, `SALD.discreteForwardKlEmInterpolationLeftEndpointLawHandoff`, `SALD.discreteForwardKlEmInterpolationRightEndpointLawHandoff`, `SALD.cycle40DiscreteForwardKlEmFpMiddleContract`, `SALD.cycle40DiscreteForwardKlEmFpMiddleObligation`, `ASTIS.SALD.forward_KL_discrete.cycle40_em_fp_middle`; concrete law notation, Brownian/EM process definitions, conditional drift density, conditional-FP theorem, Laplacian split, integration by parts, and stitched interval regularity remain obligations |
| Cycle 40 EM endpoint law lower pair handoff | formalized representation handoff + obligation | `appendix.tex:260-266`, `appendix.tex:334-335` | `SALD.discreteForwardKlEmEndpointLawPairHandoff`, `SALD.cycle40DiscreteForwardKlEmEndpointLowerObligation`, `ASTIS.SALD.forward_KL_discrete.cycle40_em_endpoint_lower`; proves the two endpoint law equalities from explicit named-law representation hypotheses for `hat rho_s`, `rho_k^eta`, and `rho_{k+1}^eta`; concrete Brownian/law/density definitions, conditional drift density, conditional-FP, KL derivative, LSI, DV, and Gronwall remain obligations |
| Discrete forward-KL stitched interval regularity | obligation | `appendix.tex:334-335`, `appendix.tex:557-590` | `SALD.discreteForwardKlStitchedIntervalRegularityObligation`, `SALD.discreteForwardKlEmInterpolationSideConditionContract` |
| Cycle 15 discrete forward-KL upper EM-interpolation packet | workflow obligation | `appendix.tex:260-590`, `main_body.tex:299-323` | `SALD.cycle15DiscreteForwardKlUpperPacket`; lower target is `SALD.discreteForwardKlEmInterpolationSideConditionContract` and specifically `SALD.discreteForwardKlEmConditionalFpObligation` |
| Discrete forward-KL frozen score-defect bound | obligation | `appendix.tex:268-330` | `SALD.discreteForwardKlFrozenDeltaObligation`, `SALD.frozenDeltaCrossLipSaldContract` |
| Discrete forward-KL DV finite-log-mgf witness | obligation | `appendix.tex:493-523` | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`, `SALD.discreteForwardKlDvFiniteLogMgfWitnessObligation` |
| Discrete forward-KL DV velocity-energy reuse | obligation + source-cited | `appendix.tex:493-523` | `SALD.discreteForwardKlDvVelocityObligation`, `dvVariationalObligation` |
| Discrete forward-KL Gronwall accumulation | obligation | `appendix.tex:526-592` | `SALD.discreteForwardKlGronwallAccumulationObligation`, `SALD.discreteForwardKlGronwallInstantiationContract` |
| Discrete forward-KL linear slowdown algebra | obligation | `main_body.tex:299-323`, `appendix.tex:557-590` | `SALD.discreteForwardKlLinearSlowdownObligation`, `SALD.discreteForwardKlGronwallInstantiationContract` |
| Discrete forward-KL residual exponent bound | obligation with formalized scalar core | `appendix.tex:557-590`, `main_body.tex:309-323` | `SALD.discreteForwardKlResidualExponentBoundObligation`; scalar order/exponential wrapper formalized as `SALD.discreteForwardKlResidualExponentBoundScalar` and `SALD.discreteForwardKlResidualExpBoundScalar`; interval-integral monotonicity and coefficient identifications remain open |
| Discrete forward-KL accumulated-error endpoint/exponent bridge | obligation | `appendix.tex:557-590`, `main_body.tex:309-323` | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`, `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` |
| Cycle 19 discrete forward-KL accumulated-error upper packet | workflow obligation | `appendix.tex:526-592`, `main_body.tex:299-323` | `SALD.cycle19DiscreteForwardKlUpperPacket`; lower target is exactly `SALD.discreteForwardKlAccumulatedErrorBridgeContract` / `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` / `sald.discrete_forward_kl.accumulated_error_bridge`, with `SALD.discreteForwardKlResidualExponentBoundObligation` as the preferred first lower sub-slice |
| Cycle 19 discrete forward-KL accumulated-error middle packet | workflow obligation | `appendix.tex:557-590`, `main_body.tex:299-323` | `SALD.cycle19DiscreteForwardKlMiddleContract`, `SALD.cycle19DiscreteForwardKlAccumulatedErrorMiddleObligation`; lower-ready map from Gronwall output to residual exponent, endpoint, and integral-collection sub-slices |
| Cycle 23 discrete forward-KL upper coefficient-chain packet | workflow obligation | `main_body.tex:273-323`, `appendix.tex:260-592` | `SALD.cycle23DiscreteForwardKlUpperPacket`; lower target is exactly `SALD.discreteForwardKlCoefficientChainAuditContract` / `SALD.discreteForwardKlCoefficientChainObligation` / `sald.discrete_forward_kl.coefficient_chain_audit`, with the first lower sub-slice `appendix.tex:454-553` coefficient flow |
| Cycle 23 discrete forward-KL middle coefficient-chain packet | workflow obligation | `appendix.tex:454-553`, follow-on `appendix.tex:557-590` and `main_body.tex:309-323` | `SALD.cycle23DiscreteForwardKlMiddleContract`, `SALD.cycle23DiscreteForwardKlCoefficientChainMiddleObligation`; lower-ready map for `sald.discrete_forward_kl.coefficient_chain_audit` preserving the two `1/4*FI` terms, LSI conversion, DV `dot t(s)^2*alpha^(-1)`, and `dot{s}(t)^(-1)*alpha^(-1)` time-change coefficient |
| Discrete forward-KL time-change scalar coefficient rewrite | formalized scalar core | `appendix.tex:526-553` | `SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar`; proves only `dot{s}*dot t^2*coeff = dot{s}^(-1)*coeff` after inverse-schedule identity and nonzero `dot{s}` are supplied |
| Cycle 27 discrete forward-KL upper accumulated-collection packet | workflow obligation | `appendix.tex:557-590`, `main_body.tex:309-323` | `SALD.cycle27DiscreteForwardKlUpperPacket`, `SALD.cycle27DiscreteForwardKlAccumulatedCollectionUpperObligation`; after the coefficient-chain audit, lower target returns to `SALD.discreteForwardKlAccumulatedErrorBridgeContract` / `sald.discrete_forward_kl.accumulated_error_bridge`, first sub-slice `endpointBridge` plus `alphaComplexityCollection` and `deltaAccumulation` while residual-exponent monotonicity, barGamma identification, endpoint stitching, and Gronwall remain obligations |
| Cycle 27 discrete forward-KL middle accumulated-collection packet | workflow/source-to-Lean obligation | `appendix.tex:557-590`, `main_body.tex:309-323` | `SALD.cycle27DiscreteForwardKlMiddleContract`, `SALD.cycle27DiscreteForwardKlAccumulatedCollectionMiddleObligation`; lower-ready map for the accumulated-error bridge with first sub-slice `endpointBridge`, `alphaComplexityCollection`, and `deltaAccumulation`, while residual exponent, `barGamma`, endpoint stitching, coefficient integrability, and Gronwall stay separate obligations |
| Cycle 27 lower discrete accumulated-error additive collection core | formalized scalar/integral sublemmas + obligation | `appendix.tex:586-588`, `main_body.tex:316-323` | `SALD.discreteForwardKlAlphaComplexityCollectionScalar`, `SALD.discreteForwardKlDeltaAccumulationScalar`, `SALD.discreteForwardKlAccumulatedErrorCollectionScalar`, `SALD.cycle27DiscreteForwardKlAccumulatedCollectionLowerObligation`; endpoint stitching, source definitions of `A_alpha` and `barDelta`, residual exponent, `barGamma`, and Gronwall remain obligations |
| Discrete forward-KL EM/defect/accumulation middle packet | obligation | `appendix.tex:260-590`, `main_body.tex:309-323` | `SALD.cycle11DiscreteForwardKlMiddleContract`, `SALD.discreteForwardKlEmDefectAccumulationMiddleObligation` |
| Discrete forward-KL coefficient chain audit | obligation | `main_body.tex:309-323`, `appendix.tex:454-592` | `SALD.discreteForwardKlCoefficientChainAuditContract`, `SALD.discreteForwardKlCoefficientChainObligation`; includes stitched-interval and scalar side-condition ledger |
| Guided-path normalizer derivative | obligation | `appendix.tex:630-656` | `SALD.guidedResidualIdentityContract`, `SALD.guidedResidualNormalizerObligation` |
| Guided-path centered residual identity and mean-zero residual | obligation | `appendix.tex:658-704` | `SALD.guidedResidualIdentityContract`, `SALD.guidedResidualIdentityObligation` |
| Cycle 52 guided/general theorem-route closure | workflow obligation | `appendix.tex:619-951` | `SALD.cycle52GuidedGeneralSkeletonUpperPacket`, `SALD.cycle52GuidedGeneralSkeletonObligation`, `ASTIS.SALD.guided_general.cycle52_upper_route`; re-checks the five slow interfaces and wires `prop:guided_path_residual` plus `thm:general-moving-target-SALD` to the named guided residual, KL-derivative, LSI, residual-DV, Gronwall, and pure-contraction obligations without promoting any backend |
| Cycle 52 middle guided/general route audit | workflow obligation | `appendix.tex:619-951`, preferred lower slice `appendix.tex:765-884` | `SALD.cycle52GuidedGeneralSkeletonMiddleContract`, `SALD.cycle52GuidedGeneralSkeletonMiddleObligation`, `ASTIS.SALD.guided_general.cycle52_middle_route_audit`; verifies the cycle-52 upper route in paper order, keeps `prop:guided_path_residual` and `thm:general-moving-target-SALD` contract-only, and selects `sald.general_moving_target.kl_derivative` as the next lower backend while guided residual, LSI, residual-DV, Gronwall, pure contraction, and downstream EM interfaces remain separate obligations |
| General VA-SALD sigma-weighted KL derivative | obligation | `appendix.tex:765-884` | `SALD.generalMovingTargetDerivativeCandidateContract`, `SALD.generalMovingTargetDerivativeObligation` |
| General VA-SALD residual DV finite-log-mgf witness | obligation | `appendix.tex:885-895` | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`, `SALD.generalMovingTargetDvFiniteLogMgfWitnessObligation` |
| General VA-SALD residual DV positive-alpha scaling | obligation | `appendix.tex:887-907` | `SALD.generalMovingTargetDvPositiveAlphaScalingContract`, `SALD.generalMovingTargetDvPositiveAlphaScalingObligation` |
| General VA-SALD residual DV-energy bound | obligation + source-cited | `appendix.tex:886-907` | `SALD.generalMovingTargetDvEnergyCandidateContract`, `SALD.generalMovingTargetDvEnergyObligation`, `dvVariationalObligation` |
| Cycle 52 lower general moving-target derivative/DV scalar handoff | formalized scalar sublemma + obligation | `appendix.tex:765-907` | `SALD.generalMovingTargetPostDvGronwallCoefficientScalar`, `SALD.generalMovingTargetPostDvGronwallCoefficientOfSigmaScheduleScalar`, `SALD.generalMovingTargetDerivativeDvGronwallCoefficientScalar`, `SALD.cycle52GuidedGeneralDerivativeDvLowerObligation`, `ASTIS.SALD.general_moving_target.cycle52_derivative_dv_lower`; composes supplied general KL derivative/LSI and residual DV inputs into the pre-Gronwall inequality with coefficient `(sigma_t^2/2)*dot{s}(t)*C_LSI(t)-sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)` without proving or promoting analytic backends |
| Cycle 57 lower general moving-target derivative split | formalized scalar sublemma + obligation | `appendix.tex:765-884` | `SALD.generalMovingTargetKlDerivativeResidualSplitScalar`, `SALD.generalMovingTargetKlDerivativePreDvBoundOfSplitScalar`, `SALD.cycle57GuidedGeneralDerivativeSplitLowerObligation`, `ASTIS.SALD.general_moving_target.cycle57_derivative_split_lower`; compiles the raw KL derivative split and residual display handoff before the existing Young/LSI/time-change pipeline, while all analytic Fokker--Planck, integration-by-parts, target-transport, LSI, and schedule backends remain obligations |
| General VA-SALD sigma-weighted Gronwall application | obligation | `appendix.tex:908-934` | `SALD.generalMovingTargetGronwallInstantiationContract`, `SALD.generalMovingTargetGronwallApplicationObligation` |
| General VA-SALD Gronwall endpoint/exponent side conditions | obligation | `appendix.tex:908-945` | `SALD.generalMovingTargetGronwallSideConditionContract`, `SALD.generalMovingTargetGronwallSideConditionObligation`; cycle-24 middle now narrows the preferred first lower sub-slice to coefficient regularity and adjacent interval-integrability |
| Cycle 24 guided/general VA-SALD upper Gronwall side-condition packet | workflow obligation | `appendix.tex:724-951`, `main_body.tex:359-395`, downstream `appendix.tex:1313-1603` | `SALD.cycle24GeneralVaSaldUpperPacket`; lower target is exactly `SALD.generalMovingTargetGronwallSideConditionContract` / `SALD.generalMovingTargetGronwallSideConditionObligation` / `sald.general_moving_target.gronwall_side_conditions`, with the first middle slice `appendix.tex:909-934` against theorem display `appendix.tex:727-743` |
| Cycle 24 guided/general VA-SALD middle Gronwall bridge | workflow obligation | `appendix.tex:909-945`, theorem display `appendix.tex:727-743`, unified display `main_body.tex:372-395` | `SALD.cycle24GeneralVaSaldMiddleContract`, `SALD.cycle24GeneralVaSaldGronwallMiddleObligation`; lower target remains `sald.general_moving_target.gronwall_side_conditions`, with coefficient regularity and adjacent interval-integrability as the preferred first lower sub-slice |
| General VA-SALD pure-contraction specialization | obligation | `appendix.tex:936-945` | `SALD.generalMovingTargetPureContractionObligation` |
| Cycle 16 unified VA-SALD transport bridge middle map | workflow obligation | `main_body.tex:359-368`, `appendix.tex:949-951` | `SALD.cycle16UnifiedForwardKlTransportBridgeMiddleContract`, `SALD.cycle16UnifiedForwardKlTransportBridgeMiddleObligation`; line ledger from residual identity and `eq:poisson-eq` to lower target `sald.unified_forward_kl.transport_velocity_bridge` |
| Cycle 16 unified VA-SALD transport bridge lower slice | obligation | `main_body.tex:359-368`, `appendix.tex:949-951` | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract`, `SALD.cycle16UnifiedForwardKlTransportBridgeLowerObligation`; signed residual/correction cancellation, divergence-linearity backend, and `v_t=u_t+w_t`, `c_t=u_t`, `m_t=w_t` handoff |
| Unified VA-SALD transport-velocity bridge from residual and correction equations | obligation | `main_body.tex:359-368`, `appendix.tex:949-951` | `SALD.cycle16GeneralVaSaldUpperPacket`, `SALD.unifiedForwardKlTransportBridgeObligation`, `sald.unified_forward_kl.transport_velocity_bridge` |
| Unified VA-SALD specialization `c_t <- u_t` and correction-field transport bridge | obligation | `main_body.tex:359-395`, `appendix.tex:949-951` | `SALD.unifiedForwardKlSpecializationContract`, `SALD.unifiedForwardKlSpecializationObligation` |
| Discrete general VA-SALD EM interpolation and conditional Fokker--Planck | obligation | `appendix.tex:957-996`, `appendix.tex:1354-1387` | `SALD.generalVaSaldEulerMaruyamaContract`, `SALD.generalMovingTargetDiscreteEmInterpolationObligation` |
| Discrete general VA-SALD constant-schedule stitching | obligation | `appendix.tex:1315`, `appendix.tex:1573-1600` | `SALD.generalMovingTargetDiscreteConstantScheduleObligation`, `SALD.generalMovingTargetDiscreteGronwallInstantiationContract` |
| General VA-SALD frozen-delta cross Lipschitz lemma | obligation + source-cited | `appendix.tex:1026-1307` | `SALD.generalFrozenDeltaCrossLipContract`, `SALD.generalMovingTargetDiscreteFrozenDeltaObligation`, `dvVariationalObligation` |
| Discrete general VA-SALD derivative side conditions | obligation | `appendix.tex:1354-1600` | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`, `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` |
| Discrete general VA-SALD KL derivative and frozen/residual split | obligation | `appendix.tex:1354-1542` | `SALD.generalMovingTargetDiscreteDerivativeCandidateContract`, `SALD.generalMovingTargetDiscreteDerivativeObligation` |
| Discrete general VA-SALD residual DV finite-log-mgf witness | obligation | `appendix.tex:1544-1552` | `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`, `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessObligation` |
| Discrete general VA-SALD residual DV-energy bound | obligation + source-cited | `appendix.tex:1544-1552` | `SALD.generalMovingTargetDiscreteDvMEnergyObligation`, `dvVariationalObligation` |
| Discrete general VA-SALD Gronwall application | obligation | `appendix.tex:1584-1600`, `appendix.tex:1316-1347` | `SALD.generalMovingTargetDiscreteGronwallApplicationObligation` |
| Discrete general VA-SALD Gronwall endpoint/coefficient side conditions | obligation | `appendix.tex:1573-1600`, `appendix.tex:1316-1347` | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`, `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` |
| Cycle 20 guided/general VA-SALD upper packet | workflow obligation | `appendix.tex:1313-1603`, `appendix.tex:724-951`, `main_body.tex:359-395` | `SALD.cycle20GeneralVaSaldUpperPacket`; lower target is exactly `SALD.generalMovingTargetDiscreteGronwallSideConditionContract` / `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` / `sald.general_moving_target_discrete.gronwall_side_conditions` |
| Cycle 20 guided/general VA-SALD middle Gronwall bridge | workflow obligation | `appendix.tex:1573-1600`, theorem display `appendix.tex:1316-1347` | `SALD.cycle20GeneralVaSaldMiddleContract`, `SALD.cycle20GeneralVaSaldDiscreteGronwallMiddleObligation`; lower target remains `sald.general_moving_target_discrete.gronwall_side_conditions`, with the constant-schedule coefficient rewrite as preferred first sub-slice |
| Cycle 28 guided/general VA-SALD upper derivative-side packet | workflow obligation | `appendix.tex:1354-1598`, preferred sub-slice `appendix.tex:1469-1511`, theorem display `appendix.tex:1316-1347` | `SALD.cycle28GeneralVaSaldUpperPacket`; lower target is exactly `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` / `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` / `sald.general_moving_target_discrete.derivative_side_conditions`, with frozen/residual algebra and the two `sigma_eta^2/8` Young splits first |
| Cycle 28 guided/general VA-SALD middle derivative-side packet | workflow obligation plus scalar bookkeeping core | `appendix.tex:1469-1511` | `SALD.cycle28GeneralVaSaldMiddleContract`, `SALD.cycle28GeneralVaSaldDerivativeSideMiddleObligation`, `SALD.generalMovingTargetDiscreteYoungFisherShareScalar`, `SALD.generalMovingTargetDiscreteTwoYoungFisherBudgetScalar`, `SALD.generalMovingTargetDiscreteResidualYoungCoefficientScalar`; lower target remains `sald.general_moving_target_discrete.derivative_side_conditions` |
| Cycle 28 guided/general VA-SALD lower frozen/residual algebra | formalized module algebra + obligation | `appendix.tex:1469-1478` | `SALD.generalMovingTargetDiscreteFrozenResidualAlgebraVector`, `SALD.cycle28GeneralVaSaldDerivativeSideLowerObligation`; concrete conditional-drift, score, slowed-transport, pointwise field identifications, Young/FI, frozen-delta, LSI, DV, time-change, and Gronwall remain obligations |
| Discrete guided VA-SALD specialization `c <- u` | obligation | `appendix.tex:1603` | `SALD.discreteUnifiedVaSaldSpecializationObligation` |
| Cycle 12 guided/general VA-SALD middle source-to-Lean map | obligation | `appendix.tex:619-951`, `appendix.tex:1354-1603`, `main_body.tex:359-395` | `SALD.cycle12GeneralVaSaldMiddleContract`, `SALD.generalVaSaldGuidedPathMiddleObligation` |
| Cycle 48 unified/discrete general theorem skeleton route | workflow obligation | `main_body.tex:359-395`, `appendix.tex:949-951`, `appendix.tex:1313-1603` | `SALD.cycle48UnifiedDiscreteSkeletonUpperPacket`, `SALD.cycle48UnifiedDiscreteSkeletonObligation`, `SALD.cycle48UnifiedDiscreteSkeletonDag`; wires `thm:unified-forward-KL` through the guided residual/correction-field specialization and `thm:general-moving-target-SALD-discrete` through the general EM, frozen-delta, LSI, residual DV, and Gronwall interfaces while keeping both theorem contracts `contractOnly` |
| Cycle 48 unified/discrete general middle route audit | workflow obligation | `main_body.tex:359-395`, `appendix.tex:949-951`, `appendix.tex:1313-1603` | `SALD.cycle48UnifiedDiscreteSkeletonMiddleContract`, `SALD.cycle48UnifiedDiscreteSkeletonMiddleObligation`, `ASTIS.SALD.unified_discrete_general.cycle48_middle_route_audit`; verifies the upper route against the source proof order and selects `sald.general_moving_target_discrete.kl_derivative` as lower target |
| Cycle 48/49 discrete general EM endpoint/conditional-law audit | formalized endpoint bookkeeping + measure/SDE obligation | `appendix.tex:1354-1387` | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`, `SALD.generalMovingTargetDiscreteEmInterpolationLeftEndpointLawHandoff`, `SALD.generalMovingTargetDiscreteEmInterpolationRightEndpointLawHandoff`, `SALD.generalMovingTargetDiscreteEmEndpointLawPairHandoff`, `SALD.generalMovingTargetDiscreteEmEndpointLawPairOfNamedInterpolation`; the endpoint-law pair now compiles from explicit named-process law representations and pointwise endpoint identities, while common-space construction, regular conditional drift, density/absolute-continuity, and weak Fokker--Planck assumptions remain obligations |
| Cycle 49 main skeleton analytic middle route audit | workflow obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-252`, `appendix.tex:724-951`, `main_body.tex:359-395`, `appendix.tex:1313-1603`, `appendix.tex:1354-1387` | `SALD.cycle49MainSkeletonAnalyticMiddleContract`, `SALD.cycle49MainSkeletonAnalyticMiddleObligation`, `ASTIS.SALD.cycle49.middle_route_audit`; syncs the five analytic interfaces with all six theorem consumers after the upper readiness check and keeps the next lower target at `sald.general_moving_target_discrete.kl_derivative` over the EM endpoint/conditional-law/Fokker--Planck slice |
| Cycle 53 unified/discrete general theorem-route closure | workflow obligation | `main_body.tex:359-395`, `appendix.tex:949-951`, `appendix.tex:1313-1603` | `SALD.cycle53UnifiedDiscreteGeneralUpperPacket`, `SALD.cycle53UnifiedDiscreteGeneralSkeletonObligation`, `ASTIS.SALD.unified_discrete_general.cycle53_upper_route`; wires `thm:unified-forward-KL` through the cycle-52 continuous general route and the correction-field specialization, and wires `thm:general-moving-target-SALD-discrete` through the explicit general EM, derivative, frozen-delta, LSI, residual-DV, and Gronwall interfaces while both theorem contracts remain `contractOnly` |
| Cycle 53 middle unified/discrete general route audit | workflow obligation | `main_body.tex:359-395`, `appendix.tex:949-951`, `appendix.tex:1313-1603`, first lower slice `appendix.tex:1354-1387` | `SALD.cycle53UnifiedDiscreteGeneralMiddleContract`, `SALD.cycle53UnifiedDiscreteGeneralMiddleObligation`, `ASTIS.SALD.unified_discrete_general.cycle53_middle_route_audit`; verifies the upper route against the paper order, keeps the Measure.map endpoint backfill scoped to endpoint laws only, wires both downstream theorem contracts to the middle audit, and keeps `sald.general_moving_target_discrete.kl_derivative` as the next lower backend |
| Cycle 53 discrete general Measure.map endpoint-law backfill | formalized narrow measure handoff + obligation | `appendix.tex:1354-1387` | `AutoSamplingTheory.lawMapEqOfAEEq`, `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation`, `ASTIS.SALD.general_moving_target_discrete.cycle53_measure_map_endpoint_backfill`; proves only the a.e.-equality-to-`Measure.map` endpoint handoff from named interpolation identities and update equality, while common-space construction, regular conditional drift, density/absolute-continuity, weak Fokker--Planck, and KL derivative inputs remain obligations |
| Cycle 53 lower discrete general derivative/DV scalar handoff | proof-producing scalar core plus obligation | `appendix.tex:1469-1583` | `SALD.generalMovingTargetDiscretePostYoungDerivativeBoundScalar`, `SALD.generalMovingTargetDiscretePostLsiDerivativeBoundScalar`, `SALD.generalMovingTargetDiscretePostDvDerivativeBoundScalar`, `SALD.generalMovingTargetDiscreteTimeChangedDerivativeBoundScalar`, `SALD.generalMovingTargetDiscreteDerivativeDvTimeChangedScalar`, `SALD.cycle53GeneralMovingTargetDiscreteDerivativeDvLowerObligation`, `ASTIS.SALD.general_moving_target_discrete.cycle53_derivative_dv_lower`; composes supplied EM KL derivative, frozen/residual Young bounds, frozen-delta term, LSI comparison, residual DV estimate, and constant-schedule time change into the exact t-time pre-Gronwall inequality without proving or promoting analytic backends |
| Cycle 54 analytic interface re-check | workflow obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-252`, `appendix.tex:765-884`, `appendix.tex:1354-1387` | `SALD.cycle54MainSkeletonAnalyticInterfaceLedger`, `SALD.cycle54MainSkeletonAnalyticInterfaceObligation`, `ASTIS.SALD.cycle54.analytic_interface_recheck`; re-checks Gronwall, DV, LSI-to-KL/FI, continuous Fokker--Planck/KL derivative, and EM interpolation Fokker--Planck interfaces after theorem-route wiring, lists the obligation on all six theorem contracts, and keeps `appendix.tex:1354-1387` as the next lower backend |
| Cycle 54 middle analytic interface audit | workflow obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-252`, `appendix.tex:724-951`, `main_body.tex:359-395`, `appendix.tex:1313-1603`, `appendix.tex:1354-1387` | `SALD.cycle54MainSkeletonAnalyticMiddleContract`, `SALD.cycle54MainSkeletonAnalyticMiddleObligation`, `ASTIS.SALD.cycle54.middle_interface_audit`; verifies the upper ledger is consumed by all six theorem nodes in paper order, adds the middle obligation to those theorem contracts, and keeps the lower packet on `sald.general_moving_target_discrete.kl_derivative` without promoting any analytic backend |
| Cycle 54 lower discrete general EM FP sigma split | formalized algebra plus obligation | `appendix.tex:1380-1387` | `SALD.generalMovingTargetDiscreteConditionalFpSigmaLaplacianSplitHandoff`, `SALD.cycle54GeneralMovingTargetDiscreteEmFpLowerObligation`, `ASTIS.SALD.general_moving_target_discrete.cycle54_em_fp_sigma_split`; proves only the sigma-weighted divergence regrouping from supplied FP/Laplacian/linearity hypotheses, while common-space construction, regular conditional drift, density/AC, weak Fokker--Planck, KL differentiation, mass conservation, integration by parts, and stitching remain obligations |
| Cycle 77 upper weak conditional FP source-sign backend | workflow obligation | `appendix.tex:1358-1387`, especially `appendix.tex:1379-1387` | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract`, cycle-72 source-sign wrappers, `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorHandoff`, and `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`; selects the missing analytic weak conditional Fokker--Planck theorem/interface with negative `-div(hat rho_s*bar b_{k,s})` drift and positive `+(sigma_eta^2/2)*Delta hat rho_s` diffusion under explicit conditional-law, density, admissible-test, covariance, and boundary hypotheses, while reusing existing sign/coefficient wrappers and keeping EM FP, KL, LSI/KL/FI, DV, Gronwall, and theorem closures below formalized status |
| Cycle 55 continuous forward-KL skeleton route | workflow obligation | `main_body.tex:238-247`, `appendix.tex:164-252` | `SALD.cycle55ForwardKlSkeletonUpperPacket`, `SALD.cycle55ForwardKlSkeletonObligation`, `ASTIS.SALD.forward_KL.cycle55_continuous_skeleton_route`; consumes the cycle-54 five-backend re-check and the cycle-50 continuous route, wires derivative -> LSI -> DV -> Gronwall for `thm:forward-KL`, keeps the theorem `contractOnly`, and leaves `sald.forward_kl.kl_derivative` as the lower backend |
| Cycle 55 middle continuous forward-KL route audit | workflow obligation | `main_body.tex:238-247`, `appendix.tex:164-252`, lower slice `appendix.tex:168-228` | `SALD.cycle55ForwardKlSkeletonMiddleContract`, `SALD.cycle55ForwardKlSkeletonMiddleObligation`, `ASTIS.SALD.forward_KL.cycle55_middle_route_audit`; verifies the cycle-55 upper route in paper order, adds the middle obligation to `SALD.continuousSaldContract`, and keeps lower work on `sald.forward_kl.kl_derivative` while LSI/KL/FI, DV, Gronwall, and EM interpolation stay separate obligations |
| Cycle 58 middle unified/discrete general route audit | workflow obligation | `main_body.tex:359-395`, `appendix.tex:949-951`, `appendix.tex:1313-1603`, lower slice `appendix.tex:1573-1600` | `SALD.cycle58UnifiedDiscreteGeneralMiddleContract`, `SALD.cycle58UnifiedDiscreteGeneralMiddleObligation`, `ASTIS.SALD.unified_discrete_general.cycle58_middle_route_audit`; verifies the upper route against the paper order, wires both downstream theorem contracts to the middle audit, and selects `sald.general_moving_target_discrete.gronwall_side_conditions` as the next lower backend |
| Cycle 58 lower discrete general Gronwall input wrapper | formalized local real/order core plus obligation | `appendix.tex:1573-1600` | `SALD.generalMovingTargetDiscretePointwiseGronwallInputOfPostDvTimeChanged`; packages the supplied post-DV `s`-time inequality and inverse-schedule identities into the pointwise `K'(t) <= -a(t)K(t)+b(t)` input for `lem:gronwall`; stitched endpoint laws, coefficient regularity, the Gronwall theorem, and exact theorem-display matching remain in `sald.general_moving_target_discrete.gronwall_side_conditions` |
| Cycle 59 analytic interface ledger | workflow obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-252`, `appendix.tex:260-385`, `appendix.tex:724-951`, `appendix.tex:1313-1603`, `appendix.tex:1573-1600` | `SALD.cycle59MainSkeletonAnalyticInterfaceLedger`, `SALD.cycle59MainSkeletonAnalyticInterfaceObligation`, `SALD.cycle59MainSkeletonAnalyticInterfaceDag`; records that cycle 58 passed and needs no recovery, Phase 1 is stable only for one narrow backend backfill, and the largest remaining risk is `sald.general_moving_target_discrete.gronwall_side_conditions`; rechecks Gronwall, DV, LSI/KL/FI, continuous FP/KL derivative, and EM interpolation FP interfaces across all six theorem contracts while keeping unproved backends below formalized |
| Cycle 59 middle analytic interface audit | workflow obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-252`, `appendix.tex:260-592`, `appendix.tex:619-951`, `main_body.tex:359-395`, `appendix.tex:1313-1603`, lower slice `appendix.tex:1573-1600` | `SALD.cycle59MainSkeletonAnalyticMiddleContract`, `SALD.cycle59MainSkeletonAnalyticMiddleObligation`, `ASTIS.SALD.cycle59.middle_interface_audit`; verifies the cycle-59 upper ledger against all six theorem consumers in paper order, adds the middle obligation to those theorem contracts, and keeps the lower packet exactly on `sald.general_moving_target_discrete.gronwall_side_conditions` without promoting any analytic backend |
| Cycle 59 lower discrete general Gronwall/display wrappers | formalized local Real/logical wrappers plus obligation | `appendix.tex:1573-1600`, theorem display `appendix.tex:1316-1347` | `SALD.generalMovingTargetDiscreteGronwallNamedCoefficientInput`, `SALD.generalMovingTargetDiscreteGronwallEndpointRewriteScalar`, `SALD.cycle59GeneralMovingTargetDiscreteGronwallLowerObligation`; names the final Gronwall `a(t)`, `b(t)` functions from the cycle-58 pointwise derivative input and rewrites a supplied Gronwall bound from `K(0)`, `K(T)` to the theorem KL endpoints; endpoint laws, coefficient regularity, endpoint-safe Gronwall, and exact theorem-display instantiation remain in `sald.general_moving_target_discrete.gronwall_side_conditions` |
| Cycle 60 upper continuous forward-KL post-ledger route | workflow obligation | `main_body.tex:238-247`, `appendix.tex:164-252`, lower slice `appendix.tex:168-228` | `SALD.cycle60ForwardKlSkeletonUpperPacket`, `SALD.cycle60ForwardKlSkeletonObligation`, `SALD.cycle60ForwardKlSkeletonDag`, `ASTIS.SALD.forward_KL.cycle60_post_cycle59_route`; records that cycle 59 passed and needs no recovery, keeps Phase 1 on theorem-level wiring rather than broad backfill, checks the five slow interfaces, wires `thm:forward-KL` through derivative/LSI/DV/Gronwall in paper order, and selects `sald.forward_kl.kl_derivative` as the lower packet without promoting any analytic backend |
| Cycle 60 middle continuous forward-KL route audit | workflow obligation | `main_body.tex:238-247`, `appendix.tex:164-252`, lower slice `appendix.tex:168-228` | `SALD.cycle60ForwardKlSkeletonMiddleContract`, `SALD.cycle60ForwardKlSkeletonMiddleObligation`, `ASTIS.SALD.forward_KL.cycle60_middle_route_audit`; verifies the post-cycle-59 upper route against the paper order, adds the middle obligation to `SALD.continuousSaldContract`, keeps `sald.forward_kl.kl_derivative` as the selected lower packet, and leaves LSI/KL/FI, DV, Gronwall, and EM interpolation as separate source-cited or obligation interfaces |
| Cycle 60 lower continuous forward-KL raw derivative wrapper | formalized scalar wrapper plus obligation | `appendix.tex:168-228` | `SALD.forwardKlPreDvDerivativeBoundOfRawKlFiVelocityScalingScalar`, `SALD.cycle60ForwardKlDerivativeRawLowerObligation`, `ASTIS.SALD.forward_KL.cycle60_derivative_raw_lower`; starts from the raw KL derivative split with the mass term, consumes supplied mass-conservation, first-term `-FI`, target Cauchy, LSI/KL/FI, slowed-velocity, and inverse-schedule inputs, and derives the t-time pre-DV derivative inequality without proving or promoting the analytic backends |
| Cycle 61 upper discrete forward-KL recovered route | workflow obligation | `main_body.tex:299-323`, `appendix.tex:260-592`, lower slice `appendix.tex:557-590` and `main_body.tex:309-323` | `SALD.cycle61DiscreteForwardKlSkeletonUpperPacket`, `SALD.cycle61DiscreteForwardKlSkeletonObligation`, `SALD.cycle61DiscreteForwardKlSkeletonDag`, `ASTIS.SALD.forward_KL_discrete.cycle61_recovered_theorem_route`; recovers the interrupted cycle-56 discrete route after the cycle-60 pass, checks the five slow interfaces, and selects `sald.discrete_forward_kl.accumulated_error_bridge` while keeping theorem status `contractOnly` |
| Cycle 61 middle discrete forward-KL route audit | workflow obligation | `main_body.tex:299-323`, `appendix.tex:260-592`, selected bridge `appendix.tex:557-590` plus `main_body.tex:309-323` | `SALD.cycle61DiscreteForwardKlSkeletonMiddleContract`, `SALD.cycle61DiscreteForwardKlSkeletonMiddleObligation`, `ASTIS.SALD.forward_KL_discrete.cycle61_middle_route_audit`; verifies the recovered route in paper order, adds the middle obligation to `SALD.discreteSaldContract`, reuses the cycle-56 pointwise Gronwall input, and keeps lower work on accumulated-error display matching without promoting EM/Fokker--Planck, LSI/KL/FI, DV, Gronwall, or accumulated-error backends |
| Cycle 61 lower discrete forward-KL residual display wrapper | formalized scalar wrapper plus obligation | `appendix.tex:573-589`, `main_body.tex:316-323` | `SALD.discreteForwardKlResidualIntegralDisplayBoundScalar`, `SALD.cycle61DiscreteForwardKlAccumulatedErrorLowerObligation`; after a separate residual-exponent argument supplies the common positive exponential factor, plugs the compiled `A_alpha` and `barDelta` collection scalars into the exact main-body additive display while leaving EM/Fokker--Planck, endpoint stitching, residual-exponent monotonicity, and barGamma/barDelta source identifications as obligations |
| Cycle 63 upper unified/discrete general route refresh | workflow obligation | `main_body.tex:359-395`, `appendix.tex:949-951`, `appendix.tex:1313-1603`, endpoint slice `appendix.tex:1354-1387` | `SALD.cycle63UnifiedDiscreteGeneralSkeletonUpperPacket`, `SALD.cycle63UnifiedDiscreteGeneralSkeletonObligation`, `SALD.cycle63UnifiedDiscreteGeneralDag`, `ASTIS.SALD.unified_discrete_general.cycle63_upper_route`; records that cycle 62 passed, rechecks the five slow interfaces, wires `thm:unified-forward-KL` through guided residual/correction/general theorem reuse, wires `thm:general-moving-target-SALD-discrete` through EM, frozen-delta, derivative/LSI, residual DV, and Gronwall interfaces, and keeps both theorem contracts `contractOnly` |
| Cycle 63 middle unified/discrete general route audit | workflow obligation | `main_body.tex:359-395`, `appendix.tex:949-951`, `appendix.tex:1313-1603`, lower slice `appendix.tex:1358-1387` | `SALD.cycle63UnifiedDiscreteGeneralMiddleContract`, `SALD.cycle63UnifiedDiscreteGeneralMiddleObligation`, `ASTIS.SALD.unified_discrete_general.cycle63_middle_route_audit`; verifies the upper route in source order, keeps paired endpoint-law backfill scoped to `appendix.tex:1354-1357`, and selects the conditional-law/Fokker--Planck backend as the next lower packet |
| Cycle 63 paired endpoint-law measure backfill | formalized local measure helper plus obligation | `appendix.tex:1354-1357`; local SLT Measure.map/a.e. patterns | `AutoSamplingTheory.lawMapProdEqOfAEEq`, `AutoSamplingTheory.lawMapProdFst`, `AutoSamplingTheory.lawMapProdSnd`, `SALD.generalMovingTargetDiscreteEmJointEndpointMeasureMapOfNamedInterpolation`, `SALD.generalMovingTargetDiscreteEmJointEndpointMarginalLawsOfNamedInterpolation`, `SALD.cycle63UnifiedDiscreteGeneralMeasureBackfillObligation`, `ASTIS.SALD.general_moving_target_discrete.cycle63_joint_endpoint_law_backfill`; proves only that componentwise a.e. endpoint equality gives equality of paired `Measure.map` pushforward laws and measurable projection recovers the two marginal endpoint laws on a common space, while Brownian/EM construction, regular conditional drift, density/AC, weak Fokker--Planck, KL differentiation, and stitched Gronwall remain obligations |

## Cycle 59 Middle Analytic Interface Audit

Middle synchronized the upper cycle-59 analytic ledger into
`SALD.cycle59MainSkeletonAnalyticMiddleContract`,
`SALD.cycle59MainSkeletonAnalyticMiddleObligation`, and DAG node
`ASTIS.SALD.cycle59.middle_interface_audit`.

Source-to-Lean checks:

| Source block | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:47-79` | `SALD.saldGronwallEndpointCalculusContract`; `dvVariationalFormulaInterface saldDvVariationSource` | endpoint-safe Gronwall semantics and source-cited DV common-space/finite-log-mgf witnesses |
| `main_body.tex:202-215` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | zero-set convention, admissible sqrt-density test or approximation, entropy identity, vector Fisher chain rule |
| `appendix.tex:168-252` and `appendix.tex:724-951` | continuous forward-KL and general moving-target derivative scalar handoffs | Fokker-Planck/KL differentiation, boundary, mass conservation, target transport, schedule calculus |
| `appendix.tex:260-592` and `appendix.tex:1313-1603` | EM endpoint/conditional-FP interfaces, frozen-delta, LSI, residual DV, and Gronwall route | conditional drift, density/AC, weak FP, KL differentiation, endpoint stitching, coefficient regularity |
| `appendix.tex:1573-1600` | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `SALD.generalMovingTargetDiscretePointwiseGronwallInputOfPostDvTimeChanged`; `sald.general_moving_target_discrete.gronwall_side_conditions` | selected lower packet: endpoint stitching for `K(t)`, constant-schedule admissibility, coefficient regularity, endpoint-safe Gronwall, and exact theorem-display matching |

Lower packet remains exactly
`SALD.generalMovingTargetDiscreteGronwallSideConditionContract` /
`SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` /
`sald.general_moving_target_discrete.gronwall_side_conditions` over
`appendix.tex:1573-1600`.  No theorem statement, source constant, source label,
SLT reuse status, theorem status, or slow analytic backend status is promoted
or changed.

## Cycle 59 Lower Gronwall/Display Packet

Lower added two compiled wrappers for the selected
`sald.general_moving_target_discrete.gronwall_side_conditions` packet.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1584-1597`: after the cycle-58 pointwise derivative input, introduce the named Gronwall coefficient functions `a(t)` and `b(t)` matching `eq:general_KL_derivative_8_discrete`. | `SALD.generalMovingTargetDiscreteGronwallNamedCoefficientInput` | formalized local display-matching wrapper |
| `appendix.tex:1600` plus display `appendix.tex:1316-1347`: after a Gronwall bound is supplied for `K`, rewrite `K(T)` and `K(0)` to `KL(rho_K^eta||pi_T)` and `KL(rho_0||pi_0)`. | `SALD.generalMovingTargetDiscreteGronwallEndpointRewriteScalar` | formalized local endpoint-rewrite wrapper |

The synchronized obligation is
`SALD.cycle59GeneralMovingTargetDiscreteGronwallLowerObligation` /
`sald.general_moving_target_discrete.cycle59_gronwall_lower`.  It does not
prove EM endpoint stitching, coefficient continuity or integrability,
endpoint-safe Gronwall, DV, LSI/KL/FI, KL differentiation, or the conditional
Fokker--Planck backend.

## Cycle 60 Upper Continuous Forward-KL Route

Global phase judgment: cycle 59 passed reviewer/build, so no failed cycle needs
recovery.  Phase 1 theorem-skeleton translation is stable enough for focused
continuous `thm:forward-KL` interface wiring, but not for broad cited-theory or
reusable API backfill.  The single lower packet that best reduces the current
proof risk is `SALD.forwardKlDerivativeCandidateContract` /
`SALD.forwardKlDerivativeObligation` / `sald.forward_kl.kl_derivative` over
`appendix.tex:168-228`.

Five slow interfaces checked before assigning lower work:

| Backend | Lean-facing interface | Status discipline |
|---|---|---|
| endpoint-safe Gronwall | `SALD.saldGronwallEndpointCalculusContract`, `SALD.forwardKlGronwallSideConditionContract`, `sald.forward_kl.gronwall_side_conditions` | obligation |
| Donsker-Varadhan | `dvVariationalFormulaInterface saldDvVariationSource`, `SALD.saldDvFiniteLogMgfContract`, `SALD.forwardKlDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| LSI/KL/FI | `SALD.saldLsiKlFiDensityTestContract`, `probability.lsi_to_kl_fi` | obligation |
| continuous FP/KL derivative | `SALD.forwardKlDerivativeCandidateContract`, `SALD.forwardKlDerivativeSideConditionContract`, `sald.forward_kl.kl_derivative` | selected obligation |
| EM interpolation FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`, `sald.discrete_forward_kl.em_interpolation_fp` | downstream discrete obligation |

The theorem route remains exactly
`appendix.tex:168-228` derivative/Fokker-Planck and time change,
`appendix.tex:230-241` DV velocity-energy, and `appendix.tex:244-252`
Gronwall endpoint/exponent display matching.  `main_body.tex:238-247` is not
restated, and `SALD.continuousSaldContract` remains `contractOnly`.

## Cycle 60 Lower Continuous Forward-KL Raw Derivative Wrapper

Lower compiled one local scalar wrapper for the selected
`sald.forward_kl.kl_derivative` backend:
`SALD.forwardKlPreDvDerivativeBoundOfRawKlFiVelocityScalingScalar`.

Source-to-Lean map:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:168-174`: the differentiated KL display has an explicit mass term, then the paper drops it using `int partial_s rho_s dx=0`. | `SALD.forwardKlPreDvDerivativeBoundOfRawKlFiVelocityScalingScalar`, reusing `SALD.forwardKlMassConservationDropScalar` | formalized Real equality wrapper; mass conservation and differentiation-under-integral remain obligations |
| `appendix.tex:176-208`: SALD Fokker--Planck/integration by parts gives `firstTerm=-FI`; target transport and Cauchy/Young give the one-half split. | existing `SALD.forwardKlPreDvDerivativeBoundOfKlFiVelocityScalingScalar` route consumed by the new wrapper | formalized scalar/order composition only; Fokker--Planck, boundary, target transport, and L2/FI identification remain obligations |
| `appendix.tex:210-228`: LSI and inverse schedule produce the t-time pre-DV derivative inequality. | `SALD.cycle60ForwardKlDerivativeRawLowerObligation`; `ASTIS.SALD.forward_KL.cycle60_derivative_raw_lower` | obligation ledger for the analytic inputs; theorem status remains `contractOnly` |

This lower packet does not prove or promote continuous Fokker--Planck/KL
differentiation, LSI/KL/FI, DV, Gronwall, inverse-function calculus, or
`thm:forward-KL`.

## Cycle 32 Upper Packet

Proof-closure priority check: (1) `lem:gronwall` remains an obligation after
cycle 31 partial sublemmas; cycle 32 follows the requested item (2)
`lem:dv_variation`; (3) `eq:LSI-KL-FI`, (4) the forward-KL
Fokker--Planck/KL derivative identity, and (5) the EM interpolation
Fokker--Planck backend remain later proof-closure targets.

Objective: sharpen `appendix.tex:73-79` into the precise source-cited
Donsker--Varadhan interface recorded by `dvVariationalFormulaInterface
saldDvVariationSource`, `SALD.cycle32DvVariationUpperPacket`, and
`SALD.cycle32DvVariationInterfaceObligation`.

Lower packet: first check for a usable local Mathlib entropy-duality theorem.
If none is available, keep DV source-cited and refine only the interface:
same-space probabilities `mu,nu`, measurable real tests `Z`, finite predicate
`\log E_mu[\exp Z] < +\infty`, the supremum equality, and the one-sided
consequence used by SALD theorem blocks.  Theorem-specific common-space,
absolute-continuity, measurability, alpha0-to-alpha finite-log-mgf, and
positive-alpha scaling witnesses remain obligations.

Reviewer checklist: `SALD.dvContract` and `SALD.saldStatusForLabel
"lem:dv_variation"` stay `sourceCited`; no `axiom`, `sorry`, `admit`,
`Prop := True`, or `:= trivial` closes DV; conversion-window and cited-results
notes classify this as source-cited interface refinement, not formalization.

Middle update: local Mathlib contains `klDiv` and `Measure.tilted` support but
no immediately usable entropy-duality theorem matching `appendix.tex:73-79`.
`AutoSamplingTheory.dvVariationalOneSidedConsequenceScalar` now compiles the
post-DV real-order step only:
`expectation - logMgf <= kl -> expectation <= kl + logMgf`.  The analytic
input `expectation - logMgf <= kl` must still come from the cited DV formula
or a future local port, and theorem-specific common-space, measurability, and
finite-log-mgf witnesses remain obligations.

Lower update: `AutoSamplingTheory.dvVariationalOneSidedFromSupremumScalar`
now compiles the next scalar order step: from a bounded set of admissible real
variational values, membership of the selected test value, and the source
supremum identity `sSup admissibleValues = KL`, derive the same one-sided DV
bound.  This still starts after the cited Boucheron theorem supplies the
supremum identity and after theorem-specific admissibility/finite-log-mgf
witnesses are supplied.

## Cycle 37 Upper Packet

Proof-closure priority check: (1) `lem:gronwall` was advanced in cycle 36 by a
compiled global assembly under explicit Mathlib side conditions, but the
source-level endpoint-safe differentiability/derivative-witness bridge remains
open, so the contract stays `obligation`; (2) this cycle selects
`lem:dv_variation`; (3) `eq:LSI-KL-FI`, (4) the forward-KL
Fokker--Planck/KL derivative identity, and (5) the EM interpolation
Fokker--Planck backend remain later proof-closure targets.

Objective: translate `appendix.tex:73-79` and the cited Boucheron Corollary
4.15 result into either a genuinely compiling Mathlib-backed Lean interface or
a sharper source-cited theorem interface.  The source statement is fixed:
same-space probabilities `mu,nu`, real random variables `Z`, finite predicate
`\log E_mu[\exp Z] < +\infty`, and the equality
`KL(nu||mu)=sup_Z(E_nu[Z]-log E_mu[exp Z])`.

Lower packet:

- target exactly one declaration/interface around
  `dvVariationalFormulaInterface saldDvVariationSource`,
  `probability.dv_variational_formula`, and
  `SALD.saldDvFiniteLogMgfContract`;
- start from the existing Mathlib audit: `InformationTheory.KullbackLeibler.Basic`
  supplies `klDiv` infrastructure and `MeasureTheory.Measure.Tilted` supplies
  tilted-measure/log-likelihood infrastructure, but no ready entropy-duality
  theorem matching `appendix.tex:73-79` is currently available;
- if no local proof builds, keep the result source-cited and refine the
  theorem interface with explicit common-space, absolute-continuity,
  measurability, finite-KL, and finite-log-mgf hypotheses;
- use `AutoSamplingTheory.dvVariationalOneSidedConsequenceScalar` and
  `AutoSamplingTheory.dvVariationalOneSidedFromSupremumScalar` only as
  post-DV real-order consequences, not as a proof of the variational formula;
- do not add new finite-mgf or absolute-continuity assumptions to
  `thm:forward-KL` or any downstream theorem.

Reviewer checklist:

- `SALD.dvContract` and `SALD.saldStatusForLabel "lem:dv_variation"` remain
  `sourceCited`;
- `SALD.saldDependenciesForLabel "lem:dv_variation"` names the cycle 37 packet
  and keeps the cycle 32 scalar bridges as post-DV consequences;
- conversion-window and cited-results notes classify this as source-cited DV
  equality/proof-target sharpening, with no SLT import and no claim that the
  Boucheron supremum formula is formalized;
- no `axiom`, `sorry`, `admit`, `Prop := True`, `:= trivial`, hidden theorem
  assumption, source-file drift, or alternate entropy route is introduced.

Middle update: `AutoSamplingTheory.dvVariationalOneSidedOfTiltedRight` now
compiles the one-sided admissible-test inequality
`E_nu[Z]-log E_mu[exp Z] <= KL(nu||mu)` under explicit Mathlib hypotheses:
probability measures on a common measurable space, `nu << mu`, integrability
of `Z` under `nu`, integrability of `exp Z` under `mu`, and integrability of
`llr nu mu` under `nu`.  The proof uses `mu.tilted Z`,
absolute-continuity into the tilted law, Gibbs nonnegativity for KL, and the
tilted-right log-likelihood integral identity.  This is recorded by
`SALD.cycle37DvVariationMiddleAuditContract` and
`SALD.cycle37DvVariationMiddleObligation`; the Boucheron supremum equality
and all SALD theorem-specific common-space/measurability/finite-log-mgf
witnesses remain explicit source-cited dependencies or obligations.

Lower update: `AutoSamplingTheory.dvVariationalTiltedRightOneSidedConsequence`
now compiles the paper-consumed one-sided consequence
`E_nu[Z] <= KL(nu||mu)+log E_mu[exp Z]` by composing the tilted-measure
backend with `AutoSamplingTheory.dvVariationalOneSidedConsequenceScalar`.
This is recorded by `SALD.cycle37DvVariationLowerObligation`.  It does not
prove the Boucheron supremum equality, and it does not discharge the
theorem-specific common-space, absolute-continuity, measurability,
finite-log-mgf, or finite-KL/log-likelihood witnesses needed before a SALD
squared-velocity or residual test can use the theorem.

## Cycle 42 DV Selected Scaled-Test Middle Update

Proof-closure priority check: cycle 41 advanced `lem:gronwall` but did not
close the source endpoint-safe differentiability/FTC bridge, so this middle
pass returns to item (2), `lem:dv_variation`, before LSI/KL/FI, the
forward-KL derivative, and EM interpolation.

`AutoSamplingTheory.dvFiniteLogMgfOfLeAlpha` now compiles the local
finite-log-mgf monotonicity needed for selected SALD tests:
`Integrable exp(alpha0*q)` implies `Integrable exp(alpha*q)` for
`0 <= alpha <= alpha0` under a finite measure.  The declaration
`AutoSamplingTheory.dvVariationalOneSidedOfScaledTest` then applies the
existing tilted one-sided backend to `Z=alpha*q`.

This does not prove Boucheron Corollary 4.15, does not mark
`probability.dv_variational_formula`, `SALD.dvContract`, or
`SALD.saldStatusForLabel "lem:dv_variation"` formalized, and does not
discharge theorem-specific common-space, absolute-continuity, selected-test
integrability, or log-likelihood integrability witnesses.

## Cycle 42 DV Selected Scaled-Test Lower Update

`AutoSamplingTheory.dvVariationalScaledTestEnergyBound` now compiles the
post-DV selected-test energy bridge used by the first SALD application:
from the explicit hypotheses for `Z=alpha*q`, `alpha>0`, and
`eAlpha = alpha^{-1} log E_mu[exp(alpha*q)]`, it derives
`E_nu[q] <= alpha^{-1} KL(nu||mu) + eAlpha`.  The companion theorem
`AutoSamplingTheory.dvVariationalScaledTestEnergyBoundWithCoeff` preserves a
nonnegative downstream coefficient before Gronwall.

This is still below the cited Boucheron formula.  It keeps
`SALD.cycle42DvVariationLowerObligation` as an obligation for the theorem
instances and leaves common-space, absolute-continuity, selected-test
integrability, alpha0 finite-mgf, and log-likelihood witnesses explicit.

## Cycle 1 Lower Packet

Recommended lower objective: refine `SALD.gronwallAnalyticObligation` into a
candidate Lean statement only after checking Mathlib's real integration and
differentiation APIs.  The statement must preserve:

- the source hypotheses: continuous `a_t`, continuous `b_t`, differentiable
  `K_t` on `[0,t_1]`;
- the differential inequality `dK_t/dt <= -a_t K_t + b_t`;
- the two exponential factors exactly as displayed in `appendix.tex:50-52`.

Non-goals for this cycle:

- do not prove or restate `thm:forward-KL`;
- do not replace DV with Pinsker, Talagrand, or another entropy inequality;
- do not introduce extra sign, boundedness, or positivity assumptions unless
  recorded as a source gap.

Reviewer checklist:

- `sald_version_2.tex` remains excluded from the source index;
- every first-DAG row has a source label and Lean-facing contract;
- source-cited DV is not marked formalized;
- Gronwall remains an obligation unless a compiled Lean theorem replaces it;
- KL/FI/LSI/PI vocabulary is not closed by `axiom`, `sorry`, `admit`,
  `Prop := True`, or `:= trivial`.

### Lower Cycle 1 Refinement

`SALD.saldGronwallCandidateContract` records the candidate Lean-facing
interface for `lem:gronwall` without promoting it to a theorem.  The intended
Mathlib route is:

| Source proof step | Candidate local API | Current status |
|---|---|---|
| define the integrating factor `exp(\int_0^t a_u du)` | `intervalIntegral` over `MeasureTheory.volume`, `Real.exp` | audited |
| differentiate the product with `K_t` | `Real.hasDerivAt_exp`, chain/product derivative rules | audited |
| integrate the pointwise differential inequality | FTC and integration-by-parts lemmas for `intervalIntegral` | audited |
| handle the source phrase "differentiable on `[0,t_1]`" | endpoint-safe `HasDerivWithinAt` or equivalent closed-interval formulation | tracked by `SALD.saldGronwallEndpointCalculusContract` |

No sign, constant, or endpoint expression has been changed from
`appendix.tex:47-71`.

## Cycle 5 Upper Packet

Objective: re-audit the source-index and first appendix/vocabulary layer.  The
Lean first-DAG wiring now treats `eq:LSI-KL-FI` as an explicit source node
alongside `lem:gronwall`, `lem:dv_variation`, and `def:PI`, rather than only as
an implicit dependency of later KL theorems.

Mode discipline:

- `faithfulPaper`; use the original source files under
  `/home/nitanda_sub/mark/repos/sald/paper` and keep `sald_version_2.tex` out
  of source correspondence;
- preserve the source LSI display, KL/FI definitions, Gronwall signs, DV
  formula, and PI inequality exactly;
- keep LSI-to-KL/FI, Gronwall, and DV at `obligation` or `sourceCited` status
  until local Lean proofs replace them.

Lower packet:

- target one interface among `SALD.saldLSIContract`, `SALD.saldKLContract`,
  `SALD.saldFIContract`, and `SALD.lsiKlFiVocabularyContract`;
- expose the smooth-density, absolute-continuity, finite-KL/FI, and
  smooth-test-function hypotheses needed by the source substitution
  `phi=sqrt(rho/pi)`;
- if formalization is not ready, refine `lsiToKlFiObligation` or add a
  narrower proof obligation rather than adding hidden theorem assumptions.

Non-goals:

- do not prove or restate any forward-KL theorem in this packet;
- do not replace LSI by PI, Talagrand, Pinsker, or another entropy inequality;
- do not promote `lem:dv_variation` or `lem:gronwall` beyond their current
  statuses.

Reviewer checklist:

- `SALD.firstFaithfulLabels` and `SALD.saldFirstProofDag` include
  `eq:LSI-KL-FI` with source `main_body.tex:202`;
- `research-wiki/source-index/SALD_original.jsonl` contains the source labels
  for `lem:gronwall`, `lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI`, while
  excluding `sald_version_2.tex`;
- `eq:LSI-KL-FI` remains an obligation because `probability.lsi_to_kl_fi` is
  not formalized locally;
- no mathematical content is closed by `axiom`, `sorry`, `admit`,
  `Prop := True`, or `:= trivial`.

### Cycle 5 Middle Audit

The source bridge at `main_body.tex:208-215` was re-read and split into the
following obligation interfaces:

| Source step | Classification | Lean-facing target | Current blocker |
|---|---|---|---|
| Work with densities `rho << pi` and the ratio `rho/pi`. | local measure/density interface | `SALD.saldKLContract`; `SALD.saldFIContract`; `SALD.saldLsiKlFiBridgeContract.absoluteContinuityInterface`; `SALD.saldLsiKlFiDensityTestContract.absoluteContinuity` | Radon-Nikodym density, nonnegativity, normalization, and finite KL/FI hypotheses are not yet represented by a measure backend |
| Substitute `phi=sqrt(rho/pi)` into the LSI definition. | local lemma plus possible approximation/closure argument | `SALD.saldLsiKlFiBridgeContract.testFunctionInterface`; `SALD.saldLsiKlFiDensityTestContract.sqrtTestFunction`; `SALD.lsiKlFiDensityTestObligation` | the source does not state smoothness/admissibility of `sqrt(rho/pi)` |
| Identify `int phi^2 log(phi^2) dpi` with `KL(rho||pi)`. | local lemma | `SALD.saldLsiKlFiBridgeContract.entropyIdentity`; `SALD.saldLsiKlFiDensityTestContract.entropyRewrite` | requires finite entropy and a density-ratio API |
| Rewrite `int ||nabla phi||^2 dpi` as `(1/4)*FI(rho||pi)`. | local calculus/FI chain-rule lemma | `SALD.saldLsiKlFiBridgeContract.fisherChainRule`; `SALD.saldLsiKlFiDensityTestContract.fisherChainRule` | requires differentiability/positivity of the density ratio or an approximation theorem |
| Combine with the LSI coefficient `2/C_LSI`. | algebraic final step | `lsiToKlFiObligation saldKlFiLsiSource` | after the chain rule, arithmetic gives the source constant `1/(2*C_LSI)` |

Middle lower packet:

- Target one declaration/interface:
  `SALD.saldLsiKlFiBridgeContract`,
  `SALD.saldLsiKlFiDensityTestContract`, or
  `SALD.lsiKlFiDensityTestObligation`.
- Preserve the source route `phi=sqrt(rho/pi)` and the exact bound
  `KL(rho||pi) <= FI(rho||pi)/(2*C_LSI)`.
- Make density smoothness, admissibility of the square-root test function,
  finite KL/FI, and the Fisher-information chain rule explicit as obligations;
  do not add them silently to the theorem statements.
- Non-goal: do not replace LSI by PI, Pinsker, Talagrand, or any alternate
  entropy inequality.

### Lower Cycle 5 Refinement

`SALD.saldLsiKlFiDensityTestContract` now narrows the source display
`main_body.tex:208-215` into the density-test obligations needed before a
future Lean theorem can prove `eq:LSI-KL-FI`:

| Interface slice | Source route | Current status |
|---|---|---|
| Radon-Nikodym density `r=d rho/d pi` | `rho << pi` and the paper's ratio `rho/pi` | obligation |
| Normalized LSI test function | `phi=sqrt(r)`, with `int phi^2 dpi=1` | obligation |
| Finite KL/FI quantities | KL and FI integrals defined after `eq:LSI-KL-FI` | obligation |
| Smooth-test admissibility | source says LSI holds for smooth `phi` but does not prove `sqrt(r)` is admissible | source gap |
| FI chain rule and coefficient | `int ||nabla sqrt(r)||^2 dpi=(1/4)FI`, hence factor `1/(2*C_LSI)` | obligation |

The obligation `sald.lsi_kl_fi.density_test_interface` now depends on this
compiled contract.  No LSI-to-KL/FI proof has been promoted, and no extra
regularity assumption has been added to the forward-KL theorem contracts.

## Cycle 6 Upper Packet

Objective: keep `thm:forward-KL` fixed while separating its moving-target
assumption interface from the analytic proof obligations.  The new compiled
contract `SALD.forwardKlMovingTargetDependencyContract` records how the source
statement and appendix proof compose:

| Source item | Lean-facing target | Current status |
|---|---|---|
| `main_body.tex:238-247` inverse slowdown, SALD law, LSI constants, finite alpha-complexity, and terminal KL bound | `SALD.continuousForwardKlStatementContract`; `SALD.forwardKlMovingTargetDependencyContract` | contract + obligation |
| `appendix.tex:187-197` transport velocity for `pi_t` and slowed velocity `tilde v_s` | `TransportVelocityContract`; `SALD.forwardKlMovingTargetDependencyContract.transportVelocityInterface` | obligation/backend gap |
| `appendix.tex:210-217` LSI conversion from FI to KL | `SALD.saldLsiKlFiDensityTestContract`; `lsiToKlFiObligation`; `SALD.forwardKlMovingTargetDependencyContract.lsiBridge` | obligation |
| `appendix.tex:230-241` DV with `Z=alpha*||v_t||^2` | `SALD.forwardKlDvEnergyCandidateContract`; `SALD.forwardKlMovingTargetDependencyContract.dvBridge` | obligation + source-cited |
| `appendix.tex:244-252` Gronwall with the source `a(t)` and `b(t)` | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlMovingTargetDependencyContract.gronwallBridge` | obligation |
| Endpoint identification `K(T)=KL(rho_S||pi_T)` and `K(0)=KL(rho_0||pi_0)` | `SALD.forwardKlMovingTargetDependencyObligation` | source gap/obligation |

Mode discipline:

- `faithfulPaper`; do not add assumptions to `thm:forward-KL` or weaken its
  bound;
- preserve the source dependency route derivative -> LSI -> DV -> Gronwall;
- keep LSI-to-KL/FI, DV, Gronwall, Fokker--Planck, and inverse-schedule
  calculus as obligations or source-cited facts until a local Lean proof
  exists.

Lower packet:

- Target one interface:
  `SALD.forwardKlMovingTargetDependencyContract` or
  `SALD.forwardKlMovingTargetDependencyObligation`.
- Refine exactly one of: endpoint schedule identities, transport velocity for
  the slowed target, finite log-mgf witness for the DV step, or regularity of
  the Gronwall coefficients.
- Preserve the exact differential inequality and terminal bound from
  `appendix.tex:239-252` and `main_body.tex:243-246`.

Non-goals:

- do not prove or restate the full continuous theorem;
- do not replace the source LSI, DV, or Gronwall route with another
  inequality;
- do not use `sald_version_2.tex`;
- do not mark any analytic dependency as formalized without a compiled theorem.

Reviewer checklist:

- `SALD.continuousSaldContract` includes
  `SALD.forwardKlMovingTargetDependencyObligation`;
- `SALD.forwardKlProofDag` includes
  `ASTIS.SALD.forward_KL.moving_target_dependencies`;
- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `sald.forward_kl.moving_target_dependency_chain`;
- the source index still excludes `sald_version_2.tex`;
- no Lean file contains a fake proof closure.

## Cycle 2 Upper Packet

Objective: keep `thm:forward-KL` fixed and refine the source proof route into
compiled contract/obligation data.  The theorem statement is represented by
`SALD.continuousForwardKlStatementContract`, and `SALD.continuousSaldContract`
now lists the LSI, DV, Gronwall, KL-derivative, DV-energy, and Gronwall
application obligations.

Mode discipline:

- `faithfulPaper`; do not add assumptions, weaken the bound, or merge the two
  exponential factors in `main_body.tex:243-246`;
- keep `sald_version_2.tex` out of all source correspondence;
- do not mark DV, Gronwall, LSI-to-KL/FI, or Fokker--Planck identities as
  formalized until Lean proofs replace the obligations.

Lower packet:

- refine `SALD.forwardKlDerivativeObligation` into a candidate Lean-facing
  interface for `appendix.tex:166-225`;
- explicitly list the regularity and boundary/integration-by-parts hypotheses
  needed for differentiating `K(t)=KL(rho_{s(t)}||pi_t)`;
- preserve the source differential inequality
  `dK/dt <= -dot{s}(t)*C_LSI(t)*K(t)
  + (1/2)*dot{s}(t)^(-1)*||v_t||_{L2(rho_{s(t)})}^2`;
- record any missing schedule regularity or density smoothness as a source gap,
  not as a hidden theorem assumption.

Non-goals:

- do not attempt a full proof of `thm:forward-KL`;
- do not replace Donsker--Varadhan with Pinsker, Talagrand, Cauchy-only, or a
  path-space argument;
- do not change the theorem to the general VA-SALD theorem or discrete theorem.

Reviewer checklist:

- `SALD.continuousForwardKlStatementContract` matches `main_body.tex:240-247`
  and its proof steps point to `appendix.tex:166-252`;
- `SALD.continuousSaldContract` depends on LSI/KL/FI, DV, Gronwall, and the
  theorem-specific KL derivative/DV-energy/Gronwall obligations;
- `SALD.forwardKlProofDag` and the three candidate contracts keep the source
  proof split at derivative, DV-energy, and Gronwall application blocks;
- DV remains `sourceCited`, Gronwall remains an obligation, and no analytic
  content is closed by `axiom`, `sorry`, `admit`, `Prop := True`, or
  `:= trivial`.

## Cycle 2 Middle Audit

The source theorem and proof were re-read at `main_body.tex:218-247` and
`appendix.tex:168-252`.  The faithful decomposition is:

| Source block | Classification | Lean-facing target | Current blocker |
|---|---|---|---|
| `main_body.tex:218-228` alpha-complexity | local definition plus analytic finite-mgf obligation | `SALD.saldAlphaComplexityContract` | need finite log-mgf monotonicity for `alpha <= alpha0` |
| `main_body.tex:13-21` SALD and Fokker--Planck equation | internal-paper-step plus SDE/Fokker--Planck backend | `SALD.saldContinuousSdeSource`, `SALD.saldFokkerPlanckSource` | no local measure-theoretic SDE-to-FP theorem |
| `appendix.tex:168-185` KL derivative and first term | local lemma | `SALD.forwardKlDerivativeCandidateContract` | differentiation under integral, mass conservation, integration by parts |
| `appendix.tex:187-208` slowed transport velocity and cross term | local lemma plus transport contract | `SALD.forwardKlDerivativeCandidateContract`, `TransportVelocityContract` | boundary/no-flux assumptions are implicit in source |
| `appendix.tex:210-228` LSI and inverse schedule time change | LSI obligation plus source-contract gap | `SALD.forwardKlDerivativeCandidateContract`, `lsiToKlFiObligation` | inverse-function regularity and `dot{s}(t)>0` must be stated before proof |
| `appendix.tex:230-241` DV energy estimate | external-cited-result plus local lemma | `SALD.forwardKlDvEnergyCandidateContract`, `dvVariationalObligation` | DV remains source-cited; finite log-mgf witness needed |
| `appendix.tex:244-252` Gronwall application and exponent split | local Gronwall obligation | `SALD.forwardKlGronwallInstantiationContract`, `SALD.saldGronwallCandidateContract` | continuity/integrability of `a`, `b`, and differentiability of `K` are implicit |

Middle lower packet:

- Target one declaration/interface: refine `SALD.forwardKlDerivativeCandidateContract`
  into a narrower candidate record or theorem statement for
  `appendix.tex:168-228`.
- Preserve the exact differential inequality
  `dK/dt <= -dot{s}(t)*C_LSI(t)*K(t)
  + (1/2)*dot{s}(t)^(-1)*||v_t||_{L2(rho_{s(t)})}^2`.
- Make the schedule assumptions explicit:
  smooth monotone `t=t(s)`, inverse `s=s(t)`, `dot{s}(t)>0`, and
  `dot{t}(s(t))=dot{s}(t)^(-1)`.
- Make analytic side conditions explicit as obligations, not hidden
  hypotheses: density smoothness/positivity, absolute continuity, finite
  KL/FI, differentiation under the integral, and integration-by-parts boundary
  conditions.
- Non-goal: do not prove DV, Gronwall, or the full theorem in this packet.

### Lower Cycle 2 Refinement

`SALD.forwardKlDerivativeSideConditionContract` now records the implicit side
conditions used by the derivative block without changing `thm:forward-KL`:

| Source proof step | New local obligation | Current status |
|---|---|---|
| `appendix.tex:168-174` differentiate KL and use `int partial_s rho_s dx = 0` | `SALD.forwardKlDensityBoundaryObligation` | obligation |
| `appendix.tex:176-208` integrate by parts in the SALD and target-velocity terms | `SALD.forwardKlDensityBoundaryObligation` | obligation |
| `appendix.tex:191-228` pass from `s` to `t` and rewrite `dot{s}(t)*dot{t}(s(t))^2` | `SALD.forwardKlScheduleTimeChangeObligation` | obligation |

The main derivative obligation now depends on these two named side conditions.
The target inequality remains
`dK/dt <= -dot{s}(t)*C_LSI(t)*K(t)
+ (1/2)*dot{s}(t)^(-1)*||v_t||_{L2(rho_{s(t)})}^2`.

## Cycle 3 Upper Packet

Objective: keep `thm:forward-KL-discrete` fixed and refine the source proof
route into compiled contract/obligation data.  The theorem statement is
represented by `SALD.discreteForwardKlStatementContract`, and
`SALD.discreteSaldContract` now lists the EM interpolation, frozen defect, DV,
Gronwall, density/boundary, and schedule obligations.

Mode discipline:

- `faithfulPaper`; do not change the main-body theorem bound in
  `main_body.tex:309-323`;
- preserve the paper constants `T/(r*alpha)`,
  `2*r*eta^2*barGamma/alpha'`, `(1/r)*A_alpha(pi,v)`, and
  `2*r*eta*barDelta_{alpha'}`;
- keep the SALD-specific frozen-defect lemma as an obligation, because the
  source says its proof is omitted and follows from the later general lemma;
- do not mark DV, Gronwall, interpolation Fokker--Planck, or stitched EM
  interval regularity as formalized.

Lower packet:

- target one declaration/interface:
  `SALD.discreteForwardKlDerivativeCandidateContract` or
  `SALD.frozenDeltaCrossLipSaldContract`;
- preserve the source discrete differential inequality
  `dK/dt <= -(dot{s}(t)*C_LSI(t) - dot{s}(t)^(-1)*alpha^(-1)
  - 2*dot{s}(t)*eta^2*alpha'^(-1)*Gamma(t))*K(t)
  + dot{s}(t)^(-1)*E_alpha(pi_t,v_t)
  + 2*dot{s}(t)*eta*Delta(t)`;
- make the EM interpolation Fokker--Planck equation and conditional drift
  `bar b_{k,s}` explicit before any proof search;
- record stitched-interval differentiability and endpoint continuity as
  source gaps, not hidden assumptions.

Non-goals:

- do not prove `thm:forward-KL-discrete` in this packet;
- do not replace the one-step defect route with a path-space/Girsanov argument;
- do not use `sald_version_2.tex` as source support;
- do not specialize to the general VA-SALD discrete theorem except for the
  source-indicated frozen-defect specialization.

Reviewer checklist:

- `SALD.discreteForwardKlStatementContract` matches `main_body.tex:301-323`
  and its proof steps point to `appendix.tex:260-592`;
- `SALD.discreteSaldContract` depends on the named discrete obligations and
  keeps all analytic facts at `obligation` or `sourceCited`;
- `SALD.discreteForwardKlProofDag` contains EM interpolation, frozen defect,
  derivative, and Gronwall accumulation blocks with source anchors;
- the omitted proof of `lem:frozen_delta_cross_lip_sald` is not treated as
  formalized;
- no analytic content is closed by `axiom`, `sorry`, `admit`,
  `Prop := True`, or `:= trivial`.

## Cycle 3 Middle Audit

The source proof was re-read at `main_body.tex:273-323` and
`appendix.tex:260-592`.  The faithful discrete route is now split as follows:

| Source block | Classification | Lean-facing target | Current blocker |
|---|---|---|---|
| `main_body.tex:273-298` score Lipschitz assumptions and `Gamma`, `Delta` definitions | theorem assumptions plus one-step defect vocabulary | `SALD.discreteForwardKlStatementContract`, `SALD.frozenDeltaCrossLipSaldContract` | finite exponential complexity and smoothness control for `Gamma`, `Delta` remain analytic obligations |
| `appendix.tex:260-266` EM interpolation `hat X_s` | local EM/Fokker--Planck backend | `SALD.discreteSaldEulerMaruyamaContract`, `SALD.discreteForwardKlEmInterpolationObligation` | endpoint laws, conditional drift, and interpolation Fokker--Planck equation are used without a standalone source theorem |
| `appendix.tex:268-330` SALD frozen-defect lemma | omitted proof specialized from later general lemma | `SALD.frozenDeltaCrossLipSaldContract`, `SALD.discreteForwardKlFrozenDeltaObligation` | must specialize `lem:frozen_delta_cross_lip` with `c=0` and `sigma_eta(t)=sqrt(2)` before marking formalized |
| `appendix.tex:334-523` derivative, frozen cross term, LSI, and DV | local derivative obligation plus source-cited DV | `SALD.discreteForwardKlDerivativeCandidateContract`, `SALD.discreteForwardKlDvVelocityObligation` | density/boundary, conditional expectation, and DV finite-log-mgf side conditions |
| `appendix.tex:526-592` time change and Gronwall | Gronwall accumulation obligation | `SALD.discreteForwardKlGronwallAccumulationObligation` | stitched EM interval regularity and endpoint continuity of `K(t)` are implicit |
| `main_body.tex:299-323` linear slowdown theorem bound | algebraic specialization obligation | `SALD.discreteForwardKlLinearSlowdownObligation` | appendix stops at a general-schedule Gronwall display, so `dot{s}=r`, `barGamma`, and `barDelta` collection must be proved separately |

Middle lower packet:

- Target `SALD.discreteForwardKlLinearSlowdownObligation` if doing algebra, or
  `SALD.discreteForwardKlEmInterpolationObligation` if doing analytic setup.
- Preserve the exact constants
  `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
  `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`.
- Do not claim the appendix proves the linear-slowdown collection verbatim; it
  provides the general-schedule Gronwall display, while the main-body theorem
  supplies the specialization target.

### Lower Cycle 3 Refinement

`SALD.discreteForwardKlEmInterpolationSideConditionContract` now splits the
Euler--Maruyama interpolation setup into three named obligations while keeping
`thm:forward-KL-discrete` unchanged:

| Source proof step | New local obligation | Current status |
|---|---|---|
| `appendix.tex:260-266` defines `hat X_s`; `appendix.tex:334-335` uses endpoint law matching | `SALD.discreteForwardKlEmEndpointObligation` | obligation |
| `appendix.tex:347-385` defines `bar b_{k,s}` and invokes the interpolation Fokker--Planck equation | `SALD.discreteForwardKlEmConditionalFpObligation` | obligation |
| `appendix.tex:557-590` applies one Gronwall bound after interval-wise derivative estimates | `SALD.discreteForwardKlStitchedIntervalRegularityObligation` | obligation |

The aggregate obligation
`SALD.discreteForwardKlEmInterpolationObligation` now depends on the endpoint
and conditional-drift obligations, and the Gronwall accumulation obligation now
depends on the stitched-interval regularity obligation.  No EM analytic fact is
marked formalized.

## Cycle 4 Upper Packet

Objective: keep `thm:general-moving-target-SALD` fixed and refine the
continuous guided/general VA-SALD route into compiled contract/obligation data.
This packet also pins `prop:guided_path_residual` and the specialization
`thm:unified-forward-KL`, but it does not attempt the discrete general theorem.

Mode discipline:

- `faithfulPaper`; do not change the sigma-weighted theorem bound in
  `appendix.tex:727-743` or the main-body bound in `main_body.tex:377-395`;
- preserve the residual field definition `m_t=v_t-c_t` and the unified
  specialization `c_t <- u_t`, so `m_t=w_t`;
- do not remove the factors `sigma_t^2/2`, `sigma_t^{-2}`,
  `dot{s}(t)`, or `dot{s}(t)^{-1}` from the derivative or Gronwall blocks;
- keep DV, Gronwall, Fokker--Planck, integration-by-parts, and inverse-schedule
  steps at `obligation` or `sourceCited` status until Lean proofs replace them.

Lower packet:

- target one declaration/interface:
  `SALD.generalMovingTargetDerivativeCandidateContract`;
- preserve the source pre-DV inequality
  `dK/dt <= -(sigma_t^2/2)*dot{s}(t)*C_LSI(t)*K(t)
  + sigma_t^(-2)*dot{s}(t)^(-1)*||m_t||_{L2(rho_{s(t)})}^2`;
- explicitly expose the general VA-SALD Fokker--Planck equation
  `eq:general_moving_target_FP`, the residual combination
  `v_t-c_t`, and the Young parameter
  `epsilon=2*dot{t}(s)/sigma_{t(s)}^2`;
- record sigma positivity, density/boundary regularity, and inverse-schedule
  assumptions as source gaps or obligations, not hidden theorem hypotheses.

Non-goals:

- do not prove the full general theorem in this packet;
- do not replace the residual DV-energy route with a path-space/Girsanov
  argument;
- do not work from `sald_version_2.tex`;
- do not start the discrete general VA-SALD theorem before the continuous
  sigma-weighted derivative interface is audited.

Reviewer checklist:

- `SALD.generalMovingTargetStatementContract` matches
  `appendix.tex:724-949`, including the pure-contraction clause;
- `SALD.generalVaSaldContract` depends on the named derivative, DV-energy,
  Gronwall, and pure-contraction obligations;
- `SALD.guidedResidualIdentityContract` preserves the centered residual
  `g_t-E_{pi_t}[g_t]` and does not replace it with an uncentered guide term;
- `SALD.unifiedForwardKlSpecializationContract` and
  `SALD.unifiedForwardKlSpecializationObligation` keep the unified theorem as
  the specialization `c_t <- u_t`, with the correction-field bridge
  `v_t=u_t+w_t` and `m_t=w_t`, not a new proof route;
- no analytic content is closed by `axiom`, `sorry`, `admit`,
  `Prop := True`, or `:= trivial`.

## Cycle 4 Middle Audit

The source proof was re-read at `main_body.tex:359-395` and
`appendix.tex:619-1603`, excluding `sald_version_2.tex`.  The continuous
guided/general route from the upper packet is now extended through the
discrete general theorem.

| Source block | Classification | Lean-facing target | Current blocker |
|---|---|---|---|
| `appendix.tex:953-996` EM update and frozen interpolation | internal-paper-step plus EM/Fokker--Planck backend | `SALD.generalVaSaldEulerMaruyamaContract`, `SALD.generalMovingTargetDiscreteEmInterpolationObligation` | endpoint laws, conditional drift, and sigma-weighted interpolation Fokker--Planck remain analytic obligations |
| `appendix.tex:998-1023` `delta_pi^VA` definition | local definition plus conditional expectation interface | `SALD.generalFrozenDeltaCrossLipContract`, `SALD.generalMovingTargetDiscreteDerivativeCandidateContract` | conditional expectation and density interface are not formalized locally |
| `appendix.tex:1026-1307` general frozen-delta lemma | local one-step estimate plus source-cited DV | `SALD.generalMovingTargetDiscreteFrozenDeltaObligation` | finite log-mgf monotonicity for `alpha' <= alpha0'`, increment estimates, and Gamma/Delta collection |
| `appendix.tex:1354-1600` derivative side interfaces | local side-condition ledger | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`, `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` | endpoint laws, conditional drift, Fokker--Planck split, frozen/residual algebra, two Young coefficients, DV finite-log-mgf, and stitched time change remain obligations |
| `appendix.tex:1354-1488` KL derivative and frozen/residual split | local derivative lemma | `SALD.generalMovingTargetDiscreteDerivativeCandidateContract` | integration by parts, interpolation Fokker--Planck, and residual decomposition need Lean backends |
| `appendix.tex:1493-1542` two Young bounds and LSI | local lemma plus frozen-delta dependency | `SALD.generalMovingTargetDiscreteDerivativeObligation` | preserve the `sigma_eta^2/8` splits and the resulting `sigma_eta^2/4` FI coefficient |
| `appendix.tex:1544-1598` DV and time change | source-cited DV plus constant-schedule obligation | `SALD.generalMovingTargetDiscreteDvMEnergyObligation`, `SALD.generalMovingTargetDiscreteConstantScheduleObligation` | theorem states constant `dot t`; Lean still needs a stitched interval/time-change interface |
| `appendix.tex:1600` Gronwall finish | local Gronwall obligation | `SALD.generalMovingTargetDiscreteGronwallApplicationObligation` | final source proof is one sentence, so all Gronwall regularity and endpoint matching remain explicit obligations |
| `appendix.tex:1603` guided discrete specialization | specialization only | `SALD.discreteUnifiedVaSaldSpecializationObligation` | no new proof route; must use `c <- u` and guided residual notation |

Middle lower packet:

- Target one declaration/interface: `SALD.generalMovingTargetDiscreteDerivativeCandidateContract`
  or `SALD.generalFrozenDeltaCrossLipContract`.
- Preserve the exact discrete general differential inequality
  `dK/dt <= -((sigma_eta(t)^2/2)*dot{s}(t)*C_LSI(t)
  - 2*sigma_eta(t)^(-2)*dot{s}(t)^(-1)*alpha^(-1)
  - 2*dot{s}(t)*eta^2*alpha'^(-1)*Gamma(t))*K(t)
  + 2*sigma_eta(t)^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)
  + 2*dot{s}(t)*eta*Delta(t)`.
- Keep the source step-size condition from `lem:frozen_delta_cross_lip` exactly:
  `4*eta^2*(dot t(s)*L_c_space+(sigma_eta(t(s))^2/2)*L_pi_space)^2 < 1/2`.
- Do not replace the paper's two Young splits with a different constant
  allocation; the final bound depends on the displayed `2*sigma_eta^{-2}`
  and `2*eta` factors.
- Do not treat the SALD-specific `lem:frozen_delta_cross_lip_sald` as
  formalized merely because the general lemma is now contracted; both remain
  obligations until a compiled specialization/proof exists.

### Lower Cycle 4 Refinement

`SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` now records
the side interfaces for `appendix.tex:1354-1600` separately from the derivative
inequality target:

| Source proof step | New local obligation | Current status |
|---|---|---|
| `appendix.tex:1354-1387` endpoint laws, conditional drift `bar b_{k,s}`, and interpolation Fokker--Planck equation | `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` | obligation |
| `appendix.tex:1436-1478` slowed transport velocity and algebraic split into `delta_pi^VA + dot t(s)*m_{t(s)}` | `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` | obligation |
| `appendix.tex:1493-1542` the two `sigma_eta^2/8` Young contributions and LSI bookkeeping | `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` | obligation |
| `appendix.tex:1544-1600` DV finite-log-mgf witness, `dK/dt=dot s*dK/ds`, and stitched interval regularity for Gronwall | `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` | obligation |

The theorem target and displayed differential inequality are unchanged.

## Cycle 6 Middle Audit

The source proof was re-read at `main_body.tex:238-247` and
`appendix.tex:210-252`.  The cycle focus is the continuous
`thm:forward-KL` moving-target dependency chain, especially the scalar
coefficient flow from LSI through DV to Gronwall.

| Source step | Classification | Lean-facing target | Current blocker |
|---|---|---|---|
| `appendix.tex:210-217` combines the post-Young derivative inequality with `eq:LSI-KL-FI` | local coefficient bookkeeping plus LSI/KL/FI obligation | `SALD.forwardKlDependencyChainAuditContract.lsiCoefficientStep`, `SALD.forwardKlCoefficientChainObligation` | formal LSI-to-KL/FI backend and finite FI/KL interfaces |
| `appendix.tex:218-228` changes from `s` to `t` and rewrites `dot{s}*dot{t}^2` | inverse-schedule calculus obligation | `SALD.forwardKlDependencyChainAuditContract.timeChangeStep`, `SALD.forwardKlScheduleTimeChangeObligation` | endpoint-safe inverse-function and positivity interface |
| `appendix.tex:230-241` applies DV with `Z=alpha*||v_t||^2` | source-cited external result plus local finite-log-mgf monotonicity | `SALD.forwardKlDependencyChainAuditContract.dvInstantiation`, `SALD.forwardKlDvEnergyObligation` | DV port/source-cited status and `alpha <= alpha0` log-mgf witness |
| `appendix.tex:239-242` forms the scalar differential inequality | coefficient-chain audit obligation | `SALD.forwardKlDependencyChainAuditContract.scalarDifferentialInequality` | depends on derivative, schedule, LSI, and DV obligations |
| `appendix.tex:244-252` applies Gronwall and splits exponents into the theorem display | Gronwall application plus exponent-simplification obligation | `SALD.forwardKlDependencyChainAuditContract.exponentSplit`, `SALD.forwardKlGronwallApplicationObligation` | Gronwall backend, integrability of coefficients, and nonnegativity used to drop the residual LSI exponent |
| theorem endpoints `K(T)=KL(rho_S||pi_T)` and `K(0)=KL(rho_0||pi_0)` | moving-target endpoint bookkeeping | `SALD.forwardKlDependencyChainAuditContract.terminalEndpointBridge`, `SALD.forwardKlMovingTargetDependencyContract` | `S=s(T)`, `s(0)=0`, and slowed target identity remain source gaps |

Middle lower packet:

- Target one declaration/interface:
  `SALD.forwardKlCoefficientChainObligation` or
  `SALD.forwardKlDependencyChainAuditContract`.
- Preserve exactly
  `a(t)=dot{s}(t)*C_LSI(t)-(1/2)*dot{s}(t)^(-1)*alpha^(-1)` and
  `b(t)=(1/2)*dot{s}(t)^(-1)*E_alpha(pi_t,v_t)`.
- Keep the Young coefficient `1/2`, the LSI coefficient `C_LSI(t)`, and the
  DV contribution `(1/2)*dot{s}(t)^(-1)*alpha^(-1)` unchanged.
- Treat endpoint identities and residual-exponent simplification as source
  gaps/obligations unless a compiled Lean lemma proves them.
- Do not add assumptions to `thm:forward-KL`; keep them in obligation data.

Reviewer checklist:

- `SALD.continuousSaldContract` now lists
  `SALD.forwardKlCoefficientChainObligation` but still has proof status
  `contractOnly`.
- `SALD.forwardKlProofDag` includes the coefficient-chain audit as an
  obligation reused by continuous and discrete forward-KL proof patterns.
- DV remains `source-cited`; the new audit does not mark the DV formula or
  finite log-mgf monotonicity formalized.
- The source file `sald_version_2.tex` remains excluded from the source index.
- No analytic content is closed by `axiom`, `sorry`, `admit`,
  `Prop := True`, or `:= trivial`.

### Cycle 6 Lower Refinement

`SALD.forwardKlGronwallSideConditionContract` now isolates the final
continuous forward-KL Gronwall side conditions used at
`appendix.tex:244-252` and in the theorem display at
`main_body.tex:243-246`:

| Source item | Lean-facing target | Current blocker |
|---|---|---|
| identify `K(T)` and `K(0)` with the theorem endpoints | `SALD.forwardKlGronwallSideConditionContract.terminalKlIdentification`; `SALD.forwardKlGronwallSideConditionObligation` | endpoint schedule identities `S=s(T)`, `s(0)=0`, and slowed-target equality |
| prove the source `a(t)`, `b(t)` are admissible for `lem:gronwall` | `SALD.forwardKlGronwallSideConditionContract.coefficientRegularity` | continuity or interval-integrability of `C_LSI`, `dot{s}`, and `E_alpha` |
| split `exp(-int a)` into the theorem's two initial-error exponentials | `SALD.forwardKlGronwallSideConditionContract.exponentSplitAlgebra` | real interval-integral algebra |
| drop the LSI part from the residual exponential | `SALD.forwardKlGronwallSideConditionContract.residualExponentBound` | nonnegativity of `C_LSI` and positivity of `dot{s}` must be explicit |

Mode discipline:

- this refinement does not change `thm:forward-KL` or add theorem
  assumptions;
- `lem:gronwall`, `lem:dv_variation`, and `eq:LSI-KL-FI` remain
  obligation/source-cited dependencies;
- the new side-condition obligation is local algebra/regularity bookkeeping,
  not a replacement proof route.

## Cycle 7 Upper Packet

Objective: keep `thm:forward-KL-discrete` fixed and refine the discrete
coefficient chain that carries the one-step `Gamma`/`Delta` defects into the
main-body accumulated-error constants.  The new Lean-facing audit items are
`SALD.discreteForwardKlCoefficientChainAuditContract` and
`SALD.discreteForwardKlCoefficientChainObligation`.

Mode discipline:

- `faithfulPaper`; use only `main_body.tex:273-323` and
  `appendix.tex:260-592` for this discrete SALD theorem;
- preserve the source differential inequality with
  `dot{s}(t)^(-1)*alpha^(-1)`,
  `2*dot{s}(t)*eta^2*alpha'^(-1)*Gamma(t)`, and
  `2*dot{s}(t)*eta*Delta(t)`;
- keep `lem:frozen_delta_cross_lip_sald`, DV, Gronwall, EM
  Fokker--Planck, and stitched-interval regularity as obligations or
  source-cited facts until compiled proofs replace them;
- do not add hidden assumptions to the theorem statement.

Lower packet:

- target one declaration/interface:
  `SALD.discreteForwardKlCoefficientChainAuditContract` or
  `SALD.discreteForwardKlCoefficientChainObligation`;
- verify the coefficient flow from `appendix.tex:454-553`: two `1/4*FI`
  cross-term bounds, LSI conversion, DV with
  `Z=alpha*||v_{t(s)}||^2`, and the time-change rewrite
  `dot{s}(t)*dot{t}(s(t))^2=dot{s}(t)^(-1)`;
- then check the accumulation step from `appendix.tex:557-590` to
  `main_body.tex:309-323`, preserving
  `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
  `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`;
- record endpoint matching and residual-exponent simplification as source
  gaps unless a compiled Lean lemma proves them.

Non-goals:

- do not prove `thm:forward-KL-discrete` in this packet;
- do not replace the one-step frozen-defect route with path-space or
  Girsanov analysis;
- do not use `sald_version_2.tex`;
- do not mark the omitted SALD frozen-defect specialization formalized just
  because the later general lemma is contracted.

Reviewer checklist:

- `SALD.discreteSaldContract` lists
  `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` and
  `SALD.discreteForwardKlCoefficientChainObligation` and still has proof status
  `contractOnly`;
- `SALD.discreteForwardKlProofDag` contains
  `ASTIS.SALD.forward_KL_discrete.accumulated_error_bridge` and
  `ASTIS.SALD.forward_KL_discrete.residual_exponent_bound` and
  `ASTIS.SALD.forward_KL_discrete.coefficient_chain_audit`;
- `SALD.discreteForwardKlStatementContract` still matches
  `main_body.tex:301-323`, especially the two accumulated error terms;
- all analytic dependencies remain `obligation` or `sourceCited`;
- no analytic content is closed by `axiom`, `sorry`, `admit`,
  `Prop := True`, or `:= trivial`.

### Cycle 7 Middle Refinement

`SALD.discreteForwardKlAccumulatedErrorBridgeContract` now separates the final
main-body collection from the one-step derivative audit.  Its lower-facing
interface is:

| Source item | Lean-facing target | Current blocker |
|---|---|---|
| rewrite `K(T)` and `K(0)` after Gronwall | `SALD.discreteForwardKlAccumulatedErrorBridgeContract.endpointBridge`; `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` | EM endpoint laws, `s(0)=0`, `S=s(T)`, and linear-slowdown endpoints |
| split `exp(-int a)` under `t(s)=s/r` | `SALD.discreteForwardKlAccumulatedErrorBridgeContract.initialExponentSplit` | real interval-integral algebra with the exact source `a(t)` |
| bound residual exponents by the full positive exponent | `SALD.discreteForwardKlAccumulatedErrorBridgeContract.residualExponentBound`; `SALD.discreteForwardKlResidualExponentBoundObligation` | nonnegativity of `C_LSI`, positivity of `alpha`, `alpha'`, and `r`, and monotonicity of interval integrals for the Gamma contribution |
| collect the additive terms | `SALD.discreteForwardKlAccumulatedErrorBridgeContract.alphaComplexityCollection`; `gammaAccumulation`; `deltaAccumulation` | identify `A_alpha(pi,v)`, `barGamma`, and `barDelta_{alpha'}` as the source full-interval integrals |

This is a local endpoint and real/integral algebra obligation.  It does not
add assumptions to `thm:forward-KL-discrete` and does not mark Gronwall, DV, or
the EM interpolation facts formalized.

### Cycle 7 Lower Refinement

`SALD.discreteForwardKlCoefficientChainAuditContract` now separates the scalar
side conditions needed to audit the source coefficient chain:

| Source item | Lean-facing target | Current blocker |
|---|---|---|
| `appendix.tex:454-467` frozen-defect contribution | `sourceLineLedger`; `frozenCrossCoefficient` | omitted SALD-specific frozen-defect specialization remains an obligation |
| `appendix.tex:469-493` moving Young split and LSI conversion | `sourceLineLedger`; `movingCrossCoefficient`; `lsiStep` | LSI-to-KL/FI backend and finite FI/KL interfaces |
| `appendix.tex:496-553` DV and time-change coefficient rewrite | `sourceLineLedger`; `dvVelocityCoefficient`; `timeChangeStep` | DV finite-log-mgf witness and inverse-schedule positivity |
| `appendix.tex:557-590` to `main_body.tex:309-323` | `sourceLineLedger`; `scalarSideConditions`; `accumulatedErrorCollection` | stitched EM endpoint continuity, coefficient integrability, nonnegative LSI exponent drop, and interval-integral monotonicity |

The named obligation
`SALD.discreteForwardKlCoefficientChainObligation` now mentions these scalar
side conditions and depends directly on
`sald.discrete_forward_kl.stitched_interval_regularity`.  This remains a proof
obligation only: no theorem target is changed, and no analytic fact is marked
formalized.

## Cycle 8 Upper Packet

Objective: keep `thm:general-moving-target-SALD` fixed and refine the final
continuous general VA-SALD Gronwall side conditions.  The new Lean-facing
items are `SALD.generalMovingTargetGronwallSideConditionContract` and
`SALD.generalMovingTargetGronwallSideConditionObligation`.

Mode discipline:

- `faithfulPaper`; use `appendix.tex:724-951` and
  `main_body.tex:359-395` for this guided/general path, excluding
  `sald_version_2.tex`;
- preserve the source coefficients
  `(sigma_t^2/2)*dot{s}(t)*C_LSI(t)` and
  `sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)` in both the initial exponent and
  the residual exponent;
- keep Gronwall, DV, LSI-to-KL/FI, Fokker--Planck, inverse-schedule, endpoint,
  and real/integral algebra facts as obligations or source-cited dependencies
  until compiled Lean proofs replace them;
- do not add endpoint, coefficient-regularity, or sign facts as hidden
  theorem assumptions.

Lower packet:

- target one declaration/interface:
  `SALD.generalMovingTargetGronwallSideConditionContract` or
  `SALD.generalMovingTargetGronwallSideConditionObligation`;
- refine exactly one of: endpoint rewrites `K(T)`/`K(0)`, sigma-weighted
  coefficient regularity for `lem:gronwall`, exponent splitting plus
  residual-exponent monotonicity, or the zero-residual
  `E_alpha(pi_t,m_t)=0` calculation in the pure-contraction case;
- preserve the source theorem display `eq:general_moving_target_KL_bound` and
  the one-line specialization `c_t <- u_t` for `thm:unified-forward-KL`.

Non-goals:

- do not prove `thm:general-moving-target-SALD` or restate it with additional
  assumptions;
- do not replace the residual DV route with Girsanov, Pinsker, Talagrand, or a
  path-space argument;
- do not change the unified theorem into a direct VA-SALD proof; it remains a
  specialization of the general moving-target theorem;
- do not use `sald_version_2.tex`.

Reviewer checklist:

- `SALD.generalVaSaldContract` lists
  `SALD.generalMovingTargetGronwallSideConditionObligation` and still has
  proof status `contractOnly`;
- `SALD.generalVaSaldProofDag` contains
  `ASTIS.SALD.general_moving_target.gronwall_side_conditions`;
- `SALD.generalMovingTargetStatementContract` still matches
  `appendix.tex:724-949`, including the pure-contraction clause;
- `SALD.unifiedForwardKlSpecializationContract` records the source bridge
  through `eq:poisson-eq`, and `SALD.unifiedForwardKlSpecializationObligation`
  remains only the specialization `c_t <- u_t`;
- all analytic dependencies remain `obligation` or `sourceCited`, with no
  fake proof closures.

### Cycle 8 Middle Refinement

`SALD.generalMovingTargetDiscreteGronwallSideConditionContract` now tracks the
side conditions behind the final line "applying Lemma gronwall finishes the
proof" for `thm:general-moving-target-SALD-discrete`.

| Source item | Lean-facing target | Current blocker |
|---|---|---|
| `appendix.tex:1573-1583` defines `K(t)` and changes from `s` to `t`. | `endpointLawIdentities`; `constantScheduleIdentities`; `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` | stitched EM interval laws, inverse-schedule identities, and endpoint matching |
| `appendix.tex:1586-1597` lists the final differential inequality. | `residualCoefficientAudit`; `frozenDeltaCoefficientAudit` | preserve the doubled residual coefficient and the `dot{s}` multipliers on `Gamma` and `Delta` |
| `appendix.tex:1600` invokes Gronwall. | `stitchedRegularity`; `coefficientRegularity` | piecewise differentiability/absolute continuity of `K(t)` and integrability of `a(t)`, `b(t)` |
| `appendix.tex:1316-1347` states the theorem display. | `gronwallDisplayMatch` | exact endpoint rewrite and display matching, with no extra exponent simplification |

The named obligation
`SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` is now listed
in `SALD.generalVaSaldDiscreteContract`, and
`SALD.generalVaSaldDiscreteProofDag` contains the block
`ASTIS.SALD.general_moving_target_discrete.gronwall_side_conditions`.  This is
local endpoint, schedule, and real/integral algebra; it does not add
assumptions to the discrete theorem.

### Cycle 8 Lower Refinement

`SALD.unifiedForwardKlSpecializationContract` now splits the one-line appendix
proof of `thm:unified-forward-KL` into explicit obligation interfaces:

| Source step | Lean-facing target | Current status |
|---|---|---|
| `main_body.tex:359-363` residual display from `prop:guided_path_residual` | `SALD.unifiedForwardKlSpecializationContract.residualEquation`; `SALD.guidedResidualIdentityObligation` | obligation |
| `main_body.tex:364-368` correction equation for `w_t` | `SALD.unifiedForwardKlSpecializationContract.correctionFieldTransportBridge`; `SALD.unifiedForwardKlTransportBridgeObligation`; `SALD.unifiedForwardKlSpecializationObligation` | obligation |
| `main_body.tex:76-99` VA-SALD dynamics | `SALD.unifiedForwardKlSpecializationContract.vaSaldDynamics`; `SALD.unifiedForwardKlSpecializationObligation` | obligation |
| `appendix.tex:949-951` specialization `c_t <- u_t` | `SALD.unifiedForwardKlSpecializationContract.terminalBoundMatch`; `SALD.unifiedForwardKlSpecializationObligation` | obligation |

The remaining blocker is now isolated as
`SALD.unifiedForwardKlTransportBridgeObligation`:
from the centered residual identity and
`\nabla\cdot(\pi_t w_t)=\pi_t(g_t-\E_{\pi_t}[g_t])`, show that
`u_t+w_t` generates `pi_t`; then the general theorem can be instantiated with
`v_t=u_t+w_t`, `c_t=u_t`, and `m_t=w_t`.  This refinement does not add a new
theorem hypothesis and does not replace the source specialization route.

## Cycle 9 Upper Packet

Objective: re-audit the source-index and first appendix/vocabulary layer before
lower proof search.  The selected source nodes are `lem:gronwall`,
`lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI`.  The compiled upper packet is
`SALD.cycle9FirstAppendixVocabularyPacket`, and `SALD.saldFirstProofDag` now
lists sharper dependency interfaces for Gronwall, DV, and PI.

Mode discipline:

- `faithfulPaper`; use `appendix.tex:47-94` and `main_body.tex:202-215`, with
  `sald_version_2.tex` still excluded from source correspondence;
- preserve the source Gronwall signs and endpoint expression, the
  Donsker--Varadhan supremum formula, the PI variance inequality, and the
  LSI-to-KL/FI coefficient `1/(2*C_LSI)`;
- keep Gronwall and LSI-to-KL/FI as obligations and DV as source-cited until
  local Lean proofs replace them.

Lower packet:

- target one first-layer interface:
  `SALD.saldGronwallCandidateContract`,
  `SALD.saldGronwallEndpointCalculusContract`,
  `dvVariationalObligation saldDvVariationSource`, `SALD.saldPIContract`, or
  `SALD.saldLsiKlFiDensityTestContract`;
- for Gronwall, refine endpoint-safe real calculus and interval-integral
  assumptions only;
- for DV, expose the finite log-mgf and common probability-space interfaces
  without promoting the cited formula;
- for PI/LSI/KL/FI, refine variance/Sobolev or density-test obligations
  without changing theorem-level hypotheses.

Non-goals:

- do not prove or restate `thm:forward-KL` or any later VA-SALD theorem;
- do not replace DV, LSI, or Gronwall with another proof route;
- do not add density, endpoint, smoothness, or finite-mgf assumptions silently
  to theorem contracts.

Reviewer checklist:

- `research-wiki/source-index/SALD_original.jsonl` contains
  `lem:gronwall`, `lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI`, while
  excluding `sald_version_2.tex`;
- `SALD.saldFirstProofDag` preserves statuses: Gronwall `obligation`, DV
  `sourceCited`, PI `contractOnly`, and LSI/KL/FI `obligation`;
- no first-layer analytic fact is closed by `axiom`, `sorry`, `admit`,
  `Prop := True`, or `:= trivial`;
- forward-KL and VA-SALD theorem statements remain unchanged.

### Cycle 9 Middle Audit

The source focus was re-read at `appendix.tex:47-151` and
`main_body.tex:202-215`.  Two first-layer interfaces were split into named
compiled obligations:

| Source step | Classification | Lean-facing target | Current blocker |
|---|---|---|---|
| `appendix.tex:73-79` applies the cited DV formula over common probability distributions and finite-log-mgf test functions. | external-cited result plus local instantiation interface | `SALD.saldDvFiniteLogMgfContract`; `SALD.dvFiniteLogMgfInterfaceObligation`; `dvVariationalObligation saldDvVariationSource` | common measurable space, measurable `Z`, finite `log E_mu[exp Z]`, and alpha-complexity monotonicity for `0 < alpha <= alpha0` |
| `appendix.tex:96-151` uses PI to control the weak PDE velocity through a weighted mean-zero Sobolev space. | local Sobolev/Riesz backend | `SALD.saldPiVelocityNormDependencyContract`; `SALD.piVelocityNormBackendObligation` | Hilbert structure on `dot H^1(mu)`, norm equivalence, bounded functional `T_mu`, Riesz representation, and boundary/regularity for `div(mu*nabla phi)` |
| `main_body.tex:202-215` uses `phi=sqrt(rho/pi)` to derive `KL <= FI/(2*C_LSI)`. | local density-test obligation | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation` | admissibility/approximation of the square-root density test and FI chain rule |
| `appendix.tex:47-71` uses the integrating factor for Gronwall. | local real-calculus obligation | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.gronwallAnalyticObligation`; `SALD.gronwallEndpointCalculusObligation` | closed-interval derivative, interval-integral FTC/backend, order integration, endpoint evaluation, and exponent algebra |

Lower packet:

- Target exactly one first-layer declaration:
  `SALD.saldDvFiniteLogMgfContract`,
  `SALD.saldPiVelocityNormDependencyContract`,
  `SALD.saldGronwallCandidateContract`,
  `SALD.saldGronwallEndpointCalculusContract`, or
  `SALD.saldLsiKlFiDensityTestContract`.
- Preserve the source formulae and statuses: Gronwall remains an obligation,
  DV remains source-cited with local side obligations, PI remains
  contract-only, and LSI-to-KL/FI remains an obligation.
- Do not attach the new finite-log-mgf, Sobolev, or density regularity
  interfaces as hidden assumptions to any theorem statement.

### Lower Cycle 9 Refinement

`SALD.saldGronwallEndpointCalculusContract` now splits the local Gronwall
backend at `appendix.tex:55-69` into endpoint-safe proof obligations:

| Interface slice | Source route | Current status |
|---|---|---|
| Closed-interval derivative semantics | `K_t` differentiable for `t in [0,t1]` | obligation |
| Integrating-factor derivative | differentiate `exp(int_0^t a)*K_t` and substitute `dK/dt <= -a*K+b` | obligation |
| Order integration/FTC | integrate the derivative inequality from `0` to `t1` | obligation |
| Endpoint evaluation | use `exp(int_0^0 a)=1` and keep `K(0)`, `K(t1)` as source endpoints | obligation |
| Exponent rewrite | convert `exp(-int_0^t1 a)*exp(int_0^t a)` to `exp(-int_t^t1 a)` | obligation |

The named obligation `SALD.gronwallEndpointCalculusObligation` depends on the
candidate Gronwall contract and records the Mathlib real/integral algebra still
needed.  No sign condition on `a` or `b` was added, and `lem:gronwall` remains
an obligation.

## Cycle 10 Upper Packet

Objective: keep `thm:forward-KL` fixed and sharpen the source dependency audit
from the post-Young derivative inequality through LSI, inverse-schedule time
change, DV, and Gronwall to the terminal theorem display.  The compiled upper
packet is `SALD.cycle10ForwardKlUpperPacket`.

Mode discipline:

- `faithfulPaper`; use `main_body.tex:238-247` and `appendix.tex:164-252`,
  with `sald_version_2.tex` still excluded from source correspondence;
- preserve the exact theorem statement, the two initial-error exponent factors,
  the residual alpha-complexity integral, and the factor
  `(1/2)*dot{s}(t)^(-1)*alpha^(-1)`;
- keep the KL derivative, LSI-to-KL/FI bridge, DV formula, inverse-schedule
  calculus, and Gronwall lemma as obligations or source-cited facts until local
  Lean proofs replace them.

Compiled refinement:
`SALD.forwardKlDependencyChainAuditContract` now carries three explicit
ledgers for `appendix.tex:210-252`:

| Ledger | Lean-facing field | Purpose |
|---|---|---|
| Source-line coefficient flow | `sourceLineLedger` | Track post-Young, LSI, time-change, DV, Gronwall, exponent-split, and residual-exponent simplification lines without changing constants. |
| Scalar side conditions | `scalarSideConditions` | Expose positivity, endpoint, regularity, finite-log-mgf, common-space, and integrability facts as proof obligations rather than theorem assumptions. |
| Dependency classifications | `sourceDependencyClassification` | Classify LSI as a local density-test obligation, DV as external-cited plus local finite-mgf interface, Gronwall as local real-analysis, KL derivative as local/source-gap, and exponent algebra as local scalar/integral algebra. |

Lower packet:

- target exactly one interface:
  `SALD.forwardKlDependencyChainAuditContract`,
  `SALD.forwardKlGronwallSideConditionContract`, or
  `SALD.forwardKlCoefficientChainObligation`;
- refine one slice only: LSI coefficient bookkeeping, inverse-schedule scalar
  rewrite, DV finite-log-mgf witness, Gronwall coefficient regularity, or
  endpoint/exponent algebra;
- use the new source-line ledger and scalar side-condition list as the audit
  checklist, and leave unresolved analytic content as proof obligations;
- do not modify `thm:forward-KL`,
  `SALD.continuousForwardKlStatementContract`, or the source exponent factors.

Non-goals:

- do not prove or restate `thm:forward-KL`;
- do not replace the paper route
  derivative -> LSI -> DV -> Gronwall with another entropy method;
- do not add endpoint, positivity, regularity, finite-log-mgf, or integrability
  assumptions silently to the theorem statement;
- do not promote any analytic dependency to `formalized`.

Reviewer checklist:

- `SALD.forwardKlDependencyChainAuditContract` contains
  `sourceLineLedger`, `scalarSideConditions`, and
  `sourceDependencyClassification` entries for `appendix.tex:210-252`;
- `SALD.continuousSaldContract` still lists the moving-target,
  coefficient-chain, Gronwall-side-condition, derivative, DV, and Gronwall
  obligations;
- `SALD.forwardKlProofDag` still routes `thm:forward-KL` through
  moving-target dependencies, coefficient-chain audit, derivative, DV-energy,
  and Gronwall blocks;
- `research-wiki/source-index/SALD_original.jsonl` contains `thm:forward-KL`,
  `eq:LSI-KL-FI`, `lem:dv_variation`, and `lem:gronwall`, while excluding
  `sald_version_2.tex`;
- no fake proof closure is introduced.

## Cycle 10 Middle Packet

Objective: refine one slice from the upper packet: the theorem-specific
Donsker--Varadhan finite-log-mgf witness for the continuous `thm:forward-KL`
proof at `appendix.tex:230-241`.  The compiled middle-layer interface is
`SALD.forwardKlDvFiniteLogMgfWitnessContract`; the named obligation is
`SALD.forwardKlDvFiniteLogMgfWitnessObligation`.

Source route:

| Source step | Lean-facing interface | Status |
|---|---|---|
| `appendix.tex:230-235` chooses `nu=rho_{s(t)}`, `mu=pi_t`, and `Z=alpha*||v_t||^2` in `lem:dv_variation`. | `dvMeasures`, `testFunction`, `commonSpaceAndAbsoluteContinuity`, `measurabilityInterface` | obligation |
| `main_body.tex:240-241` assumes finite `E_{alpha0}(pi_t,v_t)` and uses any `alpha in (0,alpha0]`. | `finiteAlpha0Assumption`, `alphaMonotonicityBridge` | obligation |
| `appendix.tex:232-236` divides the DV inequality by `alpha`. | `scalingStep`, `outputBound` | obligation |
| `appendix.tex:239-241` inserts the bound into the scalar differential inequality. | `coefficientUse`; `SALD.forwardKlDependencyChainAuditContract.dvInstantiation` | obligation |

Lower packet:

- target `SALD.forwardKlDvFiniteLogMgfWitnessContract` or
  `SALD.forwardKlDvFiniteLogMgfWitnessObligation`;
- formalize or further specify exactly one backend: alpha0-to-alpha
  exponential-moment monotonicity, common-space/absolute-continuity interface,
  measurability of `||v_t||^2`, or positive-alpha scaling;
- preserve the source coefficient
  `(1/2)*dot{s}(t)^(-1)*alpha^(-1)` and do not add a new theorem assumption;
- keep `lem:dv_variation` source-cited and do not mark the SLT
  `entropy_duality` pattern as imported.

Reviewer checklist:

- `SALD.continuousSaldContract` lists
  `SALD.forwardKlDvFiniteLogMgfWitnessObligation`;
- `SALD.forwardKlProofDag` has
  `ASTIS.SALD.forward_KL.dv_finite_log_mgf_witness` before
  `ASTIS.SALD.forward_KL.dv_energy`;
- `SALD.forwardKlDvEnergyCandidateContract` depends on the witness obligation;
- no statement of `thm:forward-KL` or `continuousForwardKlStatementContract`
  was changed.

### Lower Cycle 10 DV Monotonicity Refinement

`SALD.forwardKlDvAlphaMonotonicityContract` now isolates one backend from the
middle packet: the source assumption
`\mathfrak E_{\alpha_0}(\pi_t,v_t)<+\infty` must supply a finite log-mgf for
the DV test `Z_t=\alpha\|v_t\|^2` whenever `0<\alpha\le\alpha_0`.

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `main_body.tex:240-241` states finite `E_{alpha0}` and allows every `alpha in (0,alpha0]`. | `sourceAssumption`, `alphaRange`; `SALD.forwardKlDvAlphaMonotonicityObligation` | finite alpha0-complexity is still vocabulary/obligation data |
| `appendix.tex:230-236` applies DV to `Z=alpha*||v_t||^2`. | `nonnegativeEnergy`, `pointwiseDomination`, `expectationBridge`, `logMgfBridge` | needs a local measure/order theorem: pointwise `exp(alpha q)<=exp(alpha0 q)` plus finite alpha0 expectation implies finite alpha expectation |
| `appendix.tex:236-241` rewrites the log-mgf as `E_alpha` and inserts the coefficient into the scalar inequality. | `alphaComplexityRewrite`, `downstreamCoefficientUse` | real/log/inverse algebra remains unformalized |

This lower refinement is wired into
`SALD.forwardKlDvEnergyCandidateContract`, `SALD.continuousSaldContract`, and
`SALD.forwardKlProofDag` as
`ASTIS.SALD.forward_KL.dv_alpha_mgf_monotonicity`, before the existing
DV finite-log-mgf witness and DV-energy blocks.  It does not add a new
theorem assumption and does not mark DV or exponential-moment monotonicity
formalized.

## Cycle 11 Upper Packet

Objective: keep `thm:forward-KL-discrete` fixed and isolate the
theorem-specific Donsker--Varadhan finite-log-mgf witness for the EM
interpolation velocity bound at `appendix.tex:493-523`.  The compiled
Lean-facing interface is
`SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; the named obligation is
`SALD.discreteForwardKlDvFiniteLogMgfWitnessObligation`.

Source route:

| Source step | Lean-facing interface | Status |
|---|---|---|
| `appendix.tex:496-507` chooses `nu=\hat\rho_s`, `mu=\tilde\pi_s`, and `Z=\alpha\|v_{t(s)}\|^2`. | `dvMeasures`, `testFunction`, `commonSpaceAndAbsoluteContinuity`, `interpolationLawInterface` | obligation |
| `main_body.tex:301-306` imports the continuous `thm:forward-KL` assumptions and allows `alpha in (0,alpha0)`. | `finiteAlpha0Assumption`, `alphaMonotonicityBridge` | obligation |
| `appendix.tex:503-515` divides by `alpha` and rewrites the log-mgf term as `\mathfrak E_\alpha(\pi_{t(s)},v_{t(s)})`. | `scalingStep`, `outputBound` | obligation |
| `appendix.tex:499-515` keeps `\|\tilde v_s\|^2=\dot t(s)^2\|v_{t(s)}\|^2`. | `dotTScalingStep`, `coefficientUse` | obligation |

Lower packet:

- target `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract` or
  `SALD.discreteForwardKlDvFiniteLogMgfWitnessObligation`;
- refine one backend only: EM-interpolation common-space/absolute-continuity,
  measurability of `\|v_{t(s)}\|^2`, reuse of the continuous
  alpha0-to-alpha finite-log-mgf bridge, positive-alpha scaling, or preservation
  of the `\dot t(s)^2` coefficient;
- keep `lem:dv_variation` source-cited and do not add new hypotheses to
  `thm:forward-KL-discrete`;
- preserve the downstream time-change coefficient
  `\dot{s}(t)^{-1}\alpha^{-1}`.

Reviewer checklist:

- `SALD.discreteSaldContract` lists
  `SALD.discreteForwardKlDvFiniteLogMgfWitnessObligation` before
  `SALD.discreteForwardKlDvVelocityObligation`;
- `SALD.discreteForwardKlProofDag` includes
  `ASTIS.SALD.forward_KL_discrete.dv_finite_log_mgf_witness`;
- `SALD.discreteForwardKlDvVelocityObligation` depends on
  `sald.discrete_forward_kl.dv_finite_log_mgf_witness`;
- the conversion window, proof-obligation table, SLT reuse audit, and source
  index remain synchronized, with `sald_version_2.tex` excluded;
- no analytic result is marked formalized and no fake proof closure is
  introduced.

### Cycle 11 Middle Packet

`SALD.cycle11DiscreteForwardKlMiddleContract` now records the lower-ready
source-to-Lean map for the whole cycle focus.  The named obligation
`SALD.discreteForwardKlEmDefectAccumulationMiddleObligation` is workflow
obligation data: it does not prove the theorem and does not add assumptions.

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `appendix.tex:260-266`, `appendix.tex:334-335` define the continuous EM interpolation and endpoint laws. | `SALD.discreteForwardKlEmInterpolationSideConditionContract`, `SALD.discreteForwardKlEmEndpointObligation` | endpoint law and stitched-interval backend not formalized |
| `appendix.tex:347-385` defines `\bar b_{k,s}` and invokes the interpolation Fokker--Planck equation. | `SALD.discreteForwardKlEmConditionalFpObligation`, `SALD.discreteForwardKlEmInterpolationObligation` | conditional expectation/density Fokker--Planck backend |
| `appendix.tex:454-467` inserts `lem:frozen_delta_cross_lip_sald` and the `Gamma`, `Delta` defects. | `SALD.frozenDeltaCrossLipSaldContract`, `SALD.discreteForwardKlFrozenDeltaObligation` | SALD specialization of the later general frozen-defect lemma |
| `appendix.tex:469-523` applies Young and DV to the moving velocity term. | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`, `SALD.discreteForwardKlDvVelocityObligation` | DV witness, finite log-mgf, and coefficient preservation |
| `appendix.tex:526-590` changes time and applies Gronwall. | `SALD.discreteForwardKlGronwallInstantiationContract`, `SALD.discreteForwardKlGronwallAccumulationObligation` | stitched regularity and scalar Gronwall backend |
| `main_body.tex:309-323` states the linear-slowdown accumulated-error theorem display. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`, `SALD.discreteForwardKlResidualExponentBoundObligation`, `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` | endpoint rewrites, residual exponent drop/full-interval Gamma bound, exponent split, `A_alpha`, `barGamma`, and `barDelta` collection |

Middle lower packet:

- Preferred lower EM target:
  `SALD.discreteForwardKlEmInterpolationSideConditionContract` or
  `SALD.discreteForwardKlEmConditionalFpObligation`.
- Preferred lower accumulated-error target:
  `SALD.discreteForwardKlAccumulatedErrorBridgeContract` or
  `SALD.discreteForwardKlAccumulatedErrorBridgeObligation`.
- Cycle 11 lower scalar target:
  `SALD.discreteForwardKlResidualExponentBoundObligation`, isolating the
  residual exponent drop and the replacement of the interval Gamma integral by
  `barGamma`.
- Keep `thm:forward-KL-discrete`, `Gamma`, `Delta`, `barGamma`,
  `barDelta`, `alpha`, `alpha'`, `eta`, and `r` exactly as in the source.
- If touching the DV substep, depend on
  `SALD.discreteForwardKlDvFiniteLogMgfWitnessObligation`; do not add a new
  theorem hypothesis.

## Cycle 15 Upper Packet

Objective: keep `thm:forward-KL-discrete` fixed and select the EM
interpolation side-condition spine as the next lower target.  The compiled
upper packet is `SALD.cycle15DiscreteForwardKlUpperPacket`.

Source route:

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `appendix.tex:260-266`, `appendix.tex:334-335` define the frozen continuous EM interpolation and endpoint laws. | `SALD.discreteSaldEulerMaruyamaContract`, `SALD.discreteForwardKlEmEndpointObligation` | endpoint law bookkeeping for stitched intervals |
| `appendix.tex:347-354` defines `bar b_{k,s}` by conditional expectation. | `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract`, `SALD.cycle15DiscreteForwardKlConditionalDriftDensityObligation` | regular conditional law, density, measurability, and integrability backend |
| `appendix.tex:357-385` invokes the interpolation Fokker--Planck equation and splits the Laplacian. | `SALD.discreteForwardKlEmConditionalFpObligation`, `SALD.discreteForwardKlEmInterpolationObligation` | conditional-drift Fokker--Planck theorem and Laplacian split not formalized locally |
| `appendix.tex:454-491` uses the frozen one-step defect and LSI after the EM derivative block. | `SALD.frozenDeltaCrossLipSaldContract`, `SALD.discreteForwardKlFrozenDeltaObligation`, `SALD.discreteForwardKlDerivativeObligation` | SALD specialization of the later general frozen-defect lemma |
| `appendix.tex:557-590`, `main_body.tex:309-323` collect the accumulated errors after Gronwall. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`, `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` | endpoint rewrites, residual exponent drop, `barGamma`, and `barDelta` collection |

Lower packet:

- Target exactly one interface:
  `SALD.discreteForwardKlEmInterpolationSideConditionContract`, with the
  first lower slice `SALD.discreteForwardKlEmConditionalFpObligation`.
- Within that slice, the first lower sub-obligation is
  `SALD.cycle15DiscreteForwardKlConditionalDriftDensityObligation`, which
  stops at the law/density and measurable drift interface for `bar b_{k,s}`.
- Refine `appendix.tex:347-385` only: define the conditional drift
  `bar b_{k,s}`, derive
  `partial_s hat rho_s = -div(hat rho_s*bar b_{k,s}) + Delta hat rho_s`,
  and record the Laplacian split relative to `tilde pi_s`.
- Keep endpoint law matching, stitched interval regularity, one-step
  Gamma/Delta defects, DV velocity, and accumulated-error collection as
  separate obligations.
- Do not change `thm:forward-KL-discrete`, `Gamma`, `Delta`, `barGamma`,
  `barDelta`, `alpha`, `alpha'`, `eta`, `r`, or the source step-size
  condition.

Reviewer checklist:

- `SALD.discreteSaldContract` still lists endpoint, conditional-drift density,
  conditional Fokker--Planck, stitched-interval, frozen-defect, DV, Gronwall,
  and accumulated-error obligations.
- `SALD.discreteForwardKlProofDag` includes
  `ASTIS.SALD.forward_KL_discrete.cycle15_upper_packet` and keeps
  `ASTIS.SALD.forward_KL_discrete.em_interpolation_side_conditions` before the
  derivative and Gronwall blocks.
- `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes
  `SALD.cycle15DiscreteForwardKlUpperPacket`,
  `sald.discrete_forward_kl.conditional_drift_density`,
  `sald.discrete_forward_kl.em_endpoint_laws`,
  `sald.discrete_forward_kl.em_conditional_fokker_planck`, and
  `sald.discrete_forward_kl.stitched_interval_regularity`.
- `research-wiki/source-index/SALD_original.jsonl` still indexes the original
  source and excludes `sald_version_2.tex`.
- No analytic dependency is marked formalized and no fake proof closure is
  introduced.

## Cycle 15 Middle Conditional Fokker--Planck Lower Packet

Objective: make the first lower slice selected by the cycle-15 middle packet
line-ready without expanding it into the full derivative theorem.  The compiled
contract is `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerContract`; the
named obligation is
`SALD.cycle15DiscreteForwardKlEmConditionalFpLowerObligation`.

Source-to-Lean map:

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `appendix.tex:347-354` defines `bar b_{k,s}(x)=E[nabla log pi_{t_k}(X_k^eta) | hat X_s=x]`. | `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract`; `SALD.cycle15DiscreteForwardKlConditionalDriftDensityObligation`; `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerContract.conditionalDriftDefinition` | regular conditional law, density, measurability, and integrability backend for `hat X_s` and `hat rho_s*bar b_{k,s}` |
| `appendix.tex:357-364` invokes `partial_s hat rho_s = -div(hat rho_s*bar b_{k,s}) + Delta hat rho_s`. | `SALD.discreteForwardKlEmConditionalFpObligation`; `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerObligation` | frozen-interpolation Fokker--Planck theorem not formalized locally |
| `appendix.tex:365-385` rewrites `Delta hat rho_s` relative to `tilde pi_s` and groups the drift defect. | `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerContract.laplacianSplit` | density positivity, differentiability, and boundary conditions for the Laplacian split |
| `appendix.tex:388-413` uses this divergence form for the KL derivative integration-by-parts step. | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.discreteForwardKlDerivativeObligation` | integration-by-parts backend remains separate from the conditional FP slice |

Lower packet:

- Target `sald.discrete_forward_kl.em_conditional_fokker_planck` first, using
  `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerContract` as the line
  ledger.
- The first subtarget inside the ledger is
  `sald.discrete_forward_kl.conditional_drift_density`; it stops before the
  Fokker--Planck identity and only records the conditional-law/density backend
  for `bar b_{k,s}`.
- Keep `sald.discrete_forward_kl.em_endpoint_laws` and
  `sald.discrete_forward_kl.stitched_interval_regularity` as sibling
  obligations.
- Do not include the frozen `Gamma`/`Delta` lemma, DV velocity estimate,
  Gronwall accumulation, or accumulated-error bridge in this lower slice.
- Record missing conditional-expectation, density, Laplacian, or boundary
  interfaces as obligations rather than theorem assumptions.

## Cycle 12 Upper Packet

Objective: keep the guided/general VA-SALD statements fixed and isolate the
residual-field Donsker--Varadhan finite-log-mgf witness for `m_t`.  The
compiled upper packet is `SALD.cycle12GeneralVaSaldUpperPacket`.

Source route:

| Source step | Lean-facing interface | Status |
|---|---|---|
| `appendix.tex:724-727` assumes finite `E_{alpha0}(pi_t,m_t)` and `0<alpha<=alpha0`. | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract.finiteAlpha0Assumption`; `alphaMonotonicityBridge` | obligation |
| `appendix.tex:885-895` applies DV with `nu=rho_{s(t)}`, `mu=pi_t`, and `Z=alpha*||m_t||^2`. | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessObligation` | obligation + source-cited DV |
| `appendix.tex:899-907` inserts the residual DV bound into the sigma-weighted scalar inequality. | `SALD.generalMovingTargetDvEnergyCandidateContract`; `SALD.generalMovingTargetDvEnergyObligation` | obligation |
| `main_body.tex:372-390`, `appendix.tex:949-951` specialize `c_t<-u_t`, hence `m_t=w_t`. | `SALD.unifiedForwardKlSpecializationContract`; `SALD.unifiedForwardKlSpecializationObligation` | obligation |
| `appendix.tex:1544-1552` reuses the residual DV step under `nu=hat rho_s`, `mu=tilde pi_s`. | `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessObligation` | obligation + source-cited DV |

Lower packet:

- Target exactly one of
  `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`,
  `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`, or the
  corresponding named obligation.
- Refine one backend only: alpha0-to-alpha log-mgf monotonicity for `m_t`,
  common-space/absolute-continuity, measurability of `||m_t||^2`, positive
  alpha scaling, or the discrete EM common-space interface.
- Preserve the continuous coefficient
  `sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)` and the discrete doubled
  coefficient `2*sigma_eta^(-2)*dot t(s)^2` before time change.
- Do not add new assumptions to `thm:general-moving-target-SALD`,
  `thm:unified-forward-KL`, or
  `thm:general-moving-target-SALD-discrete`.

Reviewer checklist:

- `SALD.generalVaSaldContract` and `SALD.unifiedForwardKlContract` list
  `SALD.generalMovingTargetDvFiniteLogMgfWitnessObligation` before the
  residual DV-energy obligation.
- `SALD.generalVaSaldDiscreteContract` lists
  `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessObligation` before
  `SALD.generalMovingTargetDiscreteDvMEnergyObligation`.
- `SALD.generalVaSaldProofDag` and `SALD.generalVaSaldDiscreteProofDag`
  contain residual DV witness blocks before their DV-energy blocks.
- `lem:dv_variation` remains source-cited and no SLT theorem is imported or
  marked formalized.

## Cycle 12 Middle Packet

Objective: keep the cycle-focus proof route synchronized across
`prop:guided_path_residual`, `thm:general-moving-target-SALD`,
`thm:unified-forward-KL`, and
`thm:general-moving-target-SALD-discrete`.  The compiled middle packet is
`SALD.cycle12GeneralVaSaldMiddleContract`; the named obligation is
`SALD.generalVaSaldGuidedPathMiddleObligation`.

Source-to-Lean map:

| Source step | Lean-facing interface | Status |
|---|---|---|
| `appendix.tex:619-704` differentiates `Z_t` and `pi_t`, cancels divergence terms, and centers `g_t`. | `SALD.guidedResidualIdentityContract`; `SALD.guidedResidualNormalizerObligation`; `SALD.guidedResidualIdentityObligation` | obligation |
| `main_body.tex:359-368` combines the residual identity with `eq:poisson-eq` to make `u_t+w_t` a transport velocity for `pi_t`. | `SALD.unifiedForwardKlSpecializationContract`; `SALD.unifiedForwardKlSpecializationObligation` | obligation/source bridge |
| `appendix.tex:765-884` derives the sigma-weighted general KL derivative with `m_t=v_t-c_t`. | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation` | obligation |
| `appendix.tex:885-934` applies residual DV and Gronwall with the source sigma-weighted coefficients. | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvEnergyCandidateContract`; `SALD.generalMovingTargetGronwallInstantiationContract` | obligation + source-cited DV |
| `appendix.tex:936-951` handles pure contraction and the unified specialization `c_t<-u_t`, so `m_t=w_t`. | `SALD.generalMovingTargetPureContractionObligation`; `SALD.unifiedForwardKlSpecializationObligation` | obligation |
| `appendix.tex:1354-1600` repeats the route under the general EM interpolation, preserving the doubled residual coefficient and Gamma/Delta terms. | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract` | obligation |
| `appendix.tex:1603` specializes the discrete general theorem to discrete VA-SALD by replacing `c` with `u`. | `SALD.discreteUnifiedVaSaldSpecializationObligation` | obligation |

Lower packet:

- Target exactly one existing backend obligation from the middle map.
  Preferred targets are `SALD.unifiedForwardKlSpecializationObligation` or
  `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation`.
- For the unified specialization, prove only the transport-velocity bridge
  from `prop:guided_path_residual` plus `eq:poisson-eq` to
  `v_t=u_t+w_t` and `m_t=w_t`.
- For the discrete derivative side conditions, preserve the two
  `sigma_eta^2/8` Young splits, the residual coefficient
  `2*sigma_eta^(-2)*dot t(s)^2` before time change, and the frozen-delta
  `Gamma`/`Delta` coefficients.
- Do not add correction-field existence, density regularity, finite-log-mgf,
  endpoint, or schedule assumptions silently to any theorem statement.

## Cycle 12 Lower Packet

Lower target: `SALD.generalMovingTargetDvPositiveAlphaScalingContract` and
`SALD.generalMovingTargetDvPositiveAlphaScalingObligation`.

Source slice:

| Source step | Lean-facing interface | Status |
|---|---|---|
| `appendix.tex:887-895` writes the residual DV output as `alpha^{-1}K(t)+alpha^{-1}log E_{pi_t} exp(alpha||m_t||^2)`. | `SALD.generalMovingTargetDvPositiveAlphaScalingContract.divisionStep` | obligation |
| `appendix.tex:891-895` rewrites the log-mgf quotient as `mathfrak E_alpha(pi_t,m_t)`. | `SALD.generalMovingTargetDvPositiveAlphaScalingContract.logMgfRewrite` | obligation |
| `appendix.tex:899-907` inserts the scaled bound into the sigma-weighted derivative inequality. | `SALD.generalMovingTargetDvPositiveAlphaScalingContract.coefficientAudit`; `SALD.generalMovingTargetDvPositiveAlphaScalingObligation` | obligation |
| `main_body.tex:372-390` inherits the same rewrite under `m_t=w_t`. | `SALD.generalMovingTargetDvPositiveAlphaScalingContract.unifiedSpecializationUse` | obligation |

Scope discipline:

- This lower packet only isolates the scalar/order rewrite after the residual
  DV instantiation.
- It does not prove `lem:dv_variation`, the finite-log-mgf monotonicity bridge,
  common-space/absolute-continuity, or measurability.
- It does not add assumptions to `thm:general-moving-target-SALD` or
  `thm:unified-forward-KL`.
- It preserves the coefficient
  `sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)` on `K(t)`.

## Cycle 16 Upper Packet

Objective: keep the guided/general VA-SALD statements fixed and select the
unified theorem transport bridge as the next lower target.  The compiled upper
packet is `SALD.cycle16GeneralVaSaldUpperPacket`; the narrow obligation is
`SALD.unifiedForwardKlTransportBridgeObligation`.

Source route:

| Source step | Lean-facing interface | Status |
|---|---|---|
| `main_body.tex:359-363` imports `prop:guided_path_residual` as `partial_t pi_t+div(pi_t*u_t)=-pi_t(g_t-E_pi_t[g_t])`. | `SALD.guidedResidualIdentityContract`; `SALD.guidedResidualIdentityObligation` | obligation |
| `main_body.tex:364-368` defines `w_t` by `div(pi_t*w_t)=pi_t(g_t-E_pi_t[g_t])` and states that `u_t+w_t` transports `pi_t`. | `SALD.unifiedForwardKlTransportBridgeObligation`; `sald.unified_forward_kl.transport_velocity_bridge` | obligation |
| `appendix.tex:949-951` proves `thm:unified-forward-KL` by setting `c_t <- u_t` in the general moving-target theorem. | `SALD.unifiedForwardKlSpecializationContract`; `SALD.unifiedForwardKlSpecializationObligation` | obligation |
| The specialization records `v_t=u_t+w_t`, `c_t=u_t`, and `m_t=w_t`; the sigma-weighted theorem display stays `main_body.tex:374-390`. | `SALD.unifiedForwardKlContract`; `SALD.generalVaSaldContract` | contract + obligation |

Mode discipline:

- `faithfulPaper`; use `main_body.tex:359-395`, `appendix.tex:619-704`,
  `appendix.tex:724-951`, and `appendix.tex:1603`, excluding
  `sald_version_2.tex`;
- preserve the signs in the residual and correction equations so the two source
  terms cancel to the continuity equation for `pi_t`;
- keep `thm:unified-forward-KL` as a specialization of
  `thm:general-moving-target-SALD`, not a direct VA-SALD proof;
- keep DV, Gronwall, correction-field existence/regularity, boundary, endpoint,
  and discrete EM facts as existing obligations.

Lower packet:

- Target exactly `sald.unified_forward_kl.transport_velocity_bridge`, using
  `SALD.unifiedForwardKlSpecializationContract` as the line ledger.
- Prove or refine only the algebra from `main_body.tex:359-368`:
  centered residual plus `eq:poisson-eq` implies
  `partial_t pi_t+div(pi_t*(u_t+w_t))=0`.
- Then record the specialization `v_t=u_t+w_t`, `c_t=u_t`, and `m_t=w_t`.
- Stop before DV, Gronwall, pure-contraction, or discrete EM proof search.

Non-goals:

- do not prove or restate the general, unified, or discrete general theorem;
- do not solve existence/regularity of `w_t` by adding hidden theorem
  assumptions;
- do not replace the source specialization with Girsanov, Pinsker, Talagrand,
  path-space, or direct VA-SALD reasoning;
- do not use `sald_version_2.tex`.

Reviewer checklist:

- `SALD.unifiedForwardKlTransportBridgeObligation` is sourced to
  `main_body.tex:359-368` and remains `obligation`;
- `SALD.unifiedForwardKlSpecializationObligation` depends on
  `sald.unified_forward_kl.transport_velocity_bridge` and still follows
  `appendix.tex:949-951`;
- `SALD.saldDependenciesForLabel "thm:unified-forward-KL"` includes
  `SALD.cycle16GeneralVaSaldUpperPacket` and
  `sald.unified_forward_kl.transport_velocity_bridge`;
- the conversion window, proof-obligation ledger, SLT reuse audit, source index,
  and dialogue handoff are synchronized, with `sald_version_2.tex` excluded;
- no analytic dependency is marked formalized and no fake proof closure is
  introduced.

## Cycle 16 Middle Packet

Objective: turn the cycle-16 upper target into a lower-ready source-to-Lean
line ledger for the unified transport bridge.  The compiled middle contract is
`SALD.cycle16UnifiedForwardKlTransportBridgeMiddleContract`; the named
workflow obligation is
`SALD.cycle16UnifiedForwardKlTransportBridgeMiddleObligation`.

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `main_body.tex:359-363` gives the centered residual equation from `prop:guided_path_residual`. | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.identity` | guided-density differentiation and centering remain obligations |
| `main_body.tex:364-367` defines `w_t` by `div(pi_t*w_t)=pi_t(g_t-E_pi_t[g_t])`. | `SALD.unifiedForwardKlSpecializationContract`; `eq:poisson-eq` | correction-field existence, regularity, boundary/weak divergence backend |
| `main_body.tex:368` cancels the two displayed equations to make `u_t+w_t` transport `pi_t`. | `SALD.unifiedForwardKlTransportBridgeObligation`; `sald.unified_forward_kl.transport_velocity_bridge` | local continuity-equation/divergence algebra |
| `appendix.tex:949-951` specializes the general theorem by setting `c_t <- u_t`. | `SALD.unifiedForwardKlSpecializationObligation`; `sald.unified_forward_kl.specialization` | theorem-level specialization after the bridge, no direct proof route |

Middle lower packet:

- Target only `sald.unified_forward_kl.transport_velocity_bridge`.
- Preserve the signs in `partial_t pi_t+div(pi_t*u_t)=-pi_t(...)` and
  `div(pi_t*w_t)=pi_t(...)` so cancellation yields
  `partial_t pi_t+div(pi_t*(u_t+w_t))=0`.
- Record `v_t=u_t+w_t`, `c_t=u_t`, and `m_t=w_t` after the bridge.
- Keep correction-field existence, weak/divergence regularity, DV, Gronwall,
  and discrete EM work as separate obligations.

### Cycle 16 Lower Refinement

Lower slice: `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract` and
`SALD.cycle16UnifiedForwardKlTransportBridgeLowerObligation` refine the target
`sald.unified_forward_kl.transport_velocity_bridge`.

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `main_body.tex:359-363` supplies the signed residual equation `partial_t pi_t+div(pi_t*u_t)=-pi_t(g_t-E_pi_t[g_t])`. | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract.residualEquation` | depends on `sald.guided_path_residual.identity`; guided differentiation remains separate |
| `main_body.tex:364-367` supplies `div(pi_t*w_t)=pi_t(g_t-E_pi_t[g_t])`. | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract.correctionEquation` | existence, regularity, weak divergence, and boundary conditions for `w_t` are not proved in the paper |
| Adding the two displays cancels the centered guide residual. | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract.cancellationStep`; `sald.unified_forward_kl.transport_bridge_lower` | local scalar/sign algebra only |
| Rewriting `div(pi_t*u_t)+div(pi_t*w_t)` as `div(pi_t*(u_t+w_t))` yields the transport equation. | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract.divergenceLinearity`; `SALD.unifiedForwardKlTransportBridgeObligation` | weak/product-divergence linearity backend |
| The appendix specialization then uses `v_t=u_t+w_t`, `c_t=u_t`, and `m_t=w_t`. | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract.specializationIdentifications`; `SALD.unifiedForwardKlSpecializationObligation` | theorem-level specialization remains obligation |

The lower slice does not solve correction-field existence, does not prove the
unified theorem directly, and does not enter residual DV, Gronwall, or
discrete EM proof search.

## Cycle 13 Upper Packet

Objective: refresh the source-index and first appendix/vocabulary contracts
for `lem:gronwall`, `lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI`.  The
compiled upper packet is `SALD.cycle13FirstAppendixVocabularyPacket`; the
source-index audit contract is
`SALD.cycle13FirstAppendixSourceIndexAuditContract`.

Source-index map:

| Source label | Indexed source | Lean-facing interfaces | Status |
|---|---|---|---|
| `lem:gronwall` | `appendix.tex:47` | `SALD.gronwallContract`, `SALD.saldGronwallCandidateContract`, `SALD.saldGronwallEndpointCalculusContract`, `SALD.saldGronwallExponentRewriteContract`, `SALD.gronwallAnalyticObligation`, `SALD.gronwallEndpointCalculusObligation`, `SALD.gronwallExponentRewriteObligation` | obligation |
| `lem:dv_variation` | `appendix.tex:73` | `SALD.dvContract`, `SALD.saldDvFiniteLogMgfContract`, `dvVariationalObligation`, `SALD.dvFiniteLogMgfInterfaceObligation` | source-cited + obligation |
| `def:PI` | `appendix.tex:86` | `SALD.piDefinitionContract`, `SALD.saldPIContract`, `SALD.saldPiVelocityNormDependencyContract`, `SALD.piVelocityNormBackendObligation` | contract-only + obligation |
| `eq:LSI-KL-FI` | `main_body.tex:202` | `SALD.lsiKlFiVocabularyContract`, `SALD.saldKLContract`, `SALD.saldFIContract`, `SALD.saldLSIContract`, `SALD.saldLsiKlFiDensityTestContract`, `SALD.lsiKlFiDensityTestObligation` | obligation |

Lower packet:

- Target exactly one first-layer interface:
  `SALD.saldGronwallEndpointCalculusContract`,
  `SALD.saldGronwallExponentRewriteContract`,
  `SALD.saldDvFiniteLogMgfContract`,
  `SALD.saldPiVelocityNormDependencyContract`, or
  `SALD.saldLsiKlFiDensityTestContract`.
- Start from `research-wiki/source-index/SALD_original.jsonl`, then preserve
  the matching `SourceAnchor` and source label in Lean.
- Refine only an existing contract or named proof obligation if the analytic
  backend is not ready.
- Do not change `thm:forward-KL`, `thm:forward-KL-discrete`,
  `thm:general-moving-target-SALD`, or any later theorem statement.

Reviewer checklist:

- `python3 tools/astis.py source-index ASTIS-SALD-001` indexes all four focus
  labels and excludes `sald_version_2.tex`.
- `SALD.saldFirstProofDag` exposes
  `SALD.cycle13FirstAppendixSourceIndexAuditContract` and
  `sald.first_appendix.source_index_audit` for the four focus labels.
- Gronwall remains a local real-analysis obligation, DV remains source-cited
  plus local instantiation obligations, PI remains definition/velocity-backend
  data, and LSI-to-KL/FI remains a density-test obligation.
- No source-cited or analytic backend is marked formalized without a compiled
  Lean proof.

## Cycle 13 Middle Packet

Objective: turn the cycle 13 source-index packet into a lower-ready
source-to-Lean map.  The compiled middle record is
`SALD.cycle13FirstAppendixMiddleAuditContract`; the named obligation is
`SALD.firstAppendixMiddleAuditObligation`.

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `appendix.tex:47-71` Gronwall integrating-factor proof | `SALD.saldGronwallCandidateContract`, `SALD.saldGronwallEndpointCalculusContract`, `SALD.saldGronwallExponentRewriteContract`, `SALD.gronwallExpProductRewriteScalar`, `sald.gronwall.integrating_factor`, `sald.gronwall.endpoint_calculus`, `sald.gronwall.exponent_rewrite` | endpoint-safe derivative or absolute-continuity formulation, interval-integral FTC, order integration, endpoint evaluation, and the remaining appendix.tex:63-69 interval-additivity/integral-congruence rewrite |
| `appendix.tex:73-79` DV formula | `SALD.dvContract`, `SALD.saldDvFiniteLogMgfContract`, `probability.dv_variational_formula`, `sald.dv_variation.finite_log_mgf_interface` | source-cited theorem plus common-space, measurability, finite-log-mgf, and alpha-complexity witness interfaces |
| `appendix.tex:86-151` PI and velocity-norm route | `SALD.saldPIContract`, `SALD.piDefinitionContract`, `SALD.saldPiVelocityNormDependencyContract`, `sald.pi.velocity_norm_backend` | weighted mean-zero Sobolev Hilbert structure, bounded functional, Riesz representation, weak PDE regularity, boundary handling |
| `main_body.tex:202-215` LSI/KL/FI bridge | `SALD.saldLsiKlFiBridgeContract`, `SALD.saldLsiKlFiDensityTestContract`, `sald.lsi_kl_fi.density_test_interface`, `probability.lsi_to_kl_fi` | Radon-Nikodym density vocabulary, admissible `sqrt(rho/pi)` test, entropy rewrite, FI chain rule, coefficient audit |

Middle lower packet:

- Preferred target: `SALD.saldGronwallEndpointCalculusContract`, especially
  the lower sub-target `SALD.saldGronwallExponentRewriteContract` and
  `sald.gronwall.exponent_rewrite`.
- Alternative targets: `SALD.saldDvFiniteLogMgfContract`,
  `SALD.saldPiVelocityNormDependencyContract`, or
  `SALD.saldLsiKlFiDensityTestContract`.
- Refine one interface only.  If a backend proof is not ready, add or narrow a
  `ProofObligation`; do not change theorem statements.
- Keep `SALD_original.jsonl` as the source-anchor checklist and keep
  `sald_version_2.tex` excluded.

## Cycle 17 Upper Packet

Objective: rebaseline the source-index and first appendix/vocabulary contracts
for `lem:gronwall`, `lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI` after
the cycle-16 unified transport bridge.  The compiled upper packet is
`SALD.cycle17FirstAppendixVocabularyPacket`.

Mode discipline:

- `faithfulPaper`; use only the original `appendix.tex:47-94` and
  `main_body.tex:202-215` windows, with `sald_version_2.tex` excluded;
- preserve the source Gronwall sign convention, DV finite-log-mgf condition,
  PI constant convention `C_PI^{-1}`, and the LSI-to-KL/FI coefficient
  `1/(2*C_LSI)`;
- keep this as Phase 1 transcript and obligation refinement, not reusable API
  reorganization.

Non-goals:

- do not edit later SALD theorem statements;
- do not replace the source route by Pinsker, Talagrand, PI-to-LSI, Girsanov,
  or a direct VA-SALD proof;
- do not add hidden endpoint, smoothness, finite-log-mgf, density, Sobolev, or
  boundary assumptions;
- do not mark Gronwall, DV, PI velocity bounds, or LSI-to-KL/FI formalized
  without a local build.

Lower packet:

- middle must keep Lean, the conversion window, this obligation ledger, and
  the exact TeX line windows synchronized;
- preferred target: tighten `SALD.cycle13FirstAppendixSourceIndexAuditContract`
  / `sald.first_appendix.source_index_audit` against `SALD_original.jsonl`;
- if an analytic slice is chosen, prefer `SALD.saldGronwallExponentRewriteContract`
  / `sald.gronwall.exponent_rewrite`;
- alternatives remain `SALD.saldDvFiniteLogMgfContract`,
  `SALD.saldPiVelocityNormDependencyContract`, and
  `SALD.saldLsiKlFiDensityTestContract`, one at a time.

Reviewer checklist:

- `python3 tools/astis.py source-index ASTIS-SALD-001` indexes all four focus
  labels and excludes `sald_version_2.tex`;
- `SALD.saldFirstProofDag` keeps Gronwall as obligation, DV as source-cited,
  PI as contract-only, and LSI/KL/FI as obligation;
- the conversion window and this ledger identify cycle 17 as
  source-index/contract synchronization only;
- `python3 tools/astis.py check` passes with no fake proof closure.

## Cycle 17 Middle Packet

Objective: translate the cycle-17 source-index rebaseline into a lower-ready
source-to-Lean map over `lem:gronwall`, `lem:dv_variation`, `def:PI`, and
`eq:LSI-KL-FI`.  The compiled middle record is
`SALD.cycle17FirstAppendixMiddleAuditContract`.

| Source window | Lean-facing target | Remaining obligation |
|---|---|---|
| `appendix.tex:47-71`, especially exponent rewrite `appendix.tex:63-69` | `SALD.saldGronwallExponentRewriteContract`, `SALD.gronwallExponentRewriteObligation`, compiled scalar helpers `SALD.gronwallNegIntegralRewriteScalar` and `SALD.gronwallExpProductRewriteScalar` | cycle 17 scalar `Real.exp` product algebra builds locally; cycle 18 adds the adjacent-interval bridge, while theorem-specific interval-integrability and congruence inside the `b_t` integral remain |
| `appendix.tex:73-79` | `SALD.dvContract`, `SALD.saldDvFiniteLogMgfContract`, `sald.dv_variation.finite_log_mgf_interface` | DV remains Boucheron-source-cited; local side conditions are common space, measurable `Z`, and finite log-mgf |
| `appendix.tex:86-151` | `SALD.saldPIContract`, `SALD.saldPiVelocityNormDependencyContract`, `sald.pi.velocity_norm_backend` | weighted mean-zero Sobolev backend, bounded functional, Riesz representation, weak PDE, and boundary regularity |
| `main_body.tex:202-215` | `SALD.saldLsiKlFiBridgeContract`, `SALD.saldLsiKlFiDensityTestContract`, `sald.lsi_kl_fi.density_test_interface` | Radon-Nikodym density, admissible `sqrt(rho/pi)`, entropy identity, FI chain rule, and coefficient audit |

Middle lower packet:

- target `SALD.saldGronwallExponentRewriteContract` /
  `sald.gronwall.exponent_rewrite` only;
- preserve the source expression
  `exp(-int_0^t1 a)*exp(int_0^t a)=exp(-int_t^t1 a)` and do not add sign
  assumptions on `a` or `b`;
- keep `SALD.gronwallNegIntegralRewriteScalar`,
  `SALD.gronwallExpProductRewriteScalar`, and the cycle-18 adjacent-interval
  bridge as local sublemmas only; they do not discharge theorem-specific
  interval-integrability or the integral-congruence backend;
- keep the source-index audit synchronized with `SALD_original.jsonl` and keep
  `sald_version_2.tex` excluded;
- do not promote Gronwall, DV, PI velocity bounds, or LSI-to-KL/FI beyond
  their current statuses.

## Cycle 14 Upper Packet

Objective: return to continuous `thm:forward-KL` and keep the source theorem
fixed while selecting the moving-target side-condition interface as the next
lower target.  The compiled upper packet is
`SALD.cycle14ForwardKlUpperPacket`.

Mode discipline:

- `faithfulPaper`; use `main_body.tex:238-247` and `appendix.tex:164-252`
  from the original source root, with `sald_version_2.tex` excluded;
- preserve the source theorem statement, the two initial-error exponent
  factors, the residual alpha-complexity integral, and the source
  `a(t)`/`b(t)` Gronwall coefficients;
- keep endpoint schedule identities, density/boundary regularity, transport
  and Fokker--Planck backends, LSI-to-KL/FI, DV finite-log-mgf, inverse-schedule
  calculus, and Gronwall regularity as obligations or source-cited facts until
  local Lean proofs replace them.

Lower packet:

- target exactly one interface:
  `SALD.forwardKlEndpointScheduleContract`,
  `SALD.forwardKlMovingTargetDependencyContract`,
  `SALD.forwardKlGronwallSideConditionContract`,
  `SALD.forwardKlDerivativeSideConditionContract`, or the named obligations
  `sald.forward_kl.endpoint_schedule_identities`,
  `sald.forward_kl.moving_target_dependency_chain` and
  `sald.forward_kl.gronwall_side_conditions`;
- preferred slice: isolate endpoint schedule identities `s(0)=0`,
  `S=s(T)`, `t(s(T))=T`, and `tilde_pi_{s(t)}=pi_t` in
  `SALD.forwardKlEndpointScheduleContract` without adding them as theorem
  hypotheses;
- alternative slices: slowed-target transport velocity, density/boundary side
  conditions for the KL derivative, DV finite-log-mgf/common-space witness, or
  continuity/integrability of the Gronwall coefficients `a(t)` and `b(t)`;
- keep the differential inequality from `appendix.tex:239-241` and the terminal
  theorem display in `main_body.tex:243-246` unchanged.

Non-goals:

- do not prove or restate `thm:forward-KL`;
- do not replace derivative -> LSI -> DV -> Gronwall with another route;
- do not add endpoint, regularity, positivity, finite-log-mgf,
  absolute-continuity, or integrability assumptions silently to the theorem
  statement;
- do not change the discrete or general moving-target theorem statements.

Reviewer checklist:

- `SALD.continuousSaldContract` still lists the middle source-to-Lean,
  moving-target, derivative side-condition, DV witness, coefficient-chain,
  Gronwall-side-condition, derivative, DV-energy, and Gronwall obligations;
- `SALD.forwardKlProofDag` routes `thm:forward-KL` through
  `ASTIS.SALD.forward_KL.moving_target_dependencies` before derivative,
  DV-energy, and Gronwall proof search;
- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle14ForwardKlUpperPacket`, `SALD.cycle14ForwardKlMiddleContract`,
  and `sald.forward_kl.middle_source_to_lean_map`;
- `research-wiki/source-index/SALD_original.jsonl` contains `thm:forward-KL`,
  `eq:LSI-KL-FI`, `lem:dv_variation`, and `lem:gronwall`, while excluding
  `sald_version_2.tex`;
- no fake proof closure is introduced and no analytic dependency is marked
  formalized.

## Cycle 14 Middle Packet

Objective: map the continuous `thm:forward-KL` proof route from
`appendix.tex:168-252` and `main_body.tex:238-247` into Lean-facing contracts,
cited-result interfaces, and named proof obligations.  The compiled middle
record is `SALD.cycle14ForwardKlMiddleContract`; the named obligation is
`SALD.forwardKlMiddleSourceToLeanMapObligation`.

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `main_body.tex:238-247` theorem setup and terminal bound | `SALD.continuousForwardKlStatementContract`, `SALD.continuousSaldContract`, `SALD.forwardKlMovingTargetDependencyContract`, `SALD.forwardKlEndpointScheduleContract` | endpoint schedule identities, slowed target, and transport interface |
| `appendix.tex:168-185` KL derivative and first Fokker--Planck term | `SALD.forwardKlDerivativeSideConditionContract`, `sald.forward_kl.density_boundary_regular`, `sald.forward_kl.kl_derivative` | density regularity, mass conservation, differentiation under the integral, boundary handling |
| `appendix.tex:187-208` slowed transport velocity and Young bound | `TransportVelocityContract`, `SALD.forwardKlMovingTargetDependencyContract`, `sald.forward_kl.schedule_time_change` | transport backend and inverse-schedule calculus |
| `appendix.tex:210-228` LSI and time change | `SALD.saldLsiKlFiDensityTestContract`, `probability.lsi_to_kl_fi`, `SALD.forwardKlDependencyChainAuditContract` | LSI density-test proof and coefficient bookkeeping |
| `appendix.tex:230-241` DV velocity-energy estimate | `SALD.forwardKlDvAlphaMonotonicityContract`, `SALD.forwardKlDvFiniteLogMgfWitnessContract`, `SALD.forwardKlDvEnergyCandidateContract` | source-cited DV plus finite-log-mgf/common-space and positive-alpha scaling |
| `appendix.tex:244-252` Gronwall and terminal display | `SALD.forwardKlGronwallInstantiationContract`, `SALD.forwardKlGronwallSideConditionContract`, `sald.forward_kl.gronwall_side_conditions` | coefficient regularity, endpoint rewrites, exponent split, residual-exponent sign facts |

Middle lower packet:

- Preferred lower target: refine `SALD.forwardKlEndpointScheduleContract` and
  `sald.forward_kl.endpoint_schedule_identities` for `s(0)=0`, `S=s(T)`,
  `t(s(T))=T`, and `tilde_pi_{s(t)}=pi_t`.
- Alternative lower targets: exactly one of slowed-target transport,
  density/boundary side conditions, DV finite-log-mgf/common-space witness, or
  Gronwall coefficient regularity.
- Preserve the source proof route derivative -> LSI -> DV -> Gronwall, the
  differential inequality at `appendix.tex:239-241`, and the terminal display
  at `main_body.tex:243-246`.
- Keep DV source-cited, LSI/Gronwall/KL-derivative local, and all analytic
  backends at obligation status until compiled Lean proofs replace them.

### Lower Cycle 14 Refinement

`SALD.forwardKlEndpointScheduleContract` now narrows the middle packet's
preferred endpoint schedule slice:

| Slice | Source route | Lean-facing target | Current blocker |
|---|---|---|---|
| slowdown and inverse schedule | `main_body.tex:9-13`, `main_body.tex:238` | `SALD.forwardKlEndpointScheduleContract.slowdownInterface` | closed-interval inverse endpoint lemma |
| slowed-target identity | `appendix.tex:218-228` | `SALD.forwardKlEndpointScheduleContract.slowedTargetIdentity` | prove `tilde_pi_{s(t)}=pi_t` from `t(s(t))=t` |
| terminal endpoint | `appendix.tex:244-252`, `main_body.tex:243` | `SALD.forwardKlEndpointScheduleContract.terminalRewrite` | rewrite `K(T)` to `KL(rho_S||pi_T)` using `S=s(T)` |
| initial endpoint | `appendix.tex:244-252`, `main_body.tex:245` | `SALD.forwardKlEndpointScheduleContract.initialRewrite` | rewrite `K(0)` to `KL(rho_0||pi_0)` using `s(0)=0` |

The named obligation is `sald.forward_kl.endpoint_schedule_identities`.  It is
bookkeeping for the final Gronwall endpoint display only; it does not alter
`thm:forward-KL`, the differential inequality, the DV witness, or the source
Gronwall coefficients.

## Cycle 18 Upper Packet

Objective: return to the continuous `thm:forward-KL` chain and assign the final
Gronwall side-condition ledger as the only lower target.  The compiled upper
packet is `SALD.cycle18ForwardKlUpperPacket`.

Source anchors:

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `main_body.tex:238-247` theorem statement and terminal display | `SALD.continuousForwardKlStatementContract`, `SALD.continuousSaldContract` | statement fixed; no new theorem hypotheses allowed |
| `appendix.tex:168-228` derivative, Fokker--Planck, LSI, and time change | `SALD.forwardKlDerivativeSideConditionContract`, `sald.forward_kl.kl_derivative`, `probability.lsi_to_kl_fi` | density/boundary regularity, inverse-schedule calculus, and LSI density-test backend |
| `appendix.tex:230-241` DV with `Z=alpha*||v_t||^2` | `SALD.forwardKlDvFiniteLogMgfWitnessContract`, `SALD.forwardKlDvEnergyCandidateContract` | source-cited DV plus finite-log-mgf/common-space and positive-alpha scaling |
| `appendix.tex:244-252` Gronwall output and theorem display match | `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlGronwallSideConditionObligation` | endpoint rewrites, coefficient regularity, interval-integral exponent split, and residual LSI exponent drop |
| `appendix.tex:63-69` local Gronwall exponent rewrite | `SALD.gronwallNegIntegralRewriteScalar`, `SALD.gronwallExpProductRewriteScalar`, `SALD.gronwallIntervalIntegralAdditivityScalar`, `SALD.gronwallExpProductRewriteIntervalIntegral`, `SALD.gronwallExpProductRewriteIntegralCongr`, `SALD.gronwallExponentRewriteObligation` | scalar Real.exp algebra, adjacent-interval bridge, and outer-integral congruence build, but theorem-specific adjacent interval-integrability remains an obligation |

Mode discipline:

- `faithfulPaper`; use only the original `main_body.tex` and `appendix.tex`,
  keeping `sald_version_2.tex` excluded.
- Preserve the source theorem statement, the two initial-error exponent factors,
  the residual alpha-complexity integral, and the source
  `a(t)=dot{s}(t)*C_LSI(t)-(1/2)*dot{s}(t)^(-1)*alpha^(-1)`,
  `b(t)=(1/2)*dot{s}(t)^(-1)*E_alpha(pi_t,v_t)`.
- Treat cycle-17 scalar Gronwall lemmas and the cycle-18 adjacent-interval
  bridge as partial local algebra only; they do not prove `lem:gronwall` or
  the continuous theorem.

Lower packet:

- target exactly `SALD.forwardKlGronwallSideConditionContract` /
  `SALD.forwardKlGronwallSideConditionObligation` /
  `sald.forward_kl.gronwall_side_conditions`;
- refine one side-condition slice only: endpoint `K(0)`/`K(T)` rewrites,
  coefficient regularity, exponent split, residual LSI exponent drop, or the
  adjacent-interval bridge from interval-integral additivity to the cycle-17
  scalar helpers;
- do not modify `SALD.forwardKlDvFiniteLogMgfWitnessContract`,
  `SALD.saldLsiKlFiDensityTestContract`,
  `SALD.continuousForwardKlStatementContract`, or the source theorem display.

Non-goals:

- do not prove or restate `thm:forward-KL`;
- do not replace derivative -> LSI -> DV -> Gronwall with another route;
- do not add endpoint, positivity, density, boundary, finite-log-mgf,
  differentiability, or integrability assumptions silently to the theorem;
- do not mark DV, LSI-to-KL/FI, KL derivative, moving-target, schedule, or full
  Gronwall backends formalized.

Reviewer checklist:

- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle18ForwardKlUpperPacket` and still includes the cycle-14 packet and
  middle contract;
- `SALD.forwardKlProofDag` lists the cycle-17 scalar helpers and cycle-18
  adjacent-interval bridge only under the Gronwall side-condition block;
- `SALD.continuousSaldContract` remains `contractOnly` and lists all forward-KL
  obligations;
- `research-wiki/source-index/SALD_original.jsonl` indexes `thm:forward-KL`,
  `eq:LSI-KL-FI`, `lem:dv_variation`, and `lem:gronwall`, excluding
  `sald_version_2.tex`;
- fake-proof scan remains clean.

## Cycle 18 Middle Packet

Objective: translate the cycle-18 upper target into a lower-ready map for the
continuous `thm:forward-KL` final Gronwall side conditions.  The compiled
record is `SALD.cycle18ForwardKlMiddleContract`.

| Source window | Lean-facing target | Remaining obligation |
|---|---|---|
| `main_body.tex:238-247` theorem statement and display | `SALD.continuousForwardKlStatementContract`, `SALD.continuousSaldContract` | theorem statement fixed; endpoint, regularity, positivity, and integrability facts remain separate obligations |
| `appendix.tex:210-228` LSI/time-change coefficient chain | `SALD.saldLsiKlFiDensityTestContract`, `SALD.forwardKlEndpointScheduleContract`, `sald.forward_kl.schedule_time_change` | LSI density-test backend and inverse-schedule calculus |
| `appendix.tex:230-241` DV coefficient and residual source | `SALD.forwardKlDvFiniteLogMgfWitnessContract`, `SALD.forwardKlDvEnergyCandidateContract` | Boucheron-source-cited DV plus common-space, measurable-test, finite-log-mgf, and positive-alpha scaling |
| `appendix.tex:244-248` raw Gronwall application | `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlGronwallApplicationObligation` | coefficient regularity for `a(t)`, `b(t)`, endpoint-safe Gronwall, and `K(0)`/`K(T)` rewrites |
| `appendix.tex:249-252` split initial exponent and residual exponent bound | `SALD.forwardKlGronwallSideConditionObligation`, `sald.forward_kl.gronwall_side_conditions` | interval-integral exponent split, nonpositive LSI residual drop, and monotonicity of `Real.exp` over the integral inequality |
| `appendix.tex:63-69` reusable scalar exponent pattern | `SALD.gronwallNegIntegralRewriteScalar`, `SALD.gronwallExpProductRewriteScalar`, `SALD.gronwallIntervalIntegralAdditivityScalar`, `SALD.gronwallExpProductRewriteIntervalIntegral`, `SALD.gronwallExpProductRewriteIntegralCongr`, `SALD.gronwallExponentRewriteObligation` | scalar algebra, adjacent-interval bridge, and outer-integral congruence are formalized; theorem-specific adjacent interval-integrability supplies the remaining hypotheses |

Middle lower packet:

- target exactly `SALD.forwardKlGronwallSideConditionContract` /
  `SALD.forwardKlGronwallSideConditionObligation` /
  `sald.forward_kl.gronwall_side_conditions`;
- preferred sub-slice: bridge interval-integral additivity/orientation to
  `SALD.gronwallNegIntegralRewriteScalar` and
  `SALD.gronwallExpProductRewriteScalar` for the reusable exponent split;
- record the residual-exponent monotonicity as still blocked on
  `C_LSI(u)>=0`, `dot{s}(u)>0`, interval-integral monotonicity, and
  `Real.exp` monotonicity;
- do not edit `SALD.forwardKlDvFiniteLogMgfWitnessContract`,
  `SALD.saldLsiKlFiDensityTestContract`, `SALD.continuousForwardKlStatementContract`,
  or the theorem display.

Reviewer checklist:

- `SALD.forwardKlProofDag` lists `SALD.cycle18ForwardKlMiddleContract` inside
  the Gronwall side-condition block;
- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes the cycle-18
  middle packet and retains the cycle-14 upper/middle packets;
- conversion window, proof obligations, and SLT audit all classify this packet
  as synchronization/obligation work, not a proof of `thm:forward-KL`;
- `python3 tools/astis.py source-index ASTIS-SALD-001` keeps
  `sald_version_2.tex` excluded and `python3 tools/astis.py check` passes.

## Cycle 18 Lower Adjacent-Interval Bridge

Lower target: `SALD.forwardKlGronwallSideConditionContract` /
`SALD.forwardKlGronwallSideConditionObligation` /
`sald.forward_kl.gronwall_side_conditions`.

Compiled Lean sublemmas:

- `SALD.gronwallIntervalIntegralAdditivityScalar`: from adjacent
  `IntervalIntegrable` hypotheses on `[0,t]` and `[t,t1]`, prove the oriented
  interval-integral equality
  `int_0^t1 a = int_0^t a + int_t^t1 a`.
- `SALD.gronwallExpProductRewriteIntervalIntegral`: apply the cycle-17 scalar
  helpers to that equality and prove the pointwise Gronwall factor rewrite
  `exp(-int_0^t1 a)*exp(int_0^t a)=exp(-int_t^t1 a)`.
- `SALD.gronwallExpProductRewriteIntegralCongr`: apply
  `intervalIntegral.integral_congr` to push the pointwise rewrite through the
  source outer integral over `b_t`, under adjacent interval-integrability
  hypotheses for each `t` in the source interval.

Remaining obligations:

- prove the theorem-specific interval-integrability/continuity hypotheses for
  the forward-KL Gronwall coefficient
  `a(t)=dot{s}(t)*C_LSI(t)-(1/2)*dot{s}(t)^(-1)*alpha^(-1)`;
- separately prove endpoint `K(0)`/`K(T)` rewrites, coefficient regularity for
  `b(t)`, and the residual-exponent drop using `C_LSI(u)>=0`,
  `dot{s}(u)>0`, interval-integral monotonicity, and `Real.exp` monotonicity.

## Cycle 19 Upper Packet

Objective: return to discrete `thm:forward-KL-discrete` and select the
accumulated-error bridge as the only lower target.  The compiled upper packet
is `SALD.cycle19DiscreteForwardKlUpperPacket`.

Source-dependency audit for the blocked bridge:

| Blocked source step | Classification | Lean-facing target | Required lower output |
|---|---|---|---|
| `appendix.tex:557-590` applies `lem:gronwall` to the stitched EM inequality. | `external-cited-result` plus `source-contract-gap` | `SALD.discreteForwardKlGronwallAccumulationObligation`, `SALD.discreteForwardKlStitchedIntervalRegularityObligation` | keep Gronwall source-cited and state the endpoint-safe stitched-interval regularity needed for the scalar bridge |
| `main_body.tex:299-323` specializes to `t(s)=s/r`. | `internal-paper-step` | `SALD.discreteForwardKlLinearSlowdownObligation` | rewrite `dot{s}=r`, `dot{s}^{-1}=1/r`, and preserve every source coefficient |
| residual integral in `appendix.tex:573-589` is bounded by the common positive exponent. | `local-lemma` plus `source-contract-gap` | `SALD.discreteForwardKlResidualExponentBoundObligation` | prove the residual exponent drop and full-interval `barGamma` bound using nonnegative LSI, positive `alpha`, `alpha'`, `r`, and interval-integral monotonicity |
| `main_body.tex:310-323` collects `A_alpha`, `barGamma`, and `barDelta_{alpha'}`. | `internal-paper-step` | `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` | identify the three full-interval integrals without changing `Gamma`, `Delta`, `barGamma`, or `barDelta` |

Mode discipline:

- `faithfulPaper`; use only the original `main_body.tex` and `appendix.tex`,
  with `sald_version_2.tex` excluded.
- Preserve the theorem statement, linear slowdown, source `a(t)` and `b(t)`,
  and the displayed constants
  `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
  `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`.
- Keep EM endpoint laws, stitched-interval regularity, coefficient
  integrability, residual-exponent monotonicity, and full-interval integral
  identifications as obligations until they build locally.

Lower packet:

- target exactly `SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
  `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
  `sald.discrete_forward_kl.accumulated_error_bridge`;
- preferred first sub-slice:
  `SALD.discreteForwardKlResidualExponentBoundObligation`, not the full
  theorem;
- keep the appendix Gronwall display distinct from the main-body theorem
  display and bridge them by explicit endpoint, exponent, and integral
  collection lemmas;
- if endpoint stitching, coefficient integrability, or interval-integral
  monotonicity is missing, record the exact source-contract gap rather than
  adding theorem hypotheses.

Non-goals:

- do not prove or restate `thm:forward-KL-discrete`;
- do not reopen the conditional Fokker--Planck, frozen one-step defect, LSI,
  or DV velocity subproofs except as dependencies;
- do not change `Gamma`, `Delta`, `barGamma`, `barDelta`, `alpha`, `alpha'`,
  `eta`, `r`, or the source step-size condition;
- do not hide the accumulated-error bridge behind one opaque assumption.

Reviewer checklist:

- `SALD.discreteForwardKlProofDag` contains
  `ASTIS.SALD.forward_KL_discrete.cycle19_upper_packet` before the
  linear-slowdown, residual-exponent, and accumulated-error blocks.
- `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes
  `SALD.cycle19DiscreteForwardKlUpperPacket` while retaining the cycle-15 EM
  packets and all existing discrete obligations.
- The conversion window and source index point to `main_body.tex:299-323` and
  `appendix.tex:526-592`, excluding `sald_version_2.tex`.
- No analytic dependency is marked formalized and the fake-proof scan remains
  clean.

## Cycle 19 Middle Packet

Middle translated the upper accumulated-error target into
`SALD.cycle19DiscreteForwardKlMiddleContract` and
`SALD.cycle19DiscreteForwardKlAccumulatedErrorMiddleObligation`.

| Source step | Lean-facing target | Remaining obligation |
|---|---|---|
| `appendix.tex:557-571` initial Gronwall term with source `a(t)` | `sald.discrete_forward_kl.gronwall_accumulation` | Gronwall and stitched EM endpoint regularity are still obligations. |
| `appendix.tex:573-589` residual integral with source `b(t)` | `sald.discrete_forward_kl.accumulated_error_bridge` | residual exponent monotonicity and coefficient integrability remain local real/integral obligations. |
| `main_body.tex:299-323` linear slowdown display | `sald.discrete_forward_kl.linear_slowdown_specialization` | endpoint rewrites and `dot{s}=r`, `dot{s}^{-1}=1/r` schedule identities must be supplied. |
| residual exponent bound | `sald.discrete_forward_kl.residual_exponent_bound`; `SALD.discreteForwardKlResidualExponentBoundScalar`; `SALD.discreteForwardKlResidualExpBoundScalar` | scalar order and `Real.exp` monotonicity core is compiled; still need nonnegative LSI, positive `alpha`, `alpha'`, `r`, and interval-integral monotonicity for the full `barGamma` bound. |
| `A_alpha`, `barGamma`, and `barDelta` collection | `sald.discrete_forward_kl.accumulated_error_bridge`; `sald.discrete_forward_kl.coefficient_chain_audit`; `SALD.discreteForwardKlResidualIntegralDisplayBoundScalar` | cycle 61 compiles the final scalar wrapper from a supplied common-exponential residual bound to the `r^(-1)*A_alpha + 2*r*eta*barDelta` display; still identify the full-interval source integrals without changing `Gamma`, `Delta`, or theorem constants. |

Lower packet:

- target `SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
  `SALD.discreteForwardKlAccumulatedErrorBridgeObligation`;
- first sub-slice is
  `SALD.discreteForwardKlResidualExponentBoundObligation`, not the full
  theorem;
- keep EM interpolation, frozen defect, DV velocity, LSI, and Gronwall
  backends separate and at their current obligation/source-cited statuses.

## Cycle 19 Lower Packet

Lower formalized only the scalar real-order core of the residual exponent
sub-slice.  The compiled declarations are
`SALD.discreteForwardKlResidualExponentBoundScalar` and
`SALD.discreteForwardKlResidualExpBoundScalar`.

| Source scalar step | Lean-facing target | Remaining obligation |
|---|---|---|
| Drop the nonnegative LSI contribution in `-int_t^T a` after linear slowdown. | `SALD.discreteForwardKlResidualExponentBoundScalar` | theorem-specific proof that the LSI interval integral is nonnegative from `C_LSI>=0` and `r>0`. |
| Replace interval alpha and Gamma contributions by the full positive theorem exponent. | `SALD.discreteForwardKlResidualExponentBoundScalar` | prove `int_t^T (r*alpha)^{-1} <= T/(r*alpha)` and the Gamma interval bound by `2*r*eta^2*barGamma/alpha'`. |
| Pass the scalar exponent inequality through `exp`. | `SALD.discreteForwardKlResidualExpBoundScalar` | instantiate the scalar terms with interval integrals and connect them to the source `a(t)`. |

This packet does not prove `thm:forward-KL-discrete`, does not change the
source constants, and does not mark Gronwall, endpoint stitching,
coefficient integrability, or interval-integral monotonicity as formalized.

## Cycle 23 Upper Packet

Objective: return to `thm:forward-KL-discrete` after the cycle 22 continuous
forward-KL coefficient work.  Rebaseline the full discrete spine from
Euler--Maruyama interpolation through one-step frozen score defects and the
accumulated-error display, but assign exactly one lower target:
`SALD.discreteForwardKlCoefficientChainAuditContract` /
`SALD.discreteForwardKlCoefficientChainObligation` /
`sald.discrete_forward_kl.coefficient_chain_audit`.

Proof-DAG table:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 23 discrete upper packet | Choose the coefficient-chain audit while keeping the EM interpolation, frozen-delta, DV, Gronwall, and accumulated-error blocks visible as separate obligations. | `SALD.cycle15DiscreteForwardKlUpperPacket`; `SALD.cycle19DiscreteForwardKlUpperPacket`; EM endpoint/FP obligations; frozen-delta obligation; DV; Gronwall | `SALD.cycle23DiscreteForwardKlUpperPacket`; `ASTIS.SALD.forward_KL_discrete.cycle23_upper_packet` | `main_body.tex:273-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete`; cycle 23 lower coefficient audit | obligation |
| Cycle 23 discrete middle coefficient map | Translate the upper-selected coefficient audit into the first lower slice `appendix.tex:454-553`, leaving endpoint and accumulated-error collection as a follow-on slice. | `SALD.cycle23DiscreteForwardKlUpperPacket`; frozen-delta, LSI, DV, time-change, Gronwall, and accumulated-error obligations | `SALD.cycle23DiscreteForwardKlMiddleContract`; `SALD.cycle23DiscreteForwardKlCoefficientChainMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle23_middle_coefficient_chain` | `appendix.tex:454-553`; follow-on `appendix.tex:557-590`, `main_body.tex:309-323` | `sald.discrete_forward_kl.coefficient_chain_audit`; cycle 23 lower coefficient audit | obligation |
| Coefficient-chain audit | Check the coefficient flow from frozen/moving cross terms through LSI, DV, time change, Gronwall, and linear-slowdown accumulation. | `sald.discrete_forward_kl.stitched_interval_regularity`; `sald.discrete_forward_kl.frozen_delta_cross_lip`; `sald.discrete_forward_kl.dv_velocity_bound`; `sald.discrete_forward_kl.gronwall_accumulation`; `sald.discrete_forward_kl.accumulated_error_bridge` | `SALD.discreteForwardKlCoefficientChainAuditContract`; `SALD.discreteForwardKlCoefficientChainObligation` | `appendix.tex:454-592`; `main_body.tex:309-323` | `thm:forward-KL-discrete`; general discrete coefficient pattern | obligation |

Mode discipline:

- `faithfulPaper`; use only `main_body.tex` and `appendix.tex` under the
  original source root and keep `sald_version_2.tex` out of scope;
- preserve the theorem statement, `t(s)=s/r`, the source step-size condition,
  alpha ranges, `Gamma`, `Delta`, `barGamma`, `barDelta`, and the final
  constants `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
  `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`;
- keep EM endpoint laws, conditional Fokker--Planck, the omitted SALD
  frozen-defect proof, LSI-to-KL/FI, DV, Gronwall, endpoint stitching,
  coefficient integrability, and interval-integral monotonicity as obligations
  or source-cited facts until local Lean proofs replace them.

Lower packet:

- target exactly the coefficient-chain audit interface, not the full theorem;
- first sub-slice is `appendix.tex:454-553`: two `1/4*FI` cross-term bounds,
  LSI conversion, DV coefficient `dot{t}(s)^2*alpha^(-1)`, and the time-change
  rewrite to `dot{s}(t)^(-1)*alpha^(-1)`;
- if that sub-slice is stable, then connect `appendix.tex:557-590` to
  `main_body.tex:309-323` through endpoint stitching, residual exponent drop,
  and full-interval `A_alpha`, `barGamma`, and `barDelta` collection;
- if endpoint matching, stitched regularity, coefficient integrability, or
  interval monotonicity is missing, refine the named obligation rather than
  adding theorem hypotheses.

Non-goals:

- do not prove or restate `thm:forward-KL-discrete`;
- do not reopen the continuous forward-KL theorem except as an inherited
  dependency;
- do not replace the one-step frozen-defect route with an alternate entropy,
  path-space, or Girsanov route;
- do not promote `lem:dv_variation`, `lem:gronwall`, `eq:LSI-KL-FI`, EM
  Fokker--Planck, or the omitted frozen-defect proof beyond their current
  statuses.

Reviewer checklist:

- `SALD.discreteForwardKlProofDag` contains
  `ASTIS.SALD.forward_KL_discrete.cycle23_upper_packet` before
  `ASTIS.SALD.forward_KL_discrete.coefficient_chain_audit`;
- `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes
  `SALD.cycle23DiscreteForwardKlUpperPacket` while retaining cycle-15 and
  cycle-19 packets;
- the conversion window, source-index, and proof-obligation ledger cite
  `main_body.tex:273-323` and `appendix.tex:260-592` and still exclude
  `sald_version_2.tex`;
- no analytic dependency is marked formalized and the fake-proof scan remains
  clean.

## Cycle 23 Middle Packet

Middle translated the upper coefficient-chain target into
`SALD.cycle23DiscreteForwardKlMiddleContract` and the named workflow
obligation `sald.discrete_forward_kl.cycle23_coefficient_chain_middle`.
The first lower slice is strictly `appendix.tex:454-553`.

Source-to-Lean map:

| Source step | Lean-facing target | Remaining obligation |
|---|---|---|
| `appendix.tex:454-467` frozen-defect cross term contributes `(1/4)*FI`, `2*eta^2*alpha'^(-1)*Gamma*K`, and `2*eta*Delta`. | `SALD.frozenDeltaCrossLipSaldContract`; `sald.discrete_forward_kl.frozen_delta_cross_lip`; `SALD.discreteForwardKlCoefficientChainAuditContract` | the SALD frozen-defect proof is still omitted in source and must be specialized from the later general lemma |
| `appendix.tex:469-493` moving cross term supplies the second `(1/4)*FI`, then LSI converts `-(1/2)*FI` to `-C_LSI(t(s))*K_s`. | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi`; `sald.discrete_forward_kl.kl_derivative` | density-test, finite-KL/FI, and EM interpolation regularity remain obligations |
| `appendix.tex:496-523` applies DV with `nu=hat rho_s`, `mu=tilde pi_s`, and `Z=alpha*||v_{t(s)}||^2`. | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_finite_log_mgf_witness`; `sald.discrete_forward_kl.dv_velocity_bound` | common-space, absolute-continuity, measurability, finite log-mgf, and positive-alpha scaling are not promoted |
| `appendix.tex:526-553` time-changes the inequality and rewrites `dot{s}(t)*dot t(s(t))^2` to `dot{s}(t)^(-1)`. | `SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar`; `SALD.discreteForwardKlCoefficientChainAuditContract`; `sald.discrete_forward_kl.coefficient_chain_audit` | scalar real algebra formalized; inverse-schedule identities, `dot{s}(t)>0`, and coefficient integrability stay explicit side conditions |
| `appendix.tex:557-590` to `main_body.tex:309-323` is the follow-on bridge only after the first slice is stable. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `sald.discrete_forward_kl.accumulated_error_bridge` | endpoint stitching, residual exponent drop, and full-interval `A_alpha`, `barGamma`, `barDelta` collection remain separate obligations |

Lower packet:

- target exactly `SALD.discreteForwardKlCoefficientChainAuditContract` /
  `SALD.discreteForwardKlCoefficientChainObligation` /
  `sald.discrete_forward_kl.coefficient_chain_audit`;
- do not prove or restate `thm:forward-KL-discrete`;
- do not reopen EM Fokker--Planck, the omitted frozen-defect proof, DV,
  Gronwall, or the accumulated-error bridge in the same lower slice;
- preserve the theorem constants `T/(r*alpha)`,
  `2*r*eta^2*barGamma/alpha'`, `(1/r)*A_alpha(pi,v)`, and
  `2*r*eta*barDelta_{alpha'}`.

Lower update:

- compiled scalar core:
  `SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar`;
- covered source step: `appendix.tex:526-553`, the real-algebra rewrite from
  `dot{s}(t)*dot t(s(t))^2*coeff` to `dot{s}(t)^(-1)*coeff`;
- remaining source gaps: inverse-schedule calculus, nonzero/positive
  `dot{s}(t)`, coefficient integrability, and all analytic backends for
  frozen-defect, LSI, DV, Gronwall, endpoint stitching, and accumulated-error
  collection.

## Cycle 20 Upper Packet

Objective: return to the guided/general VA-SALD path and select the discrete
general Gronwall side-condition/display bridge as the only lower target.  The
compiled upper packet is `SALD.cycle20GeneralVaSaldUpperPacket`.

Source-dependency audit for the blocked bridge:

| Blocked source step | Classification | Lean-facing target | Required lower output |
|---|---|---|---|
| `appendix.tex:1573-1583` defines `K(t)` and changes from `s` to `t`. | local schedule/stitching interface | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract.endpointLawIdentities`; `SALD.generalMovingTargetDiscreteConstantScheduleObligation` | isolate endpoint laws for the stitched EM path and the identity `dot t(s(t))=dot s(t)^{-1}` |
| `appendix.tex:1586-1597` states the final differential inequality. | local coefficient audit | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract.residualCoefficientAudit`; `frozenDeltaCoefficientAudit` | preserve the doubled residual coefficient and the `dot{s}` multipliers on `Gamma` and `Delta` |
| `appendix.tex:1600` invokes `lem:gronwall`. | source-cited Gronwall plus local regularity gaps | `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` | expose piecewise differentiability or absolute continuity of `K(t)` and interval-integrability of `a(t)`, `b(t)` |
| `appendix.tex:1316-1347` is the theorem display. | exact display-matching obligation | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract.gronwallDisplayMatch` | rewrite the Gronwall output to the displayed bound without changing any coefficient |

Mode discipline:

- `faithfulPaper`; use only the original `appendix.tex` and `main_body.tex`,
  with `sald_version_2.tex` excluded.
- Preserve the discrete theorem display coefficients
  `(sigma_eta(t)^2/2)*dot{s}(t)*C_LSI(t)`,
  `2*sigma_eta(t)^(-2)*dot{s}(t)^(-1)*alpha^(-1)`,
  `2*dot{s}(t)*eta^2*alpha'^(-1)*Gamma(t)`,
  `2*sigma_eta(t)^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)`,
  and `2*dot{s}(t)*eta*Delta(t)`.
- Keep the source route EM interval derivative -> residual/frozen split ->
  DV/LSI -> time change -> Gronwall.  The continuous general theorem and the
  unified theorem remain fixed dependencies, not alternate proof routes.
- Treat endpoint stitching, constant-schedule algebra, coefficient
  integrability, piecewise differentiability, and Gronwall as obligations
  until they build locally.

Lower packet:

- target exactly
  `SALD.generalMovingTargetDiscreteGronwallSideConditionContract` /
  `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` /
  `sald.general_moving_target_discrete.gronwall_side_conditions`;
- refine one sub-slice only: endpoint stitching for `K(0)`/`K(T)`,
  constant-schedule coefficient rewrites, coefficient regularity for
  `a(t)`, `b(t)`, or exact Gronwall-display matching;
- preserve `appendix.tex:1586-1597` and theorem display
  `appendix.tex:1316-1347`;
- if schedule algebra, stitched EM regularity, or interval-integrability is
  blocked, record the exact source-contract gap rather than adding theorem
  hypotheses.

Non-goals:

- do not prove or restate `thm:general-moving-target-SALD-discrete`;
- do not reopen the frozen-delta lemma, residual DV finite-log-mgf witness,
  LSI-to-KL/FI bridge, or KL derivative except as dependencies;
- do not turn the discrete guided specialization into a direct VA-SALD proof;
- do not change `alpha`, `alpha'`, `eta`, `sigma_eta`, `Gamma`, `Delta`, or
  any doubled residual coefficient.

Reviewer checklist:

- `SALD.generalVaSaldDiscreteProofDag` contains
  `ASTIS.SALD.general_moving_target_discrete.cycle20_upper_packet` before the
  Gronwall side-condition block.
- `SALD.saldDependenciesForLabel "thm:general-moving-target-SALD-discrete"`
  includes `SALD.cycle20GeneralVaSaldUpperPacket` and keeps the existing EM,
  frozen-delta, derivative, DV, and Gronwall obligations.
- `SALD.generalVaSaldDiscreteContract` remains `contractOnly`, and
  `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` remains an
  obligation.
- The conversion window, source index, and SLT audit classify this as
  workflow/local algebra work, not a theorem proof.

## Cycle 20 Middle Packet

Middle added the lower-ready source-to-Lean map
`SALD.cycle20GeneralVaSaldMiddleContract` plus
`SALD.cycle20GeneralVaSaldDiscreteGronwallMiddleObligation` for
`sald.general_moving_target_discrete.gronwall_side_conditions`.  This is
workflow/ledger data only and does not prove
`thm:general-moving-target-SALD-discrete`.

| Source step | Lean-facing target | Remaining obligation |
|---|---|---|
| `appendix.tex:1573-1576` defines `K(t)=KL(hat rho_{s(t)}||pi_t)`. | `SALD.cycle20GeneralVaSaldMiddleContract.sourceStepMap`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract.endpointLawIdentities` | prove stitched EM endpoint laws and identify `K(0)`, `K(T)` with the theorem endpoints |
| `appendix.tex:1579-1583` uses `dK/dt=dot{s}(t)dK/ds` and `dot t(s(t))=dot{s}(t)^(-1)`. | `SALD.cycle20GeneralVaSaldMiddleContract`; `SALD.generalMovingTargetDiscreteConstantScheduleObligation` | formal schedule API for the inverse constant slowdown and interval-wise chain rule |
| `appendix.tex:1586-1597` gives the t-time differential inequality. | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract.residualCoefficientAudit`; `frozenDeltaCoefficientAudit` | preserve the doubled residual coefficient and the `dot{s}` multipliers on `Gamma` and `Delta` |
| `appendix.tex:1600` invokes `lem:gronwall`. | `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation`; `sald.general_moving_target_discrete.gronwall_side_conditions` | provide coefficient regularity, stitched absolute continuity or piecewise differentiability of `K(t)`, and exact display matching |

Lower packet:

- target exactly
  `SALD.generalMovingTargetDiscreteGronwallSideConditionContract` /
  `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` /
  `sald.general_moving_target_discrete.gronwall_side_conditions`;
- preferred first sub-slice: constant-schedule coefficient rewrite from
  `appendix.tex:1579-1597`, especially
  `dot{s}(t)*dot t(s(t))^2 = dot{s}(t)^(-1)`;
- alternatives are endpoint stitching, coefficient regularity, or exact
  display matching, one sub-slice at a time;
- keep EM interpolation, frozen-delta, residual DV finite-log-mgf, LSI,
  KL derivative, and full Gronwall as separate obligations.

### Lower Cycle 20 Refinement

The constant-schedule coefficient sub-slice now has compiled scalar algebra in
`AutoSamplingTheory/SALD.lean`:

| Source proof step | Lean declaration | Current status |
|---|---|---|
| `appendix.tex:1579-1583` uses the inverse-schedule identity to rewrite `dot{s}(t)*dot t(s(t))^2` | `SALD.generalMovingTargetDiscreteConstantScheduleSquareScalar` | formalized scalar core |
| `appendix.tex:1588-1594` rewrites the doubled residual coefficient after multiplying by `dot{s}(t)` | `SALD.generalMovingTargetDiscreteResidualCoefficientRewriteScalar` | formalized scalar core |
| `appendix.tex:1592-1595` carries the frozen `Gamma` coefficient through the time change | `SALD.generalMovingTargetDiscreteGammaCoefficientRewriteScalar` | formalized scalar core |
| `appendix.tex:1596-1597` carries the frozen `Delta` coefficient through the time change | `SALD.generalMovingTargetDiscreteDeltaCoefficientRewriteScalar` | formalized scalar core |

Remaining gaps are unchanged: the formal inverse-schedule/chain-rule API,
`dot{s}(t) != 0`, stitched endpoint laws for `K(0)` and `K(T)`, piecewise
differentiability or absolute continuity of the stitched KL path, interval
integrability of `a(t)` and `b(t)`, and the final Gronwall/display matching.
No theorem statement was strengthened and no analytic dependency was promoted.

## Cycle 21 Upper Packet

Objective: rebaseline the source-index and first appendix/vocabulary layer
after the cycle-20 discrete general VA-SALD scalar coefficient work.  The
compiled upper packet is `SALD.cycle21FirstAppendixVocabularyPacket`.

Source-dependency audit:

| Blocked source step | Classification | Lean-facing target | Required lower output |
|---|---|---|---|
| `appendix.tex:47-71` Gronwall integrating-factor proof and final exponent rewrite. | local real/interval-integral calculus | `SALD.saldGronwallEndpointCalculusContract`; `SALD.saldGronwallExponentRewriteContract`; `sald.gronwall.exponent_rewrite` | refine endpoint-safe derivative/FTC assumptions or theorem-specific adjacent interval-integrability without changing signs or endpoint display |
| `appendix.tex:73-79` Donsker--Varadhan formula. | source-cited external result plus local instantiation interface | `SALD.saldDvFiniteLogMgfContract`; `sald.dv_variation.finite_log_mgf_interface` | expose common-space, measurability, and finite-log-mgf witnesses; do not mark DV formalized |
| `appendix.tex:86-151` PI definition and velocity-norm route. | definition contract plus local Sobolev/Riesz backend | `SALD.saldPiVelocityNormDependencyContract`; `sald.pi.velocity_norm_backend` | refine weighted mean-zero Sobolev, bounded functional, weak PDE, or Riesz obligations |
| `main_body.tex:202-215` LSI/KL/FI vocabulary and `phi=sqrt(rho/pi)`. | local measure/density-test backend | `SALD.saldLsiKlFiDensityTestContract`; `sald.lsi_kl_fi.density_test_interface` | refine Radon-Nikodym density, admissible square-root test, entropy rewrite, FI chain rule, or coefficient audit |

Mode discipline:

- `faithfulPaper`; use only the original source files and keep
  `sald_version_2.tex` excluded.
- Preserve the source Gronwall inequality, DV formula, PI convention, and
  LSI-to-KL/FI coefficient `1/(2*C_LSI)`.
- Keep the work at source-index/contract synchronization unless a narrower
  Lean proof builds locally.

Lower packet:

- target exactly one first-layer interface;
- preferred lower target is
  `SALD.saldGronwallEndpointCalculusContract` /
  `SALD.saldGronwallExponentRewriteContract` /
  `sald.gronwall.exponent_rewrite`;
- alternatives are `SALD.saldDvFiniteLogMgfContract`,
  `SALD.saldPiVelocityNormDependencyContract`, and
  `SALD.saldLsiKlFiDensityTestContract`;
- if blocked, record the exact source-contract gap instead of changing theorem
  statements or promoting source-cited results.

Non-goals:

- do not prove or restate any forward-KL, guided, general VA-SALD, or discrete
  theorem;
- do not replace DV, LSI, PI, or Gronwall with an alternate inequality or
  proof route;
- do not add hidden density, endpoint, smoothness, finite-mgf, Sobolev, or
  boundary assumptions to theorem statements.

Reviewer checklist:

- `SALD.saldFirstProofDag` includes the four focus labels with statuses:
  Gronwall `obligation`, DV `sourceCited`, PI `contractOnly`, and LSI/KL/FI
  `obligation`.
- `SALD.firstAppendixSourceIndexAuditObligation` and
  `SALD.firstAppendixMiddleAuditObligation` depend on
  `SALD.cycle21FirstAppendixVocabularyPacket`.
- `research-wiki/source-index/SALD_original.jsonl` indexes the four focus
  labels from the original source and excludes `sald_version_2.tex`.
- `python3 tools/astis.py check` passes with no fake proof closure.

### Cycle 21 Middle Source-To-Lean Map

Middle reread `appendix.tex:47-151` and `main_body.tex:202-215` and added
`SALD.cycle21FirstAppendixMiddleAuditContract`.

| Source window | Lean-facing target | Status after middle |
|---|---|---|
| `appendix.tex:47-71` `lem:gronwall` | `SALD.saldGronwallCandidateContract`, `SALD.saldGronwallEndpointCalculusContract`, `SALD.saldGronwallExponentRewriteContract`, `sald.gronwall.exponent_rewrite` | local real/interval-integral obligation; scalar helpers remain partial substeps |
| `appendix.tex:73-79` `lem:dv_variation` | `SALD.dvContract`, `SALD.saldDvFiniteLogMgfContract`, `probability.dv_variational_formula` | source-cited, not ported |
| `appendix.tex:86-151` `def:PI` and velocity-norm route | `SALD.saldPIContract`, `SALD.saldPiVelocityNormDependencyContract`, `sald.pi.velocity_norm_backend` | PI contract-only; Sobolev/Riesz backend remains obligation |
| `main_body.tex:202-215` LSI/KL/FI | `SALD.saldLsiKlFiBridgeContract`, `SALD.saldLsiKlFiDensityTestContract`, `sald.lsi_kl_fi.density_test_interface`, `probability.lsi_to_kl_fi` | density-test and LSI-to-KL/FI obligations |

Middle lower packet:

- target exactly `SALD.saldGronwallExponentRewriteContract` /
  `sald.gronwall.exponent_rewrite`;
- refine only endpoint-safe derivative/FTC assumptions, adjacent
  interval-integrability, or the remaining integral-congruence obligation for
  `appendix.tex:63-69`;
- keep DV source-cited, PI contract-only, LSI/KL/FI as obligations, and later
  SALD theorem statements unchanged.

## Cycle 22 Upper Packet

Objective: return to continuous `thm:forward-KL` and keep the lower target
inside the existing Gronwall side-condition obligation, narrowed to the
theorem-specific regularity and adjacent interval-integrability needed before
the compiled first-appendix exponent algebra can be used in the source display.
The compiled upper packet is `SALD.cycle22ForwardKlUpperPacket`.

Source-dependency audit:

| Blocked source step | Classification | Lean-facing target | Required lower output |
|---|---|---|---|
| `appendix.tex:244-248` applies `lem:gronwall` with `a(t)=dot{s}(t) C_LSI(t)-(1/2) dot{s}(t)^(-1) alpha^(-1)` and `b(t)=(1/2) dot{s}(t)^(-1) E_alpha(pi_t,v_t)`. | source-contract gap plus local Gronwall interface | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract`; `sald.forward_kl.gronwall_side_conditions` | expose continuity or interval-integrability for `a`, its LSI and alpha pieces, and `b`; keep full Gronwall as an obligation |
| `appendix.tex:249-250` splits the initial exponent into the LSI contraction factor and the positive alpha factor. | local real/interval-integral algebra after theorem-specific hypotheses | `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable`; `SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces`; `SALD.forwardKlGronwallSideConditionObligation` | connect adjacent interval-integrability of the LSI and alpha coefficient pieces to the compiled congruence sublemma without changing signs or endpoint limits |
| `appendix.tex:248-252` drops the nonpositive LSI contribution from the residual exponent. | internal-paper-step with scalar sign and interval-monotonicity prerequisites | `SALD.forwardKlDependencyChainAuditContract`; `SALD.forwardKlGronwallSideConditionObligation` | record `C_LSI(u)>=0`, `dot{s}(u)>0`, and interval-integral monotonicity as obligations if no compiled proof is added |
| `main_body.tex:243-246` matches `K(T)` and `K(0)` to the theorem endpoint display. | source-contract gap for endpoint schedule | `SALD.forwardKlEndpointScheduleContract`; `sald.forward_kl.endpoint_schedule_identities` | do not add endpoint identities to `thm:forward-KL`; keep them as named obligations unless proved separately |

Mode discipline:

- `faithfulPaper`; use the original `main_body.tex` and `appendix.tex`
  windows above, and keep `sald_version_2.tex` excluded.
- Preserve the theorem statement, Gronwall coefficients, the two displayed
  initial exponent factors, and the residual alpha-complexity integral.
- Treat the cycle-22 coefficient-piece bridge and cycle-21 outer-integral
  congruence as local algebra only; they do not close theorem-specific
  regularity of the pieces, endpoint, DV, LSI, KL derivative, residual-drop,
  or full Gronwall obligations.

Lower packet:

- target exactly `SALD.forwardKlGronwallSideConditionContract` /
  `SALD.forwardKlGronwallSideConditionObligation` /
  `sald.forward_kl.gronwall_side_conditions`;
- first sub-slice is theorem-specific coefficient regularity and adjacent
  interval-integrability for `dot{s}(t) C_LSI(t)`,
  `(1/2) dot{s}(t)^(-1) alpha^(-1)`, and `b(t)`; `a(t)` is now assembled
  from the first two pieces by
  `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable`;
- if blocked, refine the obligation ledger with the source classification
  above rather than changing the theorem display or promoting an analytic
  backend.

Non-goals:

- do not prove or restate `thm:forward-KL`;
- do not replace the derivative -> LSI -> DV -> Gronwall route;
- do not add hidden endpoint, density, boundary, finite-log-mgf,
  differentiability, continuity, or interval-integrability assumptions;
- do not mark DV, LSI-to-KL/FI, KL derivative, residual exponent drop,
  endpoint schedule, or full Gronwall formalized.

Reviewer checklist:

- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle22ForwardKlUpperPacket` and
  `SALD.cycle22ForwardKlMiddleContract` while retaining cycle-14 and cycle-18
  packets.
- `SALD.forwardKlProofDag` routes
  `ASTIS.SALD.forward_KL.gronwall_side_conditions` through the cycle-22 upper
  and middle packets.
- `research-wiki/source-index/SALD_original.jsonl` indexes `thm:forward-KL`,
  `eq:LSI-KL-FI`, `lem:dv_variation`, and `lem:gronwall`, excluding
  `sald_version_2.tex`.
- `python3 tools/astis.py check` passes with no fake proof closure.

## Cycle 22 Middle Packet

Compiled middle record: `SALD.cycle22ForwardKlMiddleContract`.

The middle source-to-Lean map keeps the lower target inside
`sald.forward_kl.gronwall_side_conditions` and narrows the first sub-slice to
the theorem-specific coefficient regularity and adjacent
interval-integrability that are implicit in `appendix.tex:244-250`.

| Source step | Lean-facing route | Remaining lower obligation |
|---|---|---|
| `appendix.tex:210-217`: LSI converts the FI term into `dot{s}(t) C_LSI(t)`. | `SALD.forwardKlDependencyChainAuditContract`, `probability.lsi_to_kl_fi` | expose the density-test backend and integrability of the LSI coefficient product |
| `appendix.tex:218-228`: inverse schedule produces `dot{s}(t)^(-1)`. | `sald.forward_kl.schedule_time_change`, `SALD.forwardKlEndpointScheduleContract` | prove or record positivity/nonzero derivative and endpoint identities separately |
| `appendix.tex:230-241`: DV supplies `(1/2) dot{s}(t)^(-1) alpha^(-1)` and `b(t)`. | `SALD.forwardKlDvFiniteLogMgfWitnessContract`, `SALD.forwardKlDvAlphaMonotonicityContract` | keep common-space, measurability, finite-log-mgf, and `E_alpha` integrability as obligations |
| `appendix.tex:244-250`: Gronwall output and initial exponent split. | `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable`, `SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces` | prove or record adjacent interval-integrability of the LSI and alpha pieces; the assembled `a(t)` and congruence use now compile under those hypotheses |
| `appendix.tex:248-252`: residual exponent drops the LSI contribution. | `SALD.forwardKlGronwallSideConditionObligation` | record `C_LSI(u)>=0`, `dot{s}(u)>0`, and interval-integral monotonicity |

Lower packet:

- target exactly `SALD.forwardKlGronwallSideConditionContract` /
  `SALD.forwardKlGronwallSideConditionObligation` /
  `sald.forward_kl.gronwall_side_conditions`;
- first prove or refine only coefficient regularity and adjacent
  interval-integrability for `dot{s}(t) C_LSI(t)`,
  `(1/2) dot{s}(t)^(-1) alpha^(-1)`, and `b(t)`;
- use `SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces` only
  after the LSI and alpha piece hypotheses are available;
- leave endpoint rewrites, residual exponent monotonicity, DV finite-log-mgf,
  LSI density-test, KL derivative, and full Gronwall as existing obligations.

### Cycle 22 Lower Refinement

Lean increment:

- `SALD.forwardKlGronwallCoeffIntervalIntegrable` packages Mathlib closure of
  `IntervalIntegrable` under subtraction for the source coefficient
  `a(t)=lsiPart(t)-alphaPart(t)`.
- `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable` lifts that closure
  to the adjacent intervals `[0,t]` and `[t,T]` needed by the Gronwall
  exponent rewrite.
- `SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces` applies the
  existing `SALD.gronwallExpProductRewriteIntegralCongr` to the assembled
  coefficient once the LSI and alpha pieces have adjacent
  interval-integrability.

Remaining obligations:

- prove or expose regularity/integrability of the actual source pieces
  `dot{s}(t) C_LSI(t)` and `(1/2) dot{s}(t)^(-1) alpha^(-1)`;
- prove or expose regularity/integrability of
  `b(t)=(1/2) dot{s}(t)^(-1) E_alpha(pi_t,v_t)` for the Gronwall call;
- keep endpoint `K(0)`/`K(T)` rewrites, residual-exponent monotonicity, DV,
  LSI-to-KL/FI, KL derivative, and the full Gronwall lemma as separate
  obligations.

## Cycle 24 Upper Packet

Objective: return to the guided/general VA-SALD path and select the continuous
general moving-target Gronwall endpoint/exponent bridge as the next lower
target.  The compiled upper packet is
`SALD.cycle24GeneralVaSaldUpperPacket`.

Source-dependency audit:

| Blocked source step | Classification | Lean-facing target | Required middle/lower output |
|---|---|---|---|
| `appendix.tex:909-934` applies `lem:gronwall` to `K(t)` using `a(t)=(sigma_t^2/2)*dot{s}(t)*C_LSI(t)-sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)` and `b(t)=sigma_t^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)`. | source-contract gap plus local Gronwall interface | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_side_conditions` | expose coefficient regularity/integrability for `a`, its LSI and alpha pieces, and `b`; keep full Gronwall as an obligation |
| `appendix.tex:911-920` identifies the Gronwall endpoint term with `KL(rho_S||pi_T)` and `KL(rho_0||pi_0)`. | source-contract gap for endpoint schedule | `SALD.generalMovingTargetGronwallSideConditionContract.endpointScheduleIdentities`; `sald.forward_kl.schedule_time_change` | record `s(0)=0`, `S=s(T)`, `t(s(T))=T`, and the slowed-target endpoint law without adding theorem hypotheses |
| `appendix.tex:913-932` splits the negative integral of `a(t)` into the theorem's two exponent factors and drops the nonpositive LSI part in the residual exponent. | local real/interval-integral algebra after sign hypotheses | `SALD.generalMovingTargetGronwallSideConditionContract.exponentSplitAlgebra`; `residualExponentBound`; reusable `SALD.gronwallExpProductRewriteIntegralCongr` | preserve signs, endpoints, and sigma-weighted coefficients; record `C_LSI>=0`, `sigma_t^2>=0`, `dot{s}>0`, and interval monotonicity as obligations unless proved |
| `appendix.tex:936-945` proves the pure-contraction clause by setting `c_t=v_t`, hence `m_t=0` and `E_alpha(pi_t,m_t)=0`. | local alpha-complexity specialization plus normalization | `SALD.generalMovingTargetPureContractionObligation`; `SALD.generalMovingTargetGronwallSideConditionContract.pureContractionResidualZero` | expose normalization of `pi_t`, `exp(0)=1`, and `log 1=0`; do not promote the pure-contraction theorem before the side-condition bridge is stable |

Mode discipline:

- `faithfulPaper`; use only the original `appendix.tex` and `main_body.tex`
  windows above, with `sald_version_2.tex` excluded.
- Preserve the theorem statement, sigma-weighted coefficients, endpoint
  display, unified specialization `c_t<-u_t`, and residual `m_t=w_t`.
- Treat DV, LSI-to-KL/FI, KL derivative, endpoint schedule, coefficient
  regularity, residual-exponent monotonicity, pure-contraction alpha-complexity,
  and full Gronwall as obligations unless a narrower Lean proof builds.

Lower packet:

- target exactly `SALD.generalMovingTargetGronwallSideConditionContract` /
  `SALD.generalMovingTargetGronwallSideConditionObligation` /
  `sald.general_moving_target.gronwall_side_conditions`;
- middle first should classify `appendix.tex:909-934` against theorem display
  `appendix.tex:727-743`, separating endpoint rewrites, coefficient
  regularity, exponent splitting, and residual-exponent drop;
- lower should then work one sub-slice only: endpoint identities,
  theorem-specific interval-integrability, residual-exponent monotonicity, or
  zero-residual alpha-complexity;
- if blocked, refine this ledger rather than changing theorem statements or
  marking analytic dependencies formalized.

Non-goals:

- do not prove or restate `thm:general-moving-target-SALD`,
  `thm:unified-forward-KL`, or
  `thm:general-moving-target-SALD-discrete`;
- do not replace the derivative -> LSI -> DV -> Gronwall route;
- do not add hidden endpoint, schedule, density, boundary, finite-log-mgf,
  differentiability, sign, or interval-integrability assumptions;
- do not alter the discrete cycle-20 coefficient packet or the unified
  transport bridge.

Reviewer checklist:

- `SALD.generalVaSaldProofDag` contains
  `ASTIS.SALD.general_moving_target.cycle24_upper_packet` before
  `ASTIS.SALD.general_moving_target.gronwall_side_conditions`.
- `SALD.saldDependenciesForLabel "thm:general-moving-target-SALD"` and
  `"thm:unified-forward-KL"` include
  `SALD.cycle24GeneralVaSaldUpperPacket`.
- `SALD.generalMovingTargetGronwallSideConditionObligation` remains an
  obligation and keeps endpoint rewrites, coefficient regularity, exponent
  splitting, residual-exponent sign facts, and zero-residual alpha-complexity
  explicit.
- `research-wiki/source-index/SALD_original.jsonl` indexes the original
  source labels and excludes `sald_version_2.tex`.
- `python3 tools/astis.py check` passes with no fake proof closure.

## Cycle 24 Middle Packet

Middle translated the upper-selected continuous general Gronwall bridge into
`SALD.cycle24GeneralVaSaldMiddleContract` and
`SALD.cycle24GeneralVaSaldGronwallMiddleObligation`.  This is a source-to-Lean
map only; no theorem statement, coefficient, source file, or analytic status
was changed.

| Source step | Lean-facing target | Remaining obligation |
|---|---|---|
| `appendix.tex:908-910` forms `a(t)` and `b(t)` after residual DV. | `SALD.generalMovingTargetGronwallInstantiationContract`; `sald.general_moving_target.gronwall_application` | derivative, LSI, DV, and full Gronwall remain separate obligations. |
| `appendix.tex:911-920` applies Gronwall and rewrites `K(T)`/`K(0)`. | `SALD.generalMovingTargetGronwallSideConditionContract.endpointScheduleIdentities`; `sald.forward_kl.schedule_time_change` | endpoint identities `s(0)=0`, `S=s(T)`, `t(s(T))=T`, and slowed-target endpoint laws remain obligations. |
| `appendix.tex:913-920` splits the initial exponent into LSI and alpha factors. | `SALD.generalMovingTargetGronwallSideConditionContract.exponentSplitAlgebra`; reusable Gronwall exponent helpers | theorem-specific coefficient regularity and adjacent interval-integrability must be supplied before using compiled scalar/congruence helpers. |
| `appendix.tex:921-932` drops the LSI part from the residual exponent. | `SALD.generalMovingTargetGronwallSideConditionContract.residualExponentBound` | nonnegativity of `C_LSI`, positivity of `dot{s}`, sigma-square sign, and interval-integral monotonicity remain obligations. |
| `appendix.tex:936-945` specializes `c_t=v_t`. | `SALD.generalMovingTargetPureContractionObligation`; `pureContractionResidualZero` | normalization of `pi_t`, `exp(0)=1`, `log 1=0`, and residual-integral vanishing remain local algebra/measure obligations. |

Lower packet:

- target exactly `SALD.generalMovingTargetGronwallSideConditionContract` /
  `SALD.generalMovingTargetGronwallSideConditionObligation` /
  `sald.general_moving_target.gronwall_side_conditions`;
- preferred first sub-slice is theorem-specific coefficient regularity and
  adjacent interval-integrability for
  `(sigma_t^2/2)*dot{s}(t)*C_LSI(t)`,
  `sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)`, and
  `b(t)=sigma_t^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)`;
- keep endpoint rewrites, residual-exponent monotonicity, zero-residual
  alpha-complexity, full Gronwall, DV, LSI-to-KL/FI, and the KL derivative as
  separate obligations unless a compiled Lean proof replaces them.

## Cycle 24 Lower Coefficient Slice

Lower compiled two local Real/interval-integral wrappers for the preferred
coefficient sub-slice:

| Lean declaration | What is formalized | What remains an obligation |
|---|---|---|
| `SALD.generalMovingTargetGronwallCoeffAdjacentIntervalIntegrable` | From adjacent interval-integrability hypotheses for the LSI part and alpha part, assemble adjacent interval-integrability of `a(t)=lsiPart(t)-alphaPart(t)`; carry the supplied residual `b(t)` adjacent interval-integrability hypotheses. | Actual regularity/integrability of `(sigma_t^2/2)*dot{s}(t)*C_LSI(t)`, `sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)`, and `sigma_t^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)` from the source assumptions. |
| `SALD.generalMovingTargetGronwallExpProductRewriteIntegralCongrOfPieces` | Reuse the compiled Gronwall exponent congruence for the assembled sigma-weighted coefficient once the above hypotheses are supplied. | Endpoint identification, theorem-display exponent split, residual-exponent monotonicity, pure-contraction residual zero, full Gronwall, DV, LSI-to-KL/FI, and KL derivative. |

This is still part of
`SALD.generalMovingTargetGronwallSideConditionObligation` and
`sald.general_moving_target.gronwall_side_conditions`; it does not add hidden
regularity assumptions to `thm:general-moving-target-SALD` or
`thm:unified-forward-KL`.

## Cycle 25 First Appendix Upper Packet

Objective: rebaseline the source-index and first appendix/vocabulary layer
after the cycle-24 general VA-SALD coefficient work, while selecting the PI
velocity-norm dependency as the next lower proof-obligation refinement.  The
compiled upper packet is `SALD.cycle25FirstAppendixVocabularyPacket`.

Mode discipline:

- `faithfulPaper`; use only `appendix.tex:47-151` and
  `main_body.tex:202-215`, with `sald_version_2.tex` excluded;
- preserve the exact source constants and signs: Gronwall's
  `dK/dt <= -a_t K_t + b_t`, the DV finite-log-mgf variational formula, PI's
  `C_PI^{-1}` convention, and `KL <= FI/(2*C_LSI)`;
- keep Gronwall and LSI-to-KL/FI as obligations, DV as source-cited plus
  local instantiation obligations, and PI as contract-only with a separate
  velocity-norm backend.

Lower packet:

- target exactly `SALD.saldPiVelocityNormDependencyContract` /
  `SALD.piVelocityNormBackendObligation` /
  `sald.pi.velocity_norm_backend`;
- first sub-slice is `appendix.tex:96-129`: `dot H^1(mu)`, the mean-zero
  interface, PI norm equivalence, and boundedness of `T_mu` before the Riesz
  representation step;
- record any missing weighted-Sobolev Hilbert structure, quotient/mean-zero
  API, weak-PDE interpretation, or boundary regularity as a source-contract
  gap;
- do not edit later SALD theorem statements or promote Gronwall, DV, PI
  velocity bounds, or LSI-to-KL/FI beyond their current statuses.

Non-goals:

- do not prove or restate `thm:forward-KL`, `thm:forward-KL-discrete`,
  `prop:guided_path_residual`, `thm:general-moving-target-SALD`,
  `thm:unified-forward-KL`, or
  `thm:general-moving-target-SALD-discrete`;
- do not replace the source proof route with Pinsker, Talagrand, PI-to-LSI,
  Girsanov, or a direct VA-SALD argument;
- do not import or claim an SLT theorem for PI, Gronwall, or LSI/KL/FI unless
  it builds locally under the ASTIS toolchain.

Reviewer checklist:

- `python3 tools/astis.py source-index ASTIS-SALD-001` refreshes the four
  focus labels and still excludes `sald_version_2.tex`;
- `SALD.saldFirstProofDag` dependencies for the four focus labels include
  `SALD.cycle25FirstAppendixVocabularyPacket`;
- the first-layer statuses remain Gronwall `obligation`, DV `sourceCited`, PI
  `contractOnly`, and LSI/KL/FI `obligation`;
- the mandatory gate `python3 tools/astis.py check` passes with no fake proof
  closure.

## Cycle 25 Middle PI Velocity-Norm Source-To-Lean Map

Middle translated the upper-selected first appendix target into
`SALD.cycle25FirstAppendixMiddleAuditContract` and
`SALD.cycle25FirstAppendixPiVelocityNormMiddleObligation`.  This is
source-to-Lean synchronization only; PI remains contract-only and the
velocity-norm backend remains an obligation.

| Source step | Lean-facing target | Remaining obligation |
|---|---|---|
| `appendix.tex:96-103` defines `dot H^1(mu)` and the gradient inner product. | `SALD.saldPiVelocityNormDependencyContract.weightedSobolevSpace`; weighted Sobolev vocabulary | Hilbert-space/completion and mean-zero quotient or subtype backend |
| `appendix.tex:104-112` applies PI to get norm equivalence on the mean-zero space. | `normEquivalence`; `SALD.saldPIContract`; variance vocabulary | bridge `E_mu[psi]=0` to `Var_mu[psi]=||psi||_L2^2` and track the `C_PI^{-1}` convention |
| `appendix.tex:114-123` states the weak PDE and weak form. | `weakPdeStatement`; `sald.pi.velocity_norm_backend` | normalize the source line 119 `phi`/`psi` notation mismatch and choose weak-divergence/boundary interfaces |
| `appendix.tex:123-129` defines `T_mu(psi)` and proves the first Cauchy-Schwarz bound. | `boundedFunctionalStep`; `SALD.cycle25FirstAppendixPiVelocityNormMiddleObligation` | integrability/measurability of `psi*g` and the `L2(mu)` pairing backend |
| `appendix.tex:130-138` immediately finishes the PI operator-norm and Riesz representation step. | `rieszRepresentationStep`; `velocityBound` | follow-on lower slice: bounded linear functional, Riesz theorem on `dot H^1(mu)`, weak PDE solution, and velocity norm equality |

Lower packet:

- target exactly `SALD.saldPiVelocityNormDependencyContract` /
  `SALD.piVelocityNormBackendObligation` /
  `sald.pi.velocity_norm_backend`;
- first work on `appendix.tex:96-129`, and keep `appendix.tex:130-138` as
  the explicit follow-on source-contract gap if the Riesz backend is not
  ready;
- do not promote PI velocity bounds, Gronwall, DV, LSI-to-KL/FI, or any later
  SALD theorem proof status.

## Cycle 25 Lower PI Velocity-Norm Scalar Core

Lower compiled two theorem-independent real-order helpers for the selected
`appendix.tex:96-129` sub-slice:

| Source step | Compiled Lean item | Still open |
|---|---|---|
| `appendix.tex:104-112` norm-equivalence algebra after PI gives an `L2`-squared bound. | `SALD.piVelocityNormMeanZeroH1UpperScalar` | weighted Sobolev realization of `dot H^1(mu)`, mean-zero variance identity, PI instantiation, and norm-square nonnegativity |
| `appendix.tex:123-129` Cauchy--Schwarz plus PI bound for `T_mu(psi)`. | `SALD.piVelocityNormBoundedFunctionalScalar` | measurability/integrability of `psi*g`, absolute-value/operator-norm formulation for `T_mu`, nonnegative L2 norms, and the PI square-root norm bound |
| lower-cycle dependency ledger | `SALD.cycle25PiVelocityNormLowerObligation` / `sald.first_appendix.cycle25_pi_velocity_norm_lower` | Riesz representation, weak PDE interpretation, boundary regularity, and the final velocity-norm bound in `SALD.piVelocityNormBackendObligation` |

This is partial progress only.  The PI definition remains contract-only and
`lem:velocity-norm-bound` remains an obligation; no later SALD theorem target
or source assumption was changed.

## Cycle 29 First Appendix Upper Packet

Objective: rebaseline the source-index and first appendix/vocabulary layer
after the cycle-28 guided/general derivative-side algebra, while selecting the
LSI/KL/FI density-test bridge as the next lower proof-obligation refinement.
The compiled upper packet is `SALD.cycle29FirstAppendixVocabularyPacket`.

Mode discipline:

- `faithfulPaper`; use only `appendix.tex:47-151` and
  `main_body.tex:202-215`, with `sald_version_2.tex` excluded;
- preserve the exact source constants and signs: Gronwall's
  `dK/dt <= -a_t K_t + b_t`, the DV finite-log-mgf variational formula, PI's
  `C_PI^{-1}` convention, and `KL <= FI/(2*C_LSI)`;
- keep Gronwall and LSI-to-KL/FI as obligations, DV as source-cited plus
  local instantiation obligations, and PI as contract-only with its
  velocity-norm backend separate.

Lower packet:

- target exactly `SALD.saldLsiKlFiDensityTestContract` /
  `SALD.lsiKlFiDensityTestObligation` /
  `sald.lsi_kl_fi.density_test_interface`;
- first sub-slice is `main_body.tex:208-215`: `rho << pi`, density ratio
  `r=rho/pi`, `phi=sqrt(r)`, normalization, entropy rewrite to KL, FI chain
  rule with the one-quarter factor, and the final coefficient
  `1/(2*C_LSI)`;
- record any missing Radon-Nikodym density API, smooth/admissible square-root
  test function, approximation/closure argument, finite KL/FI interface, or
  FI chain-rule backend as a source-contract gap;
- do not edit later SALD theorem statements or promote Gronwall, DV, PI
  velocity bounds, or LSI-to-KL/FI beyond their current statuses.

Non-goals:

- do not prove or restate `thm:forward-KL`, `thm:forward-KL-discrete`,
  `prop:guided_path_residual`, `thm:general-moving-target-SALD`,
  `thm:unified-forward-KL`, or
  `thm:general-moving-target-SALD-discrete`;
- do not replace the source proof route with Pinsker, Talagrand, PI-to-LSI,
  Girsanov, entropy transport, or a direct VA-SALD argument;
- do not import or claim an SLT theorem for the LSI/KL/FI bridge unless it
  builds locally under the ASTIS toolchain.

Reviewer checklist:

- `python3 tools/astis.py source-index ASTIS-SALD-001` refreshes the four
  focus labels and still excludes `sald_version_2.tex`;
- `SALD.saldFirstProofDag` dependencies for the four focus labels include
  `SALD.cycle29FirstAppendixVocabularyPacket`;
- the first-layer statuses remain Gronwall `obligation`, DV `sourceCited`, PI
  `contractOnly`, and LSI/KL/FI `obligation`;
- the mandatory gate `python3 tools/astis.py check` passes with no fake proof
  closure.

## Cycle 29 First Appendix Middle Packet

Objective: translate the upper-selected LSI/KL/FI density-test bridge into a
lower-ready source-to-Lean map while preserving the first-layer statuses.  The
compiled declarations are `SALD.cycle29FirstAppendixMiddleAuditContract` and
`SALD.cycle29LsiKlFiDensityTestMiddleObligation`.

Middle source ledger:

| Source window | Lean-facing target | Remaining obligation |
|---|---|---|
| `appendix.tex:47-71` Gronwall | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `sald.gronwall.integrating_factor` | endpoint-safe calculus, interval FTC, exponent rewrite in theorem contexts |
| `appendix.tex:73-79` DV | `SALD.saldDvFiniteLogMgfContract`; `probability.dv_variational_formula`; `sald.dv_variation.finite_log_mgf_interface` | common probability space, measurable finite-log-mgf tests, alpha-complexity witnesses |
| `appendix.tex:86-151` PI route | `SALD.saldPIContract`; `SALD.saldPiVelocityNormDependencyContract`; `sald.pi.velocity_norm_backend` | weighted Sobolev/Riesz backend and weak PDE regularity |
| `main_body.tex:208-215` LSI density test | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `sald.lsi_kl_fi.cycle29_density_test_middle` | Radon-Nikodym density, admissible `sqrt(rho/pi)` test or approximation, entropy rewrite, FI chain rule, finite KL/FI interfaces, coefficient `1/(2*C_LSI)` |

Lower packet:

- target exactly `SALD.saldLsiKlFiDensityTestContract` /
  `SALD.lsiKlFiDensityTestObligation` /
  `sald.lsi_kl_fi.density_test_interface`;
- start with `main_body.tex:208-215` and refine one density-test gap at a
  time;
- do not promote `probability.lsi_to_kl_fi`, alter forward-KL theorem
  hypotheses, or introduce PI/Pinsker/Talagrand substitutes.

## Cycle 26 Upper Forward-KL DV Witness Packet

Objective: return to continuous `thm:forward-KL` and select the theorem-specific
DV finite-log-mgf/common-space witness as the next lower target.  The compiled
upper packet is `SALD.cycle26ForwardKlUpperPacket`.

Source-dependency audit:

| Blocked source step | Classification | Lean-facing target | Required middle/lower output |
|---|---|---|---|
| `appendix.tex:230-236` applies `lem:dv_variation` with `nu=rho_{s(t)}`, `mu=pi_t`, and `Z=alpha*||v_t||^2`. | external-cited result plus local instantiation obligation | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `sald.forward_kl.dv_finite_log_mgf_witness` | expose common state space, absolute continuity, measurability of `||v_t||^2`, and finite log-mgf before invoking the cited DV formula |
| `main_body.tex:240-241` assumes finite `E_alpha0(pi_t,v_t)` and `0<alpha<=alpha0`. | local measure/order lemma | `SALD.forwardKlDvAlphaMonotonicityContract`; `sald.forward_kl.dv_alpha_mgf_monotonicity` | derive finite log-mgf at `alpha` from the source alpha0-complexity assumption without adding a new theorem hypothesis |
| `appendix.tex:237-241` divides the DV output by `alpha` and feeds the coefficient into the Gronwall inequality. | local positive-alpha scalar algebra plus coefficient audit | `SALD.forwardKlDvPositiveAlphaScalingScalar`; `SALD.forwardKlDvPositiveAlphaCoefficientScalar`; `SALD.cycle26ForwardKlDvPositiveAlphaLowerObligation`; `SALD.forwardKlDvEnergyCandidateContract` | scalar real-order core formalized; still instantiate it with the source DV inequality, finite log-mgf witness, `E_alpha` rewrite, and nonnegative `(1/2)*dot{s}(t)^(-1)` prefactor |

Mode discipline:

- `faithfulPaper`; use only original `main_body.tex` and `appendix.tex`, with
  `sald_version_2.tex` excluded.
- Preserve the statement of `thm:forward-KL`, the assumption
  `E_alpha0(pi_t,v_t)<+infty`, the range `alpha in (0,alpha0]`, and the source
  DV test `Z=alpha*||v_t||^2`.
- Keep DV source-cited through Boucheron Corollary 4.15 / the reference SLT
  entropy-duality pattern; do not import or mark an SLT theorem formalized.
- Keep LSI density-test, KL derivative, endpoint schedule, Gronwall
  side-conditions, residual exponent drop, and full Gronwall as existing
  obligations.

Lower packet:

- target exactly `SALD.forwardKlDvFiniteLogMgfWitnessContract` /
  `SALD.forwardKlDvFiniteLogMgfWitnessObligation` /
  `sald.forward_kl.dv_finite_log_mgf_witness`;
- first sub-slice: common-space/absolute-continuity/measurability plus
  finite-log-mgf at `alpha` for `Z=alpha*||v_t||^2`;
- use `SALD.forwardKlDvAlphaMonotonicityContract` for the alpha0-to-alpha
  monotonicity bridge, but record any order, expectation, or log-finiteness
  blocker as a proof obligation rather than adding a theorem assumption;
- do not reopen or modify the cycle-22 Gronwall coefficient assembly except as
  a dependency of the final theorem display.

Reviewer checklist:

### Cycle 26 Lower DV Positive-Alpha Scalar Core

Lower compiled two theorem-independent Real-order helpers for the
`appendix.tex:237-241` post-DV division step:

| Source step | Compiled Lean item | Still open |
|---|---|---|
| Divide `alpha*energy <= K(t)+logMgf` by `alpha>0` and rewrite `alpha^(-1)*logMgf` as `E_alpha(pi_t,v_t)`. | `SALD.forwardKlDvPositiveAlphaScalingScalar` | theorem-specific DV inequality, finite log-mgf at `alpha`, common-space/absolute-continuity, and measurability of `Z=alpha*||v_t||^2` |
| Multiply the scaled bound by the nonnegative downstream prefactor while preserving the coefficient on `K(t)`. | `SALD.forwardKlDvPositiveAlphaCoefficientScalar` | proof that the prefactor is `(1/2)*dot{s}(t)^(-1)` and nonnegative from the source inverse-schedule positivity |
| lower-cycle dependency ledger | `SALD.cycle26ForwardKlDvPositiveAlphaLowerObligation` / `sald.forward_kl.cycle26_dv_positive_alpha_lower` | instantiation with the actual `rho_{s(t)}`, `pi_t`, `K(t)`, `E_alpha`, and Gronwall coefficient data |

This is partial progress only.  DV remains source-cited, alpha0-to-alpha
finite-log-mgf monotonicity and the measure interfaces remain obligations, and
`thm:forward-KL` is not promoted beyond contract-only status.

- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle26ForwardKlUpperPacket` while retaining cycle-14, cycle-18, and
  cycle-22 packets.
- `SALD.forwardKlProofDag` routes
  `ASTIS.SALD.forward_KL.dv_finite_log_mgf_witness` through
  `SALD.cycle26ForwardKlUpperPacket` before `ASTIS.SALD.forward_KL.dv_energy`.
- `SALD.forwardKlDvFiniteLogMgfWitnessObligation` remains an obligation; DV,
  LSI-to-KL/FI, KL derivative, endpoint rewrites, Gronwall side-conditions, and
  full Gronwall are not promoted.
- `python3 tools/astis.py source-index ASTIS-SALD-001` still indexes the
  original source labels and excludes `sald_version_2.tex`.
- `python3 tools/astis.py check` passes with no fake proof closure.

## Cycle 30 Upper Forward-KL Derivative-Side Packet

Objective: keep continuous `thm:forward-KL` fixed and choose the derivative
side-condition interface as the next lower target.  The compiled upper packet
is `SALD.cycle30ForwardKlUpperPacket`, with workflow obligation
`SALD.cycle30ForwardKlDerivativeSideUpperObligation` /
`sald.forward_kl.cycle30_derivative_side_upper`.  Middle synchronizes this as
`SALD.cycle30ForwardKlMiddleContract` with workflow obligation
`SALD.cycle30ForwardKlDerivativeSideMiddleObligation` /
`sald.forward_kl.cycle30_derivative_side_middle`.

Source-dependency audit:

| Blocked source step | Classification | Lean-facing target | Required middle/lower output |
|---|---|---|---|
| `appendix.tex:168-174` differentiates `KL(rho_s||tilde_pi_s)` and uses `int partial_s rho_s dx=0`. | local analytic/source-contract gap | `SALD.forwardKlDerivativeSideConditionContract`; `sald.forward_kl.density_boundary_regular` | mass conservation and differentiation-under-integral interface for the KL path |
| `appendix.tex:176-185` uses the SALD Fokker--Planck equation and integration by parts to obtain `-FI(rho_s||tilde_pi_s)`. | local Fokker--Planck/integration-by-parts obligation | `SALD.forwardKlDensityBoundaryObligation`; `SALD.forwardKlDerivativeObligation` | density, positivity, boundary/no-flux, and FI identification conditions |
| `appendix.tex:187-197` transports `tilde_pi_s=pi_{t(s)}` by `tilde_v_s=dot t(s)*v_{t(s)}`. | moving-target transport obligation | `SALD.forwardKlMovingTargetDependencyContract`; `SALD.forwardKlScheduleTimeChangeObligation` | common state-space and continuity-equation interface for the slowed target |
| `appendix.tex:199-208` integrates by parts on the target term and applies Cauchy--Schwarz/Young. | local calculus plus scalar coefficient bookkeeping | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlDensityBoundaryObligation` | preserve the exact `1/2*FI + 1/2*||tilde v_s||^2` Young split |
| `appendix.tex:210-228` applies LSI and changes from `s` to `t`. | LSI obligation plus inverse-schedule calculus | `SALD.saldLsiKlFiDensityTestContract`; `SALD.forwardKlScheduleTimeChangeObligation` | keep LSI-to-KL/FI and time-change as separate obligations after the first density/boundary slice |

Middle source-to-Lean map:

| Source step | Lean-facing target | Status |
|---|---|---|
| `appendix.tex:168-174` mass conservation and KL differentiation under the integral. | `SALD.cycle30ForwardKlMiddleContract`; `sald.forward_kl.cycle30_derivative_side_middle`; `sald.forward_kl.density_boundary_regular` | workflow/local-analysis obligation |
| `appendix.tex:176-185` SALD Fokker--Planck substitution and integration by parts to `-FI`. | `SALD.forwardKlDensityBoundaryObligation`; `SALD.forwardKlDerivativeSideConditionContract`; `FokkerPlanckContract`; `FIContract` | local-analysis obligation |
| `appendix.tex:187-208` target-side transport, integration by parts, Cauchy--Schwarz, and Young `1/2` split. | `SALD.forwardKlDerivativeSideConditionContract`; `TransportVelocityContract`; `sald.forward_kl.density_boundary_regular` | follow-on density/boundary obligation |
| `appendix.tex:210-228` LSI and inverse-schedule handoff. | `SALD.lsiKlFiDensityTestObligation`; `sald.forward_kl.schedule_time_change` | downstream obligations, not part of the first lower slice |

Mode discipline:

- `faithfulPaper`; use only original `main_body.tex:238-247` and
  `appendix.tex:168-228`, with `sald_version_2.tex` excluded.
- Preserve the theorem display and derivative route
  KL derivative -> SALD Fokker--Planck -> slowed-target transport -> Young ->
  LSI -> inverse-schedule time change -> DV -> Gronwall.
- Keep all density, boundary, inverse-function, endpoint, positivity, and
  integrability facts as obligations, not hidden theorem assumptions.

Lower packet:

- target exactly `SALD.forwardKlDerivativeSideConditionContract` /
  `SALD.forwardKlDensityBoundaryObligation` /
  `sald.forward_kl.density_boundary_regular`;
- use `SALD.cycle30ForwardKlMiddleContract` and
  `sald.forward_kl.cycle30_derivative_side_middle` as the line ledger;
- first sub-slice: `appendix.tex:168-185`, mass conservation,
  differentiation under the integral, SALD Fokker--Planck, integration by
  parts, and the `-FI` identification;
- second sub-slice if blocked/afterward: `appendix.tex:187-208`, slowed-target
  transport, target-side integration by parts, and Young's inequality with
  exact `1/2` coefficients;
- leave `sald.forward_kl.schedule_time_change`, `probability.lsi_to_kl_fi`,
  `sald.forward_kl.dv_finite_log_mgf_witness`, and
  `sald.forward_kl.gronwall_side_conditions` unchanged unless a separate
  compiled proof or obligation refinement is added.

Reviewer checklist:

- `SALD.forwardKlProofDag` contains
  `ASTIS.SALD.forward_KL.cycle30_derivative_side_upper` before
  `ASTIS.SALD.forward_KL.cycle30_derivative_side_middle`, and the middle block
  appears before `ASTIS.SALD.forward_KL.derivative`, DV, and Gronwall blocks.
- `SALD.continuousSaldContract` lists
  `SALD.cycle30ForwardKlDerivativeSideUpperObligation` and
  `SALD.cycle30ForwardKlDerivativeSideMiddleObligation` while keeping
  `thm:forward-KL` contract-only.
- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle30ForwardKlUpperPacket`, `SALD.cycle30ForwardKlMiddleContract`,
  `sald.forward_kl.cycle30_derivative_side_upper`, and
  `sald.forward_kl.cycle30_derivative_side_middle`.
- No analytic backend is promoted and no theorem assumptions are added.

## Cycle 27 Middle Discrete Accumulated-Collection Packet

Middle translated the cycle-27 upper target into
`SALD.cycle27DiscreteForwardKlMiddleContract` and the named workflow
obligation `sald.discrete_forward_kl.cycle27_accumulated_collection_middle`.
This is source-to-Lean synchronization only; it does not prove
`thm:forward-KL-discrete`.

Source-to-Lean map:

| Source step | Lean-facing target | Remaining obligation |
|---|---|---|
| `appendix.tex:560-571` endpoint term after Gronwall | `SALD.discreteForwardKlAccumulatedErrorBridgeContract.endpointBridge`; `sald.discrete_forward_kl.em_endpoint_laws`; `sald.discrete_forward_kl.stitched_interval_regularity` | endpoint law matching, stitched KL regularity, and linear-slowdown endpoint identities |
| `appendix.tex:586` residual `E_alpha` integrand | `SALD.discreteForwardKlAccumulatedErrorBridgeContract.alphaComplexityCollection`; `def:alpha-complexity` | identify the full integral as `(1/r)*A_alpha(pi,v)` after `dot{s}=r` |
| `appendix.tex:588` residual `Delta` integrand | `SALD.discreteForwardKlAccumulatedErrorBridgeContract.deltaAccumulation` | identify the full integral as `2*r*eta*barDelta_{alpha'}` without changing `Delta` or `barDelta` |
| `main_body.tex:310-323` common positive exponent | `SALD.discreteForwardKlResidualExponentBoundObligation`; scalar cores `SALD.discreteForwardKlResidualExponentBoundScalar` and `SALD.discreteForwardKlResidualExpBoundScalar` | nonnegative LSI, positive coefficients, interval-integral monotonicity, and full-interval `barGamma` identification |

Lower packet:

- target exactly `SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
  `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
  `sald.discrete_forward_kl.accumulated_error_bridge`;
- first sub-slice is `endpointBridge`, `alphaComplexityCollection`, and
  `deltaAccumulation`;
- keep `sald.discrete_forward_kl.residual_exponent_bound` and `barGamma`
  identification as dependencies unless lower explicitly proves them;
- do not reopen frozen-defect, LSI, DV, time-change coefficient, or full
  Gronwall subproofs.

Status: workflow/source-to-Lean obligation.  The theorem statement and source
constants `Gamma`, `Delta`, `barGamma`, `barDelta`, `alpha`, `alpha'`, `eta`,
and `r` are unchanged.

## Cycle 27 Lower Discrete Accumulated-Collection Scalar Core

Lower compiled three theorem-independent interval-integral helpers for the
additive residual collection in `appendix.tex:586-588` and
`main_body.tex:316-323`:

| Source step | Compiled Lean item | Still open |
|---|---|---|
| Factor the linear-slowdown coefficient `dot{s}(t)^(-1)=r^(-1)` through the residual `E_alpha(pi_t,v_t)` integral. | `SALD.discreteForwardKlAlphaComplexityCollectionScalar` | theorem-specific endpoint/stitching facts, `dot{s}(t)^(-1)=r^(-1)`, and identifying the integral as `A_alpha(pi,v)` |
| Factor the linear-slowdown coefficient `2*r*eta` through the residual `Delta(t)` integral. | `SALD.discreteForwardKlDeltaAccumulationScalar` | identifying `barDelta_{alpha'}` with the source full-interval `Delta` integral and supplying coefficient/integrability facts |
| Combine the two additive residual terms into `r^(-1)*A_alpha(pi,v)+2*r*eta*barDelta_{alpha'}` once the source definitions are supplied. | `SALD.discreteForwardKlAccumulatedErrorCollectionScalar`; ledger `SALD.cycle27DiscreteForwardKlAccumulatedCollectionLowerObligation` / `sald.discrete_forward_kl.cycle27_accumulated_collection_lower` | residual-exponent bound, `barGamma` identification, endpoint law matching, stitched KL regularity, Gronwall, DV, LSI-to-KL/FI, EM Fokker--Planck, and frozen-defect backends |

This is partial progress only.  It does not prove
`thm:forward-KL-discrete`, does not change `Gamma`, `Delta`, `barGamma`,
`barDelta`, `alpha`, `alpha'`, `eta`, or `r`, and does not promote the
accumulated-error bridge beyond obligation status.

## Cycle 28 Guided/General Upper Packet

Objective: return to the guided/general VA-SALD path after the cycle-27
discrete forward-KL work and select one lower-ready proof-obligation refinement:
`SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` /
`SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` /
`sald.general_moving_target_discrete.derivative_side_conditions`.

Source-dependency audit:

| Blocked source step | Classification | Lean-facing target | Required lower output |
|---|---|---|---|
| `appendix.tex:1354-1447` differentiates `KL(hat rho_s||tilde pi_s)` and inserts the conditional-drift Fokker--Planck equation. | source-contract gap plus local Fokker--Planck/backend lemma | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.em_interpolation_fp` | expose endpoint laws, conditional drift/disintegration, density regularity, mass conservation, and integration-by-parts interfaces without adding theorem assumptions |
| `appendix.tex:1469-1478` rewrites the cross field as `delta_pi^VA + dot t(s)*m_{t(s)}`. | internal-paper algebra plus local vector-field rewrite | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract.frozenResidualAlgebra`; `SALD.generalMovingTargetDiscreteFrozenResidualAlgebraVector`; `sald.general_moving_target_discrete.cycle28_derivative_side_lower`; `sald.general_moving_target_discrete.derivative_side_conditions` | module algebra formalized once `delta`, `tilde v_s`, and `m_t` are identified; concrete analytic field identifications remain obligations |
| `appendix.tex:1493-1511` applies Young twice, with `sigma_eta^2/8` for the residual and frozen terms. | local real/inner-product inequality plus dependency on frozen-delta lemma | `youngCoefficientBookkeeping`; `SALD.generalMovingTargetDiscreteFrozenDeltaObligation` | preserve the coefficients `2*sigma_eta^(-2)*dot t(s)^2`, `2*Gamma*eta^2*alpha'^(-1)`, and `2*Delta*eta` exactly |
| `appendix.tex:1526-1542` uses LSI after the two Young splits. | inherited density-test obligation | `SALD.lsiKlFiDensityTestObligation`; `eq:LSI-KL-FI` | keep LSI-to-KL/FI separate from the derivative-side lower slice |
| `appendix.tex:1544-1598` applies residual DV and changes from `s` to `t`. | source-cited DV plus local schedule/stitching obligations | `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `sald.forward_kl.schedule_time_change` | leave DV finite-log-mgf, positive-alpha scaling, and s-to-t stitching as named dependencies unless targeted separately |

Mode discipline:

- `faithfulPaper`; use the original `appendix.tex` and `main_body.tex`, with
  `sald_version_2.tex` excluded.
- Preserve the theorem display `appendix.tex:1316-1347` and the derivative
  route `appendix.tex:1354-1598`.
- Do not add endpoint, density, Fokker--Planck, conditional-law, LSI, DV,
  schedule, or Gronwall assumptions to the theorem statement.

Lower packet:

- target exactly `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`
  / `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` /
  `sald.general_moving_target_discrete.derivative_side_conditions`;
- first sub-slice: `appendix.tex:1469-1511`, frozen/residual algebra plus the
  two Young coefficient splits;
- if blocked, refine the missing local backend as a source-contract gap rather
  than weakening or restating `thm:general-moving-target-SALD-discrete`.

Non-goals:

- do not prove or restate `thm:general-moving-target-SALD-discrete`;
- do not reopen the final Gronwall/display bridge except as a downstream
  dependency;
- do not replace the EM interval derivative route with path-space, Girsanov,
  Pinsker, Talagrand, or a direct guided VA-SALD proof;
- do not alter the doubled residual coefficient, `Gamma`, `Delta`, `alpha`,
  `alpha'`, `eta`, `sigma_eta`, `dot t`, or `dot s`.

Reviewer checklist:

- `SALD.cycle28GeneralVaSaldUpperPacket` is present and workflow-only.
- `SALD.generalVaSaldDiscreteProofDag` contains
  `ASTIS.SALD.general_moving_target_discrete.cycle28_upper_derivative_side_conditions`
  before `ASTIS.SALD.general_moving_target_discrete.derivative_side_conditions`.
- `SALD.saldDependenciesForLabel "thm:general-moving-target-SALD-discrete"`
  includes `SALD.cycle28GeneralVaSaldUpperPacket`.
- `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` remains an
  obligation; no EM, LSI, DV, Gronwall, or derivative backend is promoted.

## Cycle 28 Guided/General Middle Packet

Objective: translate the upper packet's preferred source slice
`appendix.tex:1469-1511` into lower-ready declarations for
`sald.general_moving_target_discrete.derivative_side_conditions`.

Accepted compiled scalar core:

| Source bookkeeping step | Compiled Lean item | Still open |
|---|---|---|
| One `sigma_eta^2/8` Young share is one quarter of the original `(sigma_eta^2/2)*FI` dissipation. | `SALD.generalMovingTargetDiscreteYoungFisherShareScalar` | analytic FI identification and the inner-product Young inequality |
| The two Young shares leave the pre-LSI dissipation `-(sigma_eta^2/4)*FI`. | `SALD.generalMovingTargetDiscreteTwoYoungFisherBudgetScalar` | supplying the two source cross-term bounds |
| Young with `epsilon=sigma_eta^2/4` turns the residual coefficient into `2*sigma_eta^(-2)*dot t(s)^2*||m||^2`. | `SALD.generalMovingTargetDiscreteResidualYoungCoefficientScalar` | positivity/nonzero side conditions, the residual L2 identification, and the cross-term inequality |

Middle-role obligation:

`SALD.cycle28GeneralVaSaldDerivativeSideMiddleObligation` /
`sald.general_moving_target_discrete.cycle28_derivative_side_middle` records
the source-to-Lean map for:

- `appendix.tex:1469-1478`: frozen/residual vector-field algebra from
  `eq:general_discrete_delta_def` and `m_t=v_t-c_t`;
- `appendix.tex:1481-1488`: substitution into the derivative display;
- `appendix.tex:1493-1511`: the two Young/frozen-delta coefficient splits;
- `appendix.tex:1513-1524`: the combined pre-LSI inequality.

Lower packet:

- target exactly `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`
  / `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` /
  `sald.general_moving_target_discrete.derivative_side_conditions`;
- use the compiled module algebra for the frozen/residual rewrite, but keep the
  concrete conditional-drift, score, slowed-transport, and pointwise
  vector-field identifications as side-condition obligations before attempting
  the analytic Young and FI side conditions;
- do not promote `lem:frozen_delta_cross_lip`, LSI-to-KL/FI, residual DV,
  time-change stitching, Gronwall, or the full derivative theorem.

## Cycle 28 Guided/General Lower Algebra

Objective: refine the first derivative-side sub-slice selected by the middle
packet, without changing the discrete general VA-SALD theorem target.

Accepted compiled core:

| Source bookkeeping step | Compiled Lean item | Still open |
|---|---|---|
| `appendix.tex:1469-1478` rewrites the cross field from `eq:general_discrete_delta_def`, `tilde v_s=dot t(s)*v_{t(s)}`, and `m_t=v_t-c_t`. | `SALD.generalMovingTargetDiscreteFrozenResidualAlgebraVector` proves `score - frozen + tildeV = delta + dotT • m` from the three supplied identifications. | identifying the paper's concrete score, frozen conditional drift, slowed transport, and residual fields with the theorem hypotheses |
| Lower-cycle synchronization for the derivative side condition ledger. | `SALD.cycle28GeneralVaSaldDerivativeSideLowerObligation` / `sald.general_moving_target_discrete.cycle28_derivative_side_lower` | inner-product Young, frozen-delta lemma, LSI, DV, stitched time change, Gronwall, and the full derivative theorem |

This does not promote `sald.general_moving_target_discrete.derivative_side_conditions`
to formalized status; it only removes the theorem-independent module algebra
from that obligation.

## Cycle 30 Forward-KL Lower Density/Boundary Scalar Slice

Objective: refine the first lower sub-slice selected by the cycle 30 middle
packet, without changing `thm:forward-KL` or promoting the KL derivative
backend.

Accepted compiled core:

| Source bookkeeping step | Compiled Lean item | Still open |
|---|---|---|
| `appendix.tex:168-174` gives the scalar KL derivative display after mass conservation: derivative equals the first SALD term plus the target term. | input hypothesis to `SALD.forwardKlFirstTermFisherSubstitutionScalar` | mass conservation and differentiation under the integral |
| `appendix.tex:176-185` identifies the first SALD term as `-FI(rho_s||tilde pi_s)` using the SALD Fokker--Planck equation and integration by parts. | input hypothesis to `SALD.forwardKlFirstTermFisherSubstitutionScalar` | Fokker--Planck backend, boundary/no-flux or decay, positivity, finite FI, and the FI identity |
| Once the two analytic inputs are supplied, substitute the `-FI` first term into the derivative display. | `SALD.forwardKlFirstTermFisherSubstitutionScalar`; `SALD.cycle30ForwardKlDensityBoundaryLowerObligation` / `sald.forward_kl.cycle30_density_boundary_lower` | target-side transport, Young, LSI, inverse-schedule time change, DV, Gronwall, and the full derivative inequality |

This is scalar equality substitution only.  It does not close
`SALD.forwardKlDensityBoundaryObligation`, `sald.forward_kl.kl_derivative`, or
any analytic part of `thm:forward-KL`.

## Cycle 34 Upper Forward-KL Derivative Scalar Packet

Priority check before assigning lower work: (1) `lem:gronwall` remains a
local real-analysis obligation, (2) `lem:dv_variation` remains source-cited
with scalar consequences, (3) `eq:LSI-KL-FI` remains an obligation after cycle
33 scalar density-test lemmas, so this cycle follows item (4), the continuous
forward-KL Fokker--Planck/KL derivative identity.  The EM interpolation
Fokker--Planck backend remains item (5), not this lower packet.

Objective: keep `thm:forward-KL` fixed and close only theorem-independent
scalar derivative handoffs inside `appendix.tex:168-217`, after the analytic
Fokker--Planck, target-transport, Young, and LSI inputs are supplied.

Compiled core:

| Source bookkeeping step | Compiled Lean item | Still open |
|---|---|---|
| `appendix.tex:199-208` turns the Cauchy bound on the target-side transport term into the source Young split. | `SALD.forwardKlTargetTransportYoungBoundScalar` proves `targetTerm <= (1/2)*FI+(1/2)*velocitySq` from `targetTerm <= sqrt(FI)*sqrt(velocitySq)` plus nonnegativity; `SALD.forwardKlPostYoungDerivativeBoundOfCauchyScalar` composes it with the derivative bookkeeping. | slowed-target transport identity, target-side integration by parts, Cauchy--Schwarz, L2/FI square identifications, density/boundary regularity |
| `appendix.tex:168-208` combines the KL derivative display, first-term identity `firstTerm=-FI`, and target-side Young bound. | `SALD.forwardKlPostYoungDerivativeBoundScalar` proves `dK <= -(1/2)*FI+(1/2)*velocitySq` from those supplied scalar inputs. | mass conservation, differentiation under the integral, SALD Fokker--Planck, boundary/no-flux, FI identification, slowed-target transport, target-side integration by parts |
| `appendix.tex:210-217` applies LSI to replace the remaining `-(1/2)*FI` term by `-C_LSI*K`. | `SALD.forwardKlLsiDerivativeBoundScalar` proves the Real-order handoff from `C_LSI*K <= (1/2)*FI`. | LSI density-test backend, finite KL/FI interfaces, and the source comparison `probability.lsi_to_kl_fi` |
| Cycle-34 workflow registration. | `SALD.cycle34ForwardKlDerivativeUpperPacket`; `SALD.cycle34ForwardKlDerivativeScalarObligation` / `sald.forward_kl.cycle34_derivative_scalar`; `SALD.cycle34ForwardKlTargetYoungLowerObligation` / `sald.forward_kl.cycle34_target_young_lower`; `ASTIS.SALD.forward_KL.cycle34_derivative_scalar` | inverse-schedule time change `appendix.tex:218-228`, DV, Gronwall, endpoint rewrites, and the full `sald.forward_kl.kl_derivative` theorem |

Mode discipline:

- `faithfulPaper`; use only `main_body.tex:238-247` and
  `appendix.tex:168-228` from the original source root, excluding
  `sald_version_2.tex`.
- Preserve the source route KL derivative -> SALD Fokker--Planck ->
  slowed-target transport -> Young -> LSI -> inverse-schedule time change ->
  DV -> Gronwall.
- Do not add smoothness, density, absolute-continuity, endpoint, positivity,
  boundary, LSI, inverse-function, finite-log-mgf, or interval-integrability
  assumptions to the theorem statement.

Lower packet:

- target exactly `SALD.forwardKlPostYoungDerivativeBoundScalar`,
  `SALD.forwardKlLsiDerivativeBoundScalar`, and
  `SALD.cycle34ForwardKlDerivativeScalarObligation`;
- keep `SALD.cycle30ForwardKlMiddleContract` as the line ledger for
  `appendix.tex:168-208`;
- lower cycle 34 closes the theorem-independent target-side Young scalar
  inequality and keeps the analytic target transport, integration by parts,
  Cauchy--Schwarz, and L2/FI square inputs open;
- leave `sald.forward_kl.schedule_time_change` for `appendix.tex:218-228`
  unless a separate compiled chain-rule lemma is added.

Reviewer checklist:

- `SALD.forwardKlTargetTransportYoungBoundScalar`,
  `SALD.forwardKlPostYoungDerivativeBoundOfCauchyScalar`,
  `SALD.forwardKlPostYoungDerivativeBoundScalar`, and
  `SALD.forwardKlLsiDerivativeBoundScalar` compile and are only Real
  arithmetic/order lemmas.
- `SALD.forwardKlProofDag` includes
  `ASTIS.SALD.forward_KL.cycle34_derivative_scalar` before
  `ASTIS.SALD.forward_KL.derivative`.
- `sald.forward_kl.kl_derivative`, Fokker--Planck, LSI-to-KL/FI, time change,
  DV, Gronwall, and `thm:forward-KL` remain obligations or source-cited.

## Cycle 33 LSI/KL/FI Lower Scalar Bridge

Lower translated the next theorem-independent handoff in
`main_body.tex:208-215` into compiled Lean:

- `SALD.lsiKlFiDensityTestBridgeScalar` takes an already normalized LSI test
  inequality for `phi=sqrt(r)`, the entropy identity `entropy=KL`, and the
  Fisher chain-rule identity `dirichlet=(1/4)*FI`, then reuses
  `SALD.lsiKlFiCoefficientAuditScalar` to derive the displayed
  `KL <= FI/(2*C_LSI)`.
- `SALD.cycle33LsiKlFiDensityTestLowerObligation` records that the theorem
  still depends on the Radon-Nikodym density construction, integral transport,
  admissible `sqrt(r)` or approximation, finite KL/FI, zero-density
  convention, and FI chain rule.

No LSI theorem, KL/FI integral identity, or Fisher-information chain rule was
promoted.  `eq:LSI-KL-FI` and `probability.lsi_to_kl_fi` remain obligations.

## Cycle 38 LSI/KL/FI Middle Fisher-Chain Scalar Slice

Middle stayed on proof-closure item (3), `eq:LSI-KL-FI`, after the cycle 36
Gronwall and cycle 37 DV progress.  It added the next theorem-independent
scalar pieces for `main_body.tex:208-215`:

- `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainScalar` proves the
  positive-density pointwise coefficient
  `((1/(2*sqrt r))*dr)^2 = (1/4)*(r*(dr/r)^2)`.
- `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainOfDerivativesScalar`
  packages that identity after named derivative hypotheses for `d sqrt(r)`
  and `d log r`.
- `SALD.lsiKlFiHalfFisherScalar` converts the displayed
  `KL <= FI/(2*C_LSI)` to the forward-KL input
  `C_LSI*KL <= (1/2)*FI` under `C_LSI>0`.
- `SALD.lsiKlFiDensityTestHalfFisherScalar` composes the existing normalized
  density-test scalar bridge with the half-Fisher coefficient handoff.
- `SALD.cycle38LsiKlFiMiddleObligation` records that the vector-gradient,
  integral, Radon-Nikodym, smooth/admissible test or approximation,
  zero-density, and finite KL/FI backends remain open.

No vector Sobolev chain rule, integral KL/FI identity, LSI theorem, or
downstream forward-KL result was promoted.  `eq:LSI-KL-FI` and
`probability.lsi_to_kl_fi` remain obligations.

## Cycle 38 LSI/KL/FI Lower Finite-Coordinate Fisher Chain

Lower stayed on proof-closure item (3), `eq:LSI-KL-FI`, and compiled the next
theorem-independent handoff for `main_body.tex:208-215`:

- `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainFiniteSumScalar` lifts the
  positive-density pointwise coefficient from the middle scalar lemma to a
  finite coordinate sum,
  `sum_i (dSqrt_i)^2 = (1/4)*(r*sum_i (dLog_i)^2)`.
- `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainFiniteSumHandoffScalar`
  converts supplied finite-coordinate Dirichlet and Fisher identifications into
  the exact `dirichlet=(1/4)*FI` hypothesis consumed by
  `SALD.lsiKlFiDensityTestBridgeScalar`.
- `SALD.cycle38LsiKlFiLowerObligation` records that the source still needs the
  Radon-Nikodym density, coordinate-to-vector-gradient equivalence, integral
  transport, smooth/admissible test or approximation, zero-density convention,
  and finite KL/FI hypotheses.

No vector Sobolev chain rule, integral FI identity, LSI theorem, or downstream
forward-KL result was promoted.  `eq:LSI-KL-FI`,
`SALD.lsiKlFiDensityTestObligation`, and `probability.lsi_to_kl_fi` remain
obligations.

## Cycle 35 Upper EM Interpolation Fokker--Planck Packet

Priority check before lower assignment: (1) `lem:gronwall` remains open after
cycle 31 local real-analysis sublemmas, (2) `lem:dv_variation` remains
source-cited with cycle 32 scalar consequences, (3) `eq:LSI-KL-FI` remains
open after cycle 33 scalar density-test work, and (4) the continuous
forward-KL derivative block has cycle 34 scalar handoffs but still depends on
analytic Fokker--Planck inputs.  Cycle 35 therefore targets item (5), the
Euler--Maruyama interpolation endpoint and conditional-drift Fokker--Planck
backend in `appendix.tex:260-385`.

Compiled synchronization:

| Source step | Lean-facing item | Status |
|---|---|---|
| `appendix.tex:260-266` defines `hat X_s`; `appendix.tex:334-335` uses endpoint laws. | `SALD.discreteForwardKlEmEndpointObligation`, `SALD.discreteForwardKlEmInterpolationSideConditionContract` | obligation |
| `appendix.tex:347-354` defines `bar b_{k,s}` by conditional expectation. | `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract`, `SALD.cycle15DiscreteForwardKlConditionalDriftDensityObligation` | obligation |
| `appendix.tex:357-385` invokes the conditional-drift Fokker--Planck equation and Laplacian split. | `SALD.discreteForwardKlEmConditionalFpObligation`, `SALD.discreteForwardKlEmInterpolationObligation` | obligation |
| Cycle 35 upper handoff for the current proof-closure sprint. | `SALD.cycle35DiscreteForwardKlEmFpUpperPacket`, `SALD.cycle35DiscreteForwardKlEmFpUpperObligation`, `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_upper` | workflow obligation |

Lower packet:

- target exactly `SALD.discreteForwardKlEmInterpolationSideConditionContract`
  and `SALD.discreteForwardKlEmConditionalFpObligation`;
- first try one proof-producing interface: either endpoint-law algebra for the
  frozen interpolation at `s=s_k` and `s=s_{k+1}`, or the regular
  conditional-law/density/measurability interface for `bar b_{k,s}`;
- if the analytic conditional-drift Fokker--Planck theorem is too large,
  create a precise source-cited interface depending on
  `sald.discrete_forward_kl.conditional_drift_density` and keep it below
  formalized status;
- leave stitched endpoint regularity, frozen Gamma/Delta, LSI, DV, Gronwall,
  and accumulated-error collection as sibling obligations.

Reviewer checklist:

- `SALD.discreteForwardKlProofDag` contains
  `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_upper` before derivative, DV,
  and Gronwall blocks.
- `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` lists the cycle 35
  packet and obligation while retaining cycle 15 EM obligations.
- No source theorem, source constant, source file selection, or analytic
  dependency status is changed.

## Cycle 35 Middle EM Endpoint And Conditional-FP Algebra

The middle pass keeps the same priority check as the upper packet and does not
rebaseline the source index beyond the required acceptance gate.  It translates
the assigned `appendix.tex:260-385` block into three compiled local algebra
lemmas plus a middle obligation that records the remaining analytic backends.

| Source step | Lean-facing item | Status |
|---|---|---|
| `appendix.tex:260-266`, left endpoint `s=s_k`: the time increment and Brownian increment vanish. | `SALD.discreteForwardKlEmInterpolationLeftEndpointVector` | formalized local vector algebra |
| `appendix.tex:260-266`, right endpoint used in `appendix.tex:334-335`: after `s_{k+1}-s_k=eta` and the EM update definition, the interpolation equals `X_{k+1}^eta`. | `SALD.discreteForwardKlEmInterpolationRightEndpointVector` | formalized local vector algebra |
| `appendix.tex:377-385`: after divergence linearity, regroup the conditional drift and target-score terms. | `SALD.discreteForwardKlConditionalFpDivergenceDriftSplit` | formalized local additive algebra |
| Cycle 35 middle source-to-Lean synchronization. | `SALD.cycle35DiscreteForwardKlEmFpMiddleContract`, `SALD.cycle35DiscreteForwardKlEmFpMiddleObligation`, `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_middle` | obligation with compiled algebra substeps |

Remaining analytic obligations:

- `sald.discrete_forward_kl.em_endpoint_laws`: turn endpoint vector identities
  into law equalities for `hat rho_s`.
- `sald.discrete_forward_kl.conditional_drift_density`: construct the regular
  conditional law, density, measurability, and integrability interface for
  `bar b_{k,s}`.
- `sald.discrete_forward_kl.em_conditional_fokker_planck`: supply the
  conditional-drift Fokker--Planck equation, Laplacian split, and divergence
  linearity before applying the regrouping lemma.
- `sald.discrete_forward_kl.stitched_interval_regularity`: stitch the local
  interval estimates into the global Gronwall interface.

These lemmas do not mark endpoint law matching, conditional Fokker--Planck,
KL differentiation, integration by parts, LSI, DV, Gronwall, or
`thm:forward-KL-discrete` formalized.

## Cycle 35 Lower Conditional-FP Split Handoff

The lower pass adds one compiled Lean theorem for the `appendix.tex:357-385`
conditional-FP backend:

| Source step | Lean-facing item | Status |
|---|---|---|
| Conditional-drift Fokker--Planck identity `partial_s hat rho_s = -div(hat rho_s bar b_{k,s}) + Delta hat rho_s`. | hypothesis `hfp` of `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff`; existing obligation `sald.discrete_forward_kl.em_conditional_fokker_planck` | obligation |
| Laplacian split `Delta hat rho_s = div(hat rho_s grad log(hat rho_s/tilde pi_s)) + div(hat rho_s grad log tilde pi_s)`. | hypothesis `hlap` of `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff`; existing obligation `sald.discrete_forward_kl.em_conditional_fokker_planck` | obligation |
| Algebraic handoff to the source regrouped divergence form in `appendix.tex:377-385`. | `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff`, `SALD.cycle35DiscreteForwardKlEmFpLowerObligation`, `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_lower` | formalized local algebra + obligation |

The conditional drift density/disintegration, conditional-FP theorem, Laplacian
chain-rule split, KL derivative integration by parts, stitched regularity, LSI,
DV, Gronwall, and accumulated-error terms are still open.  No theorem-level
assumption, source coefficient, or analytic dependency status was changed.

## Cycle 39 Upper Forward-KL Derivative Packet

Priority check before lower assignment:

- (1) `lem:gronwall` has cycle 36 local assembly progress but remains an
  obligation;
- (2) `lem:dv_variation` has one-sided scalar consequences while the Boucheron
  equality remains source-cited;
- (3) `eq:LSI-KL-FI` has cycle 38 finite-coordinate Fisher-chain progress, but
  the vector/integral density-test backend remains an obligation;
- this cycle follows the requested item (4), the continuous forward-KL
  Fokker--Planck/KL derivative identity in `appendix.tex:168-228`;
- item (5), the Euler--Maruyama interpolation Fokker--Planck backend, stays a
  sibling obligation and is not the lower packet.

Accepted compiled core:

| Source bookkeeping step | Lean-facing item | Still open |
|---|---|---|
| `appendix.tex:168-208` supplies the KL derivative display, first-term Fisher identity, and target-side Cauchy/Young inputs. | `SALD.forwardKlPostYoungDerivativeBoundOfCauchyScalar` and earlier scalar lemmas | mass conservation, differentiation under the integral, SALD Fokker--Planck, integration by parts, target transport, Cauchy--Schwarz, density/boundary regularity |
| `appendix.tex:210-217` applies the source KL/FI comparison as a half-Fisher derivative bound. | `SALD.forwardKlLsiDerivativeBoundScalar`; `SALD.forwardKlLsiDerivativeBoundOfKlFiScalar`; cycle 38 half-Fisher scalar handoff | vector/integral density-test backend, admissibility/approximation, finite KL/FI, zero-density convention |
| `appendix.tex:218-228` changes from `s` to `t` and rewrites the velocity coefficient. | `SALD.forwardKlTimeChangedDerivativeBoundScalar` | analytic chain rule, inverse derivative identity, velocity-square scaling, positivity/nonzero of `dot{s}` |
| Cycle 39 scalar pipeline. | `SALD.forwardKlPreDvDerivativeBoundScalar`; `SALD.cycle39ForwardKlDerivativeUpperPacket`; `SALD.cycle39ForwardKlDerivativeUpperObligation` / `sald.forward_kl.cycle39_derivative_upper`; `ASTIS.SALD.forward_KL.cycle39_derivative_upper` | full `sald.forward_kl.kl_derivative`, DV, Gronwall, endpoint rewrites, and EM interpolation |

Mode discipline:

- `faithfulPaper`; use only `main_body.tex:238-247` and
  `appendix.tex:168-228` from the original source root, excluding
  `sald_version_2.tex`.
- Preserve the source route KL derivative -> SALD Fokker--Planck ->
  slowed-target transport -> Young -> LSI -> inverse-schedule time change ->
  DV -> Gronwall.
- Do not add smoothness, density, absolute-continuity, endpoint, positivity,
  boundary, LSI, inverse-function, finite-log-mgf, or interval-integrability
  assumptions to the theorem statement.

Lower packet:

- first verify or extend the theorem-specific scalar composition around
  `SALD.forwardKlPreDvDerivativeBoundScalar` and
  `SALD.forwardKlPreDvDerivativeBoundOfKlFiVelocityScalingScalar`, with all
  analytic premises explicit;
- next target `SALD.forwardKlDensityBoundaryObligation` /
  `sald.forward_kl.density_boundary_regular` for `appendix.tex:168-185`;
- if stable, target `SALD.forwardKlScheduleTimeChangeObligation` /
  `sald.forward_kl.schedule_time_change` for `appendix.tex:191-228`;
- leave DV finite-log-mgf, coefficient-chain audit, Gronwall side conditions,
  endpoint rewrites, and EM interpolation work outside this lower attempt.

Reviewer checklist:

- `SALD.forwardKlPreDvDerivativeBoundScalar` and
  `SALD.forwardKlPreDvDerivativeBoundOfKlFiVelocityScalingScalar` compile and
  are only scalar
  Real/order composition from explicit KL derivative, first-term, Cauchy, LSI,
  chain-rule, velocity-scaling, and inverse-schedule premises.
- `SALD.continuousSaldContract`, `SALD.forwardKlProofDag`, and
  `SALD.saldDependenciesForLabel "thm:forward-KL"` list the cycle 39 packet
  and obligation.
- `sald.forward_kl.kl_derivative`, `sald.forward_kl.density_boundary_regular`,
  `sald.forward_kl.schedule_time_change`, `probability.lsi_to_kl_fi`, DV, and
  Gronwall remain obligations or source-cited dependencies.

## Cycle 39 Middle Source-Shaped Schedule Lemmas

Middle stayed on proof-closure item (4) and translated the
`appendix.tex:191-228` schedule/velocity part into source-shaped scalar lemmas.
These lemmas compile, but they are not analytic closures.

| Lean item | Source slice | Formalized content | Remaining obligation |
|---|---|---|---|
| `SALD.forwardKlInverseScheduleDerivativeScalar` | `appendix.tex:218-228` | From supplied `dotS*dotT=1`, derive `dotT=dotS^-1` and `dotS != 0`. | inverse-function calculus proving the product identity |
| `SALD.forwardKlTimeChangeSquareCoefficientRewriteOfProductScalar` | `appendix.tex:223-228` | Rewrite `dotS*(dotT^2*coeff)` to `dotS^-1*coeff` from `dotS*dotT=1`. | schedule regularity and positivity/nonzero side conditions |
| `SALD.forwardKlVelocitySquareScalingScalar` | `appendix.tex:191-197` | From scalar norm-square identities and `tildeNorm=dotT*velocityNorm`, derive `tildeVelocitySq=dotT^2*velocitySq`. | slowed-target transport and L2 norm-square backend |
| `SALD.forwardKlTimeChangedDerivativeBoundOfProductScalar` | `appendix.tex:218-228` | Use the product identity in the time-change derivative bound. | KL chain rule, s-time LSI derivative bound, velocity-square scaling |
| `SALD.forwardKlPreDvDerivativeBoundOfProductScalar`; `SALD.forwardKlPreDvDerivativeBoundOfVelocityScalingScalar` | `appendix.tex:168-228` | Compose the existing KL/Young/LSI scalar pipeline with source-shaped inverse schedule and velocity-square inputs. | density/boundary KL derivative, target Cauchy, LSI-to-KL/FI, schedule backend |
| `SALD.forwardKlLsiDerivativeBoundOfKlFiScalar`; `SALD.forwardKlPreDvDerivativeBoundOfKlFiVelocityScalingScalar` | `appendix.tex:210-228` | Use the source-shaped `KL <= FI/(2*C_LSI)` input directly in the pre-DV derivative pipeline. | full density-test LSI-to-KL/FI backend, density/boundary KL derivative, target Cauchy, schedule backend |
| `SALD.cycle39ForwardKlDerivativeMiddleContract`; `SALD.cycle39ForwardKlDerivativeMiddleObligation`; `ASTIS.SALD.forward_KL.cycle39_derivative_middle` | `appendix.tex:168-228` | Middle synchronization and lower packet for the source-shaped scalar handoff. | full `sald.forward_kl.kl_derivative`; DV; Gronwall; endpoint rewrites; EM interpolation |

No theorem statement was changed, no hidden smoothness or boundary assumption
was added, and no analytic dependency was promoted.  The next lower target is
still either `sald.forward_kl.schedule_time_change` for the product/chain-rule
and L2 scaling inputs, or `sald.forward_kl.density_boundary_regular` for
`appendix.tex:168-185`.

## Cycle 40 Middle EM Endpoint Law Handoff

Middle checked the proof-closure order before lower assignment: Gronwall, DV,
LSI/KL/FI, and the continuous forward-KL derivative have current compiled
substeps but still depend on analytic backends, so this pass follows item (5),
the Euler--Maruyama interpolation Fokker--Planck backend in
`appendix.tex:260-385`.

Proof-producing additions:

| Source step | Lean declaration | Status |
|---|---|---|
| Pointwise equality of random variables implies equality under any supplied law operator. | `SALD.discreteForwardKlLawEqOfPointwise` | formalized abstract equality transport |
| `appendix.tex:260-266` and `appendix.tex:334-335`: at `s=s_k`, the interpolation endpoint has law `rho_k^eta` once the project law operator is supplied. | `SALD.discreteForwardKlEmInterpolationLeftEndpointLawHandoff` | formalized abstract law handoff; concrete stochastic law still open |
| `appendix.tex:260-266` and `appendix.tex:334-335`: at `s=s_{k+1}`, the interpolation endpoint has law `rho_{k+1}^eta` once the mesh identity and pointwise EM update are supplied. | `SALD.discreteForwardKlEmInterpolationRightEndpointLawHandoff` | formalized abstract law handoff; concrete stochastic law still open |
| Cycle 40 middle synchronization. | `SALD.cycle40DiscreteForwardKlEmFpMiddleContract`; `SALD.cycle40DiscreteForwardKlEmFpMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle40_em_fp_middle` | obligation with compiled endpoint-law sublemmas |

Remaining obligations:

- instantiate the endpoint law handoffs with the repository's concrete
  `Law`/density notation for `hat rho_s`, `rho_k^eta`, and
  `rho_{k+1}^eta`;
- construct the regular conditional law, measurability, and integrability
  interface for `bar b_{k,s}`;
- supply the conditional-drift Fokker--Planck theorem and Laplacian split
  used by `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff`;
- keep KL differentiation, integration by parts, LSI, DV, Gronwall,
  coefficient-chain, and accumulated-error work as sibling obligations.

No theorem statement, source coefficient, source file selection, SLT status, or
analytic dependency status was changed.

## Cycle 44 Upper Main Skeleton Analytic Interface Ledger

Upper checked the current proof route before assigning lower work.  The five
slow analytic backends are now explicit source-cited or obligation interfaces,
and the faithful theorem route points at the same ledger without changing any
paper theorem statement, source constant, or source label.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 44 Gronwall interface | Endpoint-safe Gronwall with continuous coefficients, differentiable or absolutely continuous `K`, FTC/order integration, endpoint evaluation, interval-integrability, and exponent rewrites. | cycle 36 assembly; cycle 41 derivative wrappers and interior endpoint bridge | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.saldGronwallExponentRewriteContract`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `appendix.tex:47-71` | forward-KL, discrete forward-KL, continuous general moving target, discrete general moving target | obligation |
| Cycle 44 DV interface | Common probability space, absolute continuity, finite KL/log-likelihood, measurable selected tests, finite log-mgf, and selected-test one-sided consequences; the Boucheron supremum equality remains cited. | cycle 32 source-cited interface; cycle 37 tilted backend; cycle 42 scaled-test handoffs | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `appendix.tex:73-79` | all SALD DV energy steps | source-cited equality plus obligations |
| Cycle 44 LSI/KL/FI interface | Radon-Nikodym density, zero-set convention, admissible `sqrt(rho/pi)` test or approximation, entropy identity, Fisher chain rule, and finite theorem-level KL/FI assumptions. | cycle 33 density scalar bridge; cycle 38 Fisher-chain scalar and finite-sum handoffs; cycle 43 density/entropy and integral Fisher-chain handoffs | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `main_body.tex:202-215` | all theorem blocks using LSI contraction | obligation |
| Cycle 44 continuous forward-KL derivative interface | Continuous Fokker--Planck/KL derivative backend with mass conservation, density and boundary regularity, KL differentiation under the integral, integration by parts, target transport, LSI handoff, and inverse-schedule calculus. | cycle 30 density/boundary packet; cycle 34 scalar derivative pipeline; cycle 39 source-shaped schedule and velocity handoffs | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `appendix.tex:168-228` | `thm:forward-KL`; continuous general moving target backend | obligation |
| Cycle 44 EM interpolation Fokker--Planck interface | Euler--Maruyama endpoint laws, conditional drift, conditional-law density, interpolation Fokker--Planck equation, Laplacian split, stitched-interval regularity, and EM common-space/absolute-continuity. | cycle 35 EM algebra; cycle 40 endpoint law handoff; existing discrete derivative side-condition contracts | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `appendix.tex:260-385`; `appendix.tex:1354-1387` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 44 theorem skeleton route | Wire the five analytic interfaces into the faithful theorem order without promoting unresolved analysis. | the five rows above; existing theorem contracts; `saldDependenciesForLabel` wiring | `SALD.cycle44MainSkeletonAnalyticInterfaceLedger`; `SALD.cycle44MainSkeletonAnalyticInterfaceObligation`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `main_body.tex:238-323`; `appendix.tex:724-1603` | ASTIS-SALD-001 main skeleton closure | obligation |

Lower packet:

- Middle should keep this proof-DAG pane synchronized across Lean, this
  obligation ledger, and the conversion window.
- Lower should target exactly one listed backend next, preferably the
  continuous forward-KL density/boundary KL derivative interface or the EM
  conditional-law/Fokker--Planck common-space interface.
- If the selected backend is too large, sharpen its source-cited or obligation
  interface with common-space, absolute-continuity, finite-quantity,
  admissibility, endpoint, and regularity hypotheses instead of changing a
  paper theorem statement.

Reviewer checklist:

- The five analytic interfaces are named with source anchors and statuses below
  formalized except for already compiled local sublemmas.
- The six theorem-route contracts and dependency-label entries point to
  `SALD.cycle44MainSkeletonAnalyticInterfaceObligation`.
- No theorem statement, source coefficient, source file selection, external
  reuse status, or proof route is changed.
- No unproved backend is marked formalized and no hidden analytic assumption is
  added to a theorem skeleton.

## Cycle 44 Lower Forward-KL Post-DV Handoff

Lower targeted the continuous `thm:forward-KL` route after the cycle-44
analytic interface ledger.  The source slice is `appendix.tex:230-244`, where
the DV velocity-energy bound is inserted into the pre-DV derivative inequality
before applying Gronwall.

| Source step | Lean-facing item | Status |
|---|---|---|
| Insert the selected-test DV estimate into `dK/dt <= -(dot{s} C_LSI)K + coeff*energy` and collect the KL coefficient. | `SALD.forwardKlPostDvGronwallCoefficientScalar` | formalized scalar/order handoff |
| Specialize the coefficient to the source prefactor `(1/2)*dot{s}(t)^(-1)`. | `SALD.forwardKlPostDvGronwallCoefficientOfScheduleScalar` | formalized scalar/order handoff |

Remaining obligations: the KL derivative/Fokker--Planck backend, LSI-to-KL/FI,
finite-log-mgf/common-space selected-test DV witnesses, nonnegativity of the
source prefactor, Gronwall endpoint calculus, and theorem endpoint rewrites.
No theorem statement or analytic backend status was changed.

## Cycle 46 Upper Discrete Forward-KL Skeleton Route

Upper added `SALD.cycle46DiscreteForwardKlSkeletonUpperPacket`,
`SALD.cycle46DiscreteForwardKlSkeletonObligation`, and
`SALD.cycle46DiscreteForwardKlSkeletonDag` to route
`thm:forward-KL-discrete` through the existing five slow interfaces.

| Source block | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:299-323` | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract` now lists `SALD.cycle46DiscreteForwardKlSkeletonObligation` | theorem stays `contractOnly`; constants and assumptions unchanged |
| `appendix.tex:260-385` | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_endpoint_laws`; `sald.discrete_forward_kl.em_conditional_fokker_planck` | endpoint laws, conditional drift density, conditional-FP theorem, Laplacian split, stitched intervals |
| `appendix.tex:388-491` | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.frozenDeltaCrossLipSaldContract`; `sald.discrete_forward_kl.kl_derivative` | density/boundary regularity, omitted frozen-defect specialization, LSI/KL/FI backend |
| `appendix.tex:493-523` | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_velocity_bound` | EM common-space, absolute-continuity, finite-log-mgf, source-cited DV |
| `appendix.tex:526-592`; `main_body.tex:309-323` | `SALD.discreteForwardKlGronwallInstantiationContract`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `sald.discrete_forward_kl.accumulated_error_bridge` | stitched Gronwall regularity, endpoint rewrites, residual exponent bound, `A_alpha`, `barGamma`, and `barDelta` identifications |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 46 discrete forward-KL theorem skeleton route | Compose EM interpolation, frozen-defect/LSI derivative block, DV velocity witness, Gronwall accumulation, and linear-slowdown bridge into the exact source theorem display. | cycle-44 ledger; discrete statement; EM side-condition; frozen-delta; LSI/DV/Gronwall; accumulated-error bridge | `SALD.cycle46DiscreteForwardKlSkeletonUpperPacket`; `SALD.cycle46DiscreteForwardKlSkeletonObligation`; `SALD.cycle46DiscreteForwardKlSkeletonDag`; `ASTIS.SALD.forward_KL_discrete.cycle46_theorem_skeleton_route` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete` | obligation |

Lower packet: choose exactly one backend next, preferably
`sald.discrete_forward_kl.em_conditional_fokker_planck` or
`sald.discrete_forward_kl.accumulated_error_bridge`; keep all slow analytic
backends below formalized until exact local proofs replace them.

## Cycle 46 Middle Discrete Forward-KL Route Audit

Middle added `SALD.cycle46DiscreteForwardKlSkeletonMiddleContract`,
`SALD.cycle46DiscreteForwardKlSkeletonMiddleObligation`, and DAG node
`ASTIS.SALD.forward_KL_discrete.cycle46_middle_route_audit` to check the
cycle-46 upper wrapper against `main_body.tex:299-323` and
`appendix.tex:260-592`.

| Source block | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:299-323` | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract` now lists `SALD.cycle46DiscreteForwardKlSkeletonMiddleObligation` | theorem stays `contractOnly`; constants and assumptions unchanged |
| `appendix.tex:260-330` | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.frozenDeltaCrossLipSaldContract`; `sald.discrete_forward_kl.frozen_delta_cross_lip` | endpoint law matching, conditional-law density, conditional-FP, and frozen-defect specialization |
| `appendix.tex:334-491` | `SALD.discreteForwardKlDerivativeCandidateContract`; `sald.discrete_forward_kl.kl_derivative`; `SALD.saldLsiKlFiDensityTestContract` | density/boundary regularity, integration by parts, and LSI/KL/FI backend |
| `appendix.tex:493-523` | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_finite_log_mgf_witness`; `sald.discrete_forward_kl.dv_velocity_bound` | EM common-space, absolute-continuity, finite-log-mgf, measurability, and source-cited DV |
| `appendix.tex:526-592` | `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract` | stitched-interval regularity, coefficient regularity, endpoint rewrites, and residual-exponent bound |
| `main_body.tex:309-323` | `sald.discrete_forward_kl.accumulated_error_bridge`; `SALD.discreteForwardKlAccumulatedErrorCollectionScalar` | `A_alpha`, `barGamma`, and `barDelta` source identifications |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 46 middle discrete forward-KL route audit | Verify the exact theorem route after the upper wrapper and choose the accumulated-error bridge for lower display-matching work. | cycle-44 ledger; cycle-46 upper wrapper; EM endpoint/conditional-FP; frozen-defect/LSI; DV; Gronwall; accumulated-error bridge | `SALD.cycle46DiscreteForwardKlSkeletonMiddleContract`; `SALD.cycle46DiscreteForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle46_middle_route_audit` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete`; cycle 46 lower packet | obligation |

Lower packet: target exactly
`SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
`SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
`sald.discrete_forward_kl.accumulated_error_bridge`, first on endpoint and
initial-exponent splitting, then on connecting the compiled collection algebra
to the theorem display.  The slow EM, frozen-defect, LSI, DV, Gronwall, and
residual-exponent backends stay below formalized.

## Cycle 46 Lower Discrete Accumulated-Error Initial Exponent Split

Lower targeted `sald.discrete_forward_kl.accumulated_error_bridge` at the
initial Gronwall exponent split from `appendix.tex:557-590` to
`main_body.tex:309-315`.

Compiled local algebra:

| Lean declaration | What it proves | Status |
|---|---|---|
| `SALD.discreteForwardKlGronwallCoeffIntervalIntegrable` | Interval-integrability of `lsi-alpha-gamma` from the three coefficient pieces. | formalized local algebra |
| `SALD.discreteForwardKlGronwallCoeffIntegralSubSub` | Integral split `int(lsi-alpha-gamma)=int lsi-int alpha-int gamma`. | formalized local algebra |
| `SALD.discreteForwardKlGronwallInitialExponentSplitScalar` | Scalar exponential split `exp(-(lsi-alpha-gamma))*K0 = exp(-lsi)*exp(alpha+gamma)*K0`. | formalized local algebra |
| `SALD.discreteForwardKlGronwallInitialExponentSplitOfPieces` | Source-shaped initial exponent split under coefficient integrability inputs. | formalized local algebra |

Remaining obligations: endpoint law rewrites for `K(0)` and `K(T)`, the
linear-slowdown identifications of the coefficient integrals, `barGamma` and
`barDelta` source definitions, residual-exponent monotonicity, stitched
Gronwall regularity, EM conditional-FP, frozen-defect, DV, and LSI/KL/FI.

## Cycle 47 Upper Guided/General Skeleton Route

Upper kept the cycle-44 five-interface ledger and moved the theorem-level
wrapper to `prop:guided_path_residual` and
`thm:general-moving-target-SALD`.  The source window is
`appendix.tex:619-951`; the proposition and theorem statements are unchanged.

Five-backend check before lower work:

| Backend | Lean-facing interface | Status |
|---|---|---|
| Endpoint-safe Gronwall `lem:gronwall` | `SALD.saldGronwallCandidateContract`; cycle 36/41 wrappers; `sald.gronwall.integrating_factor` | obligation with local wrappers |
| Donsker--Varadhan `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; residual finite-log-mgf witnesses | source-cited equality plus obligations |
| LSI/KL/FI `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous Fokker--Planck/KL derivative | `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative` | obligation |
| EM interpolation Fokker--Planck | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.em_interpolation_fp` | downstream obligation |

Source-to-Lean map:

| Source block | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:619-704`: guided normalizer, centered residual, and mean-zero identity. | `SALD.guidedResidualIdentityContract`; `SALD.guidedResidualContract`; `SALD.cycle47GuidedGeneralSkeletonObligation` | differentiating under the integral, positive finite `Z_t`, boundary decay, divergence cancellation, and mean-zero integration |
| `appendix.tex:724-744`: general theorem statement and sigma-weighted display. | `SALD.generalMovingTargetStatementContract`; `SALD.generalVaSaldContract`; `SALD.cycle47GuidedGeneralSkeletonObligation` | theorem remains `contractOnly`; no constants or assumptions are changed |
| `appendix.tex:765-884`: KL derivative, general Fokker--Planck, target transport, residual `m_t=v_t-c_t`, Young, LSI, and time change. | `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative`; `SALD.saldLsiKlFiDensityTestContract` | density/law regularity, Fokker--Planck backend, integration by parts, transport, LSI density test, sigma and schedule positivity |
| `appendix.tex:885-907`: residual DV with `Z=alpha*||m_t||^2`. | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `sald.general_moving_target.dv_m_energy` | common-space, absolute-continuity, measurability, finite log-mgf, alpha scaling, source-cited DV |
| `appendix.tex:909-945`: Gronwall, theorem-display matching, and pure contraction. | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.pure_contraction` | coefficient regularity, endpoint rewrites, exponent splitting, residual-exponent monotonicity, zero-residual alpha-complexity |
| `appendix.tex:949-951`: unified theorem downstream reuse. | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.specialization` | transport bridge from guided residual plus `eq:poisson-eq` remains separate |

Cycle 47 lower added a compiled scalar/order core for the continuous general
derivative backend:

| Source step | Compiled Lean handoff | Remaining obligation |
|---|---|---|
| `appendix.tex:835-864`: after Fokker--Planck and target transport expose the residual cross term, Young leaves `-(sigma^2/4)*FI + sigma^(-2)*dot t^2*||m||^2`. | `SALD.generalMovingTargetPostYoungDerivativeBoundScalar` | analytic Holder/Young, residual-field identification, FI/L2 identities, sigma positivity |
| `appendix.tex:865-872`: LSI converts the remaining Fisher term to `-(sigma^2/2)*C_LSI*K`. | `SALD.generalMovingTargetLsiDerivativeBoundScalar` | `probability.lsi_to_kl_fi` density-test backend and admissibility/zero-set convention |
| `appendix.tex:873-884`: the inverse schedule rewrites `dot{s}*dot t^2` to `dot{s}^(-1)`. | `SALD.generalMovingTargetTimeChangedDerivativeBoundScalar`; `SALD.generalMovingTargetPreDvDerivativeBoundScalar` | chain rule for `K(s(t))`, inverse-schedule differentiability, positivity/nonzero of `dot{s}` |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 47 guided/general skeleton route | Compose guided residual, continuous general derivative, LSI, residual DV, Gronwall, and pure-contraction interfaces into the exact source route. | cycle-44 ledger; guided residual contract; general statement contract; derivative side conditions; LSI density-test bridge; residual DV witness; Gronwall side conditions | `SALD.cycle47GuidedGeneralSkeletonUpperPacket`; `SALD.cycle47GuidedGeneralSkeletonObligation`; `SALD.cycle47GuidedGeneralSkeletonDag`; `ASTIS.SALD.guided_general.cycle47_theorem_skeleton_route` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD` | obligation |

Lower packet: target exactly `SALD.generalMovingTargetDerivativeCandidateContract`
/ `SALD.generalMovingTargetDerivativeObligation` /
`sald.general_moving_target.kl_derivative`.  First expose the density/law,
Fokker--Planck, mass-conservation, and integration-by-parts interfaces for
`appendix.tex:765-812`; then identify target transport, residual
`m_t=v_t-c_t`, and the Young coefficient from `appendix.tex:835-864`.

## Cycle 47 Middle Guided/General Route Audit

Middle added `SALD.cycle47GuidedGeneralSkeletonMiddleContract`,
`SALD.cycle47GuidedGeneralSkeletonMiddleObligation`, and DAG node
`ASTIS.SALD.guided_general.cycle47_middle_route_audit` to check the cycle-47
upper wrapper against `appendix.tex:619-951`.

| Source block | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:619-704` | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.normalizer_derivative`; `sald.guided_path_residual.identity` | guided-density calculus and centering |
| `appendix.tex:765-884` | `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative`; `probability.lsi_to_kl_fi` | Fokker--Planck/KL derivative backend, integration by parts, LSI density-test, schedule calculus |
| `appendix.tex:885-907` | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `sald.general_moving_target.dv_finite_log_mgf_witness`; `sald.general_moving_target.dv_positive_alpha_scaling`; `sald.general_moving_target.dv_m_energy` | source-cited DV plus theorem-specific selected-test witnesses |
| `appendix.tex:909-945` | `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_side_conditions`; `sald.general_moving_target.pure_contraction` | endpoint, coefficient, exponent, and zero-residual obligations |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 47 middle guided/general route audit | Verify the exact source route and choose the general KL derivative backend for lower work. | cycle-44 ledger; cycle-47 upper wrapper; guided residual, derivative, LSI, DV, and Gronwall interfaces | `SALD.cycle47GuidedGeneralSkeletonMiddleContract`; `SALD.cycle47GuidedGeneralSkeletonMiddleObligation`; `ASTIS.SALD.guided_general.cycle47_middle_route_audit` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; cycle 47 lower packet | obligation |

No analytic backend status is promoted.  `prop:guided_path_residual` and
`thm:general-moving-target-SALD` remain contract-only, and the downstream
unified theorem remains the source specialization rather than a direct proof.

## Cycle 48 Middle Unified/Discrete Route Audit

Middle added `SALD.cycle48UnifiedDiscreteSkeletonMiddleContract`,
`SALD.cycle48UnifiedDiscreteSkeletonMiddleObligation`, and DAG node
`ASTIS.SALD.unified_discrete_general.cycle48_middle_route_audit` after the
cycle-48 upper wrapper.  The audit keeps `thm:unified-forward-KL` as the
source specialization of the continuous general theorem and keeps
`thm:general-moving-target-SALD-discrete` on the paper EM/frozen-delta/LSI/DV/
Gronwall route.

| Source block | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:359-395`; `appendix.tex:949-951` | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.transport_velocity_bridge`; `sald.unified_forward_kl.specialization` | correction-field transport bridge, guided residual calculus, continuous general theorem backends |
| `appendix.tex:1313-1347` | `SALD.generalMovingTargetDiscreteStatementContract`; `SALD.generalVaSaldDiscreteContract` | theorem remains `contractOnly`; constants and alpha ranges unchanged |
| `appendix.tex:1354-1387` | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `sald.general_moving_target_discrete.em_interpolation_fp` | common space, endpoint laws, regular conditional drift, density/AC, weak conditional Fokker--Planck |
| `appendix.tex:1469-1511` | cycle-28 derivative-side middle/lower packets and scalar Young helpers | concrete field identifications, Young/FI backend, frozen-delta analytic lemma |
| `appendix.tex:1513-1603` | `probability.lsi_to_kl_fi`; `sald.general_moving_target_discrete.dv_m_energy`; `sald.general_moving_target_discrete.gronwall_side_conditions`; `sald.general_moving_target_discrete.unified_specialization` | LSI density-test, source-cited DV, finite-log-mgf witness, endpoint stitching, Gronwall |

Narrow backfill: `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`
records the first lower measure/SDE slice for
`sald.general_moving_target_discrete.kl_derivative`.  It is an obligation, not
a proof: local SLT material may guide one-step or disintegration patterns, but
no SLT theorem is imported or marked formalized.

Lower packet: target exactly
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract` /
`SALD.generalMovingTargetDiscreteDerivativeObligation` /
`sald.general_moving_target_discrete.kl_derivative`, starting with
`appendix.tex:1354-1387`.

## SLT/Mathlib Reuse

Potentially reusable SLT items are tracked in
`research-wiki/cited-results/SLT_reuse_audit.md`.

## Cycle 49 Upper Analytic Readiness

New Lean-facing obligation:
`SALD.cycle49MainSkeletonAnalyticReadinessObligation`
(`sald.main_skeleton.cycle49_analytic_readiness`).

Statement: re-check the five source-cited or obligation-level analytic
interfaces after the theorem wrappers are present, confirm that the six
theorem skeletons are routed through them without statement changes, and
select `appendix.tex:1354-1387` for the next lower backfill of the discrete
general EM endpoint/conditional-law/Fokker--Planck backend.

Backend status audit:

| Backend | Obligation/source-cited interface | Status |
|---|---|---|
| Gronwall | `SALD.saldGronwallEndpointCalculusContract`; `sald.gronwall.integrating_factor` | obligation |
| DV | `dvVariationalFormulaInterface saldDvVariationSource`; `probability.dv_variational_formula`; finite-log-mgf witnesses | source-cited plus obligations |
| LSI/KL/FI | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous KL derivative | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.generalMovingTargetDerivativeCandidateContract` | obligation |
| EM interpolation Fokker--Planck | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairHandoff`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairOfNamedInterpolation`; `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation` | obligation with compiled endpoint bookkeeping |

Selected lower packet:

- target `SALD.generalMovingTargetDiscreteDerivativeCandidateContract`,
  `SALD.generalMovingTargetDiscreteDerivativeObligation`, and
  `sald.general_moving_target_discrete.kl_derivative`;
- start with the source lines `appendix.tex:1354-1387`;
- instantiate endpoint-law bookkeeping through
  `SALD.generalMovingTargetDiscreteEmEndpointLawPairOfNamedInterpolation` only
  from concrete named-process law representations and pointwise endpoint
  identities for `hat rho_s`, `rho_k^eta`, and `rho_{k+1}^eta`;
- expose regular conditional drift, measurability/integrability,
  density/absolute-continuity, common-space, and weak conditional
  Fokker--Planck assumptions as obligations;
- preserve the cycle-28 frozen/residual algebra and the two
  `sigma_eta^2/8` Young shares for later work.

No theorem statement, coefficient, source label, theorem status, SLT reuse
status, or analytic backend status is changed.

## Cycle 62 Upper Guided/General Route Obligation

Cycle 62 returns to the guided residual and continuous general moving-target
route after the accepted cycle-61 discrete forward-KL recovery.

Global phase judgment:

- cycle 61 passed reviewer/build and does not need recovery;
- Phase 1 is not ready for cited-theory backfill until
  `prop:guided_path_residual` and `thm:general-moving-target-SALD` are
  synchronized after the discrete recovery;
- the single lower packet is an `appendix.tex:619-951` route audit that narrows
  later proof-producing work to `sald.general_moving_target.kl_derivative`.

Lean-facing declarations:

| Declaration | Source anchor | Role | Status |
|---|---|---|---|
| `SALD.cycle62GuidedGeneralSkeletonUpperPacket` | `appendix.tex:619-951` | upper objective, mode discipline, non-goals, lower packet, reviewer checklist | obligation |
| `SALD.cycle62GuidedGeneralSkeletonObligation` / `sald.guided_general.cycle62_upper_route` | `appendix.tex:619-951` | route wrapper tying guided residual and continuous general theorem to named interfaces after cycle 61 | obligation |
| `SALD.cycle62GuidedGeneralSkeletonMiddleContract` / `SALD.cycle62GuidedGeneralSkeletonMiddleObligation` / `sald.guided_general.cycle62_middle_route_audit` | `appendix.tex:619-951`; lower slice `appendix.tex:765-884` | middle source-to-Lean audit: guided residual, general derivative, LSI, residual DV, Gronwall, pure contraction, unified specialization, and downstream EM reuse all map to named interfaces; lower work remains the continuous general KL derivative | obligation |
| `SALD.generalMovingTargetKlDerivativeScaledResidualDisplayScalar`; `SALD.cycle62GuidedGeneralScaledResidualLowerObligation` / `sald.general_moving_target.cycle62_scaled_residual_lower` | `appendix.tex:813-835` | compiled scalar sign/scale handoff for `tilde v_s=dot{t}(s)v_{t(s)}` and `m_t=v_t-c_t`, giving the paper residual display before Young | formalized scalar core plus obligation |
| `SALD.cycle62GuidedGeneralSkeletonDag` | `appendix.tex:619-951`; downstream EM sources | proof-DAG pane for global judgment, five-backend check, upper route, middle audit, and selected lower packet | obligation |

Five slow analytic interfaces checked before middle/lower work:

| Interface | Named declarations | Status |
|---|---|---|
| `lem:gronwall` endpoint-safe differentiability/FTC/coefficient interface | `SALD.saldGronwallEndpointCalculusContract`; `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract` | obligation |
| `lem:dv_variation` common-space/AC/finite-log-mgf interface | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract` | source-cited plus obligations |
| `eq:LSI-KL-FI` density-test bridge | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| continuous Fokker-Planck/KL derivative | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative` | obligation |
| EM interpolation Fokker-Planck endpoint/conditional-law backend | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.em_interpolation_fp` | downstream obligation |

Route obligations:

| Source step | Lean-facing route | Remaining missing facts |
|---|---|---|
| `appendix.tex:619-704` | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.normalizer_derivative`; `sald.guided_path_residual.identity` | positive finite normalizer, differentiation under the integral, boundary integration by parts, quotient/product differentiation, mean-zero residual |
| `appendix.tex:724-744` | `SALD.generalMovingTargetStatementContract`; `SALD.generalVaSaldContract` | theorem remains `contractOnly`; statement and constants unchanged |
| `appendix.tex:765-884` | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; `sald.general_moving_target.kl_derivative`; cycle-57 scalar split lower; cycle-62 scaled residual lower | density/law regularity, mass conservation, KL differentiation, Fokker-Planck, integration by parts, analytic target transport, residual Young, LSI handoff, sigma/schedule side conditions |
| `appendix.tex:885-907` | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `sald.general_moving_target.dv_m_energy` | common-space, AC, finite KL/log-mgf, measurability, positive alpha, source-cited DV |
| `appendix.tex:908-945` | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_side_conditions`; `sald.general_moving_target.pure_contraction` | endpoint rewrites, coefficient regularity, exponent splitting, residual-exponent monotonicity, zero-residual alpha-complexity |
| `appendix.tex:949-951` | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.specialization` | downstream specialization; no direct VA-SALD proof route |

Proof-DAG rows:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 62 global judgment | No cycle-61 recovery; defer cited-theory backfill; select guided/general route audit. | cycle-61 discrete route; cycle-57 guided/general route | `ASTIS.SALD.guided_general.cycle62_global_phase_judgment` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD` | obligation |
| Cycle 62 five-backend check | Recheck Gronwall, DV, LSI/KL/FI, continuous derivative, and EM interpolation interfaces. | cycle-59 interface ledger; named guided/general contracts | `ASTIS.SALD.guided_general.cycle62_five_backend_check` | `appendix.tex:619-951`; downstream EM sources | all first-DAG theorem consumers | obligation |
| Cycle 62 upper route | Wire guided residual and continuous general theorem to named interfaces without changing statements. | cycle-61 discrete recovery; guided residual, derivative, LSI, DV, Gronwall, pure-contraction interfaces | `SALD.cycle62GuidedGeneralSkeletonObligation`; `ASTIS.SALD.guided_general.cycle62_upper_route` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; `thm:unified-forward-KL` | obligation |
| Cycle 62 middle route audit | Verify `appendix.tex:619-951` in paper order and keep all missing analytic facts as named obligations/source-cited interfaces. | cycle-62 upper route; cycle-61 discrete recovery; cycle-57 derivative split lower; guided residual, derivative, LSI, residual DV, Gronwall, pure contraction, unified specialization, and downstream EM interfaces | `SALD.cycle62GuidedGeneralSkeletonMiddleContract`; `SALD.cycle62GuidedGeneralSkeletonMiddleObligation`; `ASTIS.SALD.guided_general.cycle62_middle_route_audit` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; cycle 62 lower derivative packet | obligation |
| Cycle 62 lower packet | After the middle audit, target continuous general KL derivative over `appendix.tex:765-884`. | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; cycle-57 scalar split lower | `ASTIS.SALD.guided_general.cycle62_lower_packet.route_audit` | `appendix.tex:765-884` | `sald.general_moving_target.kl_derivative`; `thm:general-moving-target-SALD` | obligation |
| Cycle 62 lower scaled residual core | Preserve the source sign and `dot{t}(s)` scaling when the target transport term is combined with the `c_t` drift. | supplied target-transport scaling, c/v pairings, residual pairing `m_t=v_t-c_t`, cycle-57 raw split | `SALD.generalMovingTargetKlDerivativeScaledResidualDisplayScalar`; `SALD.cycle62GuidedGeneralScaledResidualLowerObligation`; `ASTIS.SALD.general_moving_target.cycle62_scaled_residual_lower` | `appendix.tex:813-835` | `sald.general_moving_target.kl_derivative`; `thm:general-moving-target-SALD` | formalized scalar core plus obligation |

Reviewer checklist:

- `SALD.guidedResidualContract` and `SALD.generalVaSaldContract` list
  `SALD.cycle62GuidedGeneralSkeletonObligation` and
  `SALD.cycle62GuidedGeneralSkeletonMiddleObligation` while remaining
  `contractOnly`.
- `SALD.generalVaSaldContract` also lists
  `SALD.cycle62GuidedGeneralScaledResidualLowerObligation`; this is a local
  scalar wrapper, not a promotion of `sald.general_moving_target.kl_derivative`.
- `SALD.saldDependenciesForLabel "prop:guided_path_residual"` and
  `SALD.saldDependenciesForLabel "thm:general-moving-target-SALD"` include
  `cycle62GuidedGeneralDependencyNames`.
- No Gronwall, DV, LSI/KL/FI, Fokker-Planck/KL derivative, guided residual,
  pure-contraction, EM backend, theorem status, source label, source constant,
  or SLT reuse status is promoted.

## Cycle 63 Upper Unified/Discrete General Route

Global phase judgment: cycle 62 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough to rewire
`thm:unified-forward-KL` and
`thm:general-moving-target-SALD-discrete`, then begin exactly one narrow
endpoint-law measure backfill.  The single lower packet that reduces the
largest remaining proof risk is the paired `Measure.map` endpoint-law helper
for the discrete general EM interpolation over `appendix.tex:1354-1387`.

Five slow analytic interfaces checked before lower work:

| Interface | Lean-facing declarations | Status |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallEndpointCalculusContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract` | obligation |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous FP/KL derivative | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.cycle62GuidedGeneralScaledResidualLowerObligation`; `sald.general_moving_target.kl_derivative` | obligation with scalar handoff |
| EM interpolation FP endpoint/conditional-law backend | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation`; `sald.general_moving_target_discrete.em_interpolation_fp` | obligation with local endpoint-law backfill |

The theorem route remains fixed:

| Theorem node | Cycle-63 route | Remaining backend |
|---|---|---|
| `thm:forward-KL` | still through the cycle-60 continuous derivative, LSI, DV, and Gronwall route | continuous FP/KL derivative and side conditions |
| `thm:forward-KL-discrete` | still through the cycle-61 EM, frozen-defect, LSI, DV, Gronwall, and accumulated-error route | EM/FP and accumulated-error obligations |
| `prop:guided_path_residual` | still through normalizer and centered residual identity obligations | guided-density calculus |
| `thm:general-moving-target-SALD` | still through cycle-62 derivative, residual DV, Gronwall, and pure-contraction interfaces | continuous general analytic backends |
| `thm:unified-forward-KL` | through guided residual, `eq:poisson-eq`, correction-field transport bridge, and `thm:general-moving-target-SALD` with `c_t=u_t` | correction-field regularity and specialization obligations |
| `thm:general-moving-target-SALD-discrete` | through general EM endpoint/conditional-FP, frozen-delta, KL derivative/LSI, residual DV, constant-schedule Gronwall, and display stitching | EM conditional-law/FP, derivative, DV, LSI, Gronwall side conditions |

Proof-DAG rows:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 63 global judgment | No cycle-62 recovery; route unified/discrete general; allow one endpoint-law backfill. | cycle-62 guided/general route; cycle-58 unified/discrete route | `ASTIS.SALD.unified_discrete_general.cycle63_global_phase_judgment` | `main_body.tex:359-395`; `appendix.tex:1313-1603` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 63 five-backend check | Recheck Gronwall, DV, LSI/KL/FI, continuous derivative, and EM interpolation interfaces before lower work. | cycle-59 ledger; cycle-62 route; EM endpoint-law handoffs | `ASTIS.SALD.unified_discrete_general.cycle63_five_backend_check` | first-DAG sources plus `appendix.tex:1354-1387` | all six theorem nodes | obligation |
| Cycle 63 upper route | Wire unified forward-KL through continuous general reuse, and discrete general through EM/frozen-delta/LSI/DV/Gronwall interfaces. | guided residual identity; correction-field bridge; continuous general theorem; discrete general side-condition contracts | `SALD.cycle63UnifiedDiscreteGeneralSkeletonObligation`; `ASTIS.SALD.unified_discrete_general.cycle63_upper_route` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 63 middle route audit | Verify the upper route in source order, keep paired endpoint-law bookkeeping scoped, and select the conditional-law/Fokker--Planck backend as the next lower packet. | cycle-63 upper route; cycle-62 guided/general route; paired endpoint-law helper; five slow interfaces | `SALD.cycle63UnifiedDiscreteGeneralMiddleContract`; `SALD.cycle63UnifiedDiscreteGeneralMiddleObligation`; `ASTIS.SALD.unified_discrete_general.cycle63_middle_route_audit` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603`; lower slice `appendix.tex:1358-1387` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete`; cycle 63 lower packet | obligation |
| Cycle 63 paired endpoint-law backfill | From componentwise a.e. endpoint identities, derive equality of paired `Measure.map` pushforward laws on the common space, then recover both marginal endpoint laws by projection. | `AutoSamplingTheory.lawMapEqOfAEEq`; existing endpoint-law handoffs; local SLT Measure.map/a.e. style patterns | `AutoSamplingTheory.lawMapProdEqOfAEEq`; `AutoSamplingTheory.lawMapProdFst`; `AutoSamplingTheory.lawMapProdSnd`; `SALD.generalMovingTargetDiscreteEmJointEndpointMeasureMapOfNamedInterpolation`; `SALD.generalMovingTargetDiscreteEmJointEndpointMarginalLawsOfNamedInterpolation`; `SALD.cycle63UnifiedDiscreteGeneralMeasureBackfillObligation`; `ASTIS.SALD.general_moving_target_discrete.cycle63_joint_endpoint_law_backfill` | `appendix.tex:1354-1357` | `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:general-moving-target-SALD-discrete` | formalized local measure helper plus obligation |

Middle update: `SALD.cycle63UnifiedDiscreteGeneralMiddleContract` maps
`main_body.tex:359-395`, `appendix.tex:949-951`, and
`appendix.tex:1313-1603` in source order.  The paired endpoint-law helper now
has a SALD-level wrapper,
`SALD.generalMovingTargetDiscreteEmJointEndpointMeasureMapOfNamedInterpolation`,
and the lower marginal wrapper
`SALD.generalMovingTargetDiscreteEmJointEndpointMarginalLawsOfNamedInterpolation`,
but the lower packet remains the conditional-law/Fokker--Planck interface:
common probability space, density/absolute-continuity for `hat rho_s` and
`tilde pi_s`, regular conditional drift `bar b_{k,s}`, weak conditional
Fokker--Planck, and KL differentiation over `appendix.tex:1358-1387`.

This cycle does not promote Brownian/EM construction, regular conditional
drift, density/absolute-continuity, weak Fokker-Planck, KL differentiation,
DV, LSI/KL/FI, Gronwall, theorem status, or SLT reuse status.

## Cycle 61 Upper Discrete Forward-KL Recovery

Global phase judgment: cycle 60 passed reviewer/build, so no previous-cycle
failure needs recovery.  Phase 1 theorem-skeleton translation is stable enough
for the interrupted cycle-56 discrete route recovery, but not for broad
cited-theory, SLT, disintegration, or reusable API backfill.  The single lower
packet that best reduces proof risk is
`SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
`SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
`sald.discrete_forward_kl.accumulated_error_bridge`, with the cycle-56
pointwise Gronwall input treated as a supplied interface.

Lean-facing update:

- `SALD.cycle61DiscreteForwardKlSkeletonUpperPacket` records the upper
  objective, mode discipline, non-goals, lower packet, and reviewer checklist.
- `SALD.cycle61DiscreteForwardKlSkeletonObligation`
  (`sald.discrete_forward_kl.cycle61_recovered_theorem_route`) wires
  `main_body.tex:299-323` and `appendix.tex:260-592` through the explicit EM,
  derivative/LSI, DV, Gronwall, and accumulated-error interfaces.
- `SALD.cycle61DiscreteForwardKlSkeletonMiddleContract` and
  `SALD.cycle61DiscreteForwardKlSkeletonMiddleObligation`
  (`sald.discrete_forward_kl.cycle61_middle_route_audit`) verify the recovered
  route in paper order, add the middle obligation to `SALD.discreteSaldContract`,
  and select the accumulated-error bridge rather than any EM, derivative, LSI,
  DV, or already compiled cycle-56 time-change backend.
- `SALD.cycle61DiscreteForwardKlSkeletonDag` adds
  `ASTIS.SALD.forward_KL_discrete.cycle61_global_phase_judgment`,
  `ASTIS.SALD.forward_KL_discrete.cycle61_five_backend_check`,
  `ASTIS.SALD.forward_KL_discrete.cycle61_recovered_theorem_route`,
  `ASTIS.SALD.forward_KL_discrete.cycle61_middle_route_audit`, and
  `ASTIS.SALD.forward_KL_discrete.cycle61_lower_packet.gronwall_accumulated`.

Five slow interfaces remain below `formalized`:

| Backend | Lean-facing route | Status |
|---|---|---|
| Gronwall endpoint/FTC/coefficient interface | `SALD.saldGronwallEndpointCalculusContract`; `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation` | obligation |
| Donsker-Varadhan | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| LSI/KL/FI | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| continuous FP/KL derivative reuse | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.cycle60ForwardKlDerivativeRawLowerObligation` | obligation plus scalar wrapper |
| EM interpolation FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | obligation |

Selected lower packet:

| Source step | Target | Remaining obligation |
|---|---|---|
| `appendix.tex:557-590`: apply Gronwall output to the theorem endpoints and collect residual terms. | `sald.discrete_forward_kl.accumulated_error_bridge` | endpoint stitching, coefficient regularity, endpoint-safe Gronwall, residual exponent, and integral collection |
| `main_body.tex:309-323`: linear slowdown theorem display. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract` plus scalar collection helpers | preserve `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`, `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}` |

No theorem statement, source label, coefficient, theorem status, SLT reuse
status, EM/Fokker--Planck backend, LSI/KL/FI backend, DV backend, Gronwall
backend, or accumulated-error backend is promoted.

Middle synchronization: the source split is now
`appendix.tex:260-385` EM endpoint/conditional-FP interfaces,
`appendix.tex:388-491` cycle-51 derivative/LSI scalar handoff,
`appendix.tex:493-523` discrete DV velocity witness,
`appendix.tex:526-553` cycle-56 pointwise Gronwall input, and
`appendix.tex:557-590` plus `main_body.tex:309-323` accumulated-error display
matching.  Lower should target exactly
`SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
`SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
`sald.discrete_forward_kl.accumulated_error_bridge`; endpoint stitching,
coefficient regularity, residual-exponent control, `barGamma`/`barDelta`
collection, and `A_alpha` collection remain obligations.

## Cycle 58 Upper Unified/Discrete General Route Refresh

Global phase judgment: cycle 57 passed reviewer/build, so no recovery is
needed; Phase 1 is stable enough for a final unified/discrete general route
refresh, but not broad cited-theory backfill; the largest remaining proof risk
is the discrete general Gronwall/display backend feeding
`thm:general-moving-target-SALD-discrete`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 58 upper route refresh | Wire `thm:unified-forward-KL` through guided residual, correction-field transport, and `thm:general-moving-target-SALD`; wire `thm:general-moving-target-SALD-discrete` through EM, frozen-delta, derivative/DV, LSI, and Gronwall interfaces after the cycle-57 pass. | cycle-54 five-backend audit; cycle-55 continuous route; cycle-56 discrete Gronwall recovery; cycle-57 guided/general route; cycle-53 unified/discrete route | `SALD.cycle58UnifiedDiscreteGeneralUpperPacket`; `SALD.cycle58UnifiedDiscreteGeneralSkeletonObligation`; `ASTIS.SALD.unified_discrete_general.cycle58_upper_route` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 58 middle route audit | Check the upper route in paper order and hand off the discrete general Gronwall/display backend. | cycle-58 upper route; cycle-57 guided/general route; cycle-53 derivative/DV scalar handoff; cycle-56 Gronwall recovery pattern; cycle-20 discrete general Gronwall bridge | `SALD.cycle58UnifiedDiscreteGeneralMiddleContract`; `SALD.cycle58UnifiedDiscreteGeneralMiddleObligation`; `ASTIS.SALD.unified_discrete_general.cycle58_middle_route_audit` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603`; lower slice `appendix.tex:1573-1600` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete`; cycle-58 lower packet | obligation |
| Cycle 58 lower packet | Refine `sald.general_moving_target_discrete.gronwall_side_conditions`: endpoint stitching for `K(t)`, constant inverse-schedule coefficient rewrites, Gronwall regularity, and exact matching of `eq:general_moving_target_KL_bound_discrete`. | `SALD.generalMovingTargetDiscreteGronwallInstantiationContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; cycle-20 middle Gronwall bridge; cycle-53 derivative/DV handoff | `ASTIS.SALD.general_moving_target_discrete.cycle58_lower_packet.gronwall_display` | `appendix.tex:1573-1600`; display `appendix.tex:1316-1347` | `sald.general_moving_target_discrete.gronwall_side_conditions`; `thm:general-moving-target-SALD-discrete` | obligation |

Five slow interface status check:

| Interface | Required cycle-58 check | Status |
|---|---|---|
| `lem:gronwall` | Endpoint-safe differentiability/FTC, stitched endpoint laws, coefficient regularity, and exact display matching remain explicit through the discrete general Gronwall contracts. | obligation |
| `lem:dv_variation` | Common-space, absolute-continuity, finite-KL, finite-log-mgf, selected residual test, and alpha-scaling witnesses remain in the DV contracts. | source-cited plus obligations |
| `eq:LSI-KL-FI` | Density, zero-set convention, admissible test, entropy identity, finite KL/FI, and Fisher chain-rule assumptions remain in the LSI/KL/FI bridge. | obligation |
| Continuous KL derivative/Fokker--Planck | The unified theorem consumes the cycle-57 general derivative split and continuous general route; no direct VA-SALD KL proof is added. | obligation |
| EM endpoint/conditional-law Fokker--Planck | Endpoint law handoffs and sigma regrouping are compiled only under explicit hypotheses; conditional law, density/AC, weak FP, KL differentiation, and integration by parts stay open. | obligation |

Lower packet:

Target exactly
`SALD.generalMovingTargetDiscreteGronwallSideConditionContract` /
`SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` /
`sald.general_moving_target_discrete.gronwall_side_conditions` over
`appendix.tex:1573-1600`.

First sub-slice: endpoint/stitching interface for
`K(t)=KL(hat rho_{s(t)}||pi_t)`, including `K(0)`, `K(T)`, interval
compatibility, and constant-schedule admissibility.  Second sub-slice:
coefficient rewrites from `eq:general_KL_derivative_8_discrete` to the theorem
display.  Third sub-slice: Gronwall regularity and display matching.  This is
not a theorem restatement, source-index rebaseline, broad SLT import, or
status promotion.

Reviewer checklist:

- `SALD.unifiedForwardKlContract` and `SALD.generalVaSaldDiscreteContract`
  list `SALD.cycle58UnifiedDiscreteGeneralSkeletonObligation` and
  `SALD.cycle58UnifiedDiscreteGeneralMiddleObligation` while remaining
  `contractOnly`.
- `SALD.generalVaSaldProofDag` and `SALD.generalVaSaldDiscreteProofDag`
  include `ASTIS.SALD.unified_discrete_general.cycle58_upper_route`,
  `ASTIS.SALD.unified_discrete_general.cycle58_middle_route_audit`, and
  `ASTIS.SALD.general_moving_target_discrete.cycle58_lower_packet.gronwall_display`.
- `SALD.saldDependenciesForLabel` for `thm:unified-forward-KL` and
  `thm:general-moving-target-SALD-discrete` includes the cycle-58 packet,
  obligation, DAG, and lower-packet node.
- No theorem statement, source label, source constant, source-file scope, SLT
  reuse status, or slow analytic backend status changes.

Middle synchronization:
`SALD.cycle58UnifiedDiscreteGeneralMiddleContract` and
`SALD.cycle58UnifiedDiscreteGeneralMiddleObligation` now check the cycle-58
upper route against `main_body.tex:359-395`, `appendix.tex:949-951`, and
`appendix.tex:1313-1603`.  The middle audit keeps unified VA-SALD as the
source specialization of the continuous general theorem and keeps the discrete
general theorem on the EM -> frozen-delta -> LSI -> residual-DV -> Gronwall
route.  It adds the middle obligation to `SALD.unifiedForwardKlContract` and
`SALD.generalVaSaldDiscreteContract`, then hands lower work to
`sald.general_moving_target_discrete.gronwall_side_conditions` over
`appendix.tex:1573-1600`.  Endpoint stitching, constant-schedule coefficient
rewrites, coefficient regularity, Gronwall, conditional-law construction,
LSI/KL/FI, DV, and EM Fokker--Planck remain obligations.

## Cycle 57 Upper Guided/General Route Obligations

Global phase judgment: cycle 56 was accepted and does not need recovery.  Phase
1 theorem-skeleton translation is stable for the forward-KL and discrete
forward-KL routes, but broad cited-theory backfill remains premature until
`prop:guided_path_residual` and `thm:general-moving-target-SALD` are rechecked
against `appendix.tex:619-951`.  The single lower packet with the largest risk
reduction is `sald.general_moving_target.kl_derivative` over
`appendix.tex:765-884`.

New Lean-facing obligation:

| Obligation | Source anchor | Depends on | Status |
|---|---|---|---|
| `SALD.cycle57GuidedGeneralSkeletonObligation` / `sald.guided_general.cycle57_upper_route` | `appendix.tex:619-951` | cycle-56 discrete route, cycle-52 guided/general route, guided residual identity, general KL derivative, LSI/KL/FI, residual DV, Gronwall side conditions, downstream EM interface | obligation |
| `SALD.cycle57GuidedGeneralSkeletonMiddleObligation` / `sald.guided_general.cycle57_middle_route_audit` | `appendix.tex:619-951` | cycle-57 upper route, cycle-56 middle route, cycle-52 middle route, guided residual identity, general KL derivative, LSI/KL/FI, residual DV, Gronwall side conditions, pure contraction, unified specialization, downstream EM interface | obligation |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 57 upper route | Recheck guided residual and continuous general theorem skeleton after the clean cycle-56 recovery. | five slow analytic interfaces; cycle-52 guided/general route; cycle-56 discrete route | `SALD.cycle57GuidedGeneralSkeletonUpperPacket`; `SALD.cycle57GuidedGeneralSkeletonObligation`; `ASTIS.SALD.guided_general.cycle57_upper_route` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; `thm:unified-forward-KL` | obligation |
| Cycle 57 middle audit | Check the upper route in source order, wire `prop:guided_path_residual` and `thm:general-moving-target-SALD` to the already named interfaces, and keep the lower packet on the continuous general derivative backend. | cycle-57 upper route; cycle-56 middle route; cycle-52 middle route; guided residual, derivative, LSI, residual DV, Gronwall, pure contraction, unified specialization, EM reuse | `SALD.cycle57GuidedGeneralSkeletonMiddleContract`; `SALD.cycle57GuidedGeneralSkeletonMiddleObligation`; `ASTIS.SALD.guided_general.cycle57_middle_route_audit` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; cycle 57 lower derivative packet | obligation |
| Cycle 57 lower packet | Refine the continuous general Fokker--Planck/KL derivative backend before DV or Gronwall proof search. | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; cycle-52 scalar handoffs; LSI and schedule obligations | `ASTIS.SALD.guided_general.cycle57_lower_packet.general_derivative` | `appendix.tex:765-884` | `sald.general_moving_target.kl_derivative`; `thm:general-moving-target-SALD` | obligation |
| Cycle 57 lower derivative split | Compile the scalar handoff from the raw KL derivative split through the residual derivative display, then feed the existing Young/LSI/time-change scalar pipeline. | supplied mass conservation, Fokker--Planck first-term evaluation, target-transport second-term evaluation, residual identity `m_t=v_t-c_t`, residual Young, LSI, schedule inputs | `SALD.generalMovingTargetKlDerivativeResidualSplitScalar`; `SALD.generalMovingTargetKlDerivativePreDvBoundOfSplitScalar`; `SALD.cycle57GuidedGeneralDerivativeSplitLowerObligation`; `ASTIS.SALD.general_moving_target.cycle57_derivative_split_lower` | `appendix.tex:765-884` | `sald.general_moving_target.kl_derivative`; `thm:general-moving-target-SALD` | formalized scalar core plus obligation |

Remaining analytic obligations for the selected lower packet:

- `appendix.tex:765-812`: law regularity, mass conservation, differentiating
  KL under the integral, the general moving-target Fokker--Planck equation, and
  integration by parts.
- `appendix.tex:813-864`: target transport by `v_t`, rescaled transport of
  `pi_{t(s)}`, residual identification `m_t=v_t-c_t`, and Young's inequality
  with `epsilon=2*dot t(s)/sigma_{t(s)}^2`.
- `appendix.tex:865-884`: LSI/KL/FI handoff, inverse-schedule calculus, sigma
  positivity, and time-change side conditions.
- `appendix.tex:885-945`: residual DV, Gronwall endpoint/exponent side
  conditions, and pure-contraction zero residual remain separate obligations.

Cycle 57 lower refinement: the raw derivative-to-residual-display algebra now
compiles locally.  `SALD.generalMovingTargetKlDerivativeResidualSplitScalar`
starts from a supplied raw derivative split with a zero mass term, the
Fokker--Planck first-term identity, the target-transport second-term identity,
and `residualCross=cDrift-vDrift`, then derives
`dK/ds=-(sigma_t^2/2)*FI+residualCross`.  The wrapper
`SALD.generalMovingTargetKlDerivativePreDvBoundOfSplitScalar` composes this with
the existing scalar Young/LSI/time-change handoff.  This does not close or
promote the analytic Fokker--Planck/KL derivative backend.

Status guard: `SALD.guidedResidualContract` and `SALD.generalVaSaldContract`
remain `contractOnly` and now list the cycle-57 middle audit obligation;
Gronwall, DV, LSI/KL/FI, continuous Fokker--Planck/KL derivative, EM
interpolation, and theorem statuses remain below `formalized`.

## Cycle 56 Upper Discrete Forward-KL Theorem Interface Route

Upper returned to `thm:forward-KL-discrete` for main skeleton sprint 3 after
the cycle-55 continuous forward-KL route.  The Lean-facing additions are
`SALD.cycle56DiscreteForwardKlSkeletonUpperPacket`,
`SALD.cycle56DiscreteForwardKlSkeletonObligation`, and DAG node
`ASTIS.SALD.forward_KL_discrete.cycle56_theorem_interface_route`.

Five-backend check before the lower packet:

| Backend | Discrete theorem consumer | Status |
|---|---|---|
| endpoint-safe Gronwall | `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation` | obligation |
| Donsker--Varadhan | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| LSI/KL/FI | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| continuous derivative reuse | `SALD.forwardKlDerivativeSideConditionContract`; cycle-55 mass handoff | scalar/workflow data only; analytic backend remains obligation |
| EM interpolation Fokker--Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | source-cited obligation interface, not reproved |

Source-to-Lean route:

| Source window | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:299-323` | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract`; `SALD.cycle56DiscreteForwardKlSkeletonObligation` | theorem stays `contractOnly`; constants unchanged |
| `appendix.tex:260-385` | EM endpoint laws, conditional drift density, conditional-FP, Laplacian split, and stitched interval interfaces | Brownian/EM law construction, conditional law, density/AC, weak FP, and endpoint stitching |
| `appendix.tex:388-491` | `SALD.discreteForwardKlDerivativeCandidateContract`; cycle-51 scalar handoff; frozen-defect and LSI contracts | KL derivative analytic backend, frozen-defect specialization, LSI density-test |
| `appendix.tex:493-523` | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_velocity_bound` | common-space, AC, finite log-mgf, source-cited DV |
| `appendix.tex:526-592` | `SALD.discreteForwardKlGronwallInstantiationContract`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract` | selected lower backend: Gronwall accumulation, endpoint stitching, residual exponent, `barGamma`/`barDelta` collection |

Lower packet: target exactly `SALD.discreteForwardKlGronwallInstantiationContract`
/ `SALD.discreteForwardKlGronwallAccumulationObligation` /
`sald.discrete_forward_kl.gronwall_accumulation` over `appendix.tex:526-592`.
Use the existing derivative and DV interfaces as inputs; do not prove the
EM/Fokker--Planck theorem from scratch.  The accumulated-error bridge remains
the downstream interface to the main-body display.

No theorem statement, source coefficient, source label, theorem status, SLT
reuse status, or analytic backend status is promoted or changed.

Middle synchronization adds
`SALD.cycle56DiscreteForwardKlSkeletonMiddleContract`,
`SALD.cycle56DiscreteForwardKlSkeletonMiddleObligation`, and DAG node
`ASTIS.SALD.forward_KL_discrete.cycle56_middle_route_audit`.  It verifies the
upper route in source order, adds the middle obligation to
`SALD.discreteSaldContract`, and keeps the selected lower packet at
`sald.discrete_forward_kl.gronwall_accumulation` over `appendix.tex:526-592`.
The derivative and DV outputs are inputs to that lower packet; EM conditional
Fokker--Planck, LSI/KL/FI, DV common-space, endpoint stitching, residual
exponent, and accumulated-error collection remain separate obligations.

Lower recovery adds
`SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`,
`SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged`,
`SALD.cycle56DiscreteForwardKlGronwallLowerObligation`, and DAG node
`ASTIS.SALD.forward_KL_discrete.cycle56_gronwall_lower`.  The compiled scalar
core starts only after the source-cited derivative/DV inputs are supplied and
now includes the pointwise-in-`t` Gronwall-input wrapper for
`appendix.tex:526-553`:
`dot{s}*C_LSI - dot{s}^(-1)*alpha^(-1)
- 2*dot{s}*eta^2*alpha'^(-1)*Gamma` and residual
`dot{s}^(-1)*E_alpha + 2*dot{s}*eta*Delta`.  It does not prove or promote
EM/Fokker--Planck, KL differentiation, frozen-defect, LSI/KL/FI, DV,
Gronwall, endpoint stitching, residual-exponent, or accumulated-error
backends.

Updated proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 56 middle route audit | Verify the upper discrete theorem route, keep EM/Fokker--Planck as named source-cited interfaces, and choose the appendix Gronwall accumulation backend for lower work. | cycle-56 upper route; cycle-54 analytic audit; cycle-55 continuous route; cycle-51 derivative lower; EM, LSI, DV, Gronwall, and accumulated-error obligations | `SALD.cycle56DiscreteForwardKlSkeletonMiddleContract`; `SALD.cycle56DiscreteForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle56_middle_route_audit` | `main_body.tex:299-323`; `appendix.tex:260-592`; lower slice `appendix.tex:526-592` | `thm:forward-KL-discrete`; cycle 56 lower Gronwall packet | obligation |
| Cycle 56 lower Gronwall time-change handoff | Compile the real-order post-DV `s`-to-`t` handoff and pointwise Gronwall-input wrapper that produce the source `a(t)` and `b(t)` before invoking `lem:gronwall`. | cycle-56 middle route; cycle-51 derivative lower; discrete DV velocity witness; inverse-schedule side conditions; Gronwall accumulation obligation | `SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`; `SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged`; `SALD.cycle56DiscreteForwardKlGronwallLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle56_gronwall_lower` | `appendix.tex:526-553` | `sald.discrete_forward_kl.gronwall_accumulation`; `thm:forward-KL-discrete` | formalized scalar core plus obligation |

## Cycle 55 Lower Continuous Forward-KL Mass-Conservation Scalar Handoff

Lower performed one proof-producing Lean step on the selected
`sald.forward_kl.kl_derivative` backend before adding this ledger row.  The
new compiled scalar theorems are:

- `SALD.forwardKlMassConservationDropScalar`;
- `SALD.forwardKlMassConservationFirstTermFisherScalar`.

Source map:

| Source line window | Supplied interface input | Compiled scalar output | Still open |
|---|---|---|---|
| `appendix.tex:168-174` | The KL derivative backend supplies a raw split `dK = firstTerm + massTerm + targetTerm`, and mass conservation supplies `massTerm = 0`. | `SALD.forwardKlMassConservationDropScalar` gives `dK = firstTerm + targetTerm`. | Differentiation under the integral and proof of `int partial_s rho_s dx = 0`. |
| `appendix.tex:176-185` | The SALD Fokker--Planck and integration-by-parts backend supplies `firstTerm = -FI`. | `SALD.forwardKlMassConservationFirstTermFisherScalar` gives `dK = -FI + targetTerm`. | Fokker--Planck equation, boundary/no-flux integration by parts, and FI identification. |

Synchronization:

- workflow obligation:
  `SALD.cycle55ForwardKlDerivativeMassLowerObligation` /
  `sald.forward_kl.cycle55_derivative_mass_lower`;
- proof-DAG node:
  `ASTIS.SALD.forward_KL.cycle55_derivative_mass_lower`.

This does not close `sald.forward_kl.kl_derivative`, change `thm:forward-KL`,
or promote any analytic backend.  LSI/KL/FI, DV finite-log-mgf, Gronwall,
target transport, and inverse-schedule steps remain separate obligations.

## Cycle 54 Analytic Interface Re-Check

Upper repeated the sprint-1 analytic-interface check after the theorem route
was wired through cycles 50-53.  The new Lean-facing route data are
`SALD.cycle54MainSkeletonAnalyticInterfaceLedger`,
`SALD.cycle54MainSkeletonAnalyticInterfaceObligation`,
`SALD.cycle54MainSkeletonAnalyticMiddleContract`,
`SALD.cycle54MainSkeletonAnalyticMiddleObligation`, and DAG nodes
`ASTIS.SALD.cycle54.analytic_interface_recheck` and
`ASTIS.SALD.cycle54.middle_interface_audit`.

Five-interface status:

| Backend | Lean-facing interface | Status |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.saldGronwallExponentRewriteContract`; cycle-36/41 local wrappers | obligation; endpoint-safe differentiability/FTC and theorem-side regularity remain open |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; theorem-specific finite-log-mgf witnesses | source-cited; common space, absolute continuity, finite KL, measurability, and finite log-mgf stay explicit |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; cycle-43 density/entropy and Fisher-chain helpers | obligation; zero-set, admissible test or approximation, entropy identity, and Fisher chain rule remain open |
| Continuous Fokker--Planck/KL derivative | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.generalMovingTargetDerivativeCandidateContract`; cycle-50/52 scalar handoffs | obligation; density, boundary, integration-by-parts, and schedule calculus remain open |
| EM interpolation Fokker--Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation`; `SALD.generalMovingTargetDiscreteConditionalFpSigmaLaplacianSplitHandoff` | obligation with formalized endpoint-law congruence and formalized sigma-weighted divergence regrouping only; conditional drift, density/AC, weak FP, KL differentiation, and integration by parts remain open |

Theorem-route synchronization:

| Theorem node | Cycle-54 route role |
|---|---|
| `thm:forward-KL` | consumes continuous derivative, LSI, DV velocity, endpoint schedule, and Gronwall side conditions |
| `thm:forward-KL-discrete` | consumes EM conditional-FP, frozen defect, LSI, DV velocity, stitched Gronwall, and accumulated-error interfaces |
| `prop:guided_path_residual` | stays on normalizer derivative, guided-path differentiation, divergence cancellation, and mean-zero residual obligations |
| `thm:general-moving-target-SALD` | consumes continuous general derivative, residual LSI/DV, sigma-weighted Gronwall, and pure-contraction obligations |
| `thm:unified-forward-KL` | remains the source specialization of the continuous general theorem through the correction-field transport bridge |
| `thm:general-moving-target-SALD-discrete` | consumes general EM endpoint/conditional-FP, frozen delta, discrete KL derivative/LSI, residual DV, constant-schedule time change, and Gronwall stitching |

Middle synchronization:

- `SALD.cycle54MainSkeletonAnalyticMiddleObligation` is listed by all six
  theorem contracts while each theorem remains `contractOnly`.
- `SALD.cycle54MainSkeletonAnalyticInterfaceDag` now includes
  `ASTIS.SALD.cycle54.middle_interface_audit` between the upper re-check and
  the lower packet, plus
  `ASTIS.SALD.general_moving_target_discrete.cycle54_em_fp_sigma_split` for
  the proof-producing appendix.tex:1380-1387 regrouping.
- The lower target remains exactly
  `SALD.generalMovingTargetDiscreteDerivativeCandidateContract` /
  `SALD.generalMovingTargetDiscreteDerivativeObligation` /
  `sald.general_moving_target_discrete.kl_derivative` over
  `appendix.tex:1354-1387`.

Lower packet: target exactly
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract`,
`SALD.generalMovingTargetDiscreteDerivativeObligation`, and
`sald.general_moving_target_discrete.kl_derivative` over
`appendix.tex:1354-1387`.  Use
`SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation`
only as endpoint-law bookkeeping and
`SALD.generalMovingTargetDiscreteConditionalFpSigmaLaplacianSplitHandoff`
only as divergence algebra, then expose common space, density/absolute
continuity, regular conditional drift, weak conditional Fokker--Planck, KL
differentiation, and integration-by-parts assumptions.

Cycle 54 lower proof-producing increment:

| Lean declaration | Source role | Still open |
|---|---|---|
| `SALD.generalMovingTargetDiscreteConditionalFpSigmaLaplacianSplitHandoff` | If `partial_s hat rho_s = -div(hat rho_s*bar b)+(sigma_eta^2/2)*Delta hat rho_s`, `Delta hat rho_s = div(hat rho_s*A_s)+div(hat rho_s*nabla log tilde pi_s)`, and divergence is additive/linear, derive the regrouped display in appendix.tex:1380-1387. | It does not prove common-space construction, the regular conditional drift, density/absolute continuity, weak FP, KL differentiation, mass conservation, integration by parts, or endpoint stitching. |
| `SALD.cycle54GeneralMovingTargetDiscreteEmFpLowerObligation` | Records that the compiled theorem is a lower algebra slice under explicit analytic hypotheses for `sald.general_moving_target_discrete.em_interpolation_fp` and `sald.general_moving_target_discrete.kl_derivative`. | The analytic backend remains obligation-level. |

No theorem statement, source coefficient, source label, theorem status, SLT
reuse status, or analytic backend status is changed.

## Cycle 53 Unified And Discrete General Route

Upper closed the sprint-5 theorem-route wiring for the two remaining
downstream skeletons.  The new Lean-facing route data are
`SALD.cycle53UnifiedDiscreteGeneralUpperPacket`,
`SALD.cycle53UnifiedDiscreteGeneralSkeletonObligation`, and DAG node
`ASTIS.SALD.unified_discrete_general.cycle53_upper_route`.

Middle synchronized that upper route with the conversion window, theorem
contracts, proof DAG, and lower packet.  The added Lean-facing middle data are
`SALD.cycle53UnifiedDiscreteGeneralMiddleContract`,
`SALD.cycle53UnifiedDiscreteGeneralMiddleObligation`, and DAG node
`ASTIS.SALD.unified_discrete_general.cycle53_middle_route_audit`.

Theorem-level route:

| Source window | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:359-395`, `appendix.tex:949-951` | `SALD.unifiedForwardKlContract`; `SALD.unifiedForwardKlSpecializationContract`; `SALD.cycle52GuidedGeneralSkeletonObligation`; `SALD.cycle52GuidedGeneralSkeletonMiddleObligation`; `SALD.cycle52GuidedGeneralDerivativeDvLowerObligation` | unified theorem stays `contractOnly`; correction-field transport bridge, pure-contraction specialization, and continuous general analytic backends remain obligations |
| `appendix.tex:1313-1353` | `SALD.generalVaSaldDiscreteContract`; `SALD.generalMovingTargetDiscreteConstantScheduleObligation`; `SALD.generalMovingTargetDiscreteGronwallInstantiationContract` | theorem display and constant-schedule stitching stay obligation-level |
| `appendix.tex:1354-1387` | `SALD.generalMovingTargetDiscreteEmInterpolationObligation`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation` | endpoint laws now have a compiled `Measure.map` handoff, but conditional drift, density/AC, weak FP, and KL derivative regularity remain obligations |
| `appendix.tex:1469-1511` | `SALD.generalMovingTargetDiscreteDerivativeCandidateContract`; `SALD.generalMovingTargetDiscreteDerivativeObligation`; cycle-28 frozen/residual algebra; `SALD.generalMovingTargetDiscretePostYoungDerivativeBoundScalar` | analytic field identifications, Young/FI inputs, and frozen-delta proof remain obligations; the scalar two-Young Fisher budget now compiles in the cycle-53 lower handoff |
| `appendix.tex:1513-1552` | `SALD.saldLsiKlFiDensityTestContract`; `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDiscreteDvMEnergyObligation`; `SALD.generalMovingTargetDiscretePostLsiDerivativeBoundScalar`; `SALD.generalMovingTargetDiscretePostDvDerivativeBoundScalar` | LSI density-test, finite-log-mgf witness, common-space/AC, and source-cited DV remain obligations; scalar coefficient handoff now compiles after those inputs are supplied |
| `appendix.tex:1573-1603` | `SALD.generalMovingTargetDiscreteTimeChangedDerivativeBoundScalar`; `SALD.generalMovingTargetDiscreteDerivativeDvTimeChangedScalar`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `SALD.generalMovingTargetDiscreteGronwallApplicationObligation`; `SALD.discreteUnifiedVaSaldSpecializationObligation` | constant-schedule analytic identity and Gronwall endpoint/exponent side conditions remain obligations; scalar time-change coefficient rewriting now compiles under explicit hypotheses |

Middle route audit:

| Lean-facing audit | Source role | Lower handoff |
|---|---|---|
| `SALD.cycle53UnifiedDiscreteGeneralMiddleContract` | verifies `main_body.tex:359-395`, `appendix.tex:949-951`, and `appendix.tex:1313-1603` in paper order after the upper route packet | keep `SALD.generalMovingTargetDiscreteDerivativeCandidateContract` / `SALD.generalMovingTargetDiscreteDerivativeObligation` / `sald.general_moving_target_discrete.kl_derivative` as the next lower target |
| `SALD.cycle53UnifiedDiscreteGeneralMiddleObligation` | records that the unified theorem remains a specialization of the continuous general theorem, and the discrete general theorem remains the EM/frozen-delta/LSI/DV/Gronwall route | first lower sub-slice is still `appendix.tex:1354-1387`: common space, density/AC, regular conditional drift, weak conditional Fokker--Planck, KL differentiation, and integration by parts |
| `ASTIS.SALD.unified_discrete_general.cycle53_middle_route_audit` | proof-DAG node reused by both downstream theorem contracts | no theorem statement, coefficient, alpha range, sigma factor, or backend status is changed |

Narrow measure-theory backfill:

| Compiled declaration | Source role | Still open |
|---|---|---|
| `AutoSamplingTheory.lawMapEqOfAEEq` | generic `Measure.map` congruence from an a.e. endpoint identity | no stochastic law construction or density backend |
| `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation` | applies the pointwise EM interpolation endpoint identities to named endpoint laws in `appendix.tex:1354-1387` | regular conditional drift, common probability space, density/absolute-continuity, weak conditional Fokker--Planck, and KL derivative |
| `ASTIS.SALD.general_moving_target_discrete.cycle53_measure_map_endpoint_backfill` | records the backfill as a formalized endpoint-law handoff in the proof DAG | theorem statements and analytic backend statuses are unchanged |

Lower scalar handoff:

| Compiled declaration | Source role | Still open |
|---|---|---|
| `SALD.generalMovingTargetDiscretePostYoungDerivativeBoundScalar` | combines the supplied derivative display with the residual and frozen-delta Young bounds, leaving `-(sigma_eta^2/4)*FI` | EM conditional-FP/KL differentiation, field identifications, Young analytic estimates, and frozen-delta theorem |
| `SALD.generalMovingTargetDiscretePostLsiDerivativeBoundScalar` | converts the remaining Fisher term using the supplied half-Fisher LSI comparison | full `eq:LSI-KL-FI` density-test backend and finite KL/FI interfaces |
| `SALD.generalMovingTargetDiscretePostDvDerivativeBoundScalar` | substitutes the supplied residual DV estimate and preserves the doubled residual coefficient | DV common-space/AC, finite log-mgf witness, measurability, and source-cited DV |
| `SALD.generalMovingTargetDiscreteTimeChangedDerivativeBoundScalar` | multiplies the `s`-time inequality by `dot{s}(t)` and rewrites `dot t(s(t))^2` under the constant inverse schedule | analytic schedule calculus and stitched regularity |
| `SALD.generalMovingTargetDiscreteDerivativeDvTimeChangedScalar` | composes the scalar route to the exact t-time pre-Gronwall inequality used by `thm:general-moving-target-SALD-discrete` | Gronwall, endpoint matching, and all analytic inputs above |
| `ASTIS.SALD.general_moving_target_discrete.cycle53_derivative_dv_lower` | DAG node recording this as a lower proof-producing handoff for `sald.general_moving_target_discrete.kl_derivative` | theorem remains `contractOnly`; analytic backends remain obligations/source-cited |

Five-interface check:

- `lem:gronwall` remains endpoint-safe real-analysis obligation data.
- `lem:dv_variation` remains source-cited through the selected-test/common-space
  interface.
- `eq:LSI-KL-FI` remains a density-test, zero-set, entropy, and Fisher-chain
  obligation.
- The continuous forward-KL/general KL derivative identities remain local
  Fokker--Planck/KL derivative obligations with compiled scalar handoffs only.
- The Euler--Maruyama interpolation backend remains obligation-level; cycle 53
  adds only the `Measure.map` endpoint-law congruence after named interpolation
  identities are supplied.

Next lower packet after this scalar handoff: return to exactly
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract`,
`SALD.generalMovingTargetDiscreteDerivativeObligation`, and
`sald.general_moving_target_discrete.kl_derivative` over
`appendix.tex:1354-1387` first.  Consume
`SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation`
only as endpoint-law bookkeeping, then expose regular conditional drift,
measurability/integrability, density/absolute-continuity, common-space, and weak
conditional Fokker--Planck assumptions as obligations.

No theorem statement, source coefficient, source label, theorem status, SLT
reuse status, or analytic backend status is promoted or changed.

## Cycle 52 Lower General Moving-Target Derivative/DV Scalar Handoff

Lower added the proof-producing scalar core for the selected
`sald.general_moving_target.kl_derivative` route after the cycle-52 upper and
middle route audits:
`SALD.generalMovingTargetPostDvGronwallCoefficientScalar`,
`SALD.generalMovingTargetPostDvGronwallCoefficientOfSigmaScheduleScalar`, and
`SALD.generalMovingTargetDerivativeDvGronwallCoefficientScalar`.

Source map:

| Source line window | Supplied interface input | Compiled scalar output | Still open |
|---|---|---|---|
| `appendix.tex:765-884` | General KL derivative backend supplies the pre-DV bound after Fokker--Planck, residual Young, LSI, and the s-to-t schedule handoff. | consumed as hypothesis by `SALD.generalMovingTargetDerivativeDvGronwallCoefficientScalar` through `SALD.generalMovingTargetPreDvDerivativeBoundScalar` | density/law regularity, mass conservation, Fokker--Planck, target transport, integration by parts, schedule calculus |
| `appendix.tex:885-895` | Residual DV gives `alpha*||m_t||^2 <= K(t)+log E_{pi_t} exp(alpha||m_t||^2)`. | positive-alpha scalar division and coefficient preservation are handled by the new post-DV helpers | common-space, absolute-continuity, finite-KL/log-likelihood, measurability, finite log-mgf, source-cited DV |
| `appendix.tex:897-907` | `E_alpha(pi_t,m_t)=alpha^(-1) log E_{pi_t} exp(alpha||m_t||^2)` and coefficient `sigma_t^(-2)*dot{s}(t)^(-1)` are supplied. | `dK/dt <= -(((sigma_t^2/2)*dot{s}(t)*C_LSI(t)-sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1))*K(t)) + sigma_t^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)` | Gronwall endpoint/exponent side conditions and pure-contraction specialization |

`SALD.cycle52GuidedGeneralDerivativeDvLowerObligation` records that this is
only Real/order coefficient bookkeeping after analytic interfaces are supplied.
No theorem statement, source constant, source label, theorem status, SLT reuse
status, or analytic backend status is changed.

## Cycle 51 Upper Discrete Forward-KL Interface Route

Upper returned to `thm:forward-KL-discrete` for main skeleton sprint 3 after
the cycle 50 continuous derivative/DV scalar handoff.  The new Lean-facing
route data are `SALD.cycle51DiscreteForwardKlSkeletonUpperPacket`,
`SALD.cycle51DiscreteForwardKlSkeletonObligation`, and DAG node
`ASTIS.SALD.forward_KL_discrete.cycle51_theorem_interface_route`.

Source windows:

| Source window | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:299-323` | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract`; `SALD.cycle51DiscreteForwardKlSkeletonObligation` | theorem stays `contractOnly`; constants unchanged |
| `appendix.tex:260-385` | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_endpoint_laws`; `sald.discrete_forward_kl.em_conditional_fokker_planck`; `sald.discrete_forward_kl.em_interpolation_fp` | endpoint laws, conditional drift density, density/AC, weak conditional FP, stitched intervals |
| `appendix.tex:388-491` | `SALD.discreteForwardKlDerivativeCandidateContract`; `sald.discrete_forward_kl.kl_derivative`; `SALD.frozenDeltaCrossLipSaldContract`; `SALD.saldLsiKlFiDensityTestContract` | KL derivative inputs, frozen-defect specialization, LSI density-test |
| `appendix.tex:493-523` | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_finite_log_mgf_witness`; `sald.discrete_forward_kl.dv_velocity_bound` | common-space, AC, measurability, finite log-mgf, source-cited DV |
| `appendix.tex:526-592` | `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract` | Gronwall, endpoint rewrites, residual exponent, `barGamma`/`barDelta` collection |

Five-interface check:

- `lem:gronwall` remains endpoint-safe real-analysis obligation data.
- `lem:dv_variation` remains source-cited through the selected-test/common-space
  interface.
- `eq:LSI-KL-FI` remains a density-test/Fisher-chain obligation.
- Continuous derivative reuse is only the cycle 50 scalar handoff after its
  analytic inputs are supplied.
- EM interpolation Fokker--Planck is used as an explicit source-cited
  interface and is not reproved in this cycle.

Lower packet: target exactly
`SALD.discreteForwardKlDerivativeCandidateContract` /
`SALD.discreteForwardKlDerivativeObligation` /
`sald.discrete_forward_kl.kl_derivative` over `appendix.tex:334-491`.
The first lower sub-slice should consume the existing EM endpoint and
conditional-Fokker--Planck interfaces from `appendix.tex:334-385` as inputs to
the KL derivative identity.  Do not add assumptions to the theorem statement;
refine named EM, density, absolute-continuity, or stitched-interval
obligations if a backend is missing.

## Cycle 51 Middle Discrete Forward-KL Derivative Route Audit

Middle synchronized the cycle 51 upper route into
`SALD.cycle51DiscreteForwardKlSkeletonMiddleContract`,
`SALD.cycle51DiscreteForwardKlSkeletonMiddleObligation`, and DAG node
`ASTIS.SALD.forward_KL_discrete.cycle51_middle_route_audit`.

The theorem statement and constants in `main_body.tex:299-323` remain unchanged.
The selected lower backend is exactly
`SALD.discreteForwardKlDerivativeCandidateContract` /
`SALD.discreteForwardKlDerivativeObligation` /
`sald.discrete_forward_kl.kl_derivative` over `appendix.tex:334-491`.
The first lower slice must use `appendix.tex:334-385` endpoint laws,
conditional drift, conditional-Fokker--Planck, and Laplacian split as named
interfaces.  It must not attempt to prove the EM/Fokker--Planck theorem from
scratch in this cycle.

Source-to-Lean split:

| Source window | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:334-385` | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_endpoint_laws`; `sald.discrete_forward_kl.conditional_drift_density`; `sald.discrete_forward_kl.em_conditional_fokker_planck`; `sald.discrete_forward_kl.em_interpolation_fp` | endpoint law representations, regular conditional drift, density/AC, weak FP, boundary and stitched-interval hypotheses |
| `appendix.tex:388-452` | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.discreteForwardKlDerivativeObligation` | KL derivative under the integral, EM-FP integration by parts, target transport term, density/boundary regularity |
| `appendix.tex:454-491` | `SALD.frozenDeltaCrossLipSaldContract`; `sald.discrete_forward_kl.frozen_delta_cross_lip`; `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | frozen-defect specialization, LSI density-test and Fisher-chain backend |
| `appendix.tex:493-523` | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_velocity_bound` | separate DV/common-space/finite-log-mgf witness |
| `appendix.tex:526-592` | `SALD.discreteForwardKlGronwallInstantiationContract`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract` | separate Gronwall, endpoint stitching, residual exponent, and accumulated-error collection |

No analytic backend, theorem status, source label, theorem assumption, SLT reuse
status, or source coefficient is promoted or changed.

## Cycle 51 Lower Discrete Forward-KL Derivative Scalar Handoff

Lower added the proof-producing scalar core for the selected
`sald.discrete_forward_kl.kl_derivative` backend:
`SALD.discreteForwardKlPostLsiDerivativeBoundScalar` and
`SALD.discreteForwardKlPostLsiDerivativeBoundOfKlFiScalar`.

Source map:

| Source line window | Supplied interface input | Compiled scalar output | Still open |
|---|---|---|---|
| `appendix.tex:388-452` | EM conditional-FP/KL derivative backend supplies `dK=-FI+frozenCross+movingCross`. | consumed as hypothesis by `SALD.discreteForwardKlPostLsiDerivativeBoundScalar` | density, boundary integration by parts, target transport identity |
| `appendix.tex:454-467` | `lem:frozen_delta_cross_lip_sald` supplies the first `(1/4)*FI` plus `2*eta^2*alpha'^(-1)*Gamma*K` and `2*eta*Delta`. | coefficient is preserved exactly in the scalar handoff | SALD specialization of the later general frozen-defect lemma |
| `appendix.tex:469-479` | Young supplies the moving `(1/4)*FI + ||tilde v_s||^2` bound. | second quarter-FI is combined with the frozen share | analytic Cauchy/Young/L2 identification if not already supplied |
| `appendix.tex:482-491` | `eq:LSI-KL-FI` supplies `C_LSI*K <= (1/2)*FI`. | `dK <= -(C_LSI-2*eta^2*alpha'^(-1)*Gamma)*K + ||tilde v_s||^2 + 2*eta*Delta` | density-test, entropy identity, Fisher chain rule |

`SALD.cycle51DiscreteForwardKlDerivativeLowerObligation` records that this is
only the scalar lower handoff.  EM conditional-Fokker--Planck, KL
differentiation, frozen-defect specialization, LSI/KL/FI, DV velocity, and
Gronwall remain separate obligations.

## Cycle 50 Upper Continuous Forward-KL Post-Readiness Route

Upper returned to the cycle focus after the cycle-49 global readiness audit:
wire `thm:forward-KL` itself through the explicit source-cited interfaces, not
through a new theorem statement or isolated scalar lemma.

Lean-facing update:

- `SALD.cycle50ForwardKlSkeletonUpperPacket` records the upper objective,
  mode discipline, non-goals, lower packet, and reviewer checklist.
- `SALD.cycle50ForwardKlSkeletonObligation`
  (`sald.forward_kl.cycle50_theorem_skeleton_route`) consumes the cycle-49
  readiness ledger and cycle-45 theorem wrapper.
- `SALD.cycle50ForwardKlSkeletonDag` adds
  `ASTIS.SALD.forward_KL.cycle50_theorem_skeleton_route`.

Source-to-Lean route:

| Source block | Consumed interface | Remaining status |
|---|---|---|
| `main_body.tex:238-247` theorem display | `SALD.continuousForwardKlStatementContract`; `SALD.continuousSaldContract` | `contractOnly`; no source assumption or coefficient changed |
| `appendix.tex:168-228` derivative/Fokker--Planck block | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `sald.forward_kl.kl_derivative` | obligation |
| `main_body.tex:202-215` LSI/KL/FI bridge | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| `appendix.tex:230-241` DV velocity-energy step | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `sald.forward_kl.dv_energy_bound` | source-cited DV plus obligations |
| `appendix.tex:244-252` Gronwall display | `SALD.saldGronwallEndpointCalculusContract`; `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract` | obligation |
| downstream discrete sibling backend | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | obligation, not used to alter continuous theorem |

Lower packet: if continuous forward-KL proof-producing work resumes, target
exactly `SALD.forwardKlDerivativeCandidateContract` /
`SALD.forwardKlDerivativeObligation` / `sald.forward_kl.kl_derivative` over
`appendix.tex:168-228`.  Keep DV, LSI/KL/FI, Gronwall endpoint conditions, and
EM interpolation as separate named interfaces unless their exact analytic
backends compile locally.

No theorem statement, source coefficient, source label, theorem status, SLT
reuse status, or analytic backend status was changed.

## Cycle 50 Lower Continuous Forward-KL Derivative/DV Scalar Handoff

Lower performed one proof-producing Lean step before adding ledger text.  The
new theorem
`SALD.forwardKlDerivativeDvGronwallCoefficientOfKlFiVelocityScalingScalar`
bridges `appendix.tex:168-241`: it takes the explicit analytic premises from
the selected `sald.forward_kl.kl_derivative` route, the source KL/FI comparison,
the inverse-schedule velocity scaling, and the selected-test DV estimate, then
derives the pre-Gronwall differential inequality

`dK/dt <= -(dot{s}*C_LSI - (1/2)*dot{s}^(-1)*alpha^(-1))*K
  + (1/2)*dot{s}^(-1)*E_alpha`.

Lean synchronization:

- compiled scalar theorem:
  `SALD.forwardKlDerivativeDvGronwallCoefficientOfKlFiVelocityScalingScalar`;
- workflow obligation:
  `SALD.cycle50ForwardKlDerivativeLowerObligation` /
  `sald.forward_kl.cycle50_derivative_dv_lower`;
- proof-DAG node:
  `ASTIS.SALD.forward_KL.cycle50_derivative_dv_lower`.

Remaining obligations:

- density/law regularity, mass conservation, KL differentiation under the
  integral, SALD Fokker--Planck, and integration by parts;
- source `eq:LSI-KL-FI` density-test backend;
- inverse-function calculus and L2 velocity scaling backend;
- common-space/absolute-continuity, finite-log-mgf, measurability, and the
  source-cited DV theorem;
- Gronwall side conditions and the theorem-level `thm:forward-KL` contract.

No theorem statement, coefficient, source label, theorem status, SLT reuse
status, or analytic backend status is changed.
## Cycle 64 Upper Analytic Interface Ledger

Upper synchronized the analytic-interface sprint after the accepted cycle-63
reviewer gate.  There is no failed previous cycle to recover.  Phase 1 is
stable enough for one narrow backend backfill, but not for broad cited-theory,
SLT, disintegration, or reusable API work.  The selected lower packet is the
EM interpolation conditional-law/Fokker--Planck backend over
`appendix.tex:1358-1387`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 64 analytic interface ledger | workflow obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-252`, `appendix.tex:1358-1387` | `SALD.cycle64MainSkeletonAnalyticInterfaceLedger`, `SALD.cycle64MainSkeletonAnalyticInterfaceObligation`, `SALD.cycle64MainSkeletonAnalyticInterfaceDag` |
| Cycle 64 theorem-route wiring | obligation | `appendix.tex:164-1603`; source theorem route order fixed | `ASTIS.SALD.cycle64.theorem_route_rewire`; all six theorem contracts list `SALD.cycle64MainSkeletonAnalyticInterfaceObligation` while remaining `contractOnly` |
| Cycle 64 middle interface audit | obligation | `appendix.tex:1358-1387`; source theorem route order fixed | `SALD.cycle64MainSkeletonAnalyticMiddleContract`, `SALD.cycle64MainSkeletonAnalyticMiddleObligation`, `ASTIS.SALD.cycle64.middle_interface_audit`; all six theorem contracts list the middle obligation while remaining `contractOnly` |
| Cycle 64 selected lower packet | obligation | `appendix.tex:1358-1387` | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`, `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`, `sald.general_moving_target_discrete.em_interpolation_fp`, `ASTIS.SALD.cycle64.lower_packet.general_discrete_em_conditional_fp` |

Five backend status check:

| Backend | Current route | Status discipline |
|---|---|---|
| Gronwall | endpoint-safe calculus and exponent interfaces plus cycle-36/41 wrappers | `lem:gronwall` remains obligation |
| DV | Boucheron source-cited formula plus common-space/finite-log-mgf selected-test witnesses | `lem:dv_variation` remains source-cited plus obligations |
| LSI/KL/FI | density-test, zero-set, entropy identity, admissibility, and Fisher-chain interfaces | `eq:LSI-KL-FI` remains obligation |
| Continuous FP/KL derivative | continuous forward-KL and general moving-target derivative candidate/side-condition interfaces | analytic derivative backends remain obligations |
| EM interpolation FP | endpoint-law Measure.map helpers are local only; conditional drift, density/AC, weak FP, KL differentiation, and stitching remain open | EM conditional-FP remains obligation |

No theorem statement, source constant, source label, theorem status, SLT reuse
status, or analytic backend status changed.

## Cycle 64 Middle Analytic Interface Audit

Middle added `SALD.cycle64MainSkeletonAnalyticMiddleContract` and
`SALD.cycle64MainSkeletonAnalyticMiddleObligation`
(`sald.main_skeleton.cycle64_middle_interface_audit`) as an obligation-level
source-to-Lean audit below the upper ledger.  It is now referenced by all six
theorem contracts through `SALD.cycle64MainSkeletonDependencyNames` and DAG node
`ASTIS.SALD.cycle64.middle_interface_audit`.

Source-to-Lean split for the selected lower packet:

| Source window | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:1358-1366` | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation` | endpoint-safe KL differentiation, `int partial_s hat rho_s dx = 0`, density/absolute-continuity of `hat rho_s` and `tilde pi_s`, finite KL on the interpolation interval |
| `appendix.tex:1368-1377` | `sald.general_moving_target_discrete.em_interpolation_fp` conditional drift interface | regular conditional law of `X_k^eta` given `hat X_s=x`, measurability, integrability of `dot t_k c_{t_k}` and `(sigma_eta^2/2) nabla log pi_{t_k}` under the conditioning |
| `appendix.tex:1379-1387` | weak conditional Fokker-Planck backend under `sald.general_moving_target_discrete.em_interpolation_fp` | source-signed equation `partial_s hat rho_s = -div(hat rho_s bar b_{k,s}) + (sigma_eta^2/2) Delta hat rho_s` in weak form |

The cycle-63 endpoint-law Measure.map helpers remain formalized only as local
endpoint/common-space bookkeeping.  They are not counted as conditional-law,
density/AC, weak Fokker-Planck, KL derivative, LSI/KL/FI, DV, Gronwall, or
theorem formalization.

## Cycle 64 Lower Conditional-Drift Interface

Lower sharpened the selected `appendix.tex:1358-1387` EM packet at the
regular conditional drift line, while keeping the analytic backend open.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 64 regular conditional drift lower packet | obligation with formalized local algebra | `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteConditionalDriftContract`; `SALD.cycle64GeneralMovingTargetDiscreteConditionalDriftLowerObligation`; `SALD.generalMovingTargetDiscreteConditionalDriftLinearCombination`; `SALD.generalMovingTargetDiscreteConditionalDriftFieldOfLinearCombination` |

What compiled:

- `SALD.generalMovingTargetDiscreteConditionalDriftLinearCombination` proves
  that a supplied linear conditional-expectation selector splits the source
  linear combination of the `c_{t_k}` and score summands.
- `SALD.generalMovingTargetDiscreteConditionalDriftFieldOfLinearCombination`
  rewrites a named `barB` field to the same split once the analytic backend
  supplies `barB` as the selected conditional expectation.

What remains open:

- regular conditional law/kernel for `X_k^eta` given `hat X_s=x`;
- measurability and integrability of the selected drift field;
- density and absolute-continuity of `hat rho_s` and `tilde pi_s`;
- weak conditional Fokker--Planck, KL differentiation, integration by parts,
  LSI/KL/FI, DV, Gronwall, and theorem closure.

## Cycle 65 Upper Continuous Forward-KL Route

Upper returned from the accepted cycle-64 analytic-interface pass to the
continuous `thm:forward-KL` skeleton.  There is no failed previous cycle to
recover.  Phase 1 is stable enough for a narrow theorem-route audit, but not
for broad cited-theory, SDE, disintegration, or reusable API backfill.  The
selected lower packet is the continuous Fokker--Planck/KL derivative backend
over `appendix.tex:168-228`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 65 continuous forward-KL upper route | workflow obligation | `main_body.tex:238-247`, `appendix.tex:164-252` | `SALD.cycle65ForwardKlSkeletonUpperPacket`; `SALD.cycle65ForwardKlSkeletonObligation`; `SALD.cycle65ForwardKlSkeletonDag`; `ASTIS.SALD.forward_KL.cycle65_continuous_route` |
| Cycle 65 five-backend check | obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-252`, downstream `appendix.tex:260-385` | `ASTIS.SALD.forward_KL.cycle65_five_backend_check`; Gronwall, DV, LSI/KL/FI, continuous derivative, and EM interpolation interfaces remain below formalized |
| Cycle 65 selected lower packet | obligation | `appendix.tex:168-228` | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeObligation`; `sald.forward_kl.kl_derivative`; `ASTIS.SALD.forward_KL.cycle65_lower_packet.kl_derivative` |

Source-to-Lean split for the selected lower packet:

| Source window | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:168-185` | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlDensityBoundaryObligation`; cycle-60 raw derivative wrapper as downstream scalar consumer | endpoint-safe KL differentiation, mass conservation, SALD Fokker--Planck substitution, boundary/no-flux integration by parts, and `-FI` identification |
| `appendix.tex:187-208` | `SALD.forwardKlDerivativeCandidateContract`; target transport side conditions | slowed target velocity, target integration by parts, Cauchy-Schwarz/Young with the source `1/2` coefficient, L2 velocity term |
| `appendix.tex:210-228` | `SALD.saldLsiKlFiDensityTestContract`; `SALD.forwardKlScheduleTimeChangeObligation`; cycle-60 raw derivative wrapper | LSI/KL/FI density-test backend, inverse-schedule chain rule, slowed-velocity square scaling, and `dot{s}(t)^(-1)` coefficient |
| `appendix.tex:230-252` | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `SALD.forwardKlGronwallSideConditionContract` | DV finite-log-mgf/common-space witness and Gronwall endpoint/exponent display matching remain separate obligations |

`SALD.continuousSaldContract` remains `contractOnly`.  No theorem statement,
source coefficient, source label, theorem status, SLT reuse status, or
analytic backend status changed.

## Cycle 65 Middle Continuous Forward-KL Audit

Middle added `SALD.cycle65ForwardKlSkeletonMiddleContract` and
`SALD.cycle65ForwardKlSkeletonMiddleObligation`
(`sald.forward_kl.cycle65_middle_route_audit`) under the upper cycle-65 route.
The audit checks `main_body.tex:238-247` and `appendix.tex:164-252` in source
order, wires the middle obligation into `SALD.continuousSaldContract`,
`SALD.forwardKlProofDag`, and `SALD.saldDependenciesForLabel "thm:forward-KL"`,
and keeps the lower target fixed at `sald.forward_kl.kl_derivative` over
`appendix.tex:168-228`.

| Source window | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:238-247` | `SALD.continuousForwardKlStatementContract`; `SALD.continuousSaldContract`; cycle-65 upper and middle route obligations | theorem remains `contractOnly`; constants, labels, and alpha range unchanged |
| `appendix.tex:168-185` | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlDensityBoundaryObligation`; `sald.forward_kl.density_boundary_regular` | mass conservation, KL differentiation, SALD Fokker--Planck, boundary/no-flux integration by parts, `-FI` identification |
| `appendix.tex:187-208` | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeObligation`; `sald.forward_kl.kl_derivative` | slowed target transport, target integration by parts, Cauchy-Schwarz/Young with source `1/2` coefficient |
| `appendix.tex:210-228` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi`; `SALD.forwardKlScheduleTimeChangeObligation`; `SALD.forwardKlPreDvDerivativeBoundOfRawKlFiVelocityScalingScalar` | density-test LSI/KL/FI backend, inverse-schedule calculus, slowed-velocity square scaling |
| `appendix.tex:230-241` | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `sald.forward_kl.dv_finite_log_mgf_witness`; `sald.forward_kl.dv_energy_bound` | common-space, absolute-continuity, finite-KL, finite-log-mgf, selected-test measurability |
| `appendix.tex:244-252` | `SALD.saldGronwallEndpointCalculusContract`; `SALD.forwardKlGronwallSideConditionContract`; `sald.forward_kl.gronwall_application` | endpoint rewrites, coefficient regularity, Gronwall theorem, exponent split, residual exponent drop |

Reviewer notes:

- `SALD.continuousSaldContract` remains `contractOnly`.
- The middle route is an obligation-level source-to-Lean audit, not an
  analytic proof.
- Gronwall, DV, LSI/KL/FI, continuous Fokker--Planck/KL differentiation, EM
  interpolation, theorem statuses, and SLT reuse remain below `formalized`.

## Cycle 65 Lower Continuous Forward-KL Pointwise Wrapper

Lower performed one proof-producing Lean step inside the selected continuous
KL-derivative packet.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 65 pointwise derivative lower packet | formalized local Real/order wrapper plus obligation | `appendix.tex:168-228` | `SALD.forwardKlPointwisePreDvDerivativeBoundOfRawKlFiVelocityScaling`; `SALD.cycle65ForwardKlDerivativePointwiseLowerObligation`; `ASTIS.SALD.forward_KL.cycle65_derivative_pointwise_lower` |

What compiled:

- `SALD.forwardKlPointwisePreDvDerivativeBoundOfRawKlFiVelocityScaling` applies
  the existing scalar raw-derivative handoff pointwise in `t`, yielding the
  pre-DV inequality
  `K'(t) <= -dot{s}(t)*C_LSI(t)*K(t)+(1/2)*dot{s}(t)^(-1)*||v_t||^2`
  under explicit supplied hypotheses.

What remains open:

- mass conservation and differentiating KL under the integral;
- SALD Fokker--Planck substitution and boundary/no-flux integration by parts;
- target transport and Cauchy--Schwarz analytic backend;
- LSI/KL/FI density-test theorem, inverse-schedule calculus, DV, Gronwall,
  and theorem closure.

## Cycle 66 Upper Discrete Forward-KL Route

Upper returned from the accepted cycle-65 continuous route to the discrete
`thm:forward-KL-discrete` skeleton. There is no failed previous cycle to
recover. Phase 1 is stable enough for a narrow theorem-route audit, but not
for broad cited-theory, SDE, disintegration, or reusable API backfill. The
selected lower packet is the discrete Gronwall/accumulated-error bridge over
`appendix.tex:557-592` and `main_body.tex:309-323`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 66 discrete forward-KL upper route | workflow obligation | `main_body.tex:299-323`, `appendix.tex:260-592` | `SALD.cycle66DiscreteForwardKlSkeletonUpperPacket`; `SALD.cycle66DiscreteForwardKlSkeletonObligation`; `SALD.cycle66DiscreteForwardKlSkeletonDag`; `ASTIS.SALD.forward_KL_discrete.cycle66_discrete_route` |
| Cycle 66 five-backend check | obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-252`, `appendix.tex:260-592` | `ASTIS.SALD.forward_KL_discrete.cycle66_five_backend_check`; Gronwall, DV, LSI/KL/FI, continuous derivative, and EM interpolation interfaces remain below formalized |
| Cycle 66 selected lower packet | obligation | `appendix.tex:557-592`, `main_body.tex:309-323` | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `SALD.discreteForwardKlAccumulatedErrorBridgeObligation`; `sald.discrete_forward_kl.accumulated_error_bridge`; `ASTIS.SALD.forward_KL_discrete.cycle66_lower_packet.accumulated_error` |

Source-to-Lean split for the selected lower packet:

| Source window | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:557-592` | `SALD.discreteForwardKlGronwallInstantiationContract`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; cycle-56 pointwise Gronwall input | endpoint-safe Gronwall application across stitched EM intervals, endpoint laws, coefficient regularity, interval-integrability |
| `main_body.tex:309-317` | `SALD.discreteForwardKlGronwallInitialExponentSplitOfPieces`; `SALD.discreteForwardKlResidualExponentBoundScalar`; `sald.discrete_forward_kl.residual_exponent_bound` | exponent splitting, residual exponent monotonicity, `barGamma` identification, exact `T/(r*alpha)` and `2*r*eta^2*barGamma/alpha'` coefficients |
| `main_body.tex:318-323` | `SALD.discreteForwardKlAlphaComplexityCollectionScalar`; `SALD.discreteForwardKlDeltaAccumulationScalar`; `SALD.discreteForwardKlAccumulatedErrorCollectionScalar`; `SALD.discreteForwardKlResidualIntegralDisplayBoundScalar` | collection into `(1/r)*A_alpha(pi,v)+2*r*eta*barDelta_{alpha'}` after the common exponential residual bound |

Five backend status check:

| Backend | Current route | Status discipline |
|---|---|---|
| Gronwall | endpoint-safe calculus, theorem-specific discrete Gronwall instantiation, cycle-56 pointwise input, accumulated-error display obligations | `lem:gronwall` remains obligation |
| DV | Boucheron source-cited formula plus discrete finite-log-mgf/common-space witness for `nu=hat rho_s`, `mu=tilde pi_s` | `lem:dv_variation` remains source-cited plus obligations |
| LSI/KL/FI | density-test, zero-set, entropy identity, admissibility, finite KL/FI, and Fisher-chain interfaces | `eq:LSI-KL-FI` remains obligation |
| Continuous FP/KL derivative | cycle-65 continuous route data only as sibling context for inherited assumptions | analytic derivative backend remains obligation |
| EM interpolation FP | endpoint laws, conditional drift, conditional-FP, density/AC, and stitched-interval interfaces | EM conditional-FP remains obligation |

`SALD.discreteSaldContract` remains `contractOnly`. No theorem statement,
source coefficient, source label, theorem status, SLT reuse status, or
analytic backend status changed.

## Cycle 66 Middle Discrete Forward-KL Audit

Middle translated the upper route into an explicit Lean-facing audit for
`thm:forward-KL-discrete`.  The added declarations are
`SALD.cycle66DiscreteForwardKlSkeletonMiddleContract` and
`SALD.cycle66DiscreteForwardKlSkeletonMiddleObligation`
(`sald.discrete_forward_kl.cycle66_middle_route_audit`).

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 66 middle discrete forward-KL audit | workflow obligation | `main_body.tex:299-323`, `appendix.tex:260-592` | `SALD.cycle66DiscreteForwardKlSkeletonMiddleContract`; `SALD.cycle66DiscreteForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle66_middle_route_audit` |
| Cycle 66 selected lower packet after middle audit | obligation | `appendix.tex:557-592`, `main_body.tex:309-323` | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `SALD.discreteForwardKlAccumulatedErrorBridgeObligation`; `sald.discrete_forward_kl.accumulated_error_bridge` |
| Cycle 66 lower accumulated-display scalar wrapper | proof-producing scalar wrapper plus obligation | `appendix.tex:557-592`, `main_body.tex:309-323` | `SALD.discreteForwardKlMainDisplayBoundScalar`; `SALD.cycle66DiscreteForwardKlAccumulatedDisplayLowerObligation`; composes the supplied Gronwall initial term, initial exponent split, and supplied residual display into the exact two-term main-body bound while leaving endpoint stitching, residual exponent monotonicity, and `barGamma`/`barDelta` identifications open |

Source-to-Lean obligation map:

| Source window | Lean-facing route | Open backend |
|---|---|---|
| `appendix.tex:260-385` EM interpolation and conditional FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_endpoint_laws`; `sald.discrete_forward_kl.conditional_drift_density`; `sald.discrete_forward_kl.em_conditional_fokker_planck`; `sald.discrete_forward_kl.em_interpolation_fp` | Brownian construction, regular conditional laws, density/AC, weak FP, endpoint stitching |
| `appendix.tex:388-491` KL derivative with frozen defect and LSI | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.discreteForwardKlDerivativeObligation`; `SALD.frozenDeltaCrossLipSaldContract`; `SALD.saldLsiKlFiDensityTestContract`; cycle-51 derivative lower handoff | analytic KL derivative, frozen-defect specialization, LSI/KL/FI density-test backend |
| `appendix.tex:493-523` DV velocity step | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_velocity_bound` | common space, AC, finite KL, selected-test measurability, finite log-mgf, positive-alpha witnesses |
| `appendix.tex:526-553` pointwise Gronwall input | `SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`; `SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged`; `SALD.discreteForwardKlGronwallInstantiationContract` | endpoint-safe Gronwall theorem, stitched interval regularity, coefficient regularity |
| `appendix.tex:557-592` and `main_body.tex:309-323` accumulated display | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `SALD.discreteForwardKlGronwallInitialExponentSplitOfPieces`; `SALD.discreteForwardKlResidualExponentBoundScalar`; `SALD.discreteForwardKlResidualIntegralDisplayBoundScalar`; `SALD.discreteForwardKlMainDisplayBoundScalar` | endpoint rewrites, residual exponent monotonicity, `barGamma`/`barDelta` source identifications, full bridge closure |

Reviewer checklist:

- `SALD.discreteSaldContract` lists
  `SALD.cycle66DiscreteForwardKlSkeletonMiddleObligation` and
  `SALD.cycle66DiscreteForwardKlAccumulatedDisplayLowerObligation` while
  remaining `contractOnly`.
- `SALD.discreteForwardKlProofDag` contains
  `ASTIS.SALD.forward_KL_discrete.cycle66_middle_route_audit` between the
  cycle-66 route and the selected lower accumulated-error packet.
- `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes
  `SALD.cycle66DiscreteForwardKlSkeletonMiddleContract`,
  `SALD.cycle66DiscreteForwardKlSkeletonMiddleObligation`, and
  `sald.discrete_forward_kl.cycle66_middle_route_audit`, plus the lower
  display wrapper dependency.
- Do not prove or restate `thm:forward-KL-discrete` in this packet.
- Do not promote EM/Fokker--Planck, LSI/KL/FI, DV, Gronwall, continuous
  derivative, accumulated-error bridge, theorem status, or SLT reuse status.

## Cycle 67 Upper Guided/General Route

Upper returned to `prop:guided_path_residual` and
`thm:general-moving-target-SALD` after the accepted cycle-66 discrete route.
There is no failed previous cycle to recover. Phase 1 is not stable enough for
broad cited-theory backfill until this guided/general route is rechecked
against `appendix.tex:619-951`. The selected lower packet is the
residual-to-Gronwall bridge over `appendix.tex:765-945`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 67 guided/general upper route | workflow obligation | `appendix.tex:619-951` | `SALD.cycle67GuidedGeneralSkeletonUpperPacket`; `SALD.cycle67GuidedGeneralSkeletonObligation`; `SALD.cycle67GuidedGeneralSkeletonDag`; `ASTIS.SALD.guided_general.cycle67_general_moving_target_route` |
| Cycle 67 five-backend check | obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:619-951`, downstream EM interfaces | `ASTIS.SALD.guided_general.cycle67_five_backend_check`; Gronwall, DV, LSI/KL/FI, continuous derivative, and EM interpolation remain below formalized |
| Cycle 67 middle guided/general audit | workflow obligation | `appendix.tex:619-951` | `SALD.cycle67GuidedGeneralSkeletonMiddleContract`; `SALD.cycle67GuidedGeneralSkeletonMiddleObligation`; `ASTIS.SALD.guided_general.cycle67_middle_route_audit` |
| Cycle 67 selected lower packet | obligation | `appendix.tex:765-945` | `SALD.cycle67GuidedGeneralResidualGronwallBridgeObligation`; `sald.general_moving_target.cycle67_residual_to_gronwall_bridge`; `ASTIS.SALD.guided_general.cycle67_lower_packet.residual_to_gronwall_bridge` |
| Cycle 67 lower residual-to-Gronwall scalar bridge | formalized local Real/order wrapper plus obligation | `appendix.tex:765-907` | `SALD.generalMovingTargetResidualToGronwallBridgeScalar`; `SALD.cycle67GuidedGeneralResidualGronwallLowerObligation`; composes the supplied raw KL residual split, residual Young/LSI/time-change handoff, and DV residual-energy input into the exact sigma-weighted Gronwall differential inequality coefficient while Fokker--Planck/KL differentiation, LSI/KL/FI, DV finite-log-mgf/common-space side conditions, endpoint-safe Gronwall, and pure contraction remain obligations |

Source-to-Lean obligation map:

| Source window | Lean-facing route | Open backend |
|---|---|---|
| `appendix.tex:619-704` guided residual | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.normalizer_derivative`; `sald.guided_path_residual.identity`; `SALD.cycle67GuidedGeneralSkeletonObligation` | normalizer positivity, differentiation under the integral, boundary integration by parts, product/quotient differentiation, centered residual mean-zero proof |
| `appendix.tex:724-744` theorem statement | `SALD.generalMovingTargetStatementContract`; `SALD.generalVaSaldContract` | theorem remains `contractOnly`; source statement and coefficients unchanged |
| `appendix.tex:765-884` derivative and LSI handoff | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; `sald.general_moving_target.kl_derivative`; cycle-57/62 scalar handoffs | mass conservation, KL differentiation, Fokker--Planck, integration by parts, target transport, residual Young, LSI/KL/FI, sigma/schedule side conditions |
| `appendix.tex:885-907` residual DV | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `sald.general_moving_target.dv_m_energy`; `SALD.generalMovingTargetResidualToGronwallBridgeScalar` | common-space, absolute-continuity, finite KL, selected-test measurability, finite log-mgf, positive alpha; compiled wrapper only consumes the resulting scalar DV inequality |
| `appendix.tex:908-945` Gronwall and pure contraction | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_side_conditions`; `sald.general_moving_target.pure_contraction`; `SALD.cycle67GuidedGeneralResidualGronwallBridgeObligation` | endpoint-safe Gronwall theorem, endpoint rewrites, coefficient regularity, exponent splitting, residual zero alpha-complexity |
| `appendix.tex:949-951` unified specialization | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.specialization` | downstream specialization only |

Middle audit split:

| Source window | Middle check | Next lower handoff |
|---|---|---|
| `appendix.tex:619-704` | Confirms the guided residual stays on the normalizer derivative and centered residual identity obligations. | no lower proof search selected here |
| `appendix.tex:724-884` | Confirms the theorem statement is unchanged and the derivative-to-LSI route consumes `sald.general_moving_target.kl_derivative`, cycle-57/62 scalar handoffs, and `probability.lsi_to_kl_fi`. | first residual-to-Gronwall sub-slice |
| `appendix.tex:885-907` | Confirms DV uses `Z=alpha*||m_t||^2` through the finite-log-mgf and positive-alpha interfaces. | second residual-to-Gronwall sub-slice |
| `appendix.tex:908-945` | Confirms Gronwall endpoint/exponent side conditions and pure-contraction zero-residual alpha-complexity remain explicit. | third residual-to-Gronwall sub-slice |
| `appendix.tex:949-951` | Confirms unified forward-KL remains downstream specialization by `c_t<-u_t`. | no direct VA-SALD proof route |

Reviewer checklist:

- `SALD.guidedResidualContract` lists
  `SALD.cycle67GuidedGeneralSkeletonObligation` and
  `SALD.cycle67GuidedGeneralSkeletonMiddleObligation` while remaining
  `contractOnly`.
- `SALD.generalVaSaldContract` lists
  `SALD.cycle67GuidedGeneralSkeletonObligation` and
  `SALD.cycle67GuidedGeneralSkeletonMiddleObligation` and
  `SALD.cycle67GuidedGeneralResidualGronwallBridgeObligation` and
  `SALD.cycle67GuidedGeneralResidualGronwallLowerObligation` while remaining
  `contractOnly`.
- `SALD.unifiedForwardKlContract` lists
  `SALD.cycle67GuidedGeneralSkeletonMiddleObligation` while remaining
  `contractOnly`.
- `SALD.generalVaSaldProofDag` contains the cycle-67 route, middle audit, and
  lower-packet DAG nodes, with the compiled lower wrapper recorded as
  `SALD.generalMovingTargetResidualToGronwallBridgeScalar`.
- `SALD.saldDependenciesForLabel` includes
  `SALD.cycle67GuidedGeneralDependencyNames` for
  `prop:guided_path_residual`, `thm:general-moving-target-SALD`, and
  `thm:unified-forward-KL`.
- Do not promote Gronwall, DV, LSI/KL/FI, continuous Fokker--Planck/KL
  derivative, guided residual calculus, pure contraction, EM interpolation,
  theorem status, or SLT reuse status.

## Cycle 68 Upper Unified/Discrete General Route

Upper returned to `thm:unified-forward-KL` and
`thm:general-moving-target-SALD-discrete` after the accepted cycle-67
guided/general route. There is no failed previous cycle to recover. Phase 1 is
stable enough to finish the unified/discrete-general theorem route before any
cited-theory backfill. The selected lower packet is the source-cited discrete
general theorem bridge over `main_body.tex:359-395`,
`appendix.tex:949-951`, and `appendix.tex:1313-1603`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 68 unified/discrete upper route | workflow obligation | `main_body.tex:359-395`, `appendix.tex:949-951`, `appendix.tex:1313-1603` | `SALD.cycle68UnifiedDiscreteGeneralSkeletonUpperPacket`; `SALD.cycle68UnifiedDiscreteGeneralSkeletonObligation`; `SALD.cycle68UnifiedDiscreteGeneralDag`; `ASTIS.SALD.unified_discrete_general.cycle68_unified_route`; `ASTIS.SALD.general_moving_target_discrete.cycle68_theorem_route` |
| Cycle 68 five-backend check | obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, continuous general sources, discrete EM sources | `ASTIS.SALD.unified_discrete_general.cycle68_five_backend_check`; Gronwall, DV, LSI/KL/FI, continuous derivative, and EM interpolation remain below formalized |
| Cycle 68 middle unified/discrete route audit | workflow obligation | `main_body.tex:359-395`, `appendix.tex:949-951`, `appendix.tex:1313-1603` | `SALD.cycle68UnifiedDiscreteGeneralSkeletonMiddleContract`; `SALD.cycle68UnifiedDiscreteGeneralSkeletonMiddleObligation`; `ASTIS.SALD.unified_discrete_general.cycle68_middle_route_audit`; verifies the upper route in source order and keeps lower work on the source-cited bridge |
| Cycle 68 selected lower packet | obligation | `main_body.tex:359-395`, `appendix.tex:949-1603` | `SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeObligation`; `sald.unified_discrete_general.cycle68_discrete_general_bridge`; `ASTIS.SALD.unified_discrete_general.cycle68_lower_packet.discrete_general_bridge` |
| Cycle 68 lower discrete general Gronwall/display bridge | formalized local scalar/display wrapper + obligation | `appendix.tex:1573-1600`; theorem display `appendix.tex:1316-1347` | `SALD.generalMovingTargetDiscreteGronwallDisplayBridgeScalar`; `SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeLowerObligation`; composes the named Gronwall-input wrapper, a supplied Gronwall result, and endpoint rewrites without proving or promoting Gronwall, endpoint stitching, coefficient regularity, or theorem closure |

Source-to-Lean obligation map:

| Source window | Lean-facing route | Open backend |
|---|---|---|
| `main_body.tex:359-368` and `appendix.tex:949-951` unified specialization | `SALD.guidedResidualIdentityContract`; `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.transport_velocity_bridge`; `sald.unified_forward_kl.specialization`; cycle-67 continuous general route | correction-field regularity, transport bridge, continuous general theorem dependencies |
| `appendix.tex:1313-1347` theorem statement and display | `SALD.generalMovingTargetDiscreteStatementContract`; `SALD.generalVaSaldDiscreteContract`; `SALD.cycle68UnifiedDiscreteGeneralSkeletonObligation` | theorem remains `contractOnly`; source constants and labels unchanged |
| `appendix.tex:1354-1387` EM endpoint and conditional Fokker--Planck | cycle-63 endpoint helpers; `SALD.generalMovingTargetDiscreteConditionalDriftContract`; `SALD.cycle64GeneralMovingTargetDiscreteConditionalDriftLowerObligation`; `sald.general_moving_target_discrete.em_interpolation_fp` | common space, regular conditional laws, density/AC, weak Fokker--Planck, KL derivative setup |
| `appendix.tex:1455-1531` frozen delta, Young, and LSI | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.frozen_delta_cross_lip`; `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | frozen-delta analytic lemma, LSI density-test backend, coefficient side conditions |
| `appendix.tex:1544-1557` residual DV | `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `sald.general_moving_target_discrete.dv_m_energy` | common-space, absolute-continuity, finite KL, selected-test measurability, finite log-mgf, positive alpha |
| `appendix.tex:1573-1603` time change and Gronwall/display | `SALD.generalMovingTargetDiscretePointwiseGronwallInputOfPostDvTimeChanged`; `SALD.generalMovingTargetDiscreteGronwallInstantiationContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `SALD.generalMovingTargetDiscreteGronwallNamedCoefficientInput`; `SALD.generalMovingTargetDiscreteGronwallEndpointRewriteScalar`; `SALD.generalMovingTargetDiscreteGronwallDisplayBridgeScalar` | endpoint stitching, coefficient regularity, endpoint-safe Gronwall, and analytic theorem-display inputs remain obligations |

Middle audit split:

| Source window | Middle check | Next lower handoff |
|---|---|---|
| `main_body.tex:359-395`, `appendix.tex:949-951` | Confirm unified forward-KL remains the `c_t <- u_t` specialization through the correction-field transport bridge and continuous general theorem. | no direct VA-SALD proof route |
| `appendix.tex:1313-1387` | Confirm discrete general theorem statement, endpoint laws, conditional drift, and weak EM Fokker--Planck stay on explicit interfaces. | first bridge sub-slice |
| `appendix.tex:1389-1511` | Confirm frozen-delta, frozen/residual algebra, two Young splits, and LSI handoff preserve the source coefficients. | second bridge sub-slice |
| `appendix.tex:1513-1570` | Confirm residual DV uses the source-cited DV interface with `Z=alpha*||m_t||^2` and keeps common-space/finite-log-mgf witnesses explicit. | third bridge sub-slice |
| `appendix.tex:1573-1603` | Confirm constant-schedule time change and final Gronwall/display matching remain explicit. | fourth bridge sub-slice |

Reviewer checklist:

- `SALD.unifiedForwardKlContract` lists
  `SALD.cycle68UnifiedDiscreteGeneralSkeletonObligation` and
  `SALD.cycle68UnifiedDiscreteGeneralSkeletonMiddleObligation` while
  remaining `contractOnly`.
- `SALD.generalVaSaldDiscreteContract` lists
  `SALD.cycle68UnifiedDiscreteGeneralSkeletonObligation` and
  `SALD.cycle68UnifiedDiscreteGeneralSkeletonMiddleObligation` and
  `SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeObligation` and
  `SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeLowerObligation` while
  remaining `contractOnly`.
- `SALD.generalVaSaldProofDag` and `SALD.generalVaSaldDiscreteProofDag`
  contain `SALD.cycle68UnifiedDiscreteGeneralDag`.
- `SALD.saldDependenciesForLabel` includes
  `SALD.cycle68UnifiedDiscreteGeneralDependencyNames` for
  `thm:unified-forward-KL` and
  `thm:general-moving-target-SALD-discrete`.
- Do not promote Gronwall, DV, LSI/KL/FI, continuous Fokker--Planck/KL
  derivative, EM interpolation, frozen-delta, residual DV, theorem status, or
  SLT reuse status.

## Cycle 69 Upper Analytic Interface Ledger

Upper performed the post-route analytic-interface check after the accepted
cycle-68 unified/discrete-general route.

Global phase judgment: cycle 68 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for this post-route
ledger and one narrow backend backfill only; broad cited-theory, SDE,
disintegration, SLT import, and reusable API reorganization remain out of
scope. The largest remaining shared proof risk is the Euler--Maruyama
interpolation conditional-law/Fokker--Planck backend over
`appendix.tex:1358-1387`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 69 analytic interface ledger | workflow obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-252`, `appendix.tex:260-592`, `appendix.tex:619-951`, `appendix.tex:1313-1603` | `SALD.cycle69MainSkeletonAnalyticInterfaceLedger`; `SALD.cycle69MainSkeletonAnalyticInterfaceObligation`; `SALD.cycle69MainSkeletonAnalyticInterfaceDag`; `ASTIS.SALD.cycle69.five_backend_check`; `ASTIS.SALD.cycle69.theorem_route_recheck` |
| Cycle 69 selected lower packet | obligation | `appendix.tex:1358-1387` | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteConditionalDriftContract`; `sald.general_moving_target_discrete.em_interpolation_fp`; `ASTIS.SALD.cycle69.lower_packet.em_interpolation_fp` |

Five backend status check:

| Backend | Current interface | Status discipline |
|---|---|---|
| Gronwall | endpoint-safe calculus, interval-integrability, endpoint evaluation, coefficient regularity, theorem-specific display side conditions | `lem:gronwall` remains obligation |
| Donsker--Varadhan | common-space, absolute-continuity, finite-KL/log-likelihood, selected-test measurability, finite-log-mgf, positive-alpha and `E_alpha` rewrites | `lem:dv_variation` remains source-cited plus obligations |
| LSI/KL/FI | density, zero-set convention, admissible sqrt-density test/approximation, entropy identity, finite KL/FI, Fisher chain rule | `eq:LSI-KL-FI` remains obligation |
| continuous Fokker--Planck/KL derivative | mass conservation, KL differentiation, Fokker--Planck substitution, boundary integration by parts, target transport, residual Young/LSI, schedule calculus | continuous derivative backends remain obligations |
| EM interpolation Fokker--Planck | endpoint laws, common-space bookkeeping, regular conditional drift, density/absolute-continuity, weak conditional FP signs, Laplacian split, stitched intervals | selected lower packet remains obligation |

The theorem contracts remain `contractOnly`. `SALD.cycle69MainSkeletonAnalyticInterfaceObligation`
is listed by `SALD.continuousSaldContract`, `SALD.discreteSaldContract`,
`SALD.guidedResidualContract`, `SALD.generalVaSaldContract`,
`SALD.unifiedForwardKlContract`, and `SALD.generalVaSaldDiscreteContract`.
`SALD.cycle69MainSkeletonAnalyticInterfaceDag` is listed by the continuous,
discrete, general, and discrete-general proof DAGs. `SALD.saldDependenciesForLabel`
now includes `SALD.cycle69MainSkeletonDependencyNames` for the five slow
interfaces and all six theorem-route labels.

No theorem statement, source constant, source label, source-file scope, theorem
status, slow analytic backend status, or SLT reuse status changed.

## Cycle 69 Middle Analytic Interface Audit

Middle added a workflow synchronization layer for the post-route ledger.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 69 middle analytic interface audit | workflow obligation | `appendix.tex:47-79`, `main_body.tex:202-215`, `appendix.tex:168-252`, `appendix.tex:260-592`, `appendix.tex:619-951`, `appendix.tex:1313-1603` | `SALD.cycle69MainSkeletonAnalyticMiddleContract`; `SALD.cycle69MainSkeletonAnalyticMiddleObligation`; `ASTIS.SALD.cycle69.middle_interface_audit`; `sald.main_skeleton.cycle69_middle_interface_audit` |
| Cycle 69 lower packet after middle audit | obligation | `appendix.tex:1358-1387` | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteConditionalDriftContract`; `sald.general_moving_target_discrete.em_interpolation_fp` |

Middle source-to-Lean split:

| Source window | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:1358-1366` | endpoint-law and KL-derivative prerequisites through `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation` and `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` | common probability space, density/AC for `hat rho_s` and `tilde pi_s`, finite KL, mass conservation, endpoint-safe KL differentiation |
| `appendix.tex:1368-1377` | conditional drift through `SALD.generalMovingTargetDiscreteConditionalDriftContract` and cycle-64 conditional-drift algebra wrappers | regular conditional law of `X_k^eta` given `hat X_s=x`, measurability, integrability, conditional-expectation linearity |
| `appendix.tex:1379-1387` | weak EM Fokker--Planck through `sald.general_moving_target_discrete.em_interpolation_fp` | source signs `-div(hat rho_s bar b_{k,s})` and `+(sigma_eta^2/2) Delta hat rho_s`, weak-test formulation, stitched-interval regularity |

Reviewer checklist:

- `SALD.cycle69MainSkeletonAnalyticMiddleObligation` is listed by all six theorem contracts while they remain `contractOnly`.
- `SALD.cycle69MainSkeletonAnalyticInterfaceDag` contains `ASTIS.SALD.cycle69.middle_interface_audit` before the lower-packet node.
- `SALD.saldDependenciesForLabel` includes the cycle-69 middle contract, obligation, DAG node, and obligation id through `cycle69MainSkeletonDependencyNames`.
- Gronwall, DV, LSI/KL/FI, continuous Fokker--Planck/KL derivative, EM interpolation, theorem contracts, and SLT reuse remain below `formalized`.

## Cycle 69 Lower EM FP Source-Sign Handoff

Lower made one proof-producing step inside the selected
`sald.general_moving_target_discrete.em_interpolation_fp` packet before adding
this ledger entry.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 69 EM FP source-sign lower handoff | obligation plus formalized local wrapper | `appendix.tex:1379-1387` | `SALD.generalMovingTargetDiscreteConditionalFpSourceSignsHandoff`; `SALD.cycle69GeneralMovingTargetDiscreteEmFpSourceSignsLowerObligation`; `sald.general_moving_target_discrete.cycle69_em_fp_source_signs_lower` |

The compiled wrapper preserves the exact source signs and coefficient:
from an explicit weak-FP hypothesis
`partial_s hat rho_s = -div(hat rho_s*bar b_{k,s}) + sigmaCoeff*Delta hat rho_s`
and `sigmaCoeff=sigma_eta^2/2`, it rewrites the displayed source form with
`+(sigma_eta^2/2) Delta hat rho_s`.

Remaining analytic obligations are unchanged: common probability space,
endpoint laws, regular conditional drift, density/absolute-continuity, the
actual weak conditional Fokker--Planck theorem, KL differentiation, integration
by parts, LSI/KL/FI, DV, Gronwall, and theorem closure all remain below
`formalized`.

## Cycle 70 Middle Conditional-Law/Measurability Backfill

Cycle 70 keeps the active packet on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, with the lower slice narrowed to the conditional
drift definition at `appendix.tex:1368-1377`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 70 conditional-law middle interface | workflow obligation | `appendix.tex:1358-1387`; selected sub-slice `appendix.tex:1368-1377` | `SALD.cycle70GeneralMovingTargetDiscreteConditionalLawMiddleObligation`; `SALD.generalMovingTargetDiscreteConditionalLawMeasurabilityContract`; `ASTIS.SALD.cycle70.middle_conditional_law_interface` |
| Cycle 70 named conditional drift lower handoff | formalized local wrappers plus obligation | `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteNamedConditionalDriftComponents`; `SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityHandoff`; `SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityOfComponents`; `SALD.cycle70GeneralMovingTargetDiscreteConditionalLawLowerObligation`; `ASTIS.SALD.cycle70.lower_named_conditional_drift` |
| Cycle 71 endpoint-to-conditional compatibility middle packet | workflow obligation | `appendix.tex:1358-1387`; selected sub-slice `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityContract`; `SALD.cycle71GeneralMovingTargetDiscreteEndpointConditionalMiddleObligation`; `ASTIS.SALD.cycle71.middle_endpoint_conditional_compatibility`; records that the joint law of `(X_k^eta,hat X_s)` and its second marginal must be the same `hat rho_s` consumed by the conditional kernel and weak FP interface |
| Cycle 71 endpoint-to-conditional local wrappers | formalized local `Measure.map` wrappers plus obligation | `appendix.tex:1368-1377`; local `Measure.map` projection style | `SALD.generalMovingTargetDiscreteHatRhoMarginalOfJointMap`; `SALD.generalMovingTargetDiscreteConditionalKernelCompatibilityOfJointMapMarginal`; `SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityOfJointMap`; `SALD.cycle71GeneralMovingTargetDiscreteEndpointConditionalLowerObligation`; `ASTIS.SALD.cycle71.lower_endpoint_conditional_wrapper`; proves only second-marginal equality and supplied predicate transport, including a packaged marginal-plus-compatibility handoff, while regular conditional laws, disintegration, conditional expectation, density/AC, weak FP, KL differentiation, and theorem closure remain obligations |

The new wrappers compile only under explicit supplied hypotheses:

| Supplied input | Wrapper use | Still open |
|---|---|---|
| A selected conditional expectation and linearity for integrable vector-valued summands. | `SALD.generalMovingTargetDiscreteNamedConditionalDriftComponents` rewrites the paper's `bar b_{k,s}` into named component fields `dot t_k*condC_{k,s}+(sigma_eta^2/2)*condScore_{k,s}`. | regular conditional kernel/disintegration and conditional integrability |
| Component-field regularity plus add/smul closure for the chosen predicates. | `SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityOfComponents` derives regularity of the named combination, then `SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityHandoff` transfers it to `bar b_{k,s}` by pointwise equality. | concrete measurability and local integrability proofs for `condC_{k,s}` and `condScore_{k,s}` under `hat rho_s` |
| Kernel compatibility already proved for the joint law and its `Measure.map Prod.snd` marginal. | `SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityOfJointMap` returns both the equality of that marginal with named `hat rho_s` and the transported compatibility predicate. | construction of the regular conditional kernel/disintegration theorem itself |

No theorem statement, coefficient, source label, theorem status, source-file
scope, SLT dependency, weak conditional Fokker--Planck theorem, density/AC
backend, KL derivative, LSI/KL/FI, DV, or Gronwall fact was promoted. Both
`thm:forward-KL-discrete` and `thm:general-moving-target-SALD-discrete` remain
`contractOnly`.

## Cycle 72 Weak Conditional Fokker--Planck Source Signs

Cycle 72 continues the same EM backend:
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to `appendix.tex:1379-1387`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 72 weak-FP middle packet | workflow obligation | `appendix.tex:1379-1387` | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract`; `SALD.cycle72GeneralMovingTargetDiscreteWeakFpMiddleObligation`; `ASTIS.SALD.cycle72.middle_weak_fp_source_signs` |
| Cycle 72 weak-FP source-sign lower wrappers | formalized local wrappers plus obligation | `appendix.tex:1379-1387` | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsAdmissibleHandoff`; `SALD.cycle72GeneralMovingTargetDiscreteWeakFpLowerObligation`; `ASTIS.SALD.cycle72.lower_weak_fp_source_signs` |

The compiled wrappers are test-indexed: under an explicit supplied weak
conditional Fokker--Planck identity and `sigmaCoeff=sigma_eta^2/2`, they
preserve the source signs `-div(hat rho_s*bar b_{k,s})` and
`+(sigma_eta^2/2)*Delta hat rho_s`.  The lower variant
`SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsAdmissibleHandoff`
keeps the admissible-test predicate explicit instead of silently quantifying
over all tests.

Remaining analytic obligations are unchanged: common probability space,
regular conditional kernel/disintegration, conditional expectation,
measurability/integrability of `bar b_{k,s}`, density/absolute-continuity,
the actual weak Fokker--Planck theorem, admissible test and integration-by-parts
backend, KL differentiation, LSI/KL/FI, DV, Gronwall, and theorem closure.

## Cycle 73 KL-Derivative Handoff From Weak FP

Global phase judgment: cycle 72 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for continued
single-backend backfill.  The largest remaining shared proof risk is still
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; cycle 73 selects the KL-derivative handoff from the
weak conditional Fokker--Planck identity.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 73 upper packet | workflow obligation | `appendix.tex:1358-1387` | `SALD.cycle73GeneralMovingTargetDiscreteKlDerivativeWeakFpUpperPacket`; `SALD.cycle73GeneralMovingTargetDiscreteKlDerivativeWeakFpUpperObligation` |
| Cycle 73 middle source-to-Lean map | workflow obligation | `appendix.tex:1358-1387` | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffContract`; `SALD.cycle73GeneralMovingTargetDiscreteKlDerivativeWeakFpMiddleObligation`; `ASTIS.SALD.cycle73.middle_kl_derivative_weak_fp_handoff` |
| Cycle 73 lower scalar substitution | formalized local wrappers plus obligation | `appendix.tex:1358-1387` | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffScalar`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfAdmissibleSourceSigns`; `SALD.cycle73GeneralMovingTargetDiscreteKlDerivativeWeakFpLowerObligation`; `ASTIS.SALD.cycle73.lower_kl_derivative_weak_fp_substitution` |

Source-to-Lean map:

| Source step | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:1358-1366`: `d/ds KL(hat rho_s||tilde pi_s)` equals the `partial_s hat rho_s` log-ratio pairing minus the target-time term. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffContract`; hypothesis `hkl` of `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffScalar` | density/AC, finite KL, differentiating under the integral, mass conservation |
| `appendix.tex:1379-1387`: the supplied weak FP identity gives the `partial_s hat rho_s` action as negative drift-divergence plus positive `(sigma_eta^2/2)` Laplacian. | cycle-72 weak-FP source-sign contract and wrappers; hypothesis `hweak` of the cycle-73 scalar wrappers | actual weak FP theorem, conditional drift measurability/integrability, admissible weak-test class |
| Select `phi=log(hat rho_s/tilde pi_s)` as the weak test and substitute. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffScalar`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfAdmissibleSourceSigns` | admissibility or approximation of the log-ratio test; boundary and integration-by-parts backend |
| Continue to the derivative side conditions. | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.kl_derivative` | Laplacian split, FI identification, frozen/residual Young, LSI, DV, time change, Gronwall |

The compiled lower wrappers are only Real equality substitution under explicit
hypotheses; the composed wrapper first reuses the cycle-72 admissible
source-sign handoff.  They do not prove weak Fokker--Planck, log-ratio
admissibility, density/absolute-continuity, KL differentiation, mass conservation,
integration by parts, LSI/KL/FI, DV, Gronwall, or theorem closure.

## Cycle 74 Conditional-Kernel Measure Interface

Global phase judgment: cycle 73 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The largest remaining shared proof risk is still
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; cycle 74 selects one narrow Mathlib
conditional-kernel interface for the blocked `appendix.tex:1368-1377`
conditional-law layer.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 74 conditional-kernel measure interface | `sourceCited` Mathlib measure interface | Mathlib `Probability/Kernel/Condexp.lean`; paper `appendix.tex:1368-1377` | `SALD.cycle74GeneralMovingTargetDiscreteConditionalKernelMeasureInterface`; `sald.general_moving_target_discrete.cycle74_conditional_kernel_measure_interface` |
| Cycle 74 upper packet | workflow obligation | `appendix.tex:1358-1387` | `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceUpperPacket`; `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceUpperObligation`; `ASTIS.SALD.cycle74.global_phase_judgment` |
| Cycle 74 middle source-to-Lean map | workflow obligation | `appendix.tex:1368-1377`; Mathlib `CondDistrib.lean`/`Condexp.lean` audit targets | `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceMiddleObligation`; `sald.general_moving_target_discrete.cycle74_measure_interface_middle`; `ASTIS.SALD.cycle74.middle_conditional_kernel_source_map` |
| Cycle 74 lower supplied-kernel regularity handoff | formalized local wrapper plus obligation | `appendix.tex:1368-1377`; Mathlib `CondDistrib.lean`/`Condexp.lean` as cited backend | `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfComponents`; `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceLowerObligation`; `sald.general_moving_target_discrete.cycle74_conditional_kernel_lower`; `ASTIS.SALD.cycle74.lower_conditional_kernel_regularity_handoff` |

Lower packet:

- Target exactly
  `SALD.cycle74GeneralMovingTargetDiscreteConditionalKernelMeasureInterface`.
- Audit `Mathlib.Probability.Kernel.Condexp`,
  `Mathlib.Probability.Kernel.CondDistrib`, and
  `Mathlib.Probability.Kernel.Disintegration.StandardBorel` only as candidate
  local backends for the regular conditional kernel of `X_k^eta` given
  `hat X_s=x`.
- Middle has narrowed the concrete audit shape to `condDistrib`/`condExpKernel`
  facts recovering the joint law by `compProd`, transporting the second
  marginal to the named `hat rho_s`, and providing measurable/integrable
  vector-valued conditional drift integrals.
- Lower now compiles only the supplied-kernel handoff: if that cited backend
  provides kernel compatibility plus component integral measurability and
  integrability, `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfComponents`
  transports compatibility to `hat rho_s` and derives regularity of
  `bar b_{k,s}`.
- Keep standard-Borel, finite/probability measure, marginal compatibility,
  measurability, integrability, and kernel-version side conditions explicit.
- If no tiny local wrapper is ready, leave the interface `sourceCited`; do not
  switch to weak-FP proof search, KL derivative work, display algebra, or
  theorem-route audits.

Non-goals: this does not construct the SALD conditional law, prove the weak
conditional Fokker--Planck theorem, prove log-ratio admissibility, import SLT,
change Lake dependencies, or promote any theorem/analytic backend.

## Cycle 75 Upper Conditional-Law Backfill

Global phase judgment: cycle 74 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The largest remaining shared proof risk is still
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; cycle 75 keeps the lower packet on the
conditional-law/measurability and named conditional drift construction
interface for `appendix.tex:1368-1377`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 75 upper packet | workflow obligation | `appendix.tex:1358-1387`, selected slice `appendix.tex:1368-1377` | `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillUpperPacket`; `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillUpperObligation`; `ASTIS.SALD.cycle75.global_phase_judgment` |
| Cycle 75 middle conditional-law source map | workflow obligation plus local `Measure.map` helper | `appendix.tex:1368-1377`; Mathlib `CondDistrib.lean`/`Condexp.lean` audit targets | `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillMiddleObligation`; `ASTIS.SALD.cycle75.middle_conditional_law_source_map`; `AutoSamplingTheory.lawMapProdSwap` |
| Cycle 75 lower packet selection | workflow obligation | Mathlib `CondDistrib`/`Condexp` candidates plus paper `appendix.tex:1368-1377` | `ASTIS.SALD.cycle75.lower_packet.conditional_law_measurability`; feeds `SALD.cycle74GeneralMovingTargetDiscreteConditionalKernelMeasureInterface` and `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfComponents` |
| Cycle 75 lower swapped-orientation wrapper | obligation with formalized local wrapper | `appendix.tex:1368-1377`; Mathlib `CondDistrib` orientation `(hat X_s,X_k^eta)` | `SALD.generalMovingTargetDiscreteHatRhoFirstMarginalOfSwappedJointMap`; `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfSwappedComponents`; `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillLowerObligation` |

Lower packet:

- target exactly the conditional-law/measurability layer feeding
  `SALD.cycle74GeneralMovingTargetDiscreteConditionalKernelMeasureInterface`
  and
  `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfComponents`;
- account for the Mathlib orientation: `condDistrib Y X mu` for
  `X_k^eta | \hat X_s` produces the joint law ordered as
  `(\hat X_s,X_k^eta)`, while cycle 71 names `(X_k^eta,\hat X_s)`;
  `AutoSamplingTheory.lawMapProdSwap` is now the compiled local bridge for
  this `Measure.map` orientation bookkeeping only;
- compiled lower wrapper: `SALD.generalMovingTargetDiscreteHatRhoFirstMarginalOfSwappedJointMap`
  proves the named `\hat\rho_s` first marginal of the swapped Mathlib joint
  law, and `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfSwappedComponents`
  uses a supplied swapped-joint kernel compatibility bridge plus supplied
  component integral-field regularity to recover the existing SALD
  `(X_k^\eta,\hat X_s)` orientation and `bar b_{k,s}` regularity;
- preferred sub-slice: instantiate or wrap Mathlib
  `condDistrib`/`condExpKernel` facts for the joint law of
  `(X_k^eta,\hat X_s)`, the named second marginal `\hat\rho_s`, and
  vector-valued component integrals for
  `\dot t_k c_{t_k}` and
  `(\sigma_\eta^2/2)\nabla\log\pi_{t_k}`;
- if blocked, record one missing theorem with standard-Borel/probability,
  marginal compatibility, measurability, integrability, and vector-valued
  conditional expectation hypotheses explicit;
- do not switch to endpoint-law re-audit, weak FP, KL derivative,
  Gronwall/DV/LSI, frozen-delta, or theorem display work.

Reviewer checklist:

- the active lower packet still targets
  `sald.general_moving_target_discrete.em_interpolation_fp` over
  `appendix.tex:1358-1387`, specifically `appendix.tex:1368-1377`;
- cycle 75 depends on the cycle-74 conditional-kernel source-cited interface
  and does not duplicate or promote it;
- any lower proof is only a local wrapper under explicit kernel,
  measurability, and integrability hypotheses;
- the actual conditional law, weak FP, KL differentiation, density/AC, LSI,
  DV, Gronwall, and theorem contracts remain below `formalized`;
- SLT remains reference-only and no Lake dependency changes are made.

## Cycle 76 Endpoint-To-Conditional Compatibility

Global phase judgment: cycle 75 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet remains
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to endpoint-law-to-conditional-law
compatibility.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 76 upper packet | workflow obligation | `appendix.tex:1358-1387` | `SALD.cycle76GeneralMovingTargetDiscreteEndpointConditionalUpperPacket`; `SALD.cycle76GeneralMovingTargetDiscreteEndpointConditionalUpperObligation`; `ASTIS.SALD.cycle76.global_phase_judgment` |
| Cycle 76 middle endpoint/conditional map | workflow obligation | `appendix.tex:1354-1387` | `SALD.cycle76GeneralMovingTargetDiscreteEndpointConditionalMiddleObligation`; `ASTIS.SALD.cycle76.middle_endpoint_conditional_map` |
| Cycle 76 lower endpoint-to-swapped conditional wrapper | formalized local wrappers plus obligation | `appendix.tex:1354-1387` | `SALD.generalMovingTargetDiscreteEndpointMeasureMapToSwappedConditionalCompatibility`; `SALD.generalMovingTargetDiscreteEndpointMeasureMapToConditionalCompatibility`; `SALD.cycle76GeneralMovingTargetDiscreteEndpointConditionalLowerObligation`; `ASTIS.SALD.cycle76.lower_endpoint_to_swapped_conditional` |

The compiled wrapper consumes only supplied hypotheses: endpoint a.e.
interpolation identities, named `rho_k`, `rho_{k+1}`, and `hat rho_s`
`Measure.map` representations, swapped-joint kernel compatibility for
`(hat X_s,X_k^eta)`, and a bridge back to the paper's
`(X_k^eta,hat X_s)` orientation.  It returns the two endpoint law equalities,
the named `hat rho_s` marginal in both swapped first-marginal and original
second-marginal views, the swap equality, and original-orientation kernel
compatibility.

Remaining obligations are unchanged: regular conditional law construction,
conditional expectation/component integral theorems, measurability and
integrability of `bar b_{k,s}`, density/absolute-continuity, weak
Fokker--Planck, KL differentiation, log-ratio admissibility, integration by
parts, LSI/KL/FI, DV, Gronwall, and theorem closure all remain below
`formalized`.

## Cycle 77 Weak FP Generator Source Signs

Global phase judgment: cycle 76 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet remains
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed back to the weak conditional
Fokker--Planck source signs at `appendix.tex:1379-1387`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 77 middle generator/source map | workflow obligation | `appendix.tex:1379-1387` | `SALD.cycle77GeneralMovingTargetDiscreteWeakFpGeneratorMiddleObligation`; `ASTIS.SALD.cycle77.middle_weak_fp_generator_source_signs` |
| Cycle 77 generator-level source-sign wrapper | formalized local wrappers plus obligation | `appendix.tex:1379-1387` | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`; `SALD.cycle77GeneralMovingTargetDiscreteWeakFpGeneratorLowerObligation`; `ASTIS.SALD.cycle77.lower_weak_fp_generator_handoff` |

The new compiled wrappers do not repeat only the cycle-72 coefficient rewrite.
They split the supplied analytic weak FP backend into a generator/time-derivative
identity for `partial_s hat rho_s`, a supplied generator expansion, and now a
more granular supplied drift/diffusion component expansion with the source
signs:

- negative drift contribution `-div(hat rho_s*bar b_{k,s})`;
- positive diffusion contribution `+(sigma_eta^2/2)*Delta hat rho_s`.

The theorem signatures keep the required hypotheses explicit: common
probability space, regular conditional kernel, drift regularity,
density/time-regularity, admissible weak-test regularity, boundary behavior,
and the coefficient identity `sigmaCoeff=sigma_eta^2/2`.

Remaining analytic obligations are unchanged: Brownian/EM construction,
regular conditional law and conditional expectations, measurability and
integrability of `bar b_{k,s}`, density/absolute-continuity, the actual
generator theorem, admissible-test approximation, boundary/integration by
parts, KL differentiation, LSI/KL/FI, DV, Gronwall, and theorem closure all
remain below `formalized`.

## Cycle 78 Generator-To-KL Derivative Handoff

Global phase judgment: cycle 77 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill. The active lower packet remains
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to connecting the cycle-77 generator-level
weak FP source signs to the discrete KL-derivative handoff.
Lower cycle 78 factors the handoff through an additional compiled normalized
source-sign wrapper before the generator-piece specialization.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 78 upper packet | workflow obligation | `appendix.tex:1358-1387` | `SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorUpperPacket`; `SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorUpperObligation`; `ASTIS.SALD.cycle78.global_phase_judgment` |
| Cycle 78 middle source map | workflow obligation | `appendix.tex:1358-1387`, especially `1358-1366` and `1379-1387` | `SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorMiddleObligation`; `ASTIS.SALD.cycle78.middle_kl_derivative_generator_source_map` |
| Cycle 78 normalized weak-FP KL wrapper | formalized local wrapper plus obligation | `appendix.tex:1358-1387` | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSigns`; `SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorLowerObligation`; `ASTIS.SALD.cycle78.lower_kl_derivative_generator_handoff` |
| Cycle 78 generator-piece KL wrapper | formalized local wrapper plus obligation | `appendix.tex:1358-1387` | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfGeneratorPieces`; `SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorLowerObligation`; `ASTIS.SALD.cycle78.lower_kl_derivative_generator_handoff` |

The compiled wrappers compose only supplied hypotheses: the differentiated KL
formula `dK=partialS(logRatioTest)-targetTimeTerm`, admissibility of the
log-ratio weak test, normalized source signs on admissible tests, the cycle-77
generator/time-derivative identity, the generator split into drift and
diffusion actions, the source identifications of those actions, and
`sigmaCoeff=sigma_eta^2/2`. They return the source-signed
KL derivative display with negative drift-divergence action, positive
`sigma_eta^2/2` Laplacian action, and unchanged target-time term.

Remaining analytic obligations are unchanged: EM/Brownian construction,
regular conditional law, conditional expectation and drift measurability,
density/absolute-continuity, the actual generator and weak Fokker--Planck
theorems, log-ratio admissibility or approximation, KL differentiation, mass
conservation, integration by parts, Laplacian split, FI identification,
LSI/KL/FI, DV, Gronwall, and theorem closure remain below `formalized`.

## Cycle 79 Weak FP Generator Measure Interface

Global phase judgment: cycle 78 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet remains
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the weak generator-to-law
time-derivative theorem behind the Fokker--Planck line at
`appendix.tex:1379-1387`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 79 weak generator-to-law interface | source-cited measure/calculus interface | `appendix.tex:1379-1387`; Mathlib `ParametricIntegral`, `Measure.map`, Bochner integral tools | `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureInterface`; `ASTIS.SALD.cycle79.lower_packet.weak_fp_generator_measure_interface` |
| Cycle 79 upper packet | workflow obligation | `appendix.tex:1358-1387` | `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureUpperPacket`; `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureUpperObligation`; `ASTIS.SALD.cycle79.global_phase_judgment` |
| Cycle 79 middle source map | workflow obligation | `appendix.tex:1379-1387` | `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureMiddleObligation`; `ASTIS.SALD.cycle79.middle_weak_fp_generator_measure_source_map` |
| Cycle 79 lower Measure.map weak-test handoff | formalized local wrapper plus obligation | `appendix.tex:1379-1387`; Mathlib `integral_map`, `Measure.map`, Bochner integral tools | `AutoSamplingTheory.lawMapIntegral`; `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureLowerObligation`; `ASTIS.SALD.cycle79.lower_measure_map_integral_handoff` |

The new interface records the theorem boundary before the cycle-77 and
cycle-78 wrappers: for admissible weak tests, differentiate the frozen EM
interpolation law/test integral and identify the generator action with
conditional drift `bar b_{k,s}` and diffusion coefficient `sigma_eta^2/2`.
It is not a proof of the SDE/Fokker--Planck theorem and it is not promoted
above `sourceCited`.

Reviewer checklist: the packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp`; both discrete
theorem contracts remain `contractOnly`; cycle 77 and 78 remain
supplied-hypothesis packaging only; no Mathlib, SLT, or local SDE theorem is
claimed formalized; source-index and `python3 tools/astis.py check` must pass.

## Cycle 80 Conditional-Law Measurability Upper Packet

Global phase judgment: cycle 79 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, now narrowed back to the
conditional-law/measurability and named conditional drift interface at
`appendix.tex:1368-1377`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 80 upper packet | workflow obligation | `appendix.tex:1358-1387`, especially `1368-1377` | `SALD.cycle80GeneralMovingTargetDiscreteConditionalLawMeasurabilityUpperPacket`; `SALD.cycle80GeneralMovingTargetDiscreteConditionalLawMeasurabilityUpperObligation`; `ASTIS.SALD.cycle80.global_phase_judgment` |
| Cycle 80 middle conditional-law source map | workflow obligation | `appendix.tex:1368-1377`; Mathlib `CondDistrib`/`Condexp` candidates; SLT reference style only | `SALD.cycle80GeneralMovingTargetDiscreteConditionalLawMeasurabilityMiddleObligation`; `ASTIS.SALD.cycle80.middle_conditional_law_source_map` |
| Cycle 80 selected lower packet | workflow obligation | `appendix.tex:1368-1377` | `ASTIS.SALD.cycle80.lower_packet.conditional_law_measurability`; depends on cycle-70/74/75 conditional-law interfaces and the cycle-79 weak generator-to-law source-cited interface |
| Cycle 80 lower endpoint/conditional drift-regularity handoff | formalized local wrapper plus obligation | `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteEndpointConditionalDriftRegularityHandoff`; `SALD.cycle80GeneralMovingTargetDiscreteConditionalLawMeasurabilityLowerObligation`; `ASTIS.SALD.cycle80.lower_endpoint_conditional_drift_regularity` |

Cycle 80 does not advance to theorem-route audits, endpoint re-audits,
weak-FP source-sign algebra, KL-derivative handoffs, display algebra,
Gronwall/DV/LSI work, or project-article export.  The middle map now pins the
lower-ready theorem boundary: regular conditional kernel for
`X_k^eta | hat X_s=x`, named `hat rho_s=Law(hat X_s)` marginal in the Mathlib
orientation, vector-valued conditional integral fields for both frozen drift
summands, and measurability/integrability of `bar b_{k,s}` through the existing
named-drift wrappers.  Lower should either compile a local supplied-hypothesis
wrapper around those kernel/integral facts or record one exact missing Mathlib
conditional-law theorem below `formalized` status.  Cycle 80 lower now
compiles that local wrapper under supplied hypotheses: it composes the
cycle-76 endpoint/orientation compatibility package with supplied component
conditional-integral regularity to return endpoint laws, both named
`hat rho_s` marginal views, original-orientation kernel compatibility, and
measurability/integrability of `bar b_{k,s}`.

Remaining analytic obligations are unchanged: regular conditional law
construction, vector-valued conditional expectation, density/absolute
continuity, EM generator calculus, weak Fokker--Planck, KL differentiation,
log-ratio admissibility, integration by parts, LSI/KL/FI, DV, Gronwall, and
the discrete theorem closures remain `obligation` or `sourceCited`.

## Cycle 81 Endpoint-To-Conditional Upper Packet

Global phase judgment: cycle 80 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, and the single packet that best reduces the remaining
proof risk is endpoint-law-to-conditional-law compatibility for the
`appendix.tex:1368-1377` conditional drift interface.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 81 upper packet | workflow obligation | `appendix.tex:1358-1387`, especially `1368-1377` | `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalUpperPacket`; `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalUpperObligation`; `ASTIS.SALD.cycle81.global_phase_judgment` |
| Cycle 81 selected lower packet | workflow obligation | `appendix.tex:1368-1377`; endpoint `Measure.map`, named `hat rho_s` marginal, conditional-kernel orientation | `ASTIS.SALD.cycle81.lower_packet.endpoint_conditional_compatibility`; depends on cycle-71/cycle-76 endpoint wrappers, cycle-74/cycle-75 conditional-kernel interfaces, and cycle-80 drift-regularity handoff |
| Cycle 81 middle weak-FP readiness handoff | formalized local wrapper plus obligation | `appendix.tex:1368-1377`; endpoint/orientation facts consumed before weak FP | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpReadinessHandoff`; `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalMiddleObligation`; `ASTIS.SALD.cycle81.middle_endpoint_conditional_weak_fp_readiness` |
| Cycle 81 lower endpoint-only weak-FP prerequisite handoff | formalized local wrapper plus obligation | `appendix.tex:1368-1377`; endpoint `Measure.map` compatibility plus supplied `bar b_{k,s}` regularity | `SALD.generalMovingTargetDiscreteEndpointMeasureMapWeakFpPrereqHandoff`; `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalLowerObligation`; `ASTIS.SALD.cycle81.lower_endpoint_measure_map_weak_fp_prereq` |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| EM endpoint-to-conditional bridge | Connect endpoint `Measure.map` laws and named `hat rho_s=Law(hat X_s)` marginal to the conditional-kernel orientation consumed by `bar b_{k,s}` | `SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityContract`; `SALD.generalMovingTargetDiscreteHatRhoMarginalOfJointMap`; `SALD.generalMovingTargetDiscreteEndpointMeasureMapToConditionalCompatibility`; `SALD.cycle80GeneralMovingTargetDiscreteConditionalLawMeasurabilityLowerObligation` | `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalUpperObligation`; `ASTIS.SALD.cycle81.lower_packet.endpoint_conditional_compatibility` | `appendix.tex:1358-1387`, selected `1368-1377` | `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation |
| Endpoint/conditional weak-FP readiness wrapper | Package endpoint laws, original/swapped `hat rho_s` marginal views, swap equality, original-orientation kernel compatibility, and `bar b_{k,s}` measurability/integrability into a supplied weak-FP prerequisite predicate. | `SALD.generalMovingTargetDiscreteEndpointConditionalDriftRegularityHandoff`; `SALD.generalMovingTargetDiscreteEndpointMeasureMapToConditionalCompatibility`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract`; cycle-80 lower handoff | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpReadinessHandoff`; `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalMiddleObligation`; `ASTIS.SALD.cycle81.middle_endpoint_conditional_weak_fp_readiness` | `appendix.tex:1368-1377` | weak conditional FP interface; `sald.general_moving_target_discrete.em_interpolation_fp`; both discrete theorem routes | formalized local wrapper under supplied hypotheses |
| Endpoint-only weak-FP prerequisite handoff | From the cycle-76 endpoint `Measure.map` compatibility package and already-supplied `bar b_{k,s}` measurability/integrability, feed the abstract `WeakFpPrereq` consumer needed before weak FP. | `SALD.generalMovingTargetDiscreteEndpointMeasureMapToConditionalCompatibility`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract`; supplied `FieldMeasurable`/`FieldIntegrable` predicates | `SALD.generalMovingTargetDiscreteEndpointMeasureMapWeakFpPrereqHandoff`; `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalLowerObligation`; `ASTIS.SALD.cycle81.lower_endpoint_measure_map_weak_fp_prereq` | `appendix.tex:1368-1377` | weak conditional FP interface; `sald.general_moving_target_discrete.em_interpolation_fp`; both discrete theorem routes | formalized local wrapper under supplied hypotheses |

Mode discipline: faithfulPaper Phase 1 only.  Preserve the paper route and
the source theorem statements; do not add standard-Borel, probability,
marginal-compatibility, conditional-law, density, or test-regularity hypotheses
to theorem statements.  Keep SLT as a reference-only Mathlib style source.

Non-goals: no theorem-route audit, display algebra, source-index rebaseline
beyond the gate, weak-FP proof, KL derivative proof, Gronwall/DV/LSI work,
frozen-delta work, Lake dependency change, SLT import, or project-article
export.  Do not promote the EM backend, conditional law construction, weak FP,
KL derivative, or either discrete theorem contract.

Lower packet: connect the endpoint `Measure.map` laws and the named
`hat rho_s` marginal to the conditional-law/measurability interface consumed by
the cycle-80 endpoint/conditional drift-regularity handoff.  Cycle 81 middle now
compiles the local supplied-hypothesis wrapper that turns those endpoint,
orientation, kernel-compatibility, and `bar b_{k,s}` regularity facts into an
abstract `WeakFpPrereq` consumed by the later weak-FP theorem.  The actual
conditional-law construction, generator theorem, weak FP identity, density/AC,
and KL derivative remain obligations.

Cycle 81 lower now adds the endpoint-only wrapper
`SALD.generalMovingTargetDiscreteEndpointMeasureMapWeakFpPrereqHandoff`.  It
reuses the cycle-76 endpoint/orientation compatibility theorem and consumes
only supplied `bar b_{k,s}` measurability/integrability plus a supplied
`WeakFpPrereq` consumer.  It does not construct `condDistrib`,
`condExpKernel`, conditional expectations, density/AC, generator-to-law,
weak-FP, KL-derivative, or theorem closure facts.

Reviewer checklist: reject any cycle that leaves
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; duplicates or promotes the existing cycle-71/cycle-76
endpoint wrappers, cycle-74/cycle-75 conditional-kernel interfaces, or cycle-80
drift-regularity handoff; changes theorem constants or statuses; imports SLT or
changes Lake dependencies; or skips `python3 tools/astis.py source-index
ASTIS-SALD-001` and `python3 tools/astis.py check`.

## Cycle 82 Weak FP Source-Sign Upper Packet

Global phase judgment: cycle 81 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; the single packet that best reduces the remaining
proof risk is now the weak conditional Fokker--Planck source-sign statement at
`appendix.tex:1379-1387`, after the cycle-81 endpoint/conditional
`WeakFpPrereq` readiness package.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 82 upper packet | workflow obligation | `appendix.tex:1358-1387`, especially `1379-1387` | `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsUpperPacket`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsUpperObligation`; `ASTIS.SALD.cycle82.global_phase_judgment` |
| Cycle 82 middle readiness-to-source-sign bridge | local supplied-hypothesis wrapper plus obligation | `appendix.tex:1379-1387`; weak source signs after cycle-81 readiness | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfReadinessAndGeneratorPiecesHandoff`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsMiddleObligation`; `ASTIS.SALD.cycle82.middle_readiness_to_source_signs` |
| Cycle 82 selected lower packet | local supplied-hypothesis wrapper plus obligation | `appendix.tex:1379-1387`; weak source signs | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpSourceSignsHandoff`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsLowerObligation`; `ASTIS.SALD.cycle82.lower_packet.weak_fp_source_signs`; depends on cycle-81 endpoint/conditional readiness, cycle-72 weak-test source-sign wrappers, cycle-77 generator-piece wrappers, and the cycle-79 source-cited generator-to-law interface |
| Reviewer source-sign check | workflow obligation | `appendix.tex:1379-1387` | `ASTIS.SALD.cycle82.reviewer_weak_fp_source_signs_check`; reject sign changes, hidden hypotheses, SLT/Lake promotion, or theorem-status promotion |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Weak conditional FP source signs | State the weak-test form `partialS phi = -(driftDiv phi) + (sigma_eta^2/2)*laplacian phi` for the named interpolation law and conditional drift. | cycle-81 readiness; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract`; cycle-72/cycle-77 wrappers | `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsUpperObligation`; `ASTIS.SALD.cycle82.lower_packet.weak_fp_source_signs` | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation |
| Readiness-to-generator-piece source-sign bridge | Use `WeakFpPrereq hatRhoS kernel barB` only to expose common-space, conditional-kernel, and drift-regularity inputs, then call the existing generator-piece source-sign handoff; density/time regularity, tests, boundary, generator/time derivative, drift source action, diffusion source action, and `sigmaCoeff=sigma_eta^2/2` stay explicit. | cycle-81 readiness; cycle-77 generator-piece wrapper | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfReadinessAndGeneratorPiecesHandoff`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsMiddleObligation`; `ASTIS.SALD.cycle82.middle_readiness_to_source_signs` | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | local wrapper plus obligation |
| Endpoint-readiness-to-source-sign lower bridge | First build `WeakFpPrereq` from endpoint/conditional readiness hypotheses, then call the readiness/generator-piece source-sign bridge to preserve `-div` drift and `+(sigma_eta^2/2) Delta` diffusion for admissible tests. | cycle-81 endpoint/conditional readiness; cycle-82 middle bridge; cycle-77 generator-piece wrapper | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpSourceSignsHandoff`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsLowerObligation`; `ASTIS.SALD.cycle82.lower_packet.weak_fp_source_signs` | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | local wrapper plus obligation |

Mode discipline: faithfulPaper Phase 1 only.  Preserve the exact source signs:
negative `-div(hat rho_s*bar b_{k,s})` drift and positive
`+(sigma_eta^2/2)*Delta hat rho_s` diffusion.  Do not add conditional-law,
density, admissible-test, boundary, or generator assumptions to theorem
statements; keep them source-cited or obligation-level.

Middle compiles the narrow readiness bridge
`SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfReadinessAndGeneratorPiecesHandoff`.
Lower now compiles
`SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpSourceSignsHandoff`,
which composes the endpoint/conditional readiness package with that bridge
under the same supplied generator/time derivative, drift source action,
diffusion source action, density/time regularity, admissible-test, boundary,
and coefficient hypotheses.  The exact missing analytic boundary is still the
generator-to-law weak Fokker--Planck theorem with those hypotheses supplied
from the source.

Non-goals: no theorem-route audit, display algebra, KL derivative proof,
Gronwall/DV/LSI work, frozen-delta work, SLT import, Lake dependency change,
or project-article export.  Do not promote the EM backend, weak FP,
generator-to-law, density/AC, KL derivative, or either discrete theorem
contract.

## Cycle 83 Endpoint Weak-FP To KL Handoff

Global phase judgment: cycle 82 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; the single packet that best reduces the remaining
proof risk is the KL-derivative handoff from the cycle-82 endpoint/conditional
weak-FP source signs to `eq:general_KL_derivative_0_discrete`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 83 upper packet | workflow obligation | `appendix.tex:1358-1387` | `SALD.cycle83GeneralMovingTargetDiscreteKlDerivativeEndpointWeakFpUpperPacket`; `SALD.cycle83GeneralMovingTargetDiscreteKlDerivativeEndpointWeakFpUpperObligation`; `ASTIS.SALD.cycle83.global_phase_judgment` |
| Cycle 83 middle source map | workflow obligation | `appendix.tex:1358-1387`; weak FP source signs into `eq:general_KL_derivative_0_discrete` | `SALD.cycle83GeneralMovingTargetDiscreteKlDerivativeEndpointWeakFpMiddleObligation`; `ASTIS.SALD.cycle83.middle_endpoint_source_signs_to_kl` |
| Cycle 83 selected lower packet | local supplied-hypothesis wrappers plus obligation | `appendix.tex:1358-1387`; endpoint weak-FP source signs to KL derivative display | `SALD.generalMovingTargetDiscreteEndpointConditionalKlDerivativeWeakFpHandoff`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSignsWithLogAction`; `SALD.cycle83GeneralMovingTargetDiscreteKlDerivativeEndpointWeakFpLowerObligation`; `ASTIS.SALD.cycle83.lower_packet.kl_derivative_endpoint_handoff` |
| Reviewer KL-handoff check | workflow obligation | `appendix.tex:1358-1387` | `ASTIS.SALD.cycle83.reviewer_kl_derivative_handoff_check`; reject sign changes, hidden analytic claims, SLT/Lake promotion, or theorem-status promotion |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Endpoint weak-FP source signs to KL display | Compose the cycle-82 endpoint/conditional weak-FP source-sign wrapper with the normalized weak-FP-to-KL substitution at the admissible log-ratio test; keep the log-ratio weak-FP action adjacent to the resulting `dK` display. | cycle-82 endpoint source signs; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSigns`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSignsWithLogAction`; explicit differentiated KL formula and log-ratio admissibility hypotheses | `SALD.generalMovingTargetDiscreteEndpointConditionalKlDerivativeWeakFpHandoff`; `SALD.cycle83GeneralMovingTargetDiscreteKlDerivativeEndpointWeakFpLowerObligation` | `appendix.tex:1358-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.general_moving_target_discrete.kl_derivative`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | local wrappers plus obligation |

Mode discipline: faithfulPaper Phase 1 only.  Preserve the exact source signs:
negative `-div(hat rho_s*bar b_{k,s})` drift and positive
`+(sigma_eta^2/2)*Delta hat rho_s` diffusion.  Conditional law, density/AC,
admissible log-ratio test, boundary behavior, generator calculus, weak FP, KL
differentiability, integration by parts, FI identification, LSI/KL/FI, DV,
Gronwall, and theorem closure remain source-cited or obligation-level.

## Cycle 84 Active EM Backend Upper Packet

Global phase judgment: cycle 83 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; because cycle 83 produced a compiled
proof-producing endpoint weak-FP to KL derivative handoff, the single lower
packet that best reduces the remaining proof risk is continued active EM
backend consolidation, not a new cited measure interface.  A minimal
Mathlib/measure interface is allowed only after a concrete block and must name
one missing conditional-law or weak-FP theorem boundary below formalized status.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 84 upper packet | workflow obligation | `appendix.tex:1358-1387` | `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendUpperPacket`; `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendUpperObligation`; `ASTIS.SALD.cycle84.global_phase_judgment` |
| Cycle 84 middle source map | workflow obligation | `appendix.tex:1358-1387`; active EM backend | `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendMiddleObligation`; `ASTIS.SALD.cycle84.middle_active_em_backend_source_map`; keep cycles 80-83 source route synchronized and do not open a new measure fallback without a concrete block |
| Cycle 84 selected lower packet | compiled local wrapper plus obligation | `appendix.tex:1358-1387`; active EM backend | `SALD.generalMovingTargetDiscreteEndpointConditionalKlDerivativeWeakFpHandoffWithLogAction`; `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendLowerObligation`; `ASTIS.SALD.cycle84.lower_packet.active_em_backend`; consumes cycle-81 endpoint/conditional readiness, cycle-82 endpoint source signs, and cycle-83 log-ratio KL handoff without opening any new measure interface |
| Blocked fallback guard | obligation/source-cited only if needed | `appendix.tex:1368-1387` | `ASTIS.SALD.cycle84.blocked_measure_interface_escape_hatch`; one narrow conditional-law or generator-to-law weak-FP theorem boundary with common-space, density/AC, admissible-test, finite-integral, boundary, and coefficient hypotheses explicit |
| Reviewer active-backend check | workflow obligation | `appendix.tex:1358-1387` | `ASTIS.SALD.cycle84.reviewer_active_em_backend_check`; reject fallback without a concrete block, sign changes, hidden analytic claims, SLT/Lake promotion, or theorem-status promotion |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Active EM backend lower handoff | Consolidate the accepted endpoint/conditional readiness, weak-FP source-sign, and log-ratio KL handoffs into a compiled endpoint-level pair: log-ratio weak-FP action plus `dK` display. | cycle-80/cycle-81 readiness; cycle-82 endpoint source signs; cycle-83 KL handoff; cycle-79 source-cited generator-to-law interface as an existing blocker | `SALD.generalMovingTargetDiscreteEndpointConditionalKlDerivativeWeakFpHandoffWithLogAction`; `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendLowerObligation`; `ASTIS.SALD.cycle84.lower_packet.active_em_backend` | `appendix.tex:1358-1387` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | compiled local wrapper plus obligation |
| Conditional measure fallback | Only if lower is blocked, introduce exactly one source-cited conditional-law or weak-FP theorem interface with the missing Mathlib/measure theorem named precisely. | cycle-74 conditional-kernel measure interface; cycle-79 generator-to-law measure interface; failed lower proof attempt | `ASTIS.SALD.cycle84.blocked_measure_interface_escape_hatch` | `appendix.tex:1368-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; both discrete theorem routes | source-cited or obligation only |

Mode discipline: faithfulPaper Phase 1 only.  Preserve
`appendix.tex:1358-1387`, the negative drift-divergence source sign, the
positive `sigma_eta^2/2` Laplacian sign, all source labels and constants, and
both discrete theorem statements.  Conditional law, density/AC, admissible
tests, boundary behavior, generator calculus, weak FP, KL differentiability,
integration by parts, FI identification, LSI/KL/FI, DV, Gronwall, theorem
closure, SLT import, and Lake dependency status remain unpromoted.

## Cycle 85 Conditional-Kernel Theorem Boundary Upper Packet

Global phase judgment: cycle 84 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, and the single lower packet that now reduces the
largest proof risk is the conditional-kernel/conditional-expectation theorem
boundary at `appendix.tex:1368-1377`: Mathlib `condDistrib`/`condExpKernel`
orientation for `X_k^eta | hat X_s=x`, named `hat rho_s=Law(hat X_s)`,
component conditional-integral fields, and measurability/integrability of
`bar b_{k,s}`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 85 upper packet | workflow obligation | `appendix.tex:1368-1377`; active EM backend | `SALD.cycle85GeneralMovingTargetDiscreteConditionalKernelBoundaryUpperPacket`; `SALD.cycle85GeneralMovingTargetDiscreteConditionalKernelBoundaryUpperObligation`; `ASTIS.SALD.cycle85.global_phase_judgment` |
| Active EM backend check | workflow obligation | `appendix.tex:1358-1387` | `ASTIS.SALD.cycle85.active_em_backend_check`; confirms no reviewer blocker moved the packet away from `sald.general_moving_target_discrete.em_interpolation_fp` |
| Cycle 85 selected lower packet | obligation; classification required | `appendix.tex:1368-1377` | `ASTIS.SALD.cycle85.lower_packet.conditional_kernel_theorem_boundary`; lower must compile one theorem that removes an existing supplied conditional-law hypothesis, or precisely record one missing Mathlib theorem |
| Cycle 85 middle boundary narrowing | formalized local Mathlib helpers plus obligation; `narrows-source-cited-boundary` | `appendix.tex:1368-1377`; Mathlib `CondDistrib`/`Condexp` | `AutoSamplingTheory.condDistribAeEqCondExpKernelMap`; `AutoSamplingTheory.condDistribIntegralAEStronglyMeasurable`; `AutoSamplingTheory.condDistribIntegralIntegrable`; `SALD.cycle85GeneralMovingTargetDiscreteConditionalKernelBoundaryMiddleObligation`; `ASTIS.SALD.cycle85.middle_condDistrib_condExpKernel_boundary` |
| Cycle 85 lower named-field regularity | formalized local Mathlib theorem plus obligation; `discharges-supplied-hypothesis` | `appendix.tex:1368-1377`; Mathlib `CondDistrib` law-space integral regularity | `AutoSamplingTheory.condDistribIntegralMapAEStronglyMeasurable`; `AutoSamplingTheory.condDistribIntegralMapIntegrable`; `AutoSamplingTheory.condDistribIntegralNamedLawAEStronglyMeasurable`; `AutoSamplingTheory.condDistribIntegralNamedLawIntegrable`; `AutoSamplingTheory.condDistribIntegralNamedFieldRegularity`; `SALD.cycle85GeneralMovingTargetDiscreteConditionalKernelBoundaryLowerObligation`; `ASTIS.SALD.cycle85.lower_conditional_integral_named_field_regularity` |
| Missing theorem record | obligation/source-cited only if blocked | Mathlib `Probability.Kernel.CondDistrib`, `Probability.Kernel.Condexp` | `ASTIS.SALD.cycle85.missing_mathlib_theorem_record`; exact imports, standard-Borel/probability or finite-measure hypotheses, marginal orientation, measurability, integrability, and vector-valued conditional expectation hypotheses required |
| Reviewer conditional-kernel check | workflow obligation | `appendix.tex:1368-1377` | `ASTIS.SALD.cycle85.reviewer_conditional_kernel_boundary_check`; reject supplied-hypothesis wrapper churn, wrong kernel orientation, missing `hat rho_s` marginal, hidden theorem closure, status promotion, or SLT/Lake changes |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Conditional-kernel theorem boundary | Prove or sharply narrow the regular conditional kernel for `X_k^eta | hat X_s=x`, the named `hat rho_s` marginal, component conditional-integral fields, and measurable/integrable `bar b_{k,s}`. | cycle-74 conditional-kernel measure interface; cycle-75/cycle-80 conditional-law backfill; cycle-84 active EM lower handoff; Mathlib `CondDistrib`/`Condexp` candidates | `SALD.cycle85GeneralMovingTargetDiscreteConditionalKernelBoundaryUpperObligation`; `ASTIS.SALD.cycle85.lower_packet.conditional_kernel_theorem_boundary` | `appendix.tex:1368-1377` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.discrete_forward_kl.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation |
| `condDistrib`/`condExpKernel` local boundary | Compile the Mathlib orientation `condDistrib Y X mu (X omega)` to `condExpKernel mu (m.comap X)` mapped by `Y`, and compile vector-valued conditional-integral measurability/integrability. | `ProbabilityTheory.condDistrib_apply_ae_eq_condExpKernel_map`; `MeasureTheory.AEStronglyMeasurable.integral_condDistrib`; `MeasureTheory.Integrable.integral_condDistrib`; finite-measure and standard-Borel hypotheses | `AutoSamplingTheory.condDistribAeEqCondExpKernelMap`; `AutoSamplingTheory.condDistribIntegralAEStronglyMeasurable`; `AutoSamplingTheory.condDistribIntegralIntegrable`; `SALD.cycle85GeneralMovingTargetDiscreteConditionalKernelBoundaryMiddleObligation` | `appendix.tex:1368-1377` | conditional component-field construction; `bar b_{k,s}` regularity wrappers; both discrete theorem routes | formalized helper plus obligation |
| Named `hat rho_s` component-field regularity | If a component field is `hatRhoS`-a.e. equal to the canonical `condDistrib` integral and the component integrand is measurable/integrable on the joint law, then the component field is measurable/integrable under `hatRhoS=Law(hat X_s)`. | `MeasureTheory.AEStronglyMeasurable.integral_condDistrib_map`; `MeasureTheory.Integrable.integral_condDistrib_map`; named law equality `hatRhoS=mu.map hatX_s` | `AutoSamplingTheory.condDistribIntegralNamedFieldRegularity`; `SALD.cycle85GeneralMovingTargetDiscreteConditionalKernelBoundaryLowerObligation` | `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfSwappedComponents`; `SALD.generalMovingTargetDiscreteEndpointConditionalDriftRegularityHandoff`; both discrete theorem routes | formalized helper plus obligation; discharges component-regularity supplied hypothesis |

Narrowed remaining lower theorem:

| Boundary | Exact theorem shape |
|---|---|
| `hat rho_s` state-field versioning | Prove the SALD-specific `hatRhoS`-a.e. version equalities identifying `condC_{k,s}` and `condScore_{k,s}` with the canonical `condDistrib` integrals, and prove the conditional-kernel compatibility/disintegration bridge. Once those are supplied, `AutoSamplingTheory.condDistribIntegralNamedFieldRegularity` removes the generic component measurability/integrability hypotheses. |

Lower classification discipline:

- `discharges-supplied-hypothesis`: a local theorem compiles and removes an
  existing supplied conditional-kernel, marginal, conditional-integral,
  measurability, or integrability hypothesis.
- `narrows-source-cited-boundary`: proof is blocked, but the packet records
  one exact missing theorem with imports and hypotheses.
- `rejected-wrapper-churn`: a wrapper only repackages existing supplied
  hypotheses without removing one or naming a smaller missing theorem.

Mode discipline: faithfulPaper Phase 1 only.  Preserve
`appendix.tex:1368-1377`, the paper definition of `bar b_{k,s}`, the named
`hat rho_s=Law(hat X_s)` marginal, both discrete theorem statements, and all
source labels and constants.  Conditional law, weak FP, KL derivative,
density/AC, LSI/KL/FI, DV, Gronwall, theorem closure, SLT import, and Lake
dependency status remain unpromoted.

## Cycle 86 Generator-To-Law Weak-FP Upper Packet

Global phase judgment: cycle 85 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, and the single lower packet that now reduces the
largest proof risk is the generator-to-law weak Fokker--Planck boundary at
`appendix.tex:1379-1387`: use the existing cycle-79 `lawMapIntegral` /
`lawMapIntegralHasDerivAtOfSample` helpers and the accepted cycle-85
conditional-field regularity progress to discharge or sharply narrow the
supplied generator/time-derivative hypothesis consumed by
`SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 86 upper packet | workflow obligation | `appendix.tex:1379-1387`; active EM backend | `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryUpperPacket`; `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryUpperObligation`; `ASTIS.SALD.cycle86.global_phase_judgment` |
| Active EM backend check | workflow obligation | `appendix.tex:1358-1387` | `ASTIS.SALD.cycle86.active_em_backend_check`; confirms no reviewer blocker moved the packet away from `sald.general_moving_target_discrete.em_interpolation_fp` |
| Cycle 86 middle source map | obligation; narrows-source-cited-boundary | `appendix.tex:1379-1387`; Mathlib `ParametricIntegral`, Bochner integral, `Measure.map` transport | `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryMiddleObligation`; `ASTIS.SALD.cycle86.middle_weak_fp_generator_to_law_source_map`; records the exact theorem boundary for deriving admissible-test law derivatives from sample-path generator differentiation and `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample` before source-sign wrappers are used |
| Cycle 86 selected lower packet | obligation; classification required | `appendix.tex:1379-1387`; generator-to-law weak FP | `ASTIS.SALD.cycle86.lower_packet.weak_fp_generator_to_law_boundary`; lower must remove a supplied generator/time-derivative or source-action hypothesis, or name one smaller missing theorem |
| Cycle 86 lower generator-to-law handoff | formalized local handoff plus obligation; narrows-source-cited-boundary | `appendix.tex:1379-1387`; `Measure.map` derivative transport | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleGeneratorPiecesHandoff`; `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryLowerObligation`; removes the abstract `hgenerator` equality by deriving it from sample-space `HasDerivAt`, law derivative transport, and derivative uniqueness |
| Reviewer weak-FP generator check | workflow obligation | `appendix.tex:1379-1387` | `ASTIS.SALD.cycle86.reviewer_weak_fp_generator_boundary_check`; reject wrapper churn, hidden weak-FP closure, source-sign/constant drift, theorem-status promotion, or SLT/Lake changes |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Generator-to-law weak-FP boundary | Turn sample-path derivative plus `Measure.map`/Bochner integral transport into the weak law derivative statement for admissible tests before source-sign wrappers are applied. | cycle-79 `lawMapIntegral` helpers; Mathlib parametric/Bochner integral APIs; cycle-85 conditional-field regularity; cycle-77/cycle-82 weak-FP wrappers | `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryUpperObligation`; `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryMiddleObligation`; `ASTIS.SALD.cycle86.lower_packet.weak_fp_generator_to_law_boundary` | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.discrete_forward_kl.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation |
| Sample-derivative to law-generator handoff | Replace `partialS phi = generatorAction phi` as a supplied source-sign hypothesis by deriving it from a transported sample-space derivative and uniqueness of the weak law derivative. | `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; supplied sample-space `HasDerivAt`; supplied weak-law `HasDerivAt`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff` | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleGeneratorPiecesHandoff`; `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryLowerObligation`; `ASTIS.SALD.cycle86.lower_packet.weak_fp_generator_to_law_boundary` | `appendix.tex:1379-1387` | weak-FP source signs; KL derivative handoff; both discrete theorem routes | formalized local theorem plus obligation; narrows-source-cited-boundary |
| Middle theorem boundary | For each admissible weak test `phi`, prove a sample-space `HasDerivAt` for `s ↦ ∫ phi(hatX_s omega) dP`, transport it to `hatRhoS = Law(hatX_s)`, and identify the frozen EM generator action before applying `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`. | sample-path generator differentiation; Bochner/parametric integral interchange; `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; cycle-85 conditional-field regularity | `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryMiddleObligation`; `ASTIS.SALD.cycle86.middle_weak_fp_generator_to_law_source_map` | `appendix.tex:1379-1387` | weak-FP source signs; KL derivative handoff; both discrete theorem routes | obligation; narrows-source-cited-boundary |
| Measure-map derivative transport | Use `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample` in the law-to-sample-to-law direction for `hat rho_s=Law(hat X_s)`. | `AutoSamplingTheory.lawMapIntegral`; supplied sample-space `HasDerivAt`; weak-test measurability | `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; cycle-79 lower obligation | `appendix.tex:1379-1387` | weak generator theorem; both discrete theorem routes | formalized helper plus obligation |
| Supplied hypothesis to reduce | Replace or strictly narrow the `hgenerator`-style assumption `partialS phi = generatorAction phi` consumed by `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`. | conditional drift regularity from cycle 85; admissible weak tests; density/boundary hypotheses; sample-path generator derivative; source-action split | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfReadinessAndGeneratorPiecesHandoff` | `appendix.tex:1379-1387` | weak-FP source signs; KL derivative handoff; both discrete theorem routes | selected lower boundary |

Lower classification discipline:

- `discharges-supplied-hypothesis`: a local theorem compiles and removes an
  existing supplied generator/time-derivative, source-action, parametric
  integral, or weak-test measurability/integrability hypothesis.
- `narrows-source-cited-boundary`: proof is blocked, but the packet records one
  exact missing theorem with imports and hypotheses, such as sample-path
  generator differentiation, Bochner/parametric integral interchange, or
  conditional-drift source-action identification.
- `rejected-wrapper-churn`: a wrapper only repackages the cycle-77/cycle-82
  supplied hypotheses without removing one or naming a smaller missing theorem.

Mode discipline: faithfulPaper Phase 1 only.  Preserve
`appendix.tex:1379-1387`, the source signs
`-div(hat rho_s*bar b_{k,s})` and `+(sigma_eta^2/2) Delta hat rho_s`, both
discrete theorem statements, and all source labels and constants.  Conditional
law construction, full weak FP, KL derivative, density/AC, LSI/KL/FI, DV,
Gronwall, theorem closure, SLT import, and Lake dependency status remain
unpromoted unless a corresponding local ASTIS declaration compiles.

## Cycle 87 KL/Log-Ratio Boundary Upper Packet

Global phase judgment: cycle 86 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, and the single lower packet that now reduces the
largest proof risk is the KL/log-ratio analytic boundary at
`appendix.tex:1358-1366`: formalize or precisely isolate KL differentiability
at the admissible log-ratio weak test, including log-ratio
measurability/integrability and the handoff from weak-FP action to `dK`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 87 upper packet | workflow obligation | `appendix.tex:1358-1366`; active EM backend | `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryUpperPacket`; `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryUpperObligation`; `ASTIS.SALD.cycle87.global_phase_judgment` |
| Active EM backend check | workflow obligation | `appendix.tex:1358-1387` | `ASTIS.SALD.cycle87.active_em_backend_check`; confirms no reviewer blocker moved the packet away from `sald.general_moving_target_discrete.em_interpolation_fp` |
| Cycle 87 middle source map | obligation; narrows-source-cited-boundary | `appendix.tex:1358-1366`; raw KL derivative and mass conservation | `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryMiddleObligation`; `ASTIS.SALD.cycle87.middle_kl_log_ratio_source_map`; splits the old post-mass-drop `hkl` display into raw KL differentiation with an explicit mass term, `massTerm=0`, target-time derivative integrability, and log-ratio measurability/integrability/admissibility |
| Cycle 87 selected lower packet | obligation; classification required | `appendix.tex:1358-1366`; KL/log-ratio boundary | `ASTIS.SALD.cycle87.lower_packet.kl_log_ratio_boundary`; lower must remove an older `hkl`, `hlog`, log-action, measurability, or integrability supplied hypothesis, or name one smaller missing theorem |
| Cycle 87 lower mass-conservation handoff | formalized local scalar handoff plus obligation; narrows-source-cited-boundary | `appendix.tex:1358-1366`; `eq:general_KL_derivative_0_discrete` | `SALD.generalMovingTargetDiscreteKlDerivativeMassConservationDropScalar`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfRawKlAndSourceSignsWithLogAction`; `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryLowerObligation`; replaces the older supplied post-mass-drop `hkl` display with raw KL derivative plus explicit mass conservation before applying the existing weak-FP source-sign handoff |
| Cycle 87 lower log-ratio regularity | formalized local Mathlib-backed theorem; discharges-supplied-hypothesis | `appendix.tex:1358-1366`; log-ratio weak test | `SALD.generalMovingTargetDiscreteKlLogRatioLlrDef`; `SALD.generalMovingTargetDiscreteKlLogRatioRegularityOfFiniteKl`; `ASTIS.SALD.cycle87.lower_kl_log_ratio_regularity`; finite KL now supplies `hatRho << tildePi`, a.e. strong measurability, and integrability of Mathlib `llr hatRho tildePi`, so separate log-ratio AC/measurability/integrability hypotheses are no longer needed in this local boundary |
| Reviewer KL/log-ratio check | workflow obligation | `appendix.tex:1358-1366` | `ASTIS.SALD.cycle87.reviewer_kl_log_ratio_boundary_check`; reject wrapper churn, hidden KL differentiability closure, target-time sign changes, theorem-status promotion, or SLT/Lake changes |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| KL/log-ratio analytic boundary | Prove or sharply narrow the differentiated KL display at the admissible log-ratio test. | cycle-83/cycle-84 weak-FP-to-KL handoffs; cycle-86 generator-to-law narrowing; weak-FP source signs | `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryUpperObligation`; `ASTIS.SALD.cycle87.lower_packet.kl_log_ratio_boundary` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | obligation |
| Raw KL derivative split | Replace the post-mass-drop `hkl` assumption by a raw derivative display `dK=partialS(logRatioTest)+massTerm-targetTimeTerm`, a separate mass-conservation equality, and explicit log-ratio/target-time regularity obligations. | `eq:general_KL_derivative_0_discrete`; cycle-86 weak-FP source-sign narrowing | `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryMiddleObligation`; `ASTIS.SALD.cycle87.middle_kl_log_ratio_source_map` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | obligation; narrows-source-cited-boundary |
| Mass-conservation scalar handoff | Drop the explicit mass term and feed the resulting `dK=partialS(logRatioTest)-targetTimeTerm` display into the existing source-sign-with-log-action wrapper. | supplied raw KL derivative; supplied `massTerm=0`; admissible log-ratio test; normalized weak-FP source signs | `SALD.generalMovingTargetDiscreteKlDerivativeMassConservationDropScalar`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfRawKlAndSourceSignsWithLogAction`; `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryLowerObligation`; `ASTIS.SALD.cycle87.lower_kl_mass_conservation_handoff` | `appendix.tex:1358-1366` | weak-FP source signs; `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | formalized local scalar/equality wrapper plus obligation |
| Log-ratio regularity from finite KL | Use Mathlib `llr` for the paper's `log(hat rho_s / tilde pi_s)` convention and derive absolute continuity, a.e. strong measurability, and integrability from finite KL. | finite `klDiv hatRho tildePi`; Mathlib `klDiv_ne_top_iff`, `stronglyMeasurable_llr`, and `llr_def` | `SALD.generalMovingTargetDiscreteKlLogRatioLlrDef`; `SALD.generalMovingTargetDiscreteKlLogRatioRegularityOfFiniteKl`; `ASTIS.SALD.cycle87.lower_kl_log_ratio_regularity` | `appendix.tex:1358-1366` | weak-FP action to `dK`; integration by parts; FI identification | formalized; discharges-supplied-hypothesis |
| Log-ratio weak-test admissibility | Expose smooth/Sobolev approximation, boundary behavior, and validity of the Mathlib `llr` representative as an admissible weak-FP test. | finite-KL regularity theorem; density/time regularity; admissible weak-test family | `ASTIS.SALD.cycle87.lower_packet.kl_log_ratio_boundary` | `appendix.tex:1358-1366` | weak-FP action to `dK`; integration by parts; FI identification | remaining analytic boundary |
| KL derivative display | Replace or strictly narrow the supplied `hkl` display `dK = partialS logRatioTest - targetTimeTerm`, including mass conservation and target-density time derivative integrability. | differentiating under the KL integral; `integral partial_s hat rho_s dx = 0`; target-time derivative term | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSignsWithLogAction`; `SALD.generalMovingTargetDiscreteEndpointConditionalKlDerivativeWeakFpHandoffWithLogAction` | `eq:general_KL_derivative_0_discrete`; `appendix.tex:1358-1366` | weak-FP source signs; both discrete theorem routes | selected lower boundary |

Lower classification discipline:

- `discharges-supplied-hypothesis`: a local theorem compiles and removes an
  existing supplied KL derivative display, log-ratio admissibility, log-action,
  measurability, integrability, mass-conservation, or target-time derivative
  hypothesis.
- `narrows-source-cited-boundary`: proof is blocked, but the packet records one
  exact missing theorem with imports and hypotheses, such as differentiating KL
  under the integral, finite log-ratio weak-FP action, target-density time
  derivative, mass conservation, or admissible weak-test regularity.
- `rejected-wrapper-churn`: a wrapper only repackages the cycle-83/cycle-84
  supplied hypotheses without removing one or naming a smaller missing theorem.

## Cycle 88 Log-Ratio Weak-Test Admissibility Boundary

Cycle 87 was accepted by reviewer/build, so no recovery is needed.  Phase 1
theorem-skeleton translation is stable enough for cited-theory backfill.  The
active packet remains `sald.general_moving_target_discrete.em_interpolation_fp`
over `appendix.tex:1358-1387`, narrowed here to `appendix.tex:1358-1366`.

The selected supplied hypothesis is exactly
`hlog : Admissible logRatioTest`, consumed by the cycle-83/cycle-84
weak-FP-to-KL handoffs.  Cycle 87 already discharges the separate
absolute-continuity, measurability, and integrability side of the Mathlib
`llr` test under finite KL; cycle 88 therefore records the smaller remaining
admissibility/approximation theorem boundary instead of adding another wrapper.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 88 middle packet | obligation; `narrows-source-cited-boundary` | `appendix.tex:1358-1366`; active EM backend | `SALD.cycle88GeneralMovingTargetDiscreteKlLogRatioAdmissibilityMiddlePacket`; `ASTIS.SALD.cycle88.global_phase_judgment` |
| Cycle 88 middle source map | obligation; `narrows-source-cited-boundary` | `appendix.tex:1358-1366`; log-ratio weak-test admissibility | `SALD.cycle88GeneralMovingTargetDiscreteKlLogRatioAdmissibilityMiddleObligation`; `ASTIS.SALD.cycle88.middle_log_ratio_admissibility_boundary` |
| Cycle 88 selected lower packet | formalized local handoff plus obligation; `narrows-source-cited-boundary` | `appendix.tex:1358-1366`; replace `hlog` | `SALD.GeneralMovingTargetDiscreteKlLogRatioAdmissibilityClosure`; `SALD.generalMovingTargetDiscreteKlLogRatioAdmissibleOfFiniteKlClosure`; `SALD.cycle88GeneralMovingTargetDiscreteKlLogRatioAdmissibilityLowerObligation`; `ASTIS.SALD.cycle88.lower_packet.log_ratio_admissibility`; finite KL plus the named closure package imply `Admissible (llr hatRhoS tildePiS)` |
| Reviewer admissibility check | workflow obligation | `appendix.tex:1358-1366` | `ASTIS.SALD.cycle88.reviewer_log_ratio_admissibility_check`; reject wrapper churn, hidden KL/weak-FP closure, reintroduced AC/measurability/integrability hypotheses, or status promotion |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Log-ratio admissibility boundary | Replace the broad `hlog : Admissible logRatioTest` input by the smaller theorem that Mathlib `llr hatRhoS tildePiS` is an admissible weak-FP test. | cycle-87 finite-KL `llr` regularity; cycle-83/cycle-84 weak-FP-to-KL handoffs | `SALD.cycle88GeneralMovingTargetDiscreteKlLogRatioAdmissibilityMiddleObligation`; `ASTIS.SALD.cycle88.middle_log_ratio_admissibility_boundary` | `appendix.tex:1358-1366` | weak-FP action to `dK`; both discrete theorem routes | obligation; `narrows-source-cited-boundary` |
| Lower finite-KL-to-admissible-`llr` handoff | Use cycle-87 finite-KL regularity to feed the exact remaining weak-test closure package and derive `Admissible (llr hatRhoS tildePiS)`. | `SALD.generalMovingTargetDiscreteKlLogRatioRegularityOfFiniteKl`; `SALD.GeneralMovingTargetDiscreteKlLogRatioAdmissibilityClosure`; weak-FP admissible-test class; density/time, zero-set, approximation, boundary, action-closure, and target-time hypotheses | `SALD.generalMovingTargetDiscreteKlLogRatioAdmissibleOfFiniteKlClosure`; `SALD.cycle88GeneralMovingTargetDiscreteKlLogRatioAdmissibilityLowerObligation`; `ASTIS.SALD.cycle88.lower_packet.log_ratio_admissibility` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative`; integration by parts/FI | formalized local handoff plus obligation; `narrows-source-cited-boundary` |

Remaining blockers: raw KL differentiability, mass conservation theorem,
target-time derivative integrability, the actual log-ratio approximation and
weak-FP action-closure theorem, weak conditional FP, integration by parts, FI,
and theorem closure.  No theorem status, EM/KL backend status, SLT status, or
Lake dependency is promoted.

Mode discipline: faithfulPaper Phase 1 only.  Preserve
`appendix.tex:1358-1366`, `eq:general_KL_derivative_0_discrete`, the minus sign
on the target-time term, both discrete theorem statements, and all source
labels and constants.  Full weak FP, conditional law construction, integration
by parts, FI identification, LSI/KL/FI, DV, Gronwall, theorem closure, SLT
import, and Lake dependency status remain unpromoted unless a corresponding
local ASTIS declaration compiles.

## Cycle 89 Discrete Forward-KL Closure Pressure Test

Global phase judgment: cycle 88 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; the pressure test routes
`thm:forward-KL-discrete` through the currently compiled EM/KL handoffs and the
existing LSI, DV, Gronwall, and accumulated-error scalar interfaces.  The
single lower packet that now reduces the largest proof risk is the
derivative/integration-by-parts/FI boundary in
`SALD.discreteForwardKlDerivativeObligation` /
`sald.discrete_forward_kl.kl_derivative` at `appendix.tex:388-413`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 89 upper pressure packet | obligation; `narrows-source-cited-boundary` | `main_body.tex:299-323`; `appendix.tex:260-592`; active backend `appendix.tex:1358-1387` | `SALD.cycle89DiscreteForwardKlClosurePressureUpperPacket`; `ASTIS.SALD.cycle89.global_phase_judgment` |
| Active EM backend check | obligation | `appendix.tex:1358-1387` | `ASTIS.SALD.cycle89.active_em_backend_check`; confirms no reviewer blocker moved the shared packet away from `sald.general_moving_target_discrete.em_interpolation_fp` |
| Discrete theorem pressure route | obligation | `main_body.tex:299-323`; `appendix.tex:260-592` | `SALD.cycle89DiscreteForwardKlClosurePressureUpperObligation`; `ASTIS.SALD.forward_KL_discrete.cycle89_pressure_route` |
| Cycle 89 middle route audit | obligation; `narrows-source-cited-boundary` | `appendix.tex:388-413`; target-transport companion `appendix.tex:414-436` | `SALD.cycle89DiscreteForwardKlClosurePressureMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle89_middle_route_audit` |
| Next non-wrapper blocker | obligation; selected lower packet | `appendix.tex:388-413`; target-transport companion `appendix.tex:414-436` | `SALD.discreteForwardKlDerivativeObligation`; `sald.discrete_forward_kl.kl_derivative`; `ASTIS.SALD.forward_KL_discrete.cycle89_next_blocker` |
| Cycle 89 lower derivative split | compiled scalar handoff plus obligation; `narrows-source-cited-boundary` | `appendix.tex:388-436` | `SALD.discreteForwardKlDerivativeSplitOfRawIbpsScalar`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfRawIbpsScalar`; `SALD.cycle89DiscreteForwardKlClosurePressureLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle89_lower_derivative_ibp_split` |
| Reviewer pressure check | obligation | fixed theorem route and active backend | `ASTIS.SALD.cycle89.reviewer_pressure_check`; reject wrapper churn, status promotion, source-label drift, or theorem-constant drift |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Current EM/KL inputs | Use cycle 85 conditional-kernel regularity, cycle 86 generator-to-law handoff, cycle 87 raw-KL/mass split and finite-KL `llr` regularity, and cycle 88 finite-KL-to-admissible-`llr` closure handoff. | cycles 85--88; `eq:general_KL_derivative_0_discrete` | `SALD.generalMovingTargetDiscreteKlLogRatioAdmissibleOfFiniteKlClosure`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfRawKlAndSourceSignsWithLogAction` | `appendix.tex:1358-1387` | derivative route; both discrete theorem routes | formalized local handoffs plus obligations |
| Discrete derivative pressure route | Once analytic derivative action is supplied, consume the existing LSI scalar wrapper, DV velocity witness, Gronwall input wrapper, and accumulated-error wrappers. | cycle 51 derivative scalar handoff; cycles 56/61/66 | `SALD.cycle89DiscreteForwardKlClosurePressureUpperObligation`; `ASTIS.SALD.forward_KL_discrete.cycle89_pressure_route` | `appendix.tex:388-592`; `main_body.tex:309-323` | `thm:forward-KL-discrete` | obligation |
| Middle route audit | Record the source-to-Lean handoff for the pressure test and select lower work inside the existing derivative obligation, not a new theorem-route wrapper. | cycle-89 upper packet; cycle-88 log-ratio admissibility lower; cycle-51 derivative scalar handoff; cycle-66 route | `SALD.cycle89DiscreteForwardKlClosurePressureMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle89_middle_route_audit` | `appendix.tex:388-413`; `appendix.tex:414-436` | `sald.discrete_forward_kl.kl_derivative`; `thm:forward-KL-discrete` | obligation; `narrows-source-cited-boundary` |
| Selected lower blocker | Prove or isolate the integration-by-parts and Fisher-identification theorem behind `eq:KL-derivative-1-discrete`, plus target-transport IBP for `eq:KL-derivative-2-discrete`. | weak-FP log-ratio action; admissible `llr`; density/time regularity; boundary/no-flux; target-time integrability | `SALD.discreteForwardKlDerivativeObligation`; `sald.discrete_forward_kl.kl_derivative`; `ASTIS.SALD.forward_KL_discrete.cycle89_next_blocker` | `appendix.tex:388-413`; `appendix.tex:414-436` | `SALD.cycle51DiscreteForwardKlDerivativeLowerObligation`; theorem route | obligation; `narrows-source-cited-boundary` |
| Lower derivative split | Compile the scalar route after replacing the older opaque post-IBP derivative display with raw KL differentiation, mass conservation, the first-term IBP/FI identity, and target-transport IBP. | cycle-89 middle audit; cycle-51 scalar derivative route; cycle-88 finite-KL-to-admissible-`llr` handoff | `SALD.discreteForwardKlDerivativeSplitOfRawIbpsScalar`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfRawIbpsScalar`; `SALD.cycle89DiscreteForwardKlClosurePressureLowerObligation` | `appendix.tex:388-436`; `eq:KL-derivative-0-discrete`; `eq:KL-derivative-1-discrete`; `eq:KL-derivative-2-discrete` | `SALD.cycle51DiscreteForwardKlDerivativeLowerObligation`; theorem route | compiled scalar handoff plus obligation; `narrows-source-cited-boundary` |

Lower packet classification:

- `narrows-source-cited-boundary`: expected for cycle 89.  Lower must name or
  prove one exact theorem boundary for divergence integration by parts,
  target-transport integration by parts, or FI identification.
- Cycle 89 lower accepted narrowing: `SALD.discreteForwardKlDerivativeSplitOfRawIbpsScalar`
  and `SALD.discreteForwardKlPostLsiDerivativeBoundOfRawIbpsScalar` remove the
  older single supplied `dK=-FI+frozenCross+movingCross` derivative display
  from the scalar route.  Remaining exact analytic inputs are mass
  conservation (`hmass`), first-term IBP/FI (`hfirst`), and target-transport
  IBP (`htarget`) under the source density, boundary, and admissibility
  hypotheses.
- `discharges-supplied-hypothesis`: acceptable only if a compiled theorem
  removes an older supplied IBP/FI/log-action hypothesis.
- `rejected-wrapper-churn`: any packet that merely repackages `hIBP`, `hFI`,
  `hlog`, `hkl`, or weak-FP source signs without reducing an older supplied
  hypothesis or naming a smaller theorem.

No theorem statement, source label, coefficient, theorem status, EM/KL backend
status, SLT reuse status, or Lake dependency changed.

## Cycle 90 Discrete KL Mass-Conservation Upper Packet

Global phase judgment: cycle 89 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, but the cycle-89 reviewer identified a theorem-route
blocker after the pressure test.  The single lower packet that now reduces the
largest proof risk is the mass-conservation sub-boundary
`hmass : massTerm = 0` inside `SALD.discreteForwardKlDerivativeObligation` /
`sald.discrete_forward_kl.kl_derivative`, sourced at
`eq:KL-derivative-0-discrete` and `appendix.tex:338-388`, before the remaining
`hfirst` and `htarget` integration-by-parts/FI identities.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 90 upper mass-conservation packet | obligation; selected lower packet | `main_body.tex:299-323`; `appendix.tex:338-388`; active backend `appendix.tex:1358-1387` | `SALD.cycle90DiscreteForwardKlMassConservationUpperPacket`; `SALD.cycle90DiscreteForwardKlMassConservationUpperObligation`; `ASTIS.SALD.cycle90.global_phase_judgment` |
| Active EM backend exception check | obligation | `appendix.tex:1358-1387` | `ASTIS.SALD.cycle90.active_em_backend_exception_check`; confirms EM remains active but cycle 89 reviewer moved the next lower packet to `hmass/hfirst/htarget` |
| Cycle 90 middle mass-derivative route | formalized local calculus handoff plus obligation; `discharges-supplied-hypothesis` for scalar `hmass` | `eq:KL-derivative-0-discrete`; `appendix.tex:338-388` | `SALD.discreteForwardKlMassTermZeroOfTotalMassDerivative`; `SALD.discreteForwardKlDerivativeSplitOfMassDerivativeScalar`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfMassDerivativeScalar`; `SALD.cycle90DiscreteForwardKlMassConservationMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle90_middle_mass_derivative_route` |
| Cycle 90 lower mapped-law constant test | formalized local probability-law/Measure.map handoff plus obligation; `discharges-supplied-hypothesis` for abstract total-mass normalization | `eq:KL-derivative-0-discrete`; `appendix.tex:338-388` | `SALD.discreteForwardKlLawConstantTestTotalMassOne`; `SALD.discreteForwardKlLawConstantTestHasDerivAtZero`; `SALD.discreteForwardKlMassTermZeroOfLawConstantTestDerivative`; `SALD.discreteForwardKlDerivativeSplitOfLawConstantTestMassScalar`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfLawConstantTestMassScalar`; `SALD.cycle90DiscreteForwardKlMassConservationLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle90_lower_law_constant_test_mass` |
| Selected lower packet | obligation; `discharges-supplied-hypothesis` if compiled, otherwise `narrows-source-cited-boundary` | `eq:KL-derivative-0-discrete`; `appendix.tex:338-388` | `ASTIS.SALD.forward_KL_discrete.cycle90_mass_conservation_lower_packet`; prove or isolate `massTerm = 0` from `integral partial_s hat rho_s dx = 0` |
| Reviewer mass-conservation check | obligation | fixed derivative route and active EM backend | `ASTIS.SALD.cycle90.reviewer_mass_conservation_check`; reject wrapper churn, LSI/DV/Gronwall drift, or status promotion |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Discrete KL mass conservation | Prove the raw KL derivative mass term is zero from `hat rho_s = Law(hat X_s)`, probability-law normalization, and derivative-under-integral/constant weak-test semantics. | cycle-89 raw derivative split; weak-FP/log-ratio readiness; Mathlib probability measure and parametric integral APIs | `SALD.cycle90DiscreteForwardKlMassConservationUpperObligation`; `ASTIS.SALD.forward_KL_discrete.cycle90_mass_conservation_lower_packet` | `eq:KL-derivative-0-discrete`; `appendix.tex:338-388` | `sald.discrete_forward_kl.kl_derivative`; `thm:forward-KL-discrete` | obligation |
| Middle mass-derivative handoff | Replace the primitive scalar `hmass` with total-mass normalization near `s0` plus a `HasDerivAt` witness that `massTerm` is the total-mass derivative. | Mathlib `hasDerivAt_const`, `HasDerivAt.congr_of_eventuallyEq`, derivative uniqueness; cycle-89 raw split | `SALD.discreteForwardKlMassTermZeroOfTotalMassDerivative`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfMassDerivativeScalar`; `SALD.cycle90DiscreteForwardKlMassConservationMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle90_middle_mass_derivative_route` | `eq:KL-derivative-0-discrete`; `appendix.tex:338-388` | `sald.discrete_forward_kl.kl_derivative`; `thm:forward-KL-discrete` | formalized local theorem plus obligation |
| Lower mapped-law constant test | Specialize total mass to `s ↦ ∫ 1 d(Measure.map (hatX s) P)`, prove the law integral is one for probability `P`, transport the constant-test derivative with `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`, and feed the raw KL scalar route. | Mathlib `Measure.isProbabilityMeasure_map`; `MeasureTheory.integral_const`; `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; cycle-89 raw split | `SALD.discreteForwardKlLawConstantTestTotalMassOne`; `SALD.discreteForwardKlLawConstantTestHasDerivAtZero`; `SALD.discreteForwardKlMassTermZeroOfLawConstantTestDerivative`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfLawConstantTestMassScalar`; `SALD.cycle90DiscreteForwardKlMassConservationLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle90_lower_law_constant_test_mass` | `eq:KL-derivative-0-discrete`; `appendix.tex:338-388` | `sald.discrete_forward_kl.kl_derivative`; `thm:forward-KL-discrete` | formalized local theorem plus obligation; remaining boundary is `massTerm` derivative identification |
| Active EM exception guard | Keep the shared EM backend on `sald.general_moving_target_discrete.em_interpolation_fp` while allowing this theorem-route sub-boundary because reviewer identified it. | cycles 85-89; active backend `appendix.tex:1358-1387` | `ASTIS.SALD.cycle90.active_em_backend_exception_check` | `appendix.tex:1358-1387` | both discrete theorem routes | obligation |

Lower classification discipline:

- `discharges-supplied-hypothesis`: preferred.  A compiled local theorem
  removes the older supplied `hmass : massTerm = 0` input from the cycle-89 raw
  derivative route.  Cycle 90 middle achieves this at the scalar route by
  replacing `hmass` with a total-mass derivative witness and local
  probability-mass-one normalization.  Cycle 90 lower further specializes that
  normalization to the concrete mapped law `hat rho_s=Law(hat X_s)` and proves
  the constant-test derivative is zero using local Mathlib/Measure.map
  ingredients.
- `narrows-source-cited-boundary`: acceptable if proof is blocked but the
  packet records one exact missing theorem with imports and hypotheses, such as
  derivative of total mass for a differentiable family of probability laws,
  differentiation under an integral for the constant weak test, or
  density-to-measure mass preservation.
- `rejected-wrapper-churn`: any output that only renames or repackages
  `hmass`, or broadens into LSI/DV/Gronwall work before the mass-conservation
  boundary is discharged or exactly blocked.

Mode discipline: faithfulPaper Phase 1 only.  Preserve
`eq:KL-derivative-0-discrete`, `eq:KL-derivative-1-discrete`,
`eq:KL-derivative-2-discrete`, all signs and constants, both discrete theorem
statements, source labels, and the exclusion of `sald_version_2.tex`.  Do not
promote the EM backend, KL derivative, LSI/KL/FI, DV, Gronwall, or theorem
statuses; do not import SLT or change Lake dependencies.

## Cycle 91 Conditional-Kernel Named-Drift Backfill

Global phase judgment: cycle 90 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active packet returns to
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the conditional-kernel and conditional
expectation definition at `appendix.tex:1368-1377`.  The single lower packet
that now reduces the largest remaining proof risk is the named
`hatRhoS=Law(hat X_s)` component-field route for `bar b_{k,s}`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 91 middle source map | obligation | `appendix.tex:1368-1377`; active EM backend | `SALD.cycle91GeneralMovingTargetDiscreteConditionalKernelMiddleObligation`; `ASTIS.SALD.cycle91.middle_conditional_kernel_source_map` |
| Cycle 91 lower named-drift regularity | formalized local theorem plus obligation; `discharges-supplied-hypothesis` | `appendix.tex:1368-1377`; Mathlib `CondDistrib` law-space integral regularity and `ae_map_iff` transport | `SALD.generalMovingTargetDiscreteCondDistribNamedFieldAeEqOfSample`; `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfSampleVersions`; `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularity`; `SALD.cycle91GeneralMovingTargetDiscreteConditionalKernelLowerObligation`; `ASTIS.SALD.cycle91.lower_condDistrib_named_drift_regular` |
| Remaining conditional-kernel boundary | obligation | `appendix.tex:1368-1377`; Mathlib `CondDistrib`/`Condexp` | `ASTIS.SALD.cycle91.remaining_conditional_kernel_boundary`; prove the SALD-specific sample-space conditional-expectation/disintegration equalities for `condC_{k,s}` and `condScore_{k,s}` after composing with `hatXAtS`, plus the measurable equality-set side conditions and conditional-kernel compatibility |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Named conditional-drift regularity | If the canonical `condDistrib X_k^eta hatX_s P` component integrals composed with `hatXAtS` are sample-space a.e. equal to the selected fields `condC` and `condScore` composed with `hatXAtS`, then `ae_map_iff` transports those equalities to `hatRhoS=Law(hatXAtS)` and the Mathlib component regularity theorem plus pointwise `barB` formula yield `AEStronglyMeasurable barB hatRhoS` and `Integrable barB hatRhoS`. | `MeasureTheory.ae_map_iff`; `AutoSamplingTheory.condDistribIntegralNamedFieldRegularity`; `SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityOfComponents`; finite-measure and standard-Borel hypotheses | `SALD.generalMovingTargetDiscreteCondDistribNamedFieldAeEqOfSample`; `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfSampleVersions`; `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularity` | `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteEndpointConditionalDriftRegularityHandoff`; `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | formalized local theorem; discharges law-space component-version and component-field/barB regularity hypotheses |
| Remaining version/disintegration theorem | Construct the SALD-specific sample-space conditional-expectation versions `condC_{k,s}` and `condScore_{k,s}` after composing with `hatXAtS`, prove the measurable equality-set side conditions required by `ae_map_iff`, and connect them to the regular conditional kernel for `X_k^eta | hat X_s=x`. | `Mathlib.Probability.Kernel.CondDistrib`; `Mathlib.Probability.Kernel.Condexp`; source named law `hat rho_s=Law(hat X_s)` | `ASTIS.SALD.cycle91.remaining_conditional_kernel_boundary` | `appendix.tex:1368-1377` | endpoint weak-FP readiness and both discrete theorem routes | obligation |

Lower classification discipline:

- `discharges-supplied-hypothesis`: cycle 91 lower meets this bar by compiling
  `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfSampleVersions`,
  removing the older law-space component-version and component-field/barB
  regularity assumptions once the sample-space conditional component versions
  are supplied.
- `narrows-source-cited-boundary`: the next acceptable packet should prove or
  exactly record the SALD-specific sample-space conditional-expectation /
  disintegration theorem and the measurable equality-set side conditions with
  imports and hypotheses.
- `rejected-wrapper-churn`: any packet that only repackages `hcondC`,
  `hcondScore`, `hmeasOfKernel`, `hintOfKernel`, or endpoint regularity
  hypotheses without tying the named fields to `condDistrib`.

Mode discipline: faithfulPaper Phase 1 only.  Preserve
`appendix.tex:1358-1387`, especially the definition of `bar b_{k,s}` at
`appendix.tex:1368-1377`; do not promote weak-Fokker--Planck, KL derivative,
LSI/KL/FI, DV, Gronwall, theorem closure, SLT reuse, or Lake dependency
status.

## Cycle 92 Upper Weak-FP Generator-to-Law Boundary

Global phase judgment: cycle 91 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, and the single packet that now reduces the largest
proof risk is the generator-to-law weak Fokker--Planck boundary at
`appendix.tex:1379-1387`, specifically the sample-space generator derivative
and drift/diffusion source-action identifications consumed by
`SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleGeneratorPiecesHandoff`.

Faithful-paper objective: turn the paper sentence "By the Fokker--Planck
equation associated with" `eq:general_moving_target_SALD_frozen_interp` into a
lower-ready theorem boundary for admissible weak tests.  Use the cycle-79
`AutoSamplingTheory.lawMapIntegral` /
`AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample` transport and the
cycle-91 named conditional-drift regularity route.  Do not add another wrapper
around the already supplied weak-FP source signs unless it removes one of the
remaining supplied inputs.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 92 active backend check | obligation | `appendix.tex:1358-1387`; sub-slice `appendix.tex:1379-1387` | Keep `sald.general_moving_target_discrete.em_interpolation_fp` as the active backend; no reviewer blocker moved this cycle to theorem-route audit work |
| Cycle 92 lower packet | selected proof-producing packet; classification required | `appendix.tex:1379-1387`; generator-to-law weak FP | Use `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleGeneratorPiecesHandoff` and reduce its remaining supplied inputs: `hsampleGenerator`, `hlawDerivative`, `hgeneratorSplit`, `hdriftSource`, or `hdiffusionSource` |
| Cycle 92 reviewer check | obligation | fixed source signs and coefficient | Reject wrapper churn; preserve `-div(hat rho_s * bar b_{k,s})` and `+(sigma_eta^2/2) Delta hat rho_s`; no status, SLT, or Lake promotion |
| Cycle 92 middle source map | obligation; `discharges-supplied-hypothesis` target | `appendix.tex:1379-1387`; active EM backend | `SALD.cycle92GeneralMovingTargetDiscreteWeakFpGeneratorSplitMiddleObligation`; `ASTIS.SALD.cycle92.middle_generator_to_law_source_map` |
| Cycle 92 lower split-generator handoff | formalized local theorem plus obligation; removes supplied `hgeneratorSplit` | `appendix.tex:1379-1387`; cycle-79 `Measure.map` transport | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorHandoff`; `SALD.cycle92GeneralMovingTargetDiscreteWeakFpGeneratorSplitLowerObligation`; `ASTIS.SALD.cycle92.lower_sample_split_generator_handoff` |
| Cycle 92 lower direct law-derivative handoff | formalized local theorem plus obligation; removes separate `hlawDerivative` for the direct weak-test `HasDerivAt` route | `appendix.tex:1379-1387`; cycle-79 `Measure.map` transport | `SALD.generalMovingTargetDiscreteWeakConditionalFpLawDerivativeOfSampleSplitGeneratorHandoff`; `SALD.cycle92GeneralMovingTargetDiscreteWeakFpGeneratorSplitLowerObligation`; `ASTIS.SALD.cycle92.lower_law_derivative_of_sample_split_generator` |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Sample generator derivative | Prove or strictly isolate `HasDerivAt (fun s => integral omega, phi (hatX s omega) dP) (driftAction phi + diffusionAction phi) s0` for admissible weak tests of the frozen EM interpolation. | Mathlib parametric-integral/Bochner APIs; EM interpolation path differentiability; `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; admissible-test measurability | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpLawDerivativeOfSampleSplitGeneratorHandoff`; cycle-79 law-map helpers | `appendix.tex:1379-1387`; `eq:general_moving_target_SALD_frozen_interp` | weak-FP source signs; KL derivative handoff; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | remaining selected lower boundary |
| Split generator handoff | Replace the separate supplied `hgeneratorSplit` premise with the definitional generator action `driftAction phi + diffusionAction phi`, then reuse the existing sample derivative to law weak-derivative transport and source-sign wrapper. | cycle-86 sample-generator law transport; `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; drift/diffusion source-action hypotheses | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorHandoff`; `SALD.cycle92GeneralMovingTargetDiscreteWeakFpGeneratorSplitLowerObligation` | `appendix.tex:1379-1387` | weak-FP source signs; KL derivative handoff; both discrete theorem routes | formalized local theorem; `discharges-supplied-hypothesis` for `hgeneratorSplit` |
| Direct law-derivative handoff | Transport the sample-space split-generator derivative to the mapped-law weak-test integral and rewrite the derivative value to `-div(hat rho_s * bar b_{k,s}) + (sigma_eta^2/2) Delta hat rho_s`. | `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; split-generator sample derivative; drift/diffusion source-action hypotheses | `SALD.generalMovingTargetDiscreteWeakConditionalFpLawDerivativeOfSampleSplitGeneratorHandoff`; `SALD.cycle92GeneralMovingTargetDiscreteWeakFpGeneratorSplitLowerObligation` | `appendix.tex:1379-1387` | weak-FP source signs; KL derivative handoff; both discrete theorem routes | formalized local theorem; `narrows-source-cited-boundary` for `hlawDerivative` |
| Drift source-action identification | Connect the drift component of the generator action to `-div(hat rho_s * bar b_{k,s})` in weak-test form, using the named conditional drift produced from `condDistrib` component fields. | cycle-91 named conditional-drift regularity; remaining conditional-expectation/disintegration compatibility; boundary/integration-by-parts hypotheses | `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfSampleVersions`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff` | `appendix.tex:1368-1387` | weak-FP source signs and KL derivative | obligation; lower may narrow this if full derivative is blocked |
| Diffusion source-action identification | Connect the Brownian/quadratic-variation generator component to `+(sigma_eta^2/2) Delta hat rho_s` in weak-test form with the exact coefficient. | sample-path Ito/generator calculation; Bochner/parametric integral interchange; diffusion coefficient normalization | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleGeneratorPiecesHandoff` | `appendix.tex:1379-1387` | weak-FP source signs and KL derivative | obligation |

Lower classification discipline:

- `discharges-supplied-hypothesis`: preferred.  A compiled local theorem
  removes at least one currently supplied input to
  `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleGeneratorPiecesHandoff`,
  such as `hsampleGenerator`, `hgeneratorSplit`, `hdriftSource`, or
  `hdiffusionSource`, using Mathlib/local ingredients.
  Cycle 92 middle/lower achieves this for `hgeneratorSplit` by compiling
  `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorHandoff`;
  the direct weak-test derivative route additionally narrows `hlawDerivative`
  by compiling
  `SALD.generalMovingTargetDiscreteWeakConditionalFpLawDerivativeOfSampleSplitGeneratorHandoff`.
- `narrows-source-cited-boundary`: acceptable only if the packet names one
  smaller missing theorem with imports and hypotheses, such as sample-path
  generator differentiation, Bochner/parametric integral interchange, drift
  source-action through `bar b_{k,s}`, or diffusion source-action with
  coefficient `sigma_eta^2/2`.
- `rejected-wrapper-churn`: any packet that merely restates `partialS`,
  `generatorAction`, `driftAction`, `diffusionAction`, source signs, or
  admissibility predicates without removing or strictly narrowing a supplied
  hypothesis.

Mode discipline: faithfulPaper Phase 1 only.  Preserve
`appendix.tex:1379-1387`, the source signs
`-div(hat rho_s * bar b_{k,s})` and `+(sigma_eta^2/2) Delta hat rho_s`, all
discrete theorem statements, source labels, and the exclusion of
`sald_version_2.tex`.  No theorem-route audit, display algebra, LSI/DV/Gronwall
work, broad reusable API cleanup, source-index rebaseline, project-article
export, SLT import, Lake dependency change, or status promotion is in scope.

## Cycle 93 KL/Log-Ratio Mass-Derivative Backfill

Cycle 93 returns to the active EM backend
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to `appendix.tex:1358-1366`.  The selected
boundary is the mass-conservation sentence in
`eq:general_KL_derivative_0_discrete`: `since int partial_s hat rho_s dx=0`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 93 middle source map | obligation; selected `hmass` boundary | `appendix.tex:1358-1366`; active EM backend | `SALD.cycle93GeneralMovingTargetDiscreteKlMassDerivativeMiddleObligation`; `ASTIS.SALD.cycle93.middle_kl_mass_derivative_source_map` |
| Cycle 93 mapped-law mass theorem | formalized local theorem; `discharges-supplied-hypothesis` for primitive `hmass` | `appendix.tex:1354-1366`; `hat rho_s=Law(hat X_s)` | `SALD.generalMovingTargetDiscreteKlMassTermZeroOfLawConstantTestDerivative`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfLawConstantTestMassAndSourceSignsWithLogAction`; `SALD.cycle93GeneralMovingTargetDiscreteKlMassDerivativeLowerObligation`; `ASTIS.SALD.cycle93.lower_law_constant_test_mass` |
| Cycle 93 finite-KL `llr` plus law-mass handoff | formalized local theorem; `discharges-supplied-hypothesis` for primitive `hlog` and `hmass` in the exact `llr` route | `appendix.tex:1358-1366`; `eq:general_KL_derivative_0_discrete` | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfFiniteKlLlrLawConstantTestMassWithLogAction`; `ASTIS.SALD.cycle93.lower_finite_kl_llr_law_mass_handoff`; finite KL plus `SALD.GeneralMovingTargetDiscreteKlLogRatioAdmissibilityClosure` supplies admissibility, while the mapped-law derivative supplies the mass drop |
| Remaining raw KL / target-time boundary | obligation; `narrows-source-cited-boundary` | `appendix.tex:1358-1366` | `ASTIS.SALD.cycle93.remaining_raw_kl_target_time_boundary`; prove `hklRaw`, identify `massTerm` with the constant-test derivative, prove target-time derivative formula, and discharge the cycle-88 closure package internals |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Mapped-law constant weak-test mass | If `massTerm` is the `HasDerivAt` derivative of `s ↦ ∫ 1 d Measure.map (hatX s) P`, then `massTerm=0`; the derivative is zero by `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample` applied to the constant sample-space integral. | `Measure.map`; `AEMeasurable (hatX s)`; probability measure `P`; derivative uniqueness | `SALD.generalMovingTargetDiscreteKlMassTermZeroOfLawConstantTestDerivative` | `appendix.tex:1354-1366` | raw KL handoff; both discrete theorem routes | formalized local theorem |
| Raw KL handoff without primitive `hmass` | Route `dK = partialS(logRatioTest)+massTerm-targetTimeTerm` through the existing weak-FP source signs after deriving `massTerm=0` from the mapped-law constant-test derivative. | raw KL display; admissible log-ratio test; weak-FP source signs; mass derivative witness | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfLawConstantTestMassAndSourceSignsWithLogAction` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | formalized local handoff plus obligation |
| Finite-KL `llr` law-mass handoff | Specialize the raw handoff to `MeasureTheory.llr hatRho tildePi`: finite KL plus the cycle-88 closure package gives admissibility, and the mapped-law constant-test derivative gives `massTerm=0`, so the local handoff no longer needs primitive `hlog` or `hmass`. | `SALD.generalMovingTargetDiscreteKlLogRatioAdmissibleOfFiniteKlClosure`; `SALD.GeneralMovingTargetDiscreteKlLogRatioAdmissibilityClosure`; mapped-law mass theorem; raw KL display; weak-FP source signs | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfFiniteKlLlrLawConstantTestMassWithLogAction` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | formalized local handoff plus obligation |
| Remaining KL differentiability theorem | Prove the raw KL derivative display at the Mathlib `llr` weak test, including the target-time term `-int (hat rho_s/tilde pi_s) partial_s tilde pi_s`. | finite-KL `llr` regularity; cycle-88 closure package internals; weak-FP source signs; density/time regularity | `ASTIS.SALD.cycle93.remaining_raw_kl_target_time_boundary` | `appendix.tex:1358-1366` | integration by parts, FI identification, theorem closure | obligation |

Classification discipline:

- `discharges-supplied-hypothesis`: cycle 93 removes the primitive
  `hmass : massTerm=0` premise from the local general-moving-target KL handoff,
  and removes primitive `hlog` for the exact finite-KL `llr` route by using the
  cycle-88 closure theorem boundary.
- `narrows-source-cited-boundary`: the remaining mass-side analytic theorem is
  the identification of the paper `massTerm` with the mapped-law constant-test
  derivative; `hklRaw`, target-time differentiability, and closure-package
  internals remain separate.
- `rejected-wrapper-churn`: any later packet that only renames `hmass`,
  `hklRaw`, `hlog`, or weak-FP source signs without proving or strictly
  narrowing one of those inputs.

No theorem statement, source label, sign, coefficient, EM/KL backend status,
SLT reuse status, or Lake dependency changed.

## Cycle 94 Conditional-Drift Weak-Action Backfill

Cycle 94 stays on the active EM backend
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the weak Fokker--Planck source line
`appendix.tex:1379-1387` and the conditional drift definition at
`appendix.tex:1368-1377`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 94 middle source map | obligation; selected `hdriftSource` boundary | `appendix.tex:1368-1387` | `SALD.cycle94GeneralMovingTargetDiscreteWeakFpDriftActionMiddleObligation`; `ASTIS.SALD.cycle94.middle_weak_fp_drift_action_source_map` |
| Cycle 94 lower `barB` drift-action handoffs | formalized local theorems plus obligation; `narrows-source-cited-boundary` | `appendix.tex:1379-1387` using `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBWeakAction`; `SALD.generalMovingTargetDiscreteWeakConditionalFpLawDerivativeOfSampleSplitGeneratorBarBActionHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorBarBActionHandoff`; `SALD.cycle94GeneralMovingTargetDiscreteWeakFpDriftActionLowerObligation`; `ASTIS.SALD.cycle94.lower_barB_drift_action_handoff` |
| Remaining `barB` divergence boundary | obligation | `appendix.tex:1368-1387` | `ASTIS.SALD.cycle94.remaining_barB_divergence_boundary`; prove the conditional-expectation generator weak pairing against `barB` and the divergence/no-boundary identity for `hatRhoS * barB` |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Drift source via `barB` weak action | Replace primitive `hdriftSource : driftAction phi = -(driftDiv phi)` by two source-cited facts: `driftAction phi` is the weak test-gradient pairing against the named conditional drift `barB`, and that pairing is `-(driftDiv phi)` by the divergence/no-boundary theorem. | cycle-91 named conditional drift regularity; cycle-92 sample-split generator handoffs; weak-test boundary hypotheses | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBWeakAction` | `appendix.tex:1368-1387` | law-derivative and source-sign handoffs | formalized local theorem; smaller source-cited boundary |
| Direct law-derivative handoff without primitive `hdriftSource` | Feed the derived `barB` drift source into the direct mapped-law derivative route. | `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; split generator sample derivative; diffusion source action | `SALD.generalMovingTargetDiscreteWeakConditionalFpLawDerivativeOfSampleSplitGeneratorBarBActionHandoff` | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; both discrete theorem routes | formalized local handoff plus obligation |
| Source-sign handoff without primitive `hdriftSource` | Feed the same derived `barB` drift source into the normalized weak-FP source-sign route, so both source-sign and direct derivative consumers use the smaller boundary. | cycle-92 source-sign sample-split handoff; weak law derivative; diffusion source action | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorBarBActionHandoff` | `appendix.tex:1379-1387` | weak-FP source signs; KL derivative handoff; both discrete theorem routes | formalized local handoff plus obligation |
| Remaining analytic theorem | Prove the conditional-expectation generator identity through `condDistrib` and the integration-by-parts/no-boundary theorem identifying the `barB` weak pairing with `-div(hatRhoS * barB)`. | Mathlib conditional kernels; divergence theorem / weak integration by parts; admissible test and boundary hypotheses | `ASTIS.SALD.cycle94.remaining_barB_divergence_boundary` | `appendix.tex:1368-1387` | weak FP backend and KL handoff | obligation |

Classification: `narrows-source-cited-boundary`.  The primitive
`hdriftSource` hypothesis is no longer used by the new cycle-94 lower routes;
it is replaced by the two exact `barB` weak-action facts above.  Conditional
expectation/disintegration for the drift action, the divergence/no-boundary
theorem, diffusion source action, sample-path generator differentiation,
density/time regularity, admissible-test closure, weak FP theorem, KL
derivative, theorem status, SLT reuse, and Lake dependencies remain
unpromoted.

## Cycle 95 Discrete Forward-KL Pressure Test

Global phase judgment: cycle 94 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The single lower packet that now reduces the largest proof risk is
still the active EM backend
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the `barB` conditional-expectation
generator pairing and divergence/no-boundary theorem at
`appendix.tex:1368-1387`.

Cycle focus: route `thm:forward-KL-discrete` through the currently compiled EM
wrappers and existing LSI/DV/Gronwall interfaces.  The pressure test reaches
the shared weak-FP source-sign backend before any new scalar theorem wrapper is
useful.  The next exact non-wrapper blocker is
`ASTIS.SALD.cycle94.remaining_barB_divergence_boundary`, feeding
`SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBWeakAction`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 95 upper pressure route | obligation; selected backend blocker | `main_body.tex:299-323`; `appendix.tex:1358-1387` | `SALD.cycle95DiscreteForwardKlClosurePressureUpperPacket`; `SALD.cycle95DiscreteForwardKlClosurePressureUpperObligation`; `ASTIS.SALD.forward_KL_discrete.cycle95_pressure_route` |
| Cycle 95 middle route audit | obligation; `narrows-source-cited-boundary` | `main_body.tex:299-323`; `appendix.tex:1368-1387` | `SALD.cycle95DiscreteForwardKlClosurePressureMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle95_middle_route_audit`; confirms the next lower packet is the existing `barB` divergence boundary, not another theorem-display wrapper |
| Cycle 95 lower component-pairing reduction | formalized local theorem plus obligation; `narrows-source-cited-boundary` | `appendix.tex:1368-1387` | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftActionOfBarBComponentPairings`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBComponentPairings`; `SALD.cycle95DiscreteForwardKlClosurePressureLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle95_lower_barB_component_pairing` |
| Next blocker | obligation; `narrows-source-cited-boundary` | `appendix.tex:1368-1387` | `ASTIS.SALD.forward_KL_discrete.cycle95_next_blocker`; `ASTIS.SALD.cycle94.remaining_barB_divergence_boundary`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBWeakAction` |
| Reviewer check | obligation | active EM backend and theorem pressure route | `ASTIS.SALD.cycle95.reviewer_pressure_check`; reject wrapper churn around `hdriftSource`, source signs, KL mass/log-ratio inputs, LSI/DV/Gronwall, or display algebra |

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Discrete theorem pressure route | Existing compiled wrappers carry `thm:forward-KL-discrete` through EM/KL handoffs, LSI, DV, Gronwall, and accumulated-error display under named analytic inputs. | cycles 89-94; `SALD.discreteForwardKlPostLsiDerivativeBoundOfLawConstantTestMassScalar`; `SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`; `SALD.discreteForwardKlMainDisplayBoundScalar` | `SALD.cycle95DiscreteForwardKlClosurePressureUpperObligation`; `ASTIS.SALD.forward_KL_discrete.cycle95_pressure_route` | `main_body.tex:299-323`; `appendix.tex:260-592`; `appendix.tex:1358-1387` | `thm:forward-KL-discrete` | obligation |
| Middle source-to-Lean audit | Middle verifies that the compiled route already reaches the shared weak-FP source-sign backend and keeps lower work on the smaller `barB` conditional-expectation/divergence facts. | cycle 95 upper; cycle 94 lower; cycle 93 lower; existing LSI/DV/Gronwall route | `SALD.cycle95DiscreteForwardKlClosurePressureMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle95_middle_route_audit` | `main_body.tex:299-323`; `appendix.tex:1368-1387` | `thm:forward-KL-discrete`; `sald.general_moving_target_discrete.em_interpolation_fp` | obligation |
| Lower component-pairing reduction | Local algebra reduces `driftAction phi = weakGradPairing barB phi` to component pairings against `condC` and `condScore`, using the paper component formula for `barB` and linearity/congruence of the weak gradient pairing. | cycle-91 named drift regularity; cycle-94 barB weak-action handoff | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftActionOfBarBComponentPairings`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBComponentPairings` | `appendix.tex:1368-1377`; `appendix.tex:1379-1387` | weak-FP source signs; both discrete theorem routes | formalized local theorem plus obligation |
| Component generator pairings | Prove the frozen EM drift generator component action equals the weak test-gradient pairing against `condC` and `condScore`, using the conditional expectation in the source definition of `bar b_{k,s}`. | `Mathlib.Probability.Kernel.CondDistrib`; `Mathlib.Probability.Kernel.Condexp`; cycle-91 named drift regularity | `ASTIS.SALD.forward_KL_discrete.cycle95_next_blocker` | `appendix.tex:1368-1377` | weak-FP source signs; both discrete theorem routes | obligation |
| `barB` divergence/no-boundary | Prove the weak pairing against `barB` equals `-(driftDiv phi)` for `hatRhoS * barB` with the source boundary hypotheses. | `Mathlib.MeasureTheory.Integral.DivergenceTheorem`; Bochner integral APIs; weak-test admissibility | `ASTIS.SALD.cycle94.remaining_barB_divergence_boundary` | `appendix.tex:1379-1387` | weak-FP source signs; KL handoff; both discrete theorem routes | obligation |

Classification: `narrows-source-cited-boundary`.  A later lower packet is
`discharges-supplied-hypothesis` only if it proves one of the two `barB`
facts above and removes the corresponding cycle-94 supplied input.  A packet
that only rephrases `hdriftSource`, source signs, KL mass/log-ratio inputs,
LSI/DV/Gronwall, or display algebra is `rejected-wrapper-churn`.

## Cycle 96 Condexp Generator-Pairing Middle Packet

Cycle 96 upper rejected the non-EM LSI/DV/Gronwall fallback: the active EM
backend still has named blockers, so middle keeps the packet on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Non-EM fallback guard | obligation; `rejected-wrapper-churn` guard | `appendix.tex:1358-1387` | `ASTIS.SALD.cycle96.middle_non_em_fallback_rejected`; no LSI/DV/Gronwall fallback while conditional-law and divergence/no-boundary EM blockers remain named |
| Component condexp generator pairing | obligation; `narrows-source-cited-boundary` | `appendix.tex:1368-1377` | `SALD.cycle96GeneralMovingTargetDiscreteCondexpGeneratorPairingMiddleObligation`; `ASTIS.SALD.cycle96.middle_condexp_generator_pairing_boundary`; prove one condC/condScore generator weak-action pairing from Mathlib `CondDistrib`/`Condexp`, named `hatRhoS = Law(hatX_s)`, and existing local conditional-integral regularity/versioning helpers |
| Cycle 96 lower one-component handoff | formalized local theorem plus obligation; `narrows-source-cited-boundary` | `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfAeVersion`; `SALD.cycle96GeneralMovingTargetDiscreteCondexpGeneratorPairingLowerObligation`; `ASTIS.SALD.cycle96.lower_condDistrib_component_pairing_handoff`; reduces a named `condC`/`condScore` weak pairing to the canonical `condDistrib` integral action plus `hatRhoS`-a.e. field-version congruence |
| Lower packet classification | obligation | `appendix.tex:1368-1377`; `appendix.tex:1379-1387` | `ASTIS.SALD.cycle96.lower_packet.condexp_component_generator_pairing`; `discharges-supplied-hypothesis` only if one component pairing premise is proved and removed; otherwise record one smaller missing Mathlib theorem |

The selected lower theorem boundary is smaller than the cycle-95 blocker:
identify the generator weak action for `condC` or `condScore` before attempting
the separate divergence/no-boundary theorem for `hatRhoS * barB`.

Cycle 96 lower compiles the local `hatRhoS`-a.e. versioning handoff for one
component pairing.  The remaining exact theorem is now the canonical
`condDistrib`/`condexp` generator identity for the conditional-integral field
itself; the regular conditional law, weak Fokker-Planck equation, KL derivative,
and divergence/no-boundary theorem are still unproved analytic boundaries.

No theorem statement, source label, sign, coefficient, EM/KL backend status,
SLT reuse status, or Lake dependency changed.

## Cycle 97 Canonical CondDistrib Disintegration Pairing

Cycle 97 keeps the active backend on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the conditional drift definition at
`appendix.tex:1368-1377`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 97 global judgment | obligation | `appendix.tex:1358-1387`; active EM backend | `ASTIS.SALD.cycle97.global_phase_judgment`; no recovery from cycle 96, Phase 1 stable enough for cited-theory backfill, selected lower packet is the canonical `condDistrib` disintegration pairing |
| Compiled map-law disintegration theorem | formalized local theorem; `discharges-supplied-hypothesis` for the map-law part of cycle-96 `hcanonical` | `appendix.tex:1368-1377`; Mathlib `CondDistrib.lean` | `AutoSamplingTheory.condDistribIntegralMapIntegral`; `AutoSamplingTheory.condDistribIntegralNamedLawIntegral`; `ASTIS.SALD.cycle97.compiled_condDistrib_disintegration_pairing` |
| Compiled canonical component pairing handoff | formalized local theorem; `narrows-source-cited-boundary` by removing raw `hcanonical` | `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfIntegralAction`; `SALD.cycle97GeneralMovingTargetDiscreteCanonicalCondDistribPairingLowerObligation`; `ASTIS.SALD.cycle97.lower_packet.canonical_condDistrib_component_pairing`; instantiate the compiled theorem with the weak test-gradient paired component integrand and feed `SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfAeVersion` |
| Wrapper-churn guard | obligation; `rejected-wrapper-churn` guard | `appendix.tex:1368-1387` | `ASTIS.SALD.cycle97.rejected_wrapper_churn_guard`; reject fresh wrappers around `hcanonical`, `hdriftSource`, source signs, KL, LSI, DV, Gronwall, or display algebra |

Exact remaining theorem boundary for lower/reviewer: prove the
definition-alignment and paired-integrability facts that remain as hypotheses
of `SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfIntegralAction`.
Required imports are `AutoSamplingTheory.Probability` and Mathlib
`Probability.Kernel.CondDistrib`/`Condexp`; required hypotheses are finite
`P`, a.e. measurability of `hatX_s` and `X_k^eta`, standard-Borel and nonempty
conditioned state, `hatRhoS = P.map hatX_s`, and integrability of the paired
test-gradient component under the joint law of
`(hatX_s, X_k^eta)`.

## Cycle 98 BarB No-Boundary Integral Boundary

Cycle 98 returns to the generator-to-law weak-FP source-sign line at
`appendix.tex:1379-1387`.  It targets the divergence/no-boundary half of
`ASTIS.SALD.cycle94.remaining_barB_divergence_boundary`, not the conditional
component-pairing side from cycles 96--97.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 98 middle source map | obligation; `narrows-source-cited-boundary` | `appendix.tex:1379-1387`; active EM backend | `SALD.cycle98GeneralMovingTargetDiscreteBarBDivergenceNoBoundaryMiddleObligation`; `ASTIS.SALD.cycle98.middle_barB_divergence_no_boundary_source_map` |
| Compiled integral no-boundary handoff | formalized local theorem plus obligation; removes raw `hbarBWeakDivergence` under smaller hypotheses | `appendix.tex:1379-1387`; Mathlib divergence theorem candidate | `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryIntegral`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBNoBoundaryIntegral`; `SALD.cycle98GeneralMovingTargetDiscreteBarBDivergenceNoBoundaryLowerObligation`; `ASTIS.SALD.cycle98.lower_packet.barB_no_boundary_integral` |
| Bounded-pairing integrability discharge | formalized local theorem; `discharges-supplied-hypothesis` for `hpairIntegrable` under a concrete norm bound | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` for `barB` integrability | `SALD.generalMovingTargetDiscreteBarBPairIntegrableOfNormBound`; `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryBoundedPairing`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBBoundedNoBoundaryIntegral` |
| Remaining exact theorem | obligation | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` for `barB` regularity support | `ASTIS.SALD.cycle98.remaining_exact_no_boundary_theorem`; prove the concrete a.e. norm bound for the test-gradient contraction, align `weakGradPairing` with its `hatRhoS` law integral, and prove `driftDiv phi` is the negative of that integral by the no-boundary divergence theorem |

Classification: `discharges-supplied-hypothesis` for the abstract
`hpairIntegrable` premise, and `narrows-source-cited-boundary` for the
still-open analytic IBP identity.  This is not a new `hbarBWeakDivergence`
wrapper: the primitive equality is no longer the lower target.  The remaining
lower packet is the concrete a.e. test-gradient contraction bound,
integration-by-parts theorem for `hatRhoS * barB`, plus the
weak-pairing/drift-divergence definition equalities under admissible-test and
boundary hypotheses.

## Cycle 99 Raw KL Finite-KL `llr` Boundary

Cycle 99 returns to the KL/log-ratio analytic line at
`appendix.tex:1358-1366`.  It reuses the cycle-87 finite-KL `llr`
regularity, cycle-88 admissibility closure, and cycle-93 mapped-law mass
handoff.  The selected boundary is the remaining raw KL differentiability
display, not the `barB` no-boundary route.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 99 middle source map | obligation; `narrows-source-cited-boundary` | `appendix.tex:1358-1366`; active EM/KL backend | `SALD.cycle99GeneralMovingTargetDiscreteRawKlDerivativeMiddleObligation`; `ASTIS.SALD.cycle99.middle_raw_kl_derivative_source_map` |
| Raw KL finite-KL `llr` package | source-cited analytic theorem boundary | `appendix.tex:1358-1366`; Mathlib KL/`llr` and parametric-integral APIs | `SALD.GeneralMovingTargetDiscreteRawKlDerivativeAtFiniteKlLlr`; `ASTIS.SALD.cycle99.raw_kl_derivative_at_finite_kl_llr`; expose finite KL, `hatX` a.e. measurability, density/path regularity, endpoint-safe KL differentiation, `llr` weak-action integrability, target-time term integrability/formula, and mapped-law constant-test mass derivative |
| No-mass raw KL finite-KL `llr` package | source-cited analytic theorem boundary; strictly smaller than the mass-derivative package | `appendix.tex:1358-1366`; Mathlib KL/`llr` and parametric-integral APIs | `SALD.GeneralMovingTargetDiscreteRawKlDerivativeNoMassAtFiniteKlLlr`; `ASTIS.SALD.cycle99.no_mass_raw_kl_derivative_at_finite_kl_llr`; expose finite KL, `hatX` a.e. measurability, density/path regularity, endpoint-safe KL differentiation, `llr` weak-action integrability, and target-time term integrability/formula, with no mapped-law mass-derivative field |
| Compiled no-mass package-to-handoff route | formalized local handoff plus obligation; removes primitive `hklRaw` and the package-level mass-derivative field from the exact `llr` route once the no-mass source-cited package is supplied | `appendix.tex:1358-1366`; `eq:general_KL_derivative_0_discrete` | `SALD.generalMovingTargetDiscreteRawKlDerivativeNoMassAtFiniteKlLlrHkl`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfNoMassRawKlBoundaryAtFiniteKlLlrWithLogAction`; `SALD.cycle99GeneralMovingTargetDiscreteRawKlDerivativeLowerObligation`; `ASTIS.SALD.cycle99.lower_packet.raw_kl_llr_handoff` |
| Remaining exact theorem | source-cited obligation | `appendix.tex:1358-1366` | Prove `SALD.GeneralMovingTargetDiscreteRawKlDerivativeNoMassAtFiniteKlLlr` from Mathlib finite-KL/`llr` regularity, `ParametricIntegral`/Bochner differentiation under the KL integral, and target-time derivative integrability/formula; keep cycle-88 admissibility closure internals, weak FP, downstream IBP/FI, LSI, DV, Gronwall, and theorem closure separate |

The lower-ready theorem boundary is strictly smaller than the old
`ASTIS.SALD.cycle93.remaining_raw_kl_target_time_boundary`: finite KL already
selects the `MeasureTheory.llr` representative and discharges its
measurability/integrability; the lower no-mass handoff now proves the mapped-law
constant-test derivative internally.  What remains is the endpoint-safe
no-mass KL differentiation and target-time analytic theorem.

Classification: `narrows-source-cited-boundary`.  This rejects wrapper churn
around `hklRaw`, `hlog`, `hmass`, weak-FP source signs, LSI/DV/Gronwall, and
display algebra.  No theorem statement, source label, sign, coefficient,
theorem status, SLT reuse status, or Lake dependency changed.

## Cycle 100 BarB Weak-Pairing Definition Alignment

Cycle 100 narrows the generator-to-law weak-FP drift-source boundary at
`appendix.tex:1379-1387`.  The selected supplied hypothesis is
`hweakGradIntegral` from the cycle-98 bounded no-boundary route.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 100 middle source map | obligation; `narrows-source-cited-boundary` | `appendix.tex:1379-1387`; active EM backend | `SALD.cycle100GeneralMovingTargetDiscreteBarBWeakGradDefMiddleObligation`; `ASTIS.SALD.cycle100.middle_barB_weakGrad_def_source_map` |
| Compiled weak-pairing definition alignment | formalized local theorem plus obligation; removes `hweakGradIntegral` under explicit weak-pairing definition | `appendix.tex:1379-1387`; Bochner law integral notation | `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryBoundedPairingWeakGradDef`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBBoundedNoBoundaryWeakGradDef`; `SALD.cycle100GeneralMovingTargetDiscreteBarBWeakGradDefLowerObligation`; `ASTIS.SALD.cycle100.lower_packet.barB_weakGrad_definition_alignment` |
| Inner-gradient contraction handoff | formalized local theorem plus obligation; removes `hpairNormBound` when the weak-test contraction is the real inner product of `testGrad phi` with `barB` | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` for `barB` regularity support | `SALD.generalMovingTargetDiscreteBarBPairNormBoundOfInnerGradientBound`; `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryInnerGradientBound`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientBound`; `SALD.cycle100GeneralMovingTargetDiscreteBarBInnerGradientBoundLowerObligation`; `ASTIS.SALD.cycle100.lower_packet.barB_inner_gradient_contraction` |
| Remaining no-boundary theorem | obligation | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` for `barB` regularity support | `ASTIS.SALD.cycle100.remaining_no_boundary_after_weakGrad_def`; prove the concrete a.e. norm bound for `fieldPairing phi barB`, and prove `driftDiv phi = - int x, fieldPairing phi barB x d hatRhoS` by the no-boundary divergence theorem for `hatRhoS * barB` |

Classification: `narrows-source-cited-boundary`.  This is not wrapper churn
around `hbarBWeakDivergence`: the old `hweakGradIntegral` premise is removed
by specializing `weakGradPairing f phi` to the `hatRhoS` law integral of
`fieldPairing phi f`.  The contraction bound, no-boundary IBP/divergence
theorem, weak FP, KL derivative, theorem closure, SLT import, and Lake
dependency status are unchanged.

Cycle-100 lower additionally narrows the contraction part of the remaining
theorem.  When `fieldPairing phi barB x` is the real inner product
`inner (testGrad phi x) (barB x)`, Cauchy--Schwarz proves the old
`hpairNormBound` premise from the smaller weak-test gradient estimate
`||testGrad phi x|| <= pairBound phi`.  The remaining exact boundary is now
`ASTIS.SALD.cycle100.remaining_no_boundary_after_inner_gradient`: prove that
weak-test gradient bound and prove
`driftDiv phi = - int x, inner (testGrad phi x) (barB x) d hatRhoS` by the
no-boundary divergence theorem for `hatRhoS * barB`.

## Cycle 101 Discrete Forward-KL Closure Pressure Sync

Classification: `narrows-source-cited-boundary`.

Cycle 101 pressure-tests `thm:forward-KL-discrete` through the currently
compiled EM wrappers and the existing LSI/DV/Gronwall/accumulated-error
interfaces.  The test does not create a new theorem-route wrapper: cycles 89
and 95 already record that route, and cycle 100 supplies the latest compiled
weak-pairing and inner-gradient handoffs.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 101 middle pressure sync | obligation; `narrows-source-cited-boundary` | `main_body.tex:301-323`; `appendix.tex:260-592`; active backend `appendix.tex:1379-1387` | `SALD.cycle101DiscreteForwardKlClosurePressureMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle101_middle_pressure_sync` |
| Next non-wrapper blocker | obligation; selected lower packet | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` for `barB` | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientBound`; `ASTIS.SALD.cycle100.remaining_no_boundary_after_inner_gradient`; `ASTIS.SALD.forward_KL_discrete.cycle101_next_non_wrapper_blocker` |
| Product-rule no-boundary handoff | formalized local theorem plus obligation; `narrows-source-cited-boundary` | `appendix.tex:1379-1387`; Mathlib divergence theorem candidate | `SALD.generalMovingTargetDiscreteDriftDivNoBoundaryOfProductRule`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientProductRuleBoundary`; `SALD.cycle101DiscreteForwardKlNoBoundaryProductRuleLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle101_lower_product_rule_handoff` |

Cycle 101 lower compiles the product-rule/no-boundary algebraic handoff.  The
old monolithic `hdivNoBoundary` premise is narrowed to three source-facing
inputs: the product-rule expansion of `div(hatRhoS * barB * phi)`, the Mathlib
divergence-theorem boundary-flux identity, and zero boundary flux for the
admissible test.  The weak-test gradient estimate
`||testGrad phi x|| <= pairBound phi` remains explicit.

Next lower should target the Euclidean weighted-field product rule or the
zero-boundary-flux/divergence-theorem instantiation for `hatRhoS * barB`.  A
packet that only restates `hdivNoBoundary`, `hgradNormBound`, KL, LSI, DV,
Gronwall, or display algebra is `rejected-wrapper-churn`.

## Cycle 102 Zero-Flux Trace Boundary

Classification: `narrows-source-cited-boundary`.

Cycle 102 stays on the active EM backend over `appendix.tex:1379-1387` and
rejects the non-EM LSI/DV/Gronwall fallback because no named Mathlib blocker
stops the current no-boundary route.  The compiled Lean handoff narrows the
cycle-101 raw zero-flux input:

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Zero boundary flux as trace product | formalized local theorem plus obligation; `narrows-source-cited-boundary` | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` for `barB` | `SALD.generalMovingTargetDiscreteZeroBoundaryFluxOfTraceProductZero`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientTraceBoundary`; `SALD.cycle102DiscreteForwardKlZeroFluxTraceBoundaryMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle102_zero_flux_trace_boundary` |
| Trace product from zero test trace | formalized local theorem plus obligation; `narrows-source-cited-boundary` | `appendix.tex:1379-1387`; compact-support/decay interpretation of admissible weak tests | `SALD.generalMovingTargetDiscreteTraceProductZeroOfTestTraceZero`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientTraceBoundaryOfTestTraceZero`; `SALD.cycle102DiscreteForwardKlTraceZeroLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle102_test_trace_zero_lower` |
| Remaining trace boundary | obligation; selected lower packet | `appendix.tex:1379-1387`; Mathlib divergence theorem / trace setup | `ASTIS.SALD.forward_KL_discrete.cycle102_next_trace_boundary_blocker`; prove `hboundaryFluxIntegral` for `hatRhoS * barB` and prove zero boundary trace a.e. for admissible tests |

The old `hzeroBoundary : boundaryFlux phi = 0` premise in
`SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientProductRuleBoundary`
is now replaced by two smaller source-facing facts:
`boundaryFlux phi` is the boundary integral of the admissible test trace times
the normal trace of `hatRhoS * barB`, and that trace product is zero a.e. on the
boundary by compact support, decay at infinity, or zero normal trace.
The lower handoff further discharges the product-zero premise from the smaller
condition `testTrace phi = 0` a.e. on the boundary, matching the compact
support/zero boundary trace route for admissible weak tests.

The Euclidean weighted-field product rule, the Mathlib divergence-theorem
boundary-flux instantiation, the boundary-flux integral representation, the
zero-trace/compact-support proof, and `hgradNormBound` remain unproved analytic
boundaries.  No theorem status is promoted, no SLT theorem is imported or
marked formalized, and no Lake dependency changes.

## Cycle 103 Conditional-Kernel Component Version Boundary

Classification: `narrows-source-cited-boundary`.

Cycle 103 narrows `ASTIS.SALD.cycle91.remaining_conditional_kernel_boundary`
to one component behind `appendix.tex:1368-1377`, namely the guide component
`condC`.  Lower compiled a bridge that no longer takes the same sample-space
equality as a premise; it derives that equality from a measure-valued
`condDistrib`/`condExpKernel.map` a.e. alignment and a selected
`condExpKernel.map` field version.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 103 middle component-version source map | obligation; `narrows-source-cited-boundary` | `appendix.tex:1368-1377`; active EM conditional drift backend | `SALD.cycle103GeneralMovingTargetDiscreteConditionalKernelVersionMiddleObligation`; `ASTIS.SALD.cycle103.middle_conditional_kernel_component_version` |
| Cycle 103 lower `condExpKernel.map` bridge | formalized local bridge; `narrows-source-cited-boundary` | `appendix.tex:1368-1377`; named `condC` component | `AutoSamplingTheory.condDistribIntegralSampleAeEqOfCondExpKernelMap`; `SALD.generalMovingTargetDiscreteCondDistribNamedFieldAeEqOfCondExpKernelMap`; `ASTIS.SALD.cycle103.lower_condExpKernel_map_version_bridge` |
| Exact remaining `condC` theorem | obligation; selected lower packet | `appendix.tex:1368-1377`; Mathlib `CondDistrib`/`Condexp` | `ASTIS.SALD.cycle103.condC_condDistrib_condExpKernel_sample_version` |

Compiled lower bridge:

```text
If

  condDistrib X_k^eta hatXAtS P (hatXAtS omega)
  = condExpKernel P (mState.comap hatXAtS).map X_k^eta omega

holds P-a.e. as a measure-valued kernel equality, and condC is selected so that

  integral y, guideIntegrand (hatXAtS omega, y)
    d condExpKernel P (mState.comap hatXAtS).map X_k^eta omega
  = condC (hatXAtS omega)

holds P-a.e., then the old condDistrib sample-space equality follows.
```

Exact remaining theorem boundary:

```text
Prove the measure-valued kernel equality above, prove the selected
condExpKernel.map guide-component version for condC, and prove that the
equality set

  {x | integral y, guideIntegrand (x,y) d condDistrib X_k^eta hatXAtS P x
       = condC x}

is measurable for the ae_map_iff transport used by
SALD.generalMovingTargetDiscreteCondDistribNamedFieldAeEqOfSample.
```

Required imports and hypotheses:

- `Mathlib.Probability.Kernel.CondDistrib`,
  `Mathlib.Probability.Kernel.Condexp`, and Bochner integral basics.
- Finite-measure/standard-Borel assumptions and nonempty state space.
- `hatRhoS = P.map hatXAtS`.
- `AEMeasurable hatXAtS P` and `AEMeasurable X_k^eta P`.
- `guideIntegrand` measurable/integrable on
  `P.map (fun omega => (hatXAtS omega, X_k^eta omega))`.
- The measure-valued `condDistrib`/`condExpKernel.map` a.e. equality.
- The selected conditional-expectation version definition for `condC` through
  `condExpKernel P ((inferInstance : MeasurableSpace State).comap hatXAtS)`
  mapped by `X_k^eta`.
- Any measurable equality-set side condition needed for `ae_map_iff`.

The score component, weak-FP source signs, no-boundary theorem for
`hatRhoS * barB`, KL derivative, LSI, DV, Gronwall, theorem status, SLT import,
and Lake dependency status remain unchanged.

## Cycle 104 Named-Law Generator-To-Law Transport

Classification: `discharges-supplied-hypothesis`.

Cycle 104 targets the generator-to-law weak-FP sentence at
`appendix.tex:1379-1387` while keeping the active packet on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.  It removes the primitive named-law
`hlawDerivative`/rewrite premise from the direct weak-test derivative route:
after `hatRhoS s = Measure.map (hatX s) P`, the sample-space split-generator
derivative is transported to the named law path by a compiled local theorem.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 104 upper named-law transport packet | obligation; `discharges-supplied-hypothesis` | `appendix.tex:1379-1387`; active EM weak-FP backend | `SALD.cycle104GeneralMovingTargetDiscreteWeakFpNamedLawTransportUpperObligation`; `ASTIS.SALD.cycle104.global_phase_judgment` |
| Generic named-law derivative transport | formalized local theorem | Mathlib `Measure.map`/Bochner integral transport | `AutoSamplingTheory.lawIntegralHasDerivAtOfMeasureMapEqAndSample` |
| SALD named-law split-generator derivative handoff | formalized local theorem; removes named-law `hlawDerivative` premise | `appendix.tex:1379-1387` | `SALD.generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfSampleSplitGeneratorHandoff`; `ASTIS.SALD.cycle104.lower_packet.named_law_generator_to_law_transport` |
| Remaining generator-to-law theorem boundary | obligation | `appendix.tex:1368-1387` | `ASTIS.SALD.cycle104.remaining_generator_to_law_after_named_transport` |

Compiled local theorem shape:

```text
If

  hatRhoS s = Measure.map (hatX s) P

for all s, and each admissible test has a sample-space derivative

  d/ds int omega, phi (hatX s omega) dP
    = driftAction phi + diffusionAction phi,

then

  d/ds int x, phi x d(hatRhoS s)
    = -driftDiv phi + (sigma_eta^2/2) * laplacian phi

after the drift and diffusion source-action equalities are supplied.
```

Remaining exact analytic boundaries:

- sample-path/Bochner parametric-integral derivative of the split generator
  sum for the frozen EM interpolation;
- driftAction identification through the named conditional drift `barB` and
  the no-boundary divergence theorem for `hatRhoS * barB`;
- diffusionAction identification with the Laplacian source action and
  coefficient `sigma_eta^2/2`;
- weak-test measurability/admissibility, density/time regularity, and
  conditional-law compatibility.

Rejected wrapper churn: do not add wrappers that merely restate `hgenerator`,
`hlawDerivative`, `hdriftSource`, `hdivNoBoundary`, `hgradNormBound`, KL, LSI,
DV, Gronwall, or theorem-display assumptions.  The lower packet is only useful
if it proves the remaining sample-path derivative/source-action theorem or
strictly narrows one of those exact named boundaries.

## Cycle 105 Pure No-Mass KL/Log-Ratio Boundary

Classification: `narrows-source-cited-boundary`.

Cycle 105 targets the KL/log-ratio sentence at `appendix.tex:1358-1366`.
It narrows the cycle-99 no-mass raw-KL package by removing data that belongs
only to the earlier mass-conservation route.  The remaining source-cited
theorem is now a pure measure-path KL differentiability statement at the
finite-KL Mathlib `llr` weak test.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 105 middle source map | obligation; `narrows-source-cited-boundary` | `appendix.tex:1358-1366`; active EM/KL backend | `SALD.cycle105GeneralMovingTargetDiscretePureRawKlDerivativeMiddleObligation`; `ASTIS.SALD.cycle105.middle_pure_raw_kl_derivative_source_map` |
| Pure no-mass finite-KL `llr` package | source-cited analytic theorem boundary; strictly smaller than cycle 99 | `appendix.tex:1358-1366`; Mathlib KL/`llr` and parametric-integral APIs | `SALD.GeneralMovingTargetDiscretePureRawKlDerivativeNoMassAtFiniteKlLlr`; exposes finite KL, density/path regularity, endpoint-safe KL differentiation, `llr` weak-action integrability, target-time integrability, and target-time derivative formula, with no `P`, `hatX`, `s0`, `hatX_aemeasurable`, or mass-derivative field |
| Compiled pure package-to-handoff route | formalized local handoff plus obligation; `narrows-source-cited-boundary` | `appendix.tex:1358-1366`; `eq:general_KL_derivative_0_discrete` | `SALD.generalMovingTargetDiscretePureRawKlDerivativeNoMassAtFiniteKlLlrHkl`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfPureNoMassRawKlBoundaryAtFiniteKlLlrWithLogAction`; `SALD.cycle105GeneralMovingTargetDiscretePureRawKlDerivativeLowerObligation`; `ASTIS.SALD.cycle105.lower_packet.pure_raw_kl_llr_handoff` |
| Remaining exact theorem | obligation | `appendix.tex:1358-1366` | `ASTIS.SALD.cycle105.remaining_pure_raw_kl_boundary`; prove endpoint-safe no-mass KL differentiation and target-time derivative formula from finite-KL `llr` regularity, density/time regularity, and Mathlib parametric-integral/Bochner APIs |

This rejects wrapper churn around `hklRaw`, `hlog`, `hmass`, weak-FP source
signs, `barB` no-boundary hypotheses, LSI, DV, Gronwall, and theorem-display
assumptions.  It does not promote KL differentiability, weak FP, IBP/FI, either
discrete theorem, SLT reuse, or Lake dependencies.

## Cycle 111 Target-Time KL Derivative

Classification: `narrows-source-cited-boundary`.

Cycle 111 keeps the KL/log-ratio packet at `appendix.tex:1358-1366` and
narrows `ASTIS.SALD.cycle105.remaining_pure_raw_kl_boundary` to the target-time
subterm in `eq:general_KL_derivative_0_discrete`:
`- int (hat rho_s / tilde pi_s) * partial_s tilde pi_s dx`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 111 middle target-time source map | obligation; `narrows-source-cited-boundary` | `appendix.tex:1358-1366`; target-time part of `eq:general_KL_derivative_0_discrete` | `SALD.cycle111GeneralMovingTargetDiscreteTargetTimeDerivativeMiddleObligation`; `ASTIS.SALD.cycle111.middle_target_time_derivative_boundary` |
| Dominated weighted target derivative | formalized local theorem; smaller than the cycle-105 pure raw-KL package | `appendix.tex:1358-1366`; Mathlib parametric-integral backend | `SALD.generalMovingTargetDiscreteTargetTimeDerivativeOfDominated`; a fixed density-ratio weight, target-density pointwise `HasDerivAt`, local domination, and term identification imply weighted derivative integrability and the `HasDerivAt` formula for the weighted target integral |
| Source density-ratio congruence | formalized local bridge; narrows representative identification | `appendix.tex:1358-1366`; paper ratio `hat rho_s / tilde pi_s` | `SALD.generalMovingTargetDiscreteTargetTimeDerivativeSourceRatioCongr`; if the chosen fixed weight agrees a.e. with the source density-ratio representative, the target-time integral, weighted-derivative integrability, and target-integral `HasDerivAt` formula transfer to the source ratio by a.e. integral congruence |
| Finite-KL `llr` target-time field handoff | formalized local handoff plus source bridges; `narrows-source-cited-boundary` | `appendix.tex:1358-1366`; finite-KL log-ratio weak test | `SALD.generalMovingTargetDiscretePureRawKlTargetTimeFieldsOfDominated`; finite KL supplies `llr` regularity and the dominated target-time theorem supplies `targetTimeTermIntegrable` plus `targetTimeDerivativeFormula` through explicit source-specific bridges |
| Remaining pure KL theorem after target-time narrowing | obligation | `appendix.tex:1358-1366` | `ASTIS.SALD.cycle111.remaining_pure_raw_kl_after_target_time`; prove the a.e. equality identifying the fixed weight with `hat rho_s / tilde pi_s`, prove the target-density derivative/domination and source bridges, and separately prove endpoint-safe first-term KL differentiation |

No sample-space `P`, `hatX`, mass term, mapped-law mass derivative, `hbarB`
representative, weak-FP source-sign, no-boundary, LSI, DV, Gronwall, theorem
status, SLT import, Lake dependency, or `sald_version_2.tex` route is added.

## Cycle 106 Canonical Conditional-Drift Regularity

Classification: `discharges-supplied-hypothesis`.

Cycle 106 discharges one cycle 80-84 supplied EM hypothesis behind the
conditional drift definition at `appendix.tex:1368-1377`: regularity of the
canonical conditional integral field built from the guide component and score
component.  The active packet remains
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 106 middle canonical drift source map | obligation; `discharges-supplied-hypothesis` | `appendix.tex:1368-1377`; active EM conditional-law backend | `SALD.cycle106GeneralMovingTargetDiscreteCanonicalCondDistribDriftMiddleObligation`; `ASTIS.SALD.cycle106.middle_canonical_condDistrib_drift_source_map` |
| Canonical `condDistrib` guide+score drift regularity | formalized local theorem; discharges the old canonical component conditional-integral regularity premise | `appendix.tex:1368-1377`; Mathlib conditional distributions and Bochner integrals | `SALD.generalMovingTargetDiscreteCondDistribCanonicalDriftRegularity`; proves `AEStronglyMeasurable` and `Integrable` for `x |-> dotTk • int guideIntegrand (x,y) d condDistrib Xk hatXAtS P x + sigmaCoeff • int scoreIntegrand (x,y) d condDistrib Xk hatXAtS P x` under `hatRhoS = Measure.map hatXAtS P` and joint guide/score integrability |
| Named `barB` canonical-a.e. regularity bridge | formalized local theorem; `narrows-source-cited-boundary` for the named representative side condition | `appendix.tex:1368-1377`; source notation `barB` | `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfCanonicalAeEq`; if downstream `barB` is `hatRhoS`-a.e. equal to the canonical `condDistrib` guide+score field, then `barB` inherits `AEStronglyMeasurable` and `Integrable`; remaining theorem is only that a.e. equality |
| Cycle 106 lower handoff and dependency registration | obligation wrapper plus compiled theorem registration; `discharges-supplied-hypothesis` | `appendix.tex:1368-1377`; reused by the discrete forward-KL and general moving-target discrete theorem routes | `SALD.cycle106GeneralMovingTargetDiscreteCanonicalCondDistribDriftLowerObligation`; `SALD.cycle106GeneralMovingTargetDiscreteCanonicalCondDistribDriftDag`; `SALD.cycle106EmCanonicalCondDistribDriftDependencyNames`; `ASTIS.SALD.cycle106.lower_packet.canonical_condDistrib_drift_regularity` |
| Remaining named representative boundary | obligation; strictly narrower than the discharged regularity premise | `appendix.tex:1368-1377`; source notation `barB` | prove `hatRhoS`-a.e. equality between any downstream named `barB` representative and the canonical `condDistrib` guide+score field; regularity then follows from `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfCanonicalAeEq` |

No weak-FP generator-to-law theorem, no-boundary drift-divergence identity for
`hatRhoS * barB`, diffusion source action, KL/log-ratio derivative, LSI, DV,
Gronwall, theorem status, SLT import, or Lake dependency was promoted.  The
local SLT reference `SLT/EfronStein.lean` was consulted only for
product-measure and conditional-integral proof style.

## Cycle 107 Discrete Forward-KL Closure Pressure Sync

Classification: `narrows-source-cited-boundary`.

Cycle 107 reroutes `thm:forward-KL-discrete` through the compiled EM wrappers
and the existing LSI/DV/Gronwall scalar interfaces.  The pressure test does
not expose a new theorem-display or scalar accumulation blocker.  It reaches
the same active EM weak-FP backend over `appendix.tex:1358-1387`, and the next
non-wrapper boundary is the trace/divergence-theorem input for the
`hatRhoS * barB` no-boundary drift term at `appendix.tex:1379-1387`, with
`barB` defined at `appendix.tex:1368-1377`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Cycle 107 pressure-test sync | obligation; `narrows-source-cited-boundary`; no new route wrapper | `main_body.tex:301-323`; compiled route through `appendix.tex:260-592`; active backend `appendix.tex:1358-1387` | Existing route data under `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"`; no new Lean wrapper is added |
| Next exact non-wrapper blocker | obligation; selected lower packet | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` for `barB` | Consumer: `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientTraceBoundaryOfTestTraceZero`; prove or strictly narrow its `hboundaryFluxIntegral` premise while carrying `hproductRule`, `hdivergenceTheorem`, `hgradNormBound`, and `htestTraceZero` explicitly |
| Lower-ready theorem boundary | obligation; source-cited Mathlib instantiation | Mathlib divergence theorem plus the paper weak-test boundary setup | Proposed declaration: `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfDivergenceTheoremBox`; prove `boundaryFlux phi = int_y testTrace phi y * normalFluxTrace y d boundaryMeasure` for the weighted field `hatRhoS * barB` from `MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable` or a stricter local specialization |

The lower boundary should expose the box/face hypotheses required by Mathlib:
continuity of the weighted field on the box, Frechet differentiability away
from an allowed countable interior set, integrability of the divergence term,
the signed face-sum identification with `boundaryFlux`, and the normal-trace
identification used in the existing `testTrace`/`normalFluxTrace` interface.
If the zero-boundary side is needed, it should be stated as the already
narrowed `htestTraceZero : testTrace phi = 0` a.e. on the boundary, not as
another wrapper around `boundaryFlux phi = 0`.

Rejected wrapper churn: do not add wrappers that merely restate
`hdivNoBoundary`, `hzeroBoundary`, `hboundaryFluxIntegral`, `hgradNormBound`,
KL differentiability, LSI, DV, Gronwall, accumulated-error display matching,
or theorem status.  The only useful lower packet now is a compiled proof or a
strictly smaller Mathlib/local boundary for the boundary-flux integral
representation above.

Mathlib consulted:
`.lake/packages/mathlib/Mathlib/MeasureTheory/Integral/DivergenceTheorem.lean`,
especially `MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable`,
`MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable'`,
`MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable_of_equiv`, and
the two-dimensional product-rectangle specializations.  Local SLT was checked
only for possible divergence/Frechet-derivative style (`SLT/GaussianLSI/TensorizedGLSI.lean`);
no SLT divergence theorem exists or was imported.

## Cycle 107 Lower Boundary-Flux Integral Box Handoff

Classification: `narrows-source-cited-boundary`.

Cycle 107 lower compiles
`SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfDivergenceTheoremBox`
for the `hboundaryFluxIntegral` premise consumed by
`SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientTraceBoundaryOfTestTraceZero`.
The source span remains `appendix.tex:1379-1387`, with `barB` supplied by
`appendix.tex:1368-1377`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Boundary-flux integral box handoff | formalized local Mathlib handoff; `narrows-source-cited-boundary` | `appendix.tex:1379-1387`; Mathlib `MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable` | `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfDivergenceTheoremBox`; converts a supplied boundaryFlux = box-divergence-integral identity to `boundaryFlux phi = int_y testTrace phi y * normalFluxTrace y d boundaryMeasure` by applying the Mathlib box divergence theorem and a supplied signed-face-to-trace identity |
| Remaining box/trace instantiation | obligation; exact next non-wrapper blocker | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` for the weighted field `hatRhoS * barB` | Instantiate the compiled theorem with the concrete weighted field; prove continuity on the box, Frechet differentiability off a countable interior set, divergence integrability, `boundaryFlux` equals the interior divergence integral, and the signed Mathlib face sum equals the existing `testTrace`/`normalFluxTrace` boundary integral |

`hproductRule`, `hdivergenceTheorem`, `hgradNormBound`, and
`htestTraceZero` remain explicit inputs.  This cycle does not promote weak FP,
KL differentiation, LSI, DV, Gronwall, theorem status, SLT import, Lake
dependency changes, or `sald_version_2.tex` use.

## Cycle 109 Named `barB` Source-Definition Boundary

Classification: `narrows-source-cited-boundary`.

Cycle 109 returns to the conditional drift definition at
`appendix.tex:1368-1377` after the cycle-106 canonical `condDistrib` drift
regularity theorem.  The old downstream blocker was a direct supplied
`hatRhoS`-a.e. equality between a named `barB` representative and the canonical
guide-plus-score conditional integral.  This cycle narrows that boundary to
the source-definition theorem that selects the paper's conditional-expectation
representative.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Source-definition bridge | formalized local theorem; `narrows-source-cited-boundary` | `appendix.tex:1368-1377`; Mathlib `CondDistrib`/`Condexp` orientation | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpKernelSourceDef`; transports a source `condExpKernel.map XkEta` definition of `barB` through a sample-space kernel alignment and `hatRhoS = Measure.map hatXAtS P` to obtain the downstream `hatRhoS`-a.e. canonical `condDistrib` equality |
| Product conditional-expectation source bridge | formalized local theorem; `narrows-source-cited-boundary` | `appendix.tex:1368-1377`; Mathlib `condExp_prod_ae_eq_integral_condDistrib` | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSourceDef`; derives the same downstream `hatRhoS`-a.e. canonical `condDistrib` equality from the paper's sample-space conditional-expectation representative `barB (hatXAtS omega)` and Bochner add/smul linearity along `condDistrib` fibers |
| Exact missing theorem | source-cited/obligation boundary | `appendix.tex:1368-1377`; Mathlib `Probability.Kernel.CondDistrib`, `Probability.Kernel.Condexp`, Bochner integrals | `SALD.cycle109GeneralMovingTargetDiscreteNamedBarBSourceDefBoundary`; prove the measure-valued a.e. alignment `condDistrib XkEta hatXAtS P (hatXAtS omega) = condExpKernel P (mState.comap hatXAtS).map XkEta omega` and the source conditional-expectation representative for `barB` |
| Remaining lower theorem | source-cited/obligation boundary; strictly smaller than a direct `hbarBAe` | `appendix.tex:1368-1377`; Mathlib conditional expectation and `ae_map_iff` | `ASTIS.SALD.cycle109.remaining_condExp_source_representative_for_named_barB`; prove `P[dotTk • guideIntegrand(hatXAtS omega, XkEta omega) + sigmaCoeff • scoreIntegrand(hatXAtS omega, XkEta omega) | mState.comap hatXAtS] = barB (hatXAtS omega)` a.e. and the equality-set measurability needed to transport it to `hatRhoS` |
| Cycle 109 middle packet | obligation plus compiled bridge registration | active EM backend `sald.general_moving_target_discrete.em_interpolation_fp` | `SALD.cycle109GeneralMovingTargetDiscreteNamedBarBSourceDefMiddleObligation`; `SALD.cycle109GeneralMovingTargetDiscreteNamedBarBSourceDefDag`; `SALD.cycle109EmNamedBarBSourceDefDependencyNames` |
| Cycle 109 lower packet | obligation plus compiled theorem registration | active EM backend `sald.general_moving_target_discrete.em_interpolation_fp` | `SALD.cycle109GeneralMovingTargetDiscreteNamedBarBCondExpSourceLowerObligation`; `ASTIS.SALD.cycle109.lower_named_barB_condExp_source_bridge` |

Required hypotheses for the remaining theorem are explicit: finite/probability
common law `P`, standard-Borel state space, measurable `hatXAtS`,
a.e.-measurable `XkEta`, the named marginal
`hhatRhoS : hatRhoS = Measure.map hatXAtS P`, guide/score Bochner
integrability for the paper summands `dot t_k c_{t_k}` and
`(sigma_eta^2/2) nabla log pi_{t_k}`, equality-set measurability for the
canonical guide-plus-score field, completeness of the vector codomain for
Mathlib's vector-valued conditional expectation theorem, and the source
conditional-expectation definition of `barB`.  The older `condExpKernel.map`
route still records its measure-valued kernel-alignment theorem, but the lower
bridge shows that the product `condExp` theorem is enough for the named
representative equality once `barB` is selected as the source conditional
expectation.

This packet does not reopen weak FP, box trace, divergence integrability,
KL/log-ratio, LSI, DV, Gronwall, theorem status, SLT import, or Lake
dependencies.  Local `SLT/EfronStein.lean` was consulted only for conditional
expectation and product-measure proof style; no SLT theorem was imported or
marked formalized.

## Cycle 110 Named `barB` Equality-Set Measurability

Classification: `discharges-supplied-hypothesis`.

Cycle 110 removes the supplied equality-set measurability side condition
`hbarBEqMeas` from the cycle-109 source bridge for `barB`.  The active backend
is still `sald.general_moving_target_discrete.em_interpolation_fp`; this is
only the named conditional-drift representative needed before the weak-FP
source signs at `appendix.tex:1379-1387`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Equality-set measurability for named `barB` | formalized local theorem; discharges supplied `hbarBEqMeas` under strongly measurable representatives | `appendix.tex:1368-1377`; Mathlib measurable equality-set theorem | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBEqMeasOfStronglyMeasurable`; applies `MeasureTheory.StronglyMeasurable.measurableSet_eq_fun` to the canonical `condDistrib` guide-plus-score field and named `barB` |
| Cycle 110 middle packet | obligation plus compiled helper registration | active EM backend and weak-FP consumer | `SALD.cycle110GeneralMovingTargetDiscreteNamedBarBEqMeasMiddleObligation`; `ASTIS.SALD.cycle110.middle_named_barB_eq_meas_boundary`; rejects another generator-to-law wrapper because cycle 104 already discharged that named-law transport premise |
| Cycle 110 lower packet | obligation plus compiled theorem registration | active EM backend `sald.general_moving_target_discrete.em_interpolation_fp` | `SALD.cycle110GeneralMovingTargetDiscreteNamedBarBEqMeasLowerObligation`; `ASTIS.SALD.cycle110.lower_named_barB_eq_meas`; dependency list `SALD.cycle110EmNamedBarBEqMeasDependencyNames` |
| Remaining theorem | obligation; exact lower boundary after equality-set measurability | `appendix.tex:1368-1377`; Mathlib conditional expectation | `ASTIS.SALD.cycle110.remaining_condExp_source_representative_after_eq_meas`; prove the source representative `hbarBCondExp` and supply strong measurability of the canonical and named representatives if using the cycle-110 helper |

This cycle does not prove the conditional-expectation representative,
conditional law, weak FP, box trace, no-boundary theorem, KL/log-ratio, LSI,
DV, Gronwall, theorem closure, SLT import, Lake dependency change, or
`sald_version_2.tex` use.

## Cycle 112 Named `barB` Conditional-Expectation Representative

Classification: `narrows-source-cited-boundary`.

Cycle 112 narrows the remaining `hbarBCondExp` hypothesis for the named
`barB` source bridge at `appendix.tex:1368-1377`.  The old premise was the
sample-space a.e. equality
`P[frozen guide+score | mState.comap hatXAtS] = barB (hatXAtS omega)`.  The new
compiled handoff derives that equality from the standard uniqueness
characterization of conditional expectation.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Conditional-expectation uniqueness bridge | formalized local theorem; narrows `hbarBCondExp` | `appendix.tex:1368-1377`; Mathlib conditional expectation uniqueness | `SALD.generalMovingTargetDiscreteNamedBarBCondExpOfSetIntegralEq`; uses `MeasureTheory.ae_eq_condExp_of_forall_setIntegral_eq` to derive the old `hbarBCondExp` equality from candidate measurability, candidate integrability, guide/score integrability, and matching Bochner set integrals on every `hatXAtS`-measurable finite-measure set |
| Source bridge without primitive `hbarBCondExp` | formalized downstream handoff; narrows-source-cited-boundary | `appendix.tex:1368-1377`; Mathlib `condExp_prod_ae_eq_integral_condDistrib` | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSetIntegralDef`; invokes the existing cycle-109 product-condExp bridge after deriving `hbarBCondExp`, so downstream named `barB` regularity no longer takes that equality as a primitive |
| State-event set-integral bridge | formalized local theorem; narrows-source-cited-boundary | `appendix.tex:1368-1377`; `MeasurableSpace.measurableSet_comap` | `SALD.generalMovingTargetDiscreteNamedBarBSetIntegralOfStateEvents`; `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef`; equality of Bochner integrals on source-facing events `{omega | hatXAtS omega in t}` implies the all-`comap hatXAtS` set-integral hypothesis used by conditional-expectation uniqueness |
| Remaining exact theorem | source-cited/obligation boundary | `appendix.tex:1368-1377`; Bochner conditional-expectation characterization | `ASTIS.SALD.cycle112.remaining_named_barB_set_integral_characterization`; prove `barB (hatXAtS omega)` is a.e. measurable for `mState.comap hatXAtS`, integrable under `P`, and has the same set integrals as the frozen guide-plus-score drift on all source-facing events `{omega | hatXAtS omega in t}` for measurable state sets `t` |
| Cycle 112 middle packet | obligation plus compiled theorem registration | active EM backend and weak-FP consumer | `SALD.cycle112GeneralMovingTargetDiscreteNamedBarBCondExpRepresentativeMiddleObligation`; `ASTIS.SALD.cycle112.middle_named_barB_condExp_representative` |
| Cycle 112 lower packet | obligation plus compiled theorem registration | active EM backend `sald.general_moving_target_discrete.em_interpolation_fp` | `SALD.cycle112GeneralMovingTargetDiscreteNamedBarBCondExpRepresentativeLowerObligation`; `SALD.cycle112GeneralMovingTargetDiscreteNamedBarBCondExpRepresentativeDag`; `SALD.cycle112EmNamedBarBCondExpRepresentativeDependencyNames` |

This cycle does not prove the source state-event set-integral characterization itself,
construct a conditional law, prove weak Fokker-Planck, box trace, no-boundary,
diffusion source action, KL/log-ratio, LSI, DV, Gronwall, theorem closure, SLT
reuse, Lake dependency changes, source-index rebaseline, or `sald_version_2.tex`
use.  Local `SLT/EfronStein.lean` was consulted only as a conditional
expectation/product-measure style reference.

## Cycle 113 Discrete Forward-KL Pressure Test

Classification: `narrows-source-cited-boundary`.

Cycle 113 pressure-tested `thm:forward-KL-discrete` through the currently
compiled EM wrappers and the existing LSI, DV, and Gronwall interfaces.  The
route already reaches the cycle-112 named `barB` handoff in
`SALD.saldDependenciesForLabel "thm:forward-KL-discrete"`, so the first
non-wrapper blocker is not a new scalar LSI/DV/Gronwall packet.  It is still
the source-selected representative theorem for
`\bar b_{k,s}` at `appendix.tex:1368-1377`, consumed by the compiled declaration
`SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef`.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Pressure-test route through discrete theorem dependencies | checked; no theorem status promotion | `main_body.tex:301-323`; `appendix.tex:334-592`; active backend `appendix.tex:1358-1387` | `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes `SALD.cycle112EmNamedBarBCondExpRepresentativeDependencyNames`, `SALD.cycle113EmNamedBarBStateFieldRegularityDependencyNames`, the EM backend, and the LSI/DV/Gronwall scalar interfaces |
| First non-wrapper blocker | source-cited/obligation boundary; narrows-source-cited-boundary | `appendix.tex:1368-1377` | `ASTIS.SALD.cycle112.remaining_named_barB_set_integral_characterization`; the exact consuming declaration is `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef` |
| Candidate regularity pullback | formalized local theorem; discharges-supplied-hypothesis | `appendix.tex:1368-1377`; named marginal `hatRhoS = Law(hatXAtS)` | `SALD.generalMovingTargetDiscreteNamedBarBComapRegularityOfStateField`; discharges `hbarBMeas` and `hbarBInt` from `StronglyMeasurable barB`, `Integrable barB hatRhoS`, `Measurable hatXAtS`, and `hatRhoS = Measure.map hatXAtS P` |
| State-field set-integral bridge | formalized downstream handoff; discharges-supplied-hypothesis | `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateFieldSetIntegralDef`; feeds the derived regularity into `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef` |
| Remaining lower-ready declaration boundary | source-cited/obligation boundary | `appendix.tex:1368-1377` | Prove or strictly narrow `hbarBStateSetIntegral`: equality of Bochner set integrals over every source-facing state event `{omega | hatXAtS omega in t}`; also prove `Integrable barB hatRhoS` from the selected state representative if that is not already part of the source construction |

The next lower packet should not add a new theorem-route audit or a new
supplied-hypothesis wrapper.  It should either compile the selected
state-event set-integral characterization for `barB (hatXAtS omega)` or name
one smaller Mathlib/conditional-expectation theorem with imports and exact
hypotheses.  Local SLT files were consulted only for `condExp`, `Measure.map`,
and Bochner-integral style; no SLT theorem was found that directly supplies
this SALD representative characterization, and no SLT dependency is imported.

## Cycle 110 Dominated Generator-To-Law Weak-FP Transport

Classification: `discharges-supplied-hypothesis`.

Cycle 110 also returns to the assigned generator-to-law boundary at
`appendix.tex:1379-1387`.  The compiled theorem removes the supplied
integral-level sample-space derivative premise `hsampleGenerator` in the
cycle-104 named-law split-generator handoff by deriving it from a pointwise
sample-path derivative and dominated parametric-integral package.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Dominated sample-integral derivative | formalized local theorem; derives the sample-space weak-test derivative under local pointwise `HasDerivAt`, a.e. measurability, integrability, and an integrable derivative bound | `appendix.tex:1379-1387`; Mathlib parametric integral | `AutoSamplingTheory.lawMapIntegralHasDerivAtOfDominated`; uses `hasDerivAt_integral_of_dominated_loc_of_deriv_le` then `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample` |
| Named-law dominated transport | formalized local theorem; transports the dominated derivative to `hatRhoS s = Measure.map (hatX s) P` | `appendix.tex:1379-1387`; cycle-79 law-map helpers | `AutoSamplingTheory.lawIntegralHasDerivAtOfMeasureMapEqAndDominated` |
| Source-signed named-law weak derivative | formalized local theorem; discharges `hsampleGenerator` in the named-law split-generator route | `appendix.tex:1379-1387` | `SALD.generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfDominatedSplitGeneratorHandoff`; dependency list `SALD.cycle110EmWeakFpDominatedGeneratorDependencyNames` |
| Remaining theorem | obligation; exact lower boundary after dominated transport | EM interpolation proof at `appendix.tex:1379-1387`; drift source at `appendix.tex:1368-1377` | `ASTIS.SALD.cycle110.remaining_parametric_generator_boundary_after_dominated_transport`; prove the pointwise EM derivative/dominated-bound package and identify the derivative integral with `driftAction + diffusionAction` |

This cycle does not prove the concrete EM pointwise derivative, drift
`barB` representative, no-boundary theorem, box trace, KL/log-ratio, LSI, DV,
Gronwall, theorem closure, SLT import, Lake dependency change, or
`sald_version_2.tex` use.

## Cycle 108 Concrete Product-Flux Continuity Handoff

Classification: `narrows-source-cited-boundary`.

Cycle 108 stays on the active EM no-boundary backend at
`appendix.tex:1379-1387`, with `barB` supplied by `appendix.tex:1368-1377`.
The cycle compiles a concrete product-flux continuity handoff for the
remaining cycle-107 box-trace instantiation.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Product flux continuity on the Mathlib box | formalized local theorem; `narrows-source-cited-boundary` | `appendix.tex:1379-1387`; Mathlib topology/box divergence setup | `SALD.generalMovingTargetDiscreteHatRhoBarBWeightedFieldContinuousOnBox`; proves continuity of `x |-> hatRhoDensity x • barB x` on `Set.Icc a b` from separate continuity of the density representative and `barB` |
| Product-flux box handoff | formalized local theorem plus remaining obligations | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfHatRhoBarBBox`; instantiates the cycle-107 theorem with the concrete product flux and discharges the generic continuity premise |
| Remaining box/trace instantiation | obligation; exact next non-wrapper blocker | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | prove the Frechet derivative of `x |-> hatRhoDensity x • barB x` off a countable interior set, divergence integrability, `boundaryFlux` equals the interior divergence integral, and signed Mathlib faces equal the `testTrace`/`normalFluxTrace` boundary integral |

`hproductRule`, `hdivergenceTheorem`, `hgradNormBound`, and
`htestTraceZero` remain explicit.  No non-EM fallback, source-index rebaseline,
broad theorem-route audit, theorem-status promotion, SLT import, Lake change,
or `sald_version_2.tex` use was introduced.

## Cycle 108 Concrete Product-Flux Frechet Derivative Handoff

Classification: `narrows-source-cited-boundary`.

Cycle 108 lower stays on the active EM no-boundary backend at
`appendix.tex:1379-1387`, with `barB` supplied by `appendix.tex:1368-1377`.
It narrows the remaining product-flux box-trace instantiation by proving the
Frechet derivative of `x |-> hatRhoDensity x • barB x` from separate density
and drift derivatives off their own countable exception sets.

| Obligation | Status | Source | Lean-facing contract |
|---|---|---|---|
| Product flux pointwise Frechet derivative | formalized local theorem; `narrows-source-cited-boundary` | `appendix.tex:1379-1387`; Mathlib `HasFDerivAt.smul` product rule | `SALD.generalMovingTargetDiscreteHatRhoBarBWeightedFieldHasFDerivAt`; proves the derivative formula `(hatRhoDensity x) • barBDeriv x + (hatRhoDeriv x).smulRight (barB x)` for `x |-> hatRhoDensity x • barB x` |
| Product flux derivative off countable union | formalized local theorem | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteHatRhoBarBWeightedFieldHasFDerivAtOffUnion`; reduces product-flux differentiability off one exception set to separate density and `barB` differentiability off their union |
| Product-flux box handoff with derivative instantiated | formalized local theorem plus remaining obligations | `appendix.tex:1379-1387`; Mathlib box divergence setup | `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfHatRhoBarBBoxProductDeriv`; instantiates `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfHatRhoBarBBox` with the product derivative and combined exception set |
| Remaining box/trace instantiation after derivative | obligation; exact next non-wrapper blocker | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | prove divergence integrability for the product derivative, `boundaryFlux` equals the interior divergence integral, and signed Mathlib faces equal the `testTrace`/`normalFluxTrace` boundary integral |

`hproductRule`, `hdivergenceTheorem`, `hgradNormBound`, and
`htestTraceZero` remain explicit.  This does not promote weak FP, KL
differentiation, LSI, DV, Gronwall, theorem status, SLT import, Lake
dependency changes, or `sald_version_2.tex` use.
