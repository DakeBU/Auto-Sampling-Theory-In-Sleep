# Conversion Window: Original VA-SALD Paper

Task id: `ASTIS-SALD-001`
Mode: `faithfulPaper`

## Source

- Root: `/home/nitanda_sub/mark/repos/sald/paper`
- Excluded: `sald_version_2.tex`
- Main source files: `main_body.tex`, `appendix.tex`, `iteration_complexity.tex`
- Source index: `research-wiki/source-index/SALD_original.jsonl`

## Cycle 1 Objective

Faithfully pin the first appendix contracts and shared vocabulary before any
proof search:

- `lem:gronwall`
- `lem:dv_variation`
- `def:PI`
- `eq:LSI-KL-FI` and the KL/FI/LSI vocabulary in `main_body.tex`

No theorem target is weakened, and no hidden regularity assumption is added.

## Cycle 2 Objective

Faithfully pin the continuous forward-KL theorem before proof search:

- source statement `thm:forward-KL` in `main_body.tex:240-247`;
- source proof in `appendix.tex:164-252`;
- moving-target assumptions: LSI along `pi_t`, finite alpha-complexity of the
  transport velocity `v_t`, and SALD law `rho_s` under the inverse schedule
  `s=s(t)`;
- proof dependency chain: KL derivative/Fokker--Planck identity, LSI-to-KL/FI,
  Donsker--Varadhan energy bound, and `lem:gronwall`.

The compiled Lean-facing record is
`SALD.continuousForwardKlStatementContract`.  It is contract data only; no
analysis step is marked formalized.

Cycle 2 compiled proof-block interfaces now include:

- `SALD.saldAlphaComplexityContract`;
- `SALD.forwardKlDerivativeCandidateContract`;
- `SALD.forwardKlDerivativeSideConditionContract`;
- `SALD.forwardKlDvEnergyCandidateContract`;
- `SALD.forwardKlGronwallInstantiationContract`;
- `SALD.forwardKlProofDag`.

These records expose the faithful source route and regularity gaps without
promoting any analytic step to `formalized`.

## Cycle 3 Objective

Faithfully pin the discrete forward-KL theorem and its Euler--Maruyama proof
route:

- source statement `thm:forward-KL-discrete` in `main_body.tex:301-323`;
- source proof in `appendix.tex:260-592`;
- EM interpolation `eq:frozen_interp_terminal_disc_prop_additive_final`;
- one-step frozen score-defect lemma `lem:frozen_delta_cross_lip_sald`;
- accumulated `\Gamma`, `\Delta`, `\bar\Gamma`, and
  `\bar\Delta_{\alpha'}` errors under linear slowdown `t(s)=s/r`.

The compiled Lean-facing records are
`SALD.discreteForwardKlStatementContract`,
`SALD.discreteSaldEulerMaruyamaContract`,
`SALD.frozenDeltaCrossLipSaldContract`,
`SALD.discreteForwardKlDerivativeCandidateContract`,
`SALD.discreteForwardKlGronwallInstantiationContract`,
`SALD.discreteForwardKlLinearSlowdownObligation`, and
`SALD.discreteForwardKlProofDag`.  All analytic content remains obligation
data.

## Cycle 4 Objective

Faithfully pin the continuous guided/general VA-SALD path before proof search:

- source residual proposition `prop:guided_path_residual` in
  `appendix.tex:619-704`, supporting the main-body residual equation
  `eq:residual-term` in `main_body.tex:359-363`;
- source theorem `thm:general-moving-target-SALD` in
  `appendix.tex:724-949`;
- main-body specialization `thm:unified-forward-KL` in
  `main_body.tex:372-395`, with proof specialization in
  `appendix.tex:949-951`;
- residual velocity `m_t=v_t-c_t`, sigma-weighted contraction, DV residual
  energy, Gronwall application, and the `c_t=v_t` pure-contraction clause.

The compiled Lean-facing records are
`SALD.guidedResidualIdentityContract`,
`SALD.generalMovingTargetStatementContract`,
`SALD.generalMovingTargetDerivativeCandidateContract`,
`SALD.generalMovingTargetDvEnergyCandidateContract`,
`SALD.generalMovingTargetGronwallInstantiationContract`,
`SALD.generalMovingTargetDiscreteStatementContract`,
`SALD.generalFrozenDeltaCrossLipContract`,
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract`,
`SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`,
`SALD.generalMovingTargetDiscreteGronwallInstantiationContract`,
`SALD.generalVaSaldProofDag`, and `SALD.generalVaSaldDiscreteProofDag`.
The theorem contracts now list explicit guided-residual, continuous general
moving-target, and discrete general moving-target obligations.  No analytic
content is marked formalized.

## Cycle 5 Upper Re-Audit

Objective: return to the source-index and first appendix/vocabulary layer and
make the first DAG wiring explicit for `eq:LSI-KL-FI` alongside
`lem:gronwall`, `lem:dv_variation`, and `def:PI`.

Mode discipline:

- `faithfulPaper`; keep all source statements fixed and use only
  `main_body.tex`, `appendix.tex`, and `iteration_complexity.tex`;
- keep `sald_version_2.tex` excluded from the source index;
- treat LSI-to-KL/FI, Gronwall, and DV as obligations/source-cited facts until
  compiled Lean proofs replace them.

Compiled refinement: `SALD.firstFaithfulLabels` and `SALD.saldFirstProofDag`
now include the source label `eq:LSI-KL-FI`, with target Lean file
`AutoSamplingTheory/Probability.lean`, dependencies on `KLContract`,
`FIContract`, `LSIContract`, `SALD.saldLsiKlFiDensityTestContract`,
`sald.lsi_kl_fi.density_test_interface`, and `probability.lsi_to_kl_fi`, and
reuse by all forward-KL theorem contracts.

Middle refinement: `SALD.saldLsiKlFiBridgeContract` and
`SALD.lsiKlFiDensityTestObligation` now expose the exact source bridge
`phi=sqrt(rho/pi)`: absolute continuity, density-ratio normalization,
smooth/admissible test-function requirements, finite KL/FI hypotheses, the
entropy identity, and the Fisher-information chain rule that produces the
constant `1/(2*C_LSI)`.  The source display remains an obligation; no LSI,
KL/FI, Gronwall, or DV proof has been promoted.

Lower refinement: `SALD.saldLsiKlFiDensityTestContract` splits the
`phi=sqrt(rho/pi)` bridge into a narrower compiled interface: Radon-Nikodym
density `r=d rho/d pi`, normalization, zero-density/positivity handling,
finite KL/FI requirements, smooth-test admissibility or approximation,
entropy rewrite, FI chain rule, and the coefficient audit producing
`1/(2*C_LSI)`.  This is still obligation data.

Lower packet:

- target `SALD.saldLSIContract`, `SALD.saldKLContract`,
  `SALD.saldFIContract`, `SALD.saldLsiKlFiDensityTestContract`, or
  `SALD.lsiKlFiVocabularyContract`;
- refine the finite-density and smooth-test-function interfaces needed to turn
  the source display `KL <= FI/(2*C_LSI)` into a future Lean theorem;
- do not alter the theorem targets, the Gronwall signs, the DV formula, or the
  PI statement.

Reviewer checklist:

- `research-wiki/source-index/SALD_original.jsonl` indexes `eq:LSI-KL-FI` and
  still excludes `sald_version_2.tex`;
- `SALD.saldFirstProofDag` contains `lem:gronwall`, `lem:dv_variation`,
  `def:PI`, and `eq:LSI-KL-FI`;
- `eq:LSI-KL-FI` remains an obligation because LSI-to-KL/FI has not been
  formalized;
- no analytic content is closed by a fake proof pattern.

## Cycle 6 Upper Re-Audit

Objective: keep `thm:forward-KL` fixed and make the theorem-level
moving-target assumptions and LSI/DV/Gronwall dependency chain explicit before
more proof search.

Source anchors:

- statement `main_body.tex:238-247`;
- derivative and time-change proof `appendix.tex:168-228`;
- DV-energy step `appendix.tex:230-241`;
- Gronwall application `appendix.tex:244-252`.

Compiled refinement: `SALD.forwardKlMovingTargetDependencyContract` and
`SALD.forwardKlMovingTargetDependencyObligation` record the assumption bridge:
`rho_s` is the SALD law, `\tilde\pi_s=\pi_{t(s)}`, `v_t` is the transport
velocity for `\pi_t`, LSI enters only through `eq:LSI-KL-FI`, DV enters only
through `lem:dv_variation` with `Z=\alpha\|v_t\|^2`, and Gronwall uses the
source functions
`a(t)=\dot{s}(t)\cLSI{t}-(1/2)\dot{s}(t)^{-1}\alpha^{-1}` and
`b(t)=(1/2)\dot{s}(t)^{-1}\mathfrak E_\alpha(\pi_t,v_t)`.

This refinement does not add theorem hypotheses.  It records endpoint and
regularity items as obligations/source gaps: `S=s(T)`, `s(0)=0`,
transport/Fokker--Planck backends, inverse-schedule calculus, and
integrability of the coefficients required by `lem:gronwall`.

Lower refinement: `SALD.forwardKlGronwallSideConditionContract` and
`SALD.forwardKlGronwallSideConditionObligation` separate the final Gronwall
bookkeeping from the theorem statement:

- endpoint rewrites `K(T)=KL(rho_S||pi_T)` and
  `K(0)=KL(rho_0||pi_0)`;
- regularity/admissibility of the source coefficients `a(t)` and `b(t)`;
- algebraic splitting of `exp(-int a)`;
- the residual-exponent inequality that drops
  `-int_t^T dot{s}(u) C_LSI(u) du` using the source sign facts.

All four items remain obligations.  No Gronwall, DV, LSI-to-KL/FI, schedule,
or KL-derivative fact is marked formalized.

Lower packet:

- target `SALD.forwardKlMovingTargetDependencyContract` or
  `SALD.forwardKlMovingTargetDependencyObligation`;
- preserve the exact theorem statement in `main_body.tex:240-247` and the
  appendix route derivative -> LSI -> DV -> Gronwall;
- refine one interface only: endpoint schedule identities, transport velocity,
  finite log-mgf witness for DV, or Gronwall coefficient regularity;
- do not promote `lem:gronwall`, `lem:dv_variation`, `eq:LSI-KL-FI`, or the
  KL derivative to formalized status.

Reviewer checklist:

- `SALD.continuousSaldContract` lists
  `SALD.forwardKlMovingTargetDependencyObligation`;
- `SALD.forwardKlProofDag` contains the
  `ASTIS.SALD.forward_KL.moving_target_dependencies` block before derivative
  proof search;
- the terminal bound still has the two source exponent factors and the
  residual alpha-complexity integral from `main_body.tex:243-246`;
- no hidden assumption is added for the inverse schedule, coefficient
  integrability, or density/boundary regularity.

## Cycle 23 Upper Packet

Objective: return to discrete `thm:forward-KL-discrete` and rebaseline the
full paper spine from Euler--Maruyama interpolation through one-step defects
and accumulated error, while selecting one lower target:
`SALD.discreteForwardKlCoefficientChainAuditContract` /
`SALD.discreteForwardKlCoefficientChainObligation` /
`sald.discrete_forward_kl.coefficient_chain_audit`.

Source anchors:

- statement and theorem display: `main_body.tex:273-323`;
- EM interpolation and endpoint laws: `appendix.tex:260-266`,
  `appendix.tex:334-335`;
- one-step frozen score defect: `appendix.tex:268-330`;
- derivative, LSI, DV, time-change, and Gronwall route:
  `appendix.tex:334-592`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 23 discrete upper packet | Rebaseline EM interpolation, frozen one-step defects, DV velocity, Gronwall accumulation, and accumulated-error collection while choosing one lower coefficient-audit target. | `cycle15` EM packets; `cycle19` accumulated-error packets; `lem:dv_variation`; `lem:gronwall`; `eq:LSI-KL-FI` | `SALD.cycle23DiscreteForwardKlUpperPacket`; `ASTIS.SALD.forward_KL_discrete.cycle23_upper_packet` | `main_body.tex:273-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete`; cycle 23 lower coefficient audit | obligation |
| Cycle 23 middle coefficient map | Translate the upper target into the first lower coefficient slice while keeping the accumulated-error bridge separate. | `SALD.cycle23DiscreteForwardKlUpperPacket`; frozen-delta, LSI, DV, time-change, Gronwall, endpoint, and accumulation obligations | `SALD.cycle23DiscreteForwardKlMiddleContract`; `SALD.cycle23DiscreteForwardKlCoefficientChainMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle23_middle_coefficient_chain` | `appendix.tex:454-553`; follow-on `appendix.tex:557-590`, `main_body.tex:309-323` | `sald.discrete_forward_kl.coefficient_chain_audit`; cycle 23 lower coefficient audit | obligation |
| Coefficient-chain audit | Audit the two `1/4*FI` cross-term bounds, LSI conversion, DV coefficient, time-change coefficient, and final accumulated constants. | EM endpoint/stitched interval obligations; frozen-delta obligation; DV witness; Gronwall accumulation; accumulated-error bridge | `SALD.discreteForwardKlCoefficientChainAuditContract`; `SALD.discreteForwardKlCoefficientChainObligation` | `appendix.tex:454-592`; `main_body.tex:309-323` | `thm:forward-KL-discrete`; general discrete coefficient pattern | obligation |

Mode discipline:

- `faithfulPaper`; use only the original `main_body.tex` and `appendix.tex`,
  with `sald_version_2.tex` excluded;
- preserve the theorem statement, `t(s)=s/r`, the step-size condition,
  alpha ranges, `Gamma`, `Delta`, `barGamma`, `barDelta`, and the theorem
  constants `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
  `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`;
- keep EM Fokker--Planck, omitted SALD frozen-defect proof, LSI-to-KL/FI,
  DV, Gronwall, endpoint stitching, coefficient integrability, and
  interval-integral monotonicity as obligations/source-cited facts.

Lower packet:

- target exactly the coefficient-chain audit interface above;
- first lower sub-slice is `appendix.tex:454-553`: the frozen/moving
  cross-term coefficients, LSI conversion, DV coefficient
  `dot{t}(s)^2*alpha^(-1)`, and the time-change rewrite to
  `dot{s}(t)^(-1)*alpha^(-1)`;
- only after that is stable, connect `appendix.tex:557-590` to
  `main_body.tex:309-323` through endpoint stitching, residual exponent drop,
  and full-interval `A_alpha`, `barGamma`, and `barDelta` collection;
- if any analytic backend is missing, refine the named obligation rather than
  adding assumptions or changing the theorem.

Reviewer checklist:

- `SALD.discreteForwardKlProofDag` contains
  `ASTIS.SALD.forward_KL_discrete.cycle23_upper_packet` before
  `ASTIS.SALD.forward_KL_discrete.coefficient_chain_audit`;
- `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes
  `SALD.cycle23DiscreteForwardKlUpperPacket` while retaining cycle-15 and
  cycle-19 packets;
- source-index refresh keeps `thm:forward-KL-discrete`,
  `eq:frozen_interp_terminal_disc_prop_additive_final`, and
  `lem:frozen_delta_cross_lip_sald` indexed from the original files and still
  excludes `sald_version_2.tex`;
- no analytic dependency is promoted beyond its current obligation/source-cited
  status.

## Cycle 23 Middle Packet

Lean synchronization:

- compiled packet: `SALD.cycle23DiscreteForwardKlMiddleContract`;
- workflow obligation:
  `SALD.cycle23DiscreteForwardKlCoefficientChainMiddleObligation` /
  `sald.discrete_forward_kl.cycle23_coefficient_chain_middle`;
- proof-DAG node:
  `ASTIS.SALD.forward_KL_discrete.cycle23_middle_coefficient_chain`;
- source dependency map:
  `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` now includes the
  middle packet and obligation while retaining cycle 15, cycle 19, and cycle 23
  upper packet entries.

Line-level coefficient map:

| Source lines | Paper step | Lean-facing route | Status |
|---|---|---|---|
| `appendix.tex:454-467` | `lem:frozen_delta_cross_lip_sald` supplies the first `(1/4)*FI`, `2*eta^2*alpha'^(-1)*Gamma*K`, and `2*eta*Delta`. | `SALD.frozenDeltaCrossLipSaldContract`; `sald.discrete_forward_kl.frozen_delta_cross_lip`; coefficient audit ledger | obligation |
| `appendix.tex:469-493` | Young gives the second `(1/4)*FI`, then LSI converts the remaining `-(1/2)*FI` to `-C_LSI(t(s))*K_s`. | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi`; `sald.discrete_forward_kl.kl_derivative` | source-cited obligation |
| `appendix.tex:496-523` | DV with `Z=alpha*||v_{t(s)}||^2` preserves `dot t(s)^2*alpha^(-1)` in the KL coefficient. | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_velocity_bound` | source-cited obligation |
| `appendix.tex:526-553` | Time change multiplies by `dot{s}(t)` and rewrites to the `dot{s}(t)^(-1)*alpha^(-1)` coefficient. | `SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar`; `SALD.discreteForwardKlCoefficientChainAuditContract`; `sald.discrete_forward_kl.coefficient_chain_audit` | obligation with formalized scalar core |
| `appendix.tex:557-590`, `main_body.tex:309-323` | Gronwall endpoint and accumulated-error collection are a follow-on slice, not part of the first coefficient audit. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `sald.discrete_forward_kl.accumulated_error_bridge` | obligation |

Lower handoff:

- target exactly the coefficient-chain audit interface;
- first lower slice is `appendix.tex:454-553`;
- keep EM Fokker--Planck, the omitted frozen-defect proof, DV, Gronwall,
  endpoint stitching, residual exponent drop, and full-interval collection as
  separate named obligations;
- preserve `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
  `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`.

## Cycle 23 Lower Packet

Lean synchronization:

- compiled scalar core:
  `SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar`;
- source slice: `appendix.tex:526-553`, after the DV velocity bound and before
  Gronwall;
- theorem-independent content: real algebra only,
  `dot{s}(t) * dot t(s(t))^2 * coeff = dot{s}(t)^(-1) * coeff` once
  inverse-schedule side conditions provide
  `dot t(s(t)) = dot{s}(t)^(-1)` and `dot{s}(t) != 0`.

Remaining obligations:

- inverse-schedule calculus and positivity/nonzero facts for `dot{s}(t)`;
- EM endpoint and stitched-interval regularity;
- frozen-defect, LSI, DV, Gronwall, endpoint stitching, residual exponent
  drop, and full-interval accumulated-error collection.

## Cycle 27 Upper Packet

Objective: keep discrete `thm:forward-KL-discrete` fixed and select the next
lower slice inside the accumulated-error bridge after the coefficient-chain
audit: endpoint rewrites, the linear-slowdown exponent split, and the
`A_\alpha`/`\bar\Gamma`/`\bar\Delta_{\alpha'}` collection from
`appendix.tex:557-590` to `main_body.tex:309-323`.

Source anchors:

- theorem display and linear slowdown constants: `main_body.tex:299-323`;
- appendix Gronwall output: `appendix.tex:557-590`;
- coefficient audit dependency only: `appendix.tex:454-553`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 27 discrete upper accumulated collection | Select endpointBridge, exponent split, and `A_\alpha`/`\bar\Gamma`/`\bar\Delta_{\alpha'}` collection as the next lower target after the coefficient-chain audit. | cycle 19 accumulated-error bridge; cycle 23 coefficient-chain audit; residual exponent scalar cores; EM endpoint and stitched-interval obligations | `SALD.cycle27DiscreteForwardKlUpperPacket`; `SALD.cycle27DiscreteForwardKlAccumulatedCollectionUpperObligation`; `ASTIS.SALD.forward_KL_discrete.cycle27_upper_accumulated_collection` | `appendix.tex:557-590`; `main_body.tex:309-323` | `thm:forward-KL-discrete`; cycle 27 lower accumulated-error bridge | obligation |
| Cycle 27 middle accumulated collection | Translate the upper target into the lower-ready `endpointBridge`, `alphaComplexityCollection`, and `deltaAccumulation` sub-slice while keeping residual exponent and `barGamma` monotonicity separate. | cycle 27 upper packet; accumulated-error bridge; linear slowdown obligation; residual exponent scalar cores; coefficient-chain audit; EM endpoint/stitching obligations | `SALD.cycle27DiscreteForwardKlMiddleContract`; `SALD.cycle27DiscreteForwardKlAccumulatedCollectionMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle27_middle_accumulated_collection` | `appendix.tex:557-590`; `main_body.tex:309-323` | `thm:forward-KL-discrete`; cycle 27 lower accumulated-error bridge | obligation |

Mode discipline:

- `faithfulPaper`; use only the original `main_body.tex` and `appendix.tex`,
  with `sald_version_2.tex` excluded;
- preserve `t(s)=s/r`, `r>=1`, alpha ranges, step-size condition, `Gamma`,
  `Delta`, `barGamma`, `barDelta`, and the theorem constants
  `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
  `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`;
- keep endpoint laws, stitched regularity, interval-integral monotonicity,
  Gronwall, and full-interval coefficient identifications as obligations
  unless a compiled local proof replaces them.

Lower packet:

- target exactly `SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
  `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
  `sald.discrete_forward_kl.accumulated_error_bridge`;
- first lower sub-slice is `endpointBridge` plus
  `alphaComplexityCollection` and `deltaAccumulation`;
- use `SALD.discreteForwardKlResidualExponentBoundScalar` and
  `SALD.discreteForwardKlResidualExpBoundScalar` only as existing scalar
  cores, not as proof of the interval-integral monotonicity or `barGamma`
  identification;
- keep `sald.discrete_forward_kl.coefficient_chain_audit` as a dependency and
  reviewer ledger for constants, not as this cycle's lower target.

Reviewer checklist:

- `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes
  `SALD.cycle27DiscreteForwardKlUpperPacket` and
  `SALD.cycle27DiscreteForwardKlMiddleContract`, plus
  `sald.discrete_forward_kl.cycle27_accumulated_collection_upper` and
  `sald.discrete_forward_kl.cycle27_accumulated_collection_middle`;
- `SALD.discreteForwardKlProofDag` contains
  `ASTIS.SALD.forward_KL_discrete.cycle27_upper_accumulated_collection` and
  `ASTIS.SALD.forward_KL_discrete.cycle27_middle_accumulated_collection`;
- no theorem statement, source constant, source file selection, or analytic
  dependency status changed.

## Cycle 27 Middle Packet

Middle translated the upper accumulated-collection target into
`SALD.cycle27DiscreteForwardKlMiddleContract` and the named workflow
obligation `sald.discrete_forward_kl.cycle27_accumulated_collection_middle`.

Lower-ready source map:

| Source step | Lean-facing target | Remaining obligation |
|---|---|---|
| `appendix.tex:560-571` identifies the Gronwall endpoint term. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract.endpointBridge`; `sald.discrete_forward_kl.em_endpoint_laws`; `sald.discrete_forward_kl.stitched_interval_regularity` | prove the EM endpoint laws and linear-slowdown endpoint identities needed for `K(T)=KL(rho_K^eta||pi_T)` and `K(0)=KL(rho_0||pi_0)` |
| `appendix.tex:586` contributes `dot{s}(t)^(-1)*E_alpha(pi_t,v_t)`. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract.alphaComplexityCollection`; `def:alpha-complexity` | under `dot{s}=r`, identify the integral with `(1/r)*A_alpha(pi,v)` without changing the source definition |
| `appendix.tex:588` contributes `2*dot{s}(t)*eta*Delta(t)`. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract.deltaAccumulation` | under `dot{s}=r`, identify the integral with `2*r*eta*barDelta_{alpha'}` |
| `main_body.tex:310-323` uses the common positive exponent. | `SALD.discreteForwardKlResidualExponentBoundObligation`; scalar cores `SALD.discreteForwardKlResidualExponentBoundScalar` and `SALD.discreteForwardKlResidualExpBoundScalar` | interval-integral monotonicity, nonnegative LSI, positive coefficients, and full-interval `barGamma` identification remain separate obligations |

Lower packet:

- target exactly `SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
  `SALD.discreteForwardKlAccumulatedErrorBridgeObligation`;
- first sub-slice is `endpointBridge`, `alphaComplexityCollection`, and
  `deltaAccumulation`;
- keep the residual exponent and `barGamma` full-interval bound as named
  dependencies unless lower explicitly proves them;
- do not reopen frozen-defect, LSI, DV, time-change coefficient, or full
  Gronwall subproofs.

## Symbol Map

| Source symbol | Meaning | Lean declaration | Status |
|---|---|---|---|
| `\KL(\rho\|\pi)` | forward KL divergence | `SALD.saldKLContract` / `KLContract` | contract |
| `\FI(\rho\|\pi)` | Fisher information | `SALD.saldFIContract` / `FIContract` | contract |
| `\cLSI{t}` | LSI constant | `SALD.saldLSIContract` / `LSIContract` | obligation |
| `\cPI{}` | Poincare constant | `SALD.saldPIContract` / `PIContract` | contract |
| `\mathfrak{E}_\alpha(\pi_t,v_t)` | alpha-complexity density | `SALD.saldAlphaComplexityContract`; `SALD.continuousForwardKlStatementContract` | contract + obligation |
| alpha0-to-alpha finite log-mgf bridge | monotonicity needed before applying DV with `Z_t=\alpha\|v_t\|^2` under the source assumption `\mathfrak E_{\alpha_0}<+\infty` | `SALD.forwardKlDvAlphaMonotonicityContract`; `SALD.forwardKlDvAlphaMonotonicityObligation` | obligation |
| `\mathcal A_\alpha(\pi,v)` | integrated alpha-complexity | `SALD.saldAlphaComplexityContract` | contract |
| `\tilde\pi_s=\pi_{t(s)}` | slowed target path | `SALD.forwardKlDerivativeCandidateContract` | obligation |
| `\dot{s}(t)`, `\dot{t}(s)` | inverse slowdown derivatives | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlGronwallInstantiationContract` | source-contract gap |
| theorem-level moving-target dependency chain | SALD law, slowed target, transport velocity, LSI/DV/Gronwall wiring, and terminal endpoint identities | `SALD.forwardKlMovingTargetDependencyContract`; `SALD.forwardKlMovingTargetDependencyObligation` | obligation |
| forward-KL endpoint schedule identities | inverse-schedule endpoint facts `s(0)=0`, `S=s(T)`, `t(s(T))=T`, slowed-target equality `tilde_pi_{s(t)}=pi_t`, and the `K(0)`/`K(T)` Gronwall endpoint rewrites | `SALD.forwardKlEndpointScheduleContract`; `SALD.forwardKlEndpointScheduleObligation` | obligation |
| forward-KL Gronwall endpoint/exponent side conditions | endpoint rewrites, `a(t)`/`b(t)` regularity, exponent split, and residual LSI exponent drop | `SALD.forwardKlGronwallSideConditionContract`; `SALD.forwardKlGronwallSideConditionObligation` | obligation |
| `K(t)` | `\KL(\rho_{s(t)}\|\pi_t)` in the appendix proof | `SALD.forwardKlDerivativeObligation` | obligation |
| derivative side conditions | density regularity, mass conservation, integration by parts, and inverse-schedule identities used before DV | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlDensityBoundaryObligation`; `SALD.forwardKlScheduleTimeChangeObligation` | obligation |
| `X_k^\eta`, `\hat X_s` | Euler--Maruyama iterates and continuous frozen interpolation | `SALD.discreteSaldEulerMaruyamaContract`; `SALD.discreteForwardKlStatementContract`; `SALD.discreteForwardKlEmInterpolationSideConditionContract` | contract + obligation |
| `\bar b_{k,s}` | conditional frozen drift of the interpolation | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.discreteForwardKlEmInterpolationObligation`; `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerContract`; `SALD.discreteForwardKlEmConditionalFpObligation` | obligation |
| stitched EM interval laws | endpoint matching and regularity needed to pass from per-step derivative inequalities to one Gronwall bound | `SALD.discreteForwardKlEmEndpointObligation`; `SALD.discreteForwardKlStitchedIntervalRegularityObligation` | obligation |
| discrete EM DV witness | common-space, absolute-continuity, finite-log-mgf, measurability, positive-alpha scaling, and `\dot t(s)^2` coefficient side conditions for `nu=\hat\rho_s`, `mu=\tilde\pi_s`, `Z=\alpha\|v_{t(s)}\|^2` | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessObligation` | obligation |
| `\delta_{\pi_t}` | frozen score-field error | `SALD.frozenDeltaCrossLipSaldContract`; `SALD.discreteForwardKlFrozenDeltaObligation` | obligation |
| `\Gamma(t)`, `\Delta(t)` | one-step defect coefficients accumulated in the discrete proof | `SALD.frozenDeltaCrossLipSaldContract`; `SALD.discreteForwardKlStatementContract`; `SALD.discreteForwardKlCoefficientChainAuditContract` | obligation |
| `\bar\Gamma`, `\bar\Delta_{\alpha'}` | integrated discrete error coefficients | `SALD.discreteForwardKlGronwallInstantiationContract`; `SALD.discreteForwardKlLinearSlowdownObligation`; `SALD.discreteForwardKlCoefficientChainAuditContract` | obligation |
| discrete accumulated-error bridge | endpoint rewrites, Gronwall exponent split, and full-interval collection of `\mathcal A_\alpha`, `\bar\Gamma`, and `\bar\Delta_{\alpha'}` | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` | obligation |
| `v_t` | transport velocity | `TransportVelocityContract` | contract |
| `c_t` | implementable velocity in general VA-SALD | `SALD.generalMovingTargetStatementContract`; `SALD.generalMovingTargetDerivativeCandidateContract` | contract + obligation |
| `\sigma_t` | VA-SALD diffusion scale appearing in drift, FI contraction, and Gronwall coefficients | `SALD.generalMovingTargetStatementContract`; `SALD.generalMovingTargetGronwallInstantiationContract` | contract + obligation |
| `w_t`, `m_t` | residual velocity, with `m_t=v_t-c_t` and unified specialization `m_t=w_t` | `SALD.generalMovingTargetStatementContract`; `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDvEnergyCandidateContract`; `SALD.unifiedForwardKlSpecializationContract`; `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract`; `SALD.unifiedForwardKlSpecializationObligation` | contract + obligation |
| `\nabla\cdot(\pi_t w_t)=\pi_t(g_t-\E_{\pi_t}[g_t])` | correction-field equation making `u_t+w_t` a transport velocity for the guided path | `SALD.unifiedForwardKlSpecializationContract`; `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract`; `SALD.cycle16UnifiedForwardKlTransportBridgeLowerObligation`; `SALD.unifiedForwardKlSpecializationObligation` | obligation |
| `Z_t`, `g_t` | guided normalizer and centered guide transport derivative | `SALD.guidedResidualIdentityContract`; `SALD.guidedResidualNormalizerObligation`; `SALD.guidedResidualIdentityObligation` | obligation |
| `\pi_t \propto p_t e^{-f_t}` | guided target | `GuidedTiltContract`; `SALD.guidedResidualIdentityContract` | contract + obligation |
| SALD law and Fokker--Planck equation | `eq:SALD`, `eq:FP-eq` | `SALD.saldContinuousSdeSource`; `SALD.saldFokkerPlanckSource` | contract + obligation |
| `\sigma_\eta(t)` | piecewise frozen diffusion level for discrete general VA-SALD | `SALD.generalVaSaldEulerMaruyamaContract`; `SALD.generalMovingTargetDiscreteStatementContract` | contract + obligation |
| `\delta_{\pi_t}^{VA}` | general VA frozen-field error | `SALD.generalFrozenDeltaCrossLipContract`; `SALD.generalMovingTargetDiscreteDerivativeCandidateContract` | obligation |
| general `\Gamma(t)`, `\Delta(t)` | VA frozen-delta error coefficients depending on `c_t`, score, `\sigma_\eta`, and `M` | `SALD.generalFrozenDeltaCrossLipContract`; `SALD.generalMovingTargetDiscreteStatementContract` | obligation |
| `\bar b_{k,s}` in general VA-SALD | conditional frozen drift for the general EM interpolation | `SALD.generalMovingTargetDiscreteDerivativeCandidateContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteEmInterpolationObligation` | obligation |

## Source Fragments

### `lem:gronwall`

Source anchor: `appendix.tex:47`.

```tex
\begin{lemma}[Gr\"onwall's inequality]\label{lem:gronwall}
    Let $a_t, b_t$ be continuous functions and $K_t$ be a differentiable function in $t \in [0,t_1]$. Suppose $\frac{\dd}{\dd t}K_t \leq -a_t K_t + b_t~(t\in [0,t_1])$. Then, it follows that,
```

Lean-facing contract: `SALD.gronwallContract`.  The proof route is the source
integrating-factor argument in `appendix.tex:55-69`; it remains an explicit
obligation until the real calculus/integral backend is selected.

Lower cycle 1 refinement: `SALD.saldGronwallCandidateContract` records the
candidate Lean-facing calculus interface.  It keeps the source hypotheses
(`a_t`, `b_t` continuous, `K_t` differentiable on `[0,t_1]`) and the exact
target bound

```text
K t1 <= exp (-(int u in 0..t1, a u)) * K 0
  + int t in 0..t1, exp (-(int u in t..t1, a u)) * b t.
```

Mathlib API audit:

| Proof step | Candidate Lean API | Status |
|---|---|---|
| interval integrals over `[0,t_1]` and `[t,t_1]` | `intervalIntegral` over `MeasureTheory.volume` | available locally |
| continuity implies integrability | `ContinuousOn.intervalIntegrable` and related interval lemmas | available locally |
| derivative of the integrating factor | `Real.hasDerivAt_exp`, chain/product derivative rules | available locally |
| integrate the derivative inequality | FTC/integration-by-parts lemmas under `intervalIntegral` | available locally |
| endpoint interpretation of "differentiable on `[0,t_1]`" | endpoint-safe `HasDerivWithinAt` formulation or equivalent | tracked by `SALD.saldGronwallEndpointCalculusContract` |

Lower cycle 9 refinement: `SALD.saldGronwallEndpointCalculusContract` and
`SALD.gronwallEndpointCalculusObligation` split the proof backend at
`appendix.tex:55-69` into closed-interval derivative semantics,
integrating-factor differentiation, order integration/FTC, endpoint
evaluation, and the final exponent rewrite
`exp(-int_0^t1 a)*exp(int_0^t a)=exp(-int_t^t1 a)`.  This does not add sign
conditions on `a` or `b`, and `lem:gronwall` remains an obligation.

### `lem:dv_variation`

Source anchor: `appendix.tex:73`.

```tex
\KL(\nu \| \mu) = \sup_Z \left\{ \E_{\nu}[Z] - \log \E_{\mu}[\exp(Z)] \right\},
```

Lean-facing contract: `SALD.dvContract` plus
`dvVariationalObligation saldDvVariationSource` and
`dvVariationalFormulaInterface saldDvVariationSource`.  This is currently
`sourceCited`; the full supremum equality is not locally formalized.

Cycle 32 upper refinement:

| Source step | Lean-facing item | Status |
|---|---|---|
| `\mu` and `\nu` are probability distributions on the same space. | `dvVariationalFormulaInterface.probabilityMeasures`; `SALD.saldDvFiniteLogMgfContract.commonSpaceInterface` | source-cited interface + obligation for theorem instances |
| Supremum over random variables `Z` satisfying `\log E_\mu[\exp Z] < +\infty`. | `dvVariationalFormulaInterface.testFunctionClass`; `dvVariationalFormulaInterface.finiteLogMgfPredicate`; `SALD.saldDvFiniteLogMgfContract.finiteLogMgfCondition` | source-cited interface |
| Equality `KL(nu||mu)=sup_Z(E_nu[Z]-log E_mu[exp Z])`. | `dvVariationalFormulaInterface.supremumStatement`; `probability.dv_variational_formula`; `SALD.cycle32DvVariationInterfaceObligation` | source-cited, not formalized |
| One-sided use in SALD theorem blocks, `E_nu[Z] <= KL(nu||mu)+log E_mu[exp Z]`. | `dvVariationalFormulaInterface.oneSidedConsequence`; `AutoSamplingTheory.dvVariationalOneSidedConsequenceScalar`; `AutoSamplingTheory.dvVariationalOneSidedFromSupremumScalar`; theorem-specific finite-log-mgf obligations | source-cited dependency plus compiled scalar order bridges; local instantiation obligations remain |

Priority check for the proof-closure sprint: item (1) `lem:gronwall` remains
an obligation after cycle 31 partial sublemmas; cycle 32 selects item (2)
`lem:dv_variation` because the run focus requests it.  Items (3)
`eq:LSI-KL-FI`, (4) forward-KL Fokker--Planck/KL derivative, and (5) EM
interpolation Fokker--Planck remain later proof-closure targets.  No
source-index rebaseline is assigned unless reviewer reports a blocking anchor
defect.

Cycle 32 middle refinement: the local Mathlib audit found KL infrastructure in
`InformationTheory.KullbackLeibler.Basic` and tilted-measure infrastructure in
`MeasureTheory.Measure.Tilted`, but no ready theorem matching the paper's
Boucheron Corollary 4.15 display.  The Lean increment is therefore limited to
`AutoSamplingTheory.dvVariationalOneSidedConsequenceScalar`, which proves the
real-order rearrangement
`expectation - logMgf <= kl -> expectation <= kl + logMgf`.  The cited DV
equality, the supremum upper-bound input for each admissible `Z`, and all
common-space/measurability/finite-log-mgf witnesses remain explicit
dependencies through `SALD.cycle32DvVariationMiddleAuditContract` and
`SALD.cycle32DvVariationMiddleObligation`.

Cycle 32 lower refinement: `AutoSamplingTheory.dvVariationalOneSidedFromSupremumScalar`
now proves the scalar route from the source supremum display to the one-sided
DV inequality.  Its inputs are a bounded set of admissible real variational
values, membership of the chosen test value `E_nu[Z]-logMgf`, and the cited
identity `sSup admissibleValues = KL(nu||mu)`.  `SALD.cycle32DvVariationLowerObligation`
tracks the remaining analytic inputs: the Boucheron equality itself,
boundedness/admissibility of the test-value set, common probability space,
measurability, and finite-log-mgf witnesses.  `lem:dv_variation` remains
`sourceCited`.

Cycle 37 upper refinement: after cycle 36 advanced `lem:gronwall` under
explicit Mathlib side conditions but left the endpoint-safe differentiability
bridge open, the proof-closure order returns to item (2) `lem:dv_variation`.
`SALD.cycle37DvVariationUpperPacket` and
`SALD.cycle37DvVariationUpperObligation` keep the source statement fixed at
`appendix.tex:73-79` and Boucheron Corollary 4.15.  The lower target is one
declaration/interface only: either a genuinely compiling Mathlib-backed
entropy-duality interface using the available `klDiv` and tilted-measure
infrastructure, or a sharper source-cited theorem interface with explicit
common-space, absolute-continuity, measurability, finite-KL, and
finite-log-mgf hypotheses.  The cycle 32 scalar bridges remain post-DV
order consequences only, and no downstream theorem receives new hidden
finite-mgf or absolute-continuity assumptions.

Cycle 37 middle refinement: `AutoSamplingTheory.dvVariationalOneSidedOfTiltedRight`
now proves the one-sided admissible-test inequality
`E_nu[Z]-log E_mu[exp Z] <= KL(nu||mu)` under explicit Mathlib hypotheses:
probability measures on a common measurable space, `nu << mu`, integrability
of `Z` under `nu`, integrability of `exp Z` under `mu`, and integrability of
`llr nu mu` under `nu`.  The proof uses `mu.tilted Z`, absolute-continuity
into the tilted law, Gibbs nonnegativity, and the tilted-right
log-likelihood identity.  `SALD.cycle37DvVariationMiddleAuditContract` and
`SALD.cycle37DvVariationMiddleObligation` record this as a compiled one-sided
backend only; the Boucheron supremum equality in `appendix.tex:73-79` remains
source-cited through `probability.dv_variational_formula`.

Cycle 37 lower refinement: `AutoSamplingTheory.dvVariationalTiltedRightOneSidedConsequence`
now composes the tilted backend with the scalar rearrangement to prove the
paper-consumed consequence
`E_nu[Z] <= KL(nu||mu)+log E_mu[exp Z]` under the same explicit selected-test
hypotheses.  `SALD.cycle37DvVariationLowerObligation` records this lower
proof-producing step.  The source-cited supremum equality, existence of the
full finite-log-mgf test class, and SALD theorem-specific common-space,
absolute-continuity, measurability, finite-log-mgf, and finite-KL witnesses
remain obligations.

Cycle 42 middle refinement: `AutoSamplingTheory.dvFiniteLogMgfOfLeAlpha`
proves the alpha0-to-alpha finite-log-mgf bridge for selected scaled tests
`Z=alpha*q`, and `AutoSamplingTheory.dvVariationalOneSidedOfScaledTest`
applies the existing tilted backend to that test.  The hypotheses still expose
`nu << mu`, integrability of `alpha*q` under `nu`, integrability of
`llr nu mu`, and the alpha0 exponential moment.

Cycle 42 lower refinement: `AutoSamplingTheory.dvVariationalScaledTestEnergyBound`
turns the selected-test inequality into the source-shaped energy estimate
`E_nu[q] <= alpha^{-1} KL(nu||mu) + eAlpha` after `alpha>0` and the
alpha-complexity rewrite are supplied.  The companion theorem
`AutoSamplingTheory.dvVariationalScaledTestEnergyBoundWithCoeff` preserves a
nonnegative downstream prefactor, matching the coefficient use in
`appendix.tex:239-241`.  `SALD.cycle42DvVariationLowerObligation` records this
lower proof-producing step; `lem:dv_variation` itself remains source-cited.

### `def:PI`

Source anchor: `appendix.tex:86`.

```tex
\Var_\mu[\varphi]
= \E_{\mu}[ \varphi^2 ] - \E_{\mu}[\varphi]^2
\le
\frac{1}{\cPI~} \int \|\nabla \varphi\|^2 \dd\mu.
```

Lean-facing contract: `SALD.saldPIContract` and
`SALD.piDefinitionContract`.

### `eq:LSI-KL-FI`

Source anchor: `main_body.tex:202-215`.

```tex
\KL(\rho\|\pi) \le \frac{1}{2\cLSI~} \FI(\rho\|\pi),
```

Lean-facing contracts: `SALD.saldLSIContract`, `SALD.saldKLContract`,
`SALD.saldFIContract`, `SALD.saldLsiKlFiBridgeContract`,
`SALD.saldLsiKlFiDensityTestContract`, and `SALD.lsiKlFiVocabularyContract`.

Source-to-Lean bridge:

| Source step | Lean-facing item | Status |
|---|---|---|
| Assume `rho << pi` and write the density ratio `rho/pi`. | `SALD.saldKLContract`; `SALD.saldFIContract`; `SALD.saldLsiKlFiBridgeContract.absoluteContinuityInterface`; `SALD.saldLsiKlFiDensityTestContract.absoluteContinuity` | contract + obligation |
| Substitute `phi=sqrt(rho/pi)` into LSI. | `SALD.saldLsiKlFiBridgeContract.testFunctionInterface`; `SALD.saldLsiKlFiDensityTestContract.sqrtTestFunction`; `SALD.lsiKlFiDensityTestObligation` | obligation |
| Verify `int phi^2 dpi = 1`. | `SALD.saldLsiKlFiBridgeContract.normalizationStep`; `SALD.saldLsiKlFiDensityTestContract.normalization` | obligation |
| Identify the entropy term with `KL(rho||pi)`. | `SALD.saldLsiKlFiBridgeContract.entropyIdentity`; `SALD.saldLsiKlFiDensityTestContract.entropyRewrite` | obligation |
| Use `int ||nabla phi||^2 dpi = (1/4)*FI(rho||pi)`. | `SALD.saldLsiKlFiBridgeContract.fisherChainRule`; `SALD.saldLsiKlFiDensityTestContract.fisherChainRule` | obligation |
| Preserve the source coefficient `1/(2*C_LSI)`. | `SALD.saldLsiKlFiDensityTestContract.coefficientAudit`; `lsiToKlFiObligation saldKlFiLsiSource` | obligation |

Cycle 33 upper proof-closure packet:

Priority check before assigning work: the active closure order is
(1) `lem:gronwall`, (2) `lem:dv_variation`, (3) `eq:LSI-KL-FI`,
(4) the forward-KL Fokker--Planck/KL derivative identity, and
(5) the Euler--Maruyama interpolation Fokker--Planck backend.  Cycle 31 left
Gronwall as partial compiled sublemmas plus obligations; cycle 32 left DV as
Boucheron-source-cited with compiled scalar order bridges.  This cycle
therefore selects item (3), `eq:LSI-KL-FI`, and does not assign a
source-index rebaseline.

Objective: translate the paper's actual `main_body.tex:202-215` bridge into
the next proof-producing Lean slice.  Lower should start before the global
analytic theorem by proving local density/test-function sublemmas for
`phi=sqrt(r)`, where `r=d rho/d pi`: pointwise square/root normalization,
the entropy integrand rewrite after `phi^2=r`, and only then a narrow
FI-chain-rule interface.  The cycle-29 helper
`SALD.lsiKlFiCoefficientAuditScalar` remains the final scalar coefficient
step after these analytic inputs are supplied.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 33 LSI/KL/FI upper packet | Select proof-producing density/test-function work for `phi=sqrt(r)` instead of another first-appendix/source-index pass. | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; cycle-29 coefficient audit | planned lower lemma near `SALD.lsiKlFiSqrtSquareScalar` or a similarly narrow source-named declaration | `main_body.tex:202-215`, first slice `main_body.tex:208-215` | `eq:LSI-KL-FI`; all forward-KL theorem contracts | lower-ready proof sublemma plus obligation |
| Sqrt-density normalization and entropy rewrite | From `r >= 0`, `phi=sqrt(r)`, and `int r d pi=1`, prove the pointwise/integral handoff `phi^2=r`, then use it to rewrite the LSI entropy side toward KL. | Radon-Nikodym density convention; finite entropy; zero-density convention or positivity approximation | planned lower lemma before the FI chain-rule backend | `main_body.tex:208-215` | `sald.lsi_kl_fi.density_test_interface` | proof-producing local slice |
| FI chain-rule interface | Keep `int ||nabla sqrt(r)||^2 dpi = (1/4)*FI(rho||pi)` explicit; prove only scalar/vector calculus fragments if the full Sobolev chain rule is too large. | differentiability/positivity or approximation of `r`; finite FI | `SALD.saldLsiKlFiDensityTestContract.fisherChainRule`; `SALD.lsiKlFiCoefficientAuditScalar` | `main_body.tex:208-215` | `probability.lsi_to_kl_fi`; forward-KL derivative inequalities | obligation until compiled |

Mode discipline:

- `faithfulPaper`; use only the original `main_body.tex` display and keep
  `sald_version_2.tex` out of scope.
- Preserve the source LSI constant exactly: the final displayed comparison is
  `KL(rho||pi) <= FI(rho||pi)/(2*C_LSI)`.
- Treat Radon-Nikodym density construction, admissibility/approximation of
  `sqrt(r)`, entropy integrability, zero-density handling, and the FI
  chain-rule as explicit assumptions or obligations unless they are proved
  locally.
- Keep Phase 1 transcript/proof-closure discipline; do not reorganize this
  into a general teaching API.

Non-goals:

- Do not replace LSI by PI, Pinsker, Talagrand, transport, or a theorem-level
  forward-KL argument.
- Do not promote `probability.lsi_to_kl_fi`, `SALD.lsiKlFiDensityTestObligation`,
  or `SALD.saldStatusForLabel "eq:LSI-KL-FI"` to formalized.
- Do not reopen Gronwall, DV, forward-KL derivative, or EM interpolation work
  during this LSI/KL/FI packet.
- Do not run a source-index rebaseline unless reviewer reports a concrete
  source-anchor defect.

Lower packet:

- Target exactly `SALD.saldLsiKlFiDensityTestContract` /
  `SALD.lsiKlFiDensityTestObligation` /
  `sald.lsi_kl_fi.density_test_interface`.
- First attempt one compiled theorem-independent lemma for the `sqrt(r)`
  bridge, preferably the pointwise `phi^2=r` normalization/entropy handoff
  under `0 <= r`, before attempting the full Radon-Nikodym or Sobolev backend.
- If that closes, connect it to the integral normalization or entropy rewrite
  as a second narrow lemma, keeping finite-integrability and zero-density
  hypotheses explicit.
- If the FI chain-rule is too large for local Mathlib, record it as a precise
  source-cited/obligation interface and use
  `SALD.lsiKlFiCoefficientAuditScalar` only after the chain-rule identity is
  supplied.

Reviewer checklist:

- The cycle explicitly chooses proof-closure item (3), `eq:LSI-KL-FI`, after
  noting the statuses of Gronwall and DV.
- Any new Lean proof is only a local density/test-function, entropy, or scalar
  coefficient lemma tied to `main_body.tex:202-215`; no hidden smoothness,
  positivity, or integrability assumption is smuggled into later theorem
  contracts.
- `eq:LSI-KL-FI` remains `ProofStatus.obligation`; the full bridge is not
  closed by `axiom`, `sorry`, `admit`, `Prop := True`, or `:= trivial`.
- `python3 tools/astis.py check` passes.

Cycle 38 upper proof-closure packet:

Priority check before assigning work: the active closure order is still
(1) `lem:gronwall`, (2) `lem:dv_variation`, (3) `eq:LSI-KL-FI`,
(4) the forward-KL Fokker--Planck/KL derivative identity, and
(5) the Euler--Maruyama interpolation Fokker--Planck backend.  Cycle 36
advanced Gronwall by a compiled assembly under explicit Mathlib side
conditions, while endpoint-safe differentiability remains open.  Cycle 37
advanced DV by a compiled one-sided tilted-measure backend, while the
Boucheron supremum equality remains source-cited.  This cycle therefore
selects item (3), `eq:LSI-KL-FI`, with no source-index rebaseline.

Objective: keep the source theorem fixed at `main_body.tex:202-215` and move
from the cycle-33 `phi=sqrt(r)` scalar helpers toward the remaining
Fisher-information chain-rule and admissibility bridge:

```tex
\int \|\nabla \sqrt{\rho/\pi}\|^2\,d\pi
= \frac14 \FI(\rho\|\pi).
```

The target is not the full measure-theoretic theorem in one step.  Middle
should translate the source line into Lean-facing hypotheses for the density
ratio `r=d rho/d pi`, the zero-density/positivity convention, smooth or
approximating admissible tests, finite KL/FI, and the chain-rule identity.
Lower should first attempt one proof-producing local lemma, such as a
pointwise/vector-norm handoff or scalar integral bridge feeding the existing
`SALD.lsiKlFiDensityTestBridgeScalar`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 38 LSI/KL/FI upper packet | Select the Fisher chain-rule/admissibility bridge after cycle-33 sqrt-density scalar helpers. | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `SALD.lsiKlFiDensityTestBridgeScalar`; `SALD.lsiKlFiCoefficientAuditScalar`; cycle 36 Gronwall and cycle 37 DV status checks | `SALD.cycle38LsiKlFiUpperPacket`; `SALD.cycle38LsiKlFiUpperObligation` | `main_body.tex:202-215`, first lower slice `main_body.tex:208-215` | `eq:LSI-KL-FI`; all forward-KL theorem contracts | workflow obligation |
| Fisher chain-rule scalar bridge | Prove the local positive-density coefficient behind `d sqrt(r)` and `d log r`, and convert the normalized density-test bridge to the half-Fisher form consumed by forward-KL. | positivity of `r`; supplied derivative identities; normalized LSI density-test inputs; cycle-33 scalar bridge | `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainScalar`; `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainOfDerivativesScalar`; `SALD.lsiKlFiHalfFisherScalar`; `SALD.lsiKlFiDensityTestHalfFisherScalar`; `SALD.cycle38LsiKlFiMiddleObligation` | `main_body.tex:208-215` | `probability.lsi_to_kl_fi`; `SALD.forwardKlLsiDerivativeBoundScalar`; forward-KL derivative inequalities | formalized scalar sublemmas plus obligation |
| Finite-coordinate Fisher-chain handoff | Sum the pointwise coefficient over finitely many coordinates and expose the exact `dirichlet=(1/4)*FI` bridge after supplied finite-sum identifications. | positivity of `r`; coordinate derivative identities; supplied Dirichlet finite sum; supplied Fisher finite sum | `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainFiniteSumScalar`; `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainFiniteSumHandoffScalar`; `SALD.cycle38LsiKlFiLowerObligation` | `main_body.tex:208-215` | `SALD.lsiKlFiDensityTestBridgeScalar`; `probability.lsi_to_kl_fi` | formalized finite-coordinate algebra plus obligation |
| Remaining Fisher chain-rule backend | Lift the scalar coefficient to `int ||nabla sqrt(r)||^2 d pi = (1/4)*FI(rho||pi)` or record a precise source-cited interface. | Radon-Nikodym density, positivity/zero-set convention, vector gradients, differentiability or approximation of `sqrt(r)`, finite FI | `SALD.lsiKlFiDensityTestObligation`; `probability.lsi_to_kl_fi` | `main_body.tex:208-215` | all theorem blocks using LSI contraction | obligation |

Cycle 38 middle additions:

- `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainScalar` proves
  `((1/(2*sqrt r))*dr)^2 = (1/4)*(r*(dr/r)^2)` for `0<r`, matching the
  scalar coefficient in the source chain rule for `phi=sqrt(r)`.
- `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainOfDerivativesScalar`
  packages the same identity after named derivative hypotheses for
  `d sqrt(r)` and `d log r`.
- `SALD.lsiKlFiHalfFisherScalar` converts the displayed
  `KL <= FI/(2*C_LSI)` into `C_LSI*KL <= (1/2)*FI` under `C_LSI>0`.
- `SALD.lsiKlFiDensityTestHalfFisherScalar` composes the existing normalized
  density-test bridge with that half-Fisher coefficient handoff.

These are theorem-independent scalar steps only.  The Radon-Nikodym density,
smooth or approximating admissible test, zero-density convention, vector
Sobolev chain rule, integral identity, finite KL/FI interfaces, and full
`probability.lsi_to_kl_fi` theorem remain obligations.

Cycle 38 lower additions:

- `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainFiniteSumScalar` sums the
  pointwise positive-density coefficient over a finite coordinate type:
  `sum_i (dSqrt_i)^2 = (1/4)*(r*sum_i (dLog_i)^2)`.
- `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainFiniteSumHandoffScalar`
  turns supplied finite-coordinate Dirichlet and Fisher identifications into
  the exact `dirichlet=(1/4)*FI` input consumed by
  `SALD.lsiKlFiDensityTestBridgeScalar`.
- `SALD.cycle38LsiKlFiLowerObligation` records that this is still only local
  finite-coordinate algebra.  The Radon-Nikodym density construction,
  coordinate-to-vector-gradient equivalence, integral transport,
  admissibility/approximation of `sqrt(r)`, zero-density convention, and finite
  KL/FI hypotheses remain obligations.

Mode discipline and non-goals:

- `faithfulPaper`; use only original `main_body.tex:202-215`; keep
  `sald_version_2.tex` excluded.
- Preserve the exact source constant `1/(2*C_LSI)` and do not add theorem
  assumptions to `thm:forward-KL` or downstream SALD results.
- Do not replace LSI by PI, Pinsker, Talagrand, transport, or theorem-level
  forward-KL reasoning.
- If the Sobolev/measure-theoretic backend is too large, record a precise
  source-cited or obligation interface and keep `eq:LSI-KL-FI` below
  formalized status.

Reviewer checklist:

- `SALD.cycle38LsiKlFiUpperPacket` explicitly records the closure-order
  check and selects item (3), `eq:LSI-KL-FI`.
- `SALD.lsiKlFiVocabularyContract`, `SALD.lsiKlFiDensityTestObligation`,
  `probability.lsi_to_kl_fi`, and
  `SALD.saldStatusForLabel "eq:LSI-KL-FI"` remain obligations.
- Any new proof-producing lemma is local to the density/test-function,
  entropy, Fisher-chain, or scalar coefficient bridge at `main_body.tex:202-215`.
- `python3 tools/astis.py check` passes and the fake-proof scan stays clean.

Cycle 43 upper proof-closure packet:

Priority check before assigning work: the active closure order remains
(1) `lem:gronwall`, (2) `lem:dv_variation`, (3) `eq:LSI-KL-FI`,
(4) the forward-KL Fokker--Planck/KL derivative identity, and
(5) the Euler--Maruyama interpolation Fokker--Planck backend. Cycle 41
narrowed Gronwall endpoint-safe calculus but left the source differentiability
bridge open. Cycle 42 narrowed DV selected scaled-test finite-mgf and
one-sided energy bounds while the Boucheron supremum equality remains
source-cited. This cycle therefore selects item (3), `eq:LSI-KL-FI`, and does
not assign source-index rebaseline work.

Objective: keep the source theorem fixed at `main_body.tex:202-215` and move
past the cycle-33 scalar sqrt-density helpers and cycle-38 finite-coordinate
Fisher handoffs toward the remaining density/test-function backend:
Radon-Nikodym density normalization, entropy integral transport, admissibility
or approximation of `phi=sqrt(rho/pi)`, zero-density handling, and the
vector/integral Fisher chain rule

```tex
\int \|\nabla \sqrt{\rho/\pi}\|^2\,d\pi
= \frac14 \FI(\rho\|\pi).
```

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 43 LSI/KL/FI upper packet | Select one remaining measure-level density/test-function backend after cycle-38 scalar and finite-coordinate Fisher progress. | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; cycle-33 sqrt-density helpers; cycle-38 Fisher-chain helpers | `SALD.cycle43LsiKlFiUpperPacket`; `SALD.cycle43LsiKlFiUpperObligation` | `main_body.tex:202-215`, next lower slice `main_body.tex:208-215` | `eq:LSI-KL-FI`; all forward-KL theorem contracts | workflow obligation |
| Radon-Nikodym and entropy transport | Prove or source-cite the density ratio `r=d rho/d pi`, probability normalization `int r d pi=1`, and entropy identity `int r log r d pi = KL(rho||pi)`. | absolute continuity; finite KL; zero-density convention | lower-selected proof lemma or precise interface under `SALD.lsiKlFiDensityTestObligation` | `main_body.tex:208-215` | `probability.lsi_to_kl_fi`; forward-KL LSI contraction | obligation |
| Admissible sqrt test and Fisher chain rule | Prove or source-cite admissibility/approximation of `sqrt(r)` and the integral identity `int ||nabla sqrt(r)||^2 d pi=(1/4)*FI`. | positivity/zero-set convention; differentiability or Sobolev chain rule; finite FI; cycle-38 finite-coordinate handoff | lower-selected proof lemma or precise interface under `SALD.lsiKlFiDensityTestObligation` | `main_body.tex:208-215` | `SALD.lsiKlFiDensityTestBridgeScalar`; `SALD.forwardKlLsiDerivativeBoundScalar` | obligation |

Mode discipline and non-goals:

- `faithfulPaper`; use only original `main_body.tex:202-215`; keep
  `sald_version_2.tex` excluded.
- Preserve the exact source constant `1/(2*C_LSI)` and do not add theorem
  assumptions to `thm:forward-KL` or downstream SALD results.
- Do not replace LSI by PI, Pinsker, Talagrand, transport, or theorem-level
  forward-KL reasoning.
- Do not reopen Gronwall, DV, forward-KL derivative, or EM interpolation work
  during this LSI/KL/FI packet.
- If the Sobolev/measure-theoretic backend is too large, record a precise
  source-cited or obligation interface and keep `eq:LSI-KL-FI` below
  formalized status.

Lower packet:

- Target exactly `SALD.saldLsiKlFiDensityTestContract`,
  `SALD.lsiKlFiDensityTestObligation`, and
  `sald.lsi_kl_fi.density_test_interface`.
- First attempt one proof-producing Lean lemma for a remaining local backend:
  Radon-Nikodym normalization, entropy integral transport, admissibility or
  approximation of `sqrt(r)`, zero-density convention, or the vector/integral
  Fisher chain rule.
- If the full analytic theorem is too large, expose the exact source-cited
  interface with absolute continuity, nonnegative density ratio, finite KL/FI,
  admissibility/approximation, zero-density handling, and the displayed
  integral identities; do not mark it formalized.

Reviewer checklist:

- `SALD.cycle43LsiKlFiUpperPacket` explicitly records the closure-order check
  and selects item (3), `eq:LSI-KL-FI`.
- `SALD.lsiKlFiVocabularyContract`, `SALD.lsiKlFiDensityTestObligation`,
  `probability.lsi_to_kl_fi`, and
  `SALD.saldStatusForLabel "eq:LSI-KL-FI"` remain obligations.
- Any new proof-producing lemma is local to `main_body.tex:202-215`.
- `python3 tools/astis.py check` passes and the fake-proof scan stays clean.

## Cycle 43 Middle Density And Entropy Transport

Middle stayed on proof-closure item (3), `eq:LSI-KL-FI`, and translated the
first remaining measure-level density/test-function backend from
`main_body.tex:208-215` into proof-producing Mathlib-backed Lean declarations.

Accepted compiled core:

| Source step | Lean declaration | Still open |
|---|---|---|
| `rho << pi`; the density ratio `r=d rho/d pi` has mass one under `pi`. | `AutoSamplingTheory.lsiKlFiRnDerivLIntegralMassOne`; `AutoSamplingTheory.lsiKlFiRnDerivDensityMassOne` | Source smooth-density conventions and finite-KL/FI theorem interfaces |
| With `phi=sqrt(r)`, the LSI normalization `int phi^2 d pi=1` follows from the Radon-Nikodym mass theorem and the pointwise square identity. | `AutoSamplingTheory.lsiKlFiSqrtRnDerivTestMassOne` | Smooth/admissible `sqrt(r)` or approximation/closure in the LSI class |
| The entropy side rewrites from the sqrt-test integrand to the KL log-likelihood integral. | `AutoSamplingTheory.lsiKlFiRnDerivEntropyIntegral`; `AutoSamplingTheory.lsiKlFiSqrtRnDerivEntropyIntegral` | Finite KL use in theorem contexts and zero-density convention details |
| Middle ledger keeps the full comparison open after the compiled density/entropy plumbing. | `SALD.cycle43LsiKlFiMiddleObligation`; `sald.lsi_kl_fi.cycle43_middle_density_entropy` | Vector/integral Fisher chain rule `int ||nabla sqrt(r)||^2 d pi=(1/4)*FI`, admissibility/approximation, and full `probability.lsi_to_kl_fi` |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 43 middle density normalization | Formalize `int d rho/d pi d pi=1` and `int (sqrt(d rho/d pi))^2 d pi=1` for probability measures `rho << pi`. | Mathlib Radon-Nikodym derivative; probability mass; cycle-33 square identity | `AutoSamplingTheory.lsiKlFiRnDerivLIntegralMassOne`; `AutoSamplingTheory.lsiKlFiRnDerivDensityMassOne`; `AutoSamplingTheory.lsiKlFiSqrtRnDerivTestMassOne` | `main_body.tex:208-215` | `SALD.lsiKlFiDensityTestBridgeScalar`; `probability.lsi_to_kl_fi` | formalized sublemmas |
| Cycle 43 middle entropy transport | Transport the sqrt-test entropy integral to the KL log-likelihood integral under `rho << pi`. | Mathlib `integral_rnDeriv_mul_log`; cycle-33 entropy integrand rewrite | `AutoSamplingTheory.lsiKlFiRnDerivEntropyIntegral`; `AutoSamplingTheory.lsiKlFiSqrtRnDerivEntropyIntegral` | `main_body.tex:208-215` | `SALD.lsiKlFiDensityTestBridgeScalar`; forward-KL LSI contraction | formalized sublemmas |
| Remaining LSI/KL/FI theorem backend | Supply the admissible-test/approximation theorem and vector/integral Fisher chain rule without changing theorem assumptions. | finite KL/FI; zero-density handling; Sobolev chain rule; cycle-38 finite-coordinate algebra | `SALD.lsiKlFiDensityTestObligation`; `probability.lsi_to_kl_fi` | `main_body.tex:202-215` | all theorem blocks using LSI contraction | obligation |

No SLT dependency was imported.  `eq:LSI-KL-FI`,
`SALD.lsiKlFiDensityTestObligation`, and `probability.lsi_to_kl_fi` remain
obligations because the source's admissibility/approximation and
Fisher-information integral chain-rule backends are still open.

## Cycle 43 Lower Integral Fisher Chain

Lower stayed on proof-closure item (3), `eq:LSI-KL-FI`, and advanced the
Fisher side of `main_body.tex:208-215` without changing the theorem target.

Accepted compiled core:

| Source step | Lean declaration | Still open |
|---|---|---|
| Push the finite-coordinate chain-rule coefficient through the `pi`-integral under a.e. positivity and supplied coordinate derivative identities for `sqrt(r)` and `log r`. | `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainIntegralFiniteSum` | Coordinate-to-vector-gradient equivalence, zero-density Sobolev handling, and integrability side conditions |
| Package the supplied finite-coordinate Dirichlet and Fisher integral identifications into the exact `dirichlet=(1/4)*FI` input used by the scalar LSI bridge. | `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar` | Identifying those finite sums with the paper's vector-gradient FI and proving admissibility/approximation of `sqrt(r)` |
| Lower ledger keeps the full comparison open after the integral finite-sum handoff. | `SALD.cycle43LsiKlFiLowerObligation`; `sald.lsi_kl_fi.cycle43_lower_integral_fisher_chain` | Full `probability.lsi_to_kl_fi`, finite theorem-level KL/FI interfaces, and Sobolev/vector-gradient backend |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 43 lower integral Fisher-chain handoff | Convert the cycle-38 finite-coordinate pointwise Fisher coefficient into an a.e. integral identity. | cycle-38 finite-coordinate Fisher-chain lemmas; a.e. positivity; a.e. coordinate derivative identities | `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainIntegralFiniteSum`; `AutoSamplingTheory.lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar` | `main_body.tex:208-215` | `SALD.lsiKlFiDensityTestBridgeScalar`; `SALD.lsiKlFiDensityTestHalfFisherScalar`; `probability.lsi_to_kl_fi` | formalized finite-coordinate integral handoff plus obligation |
| Remaining LSI/KL/FI theorem backend | Supply admissible-test/approximation, zero-density Sobolev conventions, vector-gradient equivalence, finite KL/FI, and the final LSI-to-KL/FI theorem. | cycle-43 density/entropy transport; cycle-43 lower integral finite-sum handoff | `SALD.lsiKlFiDensityTestObligation`; `probability.lsi_to_kl_fi` | `main_body.tex:202-215` | all theorem blocks using LSI contraction | obligation |

No SLT dependency was imported.  `eq:LSI-KL-FI`,
`SALD.lsiKlFiDensityTestObligation`, and `probability.lsi_to_kl_fi` remain
obligations.

### `def:alpha-complexity`

Source anchor: `main_body.tex:218-228`.

```tex
\mathfrak{E}_\alpha(\pi_t,v_t)
:=
\frac{1}{\alpha}\log \E_{\pi_t}\!\left[\exp\!\big(\alpha \|v_t\|^2\big)\right].
```

Lean-facing contract: `SALD.saldAlphaComplexityContract`.  The definition is
contract data.  The finite log-mgf step needed by DV for
`\alpha\in(0,\alpha_0]` is an obligation, not a formalized theorem.

### `thm:forward-KL`

Source statement anchor: `main_body.tex:240`.

The theorem assumes LSI constants `\cLSI{t} >= 0` along the moving target
`(\pi_t)_{t in [0,T]}` and a transport velocity `v_t` with
`\mathfrak{E}_{\alpha_0}(\pi_t,v_t)<+\infty` for some `\alpha_0>0`.  For each
`\alpha in (0,\alpha_0]`, the law `(\rho_s)` of SALD `\eqref{eq:SALD}`
satisfies the two-term terminal KL bound in `main_body.tex:243-246`.

Lean-facing contract: `SALD.continuousSaldContract`, with exact statement
shape recorded by `SALD.continuousForwardKlStatementContract`.  Cycle 6 also
records the LSI/DV/Gronwall coefficient flow in
`SALD.forwardKlDependencyChainAuditContract`, with proof obligation
`SALD.forwardKlCoefficientChainObligation`.

Source proof anchor: `appendix.tex:164-252`.

Middle cycle 2 compiled interfaces:

| Source proof step | Lean-facing item | Dependency classification | Status |
|---|---|---|---|
| Differentiate `\KL(\rho_s\|\tilde\pi_s)` and use `\int \partial_s\rho_s dx=0` (`appendix.tex:168-174`). | `SALD.forwardKlDerivativeCandidateContract.klDerivativeIdentity` | local lemma: differentiation under the integral and mass conservation | obligation |
| Substitute the SALD Fokker--Planck equation (`appendix.tex:176-185`). | `SALD.forwardKlDerivativeCandidateContract.saldFokkerPlanck`; source anchors `eq:SALD`, `eq:FP-eq` | internal paper step plus Fokker--Planck backend | obligation |
| Show `\tilde v_s=\dot t(s)v_{t(s)}` generates `\tilde\pi_s` and integrate by parts (`appendix.tex:187-208`). | `SALD.forwardKlDerivativeCandidateContract.targetVelocity`; `TransportVelocityContract` | local lemma plus source-contract gap for boundary conditions | obligation |
| Apply LSI and change variables from `s` to `t` (`appendix.tex:210-228`). | `SALD.forwardKlDerivativeCandidateContract.lsiStep`; `SALD.forwardKlDerivativeCandidateContract.timeChangedInequality` | LSI/KL/FI obligation plus source-contract gap for inverse schedule regularity | obligation |
| Expose derivative side conditions before proof search (`appendix.tex:168-228`). | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlDensityBoundaryObligation`; `SALD.forwardKlScheduleTimeChangeObligation` | local density/boundary/schedule obligations; no theorem assumption promoted | obligation |
| Apply DV with `Z=\alpha\|v_t\|^2` (`appendix.tex:230-241`). | `SALD.forwardKlDvEnergyCandidateContract`; `dvVariationalObligation` | external cited result plus local finite-log-mgf lemma | obligation + source-cited |
| Apply Gronwall with `a(t)=\dot{s}(t)\cLSI{t}-(1/2)\dot{s}(t)^{-1}\alpha^{-1}` and `b(t)=(1/2)\dot{s}(t)^{-1}\mathfrak E_\alpha(\pi_t,v_t)` (`appendix.tex:244-252`). | `SALD.forwardKlGronwallInstantiationContract`; `SALD.saldGronwallCandidateContract` | Gronwall obligation plus source-contract gap for continuity/integrability | obligation |
| Audit the coefficient chain from post-Young inequality through LSI, time change, DV, and Gronwall exponent split (`appendix.tex:210-252`; theorem display `main_body.tex:243-246`). | `SALD.forwardKlDependencyChainAuditContract`; `SALD.forwardKlCoefficientChainObligation` | coefficient bookkeeping obligation; no new theorem assumptions | obligation |

| Source proof step | Lean-facing item | Status |
|---|---|---|
| Differentiate `\KL(\rho_s\|\tilde\pi_s)` and insert SALD Fokker--Planck (`appendix.tex:166-189`). | `SALD.forwardKlDerivativeObligation` | obligation |
| Convert from `s` to `t`, use `\dot{s}(t)`, and apply LSI to the FI term (`appendix.tex:190-225`). | `SALD.forwardKlDerivativeObligation`; `lsiToKlFiObligation` | obligation |
| Apply DV with `Z=\alpha\|v_t\|^2` to bound the velocity norm (`appendix.tex:229-241`). | `SALD.forwardKlDvEnergyObligation`; `dvVariationalObligation` | obligation + source-cited |
| Apply `lem:gronwall` with the source signs and split the exponential terms (`appendix.tex:242-252`). | `SALD.forwardKlGronwallApplicationObligation`; `SALD.gronwallAnalyticObligation` | obligation |
| Preserve the scalar coefficient flow and endpoint identifications before lower proof search (`appendix.tex:210-252`). | `SALD.forwardKlCoefficientChainObligation`; `SALD.forwardKlDependencyChainAuditContract` | obligation |

### `thm:forward-KL-discrete`

Source statement anchor: `main_body.tex:301`.

The theorem assumes the continuous `thm:forward-KL` hypotheses, score
Lipschitz conditions `eq:lip_SALD_1` and `eq:lip_SALD_2`, finite
`\alpha_0'` exponential complexities for `\nabla\log\pi_t` and `1+M`, and
`4\eta^2L_{\pi,\mathrm{space}}^2<1/2`.  For linear slowdown `t(s)=s/r`, it
bounds `\KL(\rho_K^\eta\|\pi_T)` by the continuous contraction/complexity
terms plus the accumulated one-step errors `2r\eta^2\bar\Gamma/\alpha'` and
`2r\eta\bar\Delta_{\alpha'}`.

Lean-facing contract: `SALD.discreteSaldContract`, with exact statement shape
recorded by `SALD.discreteForwardKlStatementContract`.

Source proof anchor: `appendix.tex:260-592`.

Cycle 3 compiled interfaces:

| Source proof step | Lean-facing item | Dependency classification | Status |
|---|---|---|---|
| Define the continuous EM interpolation (`appendix.tex:260-266`). | `SALD.discreteSaldEulerMaruyamaContract`; `SALD.discreteForwardKlEmInterpolationObligation`; `SALD.discreteForwardKlEmInterpolationSideConditionContract` | local endpoint laws, conditional drift, EM Fokker--Planck backend, and stitched-interval regularity | contract + obligation |
| Isolate the conditional drift and interpolation Fokker--Planck line ledger (`appendix.tex:347-385`). | `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract`; `SALD.cycle15DiscreteForwardKlConditionalDriftDensityObligation`; `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerContract`; `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerObligation`; `SALD.discreteForwardKlEmConditionalFpObligation` | conditional-expectation, density, Laplacian split, and integration-by-parts backend; endpoint and accumulated-error algebra excluded | obligation |
| State the frozen score-defect lemma (`appendix.tex:268-330`). | `SALD.frozenDeltaCrossLipSaldContract`; `SALD.discreteForwardKlFrozenDeltaObligation` | specialization of later `lem:frozen_delta_cross_lip`; proof omitted in source | obligation |
| Differentiate `\KL(\hat\rho_s\|\tilde\pi_s)` and insert interpolation Fokker--Planck (`appendix.tex:334-453`). | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.discreteForwardKlDerivativeObligation` | local lemma plus density/boundary side conditions | obligation |
| Bound the frozen and moving cross terms (`appendix.tex:454-523`). | `SALD.discreteForwardKlFrozenDeltaObligation`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessObligation`; `SALD.discreteForwardKlDvVelocityObligation` | frozen-defect lemma plus theorem-specific EM-interpolation DV finite-log-mgf witness | obligation + source-cited |
| Change from `s` to `t` and apply Gronwall (`appendix.tex:526-592`). | `SALD.discreteForwardKlGronwallInstantiationContract`; `SALD.discreteForwardKlGronwallAccumulationObligation` | Gronwall obligation and stitched-interval regularity gap | obligation |
| Specialize to linear slowdown and collect the main-body constants (`main_body.tex:299-323`; appendix display `appendix.tex:557-590`). | `SALD.discreteForwardKlLinearSlowdownObligation`; `SALD.discreteForwardKlGronwallInstantiationContract` | algebraic specialization of the source Gronwall display | obligation |
| Bound the residual Gronwall exponent by the full positive factor (`appendix.tex:557-590`; `main_body.tex:309-323`). | `SALD.discreteForwardKlResidualExponentBoundObligation` | local sign, positivity, and interval-integral monotonicity facts; no SLT reuse | obligation |
| Audit the one-step coefficient chain from frozen/moving cross terms through accumulated `barGamma` and `barDelta` errors (`appendix.tex:454-592`; `main_body.tex:309-323`). | `SALD.discreteForwardKlCoefficientChainAuditContract`; `SALD.discreteForwardKlCoefficientChainObligation` | coefficient bookkeeping tying derivative, DV, time change, Gronwall, endpoints, and linear slowdown together | obligation |

Lower cycle 3 refinement:

| Source proof step | Lean-facing item | Status |
|---|---|---|
| `appendix.tex:260-266`, `appendix.tex:334-335` endpoint laws for `hat rho_s` | `SALD.discreteForwardKlEmEndpointObligation` | obligation |
| `appendix.tex:347-385` conditional drift and interpolation Fokker--Planck equation | `SALD.discreteForwardKlEmConditionalFpObligation` | obligation |
| `appendix.tex:557-590` global Gronwall application after per-interval inequalities | `SALD.discreteForwardKlStitchedIntervalRegularityObligation` | obligation |

The discrete differential inequality preserved in the contract is:

```text
dK/dt <= -(dot{s}(t)*C_LSI(t)
  - dot{s}(t)^(-1)*alpha^(-1)
  - 2*dot{s}(t)*eta^2*alpha'^(-1)*Gamma(t))*K(t)
  + dot{s}(t)^(-1)*E_alpha(pi_t,v_t)
  + 2*dot{s}(t)*eta*Delta(t).
```

Cycle 11 upper refinement:
`SALD.discreteForwardKlDvFiniteLogMgfWitnessContract` isolates the discrete DV
side condition used at `appendix.tex:493-523`.  The source applies
`lem:dv_variation` with `nu=\hat\rho_s`, `mu=\tilde\pi_s=\pi_{t(s)}`, and
`Z=\alpha\|v_{t(s)}\|^2`, then multiplies the output by `\dot t(s)^2`.
The new witness records common-space and absolute-continuity obligations for
the EM interpolation law, reuses the continuous alpha0-to-alpha finite-log-mgf
monotonicity for the `\pi_{t(s)}` log-mgf, keeps measurability and
positive-alpha scaling explicit, and preserves the later time-change
coefficient `\dot{s}(t)^{-1}\alpha^{-1}`.  The named obligation is
`SALD.discreteForwardKlDvFiniteLogMgfWitnessObligation`; it does not add a
new assumption to `thm:forward-KL-discrete`.

Cycle 11 middle refinement:
`SALD.cycle11DiscreteForwardKlMiddleContract` now maps the cycle-focus proof
route from the EM interpolation through one-step defects and accumulated-error
collection.  The map keeps `appendix.tex:260-266`, `appendix.tex:347-385`,
`appendix.tex:454-523`, `appendix.tex:526-590`, and
`main_body.tex:309-323` separated into existing Lean-facing interfaces:
`SALD.discreteForwardKlEmInterpolationSideConditionContract`,
`SALD.frozenDeltaCrossLipSaldContract`,
`SALD.discreteForwardKlDerivativeCandidateContract`,
`SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`,
`SALD.discreteForwardKlGronwallInstantiationContract`, and
`SALD.discreteForwardKlAccumulatedErrorBridgeContract`.  The named obligation
`SALD.discreteForwardKlEmDefectAccumulationMiddleObligation` is a lower-ready
packet: lower should refine either the EM conditional-drift/Fokker--Planck
backend or the accumulated-error endpoint/exponent algebra, while leaving the
source theorem statement and all `Gamma`, `Delta`, `barGamma`, and
`barDelta` constants unchanged.

Cycle 11 lower refinement:
`SALD.discreteForwardKlResidualExponentBoundObligation` isolates the scalar
residual-exponent step inside the accumulated-error bridge.  After substituting
`t(s)=s/r`, the obligation is only to bound
`exp(-int_t^T a(u)du)` by
`exp(T/(r*alpha)+2*r*eta^2*barGamma/alpha')` using nonnegative LSI,
positive `alpha`, `alpha'`, and `r`, plus interval-integral monotonicity for
the nonnegative `Gamma` contribution.  It is local real/integral algebra, not
a new theorem assumption and not an SLT import.

Cycle 15 upper refinement:
`SALD.cycle15DiscreteForwardKlUpperPacket` selects the EM interpolation
side-condition spine for the next lower packet while keeping
`thm:forward-KL-discrete` fixed.  The selected lower slice is
`sald.discrete_forward_kl.em_conditional_fokker_planck`: formalize only the
conditional frozen drift `bar b_{k,s}` and the interpolation Fokker--Planck
equation from `appendix.tex:347-385`, including the Laplacian split relative
to `tilde pi_s`.  Endpoint law matching
`sald.discrete_forward_kl.em_endpoint_laws`, stitched regularity
`sald.discrete_forward_kl.stitched_interval_regularity`, the one-step
frozen-defect lemma, DV witness, and accumulated-error bridge remain separate
obligations.  This packet preserves the source route
EM interpolation -> frozen defect -> LSI -> DV -> Gronwall ->
linear-slowdown collection and does not change `Gamma`, `Delta`, `barGamma`,
`barDelta`, `alpha`, `alpha'`, `eta`, or `r`.

Cycle 15 middle refinement:
`SALD.cycle15DiscreteForwardKlMiddleContract` turns the upper packet into a
lower-ready source-to-Lean map for `thm:forward-KL-discrete`.  It keeps the
ordered source route
`appendix.tex:260-266`/`334-335` endpoint laws ->
`appendix.tex:347-385` conditional drift and interpolation Fokker--Planck ->
`appendix.tex:454-491` frozen one-step defect, Young, and LSI ->
`appendix.tex:493-523` discrete DV velocity witness ->
`appendix.tex:526-590` time change and Gronwall ->
`main_body.tex:309-323` linear-slowdown collection.  The new middle obligation
`SALD.cycle15DiscreteForwardKlMiddleEmSpineObligation` records this routing and
keeps the first lower target as
`sald.discrete_forward_kl.em_conditional_fokker_planck`; endpoint law matching,
stitched regularity, one-step `Gamma`/`Delta` defects, DV, Gronwall, and the
accumulated-error bridge remain separate obligations.

Cycle 15 middle lower-slice refinement:
`SALD.cycle15DiscreteForwardKlEmConditionalFpLowerContract` narrows the first
lower target to `appendix.tex:347-385`.  The slice is only the conditional
frozen drift `bar b_{k,s}`, the law/density and conditional-expectation
interface for `hat X_s`, the Fokker--Planck equation
`partial_s hat rho_s = -div(hat rho_s*bar b_{k,s}) + Delta hat rho_s`, the
Laplacian split relative to `tilde pi_s`, and the handoff to the KL derivative
integration-by-parts block.  It explicitly excludes endpoint stitching,
frozen `Gamma`/`Delta` estimates, DV, Gronwall, and accumulated-error algebra.

Cycle 15 lower conditional-drift density refinement:
`SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract` isolates the
first sub-obligation inside `appendix.tex:347-385`: construct the regular
conditional-law, smooth density, measurability, and integrability interface
needed for
`bar b_{k,s}(x)=E[nabla log pi_{t_k}(X_k^eta) | hat X_s=x]`.  It stops before
the Fokker--Planck identity, Laplacian split, KL derivative integration by
parts, one-step `Gamma`/`Delta` estimates, DV, Gronwall, and accumulated-error
collection.  The named obligation is
`SALD.cycle15DiscreteForwardKlConditionalDriftDensityObligation`.

Cycle 7 upper refinement:
`SALD.discreteForwardKlCoefficientChainAuditContract` now records the scalar
bookkeeping behind this inequality and the final theorem display.  It preserves
the two `1/4*FI` cross-term contributions from `appendix.tex:454-479`, the
LSI conversion at `appendix.tex:481-493`, the DV coefficient
`dot t(s)^2*alpha^(-1)` at `appendix.tex:496-515`, the time-change rewrite
at `appendix.tex:534-553`, and the linear-slowdown collection of
`T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
`(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}` from the theorem
display.  The corresponding proof obligation is
`SALD.discreteForwardKlCoefficientChainObligation`; no analytic fact is marked
formalized.

Cycle 7 middle refinement:
`SALD.discreteForwardKlAccumulatedErrorBridgeContract` isolates the final bridge
from the appendix Gronwall display to the main-body theorem display.  The bridge
starts with `appendix.tex:557-590`, rewrites the endpoints
`K(T)=\KL(\rho_K^\eta\|\pi_T)` and `K(0)=\KL(\rho_0\|\pi_0)`, substitutes
`t(s)=s/r`, splits
`exp(-\int a)` into the contraction factor and positive error exponent, and
collects the three full-interval quantities
`\mathcal A_\alpha(\pi,v)`, `\bar\Gamma`, and
`\bar\Delta_{\alpha'}` exactly as in `main_body.tex:309-323`.
The corresponding obligation is
`SALD.discreteForwardKlAccumulatedErrorBridgeObligation`; the residual
exponent drop is now split further into
`SALD.discreteForwardKlResidualExponentBoundObligation`.  Both are endpoint
and real/integral algebra, not new assumptions on the theorem.

Cycle 7 lower refinement:
`SALD.discreteForwardKlCoefficientChainAuditContract` now carries a
`sourceLineLedger` for the coefficient flow from `appendix.tex:454-590` and a
`scalarSideConditions` list for the real/integral facts needed by the same
source constants.  These side conditions cover positivity of `alpha`,
`alpha'`, and `dot{s}`, integrability of `C_LSI`, `Gamma`, `Delta`, and
`E_alpha`, nonnegativity of `C_LSI` for the residual exponent drop, interval
monotonicity for the full-exponent bound, and endpoint continuity of the
stitched EM KL path.  The proof obligation
`SALD.discreteForwardKlCoefficientChainObligation` now depends directly on
`sald.discrete_forward_kl.stitched_interval_regularity`; no analytic side
condition is promoted to a theorem assumption or proof.

### `prop:guided_path_residual`

Source statement anchor: `appendix.tex:619`.

The proposition defines
`Z_t=int p_t(x)e^{-f_t(x)} dx`,
`\pi_t=Z_t^{-1}p_t e^{-f_t}`, and
`g_t=partial_t f_t+\nabla f_t^T u_t`, then proves

```text
partial_t pi_t + div(pi_t u_t)
  = -pi_t * (g_t - E_{pi_t}[g_t]).
```

Lean-facing contract: `SALD.guidedResidualContract`, with proof-shape data in
`SALD.guidedResidualIdentityContract`.  The normalizer derivative and residual
identity are obligations:
`SALD.guidedResidualNormalizerObligation` and
`SALD.guidedResidualIdentityObligation`.

Cycle 4 compiled interfaces:

| Source proof step | Lean-facing item | Dependency classification | Status |
|---|---|---|---|
| Differentiate `Z_t` and use `partial_t p_t=-div(p_t u_t)` (`appendix.tex:630-656`). | `SALD.guidedResidualIdentityContract.normalizerDerivative`; `SALD.guidedResidualNormalizerObligation` | local dominated-convergence and integration-by-parts obligations | obligation |
| Differentiate `pi_t=Z_t^{-1}p_t e^{-f_t}` and add `div(pi_t u_t)` (`appendix.tex:658-699`). | `SALD.guidedResidualIdentityContract.residualIdentity`; `SALD.guidedResidualIdentityObligation` | local product/quotient derivative plus divergence cancellation | obligation |
| Prove the centered residual has zero mean (`appendix.tex:704`). | `SALD.guidedResidualIdentityContract.meanZeroStatement`; `SALD.guidedResidualIdentityObligation` | normalization/integrability obligation | obligation |

### `thm:general-moving-target-SALD`

Source statement anchor: `appendix.tex:724`.
Source proof anchor: `appendix.tex:765-949`.

The theorem studies the general VA-SALD SDE

```text
dX_s =
  (dot{t}(s)c_{t(s)}(X_s)
    +(sigma_{t(s)}^2/2)*nabla log pi_{t(s)}(X_s)) ds
  + sigma_{t(s)} dW_s,
```

sets `m_t=v_t-c_t`, and bounds `KL(rho_S||pi_T)` by the
sigma-weighted contraction term plus the residual
`E_alpha(pi_t,m_t)` integral.

Lean-facing contract: `SALD.generalVaSaldContract`, with exact statement
shape in `SALD.generalMovingTargetStatementContract`.

Cycle 4 compiled interfaces:

| Source proof step | Lean-facing item | Dependency classification | Status |
|---|---|---|---|
| Differentiate `KL(rho_s||pi_{t(s)})`, insert the general Fokker--Planck equation, and evaluate the `c_t` drift (`appendix.tex:765-818`). | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation` | Fokker--Planck, density regularity, differentiation-under-integral, and integration-by-parts obligations | obligation |
| Use the transport velocity `v_t` for the target path and combine with `c_t` into `m_t=v_t-c_t` (`appendix.tex:819-850`). | `SALD.generalMovingTargetDerivativeCandidateContract.residualVelocity` | transport-continuity-equation obligation | obligation |
| Apply Young with `epsilon=2*dot{t}(s)/sigma_{t(s)}^2`, change to `t`, and use LSI (`appendix.tex:856-884`). | `SALD.generalMovingTargetDerivativeCandidateContract.timeChangedInequality` | inverse schedule, sigma positivity, and LSI/KL/FI obligations | obligation |
| Apply DV with `Z=alpha*||m_t||^2` (`appendix.tex:886-907`). | `SALD.generalMovingTargetDvEnergyCandidateContract`; `SALD.generalMovingTargetDvEnergyObligation` | source-cited DV plus finite log-mgf witness for `m_t` | obligation + source-cited |
| Apply Gronwall with sigma-weighted coefficients (`appendix.tex:908-934`). | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallApplicationObligation` | Gronwall and integrability obligations | obligation |
| Rewrite Gronwall endpoints, split exponents, drop the residual LSI contribution, and prove the zero-residual pure-contraction algebra (`appendix.tex:908-945`). | `SALD.generalMovingTargetGronwallSideConditionContract`; `SALD.generalMovingTargetGronwallSideConditionObligation` | endpoint, real/integral algebra, sign, and normalization obligations | obligation |
| Specialize `c_t=v_t` to get `m_t=0` and pure contraction (`appendix.tex:936-945`). | `SALD.generalMovingTargetPureContractionObligation` | alpha-complexity zero-residual algebra | obligation |

The continuous general differential inequality preserved in the contract is:

```text
dK/dt <= -((sigma_t^2/2)*dot{s}(t)*C_LSI(t)
  - sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1))*K(t)
  + sigma_t^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t).
```

### `thm:unified-forward-KL`

Source statement anchor: `main_body.tex:372`.
Source proof anchor: `appendix.tex:949-951`.

The main-body VA-SALD theorem is a specialization of
`thm:general-moving-target-SALD` with `c_t <- u_t` and residual field
`m_t=w_t`, where the guided residual proposition supplies the correction-field
interpretation.  The Lean-facing specialization obligation is
`SALD.unifiedForwardKlSpecializationObligation`; no alternate proof route is
introduced.

Cycle 8 lower compiled interface:
`SALD.unifiedForwardKlSpecializationContract` now expands the source bridge
behind the one-line appendix proof.  It records `eq:SALD_Ito`, the residual
display `eq:residual-term`, the correction equation `eq:poisson-eq`, the
choice `v_t=u_t+w_t`, the specialization `c_t=u_t`, and the identification
`m_t=w_t`.  Existence/regularity of `w_t`, the divergence-equation backend,
and the transport-velocity sum remain obligations.

### `thm:general-moving-target-SALD-discrete`

Source statement anchor: `appendix.tex:1313`.
Source setup anchors: `appendix.tex:953-1024` and
`appendix.tex:1026-1307`.
Source proof anchor: `appendix.tex:1354-1603`.

The theorem assumes the continuous general moving-target theorem hypotheses and
the general frozen-delta lemma hypotheses.  It works under constant
`\dot t(s)=\dot s(t)^{-1}`, uses the EM update
`eq:SALD_general_EM`, frozen interpolation
`eq:general_moving_target_SALD_frozen_interp`, and the general VA frozen-field
error `\delta_{\pi_t}^{VA}` from `eq:general_discrete_delta_def`.  The final
bound is exactly the Gronwall display `eq:general_moving_target_KL_bound_discrete`.

Lean-facing contracts:
`SALD.generalMovingTargetDiscreteStatementContract`,
`SALD.generalVaSaldEulerMaruyamaContract`,
`SALD.generalFrozenDeltaCrossLipContract`,
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract`,
`SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`,
`SALD.generalMovingTargetDiscreteGronwallInstantiationContract`,
`SALD.generalMovingTargetDiscreteGronwallSideConditionContract`, and
`SALD.generalVaSaldDiscreteProofDag`.

Cycle 4 middle compiled interfaces:

| Source proof step | Lean-facing item | Dependency classification | Status |
|---|---|---|---|
| Define the general EM update, frozen interpolation, `sigma_eta(t)`, `phi_t`, and `delta_pi^VA` (`appendix.tex:953-1024`). | `SALD.generalVaSaldEulerMaruyamaContract`; `SALD.generalMovingTargetDiscreteEmInterpolationObligation` | EM endpoint laws, conditional drift, and Fokker--Planck backend | contract + obligation |
| Prove `lem:frozen_delta_cross_lip` for the VA frozen-field error (`appendix.tex:1026-1307`). | `SALD.generalFrozenDeltaCrossLipContract`; `SALD.generalMovingTargetDiscreteFrozenDeltaObligation` | local one-step increment estimate plus DV source-cited bounds for `c_t`, score, and `1+M` | obligation + source-cited |
| Expose derivative side interfaces: endpoint laws, conditional drift, Fokker--Planck split, slowed transport velocity, frozen/residual algebra, two Young coefficients, DV finite-mgf witness, and stitched time change (`appendix.tex:1354-1600`). | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` | local EM/Fokker--Planck, transport, DV, and time-change interfaces | obligation |
| Differentiate `KL(hat rho_s||tilde pi_s)` and insert the interpolation Fokker--Planck equation (`appendix.tex:1354-1447`). | `SALD.generalMovingTargetDiscreteDerivativeCandidateContract`; `SALD.generalMovingTargetDiscreteDerivativeObligation` | local density/Fokker--Planck/integration-by-parts obligations | obligation |
| Decompose the cross term as `delta_pi^VA + dot{t}*m_t`, apply Young to both pieces, invoke the frozen-delta lemma, and use LSI (`appendix.tex:1449-1542`). | `SALD.generalMovingTargetDiscreteDerivativeCandidateContract.frozenResidualDecomposition`; `SALD.generalMovingTargetDiscreteFrozenDeltaObligation` | source internal step plus LSI obligation | obligation |
| Apply DV with `Z=alpha*||m_t||^2` and change from `s` to `t` (`appendix.tex:1544-1598`). | `SALD.generalMovingTargetDiscreteDvMEnergyObligation`; `SALD.generalMovingTargetDiscreteConstantScheduleObligation` | source-cited DV plus inverse-schedule/stitching obligation | obligation + source-cited |
| Apply `lem:gronwall` to get `eq:general_moving_target_KL_bound_discrete` (`appendix.tex:1600`, statement lines `1316-1347`). | `SALD.generalMovingTargetDiscreteGronwallInstantiationContract`; `SALD.generalMovingTargetDiscreteGronwallApplicationObligation` | Gronwall and stitched-interval regularity obligations | obligation |
| Check endpoint stitching, constant-schedule coefficient rewrites, coefficient regularity, and exact theorem-display matching for the final Gronwall output (`appendix.tex:1573-1600`, statement lines `1316-1347`). | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` | local endpoint, schedule, real/integral, and coefficient-bookkeeping obligations | obligation |
| Specialize the general discrete theorem to guided discrete VA-SALD by replacing `c` with `u` (`appendix.tex:1603`). | `SALD.discreteUnifiedVaSaldSpecializationObligation` | specialization only, no new proof route | obligation |

The discrete general differential inequality preserved in the contract is:

```text
dK/dt <= -((sigma_eta(t)^2/2)*dot{s}(t)*C_LSI(t)
  - 2*sigma_eta(t)^(-2)*dot{s}(t)^(-1)*alpha^(-1)
  - 2*dot{s}(t)*eta^2*alpha'^(-1)*Gamma(t))*K(t)
  + 2*sigma_eta(t)^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)
  + 2*dot{s}(t)*eta*Delta(t).
```

Lower cycle 4 refinement:
`SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` now separates
the side interfaces used by `appendix.tex:1354-1600` from the derivative
inequality itself.  It preserves the source's two `sigma_eta^2/8` Young
contributions, the resulting `2*sigma_eta^{-2}` residual coefficient, the
`2*Gamma*eta^2*alpha'^{-1}` frozen-delta coefficient, and the `2*Delta*eta`
additive term before the final `t`-time Gronwall step.  These remain
obligations via
`SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation`.

Cycle 8 middle refinement:
`SALD.generalMovingTargetDiscreteGronwallSideConditionContract` now isolates
the final side conditions for `thm:general-moving-target-SALD-discrete` after
the derivative inequality is in `t`-time.  It records the stitched EM endpoint
laws needed for `K(T)=KL(rho_K^eta||pi_T)` and
`K(0)=KL(rho_0||pi_0)`, the constant inverse-schedule rewrite from
`dot{t}(s)^2` to `dot{s}(t)^(-1)`, coefficient regularity for the source
`a(t)` and `b(t)`, and the exact matching of the Gronwall output to
`eq:general_moving_target_KL_bound_discrete`.  The corresponding obligation is
`SALD.generalMovingTargetDiscreteGronwallSideConditionObligation`; no theorem
hypothesis or source coefficient has been changed.

Cycle 8 lower refinement:
`SALD.unifiedForwardKlSpecializationContract` now records the source-to-general
bridge for `thm:unified-forward-KL` instead of leaving the appendix one-line
specialization implicit.

| Source item | Lean-facing target | Current blocker |
|---|---|---|
| `main_body.tex:359-363` guided residual identity | `residualEquation`; `SALD.guidedResidualIdentityObligation` | centered residual proof, normalizer derivative, and integration by parts |
| `main_body.tex:364-368` correction field `w_t` | `correctionEquation`; `correctionFieldTransportBridge`; `SALD.unifiedForwardKlTransportBridgeObligation`; `SALD.unifiedForwardKlSpecializationObligation` | existence/regularity of `w_t`, divergence-equation backend, and transport-velocity algebra |
| `main_body.tex:76-99` VA-SALD dynamics | `vaSaldDynamics`; `specialization` | equality with the general SDE under `c_t=u_t` and guided-score identity |
| `appendix.tex:949-951` specialization line | `sourceProof`; `terminalBoundMatch` | instantiate the general theorem with `v_t=u_t+w_t`, `c_t=u_t`, and `m_t=w_t` |

This remains obligation data.  The theorem statement, sigma-weighted bound,
and proof route through `thm:general-moving-target-SALD` are unchanged.

Cycle 16 upper refinement:
`SALD.cycle16GeneralVaSaldUpperPacket` returns to this source bridge and selects
`sald.unified_forward_kl.transport_velocity_bridge` as the only lower target.
The new `SALD.unifiedForwardKlTransportBridgeObligation` isolates the algebra
from `main_body.tex:359-368`: combine the centered residual identity
`partial_t pi_t+div(pi_t*u_t)=-pi_t(g_t-E_pi_t[g_t])` with
`\nabla\cdot(\pi_t w_t)=\pi_t(g_t-E_{\pi_t}[g_t])` to obtain
`partial_t pi_t+div(pi_t*(u_t+w_t))=0`, then record
`v_t=u_t+w_t`, `c_t=u_t`, and `m_t=w_t` for the general theorem
specialization.  This packet does not solve existence or regularity of `w_t`,
does not touch DV/Gronwall steps, and does not create a direct VA-SALD proof.

## Cycle 8 Upper Re-Audit

Objective: keep `thm:general-moving-target-SALD` fixed while isolating the
last continuous general VA-SALD Gronwall side conditions from the theorem
statement.  The refined proof block is `appendix.tex:908-945`, with the
theorem display at `appendix.tex:727-743` and the unified specialization at
`main_body.tex:372-395`.

Compiled refinement:
`SALD.generalMovingTargetGronwallSideConditionContract` and
`SALD.generalMovingTargetGronwallSideConditionObligation` record:

- endpoint rewrites `K(T)=KL(rho_S||pi_T)` and
  `K(0)=KL(rho_0||pi_0)`;
- regularity/admissibility of
  `a(t)=(sigma_t^2/2)*dot{s}(t)*C_LSI(t)
  -sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)` and
  `b(t)=sigma_t^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)`;
- the exponent split producing the theorem's two initial-error factors;
- the residual-exponent bound obtained by dropping the nonpositive LSI
  contribution;
- the pure-contraction zero-residual calculation under `c_t=v_t`.

Lower packet: target this side-condition contract or obligation only, and
refine one of endpoint rewrites, coefficient regularity, exponent/sign
bookkeeping, or `E_alpha(pi_t,0)=0`.  Do not change the theorem statement,
the sigma-weighted coefficients, or the specialization route
`c_t <- u_t`.

## Cycle 9 Upper Re-Audit

Objective: return to the first appendix/vocabulary layer and make the next
lower task choose one source-faithful interface among `lem:gronwall`,
`lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI`.

Compiled refinement: `SALD.cycle9FirstAppendixVocabularyPacket` records the
cycle objective, mode discipline, non-goals, lower packet, and reviewer
checklist.  `SALD.saldDependenciesForLabel` now exposes the first-layer
dependency interfaces:

- `lem:gronwall`: `SALD.saldGronwallCandidateContract`,
  `SALD.saldGronwallEndpointCalculusContract`,
  `sald.gronwall.integrating_factor`,
  `sald.gronwall.endpoint_calculus`, real interval-integral backend, and
  endpoint-safe differentiability;
- `lem:dv_variation`: `probability.dv_variational_formula`, finite log-mgf,
  KL vocabulary, and common probability-space interfaces;
- `def:PI`: `PIContract`, variance vocabulary, weighted Sobolev vocabulary,
  and the downstream `lem:velocity-norm-bound` dependency;
- `eq:LSI-KL-FI`: the existing KL/FI/LSI density-test obligations.

Lower packet: refine exactly one of those first-layer interfaces.  Do not
prove or restate a forward-KL theorem, replace the source inequality route, or
promote Gronwall, DV, or LSI-to-KL/FI beyond their current statuses.

### Cycle 9 Middle Audit

The appendix and main-body focus blocks were re-read at
`appendix.tex:47-151` and `main_body.tex:202-215`.  The middle refinement adds
two compiled ledgers without changing theorem statements:
`SALD.saldDvFiniteLogMgfContract` and
`SALD.saldPiVelocityNormDependencyContract`.

| Source block | Classification | Lean-facing target | Current blocker |
|---|---|---|---|
| `appendix.tex:47-71` Gronwall integrating-factor proof | local real-calculus lemma | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.gronwallAnalyticObligation`; `SALD.gronwallEndpointCalculusObligation` | endpoint-safe differentiability on `[0,t1]`, FTC/order-integration backend, endpoint evaluation, and exponent algebra |
| `appendix.tex:73-79` DV variational formula | external cited result plus local instantiation interface | `SALD.saldDvFiniteLogMgfContract`; `SALD.dvFiniteLogMgfInterfaceObligation`; `dvVariationalObligation saldDvVariationSource` | common measurable probability space and finite log-mgf witness for each squared-velocity test |
| `appendix.tex:86-94` PI definition | definition contract | `SALD.saldPIContract`; `SALD.piDefinitionContract` | no proof obligation for the definition itself |
| `appendix.tex:96-151` PI to velocity-norm bound | local Sobolev/Riesz backend | `SALD.saldPiVelocityNormDependencyContract`; `SALD.piVelocityNormBackendObligation` | weighted mean-zero Sobolev Hilbert structure, bounded functional, weak PDE, boundary/regularity interface |
| `main_body.tex:202-215` LSI/KL/FI vocabulary and comparison | local density-test obligation | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation` | admissibility of `sqrt(rho/pi)`, entropy identity, FI chain rule, coefficient `1/(2*C_LSI)` |

Middle lower packet:

- Target exactly one declaration:
  `SALD.saldDvFiniteLogMgfContract`,
  `SALD.saldPiVelocityNormDependencyContract`,
  `SALD.saldGronwallEndpointCalculusContract`, or an existing first-layer
  Gronwall/LSI density-test contract.
- For DV, prove nothing about the cited variational formula; refine only the
  common-space, measurability, and finite-log-mgf witness needed by
  `Z=alpha*||v_t||^2` or `Z=alpha*||m_t||^2`.
- For PI, keep `def:PI` contract-only and refine the downstream
  `lem:velocity-norm-bound` backend: mean-zero Sobolev space, norm
  equivalence, Riesz representation, and the bound
  `||v||_{L2(mu)} <= C_PI^{-1/2}||g||_{L2(mu)}`.
- Do not add these regularity interfaces as hidden hypotheses to any
  forward-KL or VA-SALD theorem statement.

## Cycle 10 Upper Re-Audit

Objective: keep `thm:forward-KL` fixed while tightening the theorem-level
dependency ledger from the post-Young derivative inequality through LSI,
inverse-schedule time change, DV, Gronwall, and the terminal theorem display.
The compiled workflow packet is `SALD.cycle10ForwardKlUpperPacket`.

Source focus:

- statement `main_body.tex:238-247`;
- proof block `appendix.tex:164-252`;
- coefficient chain `appendix.tex:210-252`;
- theorem display `main_body.tex:243-246`.

Compiled refinement: `SALD.forwardKlDependencyChainAuditContract` now includes
`sourceLineLedger`, `scalarSideConditions`, and
`sourceDependencyClassification` for the continuous forward-KL coefficient
chain.

| Source step | Lean-facing ledger entry | Classification | Status |
|---|---|---|---|
| `appendix.tex:210-217` post-Young inequality and LSI conversion | `sourceLineLedger`; `scalarSideConditions` for LSI coefficient use | local density-test obligation via `eq:LSI-KL-FI` | obligation |
| `appendix.tex:218-228` inverse-schedule time change | `sourceLineLedger`; `scalarSideConditions` for `dot{s}>0` and inverse derivative identities | local schedule-calculus/source-contract gap | obligation |
| `appendix.tex:230-241` DV with `Z=alpha*||v_t||^2` | `sourceLineLedger`; finite-log-mgf side condition | external-cited DV plus local finite-log-mgf interface | source-cited + obligation |
| `appendix.tex:244-252` Gronwall and exponent split | `sourceLineLedger`; scalar side conditions for `K`, `a`, `b`, endpoints, and residual exponent drop | local real/integral algebra and Gronwall obligation | obligation |

Mode discipline:

- `faithfulPaper`; use only the original `main_body.tex` and `appendix.tex`,
  keeping `sald_version_2.tex` out of source correspondence;
- preserve the theorem statement, the two initial-error exponent factors, the
  residual alpha-complexity integral, and the coefficient
  `(1/2)*dot{s}(t)^(-1)*alpha^(-1)`;
- keep KL derivative/Fokker--Planck, LSI-to-KL/FI, DV, inverse-schedule
  calculus, Gronwall, and endpoint/exponent algebra as obligations or
  source-cited facts until compiled Lean proofs replace them.

Lower packet:

- target exactly one interface:
  `SALD.forwardKlDependencyChainAuditContract`,
  `SALD.forwardKlGronwallSideConditionContract`, or
  `SALD.forwardKlCoefficientChainObligation`;
- refine one slice only: LSI coefficient bookkeeping, inverse-schedule scalar
  rewrite, DV finite-log-mgf witness, Gronwall coefficient regularity, or
  endpoint/exponent algebra;
- do not modify `thm:forward-KL` or
  `SALD.continuousForwardKlStatementContract`.

Non-goals:

- do not prove or restate the continuous forward-KL theorem;
- do not replace derivative -> LSI -> DV -> Gronwall with another route;
- do not add regularity, endpoint, positivity, finite-log-mgf, or integrability
  assumptions silently to the theorem statement;
- do not mark any analytic dependency as formalized.

Reviewer checklist:

- `SALD.forwardKlDependencyChainAuditContract` exposes source-line,
  scalar-side-condition, and dependency-classification entries for
  `appendix.tex:210-252`;
- `SALD.forwardKlProofDag` still includes
  `ASTIS.SALD.forward_KL.moving_target_dependencies`,
  `ASTIS.SALD.forward_KL.coefficient_chain_audit`, derivative, DV-energy, and
  Gronwall blocks;
- `SALD.continuousSaldContract` still lists all forward-KL obligations and
  remains `contractOnly`;
- source index contains `thm:forward-KL`, `eq:LSI-KL-FI`,
  `lem:dv_variation`, and `lem:gronwall`, and excludes
  `sald_version_2.tex`;
- fake-proof scan remains clean.

## Cycle 10 Middle DV Witness

Objective: refine the DV slice selected by the upper packet without changing
`thm:forward-KL`.  The source step is `appendix.tex:230-241`, where the proof
uses `lem:dv_variation` with `Z=\alpha\|v_t\|^2` and then inserts the resulting
velocity-energy bound into the scalar Gronwall inequality.

Compiled refinement:
`SALD.forwardKlDvFiniteLogMgfWitnessContract` records the theorem-specific
side conditions:

- common-space and absolute-continuity interface for
  `rho_{s(t)}` and `pi_t`;
- measurability of the squared-velocity test function;
- finite-log-mgf monotonicity from the source assumption
  `\mathfrak E_{\alpha_0}(\pi_t,v_t)<+\infty` to every
  `0<\alpha\le\alpha_0`;
- positive-alpha scaling of the DV inequality;
- preservation of the later coefficient
  `(1/2)*dot{s}(t)^(-1)*alpha^(-1)`.

The new proof obligation is
`SALD.forwardKlDvFiniteLogMgfWitnessObligation`.  It is listed by
`SALD.continuousSaldContract`, and `SALD.forwardKlProofDag` now places
`ASTIS.SALD.forward_KL.dv_finite_log_mgf_witness` before the existing
DV-energy block.  `lem:dv_variation` remains source-cited; no SLT result is
imported or marked formalized.

## Cycle 10 Lower DV Monotonicity

Objective: refine exactly one backend from the middle packet: the
alpha0-to-alpha finite-log-mgf bridge needed before the continuous
`thm:forward-KL` proof applies `lem:dv_variation` at
`appendix.tex:230-241`.

Compiled refinement:
`SALD.forwardKlDvAlphaMonotonicityContract` records the paper's implicit
monotonicity route:

- start from the theorem assumption
  `\mathfrak E_{\alpha_0}(\pi_t,v_t)<+\infty` in
  `main_body.tex:240-241`;
- keep the theorem range `0<\alpha\le\alpha_0`;
- use nonnegativity of `q_t(x)=\|v_t(x)\|^2` and monotonicity of `exp` to
  compare `exp(\alpha q_t)` with `exp(\alpha_0 q_t)`;
- transfer the domination through `\pi_t` expectation to obtain finite
  log-mgf for the DV test;
- rewrite `\alpha^{-1}\log\E_{\pi_t}\exp(\alpha q_t)` as
  `\mathfrak E_\alpha(\pi_t,v_t)` without changing the later coefficient
  `(1/2)*dot{s}(t)^(-1)*alpha^(-1)`.

The named proof obligation is
`SALD.forwardKlDvAlphaMonotonicityObligation`.  It is added to
`SALD.continuousSaldContract`, to the dependencies of
`SALD.forwardKlDvEnergyCandidateContract`, and to `SALD.forwardKlProofDag` as
`ASTIS.SALD.forward_KL.dv_alpha_mgf_monotonicity`.  No new theorem hypothesis
or formalized analytic result is claimed.

## Cycle 12 Upper Residual DV Packet

Objective: keep `prop:guided_path_residual`,
`thm:general-moving-target-SALD`, `thm:unified-forward-KL`, and
`thm:general-moving-target-SALD-discrete` fixed while isolating the residual
DV finite-log-mgf witness for `m_t`.

Compiled refinement:

- `SALD.cycle12GeneralVaSaldUpperPacket` records the faithful upper packet;
- `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract` and
  `SALD.generalMovingTargetDvFiniteLogMgfWitnessObligation` split the
  continuous source step at `appendix.tex:885-895`;
- `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract` and
  `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessObligation` split the
  discrete reuse at `appendix.tex:1544-1552`;
- `SALD.generalVaSaldProofDag` and `SALD.generalVaSaldDiscreteProofDag` now
  place residual DV witness blocks before the residual DV-energy blocks.

Source-to-Lean map:

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `appendix.tex:724-727` finite `E_{alpha0}(pi_t,m_t)` and `0<alpha<=alpha0` | `finiteAlpha0Assumption`; `alphaMonotonicityBridge` in `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract` | alpha0-to-alpha exponential-moment monotonicity for `m_t` |
| `appendix.tex:885-895` DV with `nu=rho_{s(t)}`, `mu=pi_t`, `Z=alpha*||m_t||^2` | `SALD.generalMovingTargetDvFiniteLogMgfWitnessObligation` | common-space, absolute-continuity, measurability, positive-alpha scaling |
| `main_body.tex:372-390`, `appendix.tex:949-951` specialization `c_t<-u_t`, so `m_t=w_t` | `SALD.unifiedForwardKlSpecializationContract`; `SALD.unifiedForwardKlSpecializationObligation` | correction-field transport bridge remains separate |
| `appendix.tex:1544-1552` discrete DV under `nu=hat rho_s`, `mu=tilde pi_s` | `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessObligation` | EM interpolation common-space and doubled residual coefficient preservation |

Mode discipline: do not alter the general, unified, or discrete theorem
statements; keep `lem:dv_variation` source-cited; record finite-log-mgf,
absolute-continuity, measurability, and EM interpolation requirements as
obligations rather than theorem hypotheses.

## Cycle 12 Middle Guided/General Map

Objective: synchronize the guided residual proposition, continuous general
VA-SALD theorem, unified specialization, and discrete general theorem into one
lower-ready map.  The compiled Lean-facing contract is
`SALD.cycle12GeneralVaSaldMiddleContract`; the named proof obligation is
`SALD.generalVaSaldGuidedPathMiddleObligation`.

Source-to-Lean map:

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `appendix.tex:619-704` residual identity for the guided path | `SALD.guidedResidualIdentityContract`; `SALD.guidedResidualNormalizerObligation`; `SALD.guidedResidualIdentityObligation` | differentiating under the integral, positive finite `Z_t`, integration by parts, and mean-zero centering |
| `main_body.tex:359-368` correction-field equation and transport statement | `SALD.unifiedForwardKlSpecializationContract`; `SALD.unifiedForwardKlSpecializationObligation` | existence/regularity of `w_t` and the divergence-equation transport bridge |
| `appendix.tex:765-884` continuous general derivative block | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation` | Fokker--Planck backend, boundary regularity, inverse-schedule calculus, sigma positivity, and LSI bridge |
| `appendix.tex:885-934` residual DV and Gronwall | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvEnergyCandidateContract`; `SALD.generalMovingTargetGronwallInstantiationContract` | source-cited DV, finite-log-mgf witness, and real Gronwall side conditions |
| `appendix.tex:936-951` pure contraction and unified specialization | `SALD.generalMovingTargetPureContractionObligation`; `SALD.unifiedForwardKlSpecializationObligation` | zero-residual alpha-complexity and the faithful `c_t<-u_t`, `m_t=w_t` specialization |
| `appendix.tex:1354-1600` discrete general derivative, residual DV, time change, and Gronwall | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract` | EM common-space, stitched endpoint laws, doubled residual coefficient, and Gamma/Delta coefficient preservation |
| `appendix.tex:1603` discrete guided specialization | `SALD.discreteUnifiedVaSaldSpecializationObligation` | specialization only; no direct discrete guided proof route is supplied |

Lower packet: target exactly one existing backend from this map.  Preferred
next targets are either the unified transport bridge
`SALD.unifiedForwardKlSpecializationObligation` or the discrete side-condition
ledger `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation`.
Do not add correction-field existence, density regularity, finite-log-mgf,
endpoint, or schedule assumptions silently to the source theorem statements.

## Cycle 12 Lower Residual DV Scaling

Objective: refine one continuous residual DV backend selected by the upper
packet: the positive-alpha division and `\mathfrak E_\alpha` rewrite in
`appendix.tex:887-907`.

Compiled refinement:
`SALD.generalMovingTargetDvPositiveAlphaScalingContract` and
`SALD.generalMovingTargetDvPositiveAlphaScalingObligation` isolate the source
step after `lem:dv_variation` is instantiated with
`Z=\alpha\|m_t\|^2`:

- use the theorem range `0<\alpha\le\alpha_0` only to divide by `\alpha>0`;
- rewrite
  `\alpha^{-1}\log E_{\pi_t}\exp(\alpha\|m_t\|^2)` as
  `\mathfrak E_\alpha(\pi_t,m_t)`;
- preserve the downstream coefficient
  `\sigma_t^{-2}\dot{s}(t)^{-1}\alpha^{-1}` on `K(t)` in
  `appendix.tex:899-907`;
- carry the same rewrite through the unified specialization `m_t=w_t` without
  adding a direct VA-SALD proof route.

The obligation remains local scalar/order algebra plus the alpha-complexity
definition.  It does not prove `lem:dv_variation`, does not prove finite
log-mgf monotonicity, and does not add hypotheses to
`thm:general-moving-target-SALD` or `thm:unified-forward-KL`.

## Cycle 13 Upper Source-Index Audit

Objective: return to the first appendix/vocabulary layer and use the source
index as the controlling checklist for `lem:gronwall`,
`lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI`.

Compiled refinement:

- `SALD.cycle13FirstAppendixVocabularyPacket` records the upper objective,
  mode discipline, non-goals, lower packet, and reviewer checklist;
- `SALD.cycle13FirstAppendixSourceIndexAuditContract` records the index file
  `research-wiki/source-index/SALD_original.jsonl`, the excluded
  `sald_version_2.tex`, and the Lean contract/obligation map for the four
  focus labels;
- `SALD.cycle13FirstAppendixMiddleAuditContract` records the middle
  source-to-Lean map that classifies each proof step as an existing Lean
  contract, cited result, or named obligation;
- `SALD.saldGronwallExponentRewriteContract` and
  `SALD.gronwallExponentRewriteObligation` isolate the
  `appendix.tex:63-69` rewrite
  `exp(-int_0^t1 a)*exp(int_0^t a)=exp(-int_t^t1 a)` as a lower
  Gronwall sub-obligation;
- `SALD.firstAppendixSourceIndexAuditObligation` tracks this as a
  synchronization obligation, not a mathematical proof;
- `SALD.firstAppendixMiddleAuditObligation` tracks the lower-ready first-layer
  packet without changing any theorem target;
- `SALD.saldDependenciesForLabel` now exposes the cycle-13 audit contract and
  middle map for the four focus labels in `SALD.saldFirstProofDag`.

Source-index map:

| Source label | Indexed source | Lean-facing map | Status |
|---|---|---|---|
| `lem:gronwall` | `appendix.tex:47` | `SALD.gronwallContract`; `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.saldGronwallExponentRewriteContract`; `SALD.gronwallAnalyticObligation`; `SALD.gronwallEndpointCalculusObligation`; `SALD.gronwallExponentRewriteObligation` | obligation |
| `lem:dv_variation` | `appendix.tex:73` | `SALD.dvContract`; `SALD.saldDvFiniteLogMgfContract`; `dvVariationalObligation`; `SALD.dvFiniteLogMgfInterfaceObligation` | source-cited + obligation |
| `def:PI` | `appendix.tex:86` | `SALD.piDefinitionContract`; `SALD.saldPIContract`; `SALD.saldPiVelocityNormDependencyContract`; `SALD.piVelocityNormBackendObligation` | contract-only + obligation |
| `eq:LSI-KL-FI` | `main_body.tex:202` | `SALD.lsiKlFiVocabularyContract`; `SALD.saldKLContract`; `SALD.saldFIContract`; `SALD.saldLSIContract`; `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation` | obligation |

Lower packet: target exactly one of the four first-layer interfaces, start
from the source-index line, preserve its `SourceAnchor`, and refine only the
existing contract or named proof obligation if the analytic backend is not
ready.  Do not change any later SALD theorem statement.

## Cycle 13 Middle Source-To-Lean Map

Objective: read the first appendix/vocabulary source windows and turn the
upper source-index packet into lower-ready proof-obligation interfaces.  The
compiled middle record is `SALD.cycle13FirstAppendixMiddleAuditContract`; the
named workflow obligation is `SALD.firstAppendixMiddleAuditObligation`.

| Source step | Lean-facing interface | Classification |
|---|---|---|
| `appendix.tex:47-71` proves Gronwall by differentiating the integrating factor, integrating over `[0,t1]`, evaluating endpoints, and rewriting the exponential factor at lines 63-69. | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.saldGronwallExponentRewriteContract`; `sald.gronwall.integrating_factor`; `sald.gronwall.endpoint_calculus`; `sald.gronwall.exponent_rewrite` | local real-calculus obligation |
| `appendix.tex:73-79` states the DV variational formula over finite-log-mgf tests. | `SALD.dvContract`; `SALD.saldDvFiniteLogMgfContract`; `probability.dv_variational_formula`; `sald.dv_variation.finite_log_mgf_interface` | source-cited DV plus local instantiation obligation |
| `appendix.tex:86-151` defines PI and uses it for the weighted Sobolev/Riesz velocity-norm proof. | `SALD.saldPIContract`; `SALD.piDefinitionContract`; `SALD.saldPiVelocityNormDependencyContract`; `sald.pi.velocity_norm_backend` | PI contract-only plus analytic backend obligation |
| `main_body.tex:202-215` derives `KL <= FI/(2*C_LSI)` from LSI with `phi=sqrt(rho/pi)`. | `SALD.saldLsiKlFiBridgeContract`; `SALD.saldLsiKlFiDensityTestContract`; `sald.lsi_kl_fi.density_test_interface`; `probability.lsi_to_kl_fi` | density-test and FI chain-rule obligation |

Middle lower packet:

- Preferred target: `SALD.saldGronwallEndpointCalculusContract`, with the
  lower sub-target `SALD.saldGronwallExponentRewriteContract` and
  `sald.gronwall.exponent_rewrite`, because the source proof is
  self-contained real calculus.
- Alternative targets: `SALD.saldDvFiniteLogMgfContract`,
  `SALD.saldPiVelocityNormDependencyContract`, or
  `SALD.saldLsiKlFiDensityTestContract`.
- Refine one interface only; if the backend is not ready, add a narrower
  `ProofObligation` rather than changing any theorem statement.
- Keep `sald_version_2.tex` excluded and keep all four source anchors matched
  to `SALD_original.jsonl`.

## Cycle 14 Upper Moving-Target Re-Audit

Objective: keep `thm:forward-KL` fixed and choose the theorem-level
moving-target side conditions as the next lower target.  The compiled workflow
packet is `SALD.cycle14ForwardKlUpperPacket`.

Source focus:

- statement `main_body.tex:238-247`;
- proof route `appendix.tex:164-252`;
- derivative/time-change block `appendix.tex:168-228`;
- DV-energy block `appendix.tex:230-241`;
- Gronwall endpoint/exponent block `appendix.tex:244-252`.

Faithful route:

| Source step | Lean-facing interface | Current status |
|---|---|---|
| SALD law `rho_s` and slowed target `tilde_pi_s=pi_{t(s)}` | `SALD.forwardKlMovingTargetDependencyContract`; `SALD.forwardKlDerivativeSideConditionContract` | obligation/source-gap |
| transport velocity `v_t` and slowed velocity `tilde v_s=dot t(s) v_{t(s)}` | `TransportVelocityContract`; `sald.forward_kl.moving_target_dependency_chain` | obligation |
| LSI conversion of the FI term | `eq:LSI-KL-FI`; `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| DV with `Z=alpha*||v_t||^2` | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `SALD.forwardKlDvAlphaMonotonicityContract` | source-cited DV plus local obligations |
| Gronwall with source `a(t)` and `b(t)` | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract` | obligation |

Lower packet:

- target exactly one of `SALD.forwardKlMovingTargetDependencyContract`,
  `SALD.forwardKlEndpointScheduleContract`,
  `SALD.forwardKlGronwallSideConditionContract`,
  `SALD.forwardKlDerivativeSideConditionContract`, or the named obligations
  `sald.forward_kl.endpoint_schedule_identities`,
  `sald.forward_kl.moving_target_dependency_chain` and
  `sald.forward_kl.gronwall_side_conditions`;
- preferred slice: isolate endpoint schedule identities `s(0)=0`,
  `S=s(T)`, `t(s(T))=T`, and `tilde_pi_{s(t)}=pi_t` in
  `SALD.forwardKlEndpointScheduleContract` without adding theorem hypotheses;
- alternative slices: slowed-target transport velocity, density/boundary
  side conditions, DV finite-log-mgf/common-space witness, or regularity of
  `a(t)` and `b(t)`;
- keep the differential inequality from `appendix.tex:239-241` and the
  terminal display in `main_body.tex:243-246` unchanged.

Reviewer checklist:

- `SALD.continuousSaldContract` still lists the middle source-to-Lean,
  moving-target, derivative, DV witness, coefficient-chain,
  Gronwall-side-condition, and Gronwall obligations;
- `SALD.forwardKlProofDag` routes through
  `ASTIS.SALD.forward_KL.moving_target_dependencies` before derivative and
  Gronwall proof search;
- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle14ForwardKlUpperPacket`, `SALD.cycle14ForwardKlMiddleContract`,
  and `sald.forward_kl.middle_source_to_lean_map`;
- `SALD_original.jsonl` contains the forward-KL, LSI/KL/FI, DV, and Gronwall
  source labels while excluding `sald_version_2.tex`;
- no analytic dependency is promoted to formalized status.

## Cycle 14 Middle Source-To-Lean Map

Objective: convert the cycle 14 upper packet into a lower-ready source-to-Lean
map for `thm:forward-KL`.  The compiled workflow contract is
`SALD.cycle14ForwardKlMiddleContract`; the named obligation is
`SALD.forwardKlMiddleSourceToLeanMapObligation`.

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `main_body.tex:238-247` states the inverse slowdown setup, LSI constants, finite `alpha0` alpha-complexity assumption, alpha range, and terminal KL display. | `SALD.continuousForwardKlStatementContract`; `SALD.continuousSaldContract`; `SALD.forwardKlMovingTargetDependencyContract`; `SALD.forwardKlEndpointScheduleContract` | endpoint schedule identities and theorem-level moving-target interfaces remain obligations |
| `appendix.tex:168-185` differentiates `KL(rho_s||tilde_pi_s)` and uses the SALD Fokker--Planck equation to identify the first term as `-FI`. | `SALD.forwardKlDerivativeSideConditionContract`; `sald.forward_kl.density_boundary_regular`; `sald.forward_kl.kl_derivative` | density regularity, mass conservation, differentiation-under-integral, and boundary/integration-by-parts backend |
| `appendix.tex:187-208` proves `tilde_v_s=dot t(s) v_{t(s)}` transports the slowed target and bounds the second derivative term by Cauchy/Young. | `TransportVelocityContract`; `SALD.forwardKlMovingTargetDependencyContract`; `sald.forward_kl.schedule_time_change` | transport-velocity backend and inverse-schedule calculus |
| `appendix.tex:210-228` applies `eq:LSI-KL-FI` and changes from `s` to `t`. | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi`; `SALD.forwardKlDependencyChainAuditContract` | LSI density-test proof and scalar coefficient bookkeeping |
| `appendix.tex:230-241` applies `lem:dv_variation` with `Z=alpha*||v_t||^2`. | `SALD.forwardKlDvAlphaMonotonicityContract`; `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `SALD.forwardKlDvEnergyCandidateContract` | source-cited DV plus finite-log-mgf/common-space and positive-alpha scaling obligations |
| `appendix.tex:244-252` applies `lem:gronwall` and rewrites the terminal display. | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract`; `sald.forward_kl.gronwall_side_conditions` | Gronwall coefficient regularity, endpoint identification, exponent split, and residual-exponent sign facts |

Middle lower packet:

- Preferred lower target: refine `SALD.forwardKlEndpointScheduleContract` and
  `sald.forward_kl.endpoint_schedule_identities` for `s(0)=0`, `S=s(T)`,
  `t(s(T))=T`, and `tilde_pi_{s(t)}=pi_t`.
- If blocked, refine exactly one alternative interface: slowed-target
  transport, density/boundary side conditions, DV finite-log-mgf/common-space
  witness, or Gronwall coefficient regularity.
- Keep the source route derivative -> LSI -> DV -> Gronwall and preserve the
  differential inequality at `appendix.tex:239-241` and theorem display at
  `main_body.tex:243-246`.
- Do not add endpoint, smoothness, absolute-continuity, finite-mgf, or
  integrability assumptions silently to `thm:forward-KL`.

## Cycle 14 Lower Endpoint-Schedule Refinement

Lower refinement: `SALD.forwardKlEndpointScheduleContract` and
`SALD.forwardKlEndpointScheduleObligation` now isolate the endpoint schedule
slice selected by the cycle 14 middle packet.

| Endpoint slice | Source route | Lean-facing target | Current blocker |
|---|---|---|---|
| slowdown and inverse schedule | `main_body.tex:9-13`, `main_body.tex:238` | `SALD.forwardKlEndpointScheduleContract.slowdownInterface` | closed-interval inverse endpoint lemma |
| slowed-target equality | `appendix.tex:218-228`, using `tilde_pi_s=pi_{t(s)}` | `SALD.forwardKlEndpointScheduleContract.slowedTargetIdentity` | prove `t(s(t))=t` on `[0,T]` |
| terminal endpoint | Gronwall endpoint in `appendix.tex:244-252`, theorem display `main_body.tex:243` | `SALD.forwardKlEndpointScheduleContract.terminalRewrite` | identify `K(T)=KL(rho_S||pi_T)` through `S=s(T)` |
| initial endpoint | Gronwall endpoint in `appendix.tex:244-252`, theorem display `main_body.tex:245` | `SALD.forwardKlEndpointScheduleContract.initialRewrite` | identify `K(0)=KL(rho_0||pi_0)` through `s(0)=0` |

This is bookkeeping only: it does not change `thm:forward-KL`, the
differential inequality, the DV step, or the Gronwall coefficients.

## Cycle 16 Middle Transport Bridge Map

Objective: convert the cycle-16 upper target into a lower-ready line ledger for
`thm:unified-forward-KL` without changing the theorem statement.  The compiled
Lean-facing record is
`SALD.cycle16UnifiedForwardKlTransportBridgeMiddleContract`; the named workflow
obligation is `SALD.cycle16UnifiedForwardKlTransportBridgeMiddleObligation`.

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `main_body.tex:359-363` states `partial_t pi_t+div(pi_t*u_t)=-pi_t(g_t-E_pi_t[g_t])` by `prop:guided_path_residual`. | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.identity` | normalizer derivative, differentiation under the integral, centering, and boundary handling |
| `main_body.tex:364-367` introduces `w_t` through `div(pi_t*w_t)=pi_t(g_t-E_pi_t[g_t])`. | `SALD.unifiedForwardKlSpecializationContract`; `eq:poisson-eq` | correction-field existence, regularity, and weak/divergence interpretation |
| `main_body.tex:368` cancels the two source displays and states that `u_t+w_t` transports `pi_t`. | `SALD.unifiedForwardKlTransportBridgeObligation`; `sald.unified_forward_kl.transport_velocity_bridge` | local continuity-equation algebra plus product/divergence backend |
| `appendix.tex:949-951` proves the theorem only by setting `c_t <- u_t` in `thm:general-moving-target-SALD`. | `SALD.unifiedForwardKlSpecializationObligation`; `sald.unified_forward_kl.specialization` | theorem-level specialization after the transport bridge |

Middle lower packet:

- Target exactly `sald.unified_forward_kl.transport_velocity_bridge`.
- Preserve the residual/correction signs so their sum gives
  `partial_t pi_t+div(pi_t*(u_t+w_t))=0`.
- After the bridge, record `v_t=u_t+w_t`, `c_t=u_t`, and `m_t=w_t`.
- Leave correction-field existence, divergence regularity, residual DV,
  Gronwall, and discrete EM as separate obligations.

Lower cycle 16 refinement:

`SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract` narrows the selected
target `sald.unified_forward_kl.transport_velocity_bridge` to the source
algebra in `main_body.tex:359-368`.

| Source step | Lean-facing interface | Status |
|---|---|---|
| residual display `partial_t pi_t+div(pi_t*u_t)=-pi_t(g_t-E_pi_t[g_t])` | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract.residualEquation` | obligation via `sald.guided_path_residual.identity` |
| correction equation `div(pi_t*w_t)=pi_t(g_t-E_pi_t[g_t])` | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract.correctionEquation` | obligation; correction-field existence/regularity not solved |
| signed cancellation of the two right-hand sides | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract.cancellationStep`; `sald.unified_forward_kl.transport_bridge_lower` | obligation |
| divergence-linearity rewrite to `div(pi_t*(u_t+w_t))` | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract.divergenceLinearity` | weak/product-divergence backend obligation |
| handoff to the appendix specialization | `v_t=u_t+w_t`, `c_t=u_t`, `m_t=w_t` in `SALD.unifiedForwardKlSpecializationObligation` | obligation |

## Proof DAG

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| `lem:gronwall` | Integrated differential inequality with paper's exponent signs and additive source term. | `SALD.cycle13FirstAppendixSourceIndexAuditContract`, `SALD.cycle13FirstAppendixMiddleAuditContract`, `sald.first_appendix.source_index_audit`, `sald.first_appendix.middle_source_to_lean_map`, real differentiability/integral API, interval integrability, endpoint-safe closed-interval derivative interface, order integration, the isolated exponent rewrite, scalar helpers `SALD.gronwallNegIntegralRewriteScalar` / `SALD.gronwallExpProductRewriteScalar`, adjacent-interval bridge `SALD.gronwallExpProductRewriteIntervalIntegral`, and outer-integral congruence `SALD.gronwallExpProductRewriteIntegralCongr`. | `SALD.gronwallContract`; `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.saldGronwallExponentRewriteContract`; `SALD.gronwallEndpointCalculusObligation`; `SALD.gronwallExponentRewriteObligation` | `appendix.tex:47` | `thm:forward-KL`, `thm:forward-KL-discrete`, `thm:general-moving-target-SALD`, `thm:general-moving-target-SALD-discrete` | obligation |
| `lem:gronwall exponent rewrite` | Final source rewrite `exp(-int_0^t1 a)*exp(int_0^t a)=exp(-int_t^t1 a)` inside the additive integral. | `SALD.saldGronwallEndpointCalculusContract`, compiled adjacent interval-integral bridge `SALD.gronwallIntervalIntegralAdditivityScalar`, compiled scalar helpers `SALD.gronwallNegIntegralRewriteScalar` and `SALD.gronwallExpProductRewriteScalar`, compiled pointwise bridge `SALD.gronwallExpProductRewriteIntervalIntegral`, compiled outer-integral congruence `SALD.gronwallExpProductRewriteIntegralCongr`, and remaining theorem-specific adjacent interval-integrability. | `SALD.saldGronwallExponentRewriteContract`; `SALD.gronwallExponentRewriteObligation` | `appendix.tex:63` | All later Gronwall exponent-splitting audits. | obligation with local bridge sublemmas formalized |
| `lem:dv_variation` | Donsker--Varadhan formula under finite log-mgf. | `SALD.cycle13FirstAppendixSourceIndexAuditContract`, `SALD.cycle13FirstAppendixMiddleAuditContract`, `sald.first_appendix.source_index_audit`, `sald.first_appendix.middle_source_to_lean_map`, cited Boucheron Cor. 4.15, common probability-space interface, finite log-mgf witness, cycle 32 scalar post-DV bridges, cycle 37 one-sided tilted backend and lower consequence, and future Mathlib/SLT port for the supremum equality. | `SALD.dvContract`; `SALD.saldDvFiniteLogMgfContract`; `dvVariationalObligation`; `SALD.dvFiniteLogMgfInterfaceObligation`; `SALD.cycle37DvVariationUpperPacket`; `SALD.cycle37DvVariationUpperObligation`; `SALD.cycle37DvVariationMiddleAuditContract`; `SALD.cycle37DvVariationMiddleObligation`; `SALD.cycle37DvVariationLowerObligation`; `AutoSamplingTheory.dvVariationalOneSidedOfTiltedRight`; `AutoSamplingTheory.dvVariationalTiltedRightOneSidedConsequence` | `appendix.tex:73` | Same KL bounds as Gronwall. | source-cited equality; one-sided backend and consequence formalized under explicit hypotheses |
| `def:PI` | Poincare inequality vocabulary used for velocity norm estimates. | `SALD.cycle13FirstAppendixSourceIndexAuditContract`, `SALD.cycle13FirstAppendixMiddleAuditContract`, `sald.first_appendix.source_index_audit`, `sald.first_appendix.middle_source_to_lean_map`, variance, weighted Sobolev, gradient norm, and mean-zero interfaces. | `SALD.saldPIContract`; `SALD.piDefinitionContract`; `SALD.saldPiVelocityNormDependencyContract`; `SALD.piVelocityNormBackendObligation` | `appendix.tex:86`; `lem:velocity-norm-bound` at `appendix.tex:114` | `lem:velocity-norm-bound` | PI contract-only; velocity backend obligation |
| `eq:LSI-KL-FI` | LSI definition, KL/FI definitions, and LSI-to-KL/FI comparison. | `SALD.cycle13FirstAppendixSourceIndexAuditContract`, `SALD.cycle13FirstAppendixMiddleAuditContract`, `sald.first_appendix.source_index_audit`, `sald.first_appendix.middle_source_to_lean_map`, smooth density, admissible `sqrt(rho/pi)` test function, and Fisher-information chain-rule backend. | `SALD.saldLSIContract`; `SALD.saldKLContract`; `SALD.saldFIContract`; `SALD.saldLsiKlFiBridgeContract`; `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiVocabularyContract` | `main_body.tex:202` | All forward-KL theorems. | obligation |
| `def:alpha-complexity` | Pointwise `\mathfrak E_\alpha` and integrated `\mathcal A_\alpha` vocabulary. | Exponential moments and finite log-mgf monotonicity. | `SALD.saldAlphaComplexityContract` | `main_body.tex:218` | DV-energy bounds. | contract + obligation |
| `thm:forward-KL` | Continuous SALD KL bound with exact source exponent factors and alpha-complexity residual. | `SALD.cycle14ForwardKlMiddleContract`, `SALD.cycle18ForwardKlUpperPacket`, `SALD.cycle22ForwardKlUpperPacket`, `SALD.cycle22ForwardKlMiddleContract`, `SALD.cycle26ForwardKlUpperPacket`, `sald.forward_kl.middle_source_to_lean_map`, `sald.forward_kl.endpoint_schedule_identities`, `eq:SALD`, `eq:FP-eq`, `eq:LSI-KL-FI`, `def:alpha-complexity`, `lem:dv_variation`, `lem:gronwall`, `sald.forward_kl.moving_target_dependency_chain`, `sald.forward_kl.coefficient_chain_audit`, `sald.forward_kl.density_boundary_regular`, `sald.forward_kl.schedule_time_change`, `sald.forward_kl.kl_derivative`, `sald.forward_kl.dv_alpha_mgf_monotonicity`, `sald.forward_kl.dv_finite_log_mgf_witness`, `sald.forward_kl.dv_energy_bound`, `sald.forward_kl.gronwall_application`. | `SALD.continuousSaldContract`; `SALD.continuousForwardKlStatementContract`; `SALD.cycle14ForwardKlMiddleContract`; `SALD.cycle18ForwardKlUpperPacket`; `SALD.cycle22ForwardKlUpperPacket`; `SALD.cycle22ForwardKlMiddleContract`; `SALD.cycle26ForwardKlUpperPacket`; `SALD.forwardKlMovingTargetDependencyContract`; `SALD.forwardKlEndpointScheduleContract`; `SALD.forwardKlDependencyChainAuditContract`; `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlProofDag` | `main_body.tex:240`; proof `appendix.tex:164` | `thm:forward-KL-discrete` proof pattern. | contract + obligations |
| `forward-KL middle source-to-Lean map` | Classify `appendix.tex:168-252` and `main_body.tex:238-247` into existing contracts, source-cited results, and named obligations, with an endpoint-schedule lower packet. | `SALD.cycle14ForwardKlUpperPacket`, `SALD.continuousForwardKlStatementContract`, derivative side conditions, LSI bridge, DV witness, coefficient-chain audit, and Gronwall side conditions. | `SALD.cycle14ForwardKlMiddleContract`; `SALD.forwardKlMiddleSourceToLeanMapObligation`; DAG block `ASTIS.SALD.forward_KL.middle_source_to_lean_map` | `appendix.tex:168`; theorem display `main_body.tex:243` | `thm:forward-KL`, cycle 14 lower packets. | obligation |
| `forward-KL endpoint schedule identities` | Isolate `s(0)=0`, `S=s(T)`, `t(s(T))=T`, `tilde_pi_{s(t)}=pi_t`, and the `K(0)`/`K(T)` endpoint rewrites after Gronwall. | `SALD.forwardKlEndpointScheduleContract`, `sald.forward_kl.moving_target_dependency_chain`, `sald.forward_kl.schedule_time_change`, and `sald.forward_kl.gronwall_side_conditions`. | `SALD.forwardKlEndpointScheduleContract`; `SALD.forwardKlEndpointScheduleObligation`; DAG block `ASTIS.SALD.forward_KL.endpoint_schedule_identities` | `main_body.tex:9`; theorem display `main_body.tex:243`; proof `appendix.tex:218` | `thm:forward-KL`, cycle 14 lower packets. | obligation |
| `forward-KL coefficient-chain audit` | Preserve the post-Young, LSI, time-change, DV, scalar Gronwall, exponent-split, endpoint-identification, source-line ledger, scalar side conditions, and dependency classifications for `thm:forward-KL`. | `eq:LSI-KL-FI`, `def:alpha-complexity`, `lem:dv_variation`, `lem:gronwall`, and the forward-KL derivative/DV/Gronwall obligations. | `SALD.forwardKlDependencyChainAuditContract`; `SALD.forwardKlCoefficientChainObligation` | `appendix.tex:210`; theorem display `main_body.tex:243` | `thm:forward-KL`, `thm:forward-KL-discrete` proof pattern. | obligation |
| `cycle 18 continuous forward-KL upper packet` | Return to the continuous theorem's final Gronwall/DV/LSI chain after the cycle-17 scalar Gronwall algebra, selecting only the Gronwall side-condition ledger for lower refinement. | `SALD.cycle14ForwardKlMiddleContract`, `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlDependencyChainAuditContract`, `SALD.gronwallNegIntegralRewriteScalar`, `SALD.gronwallExpProductRewriteScalar`, `SALD.gronwallExpProductRewriteIntervalIntegral`, `SALD.gronwallExpProductRewriteIntegralCongr`, `lem:dv_variation`, and `eq:LSI-KL-FI`. | `SALD.cycle18ForwardKlUpperPacket`; DAG block `ASTIS.SALD.forward_KL.gronwall_side_conditions` dependencies | `main_body.tex:243`; proof `appendix.tex:244` | lower target `sald.forward_kl.gronwall_side_conditions`; `thm:forward-KL` | obligation |
| `cycle 22 continuous forward-KL upper packet` | Keep the same Gronwall side-condition lower target, narrowed to theorem-specific coefficient regularity and adjacent interval-integrability after the cycle-21 outer-integral congruence builds. | `SALD.cycle18ForwardKlMiddleContract`, `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlDependencyChainAuditContract`, `SALD.gronwallExpProductRewriteIntegralCongr`, `SALD.forwardKlEndpointScheduleContract`, `lem:gronwall`, `lem:dv_variation`, and `eq:LSI-KL-FI`. | `SALD.cycle22ForwardKlUpperPacket`; DAG block `ASTIS.SALD.forward_KL.gronwall_side_conditions` dependencies | theorem display `main_body.tex:243`; proof `appendix.tex:244`; Gronwall algebra `appendix.tex:63` | lower target `sald.forward_kl.gronwall_side_conditions`; `thm:forward-KL` | workflow obligation |
| `cycle 22 continuous forward-KL middle packet` | Translate the upper target into a lower-ready coefficient regularity and adjacent interval-integrability map before the compiled outer-integral congruence is used. | `SALD.cycle22ForwardKlUpperPacket`, `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlDependencyChainAuditContract`, `SALD.gronwallExpProductRewriteIntegralCongr`, `sald.forward_kl.dv_finite_log_mgf_witness`, and `probability.lsi_to_kl_fi`. | `SALD.cycle22ForwardKlMiddleContract`; DAG block `ASTIS.SALD.forward_KL.gronwall_side_conditions` dependencies | proof `appendix.tex:210-252`; theorem display `main_body.tex:243` | lower target `sald.forward_kl.gronwall_side_conditions`; `thm:forward-KL` | workflow obligation |
| `cycle 26 continuous forward-KL upper DV witness packet` | Return to the theorem-specific DV side condition for `Z=alpha*||v_t||^2`, selecting only common-space, absolute-continuity, measurability, finite log-mgf, alpha0-to-alpha monotonicity, and positive-alpha scaling as the next lower target. | `SALD.forwardKlDvFiniteLogMgfWitnessContract`, `SALD.forwardKlDvAlphaMonotonicityContract`, `SALD.saldDvFiniteLogMgfContract`, `sald.forward_kl.moving_target_dependency_chain`, `lem:dv_variation`, and `def:alpha-complexity`. | `SALD.cycle26ForwardKlUpperPacket`; DAG block `ASTIS.SALD.forward_KL.dv_finite_log_mgf_witness` dependencies | theorem assumption `main_body.tex:240`; DV use `appendix.tex:230`; source lemma `appendix.tex:73` | lower target `sald.forward_kl.dv_finite_log_mgf_witness`; `thm:forward-KL` | workflow obligation |
| `forward-KL DV alpha0-to-alpha mgf monotonicity` | Derive finite log-mgf at `alpha` from the source finite `alpha0` alpha-complexity assumption for `Z_t=alpha*||v_t||^2`. | `def:alpha-complexity`, `SALD.saldDvFiniteLogMgfContract`, exponential monotonicity, expectation/order backend, and log/inverse algebra. | `SALD.forwardKlDvAlphaMonotonicityContract`; `SALD.forwardKlDvAlphaMonotonicityObligation` | `main_body.tex:240`; DV use `appendix.tex:230` | `thm:forward-KL`, `sald.forward_kl.dv_finite_log_mgf_witness` | obligation |
| `forward-KL DV finite-log-mgf witness` | Expose the theorem-specific finite log-mgf, common-space, measurability, and positive-alpha scaling side conditions for the DV step with `Z=alpha*||v_t||^2`. | `lem:dv_variation`, `def:alpha-complexity`, `SALD.saldDvFiniteLogMgfContract`, `sald.dv_variation.finite_log_mgf_interface`, `sald.forward_kl.dv_alpha_mgf_monotonicity`, `sald.forward_kl.moving_target_dependency_chain`. | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `SALD.forwardKlDvFiniteLogMgfWitnessObligation` | `appendix.tex:230` | `thm:forward-KL`, discrete forward-KL DV pattern. | obligation |
| `thm:forward-KL-discrete` | Discrete SALD KL bound with EM interpolation, frozen one-step defect, DV, Gronwall accumulation, and linear-slowdown collection. | `SALD.cycle19DiscreteForwardKlUpperPacket`, `thm:forward-KL`, `eq:frozen_interp_terminal_disc_prop_additive_final`, `lem:frozen_delta_cross_lip_sald`, `lem:dv_variation`, `lem:gronwall`, `SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar`, and `sald.discrete_forward_kl.*` obligations including `sald.discrete_forward_kl.dv_finite_log_mgf_witness`. | `SALD.discreteSaldContract`; `SALD.discreteForwardKlStatementContract`; `SALD.discreteForwardKlProofDag` | `main_body.tex:301`; proof `appendix.tex:260` | SALD iteration-complexity verification. | contract + obligations |
| `cycle 15 discrete forward-KL upper packet` | Select the EM interpolation side-condition spine as the next lower target, before one-step defects and accumulated errors are folded into the theorem display. | `sald.discrete_forward_kl.em_endpoint_laws`, `sald.discrete_forward_kl.em_conditional_fokker_planck`, `sald.discrete_forward_kl.stitched_interval_regularity`, `sald.discrete_forward_kl.accumulated_error_bridge`. | `SALD.cycle15DiscreteForwardKlUpperPacket`; DAG block `ASTIS.SALD.forward_KL_discrete.cycle15_upper_packet` | `appendix.tex:260`; proof `appendix.tex:347` | `thm:forward-KL-discrete`, cycle 15 lower packet. | obligation |
| `cycle 15 discrete forward-KL middle EM spine` | Classify the upper-selected EM side-condition spine into ordered lower obligations, with the conditional-drift Fokker--Planck equation as the first slice and accumulated errors kept separate. | `SALD.cycle15DiscreteForwardKlUpperPacket`, `sald.discrete_forward_kl.em_endpoint_laws`, `sald.discrete_forward_kl.em_conditional_fokker_planck`, `sald.discrete_forward_kl.stitched_interval_regularity`, `sald.discrete_forward_kl.em_interpolation_fp`, and `sald.discrete_forward_kl.accumulated_error_bridge`. | `SALD.cycle15DiscreteForwardKlMiddleContract`; `SALD.cycle15DiscreteForwardKlMiddleEmSpineObligation`; DAG block `ASTIS.SALD.forward_KL_discrete.cycle15_middle_em_spine` | `appendix.tex:260`; proof `appendix.tex:347`; accumulated display `appendix.tex:557` | `thm:forward-KL-discrete`, cycle 15 lower packet. | obligation |
| `cycle 15 conditional drift density sub-obligation` | First lower sub-slice for `appendix.tex:347-354`: make the conditional expectation defining `bar b_{k,s}` into a measurable, integrable drift field against a smooth density for `hat rho_s`. | `eq:frozen_interp_terminal_disc_prop_additive_final`, `SALD.discreteSaldEulerMaruyamaContract`, `sald.discrete_forward_kl.em_endpoint_laws`. | `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract`; `SALD.cycle15DiscreteForwardKlConditionalDriftDensityObligation`; DAG block `ASTIS.SALD.forward_KL_discrete.conditional_drift_density` | `appendix.tex:347` | `sald.discrete_forward_kl.em_conditional_fokker_planck`, `thm:forward-KL-discrete` | obligation |
| `cycle 15 conditional Fokker--Planck lower packet` | Line-level lower slice for `appendix.tex:347-385`: define `bar b_{k,s}`, expose the conditional law/density backend, prove the frozen-interpolation Fokker--Planck equation, split the Laplacian relative to `tilde pi_s`, and hand off to the KL derivative block. | `SALD.cycle15DiscreteForwardKlMiddleContract`, `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract`, `SALD.discreteForwardKlEmInterpolationSideConditionContract`, `sald.discrete_forward_kl.conditional_drift_density`, `sald.discrete_forward_kl.em_endpoint_laws`, and `sald.discrete_forward_kl.em_conditional_fokker_planck`. | `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerContract`; `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerObligation`; DAG block `ASTIS.SALD.forward_KL_discrete.cycle15_conditional_fp_lower_packet` | `appendix.tex:347` | `thm:forward-KL-discrete`, cycle 15 lower packet. | obligation |
| `discrete forward-KL DV finite-log-mgf witness` | Expose the EM-interpolation DV instantiation with `nu=\hat\rho_s`, `mu=\tilde\pi_s`, and `Z=\alpha\|v_{t(s)}\|^2`, including common-space, absolute-continuity, finite log-mgf, alpha scaling, and `\dot t(s)^2` coefficient preservation. | `lem:dv_variation`, `def:alpha-complexity`, `SALD.saldDvFiniteLogMgfContract`, `sald.forward_kl.dv_alpha_mgf_monotonicity`, `sald.forward_kl.dv_finite_log_mgf_witness`, EM interpolation law. | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessObligation` | `appendix.tex:493` | `thm:forward-KL-discrete`, `sald.discrete_forward_kl.dv_velocity_bound`, discrete coefficient audit. | obligation |
| `discrete forward-KL residual exponent bound` | Bound the residual Gronwall exponent after linear slowdown by `exp(T/(r\alpha)+2r\eta^2\bar\Gamma/\alpha')`, using nonnegative LSI, positive `alpha`, `alpha'`, and `r`, plus interval-integral monotonicity for `Gamma`. | `lem:gronwall`, linear-slowdown specialization, `barGamma=int_0^T Gamma(t)dt`, and local real/integral order algebra. | `SALD.discreteForwardKlResidualExponentBoundObligation`; scalar core `SALD.discreteForwardKlResidualExponentBoundScalar`, `SALD.discreteForwardKlResidualExpBoundScalar` | `appendix.tex:557`; theorem display `main_body.tex:309` | `thm:forward-KL-discrete`, `sald.discrete_forward_kl.accumulated_error_bridge`, discrete coefficient audit. | obligation with formalized scalar core |
| `discrete forward-KL accumulated-error bridge` | Convert the appendix Gronwall display into the main-body linear-slowdown theorem bound by endpoint matching, exponent splitting, residual-exponent bounding, and `\mathcal A_\alpha`/`\bar\Gamma`/`\bar\Delta_{\alpha'}` collection. | `lem:gronwall`, `def:alpha-complexity`, EM endpoint laws, stitched interval regularity, and linear-slowdown specialization. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` | `appendix.tex:557`; theorem display `main_body.tex:309` | `thm:forward-KL-discrete`, discrete coefficient audit. | obligation |
| `cycle 19 discrete forward-KL accumulated-error upper packet` | Select the accumulated-error bridge as the next lower target after the appendix Gronwall display, preserving endpoint rewrites, exponent split, residual-exponent bound, and `A_alpha`/`barGamma`/`barDelta` collection. | `sald.discrete_forward_kl.gronwall_accumulation`, `sald.discrete_forward_kl.linear_slowdown_specialization`, `sald.discrete_forward_kl.residual_exponent_bound`, and `sald.discrete_forward_kl.accumulated_error_bridge`. | `SALD.cycle19DiscreteForwardKlUpperPacket`; DAG block `ASTIS.SALD.forward_KL_discrete.cycle19_upper_packet` | `appendix.tex:557`; theorem display `main_body.tex:309` | lower target `sald.discrete_forward_kl.accumulated_error_bridge`; `thm:forward-KL-discrete` | obligation |
| `cycle 19 discrete forward-KL accumulated-error middle packet` | Translate the upper target into lower-ready sub-slices: Gronwall output, linear-slowdown substitution, residual exponent/full-interval `barGamma` bound, endpoint rewrites, and `A_alpha`/`barDelta` collection. | `SALD.cycle19DiscreteForwardKlUpperPacket`, `sald.discrete_forward_kl.gronwall_accumulation`, `sald.discrete_forward_kl.linear_slowdown_specialization`, `sald.discrete_forward_kl.residual_exponent_bound`, and `sald.discrete_forward_kl.accumulated_error_bridge`. | `SALD.cycle19DiscreteForwardKlMiddleContract`; `SALD.cycle19DiscreteForwardKlAccumulatedErrorMiddleObligation`; DAG block `ASTIS.SALD.forward_KL_discrete.cycle19_middle_accumulated_error` | `appendix.tex:557`; theorem display `main_body.tex:309` | lower target `sald.discrete_forward_kl.residual_exponent_bound`; `thm:forward-KL-discrete` | obligation |
| `cycle 23 discrete forward-KL middle coefficient-chain packet` | Translate the cycle-23 coefficient-chain target into the first lower slice `appendix.tex:454-553`, keeping the endpoint and accumulated-error bridge separate. | `SALD.cycle23DiscreteForwardKlUpperPacket`, frozen-delta, LSI, DV finite-log-mgf, DV velocity, `SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar`, time-change side conditions, Gronwall, and accumulated-error obligations. | `SALD.cycle23DiscreteForwardKlMiddleContract`; `SALD.cycle23DiscreteForwardKlCoefficientChainMiddleObligation`; DAG block `ASTIS.SALD.forward_KL_discrete.cycle23_middle_coefficient_chain` | `appendix.tex:454`; follow-on `appendix.tex:557`; theorem display `main_body.tex:309` | lower target `sald.discrete_forward_kl.coefficient_chain_audit`; `thm:forward-KL-discrete` | obligation with formalized scalar core |
| `cycle 27 discrete forward-KL upper accumulated collection` | Return to the accumulated-error bridge after the coefficient-chain audit and select endpoint, exponent, `A_alpha`, `barGamma`, and `barDelta` collection. | `SALD.cycle19DiscreteForwardKlMiddleContract`, `SALD.cycle23DiscreteForwardKlMiddleContract`, residual exponent scalar cores, coefficient-chain audit, EM endpoint/stitching obligations. | `SALD.cycle27DiscreteForwardKlUpperPacket`; `SALD.cycle27DiscreteForwardKlAccumulatedCollectionUpperObligation`; DAG block `ASTIS.SALD.forward_KL_discrete.cycle27_upper_accumulated_collection` | `appendix.tex:557`; theorem display `main_body.tex:309` | lower target `sald.discrete_forward_kl.accumulated_error_bridge`; `thm:forward-KL-discrete` | obligation |
| `cycle 27 discrete forward-KL middle accumulated collection` | Translate the cycle-27 target into the first lower sub-slice `endpointBridge`, `alphaComplexityCollection`, and `deltaAccumulation`, keeping residual exponent and `barGamma` identification separate. | `SALD.cycle27DiscreteForwardKlUpperPacket`, accumulated-error bridge, linear slowdown, residual exponent scalar cores, coefficient-chain audit, `def:alpha-complexity`, EM endpoint/stitching obligations. | `SALD.cycle27DiscreteForwardKlMiddleContract`; `SALD.cycle27DiscreteForwardKlAccumulatedCollectionMiddleObligation`; DAG block `ASTIS.SALD.forward_KL_discrete.cycle27_middle_accumulated_collection` | `appendix.tex:557`; theorem display `main_body.tex:309` | lower target `sald.discrete_forward_kl.accumulated_error_bridge`; `thm:forward-KL-discrete` | obligation |
| `cycle 27 lower accumulated collection scalar core` | Compile the additive residual constant-factor extraction for `E_alpha` and `Delta` after linear slowdown, while keeping endpoint stitching and source integral identifications open. | `SALD.cycle27DiscreteForwardKlMiddleContract`, `SALD.discreteForwardKlAccumulatedErrorBridgeContract`, linear slowdown obligation, `def:alpha-complexity`. | `SALD.discreteForwardKlAlphaComplexityCollectionScalar`; `SALD.discreteForwardKlDeltaAccumulationScalar`; `SALD.discreteForwardKlAccumulatedErrorCollectionScalar`; `SALD.cycle27DiscreteForwardKlAccumulatedCollectionLowerObligation`; DAG block `ASTIS.SALD.forward_KL_discrete.cycle27_lower_accumulated_collection` | `appendix.tex:586`; theorem display `main_body.tex:316` | `sald.discrete_forward_kl.accumulated_error_bridge`; `thm:forward-KL-discrete` | formalized scalar core plus obligation |
| `discrete forward-KL EM/defect/accumulation middle packet` | Lower-ready map from EM interpolation and conditional drift through one-step defects, DV velocity witness, Gronwall accumulation, and main-body accumulated errors. | EM endpoint laws, conditional Fokker--Planck, frozen defect, DV witness, Gronwall accumulation, linear-slowdown specialization, and accumulated-error bridge. | `SALD.cycle11DiscreteForwardKlMiddleContract`; `SALD.discreteForwardKlEmDefectAccumulationMiddleObligation` | `appendix.tex:260`; coefficient chain `appendix.tex:454`; accumulated display `appendix.tex:557`; theorem display `main_body.tex:309` | `thm:forward-KL-discrete`, lower cycle 11 packets. | obligation |
| `discrete forward-KL time-change scalar rewrite` | Formalize the real algebra turning `dot{s}(t)*dot t(s(t))^2*coeff` into `dot{s}(t)^(-1)*coeff` after inverse-schedule side conditions are supplied. | inverse-schedule identity `dot t(s(t))=dot{s}(t)^(-1)` and nonzero `dot{s}(t)` remain obligations. | `SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar` | `appendix.tex:526` | `sald.discrete_forward_kl.coefficient_chain_audit`, `thm:forward-KL-discrete` | formalized scalar core |
| `discrete forward-KL coefficient-chain audit` | Preserve the frozen-defect, moving-velocity, LSI, DV, time-change, Gronwall, endpoint, linear-slowdown coefficients, and scalar side conditions for `thm:forward-KL-discrete`. | `lem:frozen_delta_cross_lip_sald`, `eq:LSI-KL-FI`, `lem:dv_variation`, `lem:gronwall`, stitched EM regularity, `SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar`, `sald.discrete_forward_kl.dv_finite_log_mgf_witness`, and other `sald.discrete_forward_kl.*` obligations. | `SALD.discreteForwardKlCoefficientChainAuditContract`; `SALD.discreteForwardKlCoefficientChainObligation` | `appendix.tex:454`; theorem display `main_body.tex:309` | `thm:forward-KL-discrete`, discrete general coefficient-pattern review. | obligation with formalized scalar core |
| `eq:frozen_interp_terminal_disc_prop_additive_final` | Continuous interpolation of the Euler--Maruyama update with endpoint laws `rho_k^eta`. | EM law, endpoint laws, conditional drift, interpolation Fokker--Planck equation, stitched interval regularity. | `SALD.discreteSaldEulerMaruyamaContract`; `SALD.discreteForwardKlEmInterpolationObligation`; `SALD.discreteForwardKlEmInterpolationSideConditionContract` | `appendix.tex:260`; proof `appendix.tex:334` | `thm:forward-KL-discrete` | contract + obligation |
| `lem:frozen_delta_cross_lip_sald` | One-step frozen score-defect cross-term bound with source `Gamma` and `Delta`. | Score Lipschitz assumptions, finite exponential complexities, later general frozen-defect lemma. | `SALD.frozenDeltaCrossLipSaldContract`; `SALD.discreteForwardKlFrozenDeltaObligation` | `appendix.tex:279` | `thm:forward-KL-discrete` | obligation |
| `prop:guided_path_residual` | Guided-path residual identity. | Product/normalization derivative, integration by parts, finite positive `Z_t`, and centering. | `SALD.guidedResidualContract`; `SALD.guidedResidualIdentityContract`; `SALD.guidedResidualNormalizerObligation`; `SALD.guidedResidualIdentityObligation` | `appendix.tex:619`; proof `appendix.tex:630` | `thm:unified-forward-KL` | contract + obligation |
| `thm:general-moving-target-SALD` | General VA-SALD tracking theorem with residual field `m_t=v_t-c_t` and sigma-weighted Gronwall coefficients. | `eq:general_moving_target_SALD`, `TransportVelocityContract`, `eq:LSI-KL-FI`, `def:alpha-complexity`, `lem:dv_variation`, `lem:gronwall`, `sald.general_moving_target.*` obligations including `sald.general_moving_target.dv_finite_log_mgf_witness`. | `SALD.generalVaSaldContract`; `SALD.generalMovingTargetStatementContract`; `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvEnergyCandidateContract`; `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `SALD.generalVaSaldProofDag` | `appendix.tex:724`; proof `appendix.tex:765` | `thm:unified-forward-KL`, `thm:general-moving-target-SALD-discrete` | contract + obligations |
| `guided/general VA-SALD middle map` | Lower-ready source-to-Lean map from guided residual through continuous general theorem, unified specialization, discrete general theorem, and discrete guided specialization. | `prop:guided_path_residual`, `eq:poisson-eq`, `thm:general-moving-target-SALD`, residual DV witnesses, Gronwall side conditions, EM derivative side conditions, and discrete specialization. | `SALD.cycle12GeneralVaSaldMiddleContract`; `SALD.generalVaSaldGuidedPathMiddleObligation`; DAG block `ASTIS.SALD.general_va_sald.guided_path_middle` | `appendix.tex:619`; `appendix.tex:724`; `main_body.tex:372`; `appendix.tex:1313` | `thm:general-moving-target-SALD`, `thm:unified-forward-KL`, `thm:general-moving-target-SALD-discrete`, lower cycle 12 packets | obligation |
| `cycle 16 guided/general upper transport packet` | Select the unified theorem transport bridge as the next lower target while leaving all general-theorem, DV, Gronwall, and discrete EM obligations unchanged. | `prop:guided_path_residual`, `eq:poisson-eq`, `eq:SALD_Ito`, `thm:general-moving-target-SALD`, `thm:unified-forward-KL`, `thm:general-moving-target-SALD-discrete`. | `SALD.cycle16GeneralVaSaldUpperPacket`; `SALD.unifiedForwardKlTransportBridgeObligation`; DAG block `ASTIS.SALD.unified_forward_KL.transport_velocity_bridge` | `main_body.tex:359`; proof `appendix.tex:949` | `thm:unified-forward-KL`, cycle 16 lower packet | obligation |
| `cycle 16 unified transport bridge middle map` | Line-level middle packet for `main_body.tex:359-368`: centered residual plus correction-field divergence cancels to the transport equation before the appendix specialization. | `SALD.cycle16GeneralVaSaldUpperPacket`, `SALD.unifiedForwardKlSpecializationContract`, `sald.guided_path_residual.identity`, `eq:poisson-eq`, correction-field divergence regularity. | `SALD.cycle16UnifiedForwardKlTransportBridgeMiddleContract`; `SALD.cycle16UnifiedForwardKlTransportBridgeMiddleObligation`; DAG block `ASTIS.SALD.unified_forward_KL.transport_bridge_middle` | `main_body.tex:359`; proof `appendix.tex:949` | `sald.unified_forward_kl.transport_velocity_bridge`, `thm:unified-forward-KL`, cycle 16 lower packet | obligation |
| `cycle 16 unified transport bridge lower slice` | Preserve the residual/correction signs, expose divergence linearity, cancel the centered guide residual, and record `v_t=u_t+w_t`, `c_t=u_t`, `m_t=w_t`. | `SALD.cycle16UnifiedForwardKlTransportBridgeMiddleContract`, `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract`, `sald.unified_forward_kl.transport_bridge_middle`, `sald.guided_path_residual.identity`, `eq:poisson-eq`, `TransportVelocityContract`. | `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract`; `SALD.cycle16UnifiedForwardKlTransportBridgeLowerObligation`; DAG block `ASTIS.SALD.unified_forward_KL.transport_bridge_lower` | `main_body.tex:359`; proof `appendix.tex:949` | `sald.unified_forward_kl.transport_velocity_bridge`, `thm:unified-forward-KL`, cycle 16 lower packet | obligation |
| `cycle 17 first appendix source-index upper packet` | Rebaseline the first appendix/vocabulary source-index contracts after cycle 16, keeping the focus on `lem:gronwall`, `lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI`. | `research-wiki/source-index/SALD_original.jsonl`, `SALD.cycle13FirstAppendixSourceIndexAuditContract`, `SALD.cycle13FirstAppendixMiddleAuditContract`, and the existing Gronwall, DV, PI, and LSI/KL/FI contracts. | `SALD.cycle17FirstAppendixVocabularyPacket`; `SALD.firstAppendixSourceIndexAuditObligation`; DAG dependencies for the four first-layer labels. | `appendix.tex:47`; `appendix.tex:73`; `appendix.tex:86`; `main_body.tex:202` | cycle 17 middle/lower packet; all first proof-DAG users | obligation |
| `cycle 17 first appendix middle rebaseline` | Re-read the four first-layer source windows and classify each step as an existing Lean contract, cited result, or proof obligation, with `sald.gronwall.exponent_rewrite` as the lower target. | `SALD.cycle17FirstAppendixVocabularyPacket`, `SALD.cycle13FirstAppendixSourceIndexAuditContract`, `SALD.saldGronwallExponentRewriteContract`, `SALD.saldDvFiniteLogMgfContract`, `SALD.saldPiVelocityNormDependencyContract`, `SALD.saldLsiKlFiDensityTestContract`, and `SALD_original.jsonl`. | `SALD.cycle17FirstAppendixMiddleAuditContract`; `SALD.firstAppendixMiddleAuditObligation`; DAG dependencies for the four first-layer labels. | `appendix.tex:47`; exponent slice `appendix.tex:63`; `appendix.tex:73`; `appendix.tex:86`; `main_body.tex:202` | lower target `sald.gronwall.exponent_rewrite`; all first proof-DAG users | obligation |
| `general moving-target residual DV finite-log-mgf witness` | Expose finite log-mgf, common-space, absolute-continuity, measurability, and positive-alpha scaling for `Z=alpha*||m_t||^2`. | `lem:dv_variation`, `def:alpha-complexity`, `SALD.saldDvFiniteLogMgfContract`, alpha0-to-alpha monotonicity for `m_t`, and KL density vocabulary. | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessObligation` | `appendix.tex:885` | `thm:general-moving-target-SALD`, `thm:unified-forward-KL`, `thm:general-moving-target-SALD-discrete` | obligation |
| `general moving-target residual DV positive-alpha scaling` | Divide the residual DV inequality by `alpha>0`, rewrite the log-mgf quotient as `E_alpha(pi_t,m_t)`, and keep the sigma-weighted `alpha^(-1)` coefficient. | `lem:dv_variation`, `def:alpha-complexity`, `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`, and local Real order/scalar algebra. | `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingObligation`; DAG block `ASTIS.SALD.general_moving_target.dv_positive_alpha_scaling` | `appendix.tex:887` | `thm:general-moving-target-SALD`, `thm:unified-forward-KL` | obligation |
| `general moving-target Gronwall side conditions` | Rewrite Gronwall endpoints, split sigma-weighted exponents, bound the residual exponent, and record the zero-residual pure-contraction algebra. | `lem:gronwall`, inverse-schedule endpoints, `def:alpha-complexity`, coefficient regularity, sign/order algebra. | `SALD.generalMovingTargetGronwallSideConditionContract`; `SALD.generalMovingTargetGronwallSideConditionObligation` | `appendix.tex:908`; theorem display `appendix.tex:727` | `thm:general-moving-target-SALD`, `thm:unified-forward-KL` | obligation |
| `unified-forward-KL transport bridge` | Combine the centered guided residual identity with `eq:poisson-eq` to prove `u_t+w_t` transports `pi_t`, then record `v_t=u_t+w_t`, `c_t=u_t`, and `m_t=w_t`. | `prop:guided_path_residual`, `eq:poisson-eq`, `TransportVelocityContract`, correction-field existence/regularity obligation. | `SALD.unifiedForwardKlTransportBridgeObligation`; DAG block `ASTIS.SALD.unified_forward_KL.transport_velocity_bridge` | `main_body.tex:359`; `main_body.tex:364` | `thm:unified-forward-KL` | obligation |
| `thm:unified-forward-KL` | Main-body VA-SALD theorem as specialization `c_t <- u_t`, so `m_t=w_t`. | `prop:guided_path_residual`, `eq:poisson-eq`, `eq:SALD_Ito`, `thm:general-moving-target-SALD`, `sald.unified_forward_kl.transport_velocity_bridge`, `sald.general_moving_target.dv_finite_log_mgf_witness`, `sald.unified_forward_kl.specialization`. | `SALD.unifiedForwardKlContract`; `SALD.unifiedForwardKlSpecializationContract`; `SALD.unifiedForwardKlTransportBridgeObligation`; `SALD.unifiedForwardKlSpecializationObligation` | `main_body.tex:372`; proof `appendix.tex:949` | Guided-generation convergence statement. | contract + obligation |
| `general_moving_target_discrete.derivative_side_conditions` | Endpoint laws, conditional-drift Fokker--Planck split, frozen/residual algebra, exact Young coefficient bookkeeping, DV finite-mgf witness, and stitched time change for the discrete general derivative block. | `eq:SALD_general_EM`, `eq:general_moving_target_SALD_frozen_interp`, `eq:general_discrete_delta_def`, `lem:frozen_delta_cross_lip`, `lem:dv_variation`, inverse-schedule interface. | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` | `appendix.tex:1354`; proof through `appendix.tex:1600` | `thm:general-moving-target-SALD-discrete` | obligation |
| `general_moving_target_discrete residual DV finite-log-mgf witness` | Expose the EM-interpolation residual DV witness with `nu=hat rho_s`, `mu=tilde pi_s`, and `Z=alpha*||m_{t(s)}||^2`, preserving the doubled residual coefficient before time change. | `lem:dv_variation`, `def:alpha-complexity`, continuous residual finite-log-mgf witness, EM interpolation law, and derivative side conditions. | `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessObligation` | `appendix.tex:1544` | `thm:general-moving-target-SALD-discrete`, discrete VA-SALD guided specialization | obligation |
| `general_moving_target_discrete.gronwall_side_conditions` | Stitched endpoint laws, constant-schedule coefficient rewrites, coefficient regularity, and exact matching of the Gronwall output to the theorem display. | `lem:gronwall`, `sald.general_moving_target_discrete.constant_schedule_stitching`, `sald.general_moving_target_discrete.kl_derivative`, `sald.general_moving_target_discrete.dv_m_energy`, `sald.general_moving_target_discrete.frozen_delta_cross_lip`. | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` | `appendix.tex:1573`; theorem display `appendix.tex:1316` | `thm:general-moving-target-SALD-discrete`, discrete VA-SALD guided specialization | obligation |
| `thm:general-moving-target-SALD-discrete` | Discrete general VA-SALD theorem with EM interpolation, general frozen-delta error, residual DV-energy, and Gronwall. | `eq:SALD_general_EM`, `eq:general_moving_target_SALD_frozen_interp`, `eq:general_discrete_delta_def`, `lem:frozen_delta_cross_lip`, `lem:dv_variation`, `lem:gronwall`, `sald.general_moving_target_discrete.*` obligations including `sald.general_moving_target_discrete.dv_finite_log_mgf_witness`. | `SALD.generalVaSaldDiscreteContract`; `SALD.generalMovingTargetDiscreteStatementContract`; `SALD.generalFrozenDeltaCrossLipContract`; `SALD.generalMovingTargetDiscreteDerivativeCandidateContract`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDiscreteGronwallInstantiationContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `SALD.generalVaSaldDiscreteProofDag` | `appendix.tex:1313`; setup `appendix.tex:953`; proof `appendix.tex:1354` | Discrete VA-SALD specialization. | contract + obligations |

## Cycle 17 Upper Source-Index Rebaseline

Objective: rebaseline the source-index and first appendix/vocabulary contracts
for `lem:gronwall`, `lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI` after
cycle 16.  The compiled upper packet is
`SALD.cycle17FirstAppendixVocabularyPacket`.

Mode discipline: use only the original `appendix.tex:47-94` and
`main_body.tex:202-215` windows; preserve the Gronwall signs, DV finite-log-mgf
condition, PI constant convention, and `1/(2*C_LSI)` LSI-to-KL/FI coefficient;
keep all analytic backends at obligation/source-cited status.

Non-goals: do not edit later SALD theorem statements, do not switch proof
routes, and do not add hidden endpoint, smoothness, finite-mgf, density,
Sobolev, or boundary assumptions.

Lower packet: middle must keep Lean, this conversion window,
`proof-obligations/ASTIS-SALD-001.md`, and the TeX line windows synchronized.
The preferred lower target is the source-index/contract audit
`SALD.cycle13FirstAppendixSourceIndexAuditContract` /
`sald.first_appendix.source_index_audit`; if an analytic slice is chosen,
prefer `SALD.saldGronwallExponentRewriteContract` /
`sald.gronwall.exponent_rewrite`.

Reviewer checklist: rerun `python3 tools/astis.py source-index ASTIS-SALD-001`
and `python3 tools/astis.py check`; confirm `sald_version_2.tex` is excluded;
confirm `SALD.saldFirstProofDag` keeps Gronwall as obligation, DV as
source-cited, PI as contract-only, and LSI/KL/FI as obligation.

## Cycle 17 Middle Source-To-Lean Rebaseline

Objective: translate the cycle-17 upper packet into a lower-ready source map
without changing any theorem statement.  The compiled middle record is
`SALD.cycle17FirstAppendixMiddleAuditContract`; the shared workflow obligation
is `SALD.firstAppendixMiddleAuditObligation`.

| Source window | Lean-facing interface | Current blocker |
|---|---|---|
| `appendix.tex:47-71` Gronwall proof, especially `appendix.tex:63-69` | `SALD.saldGronwallExponentRewriteContract`, `SALD.gronwallExponentRewriteObligation`, parent `SALD.saldGronwallEndpointCalculusContract`, compiled scalar helpers `SALD.gronwallNegIntegralRewriteScalar` / `SALD.gronwallExpProductRewriteScalar`, compiled adjacent-interval bridge `SALD.gronwallExpProductRewriteIntervalIntegral`, and compiled outer-integral congruence `SALD.gronwallExpProductRewriteIntegralCongr` | theorem-specific adjacent interval-integrability remains; scalar `Real.exp` product algebra, the adjacent-interval bridge, and the outer-integral congruence now build locally |
| `appendix.tex:73-79` DV variational formula | `SALD.dvContract`, `SALD.saldDvFiniteLogMgfContract`, `probability.dv_variational_formula`, `sald.dv_variation.finite_log_mgf_interface` | source-cited Boucheron formula plus common-space/measurable-test/finite-log-mgf interfaces |
| `appendix.tex:86-151` PI definition and velocity-norm route | `SALD.saldPIContract`, `SALD.piDefinitionContract`, `SALD.saldPiVelocityNormDependencyContract`, `sald.pi.velocity_norm_backend` | weighted mean-zero Sobolev backend, bounded functional, Riesz representation, weak PDE, and boundary regularity |
| `main_body.tex:202-215` LSI/KL/FI bridge | `SALD.saldLsiKlFiBridgeContract`, `SALD.saldLsiKlFiDensityTestContract`, `SALD.lsiKlFiVocabularyContract`, `sald.lsi_kl_fi.density_test_interface`, `probability.lsi_to_kl_fi` | Radon-Nikodym density, admissible `sqrt(rho/pi)`, entropy rewrite, FI chain rule, and coefficient audit |

Middle lower packet:

- target `SALD.saldGronwallExponentRewriteContract` /
  `sald.gronwall.exponent_rewrite` only;
- preserve the source rewrite
  `exp(-int_0^t1 a)*exp(int_0^t a)=exp(-int_t^t1 a)` with no sign
  assumptions on `a` or `b`;
- if the real-analysis backend is not ready, refine the obligation rather than
  proving `lem:gronwall` or changing later theorem statements;
- keep DV source-cited, PI contract-only, and LSI/KL/FI at obligation status.

## Cycle 17 Lower Gronwall Scalar Sublemma

Lower target: `SALD.saldGronwallExponentRewriteContract` /
`sald.gronwall.exponent_rewrite` only.

Compiled Lean sublemmas:

- `SALD.gronwallNegIntegralRewriteScalar`: from scalar additivity
  `i0 = it + it1`, prove `-i0 + it = -it1`;
- `SALD.gronwallExpProductRewriteScalar`: from the same scalar additivity, prove
  `Real.exp (-i0) * Real.exp it = Real.exp (-it1)`.

These sublemmas formalize only the pointwise real algebra behind
`appendix.tex:65-69`.  Cycle 18 adds the adjacent-interval bridge from
interval-integral additivity to these scalar helpers; theorem-specific
interval-integrability and the congruence that pushes the pointwise rewrite
through the `b_t` integral remain obligations.  No sign condition on `a` or
`b` is introduced, and `lem:gronwall` remains an obligation.

## Cycle 18 Upper Continuous Forward-KL Re-Audit

Objective: return to continuous `thm:forward-KL` and select one lower target in
the final moving-target dependency chain: `SALD.forwardKlGronwallSideConditionContract`
/ `SALD.forwardKlGronwallSideConditionObligation` /
`sald.forward_kl.gronwall_side_conditions`.

Source anchors:

- theorem statement `main_body.tex:238-247`;
- derivative/LSI/time-change chain `appendix.tex:168-228`;
- DV velocity-energy step `appendix.tex:230-241`;
- final Gronwall display `appendix.tex:244-252`;
- cycle-17 local scalar Gronwall algebra from `appendix.tex:63-69`.

Compiled upper packet: `SALD.cycle18ForwardKlUpperPacket`.  It does not change
`thm:forward-KL` or `SALD.continuousForwardKlStatementContract`.  The packet
records that the cycle-17 scalar helpers
`SALD.gronwallNegIntegralRewriteScalar` and
`SALD.gronwallExpProductRewriteScalar`, plus the cycle-18 bridge
`SALD.gronwallExpProductRewriteIntervalIntegral` and the cycle-21 congruence
wrapper `SALD.gronwallExpProductRewriteIntegralCongr`, are local substeps
only; the theorem context still must supply adjacent interval-integrability.

Lower packet:

- refine only the final Gronwall side-condition ledger: endpoint `K(0)`/`K(T)`
  rewrites, coefficient regularity for `a(t)` and `b(t)`, exponent splitting,
  and the residual LSI exponent drop;
- keep the DV slice at `SALD.forwardKlDvFiniteLogMgfWitnessContract` and the
  LSI slice at `SALD.saldLsiKlFiDensityTestContract`;
- if theorem-specific adjacent interval-integrability or residual
  exponent monotonicity is not ready, refine the obligation rather than
  changing the theorem display.

Reviewer checklist:

- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle18ForwardKlUpperPacket` while retaining cycle-14 dependencies;
- `SALD.forwardKlProofDag` records the cycle-17 scalar Gronwall helpers and
  cycle-18 adjacent-interval bridge only as dependencies of the Gronwall
  side-condition block;
- `SALD.continuousSaldContract` remains `contractOnly` with all analytic
  obligations still listed;
- `SALD_original.jsonl` indexes the source theorem and first-layer dependencies,
  excluding `sald_version_2.tex`;
- no DV, LSI, KL derivative, full Gronwall, schedule, or moving-target backend
  is promoted.

## Cycle 18 Middle Gronwall Side-Condition Map

Objective: translate the cycle-18 upper target into a lower-ready
source-to-Lean map for `sald.forward_kl.gronwall_side_conditions`.  The
compiled middle record is `SALD.cycle18ForwardKlMiddleContract`.

| Source step | Lean-facing interface | Current blocker |
|---|---|---|
| `main_body.tex:238-247` theorem statement and final display | `SALD.continuousForwardKlStatementContract`, `SALD.continuousSaldContract` | fixed theorem statement; no endpoint, regularity, or positivity facts may be silently added |
| `appendix.tex:210-228` LSI/time-change coefficient input | `SALD.saldLsiKlFiDensityTestContract`, `SALD.forwardKlEndpointScheduleContract`, `sald.forward_kl.schedule_time_change` | density-test backend for `eq:LSI-KL-FI` and inverse-schedule calculus |
| `appendix.tex:230-241` DV contribution to `a(t)` and `b(t)` | `SALD.forwardKlDvFiniteLogMgfWitnessContract`, `SALD.forwardKlDvEnergyCandidateContract` | common-space, measurability, alpha0-to-alpha finite-log-mgf, and positive-alpha scaling |
| `appendix.tex:244-248` raw Gronwall output | `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlGronwallApplicationObligation` | coefficient regularity for `a(t)`, `b(t)`, endpoint-safe Gronwall backend, and `K(0)`/`K(T)` rewrites |
| `appendix.tex:249-252` theorem-display simplification | `SALD.forwardKlGronwallSideConditionObligation`, `sald.forward_kl.gronwall_side_conditions` | exponent split, residual LSI exponent drop, and interval-integral monotonicity |
| `appendix.tex:63-69` reusable Gronwall exponent algebra | `SALD.gronwallNegIntegralRewriteScalar`, `SALD.gronwallExpProductRewriteScalar`, `SALD.gronwallIntervalIntegralAdditivityScalar`, `SALD.gronwallExpProductRewriteIntervalIntegral`, `SALD.gronwallExpProductRewriteIntegralCongr`, `SALD.gronwallExponentRewriteObligation` | scalar algebra, adjacent-interval bridge, and outer-integral congruence build; theorem-specific adjacent interval-integrability remains |

Middle lower packet:

- target exactly `SALD.forwardKlGronwallSideConditionContract` /
  `SALD.forwardKlGronwallSideConditionObligation` /
  `sald.forward_kl.gronwall_side_conditions`;
- preferred sub-slice: bridge interval-integral additivity/orientation to the
  cycle-17 scalar helpers for the reusable exponent split, while leaving
  theorem-specific interval-integrability and residual-exponent monotonicity as
  separate obligations;
- do not modify the DV finite-log-mgf witness, LSI density-test interface,
  KL-derivative backend, schedule endpoint identities, or theorem display;
- do not mark endpoint rewrites, coefficient regularity, residual exponent
  drop, DV, LSI-to-KL/FI, KL derivative, schedule, or full Gronwall
  formalized without a compiled Lean proof.

## Cycle 18 Lower Adjacent-Interval Bridge

Lean increment:

- `SALD.gronwallIntervalIntegralAdditivityScalar` packages
  `intervalIntegral.integral_add_adjacent_intervals` as the scalar equality
  `int_0^t1 a = int_0^t a + int_t^t1 a` under adjacent
  `IntervalIntegrable` hypotheses.
- `SALD.gronwallExpProductRewriteIntervalIntegral` feeds that equality into
  `SALD.gronwallExpProductRewriteScalar` to prove the pointwise factor
  `exp(-int_0^t1 a)*exp(int_0^t a)=exp(-int_t^t1 a)`.
- `SALD.gronwallExpProductRewriteIntegralCongr` applies
  `intervalIntegral.integral_congr` to push the pointwise rewrite through the
  source `b_t` integral, assuming adjacent interval-integrability for each
  `t` in the source interval.

Two-way status:

- source step `appendix.tex:63-69` now has a compiled interval-to-scalar bridge
  for the pointwise Gronwall exponent factor and a compiled congruence wrapper
  for the outer `b_t` integral;
- `thm:forward-KL` still needs theorem-specific interval-integrability for its
  coefficient `a(t)`, endpoint schedule rewrites, coefficient regularity for
  `b(t)`, and the residual LSI exponent drop;
- no DV, LSI-to-KL/FI, KL derivative, moving-target, schedule, or full
  Gronwall backend is promoted.

## Cycle 19 Discrete Accumulated-Error Upper Packet

Objective: keep `thm:forward-KL-discrete` fixed and assign the accumulated
error bridge as the next lower target.  The compiled packet is
`SALD.cycle19DiscreteForwardKlUpperPacket`.

Source dependency audit:

| Source window | Lean-facing target | Classification |
|---|---|---|
| `appendix.tex:526-553` time-change inequality with `Gamma` and `Delta` | `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation` | external-cited Gronwall plus coefficient regularity obligations |
| `appendix.tex:557-590` Gronwall output | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `sald.discrete_forward_kl.accumulated_error_bridge` | internal paper step with local real/integral algebra gaps |
| `main_body.tex:299-323` linear slowdown theorem display | `SALD.discreteForwardKlLinearSlowdownObligation`; `SALD.discreteForwardKlResidualExponentBoundObligation` | internal paper specialization plus source-contract gaps for endpoint stitching and monotonicity |

Lower packet:

- target exactly `SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
  `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
  `sald.discrete_forward_kl.accumulated_error_bridge`;
- preferred first sub-slice:
  `SALD.discreteForwardKlResidualExponentBoundObligation`;
- preserve the source `a(t)`, `b(t)`, endpoint rewrites, and constants
  `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
  `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`;
- keep EM endpoint/stitching, Gronwall, residual-exponent monotonicity, and
  integral identifications as obligations rather than theorem assumptions.

Reviewer checklist: confirm `SALD.discreteForwardKlProofDag` includes
`ASTIS.SALD.forward_KL_discrete.cycle19_upper_packet`, source-index refresh
keeps `sald_version_2.tex` excluded, and no analytic backend is promoted.

## Cycle 19 Discrete Accumulated-Error Middle Packet

Middle re-read the cycle focus at `appendix.tex:557-590` and
`main_body.tex:299-323`.  The new compiled map is
`SALD.cycle19DiscreteForwardKlMiddleContract`, with the companion obligation
`SALD.cycle19DiscreteForwardKlAccumulatedErrorMiddleObligation`.

Lower-ready source map:

| Source step | Lean-facing target | Current blocker |
|---|---|---|
| `appendix.tex:557-571` applies Gronwall to the initial-error term with source `a(t)`. | `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation` | Gronwall remains a local real-analysis obligation with stitched EM regularity. |
| `appendix.tex:573-589` keeps the residual integral with the same exponent kernel and source `b(t)`. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `sald.discrete_forward_kl.accumulated_error_bridge` | residual exponent monotonicity and coefficient integrability are still obligations. |
| `main_body.tex:299-323` specializes to `t(s)=s/r`. | `SALD.discreteForwardKlLinearSlowdownObligation` | `dot{s}=r`, `dot{s}^{-1}=1/r`, and endpoint rewrites must be supplied by local schedule/EM stitching interfaces. |
| residual exponent is bounded by the common positive factor. | `SALD.discreteForwardKlResidualExponentBoundObligation`; `sald.discrete_forward_kl.residual_exponent_bound`; `SALD.discreteForwardKlResidualExponentBoundScalar`; `SALD.discreteForwardKlResidualExpBoundScalar` | scalar order and `Real.exp` monotonicity core is compiled; still need `C_LSI(t)>=0`, `alpha>0`, `alpha'>0`, `r>=1`, and interval-integral monotonicity for the full `barGamma` bound. |
| residual integral collects to `(1/r)*A_alpha(pi,v)+2*r*eta*barDelta_{alpha'}`. | `SALD.discreteForwardKlAccumulatedErrorBridgeObligation` | identify the source full-interval integrals without changing `Gamma`, `Delta`, `barGamma`, or `barDelta`. |

Lower packet:

- target exactly `SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
  `SALD.discreteForwardKlAccumulatedErrorBridgeObligation`;
- first scalar sub-slice is
  `SALD.discreteForwardKlResidualExponentBoundObligation`;
- keep EM endpoint laws, stitched-interval regularity, frozen defect, DV, LSI,
  and Gronwall as separate dependencies;
- do not change the theorem display or promote any analytic backend.

## Cycle 19 Discrete Accumulated-Error Lower Packet

Lower narrowed the first scalar sub-slice of
`sald.discrete_forward_kl.residual_exponent_bound`.  The compiled Lean facts
are:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| residual exponent scalar order | From `0 <= lsiTerm`, `alphaTerm <= alphaBound`, and `gammaTerm <= gammaBound`, derive `-(lsiTerm-alphaTerm-gammaTerm) <= alphaBound+gammaBound`. | local Real linear arithmetic; theorem-specific interval bounds remain separate. | `SALD.discreteForwardKlResidualExponentBoundScalar` | `appendix.tex:557`; theorem display `main_body.tex:309` | `sald.discrete_forward_kl.residual_exponent_bound`, accumulated-error bridge | formalized scalar core |
| residual exponent exponential monotonicity | Pass the scalar exponent inequality through monotonicity of `Real.exp`. | `SALD.discreteForwardKlResidualExponentBoundScalar`, `Real.exp_le_exp`. | `SALD.discreteForwardKlResidualExpBoundScalar` | `appendix.tex:573`; theorem display `main_body.tex:309` | residual integral bound in `sald.discrete_forward_kl.accumulated_error_bridge` | formalized scalar core |

Open pieces remain exactly the source-contract gaps already listed: interval
integrability, nonnegativity of the LSI integral, positivity of coefficients,
full-interval `barGamma` identification, endpoint stitching, and the final
`A_alpha`/`barDelta` collection.

## Cycle 20 Guided/General Upper Packet

Objective: return to the guided/general VA-SALD path and make the next lower
task the discrete general theorem's final Gronwall side-condition/display
bridge.  The compiled workflow packet is
`SALD.cycle20GeneralVaSaldUpperPacket`.

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| cycle-20 upper packet | Select only the final discrete general Gronwall/display bridge as the lower target; keep continuous general VA-SALD and unified VA-SALD as fixed upstream dependencies. | `thm:general-moving-target-SALD`, `thm:unified-forward-KL`, `eq:SALD_general_EM`, `lem:frozen_delta_cross_lip`, `lem:gronwall` | `SALD.cycle20GeneralVaSaldUpperPacket`; DAG block `ASTIS.SALD.general_moving_target_discrete.cycle20_upper_packet` | `appendix.tex:1313-1603`; supporting anchors `appendix.tex:724-951`, `main_body.tex:359-395` | `thm:general-moving-target-SALD-discrete`, discrete VA-SALD guided specialization | workflow obligation |
| discrete general Gronwall side conditions | Stitch endpoint laws into `K(t)`, rewrite constant-schedule coefficients, prove coefficient regularity, and match Gronwall output to the theorem display. | `sald.general_moving_target_discrete.gronwall_application`, `sald.general_moving_target_discrete.constant_schedule_stitching`, `sald.general_moving_target_discrete.kl_derivative`, `sald.gronwall.integrating_factor` | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` | `appendix.tex:1573-1600`; theorem display `appendix.tex:1316-1347` | `thm:general-moving-target-SALD-discrete`, discrete VA-SALD guided specialization | obligation |

Lower packet:

- target exactly `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`
  / `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation`;
- refine one sub-slice only: endpoint stitching, constant-schedule coefficient
  rewrites, coefficient regularity, or exact theorem-display matching;
- preserve the differential inequality at `appendix.tex:1586-1597` and the
  theorem display at `appendix.tex:1316-1347`;
- keep frozen-delta, residual DV, LSI-to-KL/FI, KL derivative, and full
  Gronwall as separate obligations.

## Cycle 20 Guided/General Middle Packet

Middle translated the upper-selected discrete general Gronwall/display bridge
into `SALD.cycle20GeneralVaSaldMiddleContract` and
`SALD.cycle20GeneralVaSaldDiscreteGronwallMiddleObligation`.  This packet is a
source-to-Lean map only; it keeps `thm:general-moving-target-SALD-discrete`
contract-only and does not promote Gronwall, endpoint stitching, schedule
algebra, DV, LSI, or the KL derivative.

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| cycle-20 middle Gronwall bridge | Classify `appendix.tex:1573-1600` against the theorem display: stitched `K(t)`, `dK/dt=dot{s}(t)dK/ds`, constant-schedule coefficient rewrite, coefficient regularity, and exact display matching. | `SALD.cycle20GeneralVaSaldUpperPacket`, `SALD.generalMovingTargetDiscreteGronwallInstantiationContract`, `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`, `sald.general_moving_target_discrete.gronwall_application`, `sald.general_moving_target_discrete.constant_schedule_stitching` | `SALD.cycle20GeneralVaSaldMiddleContract`; `SALD.cycle20GeneralVaSaldDiscreteGronwallMiddleObligation`; DAG block `ASTIS.SALD.general_moving_target_discrete.cycle20_middle_gronwall_bridge` | `appendix.tex:1573-1600`; theorem display `appendix.tex:1316-1347` | `thm:general-moving-target-SALD-discrete`, cycle 20 lower packet | workflow obligation |

Source-to-Lean map:

- `appendix.tex:1573-1576` defines
  `K(t)=KL(hat rho_{s(t)}||pi_t)=KL(hat rho_{s(t)}||tilde pi_{s(t)})`;
- `appendix.tex:1579-1583` changes derivatives and uses
  `dot t(s(t))=dot{s}(t)^(-1)`;
- `appendix.tex:1586-1597` rewrites the residual coefficient to
  `2*sigma_eta(t)^(-2)*dot{s}(t)^(-1)` and the frozen terms to
  `2*dot{s}(t)*eta^2*alpha'^(-1)*Gamma(t)` and
  `2*dot{s}(t)*eta*Delta(t)`;
- `appendix.tex:1600` invokes `lem:gronwall`; stitched regularity,
  coefficient integrability, endpoint identification, and display matching
  remain obligations.

Lower packet:

- target exactly `sald.general_moving_target_discrete.gronwall_side_conditions`;
- preferred first sub-slice: constant-schedule coefficient rewrite from
  `appendix.tex:1579-1597`;
- alternatives are endpoint stitching, coefficient regularity, or exact
  display matching, but only one sub-slice should be handled at a time;
- do not reopen EM interpolation, frozen-delta, residual DV, LSI-to-KL/FI,
  KL derivative, or full Gronwall proof search in the same lower attempt.

Lower cycle 20 refinement:

| Source coefficient step | Lean-facing item | Status |
|---|---|---|
| `dot{s}(t)*dot t(s(t))^2 = dot{s}(t)^(-1)` after the inverse-schedule identity | `SALD.generalMovingTargetDiscreteConstantScheduleSquareScalar` | formalized scalar core |
| residual coefficient `dot{s}(t)*(2*sigma_eta^{-2}*dot t(s(t))^2*alpha^{-1})` | `SALD.generalMovingTargetDiscreteResidualCoefficientRewriteScalar` | formalized scalar core |
| frozen `Gamma` multiplier after the `s`-to-`t` time change | `SALD.generalMovingTargetDiscreteGammaCoefficientRewriteScalar` | formalized scalar core |
| frozen `Delta` multiplier after the `s`-to-`t` time change | `SALD.generalMovingTargetDiscreteDeltaCoefficientRewriteScalar` | formalized scalar core |

These lemmas close only real algebra once `dot t(s(t))=dot{s}(t)^(-1)` and
`dot{s}(t) != 0` are supplied.  The inverse-function theorem, endpoint
stitching, coefficient integrability, Gronwall application, and theorem-display
matching remain obligations under
`sald.general_moving_target_discrete.gronwall_side_conditions`.

## Cycle 21 First Appendix Upper Packet

Objective: rebaseline the source-index and first appendix/vocabulary layer
after the cycle-20 discrete general VA-SALD scalar coefficient work.  The
compiled upper packet is `SALD.cycle21FirstAppendixVocabularyPacket`.

Mode discipline:

- `faithfulPaper`; use only the original `appendix.tex:47-94`,
  `appendix.tex:96-151`, and `main_body.tex:202-215`, with
  `sald_version_2.tex` excluded;
- preserve the source Gronwall signs and endpoint display, the DV
  finite-log-mgf variational formula, the PI constant convention
  `C_PI^{-1}`, and the LSI-to-KL/FI coefficient `1/(2*C_LSI)`;
- keep this as Phase 1 transcript and proof-obligation refinement:
  Gronwall and LSI-to-KL/FI remain obligations, DV remains source-cited plus
  instantiation obligations, and PI remains contract-only with a separate
  velocity-norm backend.

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| cycle-21 upper first appendix packet | Select the first-layer source-index/vocabulary packet as the next lower target; require two-way Lean/Markdown/TeX synchronization and leave theorem statements fixed. | `SALD.cycle13FirstAppendixSourceIndexAuditContract`, `SALD.cycle17FirstAppendixVocabularyPacket`, `SALD.saldFirstProofDag`, `sald.first_appendix.source_index_audit`, `sald.first_appendix.middle_source_to_lean_map` | `SALD.cycle21FirstAppendixVocabularyPacket` | `appendix.tex:47-94`, `appendix.tex:96-151`, `main_body.tex:202-215` | first proof DAG, forward-KL and VA-SALD theorem dependencies | workflow obligation |
| preferred lower slice | Refine the local Gronwall exponent/endpoint calculus obligations without proving the full Gronwall theorem. | `SALD.saldGronwallEndpointCalculusContract`, `SALD.saldGronwallExponentRewriteContract`, `SALD.gronwallNegIntegralRewriteScalar`, `SALD.gronwallExpProductRewriteScalar`, `SALD.gronwallIntervalIntegralAdditivityScalar`, `SALD.gronwallExpProductRewriteIntervalIntegral`, `SALD.gronwallExpProductRewriteIntegralCongr` | `sald.gronwall.exponent_rewrite` | `appendix.tex:63-69` | `lem:gronwall`, later theorem Gronwall applications | obligation |

Lower packet:

- target exactly one first-layer interface;
- preferred target is `SALD.saldGronwallEndpointCalculusContract` /
  `SALD.saldGronwallExponentRewriteContract` /
  `sald.gronwall.exponent_rewrite`, because the scalar exponent helpers and
  congruence wrapper are compiled while theorem-specific adjacent
  interval-integrability remains open;
- alternatives are `SALD.saldDvFiniteLogMgfContract`,
  `SALD.saldPiVelocityNormDependencyContract`, and
  `SALD.saldLsiKlFiDensityTestContract`;
- if blocked, record the precise source-contract gap instead of changing
  theorem statements or promoting a cited result.

Reviewer checklist:

- `python3 tools/astis.py source-index ASTIS-SALD-001` indexes the four focus
  labels and still excludes `sald_version_2.tex`;
- `SALD.saldFirstProofDag` reports Gronwall `obligation`, DV `sourceCited`,
  PI `contractOnly`, and LSI/KL/FI `obligation`;
- conversion window, proof-obligation ledger, source-index, and SLT audit all
  classify cycle 21 as synchronization/obligation refinement, not analytic
  proof closure;
- `python3 tools/astis.py check` passes.

## Cycle 21 Middle Source-To-Lean Map

Middle reread the exact focus windows and added the compiled workflow contract
`SALD.cycle21FirstAppendixMiddleAuditContract`.  This is a transcript and
lower-packet refinement only; no theorem statement or analytic proof status was
changed.

| Source step | Lean-facing map | Classification | Lower handoff |
|---|---|---|---|
| `appendix.tex:47-71` `lem:gronwall`: continuous `a_t,b_t`, differentiable `K_t`, integrating factor, integration, and final exponent rewrite. | `SALD.saldGronwallCandidateContract`, `SALD.saldGronwallEndpointCalculusContract`, `SALD.saldGronwallExponentRewriteContract`, `sald.gronwall.integrating_factor`, `sald.gronwall.endpoint_calculus`, `sald.gronwall.exponent_rewrite` | local real/interval-integral obligation; scalar exponent helpers already compiled only as substeps | preferred target: refine `SALD.saldGronwallExponentRewriteContract` / `sald.gronwall.exponent_rewrite` |
| `appendix.tex:73-79` `lem:dv_variation`: same-space probabilities and finite-log-mgf variational formula. | `SALD.dvContract`, `SALD.saldDvFiniteLogMgfContract`, `probability.dv_variational_formula`, `sald.dv_variation.finite_log_mgf_interface` | source-cited external result plus local instantiation obligation | alternative target only; do not mark DV formalized |
| `appendix.tex:86-151` `def:PI` and velocity-norm route. | `SALD.saldPIContract`, `SALD.piDefinitionContract`, `SALD.saldPiVelocityNormDependencyContract`, `sald.pi.velocity_norm_backend` | PI definition is contract-only; weighted Sobolev/Riesz backend remains local obligation | alternative target: refine one Sobolev/Riesz side condition |
| `main_body.tex:202-215` LSI, `eq:LSI-KL-FI`, KL/FI vocabulary. | `SALD.saldKLContract`, `SALD.saldFIContract`, `SALD.saldLSIContract`, `SALD.saldLsiKlFiBridgeContract`, `SALD.saldLsiKlFiDensityTestContract`, `sald.lsi_kl_fi.density_test_interface`, `probability.lsi_to_kl_fi` | local density-test obligation | alternative target: refine one density, admissibility, entropy, FI-chain, or coefficient side condition |

Cycle-21 lower packet:

- target exactly `SALD.saldGronwallExponentRewriteContract` /
  `sald.gronwall.exponent_rewrite` as the first lower slice;
- permitted refinements are endpoint-safe derivative/FTC assumptions, adjacent
  interval-integrability, or the remaining integral-congruence step in
  `appendix.tex:63-69`;
- keep the scalar Gronwall helpers as partial local algebra only, and keep DV
  source-cited, PI contract-only, and LSI/KL/FI as obligations;
- do not edit forward-KL, guided, general VA-SALD, or discrete theorem
  statements.

## Cycle 22 Continuous Forward-KL Upper Packet

Objective: keep `thm:forward-KL` fixed and return the next lower assignment to
the existing Gronwall side-condition obligation, narrowed to theorem-specific
coefficient regularity and adjacent interval-integrability.  The compiled
workflow packet is `SALD.cycle22ForwardKlUpperPacket`.

Source anchors:

- theorem statement and terminal display `main_body.tex:238-247`;
- LSI/time-change coefficient input `appendix.tex:210-228`;
- DV contribution to the scalar coefficient and residual term
  `appendix.tex:230-241`;
- final Gronwall output and theorem-display simplification
  `appendix.tex:244-252`;
- reusable first-appendix Gronwall exponent algebra `appendix.tex:63-69`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| cycle-22 upper forward-KL packet | Select only the theorem-specific regularity/integrability bridge for `sald.forward_kl.gronwall_side_conditions`. | `SALD.cycle18ForwardKlMiddleContract`, `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlDependencyChainAuditContract`, `SALD.gronwallExpProductRewriteIntegralCongr`, `SALD.forwardKlEndpointScheduleContract`, `lem:gronwall`, `lem:dv_variation`, `eq:LSI-KL-FI` | `SALD.cycle22ForwardKlUpperPacket` | `main_body.tex:243`, `appendix.tex:244`, `appendix.tex:63` | `thm:forward-KL` | workflow obligation |
| cycle-22 middle coefficient bridge | Translate the upper target into a lower-ready map for coefficient regularity and adjacent interval-integrability before using the compiled exponent congruence. | `SALD.cycle22ForwardKlUpperPacket`, `SALD.forwardKlGronwallSideConditionContract`, `SALD.forwardKlDependencyChainAuditContract`, `SALD.gronwallExpProductRewriteIntegralCongr`, `sald.forward_kl.dv_finite_log_mgf_witness`, `probability.lsi_to_kl_fi` | `SALD.cycle22ForwardKlMiddleContract` | `appendix.tex:210`, `appendix.tex:230`, `appendix.tex:244`, `appendix.tex:249` | `sald.forward_kl.gronwall_side_conditions`; `thm:forward-KL` | workflow obligation |
| coefficient regularity bridge | Expose continuity or interval-integrability for `dot{s}(t) C_LSI(t)`, `(1/2) dot{s}(t)^(-1) alpha^(-1)`, and `b(t)`; assemble `a(t)` from the first two pieces. | inverse-schedule regularity, LSI constant measurability, alpha positivity, alpha-complexity finite-mgf interface | `SALD.forwardKlGronwallSideConditionContract`; `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable`; `SALD.forwardKlGronwallSideConditionObligation` | `appendix.tex:244-248` | Gronwall application and exponent split | formalized sublemma plus remaining obligations |
| exponent-congruence use site | Apply compiled Gronwall exponent congruence only after adjacent interval-integrability/orientation hypotheses are present for the source coefficient pieces. | `SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces`, `SALD.gronwallExpProductRewriteIntegralCongr`, `SALD.gronwallExponentRewriteObligation` | `sald.forward_kl.gronwall_side_conditions` | `appendix.tex:249-250`; reusable source `appendix.tex:63-69` | theorem display | formalized sublemma plus remaining obligations |
| residual exponent drop | Record the internal paper step using `C_LSI(u)>=0`, `dot{s}(u)>0`, and interval-integral monotonicity. | `SALD.forwardKlDependencyChainAuditContract`, endpoint/schedule side conditions | `SALD.forwardKlGronwallSideConditionObligation` | `appendix.tex:248-252` | residual alpha-complexity integral | obligation |

Lower packet:

- target exactly `SALD.forwardKlGronwallSideConditionContract` /
  `SALD.forwardKlGronwallSideConditionObligation` /
  `sald.forward_kl.gronwall_side_conditions`;
- first lower sub-slice is coefficient regularity and adjacent
  interval-integrability for the source LSI and alpha pieces and `b(t)`;
  `a(t)` is now assembled from the two coefficient pieces by
  `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable`;
- keep endpoint rewrites, residual exponent monotonicity, DV finite-log-mgf,
  LSI density-test, KL derivative, and full Gronwall as separate obligations
  unless a compiled local proof is added.

Reviewer checklist:

- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle22ForwardKlUpperPacket` and
  `SALD.cycle22ForwardKlMiddleContract` while retaining cycle-14 and cycle-18
  packets;
- `SALD.forwardKlProofDag` routes
  `ASTIS.SALD.forward_KL.gronwall_side_conditions` through the cycle-22 upper
  and middle packets;
- source index still excludes `sald_version_2.tex`;
- no analytic backend is promoted beyond obligation/source-cited status.

## Cycle 22 Continuous Forward-KL Middle Packet

Compiled middle record: `SALD.cycle22ForwardKlMiddleContract`.  It keeps the
upper target narrow and lower-ready:

| Source step | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:210-217` supplies the LSI part `dot{s}(t) C_LSI(t)`. | `SALD.forwardKlDependencyChainAuditContract`; `probability.lsi_to_kl_fi` | density-test LSI backend and interval-integrability of the product |
| `appendix.tex:218-228` rewrites the time-change coefficient as `dot{s}(t)^(-1)`. | `sald.forward_kl.schedule_time_change`; `SALD.forwardKlEndpointScheduleContract` | inverse-schedule regularity and nonzero/positive derivative facts |
| `appendix.tex:230-241` supplies the alpha part of `a(t)` and `b(t)`. | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `SALD.forwardKlDvAlphaMonotonicityContract` | common-space, finite-log-mgf, measurability, and integrability of `E_alpha(pi_t,v_t)` |
| `appendix.tex:244-250` applies Gronwall and splits the exponent. | `SALD.forwardKlGronwallSideConditionContract`; `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable`; `SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces` | adjacent interval-integrability of the LSI and alpha pieces; endpoint and residual-drop obligations remain separate |
| `appendix.tex:248-252` removes the LSI contribution from the residual exponent. | `SALD.forwardKlGronwallSideConditionObligation` | sign facts plus interval-integral monotonicity |

Lower packet: prove or refine only the theorem-specific coefficient
regularity and adjacent interval-integrability needed for
`dot{s}(t) C_LSI(t)`, `(1/2) dot{s}(t)^(-1) alpha^(-1)`, and `b(t)`.
The assembled `a(t)` interval-integrability and the exponent congruence now
compile as `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable` and
`SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces` under those
piece hypotheses.  Endpoint rewrites, residual exponent monotonicity, DV,
LSI-to-KL/FI, KL derivative, and full Gronwall remain separate obligations
unless a compiled proof is added.

## Cycle 22 Lower Coefficient-Piece Bridge

Lean increment:

| Compiled lemma | Role | Remaining source obligation |
|---|---|---|
| `SALD.forwardKlGronwallCoeffIntervalIntegrable` | packages `IntervalIntegrable.sub` for `a=lsiPart-alphaPart` on one interval | actual regularity of the source LSI and alpha pieces |
| `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable` | supplies adjacent `[0,t]` and `[t,T]` interval-integrability for assembled `a(t)` from piece hypotheses | prove or record those piece hypotheses for every `t` in the source interval |
| `SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces` | applies the existing outer-integral Gronwall congruence to the assembled coefficient | `b(t)` regularity for the Gronwall call, endpoint rewrites, and residual-exponent monotonicity |

Two-way status:

- the source coefficient `a(t)=dot{s}(t) C_LSI(t)-(1/2) dot{s}(t)^(-1) alpha^(-1)`
  now has a compiled interval-integrability assembly lemma once the two source
  pieces are available;
- no theorem statement, source coefficient, endpoint identity, DV/LSI/KL
  backend, residual exponent drop, or full Gronwall proof is promoted.

## Obligations

- Formal KL/FI/LSI backend in Mathlib-compatible Lean.
- Formal PI/variance/weighted-Sobolev backend for `def:PI` and the velocity norm bound.
- Real Gronwall proof for the exact appendix sign convention and integral expression, including the endpoint-calculus side conditions now isolated in `SALD.saldGronwallEndpointCalculusContract` and the final exponent rewrite isolated in `SALD.saldGronwallExponentRewriteContract`.
- DV variational formula port or cited-result interface.
- Cycle 13 first appendix source-index audit:
  `SALD.cycle13FirstAppendixVocabularyPacket`,
  `SALD.cycle13FirstAppendixSourceIndexAuditContract`, and
  `SALD.firstAppendixSourceIndexAuditObligation` keep the source index,
  first-DAG labels, and Lean-facing contracts synchronized without changing
  analytic proof statuses.
- Cycle 17 first appendix source-index upper packet:
  `SALD.cycle17FirstAppendixVocabularyPacket` returns to the same four
  first-layer labels after the cycle-16 transport work, requires two-way
  Lean/Markdown/TeX synchronization, and selects source-index/contract
  rebaselining before any new analytic proof search.
- Cycle 17 first appendix middle source-to-Lean rebaseline:
  `SALD.cycle17FirstAppendixMiddleAuditContract` and
  `SALD.firstAppendixMiddleAuditObligation` map the same four source windows
  to existing contracts and select `sald.gronwall.exponent_rewrite` as the
  lower target, with no status promotion.
- Cycle 21 first appendix upper packet:
  `SALD.cycle21FirstAppendixVocabularyPacket` returns the next lower target to
  the first-layer source-index/vocabulary packet after cycle 20, requires
  two-way Lean/Markdown/TeX synchronization, and keeps Gronwall, DV, PI, and
  LSI/KL/FI at their existing non-formalized statuses.
- Cycle 13 first appendix middle source-to-Lean map:
  `SALD.cycle13FirstAppendixMiddleAuditContract` and
  `SALD.firstAppendixMiddleAuditObligation` classify each focus proof step as
  a Lean contract, cited result, or named obligation and provide a lower-ready
  target without changing theorem statements.
- Cycle 14 continuous forward-KL upper packet:
  `SALD.cycle14ForwardKlUpperPacket` selects the moving-target side-condition
  interface as the next lower objective, while keeping `thm:forward-KL`, the
  appendix route derivative -> LSI -> DV -> Gronwall, and all source
  coefficients unchanged.
- Cycle 14 continuous forward-KL middle source-to-Lean map:
  `SALD.cycle14ForwardKlMiddleContract` and
  `SALD.forwardKlMiddleSourceToLeanMapObligation` classify each focused
  source proof step and select endpoint schedule identities as the preferred
  lower slice.
- Cycle 14 continuous forward-KL endpoint schedule lower slice:
  `SALD.forwardKlEndpointScheduleContract` and
  `SALD.forwardKlEndpointScheduleObligation` isolate `s(0)=0`, `S=s(T)`,
  `t(s(T))=T`, `tilde_pi_{s(t)}=pi_t`, and the `K(0)`/`K(T)` endpoint
  rewrites without changing the theorem statement.
- Cycle 18 continuous forward-KL upper packet:
  `SALD.cycle18ForwardKlUpperPacket` selects
  `SALD.forwardKlGronwallSideConditionContract` /
  `sald.forward_kl.gronwall_side_conditions` as the next lower target, with
  cycle-17 scalar Gronwall helpers treated as partial local algebra only.
- Cycle 18 continuous forward-KL middle packet:
  `SALD.cycle18ForwardKlMiddleContract` maps `appendix.tex:244-252` and the
  supporting DV/LSI/Gronwall dependencies to `sald.forward_kl.gronwall_side_conditions`,
  selecting the interval-integral-to-scalar-helper bridge as the preferred
  lower sub-slice while preserving all analytic statuses.
- Cycle 22 continuous forward-KL upper packet:
  `SALD.cycle22ForwardKlUpperPacket` keeps the lower target at
  `sald.forward_kl.gronwall_side_conditions`, narrowed to theorem-specific
  coefficient regularity and adjacent interval-integrability needed before the
  compiled Gronwall congruence can be used in the theorem display.
- Cycle 22 continuous forward-KL middle packet:
  `SALD.cycle22ForwardKlMiddleContract` maps `appendix.tex:210-252` to the
  same lower target, selecting regularity/integrability for `a(t)`, its LSI
  and alpha pieces, and `b(t)` before applying
  `SALD.gronwallExpProductRewriteIntegralCongr`.
- Cycle 26 continuous forward-KL upper packet:
  `SALD.cycle26ForwardKlUpperPacket` returns to the theorem-specific DV
  witness for `Z=alpha*||v_t||^2`, selecting
  `sald.forward_kl.dv_finite_log_mgf_witness` as the lower target while the
  cycle-22 Gronwall coefficient work stays a downstream dependency.
- Cycle 30 continuous forward-KL upper packet:
  `SALD.cycle30ForwardKlUpperPacket` returns to the derivative-side source
  window `appendix.tex:168-228`, selecting
  `SALD.forwardKlDerivativeSideConditionContract` /
  `sald.forward_kl.density_boundary_regular` as the first lower target while
  keeping time change, LSI, DV, and Gronwall as separate obligations.
- Fokker--Planck differentiation identities.
- Theorem-level moving-target dependency-chain and coefficient-chain audit
  obligations for continuous forward-KL.
- Theorem-specific forward-KL derivative, DV-energy, and Gronwall-instantiation obligations in `AutoSamplingTheory/SALD.lean`.
- Theorem-specific DV finite-log-mgf witness for continuous forward-KL:
  common-space, absolute-continuity, measurability, alpha0-to-alpha
  monotonicity, and positive-alpha scaling before the velocity-energy bound.
- Theorem-specific alpha0-to-alpha exponential-moment monotonicity for the
  continuous forward-KL DV test `Z_t=alpha*||v_t||^2`, tracked by
  `SALD.forwardKlDvAlphaMonotonicityContract`.
- Density/boundary regularity and inverse-schedule time-change obligations for
  the forward-KL derivative block.
- Euler--Maruyama frozen interpolation Fokker--Planck equation, conditional
  frozen drift, endpoint laws, stitched interval regularity, and local defect
  bounds.
- Discrete forward-KL one-step defect, EM-interpolation DV finite-log-mgf
  witness, DV velocity-energy reuse, and Gronwall accumulation obligations in
  `AutoSamplingTheory/SALD.lean`.
- Cycle 15 discrete forward-KL upper packet:
  `SALD.cycle15DiscreteForwardKlUpperPacket` selects
  `sald.discrete_forward_kl.em_conditional_fokker_planck` as the next lower
  slice while keeping endpoint laws, stitched regularity, one-step defects, DV,
  and accumulated-error collection as separate obligations.
- Cycle 15 conditional Fokker--Planck lower packet:
  `SALD.cycle15DiscreteForwardKlEmConditionalFpLowerContract` gives the
  line-level ledger for `appendix.tex:347-385` and keeps the first lower target
  narrower than the derivative, Gronwall, or accumulated-error blocks.
- Cycle 15 conditional drift density sub-obligation:
  `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract` and
  `SALD.cycle15DiscreteForwardKlConditionalDriftDensityObligation` isolate the
  regular conditional-law, density, measurability, and integrability input for
  `bar b_{k,s}` before the Fokker--Planck identity is attempted.
- Linear-slowdown specialization from the appendix general-schedule Gronwall
  display to the theorem constants in `main_body.tex:309-323`.
- Discrete forward-KL residual exponent bound after linear slowdown, separated
  as `SALD.discreteForwardKlResidualExponentBoundObligation`.
- Discrete accumulated-error endpoint/exponent bridge from the appendix
  Gronwall output to the main-body `\bar\Gamma` and
  `\bar\Delta_{\alpha'}` theorem display.
- Cycle 19 discrete forward-KL accumulated-error upper packet:
  `SALD.cycle19DiscreteForwardKlUpperPacket` selects
  `sald.discrete_forward_kl.accumulated_error_bridge` as the next lower
  target, with `sald.discrete_forward_kl.residual_exponent_bound` as the first
  scalar sub-slice and no changes to the theorem constants.
- Discrete forward-KL coefficient-chain audit tying one-step `Gamma`/`Delta`
  defects, stitched EM endpoint side conditions, and scalar exponent
  monotonicity facts to the accumulated `barGamma` and `barDelta` theorem
  constants.
- Guided-path normalizer derivative, centered residual identity, and mean-zero
  residual obligations.
- Cycle 16 unified VA-SALD transport bridge:
  `SALD.cycle16GeneralVaSaldUpperPacket` selects
  `SALD.unifiedForwardKlTransportBridgeObligation` /
  `sald.unified_forward_kl.transport_velocity_bridge` as the next lower target,
  with source algebra from `main_body.tex:359-368` and the specialization line
  `appendix.tex:949-951`.
- Cycle 16 unified VA-SALD transport bridge middle map:
  `SALD.cycle16UnifiedForwardKlTransportBridgeMiddleContract` and
  `SALD.cycle16UnifiedForwardKlTransportBridgeMiddleObligation` classify the
  exact residual/correction cancellation and keep correction-field existence,
  weak divergence regularity, DV, Gronwall, and discrete EM work outside the
  lower slice.
- Cycle 16 unified VA-SALD transport bridge lower slice:
  `SALD.cycle16UnifiedForwardKlTransportBridgeLowerContract` and
  `SALD.cycle16UnifiedForwardKlTransportBridgeLowerObligation` isolate the
  signed cancellation, divergence-linearity rewrite, and
  `v_t=u_t+w_t`, `c_t=u_t`, `m_t=w_t` handoff inside
  `sald.unified_forward_kl.transport_velocity_bridge`.
- Continuous general VA-SALD KL derivative, residual DV-energy, sigma-weighted
  Gronwall, endpoint/exponent side-condition, pure-contraction, and
  unified-specialization obligations, including the correction-field transport
  bridge from `eq:poisson-eq` to `m_t=w_t`.
- Continuous general VA-SALD residual DV finite-log-mgf witness:
  alpha0-to-alpha monotonicity for `m_t`, common-space/absolute-continuity,
  measurability, and positive-alpha scaling before the residual-energy bound.
- Continuous general VA-SALD residual DV positive-alpha scaling, tracked by
  `SALD.generalMovingTargetDvPositiveAlphaScalingObligation`, for the division
  by `alpha>0`, the `E_alpha(pi_t,m_t)` rewrite, and the unchanged
  sigma-weighted coefficient.
- Discrete general VA-SALD EM interpolation, frozen-delta, residual
  DV-energy, constant-schedule stitching, Gronwall, and guided-specialization
  obligations.
- Discrete general VA-SALD residual DV finite-log-mgf witness under the EM
  interpolation law, preserving the doubled residual coefficient before time
  change.
- Discrete general VA-SALD derivative side-condition interface for endpoint
  laws, conditional drift, Fokker--Planck split, frozen/residual algebra,
  exact Young coefficients, DV finite-log-mgf, and stitched time change.
- Discrete general VA-SALD Gronwall side-condition interface for endpoint
  stitching, constant-schedule coefficient rewrites, coefficient regularity,
  and exact theorem-display matching.
- Cycle 20 guided/general upper packet:
  `SALD.cycle20GeneralVaSaldUpperPacket` selects
  `sald.general_moving_target_discrete.gronwall_side_conditions` as the only
  lower target, with theorem statements and coefficients unchanged.
- Cycle 20 guided/general middle packet:
  `SALD.cycle20GeneralVaSaldMiddleContract` and
  `SALD.cycle20GeneralVaSaldDiscreteGronwallMiddleObligation` map
  `appendix.tex:1573-1600` to the existing discrete general Gronwall
  side-condition obligation and select the constant-schedule coefficient
  rewrite as the preferred first lower sub-slice.
- Cycle 24 guided/general upper packet:
  `SALD.cycle24GeneralVaSaldUpperPacket` returns to the continuous general
  moving-target theorem and selects
  `sald.general_moving_target.gronwall_side_conditions` as the only lower
  target, with theorem statements, unified specialization, and discrete
  cycle-20 coefficients unchanged.
- Cycle 28 guided/general upper packet:
  `SALD.cycle28GeneralVaSaldUpperPacket` returns to the discrete general
  pre-Gronwall derivative route and selects
  `sald.general_moving_target_discrete.derivative_side_conditions` as the only
  lower target, with the preferred sub-slice
  `appendix.tex:1469-1511` for frozen/residual algebra and the two
  `sigma_eta^2/8` Young splits.
- VP dissipativity and moment bounds from `iteration_complexity.tex`.

## Cycle 24 Upper Packet

Objective: return to the guided/general VA-SALD path and select the continuous
general moving-target Gronwall endpoint/exponent bridge as the next lower
target.  This is a source-to-Lean transcript packet, not a proof of
`thm:general-moving-target-SALD` or `thm:unified-forward-KL`.

Source anchors:

- theorem display: `appendix.tex:727-743`;
- Gronwall output: `appendix.tex:909-934`;
- pure-contraction clause: `appendix.tex:936-945`;
- unified specialization: `main_body.tex:359-395` and
  `appendix.tex:949-951`;
- downstream discrete reuse remains under `appendix.tex:1313-1603`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 24 continuous general upper packet | Select the final continuous general Gronwall endpoint/exponent/pure-contraction side-condition bridge as the lower target. | `lem:gronwall`; `lem:dv_variation`; `eq:LSI-KL-FI`; `def:alpha-complexity`; `SALD.generalMovingTargetGronwallSideConditionContract` | `SALD.cycle24GeneralVaSaldUpperPacket`; `ASTIS.SALD.general_moving_target.cycle24_upper_packet` | `appendix.tex:724-951`; `main_body.tex:359-395` | `thm:general-moving-target-SALD`; `thm:unified-forward-KL`; cycle 24 lower packet | obligation |
| Cycle 24 middle Gronwall bridge | Classify `appendix.tex:909-945` against theorem display `appendix.tex:727-743`: endpoint rewrites, coefficient regularity, exponent split, residual-exponent drop, and zero-residual alpha-complexity. | `SALD.cycle24GeneralVaSaldUpperPacket`; `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_application`; `sald.forward_kl.schedule_time_change` | `SALD.cycle24GeneralVaSaldMiddleContract`; `SALD.cycle24GeneralVaSaldGronwallMiddleObligation`; `ASTIS.SALD.general_moving_target.cycle24_middle_gronwall_bridge` | `appendix.tex:909-945`; theorem display `appendix.tex:727-743` | `thm:general-moving-target-SALD`; `thm:unified-forward-KL`; cycle 24 lower packet | workflow obligation |
| General Gronwall side conditions | Expose `K(0)`/`K(T)` endpoint rewrites, sigma-weighted coefficient regularity, exponent splitting, residual-exponent sign facts, and zero-residual alpha-complexity. | `SALD.cycle24GeneralVaSaldUpperPacket`; `SALD.cycle24GeneralVaSaldMiddleContract`; `sald.general_moving_target.cycle24_gronwall_middle`; `sald.general_moving_target.gronwall_application`; `sald.general_moving_target.dv_m_energy`; `sald.forward_kl.schedule_time_change`; `sald.gronwall.integrating_factor` | `SALD.generalMovingTargetGronwallSideConditionContract`; `SALD.generalMovingTargetGronwallSideConditionObligation`; `sald.general_moving_target.gronwall_side_conditions` | `appendix.tex:909-945`; theorem display `appendix.tex:727-743` | `thm:general-moving-target-SALD`; `thm:unified-forward-KL` | obligation |
| Unified specialization reuse | Keep `thm:unified-forward-KL` as the source specialization `c_t<-u_t`, with `v_t=u_t+w_t` and `m_t=w_t` only after the correction-field transport bridge. | `prop:guided_path_residual`; `eq:poisson-eq`; `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.transport_velocity_bridge`; continuous general side conditions | `SALD.unifiedForwardKlSpecializationObligation`; `SALD.unifiedForwardKlTransportBridgeObligation` | `main_body.tex:359-395`; `appendix.tex:949-951` | `thm:unified-forward-KL` | obligation |

Mode discipline:

- `faithfulPaper`; use the original `appendix.tex` and `main_body.tex`
  windows above, with `sald_version_2.tex` excluded.
- Preserve
  `a(t)=(sigma_t^2/2)*dot{s}(t)*C_LSI(t)-sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)`
  and
  `b(t)=sigma_t^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)`.
- Keep DV, LSI-to-KL/FI, KL derivative, endpoint schedule, coefficient
  regularity, residual-exponent monotonicity, pure-contraction
  alpha-complexity, and full Gronwall as obligations unless a narrower Lean
  proof builds locally.

Lower packet:

- target exactly `SALD.generalMovingTargetGronwallSideConditionContract` /
  `SALD.generalMovingTargetGronwallSideConditionObligation` /
  `sald.general_moving_target.gronwall_side_conditions`;
- cycle 24 middle has now classified `appendix.tex:909-945` against
  `appendix.tex:727-743`, separating endpoint rewrites, coefficient
  regularity, exponent splitting, residual-exponent drop, and zero-residual
  alpha-complexity;
- lower should take one sub-slice only; the preferred first target is
  theorem-specific coefficient regularity and adjacent interval-integrability
  for the LSI coefficient, alpha coefficient, and residual `b(t)` term.

Reviewer checklist:

- `SALD.generalVaSaldProofDag` contains
  `ASTIS.SALD.general_moving_target.cycle24_upper_packet` before
  `ASTIS.SALD.general_moving_target.gronwall_side_conditions`.
- `SALD.saldDependenciesForLabel "thm:general-moving-target-SALD"` and
  `"thm:unified-forward-KL"` include
  `SALD.cycle24GeneralVaSaldUpperPacket`.
- `SALD.generalMovingTargetGronwallSideConditionObligation` remains an
  obligation; no endpoint, coefficient, DV, LSI, pure-contraction, or Gronwall
  backend is promoted.
- The source index excludes `sald_version_2.tex`, and
  `python3 tools/astis.py check` passes.

## Cycle 24 Middle Source-To-Lean Map

Compiled refinement: `SALD.cycle24GeneralVaSaldMiddleContract` and
`SALD.cycle24GeneralVaSaldGronwallMiddleObligation`.

| Source step | Lean-facing map | Status |
|---|---|---|
| `appendix.tex:908-910` post-DV scalar inequality with source `a(t)` and `b(t)`. | `SALD.generalMovingTargetGronwallInstantiationContract`; `sald.general_moving_target.gronwall_application` | obligation |
| `appendix.tex:911-920` Gronwall output and endpoint rewrites. | `SALD.generalMovingTargetGronwallSideConditionContract.endpointScheduleIdentities`; `sald.forward_kl.schedule_time_change` | obligation |
| `appendix.tex:913-920` split `exp(-int_0^T a)` into the theorem's LSI and alpha factors. | `exponentSplitAlgebra`; reusable Gronwall exponent helpers after theorem-specific hypotheses | obligation |
| `appendix.tex:921-932` residual exponent drop. | `residualExponentBound`; interval-integral monotonicity and sign facts | obligation |
| `appendix.tex:936-945` pure-contraction clause. | `SALD.generalMovingTargetPureContractionObligation`; `pureContractionResidualZero` | obligation |

Lower packet:

- target exactly `SALD.generalMovingTargetGronwallSideConditionContract` /
  `SALD.generalMovingTargetGronwallSideConditionObligation` /
  `sald.general_moving_target.gronwall_side_conditions`;
- preferred first sub-slice: coefficient regularity and adjacent
  interval-integrability for
  `(sigma_t^2/2)*dot{s}(t)*C_LSI(t)`,
  `sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)`, and
  `b(t)=sigma_t^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)`;
- keep endpoint rewrites, residual exponent monotonicity, pure contraction,
  full Gronwall, DV, LSI-to-KL/FI, and KL derivative in their named
  obligations unless a compiled lower proof replaces one slice.

## Cycle 24 Lower Coefficient Slice

Compiled local declarations:

- `SALD.generalMovingTargetGronwallCoeffAdjacentIntervalIntegrable` packages
  the adjacent interval-integrability of
  `a(t)=lsiPart(t)-alphaPart(t)` from the source LSI and alpha pieces, and
  carries the residual `b(t)` interval-integrability hypotheses on `[0,t]`
  and `[t,T]`.
- `SALD.generalMovingTargetGronwallExpProductRewriteIntegralCongrOfPieces`
  applies the reusable Gronwall exponent congruence to the assembled
  sigma-weighted coefficient after those piecewise integrability hypotheses
  are supplied.

Source mapping:

| Source coefficient | Lean parameter | Remaining source obligation |
|---|---|---|
| `(sigma_t^2/2)*dot{s}(t)*C_LSI(t)` in `appendix.tex:908-920` | `lsiPart` | sigma regularity, inverse-schedule regularity, LSI constant measurability, and adjacent interval-integrability |
| `sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)` in `appendix.tex:908-920` | `alphaPart` | positivity/nonzero facts for sigma and `dot{s}`, fixed positive alpha, and adjacent interval-integrability |
| `b(t)=sigma_t^(-2)*dot{s}(t)^(-1)*E_alpha(pi_t,m_t)` in `appendix.tex:908-932` | `residualPart` | finite residual alpha-complexity, measurability, coefficient regularity, and adjacent interval-integrability |

Status:

- local `IntervalIntegrable.sub`/congruence packaging is compiled;
- theorem-specific coefficient regularity remains inside
  `SALD.generalMovingTargetGronwallSideConditionObligation`;
- endpoint rewrites, residual-exponent drop, pure contraction, full
  Gronwall, DV, LSI-to-KL/FI, and KL derivative are unchanged obligations.

## Cycle 25 First Appendix Upper Packet

Objective: rebaseline the source-index and first appendix/vocabulary layer
after the cycle-24 general VA-SALD coefficient work, and select the PI
velocity-norm dependency as the next lower proof-obligation refinement.  The
compiled upper packet is `SALD.cycle25FirstAppendixVocabularyPacket`.

Source anchors:

- `lem:gronwall`: `appendix.tex:47-71`;
- `lem:dv_variation`: `appendix.tex:73-79`;
- `def:PI`: `appendix.tex:86-94`;
- PI downstream velocity-norm route: `appendix.tex:96-151`;
- `eq:LSI-KL-FI` and KL/FI/LSI vocabulary: `main_body.tex:202-215`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 25 upper first appendix packet | Refresh the source-index and first-layer contract map while selecting the PI velocity-norm backend as the next lower slice. | `SALD.cycle13FirstAppendixSourceIndexAuditContract`; `SALD.cycle21FirstAppendixMiddleAuditContract`; `SALD.saldFirstProofDag`; `sald.first_appendix.source_index_audit`; `sald.first_appendix.middle_source_to_lean_map` | `SALD.cycle25FirstAppendixVocabularyPacket` | `appendix.tex:47-151`; `main_body.tex:202-215` | first proof DAG; later forward-KL and VA-SALD theorem dependencies | workflow obligation |
| Cycle 25 middle PI velocity map | Translate the upper-selected PI velocity-norm backend into a lower-ready source map for `dot H^1(mu)`, mean-zero/variance, PI norm equivalence, weak-form notation, and boundedness of `T_mu` before Riesz. | `SALD.cycle25FirstAppendixVocabularyPacket`; `SALD.saldPIContract`; `SALD.piDefinitionContract`; `SALD.saldPiVelocityNormDependencyContract`; `SALD.piVelocityNormBackendObligation` | `SALD.cycle25FirstAppendixMiddleAuditContract`; `SALD.cycle25FirstAppendixPiVelocityNormMiddleObligation`; `sald.first_appendix.cycle25_pi_velocity_norm_middle` | `appendix.tex:96-129`; immediate continuation `appendix.tex:130-138` | lower target `sald.pi.velocity_norm_backend`; `lem:velocity-norm-bound` | workflow obligation |
| PI velocity-norm lower target | Refine the PI downstream Sobolev/Riesz route without changing the PI definition or proving a theorem-level SALD bound. | `SALD.saldPIContract`; `SALD.piDefinitionContract`; mean-zero weighted Sobolev vocabulary; variance vocabulary | `SALD.saldPiVelocityNormDependencyContract`; `SALD.piVelocityNormBackendObligation`; `sald.pi.velocity_norm_backend` | `appendix.tex:96-151`, first sub-slice `appendix.tex:96-129` | `lem:velocity-norm-bound`; moving-target and guided-path complexity estimates | obligation |
| First-layer status guard | Keep Gronwall, DV, PI, and LSI/KL/FI statuses honest while lower work narrows only the selected PI backend. | source index, proof-obligation ledger, SLT audit, fake-proof gate | `SALD.saldFirstProofDag`; `SALD.saldDependenciesForLabel` | `appendix.tex:47-151`; `main_body.tex:202-215` | all first proof-DAG users | obligation/source-cited/contract-only as before |

Mode discipline:

- `faithfulPaper`; use only the original `appendix.tex` and `main_body.tex`
  windows above, with `sald_version_2.tex` excluded.
- Preserve the source Gronwall signs, DV finite-log-mgf formula, PI
  `C_PI^{-1}` convention, and the LSI-to-KL/FI coefficient
  `1/(2*C_LSI)`.
- Keep Gronwall and LSI-to-KL/FI as obligations, DV as source-cited plus
  local instantiation obligations, and PI as contract-only with the
  velocity-norm proof route tracked separately.

Lower packet:

- target exactly `SALD.saldPiVelocityNormDependencyContract` /
  `SALD.piVelocityNormBackendObligation` /
  `sald.pi.velocity_norm_backend`;
- first sub-slice: `appendix.tex:96-129`, covering `dot H^1(mu)`, the
  mean-zero interface, PI norm equivalence, and boundedness of `T_mu` before
  the Riesz representation step;
- if blocked, record the missing weighted-Sobolev, Hilbert-space, weak-PDE,
  or boundary interface as a proof obligation instead of adding theorem
  assumptions;
- do not reopen Gronwall, DV, LSI-to-KL/FI, forward-KL, guided, general
  VA-SALD, or discrete theorem proof search in the same lower attempt.

Reviewer checklist:

- `python3 tools/astis.py source-index ASTIS-SALD-001` indexes the four focus
  labels and still excludes `sald_version_2.tex`.
- `SALD.saldFirstProofDag` dependencies for the four focus labels include
  `SALD.cycle25FirstAppendixVocabularyPacket` while preserving statuses:
  Gronwall `obligation`, DV `sourceCited`, PI `contractOnly`, and LSI/KL/FI
  `obligation`.
- The conversion window, proof-obligation ledger, source-index, and SLT audit
  classify cycle 25 as source-index/contract synchronization plus PI backend
  obligation refinement, not analytic proof closure.
- `python3 tools/astis.py check` passes.

## Cycle 25 Middle PI Velocity-Norm Map

Compiled refinement: `SALD.cycle25FirstAppendixMiddleAuditContract` and
`SALD.cycle25FirstAppendixPiVelocityNormMiddleObligation`.

| Source step | Lean-facing map | Status |
|---|---|---|
| `appendix.tex:96-103` defines `dot H^1(mu)` as the mean-zero weighted Sobolev space and equips it with the gradient inner product. | `SALD.saldPiVelocityNormDependencyContract.weightedSobolevSpace`; weighted Sobolev/mean-zero backend | obligation |
| `appendix.tex:104-112` uses PI to compare the gradient norm and weighted `H^1(mu)` norm on the mean-zero subspace. | `normEquivalence`; variance vocabulary; `SALD.saldPIContract` | obligation |
| `appendix.tex:114-123` states `lem:velocity-norm-bound`, restricts to gradient fields, and writes the weak form. | `weakPdeStatement`; `sald.pi.velocity_norm_backend` | obligation; line 119 has a `phi`/`psi` notation mismatch to normalize before proof search |
| `appendix.tex:123-129` defines `T_mu(psi)` and starts the Cauchy-Schwarz boundedness estimate. | `boundedFunctionalStep`; `SALD.cycle25FirstAppendixPiVelocityNormMiddleObligation` | obligation |
| `appendix.tex:130-138` supplies the immediate PI operator-norm and Riesz continuation. | `rieszRepresentationStep`; `velocityBound` | follow-on obligation, not part of the first lower proof closure unless a local backend builds |

Lower packet:

- target exactly `SALD.saldPiVelocityNormDependencyContract` /
  `SALD.piVelocityNormBackendObligation` /
  `sald.pi.velocity_norm_backend`;
- first sub-slice is `appendix.tex:96-129`, with the `appendix.tex:130-138`
  operator-norm/Riesz continuation recorded as the next source-contract gap;
- keep PI contract-only and do not promote the velocity-norm lemma, Gronwall,
  DV, LSI-to-KL/FI, or any forward/general VA-SALD theorem.

## Cycle 25 Lower PI Velocity-Norm Scalar Core

Compiled lower refinement:
`SALD.piVelocityNormMeanZeroH1UpperScalar`,
`SALD.piVelocityNormBoundedFunctionalScalar`, and
`SALD.cycle25PiVelocityNormLowerObligation`.

| Source step | Lean-facing refinement | Remaining obligation |
|---|---|---|
| `appendix.tex:104-112` uses PI and mean-zero variance to bound the weighted `H^1(mu)` norm by `(1+C_PI^{-1})` times the gradient norm. | `SALD.piVelocityNormMeanZeroH1UpperScalar` proves the real algebra `l2Sq + dotSq <= (1+invC)*dotSq` once `l2Sq <= invC*dotSq` is supplied. | mean-zero variance identity, PI instantiation on `dot H^1(mu)`, and nonnegative norm-square interpretation |
| `appendix.tex:123-129` starts the bounded-functional estimate `T_mu(psi) <= ||psi||_L2 ||g||_L2`. | `SALD.piVelocityNormBoundedFunctionalScalar` propagates Cauchy--Schwarz plus the PI norm bound to `piScale*psiDot*gL2`. | L2 pairing measurability/integrability, absolute-value/operator-norm formulation, nonnegative L2 norms, and the PI square-root norm bound |
| `appendix.tex:130-138` completes the operator-norm and Riesz step. | unchanged: `SALD.piVelocityNormBackendObligation` and `rieszRepresentationStep`. | Hilbert structure on `dot H^1(mu)`, bounded linear functional, Riesz representation, weak PDE solution, and velocity norm equality |

Status: only theorem-independent real-order algebra has been formalized.  The
PI definition remains contract-only, and `lem:velocity-norm-bound` remains an
analytic obligation.

## Cycle 26 Continuous Forward-KL Upper DV Witness Packet

Compiled upper packet: `SALD.cycle26ForwardKlUpperPacket`.

Objective: return to continuous `thm:forward-KL` after the first-appendix PI
cycle and select only the theorem-specific DV finite-log-mgf/common-space
witness as the next lower target.

Source anchors:

- alpha-complexity and theorem assumption: `main_body.tex:218-248`;
- source DV lemma: `appendix.tex:73-79`;
- forward-KL DV use: `appendix.tex:230-241`;
- downstream Gronwall use of the coefficient: `appendix.tex:244-252`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| cycle-26 upper forward-KL DV witness packet | Select the lower target `sald.forward_kl.dv_finite_log_mgf_witness` and keep the theorem statement fixed. | `SALD.forwardKlDvFiniteLogMgfWitnessContract`, `SALD.forwardKlDvAlphaMonotonicityContract`, `SALD.saldDvFiniteLogMgfContract`, `lem:dv_variation`, `def:alpha-complexity`, `sald.forward_kl.moving_target_dependency_chain` | `SALD.cycle26ForwardKlUpperPacket` | `main_body.tex:240`; `appendix.tex:230`; `appendix.tex:73` | `thm:forward-KL`; discrete DV witness pattern | workflow obligation |
| DV common-space and finite log-mgf witness | Before invoking DV, expose common state space, absolute continuity, measurability of `||v_t||^2`, finite log-mgf at `alpha`, and positive-alpha scaling. | source alpha0-complexity assumption, `SALD.forwardKlDvAlphaMonotonicityContract`, source-cited `lem:dv_variation` | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `SALD.forwardKlDvFiniteLogMgfWitnessObligation` | `appendix.tex:230-236` | `SALD.forwardKlDvEnergyCandidateContract`; `sald.forward_kl.dv_energy_bound` | obligation |
| alpha0-to-alpha bridge | Derive finite log-mgf at `alpha` from finite `E_alpha0(pi_t,v_t)` and `0<alpha<=alpha0`. | exponential monotonicity, expectation/order backend, log finiteness, positive alpha | `SALD.forwardKlDvAlphaMonotonicityContract`; `SALD.forwardKlDvAlphaMonotonicityObligation` | `main_body.tex:240-241`; `appendix.tex:230-236` | forward-KL DV witness | obligation |
| downstream coefficient guard | Preserve the source factors `alpha^(-1)` and `(1/2)*dot{s}(t)^(-1)*alpha^(-1)` before the Gronwall coefficient audit. | `SALD.forwardKlDvPositiveAlphaScalingScalar`, `SALD.forwardKlDvPositiveAlphaCoefficientScalar`, `SALD.forwardKlDependencyChainAuditContract`, `SALD.forwardKlGronwallSideConditionContract` | `SALD.forwardKlDvEnergyCandidateContract`; `SALD.cycle26ForwardKlDvPositiveAlphaLowerObligation`; `SALD.forwardKlCoefficientChainObligation` | `appendix.tex:237-241`; `main_body.tex:243-246` | Gronwall application | formalized scalar core plus obligation |

Mode discipline:

- `faithfulPaper`; use only original `main_body.tex` and `appendix.tex`, with
  `sald_version_2.tex` excluded.
- Preserve `nu=rho_{s(t)}`, `mu=pi_t`, `Z=alpha*||v_t||^2`, the source
  `alpha^(-1)` coefficient, and the final forward-KL theorem display.
- Keep DV source-cited; SLT entropy duality is a reference pattern only until
  it builds locally under the ASTIS toolchain.
- Keep LSI-to-KL/FI, KL derivative, schedule calculus, endpoint rewrites,
  Gronwall side-conditions, residual exponent drop, and full Gronwall as
  separate obligations.

Lower packet:

- target exactly `SALD.forwardKlDvFiniteLogMgfWitnessContract` /
  `SALD.forwardKlDvFiniteLogMgfWitnessObligation` /
  `sald.forward_kl.dv_finite_log_mgf_witness`;
- first sub-slice: common-space/absolute-continuity/measurability and
  alpha0-to-alpha finite log-mgf for `Z=alpha*||v_t||^2`;
- if the finite-log-mgf monotonicity or expectation-order backend is blocked,
  update `sald.forward_kl.dv_alpha_mgf_monotonicity` rather than adding a new
  theorem assumption;
- do not reopen the cycle-22 Gronwall coefficient assembly except as a
  downstream dependency.

Reviewer checklist:

- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle26ForwardKlUpperPacket`.
- `SALD.forwardKlProofDag` includes `SALD.cycle26ForwardKlUpperPacket` in the
  `ASTIS.SALD.forward_KL.dv_finite_log_mgf_witness` block.
- `SALD.forwardKlDvFiniteLogMgfWitnessObligation` remains an obligation; DV,
  LSI-to-KL/FI, KL derivative, endpoint rewrites, Gronwall side-conditions, and
  full Gronwall are not promoted.
- Source index refresh and the mandatory check pass.

## Cycle 26 Middle DV Witness Source-Dependency Map

Compiled middle refinement: `SALD.cycle26ForwardKlMiddleContract` and
`SALD.cycle26ForwardKlDvWitnessMiddleObligation`.

Objective: translate the upper-selected `appendix.tex:230-241` DV step into a
lower-ready map without changing `thm:forward-KL`.

Source-dependency audit:

| Source step | Classification | Lean-facing target | Status |
|---|---|---|---|
| `appendix.tex:73-79` states DV over probability measures on the same space and finite-log-mgf random variables. | external-cited-result | `probability.dv_variational_formula`; `SALD.saldDvFiniteLogMgfContract` | source-cited plus obligation interface |
| `main_body.tex:218-228` defines `E_alpha(pi_t,v_t)` as `alpha^(-1)*log E_{pi_t}[exp(alpha*||v_t||^2)]`. | internal-paper definition | `SALD.saldAlphaComplexityContract`; `SALD.forwardKlDvAlphaMonotonicityContract` | contract plus obligation |
| `main_body.tex:240-241` assumes finite `E_alpha0(pi_t,v_t)` for all `t`; the proof uses finite log-mgf for every `0<alpha<=alpha0`. | local-lemma / source-contract gap | `sald.forward_kl.dv_alpha_mgf_monotonicity` | obligation |
| `appendix.tex:230-236` applies DV with `nu=rho_{s(t)}`, `mu=pi_t`, and `Z=alpha*||v_t||^2`. | source-contract gap | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `sald.forward_kl.dv_finite_log_mgf_witness` | obligation |
| `appendix.tex:237-241` divides by positive `alpha` and rewrites the log-mgf term as `E_alpha(pi_t,v_t)`. | local algebra plus alpha-complexity rewrite | `SALD.forwardKlDvPositiveAlphaScalingScalar`; `SALD.forwardKlDvPositiveAlphaCoefficientScalar`; `SALD.cycle26ForwardKlDvPositiveAlphaLowerObligation` | scalar real-order core formalized; theorem-specific instantiation remains obligation |

Updated proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| cycle-26 middle DV witness map | Expose common-space/absolute-continuity, measurability of `Z=alpha*||v_t||^2`, alpha0-to-alpha finite log-mgf, and positive-alpha scaling before DV energy. | `SALD.cycle26ForwardKlUpperPacket`, `SALD.forwardKlDvFiniteLogMgfWitnessContract`, `SALD.forwardKlDvAlphaMonotonicityContract`, `SALD.saldDvFiniteLogMgfContract`, `probability.dv_variational_formula` | `SALD.cycle26ForwardKlMiddleContract`; `SALD.cycle26ForwardKlDvWitnessMiddleObligation`; `ASTIS.SALD.forward_KL.cycle26_middle_dv_witness` | `main_body.tex:218-248`; `appendix.tex:73-79`; `appendix.tex:230-241` | `sald.forward_kl.dv_finite_log_mgf_witness`; `thm:forward-KL` | obligation |
| DV finite-log-mgf witness | Lower target selected by the middle map. | cycle-26 middle map, alpha monotonicity, moving-target dependency chain, DV source-cited interface | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `SALD.forwardKlDvFiniteLogMgfWitnessObligation` | `appendix.tex:230-241` | DV energy and Gronwall coefficient audit | obligation |
| cycle-26 lower positive-alpha scalar core | Divide the supplied DV inequality by `alpha>0`, rewrite the log-mgf quotient as `E_alpha`, and preserve the nonnegative downstream prefactor. | supplied DV inequality, `alpha>0`, `E_alpha=alpha^(-1)*logMgf`, nonnegative prefactor `(1/2)*dot{s}(t)^(-1)` | `SALD.forwardKlDvPositiveAlphaScalingScalar`; `SALD.forwardKlDvPositiveAlphaCoefficientScalar`; `SALD.cycle26ForwardKlDvPositiveAlphaLowerObligation` | `appendix.tex:237-241` | `sald.forward_kl.dv_energy_bound`; Gronwall coefficient audit | formalized scalar core plus obligation |

Lower packet:

- target exactly `SALD.forwardKlDvFiniteLogMgfWitnessContract` /
  `SALD.forwardKlDvFiniteLogMgfWitnessObligation` /
  `sald.forward_kl.dv_finite_log_mgf_witness`;
- first sub-slice: common state space for `rho_{s(t)}` and `pi_t`,
  `rho_{s(t)} << pi_t`, and measurability/real-valuedness of
  `Z_t=alpha*||v_t||^2`;
- if that backend is blocked, refine
  `sald.forward_kl.dv_alpha_mgf_monotonicity` from finite
  `E_alpha0(pi_t,v_t)` to finite log-mgf at `alpha`;
- keep positive-alpha division and the coefficient `alpha^(-1)` visible;
  do not add any new theorem assumption and do not reopen LSI, KL derivative,
  endpoint schedule, Gronwall, or the full theorem proof.

Status: workflow/source-dependency refinement plus a compiled scalar core.  DV
remains source-cited; alpha0-to-alpha monotonicity, common-space/absolute
continuity, measurability, and the theorem-specific instantiation of the
positive-alpha scalar lemmas remain obligations.

## Cycle 30 Continuous Forward-KL Upper Derivative-Side Packet

Objective: keep `thm:forward-KL` fixed and assign lower work to the
derivative-side moving-target interface before the existing LSI, DV, and
Gronwall packets.  The compiled upper packet is
`SALD.cycle30ForwardKlUpperPacket`, with workflow obligation
`SALD.cycle30ForwardKlDerivativeSideUpperObligation` /
`sald.forward_kl.cycle30_derivative_side_upper`.

Source anchors:

- theorem statement and terminal display: `main_body.tex:238-247`;
- KL differentiation and SALD Fokker--Planck step: `appendix.tex:168-185`;
- slowed-target transport and Young bound: `appendix.tex:187-208`;
- LSI and inverse-schedule handoff to the pre-DV `t` inequality:
  `appendix.tex:210-228`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 30 upper derivative-side packet | Select the derivative side-condition lower target while preserving the source route through LSI, DV, and Gronwall. | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlMovingTargetDependencyContract`; `eq:SALD`; `eq:FP-eq`; `eq:LSI-KL-FI` | `SALD.cycle30ForwardKlUpperPacket`; `SALD.cycle30ForwardKlDerivativeSideUpperObligation`; `ASTIS.SALD.forward_KL.cycle30_derivative_side_upper` | `appendix.tex:168-228`; `main_body.tex:238-247` | `thm:forward-KL`; cycle 30 lower derivative-side packet | workflow obligation |
| Cycle 30 middle derivative-side packet | Translate the upper packet into a lower-ready source map for `appendix.tex:168-208`, with `appendix.tex:168-185` as the first density/boundary/FI-identification sub-slice. | `SALD.cycle30ForwardKlUpperPacket`; `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlDensityBoundaryObligation`; `eq:SALD`; `eq:FP-eq`; `KLContract`; `FIContract`; `FokkerPlanckContract` | `SALD.cycle30ForwardKlMiddleContract`; `SALD.cycle30ForwardKlDerivativeSideMiddleObligation`; `ASTIS.SALD.forward_KL.cycle30_derivative_side_middle` | `appendix.tex:168-208` | `sald.forward_kl.density_boundary_regular`; cycle 30 lower density-boundary packet | workflow obligation |
| Density/boundary derivative side conditions | Expose mass conservation, differentiation under the KL integral, SALD Fokker--Planck integration by parts, target-side integration by parts, and the exact Young `1/2` coefficients. | `KLContract`; `FIContract`; `TransportVelocityContract`; `FokkerPlanckContract`; `SALD.forwardKlDerivativeSideConditionContract` | `SALD.forwardKlDensityBoundaryObligation`; `sald.forward_kl.density_boundary_regular` | `appendix.tex:168-208` | `sald.forward_kl.kl_derivative`; coefficient-chain audit | obligation |
| Time-change handoff | Keep `tilde_v_s=dot t(s)*v_{t(s)}`, `d/dt K(s(t))=dot s(t)*dK/ds`, and `dot s(t)*dot t(s(t))^2=dot s(t)^(-1)` separate from the first lower density/boundary slice. | derivative side-condition contract; endpoint schedule contract; moving-target dependency chain | `SALD.forwardKlScheduleTimeChangeObligation`; `sald.forward_kl.schedule_time_change` | `appendix.tex:191-228` | `sald.forward_kl.kl_derivative`; Gronwall coefficient audit | obligation |

Mode discipline:

- `faithfulPaper`; use only the original `main_body.tex` and `appendix.tex`,
  with `sald_version_2.tex` excluded.
- Preserve the derivative route exactly:
  KL differentiation -> SALD Fokker--Planck -> target transport ->
  Cauchy--Schwarz/Young -> LSI -> inverse-schedule time change.
- Do not add density, boundary, inverse-function, endpoint, positivity, or
  integrability hypotheses to `thm:forward-KL`; keep them as obligations.
- Do not reopen the cycle-26 DV witness or cycle-29 LSI density-test work
  except as dependencies.

Lower packet:

- target exactly `SALD.forwardKlDerivativeSideConditionContract` /
  `SALD.forwardKlDensityBoundaryObligation` /
  `sald.forward_kl.density_boundary_regular`;
- middle declaration: `SALD.cycle30ForwardKlMiddleContract`, with workflow
  obligation `SALD.cycle30ForwardKlDerivativeSideMiddleObligation` /
  `sald.forward_kl.cycle30_derivative_side_middle`;
- first sub-slice: `appendix.tex:168-185`, covering mass conservation,
  differentiation under the integral, SALD Fokker--Planck, and the
  integration-by-parts step giving `-FI(rho_s||tilde_pi_s)`;
- second sub-slice if needed: `appendix.tex:187-208`, covering slowed-target
  transport, target-side integration by parts, Cauchy--Schwarz, and Young with
  the exact `1/2` coefficients;
- leave `appendix.tex:218-228` inverse-schedule calculus in
  `sald.forward_kl.schedule_time_change` unless the density/boundary slice is
  finished and explicitly handed off.

Reviewer checklist:

- `SALD.forwardKlProofDag` has
  `ASTIS.SALD.forward_KL.cycle30_derivative_side_upper` before the derivative,
  and now has `ASTIS.SALD.forward_KL.cycle30_derivative_side_middle` before
  the derivative, DV, and Gronwall proof-search blocks.
- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle30ForwardKlUpperPacket`, `SALD.cycle30ForwardKlMiddleContract`,
  `sald.forward_kl.cycle30_derivative_side_upper`, and
  `sald.forward_kl.cycle30_derivative_side_middle`.
- `SALD.forwardKlDerivativeSideConditionContract` remains an obligation and
  no analytic backend is promoted.
- Source index refresh and `python3 tools/astis.py check` pass.

## Cycle 27 Lower Discrete Additive Collection

Objective: formalize only the local scalar/interval-integral algebra for the
additive residual terms in the accumulated-error bridge for
`thm:forward-KL-discrete`.

Source-to-Lean update:

| Source step | Classification | Lean-facing target | Status |
|---|---|---|---|
| `appendix.tex:586` contributes `dot{s}(t)^(-1)*E_alpha(pi_t,v_t)` to the residual integral. | local interval-integral algebra after linear slowdown | `SALD.discreteForwardKlAlphaComplexityCollectionScalar` | formalized scalar core; source identification of `A_alpha(pi,v)` remains an obligation |
| `appendix.tex:588` contributes `2*dot{s}(t)*eta*Delta(t)` to the residual integral. | local interval-integral algebra after linear slowdown | `SALD.discreteForwardKlDeltaAccumulationScalar` | formalized scalar core; source identification of `barDelta_{alpha'}` remains an obligation |
| `main_body.tex:316-323` collects the residual additive terms as `(1/r)*A_alpha(pi,v)+2*r*eta*barDelta_{alpha'}`. | combined local algebra plus source-definition hypotheses | `SALD.discreteForwardKlAccumulatedErrorCollectionScalar`; `SALD.cycle27DiscreteForwardKlAccumulatedCollectionLowerObligation` | formalized scalar core plus obligation |

This lower slice keeps `SALD.discreteForwardKlAccumulatedErrorBridgeContract`
as an obligation.  Endpoint rewrites, stitched interval regularity,
coefficient integrability, residual-exponent monotonicity, `barGamma`
identification, Gronwall, DV, LSI-to-KL/FI, EM Fokker--Planck, and
frozen-defect backends are not promoted.

## Cycle 28 Guided/General Upper Packet

Objective: return to the guided/general VA-SALD path and select the discrete
general derivative side-condition bridge as the next lower target.  The compiled
upper packet is `SALD.cycle28GeneralVaSaldUpperPacket`; it does not change
`thm:general-moving-target-SALD-discrete` or prove the derivative inequality.

Source anchors:

- fixed theorem display: `appendix.tex:1316-1347`;
- derivative route: `appendix.tex:1354-1598`;
- preferred lower sub-slice: `appendix.tex:1469-1511`;
- upstream continuous/unified dependencies: `appendix.tex:724-951` and
  `main_body.tex:359-395`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 28 discrete derivative upper packet | Select the pre-Gronwall derivative side-condition ledger; preferred lower work is the frozen/residual algebra and two Young coefficient splits. | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; EM endpoint/Fokker--Planck obligations; frozen-delta obligation; `eq:LSI-KL-FI`; `lem:dv_variation`; schedule obligations | `SALD.cycle28GeneralVaSaldUpperPacket`; `ASTIS.SALD.general_moving_target_discrete.cycle28_upper_derivative_side_conditions` | `appendix.tex:1354-1598`, first sub-slice `appendix.tex:1469-1511` | `thm:general-moving-target-SALD-discrete`; cycle 28 lower packet | obligation |
| Cycle 28 discrete derivative middle packet | Translate the upper-selected sub-slice into lower-ready frozen/residual algebra and Young bookkeeping interfaces. | upper packet; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; frozen-delta obligation; LSI handoff; scalar Young helpers | `SALD.cycle28GeneralVaSaldMiddleContract`; `SALD.cycle28GeneralVaSaldDerivativeSideMiddleObligation`; `ASTIS.SALD.general_moving_target_discrete.cycle28_middle_derivative_side_conditions` | `appendix.tex:1469-1511` | `sald.general_moving_target_discrete.derivative_side_conditions`; cycle 28 lower packet | obligation |
| Cycle 28 discrete derivative lower algebra | Compile the module-level frozen/residual rewrite once `delta_pi^VA`, `tilde v_s`, and `m_t=v_t-c_t` are supplied. | middle packet; `eq:general_discrete_delta_def`; EM/conditional-drift and slowed-transport identifications | `SALD.generalMovingTargetDiscreteFrozenResidualAlgebraVector`; `SALD.cycle28GeneralVaSaldDerivativeSideLowerObligation`; `ASTIS.SALD.general_moving_target_discrete.cycle28_lower_derivative_side_conditions` | `appendix.tex:1469-1478` | `sald.general_moving_target_discrete.derivative_side_conditions`; `thm:general-moving-target-SALD-discrete` | local module algebra formalized; analytic identifications open |
| Discrete derivative side conditions | Keep endpoint laws, conditional drift, Fokker--Planck split, slowed transport velocity, frozen/residual algebra, Young coefficients, DV handoff, and stitched time change explicit. | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.general_moving_target_discrete.frozen_delta_cross_lip`; `sald.forward_kl.schedule_time_change` | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` | `appendix.tex:1354-1598` | `sald.general_moving_target_discrete.kl_derivative`; final Gronwall bridge | obligation |

Mode discipline:

- `faithfulPaper`; use the original `appendix.tex` and `main_body.tex`, with
  `sald_version_2.tex` excluded.
- Preserve the source identity
  `(sigma_eta^2/2)*nabla log tilde pi_s - bar b_{k,s} + tilde v_s =
  delta_pi^VA + dot{t}(s)*m_{t(s)}`.
- Preserve the two Young splits with `sigma_eta^2/8` each and the resulting
  coefficients `2*sigma_eta^(-2)*dot{t}(s)^2`,
  `2*Gamma*eta^2*alpha'^(-1)`, and `2*Delta*eta`.
- Keep EM endpoint laws, conditional drift, Fokker--Planck, integration by
  parts, LSI-to-KL/FI, DV, time change, and Gronwall as separate obligations.

Lower packet:

- target exactly `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`
  / `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` /
  `sald.general_moving_target_discrete.derivative_side_conditions`;
- first sub-slice: `appendix.tex:1469-1511`, covering the frozen/residual
  algebra and Young coefficient bookkeeping only;
- if the conditional-drift, divergence, slowed-transport, or stitched-regularity
  backend is blocked, refine that named obligation instead of adding theorem
  assumptions.

Reviewer checklist:

- `SALD.generalVaSaldDiscreteProofDag` contains
  `ASTIS.SALD.general_moving_target_discrete.cycle28_upper_derivative_side_conditions`
  before `ASTIS.SALD.general_moving_target_discrete.derivative_side_conditions`.
- `SALD.saldDependenciesForLabel "thm:general-moving-target-SALD-discrete"`
  includes `SALD.cycle28GeneralVaSaldUpperPacket`.
- `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` remains an
  obligation and keeps the `appendix.tex:1469-1511` coefficients unchanged.

## Cycle 28 Guided/General Middle Packet

Objective: translate the upper-selected source window
`appendix.tex:1469-1511` into lower-ready Lean-facing declarations for
`sald.general_moving_target_discrete.derivative_side_conditions`.  The compiled
middle packet is `SALD.cycle28GeneralVaSaldMiddleContract`; it does not prove the
vector-field decomposition, inner-product Young inequalities, frozen-delta
lemma, LSI, DV, time change, or final derivative theorem.

Source-to-Lean map:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1469-1478` rewrites the cross field as `delta_pi^VA + dot t(s)*m_{t(s)}`. | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract.frozenResidualAlgebra`; `SALD.generalMovingTargetDiscreteFrozenResidualAlgebraVector`; lower obligation `sald.general_moving_target_discrete.cycle28_derivative_side_lower` | module algebra formalized; concrete field identifications open |
| `appendix.tex:1481-1488` splits the derivative cross term into frozen and residual pieces. | `SALD.cycle28GeneralVaSaldMiddleContract.sourceStepMap`; `SALD.cycle28GeneralVaSaldDerivativeSideMiddleObligation` | obligation |
| `appendix.tex:1493-1501` applies Young to the residual cross term and produces `2*sigma_eta^(-2)*dot t(s)^2*||m||^2`. | `SALD.generalMovingTargetDiscreteResidualYoungCoefficientScalar` plus analytic Young/FI obligations | scalar algebra formalized; analytic step open |
| `appendix.tex:1503-1511` applies `lem:frozen_delta_cross_lip` with the second `sigma_eta^2/8` FI share. | `SALD.generalMovingTargetDiscreteFrozenDeltaObligation`; `SALD.generalMovingTargetDiscreteYoungFisherShareScalar` | scalar algebra formalized; frozen-delta lemma open |
| `appendix.tex:1513-1524` combines both Young outputs, leaving `-(sigma_eta^2/4)*FI`. | `SALD.generalMovingTargetDiscreteTwoYoungFisherBudgetScalar` | scalar budget formalized; source analytic hypotheses open |

Lower packet:

- target exactly `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`
  / `SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation` /
  `sald.general_moving_target_discrete.derivative_side_conditions`;
- use the compiled module algebra for the frozen/residual rewrite, then keep
  the concrete conditional-drift, score, slowed-transport, and pointwise field
  identifications open before the analytic Young and FI side conditions;
- keep LSI-to-KL/FI, residual DV finite-log-mgf, s-to-t stitching, and Gronwall
  as separate obligations.

Reviewer checklist:

- `SALD.generalVaSaldDiscreteContract` lists
  `SALD.cycle28GeneralVaSaldDerivativeSideMiddleObligation`.
- `SALD.generalVaSaldDiscreteProofDag` contains
  `ASTIS.SALD.general_moving_target_discrete.cycle28_middle_derivative_side_conditions`
  between the upper packet and `derivative_side_conditions`.
- `SALD.saldDependenciesForLabel "thm:general-moving-target-SALD-discrete"`
  includes the middle contract, middle obligation, DAG block, and scalar Young
  bookkeeping helpers.
- Lower synchronization adds
  `SALD.generalMovingTargetDiscreteFrozenResidualAlgebraVector`,
  `SALD.cycle28GeneralVaSaldDerivativeSideLowerObligation`, and
  `ASTIS.SALD.general_moving_target_discrete.cycle28_lower_derivative_side_conditions`
  without promoting the analytic side-condition obligation.

## Cycle 28 Guided/General Lower Algebra

Objective: refine the first lower sub-slice of
`sald.general_moving_target_discrete.derivative_side_conditions` without
changing `thm:general-moving-target-SALD-discrete`.

Accepted compiled core:

| Source step | Lean-facing declaration | Still open |
|---|---|---|
| `appendix.tex:1469-1478` uses `eq:general_discrete_delta_def`, `tilde v_s=dot t(s)*v_{t(s)}`, and `m_t=v_t-c_t` to rewrite the cross field as `delta_pi^VA+dot t(s)*m_{t(s)}`. | `SALD.generalMovingTargetDiscreteFrozenResidualAlgebraVector`; `SALD.cycle28GeneralVaSaldDerivativeSideLowerObligation`; DAG block `ASTIS.SALD.general_moving_target_discrete.cycle28_lower_derivative_side_conditions` | conditional drift/disintegration, score and slowed-transport identifications, pointwise vector-field equality, Young/FI, frozen-delta, LSI, DV, time change, and Gronwall |

The helper is module-level algebra only: from
`delta = dotT • c + score - frozen`, `tildeV = dotT • v`, and `m = v-c`, it
proves `score - frozen + tildeV = delta + dotT • m`.  The paper's concrete
analytic fields remain obligations under
`SALD.generalMovingTargetDiscreteDerivativeSideConditionObligation`.

## Cycle 29 First Appendix Upper Packet

Objective: return to the source-index and first appendix/vocabulary layer after
the cycle-28 guided/general derivative-side algebra, and select the LSI/KL/FI
density-test bridge as the next lower target.  The compiled upper packet is
`SALD.cycle29FirstAppendixVocabularyPacket`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 29 first appendix upper packet | Rebaseline the four first-layer labels and choose the LSI/KL/FI density-test bridge as the next lower obligation. | `SALD.cycle13FirstAppendixSourceIndexAuditContract`; `SALD.cycle25FirstAppendixVocabularyPacket`; source index refresh | `SALD.cycle29FirstAppendixVocabularyPacket` | `appendix.tex:47-151`; `main_body.tex:202-215` | first proof DAG; cycle 29 middle/lower packet | obligation |
| LSI/KL/FI density-test bridge | Expose the source route `rho << pi`, `phi=sqrt(rho/pi)`, normalization, entropy rewrite, FI chain rule, and coefficient `1/(2*C_LSI)`. | `KLContract`; `FIContract`; `LSIContract`; density and smooth-test obligations | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `sald.lsi_kl_fi.density_test_interface` | `main_body.tex:208-215` | all forward-KL theorem contracts | obligation |

Mode discipline:

- `faithfulPaper`; use only the original `appendix.tex` and `main_body.tex`
  focus windows, with `sald_version_2.tex` excluded;
- preserve Gronwall signs, the DV finite-log-mgf formula, PI's `C_PI^{-1}`
  convention, and the LSI-to-KL/FI coefficient `1/(2*C_LSI)`;
- keep this as Phase 1 transcript/obligation work, not reusable API
  reorganization.

Lower packet:

- target exactly `SALD.saldLsiKlFiDensityTestContract` /
  `SALD.lsiKlFiDensityTestObligation` /
  `sald.lsi_kl_fi.density_test_interface`;
- first sub-slice is `main_body.tex:208-215`: density ratio, square-root test,
  normalization, entropy identity, FI chain rule, finite KL/FI requirements,
  and coefficient audit;
- if a backend is missing, record the density, admissibility, approximation,
  or chain-rule gap as an obligation instead of changing theorem hypotheses.

Reviewer checklist:

- source index contains `lem:gronwall`, `lem:dv_variation`, `def:PI`, and
  `eq:LSI-KL-FI` from original files and excludes `sald_version_2.tex`;
- `SALD.saldFirstProofDag` dependencies for the four focus labels include
  `SALD.cycle29FirstAppendixVocabularyPacket`;
- Gronwall remains `obligation`, DV remains `sourceCited`, PI remains
  `contractOnly`, and LSI/KL/FI remains `obligation`.

## Cycle 29 First Appendix Middle Packet

Objective: translate the cycle 29 upper packet into a lower-ready
source-to-Lean map for the LSI/KL/FI density-test bridge, without changing any
later SALD theorem statement.  The compiled middle packet is
`SALD.cycle29FirstAppendixMiddleAuditContract`.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 29 first appendix middle map | Re-read the four first-layer source windows and classify each step as contract, cited result, or obligation. | `SALD.cycle29FirstAppendixVocabularyPacket`; `SALD.saldLsiKlFiDensityTestContract`; source-index refresh | `SALD.cycle29FirstAppendixMiddleAuditContract` | `appendix.tex:47-151`; `main_body.tex:202-215` | first proof DAG; lower LSI density-test packet | obligation |
| LSI/KL/FI density-test middle obligation | Narrow the selected lower slice to `main_body.tex:208-215`: `rho << pi`, `r=d rho/d pi`, `phi=sqrt(r)`, normalization, entropy-to-KL rewrite, FI chain rule, and coefficient audit. | `KLContract`; `FIContract`; `LSIContract`; `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | `SALD.cycle29LsiKlFiDensityTestMiddleObligation`; `sald.lsi_kl_fi.cycle29_density_test_middle` | `main_body.tex:208-215` | `eq:LSI-KL-FI`; forward-KL theorem contracts | obligation |

Source-to-Lean map:

| Source step | Lean-facing target | Classification |
|---|---|---|
| `appendix.tex:47-71` Gronwall integrating-factor proof | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `sald.gronwall.*` obligations | unchanged local real-analysis obligation |
| `appendix.tex:73-79` DV variational formula | `SALD.saldDvFiniteLogMgfContract`; `probability.dv_variational_formula`; `sald.dv_variation.finite_log_mgf_interface` | cited result plus local instantiation obligation |
| `appendix.tex:86-151` PI and velocity-norm route | `SALD.saldPIContract`; `SALD.saldPiVelocityNormDependencyContract`; `sald.pi.velocity_norm_backend` | PI contract-only; velocity backend obligation |
| `main_body.tex:202-215` LSI/KL/FI comparison | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `SALD.cycle29LsiKlFiDensityTestMiddleObligation` | selected lower obligation |

Lower packet:

- target exactly `SALD.saldLsiKlFiDensityTestContract` /
  `SALD.lsiKlFiDensityTestObligation` /
  `sald.lsi_kl_fi.density_test_interface`;
- refine one missing backend at a time: Radon-Nikodym density convention,
  square-root test admissibility or approximation, entropy identity, FI chain
  rule, finite KL/FI interface, or the `1/(2*C_LSI)` coefficient audit;
- do not replace the source LSI route with PI, Pinsker, Talagrand, Girsanov,
  or a direct theorem-level VA-SALD proof.

## Cycle 29 First Appendix Lower Coefficient Slice

Objective: refine only the scalar coefficient audit inside the selected
LSI/KL/FI density-test bridge.  The compiled Lean helper is
`SALD.lsiKlFiCoefficientAuditScalar`; it does not prove the density,
admissibility, entropy, or Fisher-information chain-rule facts.

Accepted compiled core:

| Source step | Lean-facing declaration | Still open |
|---|---|---|
| `main_body.tex:205-210` combines the LSI factor `2/C_LSI` with the FI chain-rule factor `1/4` to obtain `FI/(2*C_LSI)`. | `SALD.lsiKlFiCoefficientAuditScalar`; `SALD.cycle29LsiKlFiDensityTestLowerObligation`; `sald.lsi_kl_fi.cycle29_density_test_lower` | Radon-Nikodym density `r=d rho/d pi`, normalization, smooth/admissible `sqrt(r)` or approximation, entropy rewrite to KL, zero-density conventions, and FI chain rule |

The lower obligation keeps `SALD.lsiKlFiDensityTestObligation` open.  It may be
used only after a future analytic backend supplies the source LSI inequality
with Dirichlet term and the identity
`dirichlet = (1/4) * FI(rho||pi)`.

## Cycle 30 Forward-KL Lower Density/Boundary Scalar Slice

Objective: refine the first lower sub-slice of the continuous forward-KL
derivative-side packet: `appendix.tex:168-185`, before target-side transport,
LSI, time-change, DV, or Gronwall.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 30 lower density/boundary scalar handoff | Substitute the supplied first-term identity `firstTerm=-FI` into the KL derivative display after the analytic density/Fokker--Planck obligations supply both inputs. | `SALD.cycle30ForwardKlMiddleContract`; `SALD.forwardKlDensityBoundaryObligation`; `eq:FP-eq`; `KLContract`; `FIContract`; `FokkerPlanckContract` | `SALD.forwardKlFirstTermFisherSubstitutionScalar`; `SALD.cycle30ForwardKlDensityBoundaryLowerObligation`; DAG block `ASTIS.SALD.forward_KL.cycle30_density_boundary_lower` | `appendix.tex:168-185` | `sald.forward_kl.kl_derivative`; `thm:forward-KL` | formalized scalar core plus obligation |

Source-to-Lean map:

| Source step | Lean-facing target | Classification |
|---|---|---|
| `appendix.tex:168-174` differentiates `KL(rho_s||tilde pi_s)` and uses `int partial_s rho_s dx=0`. | first input to `SALD.forwardKlFirstTermFisherSubstitutionScalar`; `SALD.forwardKlDerivativeSideConditionContract.massConservation`; `SALD.forwardKlDensityBoundaryObligation` | local analytic obligation |
| `appendix.tex:176-185` substitutes the SALD Fokker--Planck equation and integrates by parts to obtain `-FI(rho_s||tilde pi_s)`. | second input to `SALD.forwardKlFirstTermFisherSubstitutionScalar`; `SALD.forwardKlDensityBoundaryObligation` | local analytic obligation |
| The displayed derivative expression now has the first term replaced by `-FI` while retaining the target term for the next slice. | `SALD.forwardKlFirstTermFisherSubstitutionScalar`; `sald.forward_kl.cycle30_density_boundary_lower` | scalar equality formalized; analytic hypotheses open |

Remaining obligations: smooth positive densities, domination for
differentiation under the integral, mass conservation, the SALD
Fokker--Planck backend, boundary/no-flux or decay, finite Fisher information,
and the concrete FI identification.  Target-side transport (`appendix.tex:187-208`),
LSI (`appendix.tex:210-217`), inverse-schedule time change
(`appendix.tex:218-228`), DV, and Gronwall remain separate named obligations.

## Cycle 31 Gronwall Upper Proof-Closure Packet

Priority check before assigning work: the active proof-closure order is
`lem:gronwall`, `lem:dv_variation`, `eq:LSI-KL-FI`, the forward-KL
Fokker--Planck/KL derivative identity, then the Euler--Maruyama interpolation
Fokker--Planck backend.  This cycle selects the first item only:
`lem:gronwall` from `appendix.tex:47-71`.

Objective: translate the original Gronwall proof into proof-producing Lean code
instead of another first-appendix rebaseline.  The lower slice should attack the
integrating-factor step in `appendix.tex:58-61` first, because it is local real
algebra once the product derivative and positive integrating factor have been
supplied.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Gronwall integrating-factor scalar inequality | From `I=exp(int_0^t a)>0` and `K' <= -a*K+b`, prove `a*I*K + I*K' <= I*b`, matching the inequality after differentiating the integrating factor. | Real ordered-ring algebra; `Real.exp_pos`; source differential inequality | planned `SALD.gronwallIntegratingFactorDerivativeInequalityScalar` | `appendix.tex:58-61` | `sald.gronwall.integrating_factor`; all later Gronwall applications | lower-ready proof-producing sublemma |
| Gronwall endpoint-safe derivative/FTC backend | Choose the closed-interval derivative or absolute-continuity formulation for differentiating `exp(int_0^t a)*K_t` and integrating the derivative inequality from `0` to `t1`. | `SALD.saldGronwallEndpointCalculusContract`; Mathlib interval-integral FTC/order integration | `SALD.gronwallEndpointCalculusObligation` | `appendix.tex:55-63` | `sald.gronwall.integrating_factor` | obligation |
| Gronwall exponent rewrite | Reuse existing compiled interval-additivity and exponential-product helpers to move from line 67 to line 69. | `SALD.gronwallNegIntegralRewriteScalar`; `SALD.gronwallExpProductRewriteScalar`; `SALD.gronwallIntervalIntegralAdditivityScalar`; `SALD.gronwallExpProductRewriteIntegralCongr` | `SALD.gronwallExponentRewriteObligation` | `appendix.tex:63-69` | continuous/discrete forward-KL and general moving-target Gronwall applications | partial formalized sublemmas plus obligation |

Mode discipline:

- `faithfulPaper`; use only the original source root
  `/home/nitanda_sub/mark/repos/sald/paper`, with `sald_version_2.tex`
  excluded.
- Keep the Gronwall theorem statement fixed: continuous `a_t,b_t`,
  differentiable `K_t` on `[0,t1]`, and
  `dK_t/dt <= -a_t*K_t + b_t`.
- Preserve both displayed exponential factors exactly:
  `exp(-int_0^t1 a)` and `exp(-int_t^t1 a)`.
- Do not add sign assumptions on `a`, `b`, or `K`.

Non-goals:

- No source-index rebaseline unless the reviewer finds a blocking anchor gap.
- Do not work on DV, LSI/KL/FI, forward-KL derivative, or EM interpolation
  until this Gronwall slice has a real Lean attempt.
- Do not restate later SALD theorem contracts or promote `lem:gronwall` to
  formalized unless the local Lean proof actually builds.
- Do not replace the paper route with a generalized API, comparison theorem,
  or external Gronwall result.

Lower packet:

- Target `sald.gronwall.integrating_factor` through
  `SALD.saldGronwallCandidateContract` and
  `SALD.saldGronwallEndpointCalculusContract`.
- First attempt a compiled Lean helper named near
  `SALD.gronwallIntegratingFactorDerivativeInequalityScalar`: given real
  `a`, `K`, `K'`, `b`, and `I>0`, prove the line `58-61` algebra
  `a*I*K + I*K' <= I*b` from `K' <= -a*K+b`.
- If that closes quickly, next attempt the calculus wrapper for
  `I(t)=Real.exp (integral 0 t a)` using the narrowest Mathlib
  `HasDerivAt`/`HasDerivWithinAt` interval-integral API that preserves endpoint
  discipline.
- If the calculus backend is too large, add only a precise source-cited
  obligation for the missing FTC/order-integration interface and keep all
  statuses below formalized.

Reviewer checklist:

- The cycle explicitly chooses priority item 1, `lem:gronwall`, and does not
  spend the turn on source-index rebaseline work.
- Any new Lean helper is theorem-independent real algebra or calculus tied to
  `appendix.tex:58-61`; it must not add hidden signs or regularity assumptions
  to the source theorem.
- Existing exponent-rewrite helpers remain partial sublemmas only; the full
  Gronwall theorem remains an obligation unless a compiled proof closes it.
- `python3 tools/astis.py check` passes and the fake-proof scan remains clean.

## Cycle 31 Gronwall Middle Proof Slice

Middle translated `appendix.tex:58-61` into proof-producing Lean code while
leaving the full endpoint integration step as an explicit obligation.

Lean synchronization:

- `SALD.gronwallIntegratingFactorProductDerivative` proves the product
  derivative of `exp(A(t))*K(t)` once `A'(t)=a(t)` and `K'(t)=k'` are supplied.
- `SALD.gronwallIntegratingFactorDerivativeInequalityScalar` proves the ordered
  real algebra from `k' <= -a*K+b` and `0 <= I` to
  `a*I*K + I*k' <= I*b`.
- `SALD.gronwallIntegratingFactorDerivativeLe` combines the two against
  `A(t)=int_0^t a`.
- `SALD.gronwallIntegratingFactorDerivativeLeOfIntegral` discharges
  `A'(t)=a(t)` at a point with Mathlib's interval-integral FTC.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 31 product derivative | Differentiate `exp(A(t))*K(t)` as `a(t)*exp(A(t))*K(t)+exp(A(t))*K'(t)`. | `HasDerivAt A (a t) t`; `HasDerivAt K k' t`; `Real.hasDerivAt_exp`; product rule | `SALD.gronwallIntegratingFactorProductDerivative` | `appendix.tex:58-60` | `sald.gronwall.integrating_factor`; later Gronwall applications | formalized sublemma |
| Cycle 31 scalar derivative inequality | Substitute `K' <= -a*K+b` into the differentiated product and use `exp(A(t)) >= 0`. | ordered-ring algebra; `mul_le_mul_of_nonneg_left`; `Real.exp_pos` at use sites | `SALD.gronwallIntegratingFactorDerivativeInequalityScalar` | `appendix.tex:60-61` | `sald.gronwall.integrating_factor` | formalized sublemma |
| Cycle 31 FTC pointwise wrapper | Use interval-integral FTC to provide `d/dt int_0^t a=a(t)` at a point and derive the line 58-61 derivative bound. | `IntervalIntegrable a volume 0 t`; `StronglyMeasurableAtFilter a (nhds t) volume`; `ContinuousAt a t`; `HasDerivAt K k' t` | `SALD.gronwallIntegratingFactorDerivativeLeOfIntegral` | `appendix.tex:58-61` | `sald.gronwall.endpoint_calculus` | formalized pointwise wrapper |
| Remaining Gronwall integration | Integrate the pointwise derivative inequality over `[0,t1]`, evaluate endpoints, and then apply the existing exponent rewrite helpers. | closed-interval derivative or absolute-continuity semantics; order integration; endpoint evaluation; existing exponent congruence helpers | `SALD.gronwallEndpointCalculusObligation`; `SALD.gronwallExponentRewriteObligation` | `appendix.tex:63-69` | `lem:gronwall`; all downstream SALD Gronwall calls | obligation |

Lower handoff:

- next target should be the order-integration/endpoint slice in
  `SALD.gronwallEndpointCalculusObligation`, not another source-index
  rebaseline;
- use the new pointwise wrapper as the line 58-61 input;
- preserve the source's closed interval `[0,t1]`, with any one-sided endpoint
  derivative or absolute-continuity choice recorded explicitly;
- keep `lem:gronwall` at obligation status until the integrated inequality and
  final endpoint bound build.

## Cycle 31 Gronwall Lower Proof Slice

Lower translated the next source step, `appendix.tex:62-65`, into
proof-producing Lean helpers.  This closes the interval-order integration
shape and endpoint scalar algebra after the derivative function and its upper
bound have already been supplied.

Lean synchronization:

- `SALD.gronwallOrderIntegrationOfHasDerivAt` uses Mathlib's
  `intervalIntegral.integral_eq_sub_of_hasDerivAt` and
  `intervalIntegral.integral_mono_on` to derive
  `F(t1)-F(0) <= int_0^t1 g` from `F'=f'`, `f'<=g`, and interval
  integrability.
- `SALD.gronwallEndpointEvaluationScalar` evaluates the left endpoint
  `exp(int_0^0 a)*K(0)` as `K(0)` after the integrated inequality.
- `SALD.gronwallEndpointMultiplyByExpNegScalar` multiplies by
  `exp(-A)>0`, producing the source form immediately before the existing
  exponent-rewrite helpers.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 31 order integration | Integrate the derivative inequality from `0` to `t1`, preserving the inequality direction. | `HasDerivAt F (f' t) t` on `Set.uIcc 0 t1`; `IntervalIntegrable f'`; `IntervalIntegrable g`; pointwise order on `Set.Icc 0 t1` | `SALD.gronwallOrderIntegrationOfHasDerivAt` | `appendix.tex:62-63` | `sald.gronwall.endpoint_calculus`; later Gronwall applications | formalized sublemma |
| Cycle 31 endpoint evaluation | Replace `exp(int_0^0 a)*K(0)` by `K(0)` in the integrated inequality. | `intervalIntegral` same-endpoint simplification; real order algebra | `SALD.gronwallEndpointEvaluationScalar` | `appendix.tex:63-65` | `sald.gronwall.endpoint_calculus` | formalized sublemma |
| Cycle 31 inverse factor multiplication | Multiply by `exp(-int_0^t1 a)` and distribute over the right side. | `Real.exp_pos`; `Real.exp_add`; ordered scalar multiplication | `SALD.gronwallEndpointMultiplyByExpNegScalar` | `appendix.tex:65-67` | `sald.gronwall.endpoint_calculus`; `sald.gronwall.exponent_rewrite` | formalized sublemma |
| Remaining Gronwall backend | Produce the global interval-integrable derivative/input functions from the pointwise wrapper and supply adjacent interval-integrability for the final exponent rewrite. | closed-interval derivative or absolute-continuity semantics; `SALD.gronwallIntegratingFactorDerivativeLeOfIntegral`; existing exponent congruence helpers | `SALD.gronwallEndpointCalculusObligation`; `SALD.gronwallExponentRewriteObligation` | `appendix.tex:55-69` | `lem:gronwall`; all downstream SALD Gronwall calls | obligation |

No source statement was changed.  `lem:gronwall` remains an obligation because
the global endpoint-safe derivative/integrability backend and the final
adjacent-interval exponent-rewrite inputs still need to be supplied.

## Cycle 33 LSI/KL/FI Middle Density-Test Slice

Priority check: cycle 33 follows proof-closure item (3),
`eq:LSI-KL-FI`, after the cycle 31 Gronwall partial proof and cycle 32
source-cited DV scalar bridges.  Forward-KL derivative and EM interpolation
Fokker--Planck remain later targets.

Objective: translate `main_body.tex:202-215`, especially the source line
`phi=sqrt(rho/pi)`, into proof-producing Lean code for the density/test
sub-slice without promoting the full LSI-to-KL/FI comparison.

Accepted compiled core:

| Source bookkeeping step | Compiled Lean item | Still open |
|---|---|---|
| For nonnegative density ratio `r=d rho/d pi`, the source test satisfies `phi^2=r`. | `AutoSamplingTheory.lsiKlFiSqrtDensitySquareScalar` | Radon-Nikodym density construction and a.e. nonnegativity |
| The entropy integrand rewrites pointwise from `phi^2 log(phi^2)` to `r log r`. | `AutoSamplingTheory.lsiKlFiSqrtDensityEntropyIntegrandScalar` | integrability, zero-density convention, and the KL integral identity |
| Once an integral backend gives `testMass=densityMass`, density normalization gives the LSI test normalization. | `AutoSamplingTheory.lsiKlFiSqrtDensityNormalizationScalar` | integral transport from pointwise square and probability normalization of `rho` with respect to `pi` |
| Middle synchronization records the scalar slice as a dependency of the open density-test interface. | `SALD.cycle33LsiKlFiDensityTestMiddleObligation`; `sald.lsi_kl_fi.cycle33_density_test_middle` | smooth/admissible `sqrt(r)` or approximation, finite KL/FI, FI chain rule, and the full `probability.lsi_to_kl_fi` theorem |

This keeps `eq:LSI-KL-FI` at obligation status.  The cycle proves only
theorem-independent scalar facts that the paper uses inside the substitution
`phi=sqrt(rho/pi)`.

## Cycle 33 LSI/KL/FI Lower Scalar Bridge

Lower stayed on proof-closure item (3), `eq:LSI-KL-FI`, and translated the
next scalar handoff after the middle `sqrt(r)` lemmas.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Normalized LSI test bridge | Once the analytic backend supplies `int phi^2 d pi=1`, the LSI test inequality, `entropy=KL`, and `dirichlet=(1/4)*FI`, derive the displayed `KL <= FI/(2*C_LSI)`. | normalized test input; entropy-to-KL identity; FI chain rule; `SALD.lsiKlFiCoefficientAuditScalar` | `SALD.lsiKlFiDensityTestBridgeScalar`; `SALD.cycle33LsiKlFiDensityTestLowerObligation` | `main_body.tex:208-215` | `eq:LSI-KL-FI`; forward-KL theorem contracts | formalized scalar sublemma plus obligation |
| Remaining LSI/KL/FI backend | Build the actual Radon-Nikodym density, integral transport, admissible `sqrt(r)` or approximation, finite KL/FI, zero-density convention, and FI chain rule. | measure-theoretic density and calculus backend | `SALD.lsiKlFiDensityTestObligation`; `probability.lsi_to_kl_fi` | `main_body.tex:202-215` | all theorem blocks using the LSI contraction step | obligation |

The bridge is scalar only.  It does not promote `eq:LSI-KL-FI`,
`probability.lsi_to_kl_fi`, or the FI chain-rule backend.

## Cycle 34 Upper Forward-KL Derivative Scalar Slice

Priority check before lower assignment: (1) `lem:gronwall` remains open after
partial local real-analysis sublemmas, (2) `lem:dv_variation` remains
source-cited with scalar consequences, (3) `eq:LSI-KL-FI` remains open after
cycle 33 scalar density-test work, so this cycle targets item (4), the
continuous forward-KL Fokker--Planck/KL derivative identity.  The Euler--
Maruyama interpolation Fokker--Planck backend stays item (5).

Source fragment:

| Source step | Lean declaration | Status |
|---|---|---|
| `appendix.tex:168-174`: derivative display `dK/ds = firstTerm + targetTerm`. | input to `SALD.forwardKlFirstTermFisherSubstitutionScalar` and `SALD.forwardKlPostYoungDerivativeBoundScalar` | analytic obligation |
| `appendix.tex:176-185`: SALD Fokker--Planck and integration by parts give `firstTerm=-FI`. | input to `SALD.forwardKlPostYoungDerivativeBoundScalar` | analytic obligation |
| `appendix.tex:199-208`: target-side integration by parts and Young give `targetTerm <= (1/2)*FI+(1/2)*velocitySq`. | `SALD.forwardKlTargetTransportYoungBoundScalar`; `SALD.forwardKlPostYoungDerivativeBoundOfCauchyScalar` after the analytic Cauchy input is supplied | formalized scalar Young sublemma plus analytic obligation |
| `appendix.tex:210-217`: LSI gives `C_LSI*K <= (1/2)*FI`. | input to `SALD.forwardKlLsiDerivativeBoundScalar` | LSI obligation |
| `appendix.tex:218-228`: inverse-schedule time change produces the `dot{s}(t)^(-1)` coefficient. | `SALD.forwardKlTimeChangedDerivativeBoundScalar` after `SALD.forwardKlScheduleTimeChangeObligation` supplies the analytic chain rule, velocity-square scaling, inverse derivative, and positivity inputs | formalized scalar sublemma plus obligation |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 34 lower target-side Young scalar | Convert the supplied Cauchy bound `targetTerm <= sqrt(FI)*sqrt(velocitySq)` to the source `1/2`-`1/2` Young bound and feed it into the post-Young derivative bookkeeping. | target-side transport/integration-by-parts and Cauchy input; nonnegative FI and velocity square | `SALD.forwardKlTargetTransportYoungBoundScalar`; `SALD.forwardKlPostYoungDerivativeBoundOfCauchyScalar`; `SALD.cycle34ForwardKlTargetYoungLowerObligation` | `appendix.tex:199-208` | `sald.forward_kl.kl_derivative`; `thm:forward-KL` | formalized scalar sublemma plus obligation |
| Cycle 34 post-Young scalar derivative | Combine the supplied derivative display, first-term Fisher identity, and target Young bound. | `SALD.forwardKlFirstTermFisherSubstitutionScalar`; target-side Young input | `SALD.forwardKlPostYoungDerivativeBoundScalar` | `appendix.tex:168-208` | `sald.forward_kl.kl_derivative`; `thm:forward-KL` | formalized scalar sublemma |
| Cycle 34 LSI scalar handoff | Replace `-(1/2)*FI` by `-C_LSI*K` after a supplied LSI half-Fisher comparison. | `probability.lsi_to_kl_fi` as an open source comparison input | `SALD.forwardKlLsiDerivativeBoundScalar` | `appendix.tex:210-217` | `sald.forward_kl.kl_derivative`; `thm:forward-KL` | formalized scalar sublemma |
| Cycle 34 time-change scalar handoff | Convert the supplied `s`-time derivative bound to the `t`-time pre-DV inequality, preserving the source coefficient `(1/2)*dot{s}(t)^(-1)`. | `SALD.forwardKlScheduleTimeChangeObligation` inputs: chain rule, `||tilde v||^2` scaling, inverse derivative, `dot{s}` nonnegative/nonzero | `SALD.forwardKlTimeChangedDerivativeBoundScalar`; `SALD.cycle34ForwardKlDerivativeMiddleContract`; `SALD.cycle34ForwardKlDerivativeMiddleObligation` | `appendix.tex:218-228` | `sald.forward_kl.kl_derivative`; `thm:forward-KL` | formalized scalar sublemma plus obligation |
| Cycle 34 upper/middle packet | Assign only the derivative scalar proof slice and keep analytic backends explicit. | cycle-30 derivative-side ledger; cycle-33 LSI scalar bridge; schedule-time-change obligation | `SALD.cycle34ForwardKlDerivativeUpperPacket`; `SALD.cycle34ForwardKlDerivativeMiddleContract`; `SALD.cycle34ForwardKlDerivativeScalarObligation`; `ASTIS.SALD.forward_KL.cycle34_derivative_scalar` | `appendix.tex:168-228` | `thm:forward-KL` | obligation |

Lower packet:

- target the compiled scalar lemmas first;
- lower cycle 34 adds the target-side Young scalar closure for
  `appendix.tex:199-208`; the analytic target transport, integration by
  parts, and Cauchy--Schwarz input remain obligations;
- for `appendix.tex:218-228`, use the compiled time-change scalar lemma only
  after the analytic schedule inputs are supplied; DV, Gronwall, endpoint
  rewrites, and EM interpolation stay in their named obligations.

No theorem statement, coefficient, or source route is changed.

## Cycle 35 Upper EM Interpolation Fokker--Planck Packet

Priority check before lower assignment: (1) `lem:gronwall` remains open after
cycle 31 local real-analysis sublemmas, (2) `lem:dv_variation` remains
source-cited with cycle 32 scalar consequences, (3) `eq:LSI-KL-FI` remains
open after cycle 33 density-test scalar lemmas, and (4) the continuous
forward-KL derivative block has cycle 34 scalar handoffs while the analytic
Fokker--Planck backend stays open.  Cycle 35 therefore selects proof-closure
item (5), the Euler--Maruyama interpolation endpoint and conditional-drift
Fokker--Planck backend.

Source fragment:

| Source step | Lean declaration | Status |
|---|---|---|
| `appendix.tex:260-266`: frozen continuous interpolation `hat X_s = X_k^eta +(s-s_k) nabla log pi_{t_k}(X_k^eta)+sqrt2(W_s-W_{s_k})`. | `SALD.discreteSaldEulerMaruyamaContract`; `SALD.discreteForwardKlEmEndpointObligation` | endpoint obligation |
| `appendix.tex:334-335`: endpoint laws `hat rho_{s_k}=rho_k^eta`, `hat rho_{s_{k+1}}=rho_{k+1}^eta`. | input to `SALD.discreteForwardKlEmInterpolationSideConditionContract` | obligation |
| `appendix.tex:347-354`: conditional drift `bar b_{k,s}`. | `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract`; `SALD.cycle15DiscreteForwardKlConditionalDriftDensityObligation` | obligation |
| `appendix.tex:357-385`: conditional-drift Fokker--Planck equation and Laplacian split relative to `tilde pi_s`. | `SALD.discreteForwardKlEmConditionalFpObligation`; `SALD.discreteForwardKlEmInterpolationObligation` | obligation |
| Cycle 35 upper handoff. | `SALD.cycle35DiscreteForwardKlEmFpUpperPacket`; `SALD.cycle35DiscreteForwardKlEmFpUpperObligation` | workflow obligation |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 35 EM-FP upper packet | Re-select the existing EM endpoint and conditional-drift Fokker--Planck interfaces as the current lower target after the earlier proof-closure slices, without reopening discrete coefficient or accumulated-error work. | `SALD.cycle15DiscreteForwardKlUpperPacket`; `SALD.cycle15DiscreteForwardKlMiddleContract`; endpoint, conditional-drift density, conditional-FP, and EM interpolation obligations | `SALD.cycle35DiscreteForwardKlEmFpUpperPacket`; `SALD.cycle35DiscreteForwardKlEmFpUpperObligation`; `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_upper` | `appendix.tex:260-385`; endpoint use `appendix.tex:334-335` | `thm:forward-KL-discrete`; cycle 35 lower EM-FP packet | obligation |
| EM endpoint law interface | Formalize or precisely interface the endpoint laws of the frozen interpolation on a fixed interval. | `eq:frozen_interp_terminal_disc_prop_additive_final`; Euler-Maruyama contract | `SALD.discreteForwardKlEmEndpointObligation`; `sald.discrete_forward_kl.em_endpoint_laws` | `appendix.tex:260-266`, `appendix.tex:334-335` | stitched interval regularity; discrete derivative block | obligation |
| Conditional-drift Fokker--Planck backend | Build the regular conditional-law/density interface for `bar b_{k,s}` and derive the conditional-drift Fokker--Planck equation plus Laplacian split. | conditional drift density obligation; FokkerPlanck, KL, FI vocabulary | `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract`; `SALD.discreteForwardKlEmConditionalFpObligation`; `SALD.discreteForwardKlEmInterpolationObligation` | `appendix.tex:347-385` | `sald.discrete_forward_kl.kl_derivative`; `thm:forward-KL-discrete` | obligation |

Mode discipline:

- `faithfulPaper`; use only the original `main_body.tex` and `appendix.tex`,
  with `sald_version_2.tex` excluded.
- Preserve `thm:forward-KL-discrete`, the linear slowdown `t(s)=s/r`, and all
  `Gamma`, `Delta`, `barGamma`, `barDelta`, `alpha`, `alpha'`, `eta`, and `r`
  constants.
- Do not add theorem-level smoothness, density, disintegration, or boundary
  assumptions to close the conditional-FP backend.

Lower packet:

- target exactly `SALD.discreteForwardKlEmInterpolationSideConditionContract`
  and `SALD.discreteForwardKlEmConditionalFpObligation`;
- first try one proof-producing Lean interface: endpoint-law algebra for
  `hat X_{s_k}`/`hat X_{s_{k+1}}`, or the conditional-law/density interface
  for `bar b_{k,s}`;
- if the analytic conditional-drift Fokker--Planck theorem is too large for
  the local Mathlib state, record a precise source-cited interface depending
  on `sald.discrete_forward_kl.conditional_drift_density` and keep it below
  formalized status;
- keep endpoint stitching, frozen one-step Gamma/Delta defects, LSI, DV,
  Gronwall, and accumulated-error collection outside this lower attempt.

Reviewer checklist:

- `SALD.discreteForwardKlProofDag` contains
  `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_upper` before derivative, DV,
  and Gronwall blocks.
- `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes the cycle
  35 packet and obligation while retaining the cycle 15 EM obligations.
- `SALD.discreteSaldContract` lists
  `SALD.cycle35DiscreteForwardKlEmFpUpperObligation`.
- No source theorem, coefficient, file selection, or analytic dependency
  status is changed.

## Cycle 35 Middle EM Endpoint And Conditional-FP Algebra

Priority check before lower work remains unchanged: Gronwall, DV, LSI/KL/FI,
and continuous forward-KL derivative still have only partial scalar or
source-cited slices, so this cycle is item (5), the EM interpolation
Fokker--Planck backend.  The middle pass translates `appendix.tex:260-385`
into proof-producing local algebra without promoting the analytic backend.

Source-to-Lean additions:

| Source step | Lean declaration | Status |
|---|---|---|
| `appendix.tex:260-266`: at `s=s_k`, both the time increment and Brownian increment vanish. | `SALD.discreteForwardKlEmInterpolationLeftEndpointVector` | formalized local vector algebra |
| `appendix.tex:260-266` with endpoint use at `appendix.tex:334-335`: at `s=s_{k+1}`, the interpolation equals the supplied EM update after `s_{k+1}-s_k=eta`. | `SALD.discreteForwardKlEmInterpolationRightEndpointVector` | formalized local vector algebra |
| `appendix.tex:377-385`: regroup `-div(rho*bbar)+div(rho*A)+div(rho*grad log tilde pi)` as `div(rho*A)+div(rho*(grad log tilde pi-bbar))` after divergence linearity is supplied. | `SALD.discreteForwardKlConditionalFpDivergenceDriftSplit` | formalized local additive algebra |
| Middle source-to-Lean map for the cycle. | `SALD.cycle35DiscreteForwardKlEmFpMiddleContract`; `SALD.cycle35DiscreteForwardKlEmFpMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_middle` | obligation with compiled algebra substeps |

Remaining obligations:

- `sald.discrete_forward_kl.em_endpoint_laws`: lift the pointwise endpoint
  algebra to stochastic law equalities for `hat rho_s`.
- `sald.discrete_forward_kl.conditional_drift_density`: construct the regular
  conditional law, density, measurability, and integrability interface for
  `bar b_{k,s}`.
- `sald.discrete_forward_kl.em_conditional_fokker_planck`: prove or cite the
  conditional-drift Fokker--Planck equation and Laplacian split before using
  the divergence regrouping lemma.
- `sald.discrete_forward_kl.stitched_interval_regularity`: stitch the
  interval-wise endpoint laws for the final Gronwall application.

The new Lean lemmas are theorem-independent algebra only.  They do not close
endpoint laws, density regularity, the conditional Fokker--Planck theorem,
integration by parts, LSI, DV, Gronwall, or `thm:forward-KL-discrete`.

## Cycle 35 Lower Conditional-FP Split Handoff

Lower proof-producing refinement for `appendix.tex:357-385`: after the analytic
conditional-drift Fokker--Planck equation and the analytic Laplacian split are
supplied, the remaining source transition to the regrouped divergence form is
now local Lean algebra.

| Source step | Lean declaration | Status |
|---|---|---|
| `appendix.tex:357-364`: supply `partial_s hat rho_s = -div(hat rho_s bar b_{k,s}) + Delta hat rho_s`. | hypothesis `hfp` of `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff`; obligation `sald.discrete_forward_kl.em_conditional_fokker_planck` | obligation |
| `appendix.tex:365-374`: supply the Laplacian split relative to `tilde pi_s`. | hypothesis `hlap` of `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff`; obligation `sald.discrete_forward_kl.em_conditional_fokker_planck` | obligation |
| `appendix.tex:377-385`: compose the two supplied identities and divergence linearity to get the final regrouped RHS. | `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff`; `SALD.cycle35DiscreteForwardKlEmFpLowerObligation`; DAG block `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_lower` | formalized local algebra + obligation |

Remaining obligations are unchanged: construct the conditional drift density and
measurability interface for `bar b_{k,s}`, prove or source-cite the conditional
Fokker--Planck theorem and Laplacian/chain-rule split, justify integration by
parts in the KL derivative, and later handle LSI, DV, Gronwall, and accumulated
error collection.  No theorem statement, coefficient, source file, or analytic
dependency status is changed.

## Cycle 36 Gronwall Upper Proof-Closure Packet

Priority check before middle/lower assignment: (1) `lem:gronwall` remains open
after cycle 31 local derivative, order-integration, endpoint, and exponent
sublemmas; (2) `lem:dv_variation` remains source-cited with cycle 32 scalar
consequences; (3) `eq:LSI-KL-FI` remains open after cycle 33 density-test
scalar lemmas; (4) the forward-KL Fokker--Planck/KL derivative identity still
depends on analytic backends after cycle 34 scalar handoffs; and (5) the EM
interpolation Fokker--Planck backend has cycle 35 endpoint/divergence algebra
only.  Cycle 36 therefore returns to item (1), `appendix.tex:47-71`.

Source fragment:

| Source step | Lean declaration | Status |
|---|---|---|
| `appendix.tex:47-54`: Gronwall statement with continuous `a_t,b_t`, differentiable `K_t`, and `dK/dt <= -a_t K_t + b_t`. | `SALD.saldGronwallCandidateContract`; `SALD.gronwallContract` | obligation |
| `appendix.tex:58-61`: differentiate `exp(int_0^t a) K_t` and use the differential inequality. | `SALD.gronwallIntegratingFactorDerivativeLeOfIntegral` plus scalar helpers | formalized local sublemmas |
| `appendix.tex:62-65`: integrate the derivative inequality and evaluate the endpoints. | `SALD.gronwallOrderIntegrationOfHasDerivAt`; `SALD.gronwallEndpointEvaluationScalar`; `SALD.gronwallEndpointMultiplyByExpNegScalar` | formalized local sublemmas plus obligation |
| `appendix.tex:65-69`: rewrite the product of exponentials inside the `b_t` integral. | `SALD.gronwallExpProductRewriteIntegralCongr`; `SALD.gronwallExponentRewriteObligation` | formalized congruence helper plus obligation |
| Cycle 36 upper assignment. | `SALD.cycle36GronwallUpperPacket`; `SALD.cycle36GronwallUpperObligation`; `sald.gronwall.cycle36_upper_packet` | workflow obligation |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 36 Gronwall upper packet | Select the global assembly of the original integrating-factor proof as the lower target, using existing compiled local helpers without changing the source statement. | cycle 31 derivative/order/endpoint helpers; exponent rewrite congruence; closed-interval FTC/integrability backend | `SALD.cycle36GronwallUpperPacket`; `SALD.cycle36GronwallUpperObligation` | `appendix.tex:47-71` | `lem:gronwall`; all SALD Gronwall applications | obligation |
| Gronwall global assembly | Produce the final source display from explicit global interval hypotheses for `F(t)=exp(int_0^t a)*K(t)`, its derivative representative, `g(t)=exp(int_0^t a)*b(t)`, and adjacent interval-integrability of `a`. | `SALD.gronwallIntegratingFactorDerivativeLeOfIntegral`; `SALD.gronwallOrderIntegrationOfHasDerivAt`; endpoint helpers; `SALD.gronwallExpProductRewriteIntegralCongr` | `SALD.gronwallIntegratingFactorBoundOfDerivatives`; `SALD.gronwallIntegratingFactorBoundOfIntegral`; `SALD.gronwallIntegratingFactorBoundOfContinuousData` | `appendix.tex:58-69` | `SALD.gronwallContract` | formalized local assembly plus obligation |
| Closed-interval calculus backend | Resolve the source phrase "differentiable on `[0,t_1]`" as endpoint-safe `HasDerivWithinAt` or an absolute-continuity/FTC interface. | Mathlib interval-integral FTC; interval-integrability of derivative/input functions; endpoint semantics | `SALD.gronwallEndpointCalculusObligation` | `appendix.tex:55-63` | all Gronwall applications | obligation |

Mode discipline:

- `faithfulPaper`; use only the original `appendix.tex:47-71`, with
  `sald_version_2.tex` excluded.
- Preserve the exact source signs and endpoint display; do not add sign
  assumptions on `a` or `b`.
- Keep downstream theorem-specific Gronwall side conditions for forward-KL,
  discrete forward-KL, and general moving-target SALD as separate obligations.

Lower packet:

- target exactly `SALD.saldGronwallCandidateContract`,
  `SALD.saldGronwallEndpointCalculusContract`,
  `SALD.saldGronwallExponentRewriteContract`, and the obligations
  `sald.gronwall.integrating_factor`, `sald.gronwall.endpoint_calculus`,
  `sald.gronwall.exponent_rewrite`;
- first attempt a proof-producing assembly lemma under explicit global
  interval hypotheses, reusing the cycle 31 helpers and exponent congruence;
- if the closed-interval derivative/FTC backend is blocked, introduce one
  precise interface for the needed calculus theorem and keep it at obligation
  or source-cited status rather than promoting `lem:gronwall`.

Reviewer checklist:

- `SALD.gronwallContract` remains `ProofStatus.obligation`;
- `SALD.saldDependenciesForLabel "lem:gronwall"` includes the cycle 36 packet
  and obligation while retaining the compiled helper declarations;
- no source-index rebaseline, theorem-constant change, hidden sign assumption,
  alternate Gronwall theorem, or fake proof closure appears.

## Cycle 36 Middle Gronwall Assembly

Middle proof-producing refinement for `appendix.tex:58-69`: the original
integrating-factor proof now has a compiled global assembly under explicit
Mathlib side conditions.  This narrows the remaining `lem:gronwall` gap to the
source-to-Mathlib regularity bridge from continuous `a_t,b_t` and
differentiable `K_t` on `[0,t_1]` to interval-integrability and endpoint-safe
derivative hypotheses.

| Source step | Lean declaration | Status |
|---|---|---|
| `appendix.tex:65-69`: move `exp(-int_0^t1 a)` through the `b_t` integral and rewrite the exponent using interval additivity. | `SALD.gronwallEndpointIntegralRewrite` | formalized local interval/exponential assembly |
| `appendix.tex:58-69`: assemble product differentiation, order integration, endpoint multiplication, and exponent rewrite from supplied derivative/integrability hypotheses. | `SALD.gronwallIntegratingFactorBoundOfDerivatives` | formalized local Gronwall assembly |
| `appendix.tex:58-61`: derive `d/dt int_0^t a=a(t)` from Mathlib interval-integral FTC at each point before the same assembly. | `SALD.gronwallIntegratingFactorBoundOfIntegral` | formalized local Gronwall assembly plus explicit FTC side conditions |
| `appendix.tex:47-71`: use continuity of the coefficient data to supply interval-integrability and the local FTC side conditions for `a`, `b`, and the integrating-factor products. | `SALD.gronwallCoefficientSideConditionsOfContinuous`; `SALD.gronwallIntegratingFactorBoundOfContinuousData` | formalized lower continuous-data wrapper plus explicit derivative-witness side conditions |
| Cycle 36 middle ledger. | `SALD.cycle36GronwallMiddleObligation`; `sald.gronwall.cycle36_middle_assembly` | obligation with formalized local subtheorems |

Remaining obligations:

- derive a globally continuous derivative witness `K'`, or replace it with an
  endpoint-safe closed-interval/absolute-continuity backend, from the paper's
  concise differentiability statement;
- choose the endpoint semantics for differentiability on `[0,t_1]`;
- keep theorem-specific coefficient regularity for forward-KL, discrete
  forward-KL, and general moving-target SALD as separate obligations.

`SALD.gronwallContract` remains `ProofStatus.obligation`; no sign assumption on
`a` or `b`, theorem-status promotion, source-index rebaseline, or alternate
Gronwall theorem was introduced.

## Cycle 36 Lower Continuous-Data Gronwall Wrapper

Lower proof-producing refinement for the same `appendix.tex:47-71` proof:
`SALD.gronwallCoefficientSideConditionsOfContinuous` packages the Mathlib
`Continuous.intervalIntegrable`, `Continuous.stronglyMeasurableAtFilter`, and
`ContinuousAt` facts needed for `a`.  `SALD.gronwallIntegratingFactorBoundOfContinuousData`
then proves the paper's final displayed bound from global continuity of
`a`, `b`, `K`, and the selected derivative witness `K'`, together with the
pointwise derivative inequality on `[0,t_1]`.

This does not close `lem:gronwall`: the original paper only says `K_t` is
differentiable on `[0,t_1]`, so the remaining faithful bridge is to formalize
that endpoint-safe differentiability/absolute-continuity interface without
adding hidden smoothness assumptions to the theorem contract.

## Cycle 39 Upper Forward-KL Derivative Packet

Priority check before lower assignment: (1) `lem:gronwall` has cycle 36 local
assembly progress but remains an obligation, (2) `lem:dv_variation` has
one-sided scalar consequences while the Boucheron equality remains
source-cited, (3) `eq:LSI-KL-FI` has cycle 38 finite-coordinate Fisher-chain
progress but the vector/integral density-test backend remains an obligation,
so this cycle follows the requested item (4): the continuous forward-KL
Fokker--Planck/KL derivative identity in `appendix.tex:168-228`.  The
Euler--Maruyama interpolation Fokker--Planck backend remains item (5).

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 39 derivative upper packet | Keep `thm:forward-KL` fixed and assign lower work to theorem-specific derivative closure before any ledger expansion. | cycle 30 density/FI side conditions; cycle 34 scalar derivative handoffs; cycle 38 LSI half-Fisher bridge; schedule-time-change obligation | `SALD.cycle39ForwardKlDerivativeUpperPacket`; `SALD.cycle39ForwardKlDerivativeUpperObligation`; `ASTIS.SALD.forward_KL.cycle39_derivative_upper` | `appendix.tex:168-228` | `thm:forward-KL`; `sald.forward_kl.kl_derivative` | obligation |
| Pre-DV scalar derivative pipeline | Compose supplied KL derivative display, first-term Fisher identity, target Cauchy/Young, LSI half-Fisher, chain-rule, velocity scaling, and inverse-schedule inputs into the paper's t-time pre-DV inequality. | `SALD.forwardKlPostYoungDerivativeBoundOfCauchyScalar`; `SALD.forwardKlLsiDerivativeBoundScalar`; `SALD.forwardKlTimeChangedDerivativeBoundScalar` | `SALD.forwardKlPreDvDerivativeBoundScalar` | `appendix.tex:168-228` | `sald.forward_kl.kl_derivative`; DV velocity-energy step | formalized local scalar core |
| Remaining analytic derivative inputs | Supply mass conservation, differentiation under the KL integral, SALD Fokker--Planck/integration by parts, target transport/Cauchy, LSI density-test, and inverse-schedule calculus without adding theorem hypotheses. | `SALD.forwardKlDensityBoundaryObligation`; `SALD.forwardKlScheduleTimeChangeObligation`; `probability.lsi_to_kl_fi` | `sald.forward_kl.density_boundary_regular`; `sald.forward_kl.schedule_time_change`; `sald.forward_kl.kl_derivative` | `appendix.tex:168-228` | `thm:forward-KL` | obligation |

Lower packet:

- first verify or extend the theorem-specific scalar composition around
  `SALD.forwardKlPreDvDerivativeBoundScalar`, keeping all analytic premises
  explicit;
- next refine `sald.forward_kl.density_boundary_regular` for
  `appendix.tex:168-185`;
- then refine `sald.forward_kl.schedule_time_change` for
  `appendix.tex:191-228`;
- leave DV, Gronwall, endpoint rewrites, coefficient-chain audit, and EM
  interpolation as sibling obligations.

Reviewer checklist:

- `SALD.forwardKlPreDvDerivativeBoundScalar` is a scalar Real/order theorem
  and does not prove Fokker--Planck, integration by parts, LSI, or
  inverse-schedule calculus;
- `SALD.forwardKlProofDag` and `SALD.saldDependenciesForLabel "thm:forward-KL"`
  include the cycle 39 packet and obligation;
- `sald.forward_kl.kl_derivative`, `sald.forward_kl.density_boundary_regular`,
  `sald.forward_kl.schedule_time_change`, `probability.lsi_to_kl_fi`, DV, and
  Gronwall remain obligations or source-cited dependencies.

## Cycle 39 Middle Forward-KL Schedule Handoff

Middle priority check is unchanged: Gronwall, DV, and the full LSI/KL/FI
density-test backend remain earlier obligations or source-cited dependencies,
so this pass stays on proof-closure item (4), `appendix.tex:168-228`.

| Source step | Lean declaration | Input still analytic | Status |
|---|---|---|---|
| `appendix.tex:191-197`: `\tilde v_s=\dot t(s)v_{t(s)}` gives the velocity-square scaling. | `SALD.forwardKlVelocitySquareScalingScalar` | L2 norm-square identities for `\tilde v_s` and `v_{t(s)}` supplied by slowed-target transport backend | formalized scalar algebra |
| `appendix.tex:218-228`: inverse schedule rewrites `\dot t(s(t))` as `\dot s(t)^{-1}`. | `SALD.forwardKlInverseScheduleDerivativeScalar`; `SALD.forwardKlTimeChangeSquareCoefficientRewriteOfProductScalar` | inverse-function theorem/product identity `dotS*dotT=1` and positivity/nonzero side conditions | formalized scalar algebra |
| Source-shaped time-change derivative handoff. | `SALD.forwardKlTimeChangedDerivativeBoundOfProductScalar` | KL chain rule `dKdt=dotS*dKds`, s-time LSI derivative bound, velocity-square scaling | formalized scalar/order handoff |
| Source-shaped pre-DV derivative pipeline. | `SALD.forwardKlPreDvDerivativeBoundOfProductScalar`; `SALD.forwardKlPreDvDerivativeBoundOfVelocityScalingScalar` | KL derivative display, first-term FI identity, target Cauchy, LSI half-Fisher, schedule product identity, velocity norm-square inputs | formalized local scalar core |
| Lower source-shaped LSI/KL/FI input. | `SALD.forwardKlLsiDerivativeBoundOfKlFiScalar`; `SALD.forwardKlPreDvDerivativeBoundOfKlFiVelocityScalingScalar` | source `KL <= FI/(2*C_LSI)` comparison from `eq:LSI-KL-FI`, positive `C_LSI`, KL derivative display, target Cauchy, schedule product identity, and velocity norm-square inputs | formalized local scalar core |
| Cycle 39 middle ledger and DAG block. | `SALD.cycle39ForwardKlDerivativeMiddleContract`; `SALD.cycle39ForwardKlDerivativeMiddleObligation`; `ASTIS.SALD.forward_KL.cycle39_derivative_middle` | `sald.forward_kl.density_boundary_regular`, `sald.forward_kl.schedule_time_change`, `probability.lsi_to_kl_fi`, `sald.forward_kl.kl_derivative` | obligation with compiled scalar sublemmas |

The new declarations replace neither `sald.forward_kl.schedule_time_change` nor
`sald.forward_kl.density_boundary_regular`: they only reduce those obligations
to source-shaped scalar inputs before the full derivative theorem is attempted.
DV, Gronwall, endpoint rewrites, coefficient-chain audit, and EM interpolation
remain sibling obligations.

Lower update: `SALD.forwardKlLsiDerivativeBoundOfKlFiScalar` now compiles the
paper's direct `eq:LSI-KL-FI` handoff from `KL <= FI/(2*C_LSI)` to the
half-Fisher derivative premise.  `SALD.forwardKlPreDvDerivativeBoundOfKlFiVelocityScalingScalar`
threads that source-shaped LSI input through the cycle 39 velocity-scaling and
inverse-schedule scalar pipeline.  It does not prove the density-test LSI
backend, the KL derivative/Fokker--Planck identity, target transport, or the
inverse-function calculus.

## Cycle 40 Middle EM Endpoint Law Handoff

Priority check: the earlier closure targets still have open analytic backends
after their local scalar/real-analysis progress, so this middle pass follows
item (5), the Euler--Maruyama interpolation Fokker--Planck backend for
`appendix.tex:260-385`.

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `appendix.tex:260-266`: define the frozen interpolation `hat X_s`. | Existing pointwise endpoint lemmas `SALD.discreteForwardKlEmInterpolationLeftEndpointVector` and `SALD.discreteForwardKlEmInterpolationRightEndpointVector` | project-level Brownian/EM process notation |
| `appendix.tex:334-335`: use `hat rho_{s_k}=rho_k^eta` and `hat rho_{s_{k+1}}=rho_{k+1}^eta`. | `SALD.discreteForwardKlLawEqOfPointwise`; `SALD.discreteForwardKlEmInterpolationLeftEndpointLawHandoff`; `SALD.discreteForwardKlEmInterpolationRightEndpointLawHandoff`; `SALD.discreteForwardKlEmEndpointLawPairHandoff` | concrete Brownian/law/density definitions for the named representations of `hat rho_s`, `rho_k^eta`, and `rho_{k+1}^eta` |
| `appendix.tex:347-354`: define `bar b_{k,s}` by conditional expectation. | `SALD.cycle15DiscreteForwardKlConditionalDriftDensityContract`; `sald.discrete_forward_kl.conditional_drift_density` | regular conditional law, measurability, integrability |
| `appendix.tex:357-385`: invoke conditional-drift FP and split/regroup the Laplacian. | `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff`; `sald.discrete_forward_kl.em_conditional_fokker_planck` | conditional-drift Fokker--Planck theorem, Laplacian chain-rule split, boundary/integration-by-parts backend |
| Cycle 40 ledger and DAG node. | `SALD.cycle40DiscreteForwardKlEmFpMiddleContract`; `SALD.cycle40DiscreteForwardKlEmFpMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle40_em_fp_middle` | obligation with compiled endpoint-law sublemmas |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 40 EM endpoint law handoff | Convert pointwise EM endpoint identities into abstract law equalities before lower work on concrete endpoint laws and conditional drift. | cycle 35 endpoint vector lemmas; cycle 35 conditional-FP regrouping; endpoint law obligation; conditional drift density obligation | `SALD.cycle40DiscreteForwardKlEmFpMiddleContract`; `SALD.cycle40DiscreteForwardKlEmFpMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle40_em_fp_middle` | `appendix.tex:260-385`; endpoint use `appendix.tex:334-335` | `thm:forward-KL-discrete`; next lower EM endpoint/conditional-FP packet | obligation with formalized abstract law handoffs |
| Cycle 40 EM endpoint lower pair | Prove both endpoint law equalities from explicit named-law representation hypotheses for the frozen interpolation and EM update. | cycle 40 endpoint-law handoffs; endpoint law obligation; concrete law notation still missing | `SALD.discreteForwardKlEmEndpointLawPairHandoff`; `SALD.cycle40DiscreteForwardKlEmEndpointLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle40_em_endpoint_lower` | `appendix.tex:260-266`; endpoint use `appendix.tex:334-335` | `sald.discrete_forward_kl.em_endpoint_laws`; `thm:forward-KL-discrete` | formalized representation handoff plus obligation |

Lower packet:

- cycle 40 lower now proves the endpoint-law pair once explicit named-law
  representations for `hat rho_s`, `rho_k^eta`, and `rho_{k+1}^eta` are
  supplied; the concrete Brownian/law/density definitions remain the endpoint
  obligation;
- then refine `sald.discrete_forward_kl.conditional_drift_density`;
- only after that state or prove the source-cited conditional-drift
  Fokker--Planck theorem consumed by the existing Laplacian-split handoff;
- keep frozen-delta, LSI, DV, Gronwall, coefficient-chain, and
  accumulated-error work outside this lower packet.

## Cycle 41 Middle Gronwall Derivative Wrapper

Priority check: this cycle returns to proof-closure item (1),
`lem:gronwall`, before DV, LSI/KL/FI, forward-KL derivative, and EM
interpolation Fokker--Planck.  The source anchor remains
`appendix.tex:47-71`; no source-index rebaseline was needed.

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `appendix.tex:47-54`: assume continuous `a_t,b_t`, differentiable `K_t`, and `dK_t/dt <= -a_t K_t + b_t`. | `SALD.gronwallIntegratingFactorBoundOfDifferentiable` uses `deriv K` for the paper derivative and keeps the same final bound. | justify the product-derivative interval-integrability side condition from the source's endpoint-safe differentiability/FTC interpretation |
| `appendix.tex:58-61`: differentiate the integrating factor and substitute the source inequality. | existing `SALD.gronwallIntegratingFactorBoundOfIntegral`; new wrapper supplies `HasDerivAt K (deriv K t) t` from `Differentiable Real K`. | closed-interval endpoint semantics for "differentiable on `[0,t1]`" |
| `appendix.tex:62-69`: integrate, evaluate endpoints, multiply by `exp(-int_0^t1 a)`, and rewrite the exponent in the `b_t` integral. | existing `SALD.gronwallEndpointIntegralRewrite`; `SALD.gronwallIntegratingFactorBoundOfDifferentiable` delegates to the compiled cycle 36 assembly. | none beyond the explicit FTC/integrability side condition |
| C1-compatible backend for the same source display. | `SALD.gronwallIntegratingFactorBoundOfC1` discharges the product-derivative integrability condition when `deriv K` is continuous. | this is a precise backend option, not a promotion of the paper's bare differentiability wording to formalized status |
| Endpoint-safe FTC/order-integration bridge. | `SALD.gronwallOrderIntegrationOfHasDerivRight` integrates the derivative inequality using continuity on `[0,t1]` and right derivatives on `(0,t1)`; `SALD.gronwallIntegratingFactorBoundOfInteriorDerivatives` threads this through the existing endpoint and exponent helpers. | identify the source phrase "differentiable on `[0,t1]`" with this C1-compatible or absolute-continuity backend before promoting `lem:gronwall` |
| Interior C1 backend option. | `SALD.gronwallIntegratingFactorBoundOfInteriorContinuousData` and `SALD.gronwallIntegratingFactorBoundOfInteriorC1` prove the same displayed bound without endpoint derivative hypotheses on `K`. | still below the paper's bare differentiability wording; no sign assumptions on `a` or `b` |
| Cycle 41 ledger. | `SALD.cycle41GronwallMiddleObligation`; `sald.gronwall.cycle41_deriv_wrapper` | obligation with formalized local wrappers |
| Cycle 41 lower ledger. | `SALD.cycle41GronwallLowerObligation`; `sald.gronwall.cycle41_interior_endpoint_bridge` | obligation with formalized endpoint-safe local bridge |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Source derivative wrapper | Replace the arbitrary derivative witness `K'` in the cycle 36 assembly by Mathlib's `deriv K`, preserving the displayed source bound. | continuous `a,b`; `Differentiable Real K`; source-shaped `deriv K` inequality; product-derivative integrability; cycle 36 assembly | `SALD.gronwallIntegratingFactorBoundOfDifferentiable` | `appendix.tex:47-71` | `lem:gronwall`; later Gronwall applications after their `K` regularity is instantiated | formalized local wrapper plus obligation |
| C1 backend option | Prove the product-derivative integrability condition from continuity of `deriv K`. | `SALD.gronwallIntegratingFactorBoundOfDifferentiable`; continuity closure of interval integrals | `SALD.gronwallIntegratingFactorBoundOfC1` | `appendix.tex:47-71` | candidate endpoint-safe Gronwall backend | formalized local wrapper plus obligation |
| Interior endpoint bridge | Use Mathlib right-derivative FTC to integrate on `[0,t1]` while differentiating only on `(0,t1)`. | continuity of the integrating-factor product on `[0,t1]`; right derivatives on `(0,t1)`; existing endpoint/exponent helpers | `SALD.gronwallOrderIntegrationOfHasDerivRight`; `SALD.gronwallIntegratingFactorBoundOfInteriorDerivatives` | `appendix.tex:62-69` | candidate endpoint-safe Gronwall backend | formalized local bridge plus obligation |
| Interior C1 backend | Discharge integrability and coefficient side conditions with continuous `a,b,K,deriv K` and differentiability of `K` only on `(0,t1)`. | interior endpoint bridge; continuous coefficient side conditions | `SALD.gronwallIntegratingFactorBoundOfInteriorContinuousData`; `SALD.gronwallIntegratingFactorBoundOfInteriorC1` | `appendix.tex:47-71` | candidate endpoint-safe Gronwall backend | formalized local wrapper plus obligation |

Remaining obligations:

- formalize, source-cite, or explicitly assume the endpoint-safe
  closed-interval/absolute-continuity interpretation of "K differentiable on
  `[0,t1]`" that justifies the FTC step;
- do not mark `SALD.gronwallContract` formalized until that bridge is closed;
- keep theorem-specific Gronwall coefficient regularity for forward-KL,
  discrete forward-KL, and general moving-target SALD as sibling obligations;
- no sign assumptions on `a` or `b` were added.

## Cycle 42 Middle DV Selected Scaled-Test Interface

Priority check: cycle 41 advanced `lem:gronwall` with endpoint-safe local
wrappers but left the source differentiability/FTC interpretation open, so
this pass returns to proof-closure item (2), `lem:dv_variation`.  Later
targets remain `eq:LSI-KL-FI`, the forward-KL derivative identity, and the EM
interpolation Fokker--Planck backend.

Exact source fragment:

```tex
\begin{lemma}[Corollary 4.15, \cite{boucheron2013concentration}]\label{lem:dv_variation}
    Let $\mu$ and $\nu$ be the probability distributions on the same space. Then,
    \[
        \KL(\nu \| \mu) = \sup_Z \left\{ \E_{\nu}[Z] - \log \E_{\mu}[\exp(Z)] \right\},
    \]
    where the supremum is taken over all random variables such that $\log \E_{\mu}[\exp(Z)] < + \infty$.
\end{lemma}
```

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `appendix.tex:73-79`: Boucheron DV equality over finite-log-mgf tests. | `dvVariationalFormulaInterface saldDvVariationSource`; `dvVariationalObligation saldDvVariationSource`; `SALD.dvContract` | full supremum equality remains source-cited |
| Finite-log-mgf predicate for SALD selected tests. | `AutoSamplingTheory.dvFiniteLogMgfOfLeAlpha` proves `Integrable exp(alpha0*q) -> Integrable exp(alpha*q)` for `0 <= alpha <= alpha0` under a finite measure. | identify each source `q` (`||v_t||^2`, `||m_t||^2`, frozen defects) and supply the theorem-specific alpha0 moment |
| First selected-test shape `Z=alpha*q`, covering `appendix.tex:230-241` with `q=||v_t||^2`. | `AutoSamplingTheory.dvVariationalOneSidedOfScaledTest` composes the finite-log-mgf handoff with `AutoSamplingTheory.dvVariationalOneSidedOfTiltedRight`. | supply `nu << mu`, `Integrable (alpha*q) nu`, probability/sigma-finite instances, and `Integrable (llr nu mu) nu` for the concrete SALD laws |
| Cycle 42 synchronization. | `SALD.cycle42DvVariationMiddleAuditContract`; `SALD.cycle42DvVariationMiddleObligation`; `SALD.saldDependenciesForLabel "lem:dv_variation"` | selected-test backend is formalized, but theorem-specific witness obligations remain |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| DV source equality | Source-cited Boucheron Cor. 4.15 formula. | cited result; common probability space; finite-log-mgf class | `dvVariationalFormulaInterface`; `probability.dv_variational_formula`; `SALD.dvContract` | `appendix.tex:73-79` | all SALD DV energy steps | source-cited |
| Scaled-test finite-log-mgf handoff | Convert alpha0 exponential integrability to alpha exponential integrability. | Mathlib `ProbabilityTheory.integrable_exp_mul_of_nonneg_of_le`; `0 <= alpha <= alpha0`; finite measure | `AutoSamplingTheory.dvFiniteLogMgfOfLeAlpha` | `appendix.tex:78`; first SALD use `appendix.tex:230-241` | `sald.dv_variation.finite_log_mgf_interface`; theorem-specific DV witnesses | formalized local sublemma |
| Selected scaled-test one-sided inequality | Prove `E_nu[alpha*q]-log E_mu[exp(alpha*q)] <= KL(nu||mu)` after explicit selected-test hypotheses. | finite-log-mgf handoff; tilted backend; absolute continuity; integrability; log-likelihood integrability | `AutoSamplingTheory.dvVariationalOneSidedOfScaledTest` | `appendix.tex:73-79`; first SALD use `appendix.tex:230-241` | forward-KL, discrete forward-KL, general moving-target DV witness obligations | formalized selected-test sublemma |
| Cycle 42 middle ledger | Keep the selected-test backend classified below the full DV equality. | cycle 37 tilted backend; source-cited equality; theorem-specific witness obligations | `SALD.cycle42DvVariationMiddleAuditContract`; `SALD.cycle42DvVariationMiddleObligation` | `appendix.tex:73-79` | reviewer and next lower packet | obligation |

Remaining obligations:

- instantiate one concrete source use, preferably `appendix.tex:230-241` with
  `nu=rho_{s(t)}`, `mu=pi_t`, and `q=||v_t||^2`;
- prove or source-cite the concrete common-space, absolute-continuity,
  selected-test integrability, and log-likelihood integrability witnesses;
- keep `SALD.dvContract` and `SALD.saldStatusForLabel "lem:dv_variation"` at
  `sourceCited`; this cycle did not formalize Boucheron Corollary 4.15.

## Cycle 44 Upper Main Skeleton Analytic Interface Ledger

Upper switched from isolated scalar sublemmas to theorem-level route closure.
The conversion window now has a single synchronization pane for the five slow
analytic interfaces and the six theorem skeletons that consume them.

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `appendix.tex:47-71`: endpoint-safe Gronwall integrating-factor lemma. | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.saldGronwallExponentRewriteContract`; cycle 36 and cycle 41 compiled wrappers | Source-compatible endpoint differentiability/FTC or absolute-continuity backend, plus theorem-specific coefficient regularity. |
| `appendix.tex:73-79`: Donsker--Varadhan variational formula. | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; cycle 37 and cycle 42 selected-test consequences | Full Boucheron supremum equality remains source-cited; concrete SALD common-space, absolute-continuity, finite-KL/log-likelihood, and finite-log-mgf witnesses remain obligations. |
| `main_body.tex:202-215`: LSI implies KL/FI through the `sqrt(rho/pi)` test. | `SALD.saldLsiKlFiDensityTestContract`; cycle 33/38/43 density, entropy, and Fisher-chain handoffs | Smooth/admissible test approximation, zero-density Sobolev handling, vector-gradient equivalence, finite theorem-level KL/FI, and full `probability.lsi_to_kl_fi`. |
| `appendix.tex:168-228`: continuous forward-KL derivative display. | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; cycle 30/34/39 derivative-side handoffs | Law/density regularity, SALD Fokker--Planck theorem, integration by parts, target transport, and inverse-schedule calculus. |
| `appendix.tex:260-385`: EM interpolation endpoint and conditional Fokker--Planck backend. | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; cycle 35 and cycle 40 EM endpoint/conditional-FP handoffs | Concrete endpoint laws, conditional drift density, conditional-law Fokker--Planck theorem, Laplacian split, stitched intervals, and EM common-space/absolute-continuity. |
| `appendix.tex:724-1603`: general and unified theorem route. | `SALD.cycle44MainSkeletonAnalyticInterfaceLedger`; `SALD.cycle44MainSkeletonAnalyticInterfaceObligation`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | Keep theorem contracts `contractOnly` until every analytic dependency builds locally. |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 44 Gronwall interface | Endpoint-safe differentiability/FTC assumptions, interval-integrability, endpoint evaluation, and exponent rewrite with source signs unchanged. | cycle 36 assembly; cycle 41 endpoint-safe wrappers | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.saldGronwallExponentRewriteContract`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `appendix.tex:47-71` | forward-KL; discrete forward-KL; continuous and discrete general moving target | obligation |
| Cycle 44 DV interface | Common-space, absolute-continuity, finite-KL/log-likelihood, selected-test measurability, finite-log-mgf, and one-sided consequences. | cycle 32 source-cited interface; cycle 37 tilted backend; cycle 42 scaled-test handoffs | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `appendix.tex:73-79` | all SALD DV energy steps | source-cited equality plus obligations |
| Cycle 44 LSI/KL/FI interface | Density, zero-set convention, admissible sqrt test, entropy identity, Fisher chain rule, and finite KL/FI side conditions. | cycle 33 scalar bridge; cycle 38 Fisher-chain handoffs; cycle 43 density/entropy and integral Fisher-chain handoffs | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `main_body.tex:202-215` | all theorem blocks using LSI contraction | obligation |
| Cycle 44 continuous derivative interface | Continuous Fokker--Planck/KL derivative with mass conservation, integration by parts, target transport, LSI handoff, and inverse-schedule calculus. | cycle 30 density/boundary; cycle 34 scalar derivative pipeline; cycle 39 schedule/velocity handoffs | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `appendix.tex:168-228` | `thm:forward-KL`; continuous general moving target backend | obligation |
| Cycle 44 EM interpolation interface | Endpoint laws, conditional drift, conditional-law density, interpolation Fokker--Planck, Laplacian split, stitched intervals, and EM law common-space. | cycle 35 EM algebra; cycle 40 endpoint law handoff; discrete side-condition contracts | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `appendix.tex:260-385`; `appendix.tex:1354-1387` | discrete forward-KL; discrete general moving target | obligation |
| Cycle 44 theorem skeleton route | Wire the five analytic interfaces into the source theorem order: forward-KL, discrete forward-KL, guided residual, general moving target, unified forward-KL, and discrete general moving target. | five interface rows; existing theorem contracts; `saldDependenciesForLabel` entries | `SALD.cycle44MainSkeletonAnalyticInterfaceLedger`; `SALD.cycle44MainSkeletonAnalyticInterfaceObligation`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | `main_body.tex:238-323`; `appendix.tex:724-1603` | ASTIS-SALD-001 main skeleton closure | obligation |

Mode discipline:

- The source theorem statements, constants, and source labels are unchanged.
- `sald_version_2.tex` remains out of scope.
- Unproved analytic backends stay at `obligation` or `sourceCited`.
- Systematic SLT or measure-theory backfill is deferred until this theorem
  route is stable.

## Cycle 44 Lower Forward-KL Post-DV Handoff

Lower kept the cycle-44 theorem route fixed and targeted the continuous
`thm:forward-KL` source slice `appendix.tex:230-244`.  This is the step after
the pre-DV derivative inequality and before the Gronwall call.

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| Insert the selected-test DV energy estimate into `dK/dt <= -(dot{s} C_LSI)K + coeff*energy` and collect the coefficient of `K`. | `SALD.forwardKlPostDvGronwallCoefficientScalar` | The actual SALD KL derivative/Fokker--Planck, LSI, selected-test DV witnesses, and coefficient nonnegativity remain theorem-specific obligations. |
| Specialize the handoff to the paper prefactor `(1/2)*dot{s}(t)^(-1)`. | `SALD.forwardKlPostDvGronwallCoefficientOfScheduleScalar` | Source inverse-schedule positivity and endpoint-safe Gronwall hypotheses remain obligations. |

Status: formalized scalar/order handoff only.  No theorem statement, source
constant, source label, or analytic backend status was changed.

## Cycle 45 Upper Continuous Forward-KL Skeleton Route

Upper kept the cycle-44 five-interface ledger and added a theorem-level wrapper
for the continuous `thm:forward-KL` route.  This cycle is not a new scalar
lemma: it wires the checked analytic interfaces into the source theorem display
and proof route for `main_body.tex:238-247` and `appendix.tex:164-252`.

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `main_body.tex:238-247`: statement with inverse slowdown, LSI constants, finite `alpha0` complexity, `alpha in (0,alpha0]`, and the two-exponential terminal bound. | `SALD.continuousForwardKlStatementContract`; `SALD.continuousSaldContract`; `SALD.cycle45ForwardKlSkeletonObligation` | The theorem remains `contractOnly`; no endpoint, regularity, or finite-quantity assumptions are added to the source statement. |
| `appendix.tex:168-228`: KL derivative, SALD Fokker-Planck, target transport, LSI handoff, and inverse time change. | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `sald.forward_kl.kl_derivative` | Density/law regularity, differentiation under the integral, integration by parts, target transport, LSI density-test input, and inverse-schedule calculus remain obligations. |
| `appendix.tex:230-241`: DV with `Z=alpha*||v_t||^2`, finite log-mgf from `alpha0`, and positive-alpha scaling. | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `SALD.forwardKlDvEnergyCandidateContract`; `sald.forward_kl.dv_energy_bound` | Common space, absolute continuity, measurable squared velocity, finite log-mgf, and the source-cited DV formula remain explicit obligations/source-cited facts. |
| `appendix.tex:244-252`: Gronwall with `a(t)=dot{s}(t) C_LSI(t)-(1/2) dot{s}(t)^(-1) alpha^(-1)` and `b(t)=(1/2) dot{s}(t)^(-1) E_alpha(pi_t,v_t)`. | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract`; `sald.forward_kl.gronwall_application` | Endpoint rewrites, coefficient regularity, exponent splitting, and residual-exponent monotonicity remain obligations. |
| Downstream slow backend visibility for theorem-route stability. | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.cycle44MainSkeletonAnalyticInterfaceDag` | EM interpolation Fokker-Planck is checked as the discrete sibling backend, not used to alter the continuous theorem. |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 45 continuous forward-KL skeleton route | Compose statement, derivative/Fokker-Planck, LSI, DV, and Gronwall interfaces into the exact source theorem route. | cycle-44 interface ledger; forward-KL statement contract; derivative side conditions; LSI density-test bridge; DV finite-log-mgf witness; Gronwall endpoint/exponent side conditions; EM interpolation sibling backend | `SALD.cycle45ForwardKlSkeletonUpperPacket`; `SALD.cycle45ForwardKlSkeletonObligation`; `SALD.cycle45ForwardKlSkeletonDag`; `ASTIS.SALD.forward_KL.cycle45_theorem_skeleton_route` | `main_body.tex:238-247`; `appendix.tex:164-252` | `thm:forward-KL`; later `thm:forward-KL-discrete` route reuse | obligation |

Reviewer checklist:

- `SALD.continuousSaldContract` lists
  `SALD.cycle45ForwardKlSkeletonObligation` and stays `contractOnly`.
- `SALD.forwardKlProofDag` contains
  `ASTIS.SALD.forward_KL.cycle45_theorem_skeleton_route`.
- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes the cycle-45
  packet, obligation, and DAG block.
- No Gronwall, DV, LSI/KL/FI, Fokker-Planck/KL derivative, or EM interpolation
  backend is promoted to `formalized`.

## Cycle 45 Middle Continuous Forward-KL Route Audit

Middle synchronized the upper theorem wrapper back to the source proof and
added a lower-ready audit for the continuous `thm:forward-KL` route.  The
theorem display remains the one in `main_body.tex:238-247`; the appendix proof
route remains derivative, LSI, inverse time change, DV, then Gronwall.

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `main_body.tex:238-247`: unchanged theorem statement and two-exponential terminal bound. | `SALD.continuousForwardKlStatementContract`; `SALD.continuousSaldContract`; `SALD.cycle45ForwardKlSkeletonMiddleObligation` | No endpoint, density, smoothness, finite-log-mgf, or coefficient-regularity assumptions are added to the theorem statement. |
| `appendix.tex:168-228`: KL derivative, Fokker-Planck, target transport, LSI handoff, and inverse schedule. | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `sald.forward_kl.kl_derivative`; `sald.forward_kl.schedule_time_change` | Law/density regularity, differentiation under the integral, integration by parts, target transport, and inverse-function calculus remain obligations. |
| `appendix.tex:230-241`: DV selected test `Z=alpha*||v_t||^2` and alpha-complexity rewrite. | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `sald.forward_kl.dv_finite_log_mgf_witness`; `sald.forward_kl.dv_energy_bound` | DV remains source-cited; common-space, absolute-continuity, measurability, and alpha0-to-alpha finite-log-mgf witnesses remain obligations. |
| `appendix.tex:244-252`: Gronwall call, exponent split, and residual-exponent simplification. | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract`; `sald.forward_kl.gronwall_application` | Coefficient regularity, adjacent interval-integrability, endpoint rewrites, exponent split, residual monotonicity, and full Gronwall remain obligations. |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 45 middle route audit | Verify the exact statement and appendix proof route, then choose one lower backend for theorem-display matching. | cycle-44 ledger; cycle-45 upper wrapper; derivative, LSI, DV, and Gronwall interfaces | `SALD.cycle45ForwardKlSkeletonMiddleContract`; `SALD.cycle45ForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL.cycle45_middle_route_audit` | `main_body.tex:238-247`; `appendix.tex:168-252` | `thm:forward-KL`; cycle 45 lower packet | obligation |

Lower packet:

- Target exactly `SALD.forwardKlGronwallSideConditionContract` /
  `SALD.forwardKlGronwallSideConditionObligation` /
  `sald.forward_kl.gronwall_side_conditions`.
- First sub-slice: coefficient regularity and adjacent
  interval-integrability for `dot{s}(t) C_LSI(t)`,
  `(1/2) dot{s}(t)^(-1) alpha^(-1)`, and
  `(1/2) dot{s}(t)^(-1) E_alpha(pi_t,v_t)`.
- Second sub-slice: connect the theorem-specific exponent split to
  `SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces` without
  changing signs, endpoints, or constants.
- Leave endpoint rewrites, residual-exponent monotonicity, DV, LSI/KL/FI,
  continuous KL derivative, and full Gronwall as obligations unless exact
  compiled proofs are added.

## Cycle 45 Lower Forward-KL Gronwall Display Algebra

Lower kept the cycle-45 theorem skeleton fixed and targeted
`sald.forward_kl.gronwall_side_conditions` at the final theorem-display
matching step in `appendix.tex:244-252`.

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| Split the assembled coefficient integral for `a(t)=lsiPart(t)-alphaPart(t)`. | `SALD.forwardKlGronwallCoeffIntegralSub` | Theorem-specific interval-integrability of the LSI and alpha pieces remains an input. |
| Split the initial Gronwall exponent into the two theorem factors in `main_body.tex:243-245`. | `SALD.forwardKlGronwallInitialExponentSplitScalar`; `SALD.forwardKlGronwallInitialExponentSplitOfPieces` | Endpoint rewrite `K(0)=KL(rho_0||pi_0)` and coefficient regularity remain obligations. |
| Drop the nonpositive LSI contribution from the residual exponent in `appendix.tex:248-251`. | `SALD.forwardKlGronwallResidualExponentDropScalar`; `SALD.forwardKlGronwallResidualExponentDropIntegral` | Need source-specific proofs that `int_t^T dot{s}(u) C_LSI(u) du >= 0`, `b(t)>=0`, and both outer residual integrands are interval-integrable. |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 45 lower Gronwall display algebra | Under explicit interval-integrability and nonnegativity inputs, turn the Gronwall output into the source two-exponential initial term and residual-exponent upper bound. | `SALD.forwardKlGronwallSideConditionContract`; `SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable`; endpoint schedule obligation; coefficient regularity obligation | `SALD.forwardKlGronwallCoeffIntegralSub`; `SALD.forwardKlGronwallInitialExponentSplitOfPieces`; `SALD.forwardKlGronwallResidualExponentDropIntegral`; DAG block `ASTIS.SALD.forward_KL.gronwall_side_conditions` | `appendix.tex:244-252`; `main_body.tex:243-246` | `thm:forward-KL` | formalized local algebra plus obligation |

Status: local Real/interval-integral algebra is compiled only under explicit
side conditions.  No theorem statement, source constant, source label, or
analytic backend status was changed.

## Cycle 46 Upper Discrete Forward-KL Skeleton Route

Upper kept the cycle-44 five-interface ledger and moved the theorem-level
wrapper from continuous `thm:forward-KL` to discrete
`thm:forward-KL-discrete`.  The source statement remains
`main_body.tex:299-323`; the proof route remains `appendix.tex:260-592`.

Five-backend check before lower work:

| Backend | Lean-facing interface | Status |
|---|---|---|
| Endpoint-safe Gronwall `lem:gronwall` | `SALD.saldGronwallCandidateContract`; cycle 36/41 wrappers; `sald.gronwall.integrating_factor` | obligation with local wrappers |
| Donsker--Varadhan `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; cycle 42 selected-test bridge | source-cited equality plus obligations |
| LSI/KL/FI `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous KL derivative/Fokker--Planck reuse | `SALD.forwardKlDerivativeCandidateContract`; `sald.forward_kl.kl_derivative`; `sald.forward_kl.schedule_time_change` | obligation |
| EM interpolation endpoint/conditional-FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | obligation |

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `main_body.tex:299-323`: theorem assumptions and displayed bound with `barGamma`, `barDelta`, `alpha`, `alpha'`, `eta`, and `r`. | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract`; `SALD.cycle46DiscreteForwardKlSkeletonObligation` | theorem remains `contractOnly`; no constants or assumptions are changed |
| `appendix.tex:260-385`: frozen EM interpolation, endpoint laws, conditional drift, and interpolation Fokker--Planck. | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_endpoint_laws`; `sald.discrete_forward_kl.em_conditional_fokker_planck` | concrete endpoint laws, conditional-law density, conditional-FP theorem, Laplacian split, stitched intervals |
| `appendix.tex:388-491`: KL derivative, frozen cross term, Young, and LSI. | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.frozenDeltaCrossLipSaldContract`; `sald.discrete_forward_kl.kl_derivative` | density/boundary regularity, omitted frozen-defect specialization, LSI density-test backend |
| `appendix.tex:493-523`: DV velocity bound under the EM interpolation law. | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_finite_log_mgf_witness`; `sald.discrete_forward_kl.dv_velocity_bound` | common-space, absolute-continuity, finite-log-mgf, measurability, source-cited DV |
| `appendix.tex:526-592`: time change, Gronwall, and general-schedule accumulated-error display. | `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract` | stitched-interval regularity, coefficient regularity, endpoint rewrites, residual-exponent bound |
| `main_body.tex:309-323`: linear slowdown collection. | `sald.discrete_forward_kl.linear_slowdown_specialization`; `sald.discrete_forward_kl.accumulated_error_bridge`; `sald.discrete_forward_kl.coefficient_chain_audit` | `A_alpha`, `barGamma`, `barDelta` integral identifications and residual exponent monotonicity |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 46 discrete forward-KL skeleton route | Compose statement, EM interpolation backend, frozen-defect/LSI derivative block, DV velocity witness, Gronwall accumulation, and linear-slowdown accumulated-error bridge into the exact theorem route. | cycle-44 ledger; discrete statement contract; EM side-condition contract; frozen-delta contract; LSI/DV/Gronwall interfaces; accumulated-error bridge | `SALD.cycle46DiscreteForwardKlSkeletonUpperPacket`; `SALD.cycle46DiscreteForwardKlSkeletonObligation`; `SALD.cycle46DiscreteForwardKlSkeletonDag`; `ASTIS.SALD.forward_KL_discrete.cycle46_theorem_skeleton_route` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete`; later discrete general route audit | obligation |

Lower packet:

- Target exactly one backend:
  `SALD.discreteForwardKlEmInterpolationSideConditionContract` /
  `sald.discrete_forward_kl.em_conditional_fokker_planck`, or
  `SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
  `sald.discrete_forward_kl.accumulated_error_bridge`.
- Preserve the constants
  `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
  `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`.
- Keep `lem:frozen_delta_cross_lip_sald`, DV, LSI/KL/FI, Gronwall,
  endpoint stitching, and conditional-FP below formalized unless exact Lean
  proofs replace them.

## Cycle 46 Middle Discrete Forward-KL Route Audit

Middle checked the upper theorem wrapper against the exact source route and
added `SALD.cycle46DiscreteForwardKlSkeletonMiddleContract`,
`SALD.cycle46DiscreteForwardKlSkeletonMiddleObligation`, and DAG node
`ASTIS.SALD.forward_KL_discrete.cycle46_middle_route_audit`.

Source-to-Lean audit:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `main_body.tex:299-323`: linear slowdown theorem with unchanged assumptions, alpha ranges, step-size condition, and displayed constants. | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract`; `SALD.cycle46DiscreteForwardKlSkeletonMiddleObligation` | theorem remains `contractOnly`; no constants or assumptions are changed |
| `appendix.tex:260-330`: EM interpolation, frozen field error, and omitted SALD frozen-defect lemma by specialization of the later general lemma. | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.frozenDeltaCrossLipSaldContract`; `sald.discrete_forward_kl.frozen_delta_cross_lip` | endpoint laws, conditional-law density, conditional-FP, and frozen-defect specialization |
| `appendix.tex:334-491`: KL derivative, conditional Fokker--Planck, frozen cross bound, moving Young bound, and LSI. | `SALD.discreteForwardKlDerivativeCandidateContract`; `sald.discrete_forward_kl.kl_derivative`; `SALD.saldLsiKlFiDensityTestContract` | density/boundary regularity, integration by parts, LSI/KL/FI density-test backend |
| `appendix.tex:493-523`: DV velocity estimate under the EM interpolation law. | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_finite_log_mgf_witness`; `sald.discrete_forward_kl.dv_velocity_bound` | EM common-space, absolute-continuity, finite-log-mgf, measurability, source-cited DV |
| `appendix.tex:526-592`: time change and Gronwall general-schedule display. | `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation` | stitched-interval regularity, coefficient regularity, endpoint rewrites |
| `main_body.tex:309-323`: collect the linear-slowdown theorem display. | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `sald.discrete_forward_kl.accumulated_error_bridge`; `SALD.discreteForwardKlAccumulatedErrorCollectionScalar` | residual-exponent monotonicity, `barGamma` identification, and source definitions of `A_alpha` and `barDelta` |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 46 middle discrete route audit | Verify the theorem-level route and choose one lower backend for display matching. | cycle-44 ledger; cycle-46 upper wrapper; EM, frozen-defect, LSI, DV, Gronwall, and accumulated-error interfaces | `SALD.cycle46DiscreteForwardKlSkeletonMiddleContract`; `SALD.cycle46DiscreteForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle46_middle_route_audit` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete`; cycle 46 lower packet | obligation |

Lower packet: target exactly
`SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
`SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
`sald.discrete_forward_kl.accumulated_error_bridge`.  First sub-slice is the
endpoint and initial-exponent split; second sub-slice connects the compiled
collection algebra to the theorem display.  EM conditional-FP, frozen-defect,
DV, LSI/KL/FI, stitched Gronwall, and residual-exponent facts remain
obligations unless exact Lean proofs replace them.

## Cycle 46 Lower Discrete Accumulated-Error Initial Exponent Split

Lower kept `thm:forward-KL-discrete` fixed and targeted the first
accumulated-error sub-slice selected by middle: the initial Gronwall exponent
split in `appendix.tex:557-590` as it feeds the theorem display in
`main_body.tex:309-315`.

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| Assemble the discrete Gronwall coefficient `a(t)=lsiPart(t)-alphaPart(t)-gammaPart(t)`. | `SALD.discreteForwardKlGronwallCoeffIntervalIntegrable` | Source-specific interval-integrability of the LSI, alpha, and Gamma pieces remains an input. |
| Split `int_0^T a(t) dt` into LSI, alpha, and Gamma integrals. | `SALD.discreteForwardKlGronwallCoeffIntegralSubSub` | Linear-slowdown identification of the three integrals remains separate. |
| Split `exp(-(lsi-alpha-gamma))*K(0)` into the LSI contraction factor and the positive alpha/Gamma factor. | `SALD.discreteForwardKlGronwallInitialExponentSplitScalar`; `SALD.discreteForwardKlGronwallInitialExponentSplitOfPieces` | Endpoint rewrite `K(0)=KL(rho_0||pi_0)`, `barGamma` identification, and residual-exponent monotonicity remain obligations. |

Status: local Real/interval-integral algebra is compiled only under explicit
coefficient integrability inputs. No theorem statement, source constant, source
label, or analytic backend status was changed.

## Cycle 47 Upper Guided/General Skeleton Route

Upper kept the cycle-44 five-interface ledger and wired
`prop:guided_path_residual` plus `thm:general-moving-target-SALD` at theorem
level.  The source window is `appendix.tex:619-951`; no proposition, theorem,
constant, or source label is changed.

Five-backend check:

| Backend | Lean interface | Status |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallCandidateContract`; cycle 36/41 wrappers; `sald.gronwall.integrating_factor` | obligation |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; residual DV witnesses | source-cited plus obligations |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous Fokker--Planck/KL derivative | `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative` | obligation |
| EM interpolation Fokker--Planck | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.em_interpolation_fp` | downstream obligation |

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `appendix.tex:619-704`: differentiate `Z_t`, then `pi_t=Z_t^(-1)p_t exp(-f_t)`, cancel divergence terms, and prove the centered residual plus mean-zero identity. | `SALD.guidedResidualIdentityContract`; `SALD.guidedResidualContract`; `SALD.cycle47GuidedGeneralSkeletonObligation` | differentiating under the integral, positive finite normalizer, integration by parts, boundary decay, and centering |
| `appendix.tex:724-744`: state general moving-target SALD with residual `m_t=v_t-c_t` and the sigma-weighted terminal bound. | `SALD.generalMovingTargetStatementContract`; `SALD.generalVaSaldContract`; `SALD.cycle47GuidedGeneralSkeletonObligation` | theorem remains `contractOnly`; source assumptions and coefficients unchanged |
| `appendix.tex:765-884`: KL derivative, general Fokker--Planck equation, target transport, residual `m_t`, Young, LSI, and time change. | `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative`; `SALD.saldLsiKlFiDensityTestContract` | density/law regularity, Fokker--Planck backend, integration by parts, LSI density test, schedule and sigma positivity |
| `appendix.tex:885-907`: DV with `Z=alpha*||m_t||^2` and alpha-complexity rewrite. | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `sald.general_moving_target.dv_m_energy` | common space, absolute continuity, measurability, finite log-mgf, source-cited DV |
| `appendix.tex:909-945`: Gronwall, theorem-display matching, and pure contraction. | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.pure_contraction` | endpoint rewrites, coefficient regularity, exponent splitting, residual monotonicity, zero-residual alpha-complexity |
| `appendix.tex:949-951`: unified theorem reuse by `c_t <- u_t`. | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.specialization` | transport bridge from guided residual plus `eq:poisson-eq` remains separate |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 47 guided/general skeleton route | Compose guided residual, continuous general derivative, LSI, residual DV, Gronwall, and pure-contraction interfaces into the exact source route. | cycle-44 ledger; guided residual contract; general statement contract; derivative side conditions; LSI bridge; residual DV witness; Gronwall side conditions | `SALD.cycle47GuidedGeneralSkeletonUpperPacket`; `SALD.cycle47GuidedGeneralSkeletonObligation`; `SALD.cycle47GuidedGeneralSkeletonDag`; `ASTIS.SALD.guided_general.cycle47_theorem_skeleton_route` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD` | obligation |

Lower packet: target exactly
`SALD.generalMovingTargetDerivativeCandidateContract` /
`SALD.generalMovingTargetDerivativeObligation` /
`sald.general_moving_target.kl_derivative`.  First expose the density/law,
Fokker--Planck, mass-conservation, and integration-by-parts interfaces for
`appendix.tex:765-812`; then identify target transport, residual
`m_t=v_t-c_t`, and the Young coefficient from `appendix.tex:835-864`.

## Cycle 47 Middle Guided/General Route Audit

Middle synchronized the upper wrapper back to `appendix.tex:619-951` and added
`SALD.cycle47GuidedGeneralSkeletonMiddleContract`,
`SALD.cycle47GuidedGeneralSkeletonMiddleObligation`, and
`ASTIS.SALD.guided_general.cycle47_middle_route_audit`.

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `appendix.tex:619-704` guided residual proof. | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.normalizer_derivative`; `sald.guided_path_residual.identity` | guided-density calculus and centering |
| `appendix.tex:765-884` continuous general KL derivative and LSI handoff. | `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative`; `probability.lsi_to_kl_fi` | Fokker--Planck/KL derivative backend, integration by parts, LSI density test, schedule calculus |
| `appendix.tex:885-907` residual DV handoff. | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `sald.general_moving_target.dv_finite_log_mgf_witness`; `sald.general_moving_target.dv_positive_alpha_scaling`; `sald.general_moving_target.dv_m_energy` | source-cited DV and theorem-specific selected-test witnesses |
| `appendix.tex:909-945` Gronwall and pure contraction. | `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_side_conditions`; `sald.general_moving_target.pure_contraction` | endpoint, coefficient, exponent, and zero-residual obligations |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 47 middle guided/general route audit | Verify the exact source route and choose the general KL derivative backend for lower work. | cycle-44 ledger; cycle-47 upper wrapper; guided residual, derivative, LSI, DV, and Gronwall interfaces | `SALD.cycle47GuidedGeneralSkeletonMiddleContract`; `SALD.cycle47GuidedGeneralSkeletonMiddleObligation`; `ASTIS.SALD.guided_general.cycle47_middle_route_audit` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; cycle 47 lower packet | obligation |

Status: workflow route audit only.  `prop:guided_path_residual` and
`thm:general-moving-target-SALD` remain contract-only; Gronwall, DV,
LSI/KL/FI, Fokker--Planck/KL derivative, guided residual calculus, and EM
interpolation remain obligation/source-cited as before.

## Cycle 47 Lower General Derivative Scalar Handoff

Lower targeted `sald.general_moving_target.kl_derivative` and compiled only the
real/order part of `appendix.tex:835-884`.  The source theorem statement,
residual `m_t=v_t-c_t`, and coefficients are unchanged.

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| Residual Young output from `appendix.tex:835-864`: after the analytic residual cross bound is supplied, subtract the Fisher share to get `-(sigma_t^2/4)*FI + sigma_t^(-2)*dot t(s)^2*||m_t||^2`. | `SALD.generalMovingTargetPostYoungDerivativeBoundScalar` | Holder/Young, residual field identification, FI and residual L2 identities, sigma positivity |
| LSI handoff in `appendix.tex:865-872`: use the supplied half-Fisher comparison to replace the Fisher term by `-(sigma_t^2/2)*C_LSI(t)*K`. | `SALD.generalMovingTargetLsiDerivativeBoundScalar` | `probability.lsi_to_kl_fi`, density-test admissibility, entropy/KL identity, Fisher chain rule |
| Time change in `appendix.tex:873-884`: multiply by `dot{s}(t)` and rewrite `dot{s}(t)*dot t(s(t))^2` to `dot{s}(t)^(-1)`. | `SALD.generalMovingTargetTimeChangedDerivativeBoundScalar`; `SALD.generalMovingTargetPreDvDerivativeBoundScalar` | chain rule for `K(s(t))`, inverse-schedule differentiability, `dot{s}` nonzero/positive |

`SALD.generalMovingTargetDerivativeCandidateContract`,
`SALD.generalMovingTargetDerivativeObligation`, the proof-DAG node
`ASTIS.SALD.general_moving_target.derivative`, and
`saldDependenciesForLabel "thm:general-moving-target-SALD"` now list these
compiled scalar handoffs.  The continuous Fokker--Planck/KL derivative,
integration by parts, LSI density-test, residual DV, and Gronwall interfaces
remain obligations/source-cited.

## Cycle 48 Upper Unified/Discrete General Skeleton Route

Upper kept the cycle-44 five-interface ledger and wired the final two theorem
nodes in the main skeleton sprint:
`thm:unified-forward-KL` and
`thm:general-moving-target-SALD-discrete`.  The source route is still the paper
route: unified VA-SALD specializes the continuous general theorem, and the
discrete general theorem uses the general EM interpolation, frozen-delta,
LSI/DV, and Gronwall spine.

Five-backend check:

| Backend | Lean interface | Status |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallEndpointCalculusContract`; `sald.gronwall.integrating_factor` | obligation |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; theorem-specific finite-log-mgf witnesses | source-cited plus obligations |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous Fokker--Planck/KL derivative | `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative` | obligation |
| EM interpolation Fokker--Planck | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.em_interpolation_fp` | obligation |

Source-to-Lean map:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `main_body.tex:359-395` and `appendix.tex:949-951`: specialize the general theorem with `c_t=u_t`, use `eq:poisson-eq`, and identify `m_t=w_t`. | `SALD.unifiedForwardKlSpecializationContract`; `SALD.cycle48UnifiedDiscreteSkeletonObligation`; `ASTIS.SALD.unified_forward_KL.cycle48_theorem_skeleton_route` | correction-field transport bridge, divergence linearity, guided residual identity |
| `appendix.tex:1313-1347`: keep the discrete general theorem display fixed. | `SALD.generalMovingTargetDiscreteStatementContract`; `SALD.generalVaSaldDiscreteContract`; cycle-48 route node | theorem remains `contractOnly`; constants and source assumptions unchanged |
| `appendix.tex:1354-1511`: general EM interpolation, conditional Fokker--Planck, frozen/residual split, and Young bookkeeping. | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.derivative_side_conditions`; cycle-28 middle/lower packets | conditional-law density, EM Fokker--Planck, concrete vector-field identifications, Young/FI backend |
| `appendix.tex:1544-1552`: residual DV under the EM interpolation law. | `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `sald.general_moving_target_discrete.dv_m_energy` | common space, absolute continuity, finite log-mgf, source-cited DV |
| `appendix.tex:1573-1603`: constant-schedule stitching, Gronwall display, and discrete guided specialization. | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `sald.general_moving_target_discrete.gronwall_side_conditions`; `sald.general_moving_target_discrete.unified_specialization` | endpoint stitching, coefficient regularity, Gronwall backend, exact display matching |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 48 unified theorem route | Use guided residual plus `eq:poisson-eq` to produce the transport velocity and specialize the continuous general theorem. | cycle-44 ledger; cycle-47 guided/general route; cycle-16 transport bridge; continuous general derivative/DV/Gronwall obligations | `SALD.cycle48UnifiedDiscreteSkeletonUpperPacket`; `SALD.cycle48UnifiedDiscreteSkeletonObligation`; `ASTIS.SALD.unified_forward_KL.cycle48_theorem_skeleton_route` | `main_body.tex:359-395`; `appendix.tex:949-951` | `thm:unified-forward-KL` | obligation |
| Cycle 48 discrete general route | Compose the general EM backend, frozen-delta, KL derivative/LSI, residual DV, Gronwall/stitching, and discrete guided specialization. | cycle-44 ledger; cycle-28 derivative side conditions; cycle-20 Gronwall side conditions; `lem:dv_variation`; `lem:gronwall`; `eq:LSI-KL-FI` | `SALD.cycle48UnifiedDiscreteSkeletonUpperPacket`; `SALD.cycle48UnifiedDiscreteSkeletonObligation`; `ASTIS.SALD.general_moving_target_discrete.cycle48_theorem_skeleton_route` | `appendix.tex:1313-1603` | `thm:general-moving-target-SALD-discrete` | obligation |

Lower packet: after this wrapper is accepted, target exactly
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract` /
`SALD.generalMovingTargetDiscreteDerivativeObligation` /
`sald.general_moving_target_discrete.kl_derivative`.  First expose the
`appendix.tex:1354-1387` EM endpoint, conditional-law density, and
Fokker--Planck interfaces; then preserve the cycle-28 frozen/residual algebra
and two `sigma_eta^2/8` Young shares.  Local SLT material is reference-only for
a later narrow measure-theory audit; no SLT theorem is imported or marked
formalized.

Status: workflow route closure only.  `SALD.unifiedForwardKlContract` and
`SALD.generalVaSaldDiscreteContract` now list the cycle-48 obligation while
remaining `contractOnly`.  Gronwall, DV, LSI/KL/FI, continuous KL derivative,
EM conditional Fokker--Planck, frozen-delta, and guided residual calculus
remain obligations/source-cited.

## Cycle 48 Middle Unified/Discrete Route Audit

Middle synchronized the upper route with the exact TeX proof paragraphs and
added a narrow source-dependency audit for the first discrete derivative
backend.  The new Lean-facing declarations are
`SALD.cycle48UnifiedDiscreteSkeletonMiddleContract`,
`SALD.cycle48UnifiedDiscreteSkeletonMiddleObligation`,
`SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`, and DAG
node `ASTIS.SALD.unified_discrete_general.cycle48_middle_route_audit`.

Source-to-Lean audit:

| Source step | Lean declaration | Remaining obligation |
|---|---|---|
| `main_body.tex:359-395` and `appendix.tex:949-951`: use the guided residual plus `eq:poisson-eq`, then specialize the continuous general theorem with `c_t=u_t` and `m_t=w_t`. | `SALD.cycle48UnifiedDiscreteSkeletonMiddleContract`; `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.transport_velocity_bridge`; `sald.unified_forward_kl.specialization` | correction-field existence/regularity, divergence linearity, guided residual calculus, continuous general theorem obligations |
| `appendix.tex:1313-1347`: keep the discrete general theorem display with the doubled residual term, Gamma term, Delta term, alpha ranges, and constant inverse-schedule assumption. | `SALD.generalMovingTargetDiscreteStatementContract`; `SALD.generalVaSaldDiscreteContract`; `SALD.cycle48UnifiedDiscreteSkeletonMiddleObligation` | theorem remains `contractOnly`; no coefficient or assumption is changed |
| `appendix.tex:1354-1387`: define `hat rho_s`, assert endpoint laws, define `bar b_{k,s}` as a conditional drift, and invoke conditional-drift Fokker--Planck before KL differentiation. | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairHandoff`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairOfNamedInterpolation`; `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.general_moving_target_discrete.kl_derivative` | regular conditional expectation, measurability/integrability, density and absolute continuity, weak Fokker--Planck; named-process endpoint bookkeeping is compiled |
| `appendix.tex:1469-1511`: rewrite the cross field as `delta_pi^VA + dot t(s)*m_t` and preserve the two `sigma_eta^2/8` Young shares. | cycle-28 middle/lower packets; `SALD.generalMovingTargetDiscreteFrozenResidualAlgebraVector`; scalar Young helpers | concrete conditional drift, score, slowed transport, FI/L2, and frozen-delta analytic identifications |
| `appendix.tex:1513-1603`: apply LSI, residual DV, time change, Gronwall, and the discrete guided specialization. | `probability.lsi_to_kl_fi`; `sald.general_moving_target_discrete.dv_m_energy`; `sald.general_moving_target_discrete.gronwall_side_conditions`; `sald.general_moving_target_discrete.unified_specialization` | LSI density-test backend, source-cited DV, finite-log-mgf witness, coefficient regularity, endpoint stitching, Gronwall |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 48 middle route audit | Verify the unified specialization and the discrete general EM/Fokker--Planck/frozen-delta/LSI/DV/Gronwall chain, then select the discrete KL derivative backend. | cycle-44 ledger; cycle-48 upper wrapper; cycle-47 continuous general route; cycle-28 derivative side conditions; cycle-20 Gronwall side conditions | `SALD.cycle48UnifiedDiscreteSkeletonMiddleContract`; `SALD.cycle48UnifiedDiscreteSkeletonMiddleObligation`; `ASTIS.SALD.unified_discrete_general.cycle48_middle_route_audit` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete`; cycle 48 lower packet | obligation |
| Cycle 48/49 EM endpoint/conditional-law audit | Sharpen the first lower sub-slice for `sald.general_moving_target_discrete.kl_derivative`: endpoint laws, regular conditional drift, common space, density/AC, and weak conditional Fokker--Planck. | general EM contract; `SALD.generalMovingTargetDiscreteEmEndpointLawPairHandoff`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairOfNamedInterpolation`; derivative side-condition contract; KL/FI/Fokker--Planck vocabulary | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation` | `appendix.tex:1354-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.general_moving_target_discrete.kl_derivative` | obligation with formalized endpoint bookkeeping |

Lower packet: target exactly
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract` /
`SALD.generalMovingTargetDiscreteDerivativeObligation` /
`sald.general_moving_target_discrete.kl_derivative`.  Start with
`appendix.tex:1354-1387`; use local SLT one-step or disintegration material
only as reference patterns until a result is ported and built locally.

Cycle 48 lower backfill: `SALD.generalMovingTargetDiscreteEmEndpointLawPairHandoff`
compiles the abstract endpoint-law pair for
`\hat\rho_{s_k}=\rho_k^\eta` and
`\hat\rho_{s_{k+1}}=\rho_{k+1}^\eta` once a concrete law operator and named
law representations are supplied.  This is only law-transport bookkeeping;
the Brownian/EM construction, conditional drift, density/AC, and weak
conditional Fokker--Planck theorem remain obligations.

Cycle 49 lower update:
`SALD.generalMovingTargetDiscreteEmEndpointLawPairOfNamedInterpolation` now
compiles the named-process endpoint layer for the same source lines.  It uses
`hatRho s = law (hatX s)`, named `rhoEta k`/`rhoEta (k+1)` law
representations, and pointwise left/right frozen-interpolation identities to
derive the endpoint law pair.  It is not a construction of Brownian motion,
regular conditional drift, density/AC, or weak conditional Fokker--Planck.

## Cycle 49 Upper Analytic Readiness Check

Upper re-checked the five slow analytic interfaces after the cycle 45--48
theorem-route wrappers were in place.  The new Lean-facing declarations are
`SALD.cycle49MainSkeletonAnalyticReadinessLedger`,
`SALD.cycle49MainSkeletonAnalyticReadinessObligation`, and
`SALD.cycle49MainSkeletonAnalyticReadinessDag`.

Five-backend check:

| Backend | Lean-facing interface | Status |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.saldGronwallExponentRewriteContract` | obligation |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract` | source-cited equality plus obligations |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous Fokker--Planck/KL derivative | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `SALD.generalMovingTargetDerivativeCandidateContract` | obligation |
| EM interpolation Fokker--Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairHandoff`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairOfNamedInterpolation`; `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation` | obligation with compiled endpoint bookkeeping |

Route status:

| Theorem node | Route status | Remaining selected backend |
|---|---|---|
| `thm:forward-KL` | Routed through continuous KL derivative, LSI/KL/FI, DV velocity witness, Gronwall, and endpoint schedule obligations. | no new upper target |
| `thm:forward-KL-discrete` | Routed through EM endpoint/conditional-FP, frozen defect, LSI/DV, stitched Gronwall, and accumulated-error obligations. | no new upper target |
| `prop:guided_path_residual` | Routed through normalizer derivative and centered residual identity obligations. | guided-density calculus remains |
| `thm:general-moving-target-SALD` | Routed through continuous general KL derivative, residual DV, sigma-weighted Gronwall, and pure-contraction obligations. | no new upper target |
| `thm:unified-forward-KL` | Routed as the source specialization of `thm:general-moving-target-SALD` using `prop:guided_path_residual` and `eq:poisson-eq`. | correction-field transport bridge remains |
| `thm:general-moving-target-SALD-discrete` | Routed through general EM interpolation, frozen-delta, residual DV, LSI, Gronwall, and stitching obligations. | `appendix.tex:1354-1387` EM endpoint/conditional-law/Fokker--Planck backend |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 49 analytic readiness | Post-route check that the five analytic backends have explicit source-cited or obligation interfaces and that all six theorem nodes point through them. | cycle-44 ledger; cycle-45--48 route obligations | `SALD.cycle49MainSkeletonAnalyticReadinessLedger`; `SALD.cycle49MainSkeletonAnalyticReadinessObligation`; `ASTIS.SALD.cycle49.analytic_readiness` | `appendix.tex:1354-1387`; theorem-route sources | all six theorem-route nodes | obligation |
| Cycle 49 lower packet | Use the named-process endpoint-law handoff for concrete named laws and pointwise endpoint identities, then expose regular conditional drift, density/AC, common space, and weak conditional Fokker--Planck before the KL derivative proof. | `SALD.generalMovingTargetDiscreteDerivativeCandidateContract`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairHandoff`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairOfNamedInterpolation`; cycle-48 EM endpoint/FP audit | `ASTIS.SALD.cycle49.lower_packet.general_discrete_em_fp` | `appendix.tex:1354-1387` | `thm:general-moving-target-SALD-discrete` | obligation with compiled endpoint bookkeeping |

Lower packet: target exactly
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract` /
`SALD.generalMovingTargetDiscreteDerivativeObligation` /
`sald.general_moving_target_discrete.kl_derivative`, starting with
`appendix.tex:1354-1387`.  Preserve the cycle-28 frozen/residual algebra and
the two `sigma_eta^2/8` Young shares for the next sub-slice.  Do not mark the
Brownian/EM construction, regular conditional drift, density/AC, weak
Fokker--Planck, DV, LSI/KL/FI, or Gronwall as formalized.

## Cycle 49 Middle Route Audit

Middle added `SALD.cycle49MainSkeletonAnalyticMiddleContract`,
`SALD.cycle49MainSkeletonAnalyticMiddleObligation`, and DAG node
`ASTIS.SALD.cycle49.middle_route_audit`.

The audit translates the post-route Lean state back into the conversion
window:

| Source window | Lean-facing interface | Remaining obligation |
|---|---|---|
| `appendix.tex:47-79` | `SALD.saldGronwallEndpointCalculusContract`; `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract` | endpoint-safe Gronwall calculus stays an obligation; DV equality stays source-cited with theorem-specific common-space and finite-log-mgf witnesses |
| `main_body.tex:202-215` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | density, zero-set convention, admissible `sqrt(rho/pi)` test or approximation, entropy identity, and Fisher chain rule remain obligations |
| `appendix.tex:168-252` | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.continuousSaldContract` | continuous KL derivative/Fokker--Planck, density/boundary, inverse-schedule, DV, and Gronwall backends remain obligations |
| `appendix.tex:724-951`; `main_body.tex:359-395` | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.unifiedForwardKlSpecializationContract` | guided residual calculus, correction-field transport bridge, continuous general derivative, residual DV, and sigma-weighted Gronwall stay obligations |
| `appendix.tex:1313-1603` | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalVaSaldDiscreteContract` | theorem remains `contractOnly`; EM conditional-FP, frozen-delta, LSI, residual DV, and stitched Gronwall remain obligations |
| `appendix.tex:1354-1387` | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairHandoff`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairOfNamedInterpolation` | common-space construction, regular conditional drift, density/AC, and weak conditional Fokker--Planck remain the next lower target; named-process endpoint bookkeeping is compiled |

Lower packet remains exactly
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract` /
`SALD.generalMovingTargetDiscreteDerivativeObligation` /
`sald.general_moving_target_discrete.kl_derivative`, first sub-slice
`appendix.tex:1354-1387`.  The compiled endpoint-law handoffs are only
bookkeeping after named-law representations and pointwise interpolation
identities are supplied; they are not a Brownian/EM construction,
conditional-law, density, or Fokker--Planck proof.

## Cycle 50 Upper Continuous Forward-KL Post-Readiness Route

Upper re-focused the post-route readiness ledger on the cycle target:
`thm:forward-KL` over `main_body.tex:238-247` and
`appendix.tex:164-252`.  The Lean-facing additions are
`SALD.cycle50ForwardKlSkeletonUpperPacket`,
`SALD.cycle50ForwardKlSkeletonObligation`, and DAG node
`ASTIS.SALD.forward_KL.cycle50_theorem_skeleton_route`.

Five-backend check before the route wiring:

| Backend | Forward-KL consumer | Status |
|---|---|---|
| Endpoint-safe Gronwall | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract` | obligation |
| Donsker--Varadhan | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.forwardKlDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| LSI/KL/FI | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous Fokker--Planck/KL derivative | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `sald.forward_kl.kl_derivative` | obligation |
| EM interpolation Fokker--Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | downstream obligation only |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 50 continuous forward-KL post-readiness route | Compose the cycle-49 five-backend readiness check and cycle-45 theorem wrapper into the exact derivative -> LSI -> DV -> Gronwall source route. | cycle-49 readiness/middle audits; cycle-45 forward-KL wrapper; derivative, LSI/KL/FI, DV finite-log-mgf, Gronwall side-condition, and EM sibling interfaces | `SALD.cycle50ForwardKlSkeletonUpperPacket`; `SALD.cycle50ForwardKlSkeletonObligation`; `SALD.cycle50ForwardKlSkeletonDag`; `ASTIS.SALD.forward_KL.cycle50_theorem_skeleton_route` | `main_body.tex:238-247`; `appendix.tex:164-252` | `thm:forward-KL`; cycle 50 handoff | obligation |

Lower packet: if proof-producing lower work resumes on the continuous
forward-KL route, target exactly
`SALD.forwardKlDerivativeCandidateContract` /
`SALD.forwardKlDerivativeObligation` / `sald.forward_kl.kl_derivative` over
`appendix.tex:168-228`.  Do not add endpoint, density,
absolute-continuity, finite-log-mgf, or coefficient-regularity facts to the
theorem statement; keep them as named obligations unless compiled locally.

No theorem display, source constant, source label, theorem status, or analytic
backend status was changed.

## Cycle 50 Middle Continuous Forward-KL Route Audit

Middle synchronized the cycle-50 upper route with the source-to-Lean map for
`thm:forward-KL`.  The new Lean-facing audit is
`SALD.cycle50ForwardKlSkeletonMiddleContract`,
`SALD.cycle50ForwardKlSkeletonMiddleObligation`, and DAG node
`ASTIS.SALD.forward_KL.cycle50_middle_route_audit`.

Source-to-Lean map:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `main_body.tex:238-247`: theorem statement and terminal display. | `SALD.continuousForwardKlStatementContract`; `SALD.continuousSaldContract` | theorem remains `contractOnly` |
| `appendix.tex:168-185`: KL differentiation, mass conservation, SALD Fokker--Planck, integration by parts, and `-FI`. | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlDerivativeObligation` | density, AC, boundary/no-flux, and differentiation-under-integral |
| `appendix.tex:187-228`: target transport, Young bound, LSI, and inverse-schedule time change. | `sald.forward_kl.density_boundary_regular`; `sald.forward_kl.schedule_time_change`; `probability.lsi_to_kl_fi` | transport regularity, LSI density-test backend, schedule calculus |
| `appendix.tex:230-241`: DV velocity-energy bound with `Z=alpha*||v_t||^2`. | `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `sald.forward_kl.dv_finite_log_mgf_witness`; `sald.forward_kl.dv_energy_bound` | common-space, AC, measurability, finite log-mgf, source-cited DV |
| `appendix.tex:244-252`: Gronwall and exact theorem display matching. | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract`; `sald.forward_kl.gronwall_application` | endpoint rewrites, coefficient regularity, residual exponent drop |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 50 middle continuous forward-KL audit | Verify the cycle-50 post-readiness route and select the continuous KL derivative/Fokker--Planck backend for lower work. | cycle-50 upper wrapper; cycle-49 readiness audit; cycle-45 route audit; derivative, LSI/KL/FI, DV, Gronwall, and EM sibling interfaces | `SALD.cycle50ForwardKlSkeletonMiddleContract`; `SALD.cycle50ForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL.cycle50_middle_route_audit` | `main_body.tex:238-247`; `appendix.tex:168-252` | `thm:forward-KL`; cycle 50 lower packet | obligation |

Lower packet: target exactly `SALD.forwardKlDerivativeCandidateContract` /
`SALD.forwardKlDerivativeObligation` / `sald.forward_kl.kl_derivative` over
`appendix.tex:168-228`.  First sub-slice is `appendix.tex:168-185`: law and
density regularity, mass conservation, KL differentiation under the integral,
SALD Fokker--Planck substitution, boundary/no-flux integration by parts, and
the `-FI` identification.  Target transport, inverse-schedule calculus, LSI,
DV, and Gronwall remain separate obligations unless compiled locally.

## Cycle 50 Lower Continuous Forward-KL Derivative/DV Handoff

Lower added one proof-producing scalar bridge inside the selected
`sald.forward_kl.kl_derivative` route, without promoting any analytic backend:
`SALD.forwardKlDerivativeDvGronwallCoefficientOfKlFiVelocityScalingScalar`.
It composes the existing source-shaped pre-DV derivative pipeline with the
existing post-DV coefficient handoff.

| Source step | Lean-facing item | Remaining backend |
|---|---|---|
| `appendix.tex:168-228`: KL derivative, first-term `-FI`, target Cauchy/Young, LSI, and inverse-schedule velocity scaling. | `SALD.forwardKlPreDvDerivativeBoundOfKlFiVelocityScalingScalar` | density/boundary regularity, target transport, LSI density-test, and schedule calculus |
| `appendix.tex:230-241`: DV selected-test estimate with `Z=alpha*||v_t||^2`. | `SALD.forwardKlPostDvGronwallCoefficientOfScheduleScalar` | common-space/AC, finite log-mgf, measurability, and source-cited DV |
| `appendix.tex:239-241`: collect the pre-Gronwall coefficient `dot{s}(t)*C_LSI(t) - (1/2)*dot{s}(t)^(-1)*alpha^(-1)`. | `SALD.forwardKlDerivativeDvGronwallCoefficientOfKlFiVelocityScalingScalar`; `SALD.cycle50ForwardKlDerivativeLowerObligation`; DAG block `ASTIS.SALD.forward_KL.cycle50_derivative_dv_lower` | full KL derivative/Fokker--Planck, DV witness, Gronwall side conditions, and `thm:forward-KL` remain obligations |

No theorem statement, source coefficient, source label, theorem status, SLT
reuse status, or analytic backend status was changed.

## Cycle 51 Upper Discrete Forward-KL Interface Route

Upper returned to the cycle focus `thm:forward-KL-discrete` after the cycle 50
continuous derivative/DV scalar handoff.  The new Lean-facing route data are
`SALD.cycle51DiscreteForwardKlSkeletonUpperPacket`,
`SALD.cycle51DiscreteForwardKlSkeletonObligation`, and DAG node
`ASTIS.SALD.forward_KL_discrete.cycle51_theorem_interface_route`.

Five-backend check before the discrete route wiring:

| Backend | Discrete forward-KL consumer | Status |
|---|---|---|
| Endpoint-safe Gronwall | `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation` | obligation |
| Donsker--Varadhan | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| LSI/KL/FI | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous derivative reuse | `SALD.cycle50ForwardKlDerivativeLowerObligation`; `SALD.forwardKlDerivativeDvGronwallCoefficientOfKlFiVelocityScalingScalar` | scalar handoff only; analytic backend remains obligation |
| EM interpolation Fokker--Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | obligation; used as interface, not reproved |

Source-to-Lean route:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `main_body.tex:299-323`: theorem statement and terminal bound. | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract`; `SALD.cycle51DiscreteForwardKlSkeletonObligation` | theorem remains `contractOnly`; constants unchanged |
| `appendix.tex:260-385`: EM interpolation, endpoint laws, conditional drift, conditional Fokker--Planck, and Laplacian split. | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_endpoint_laws`; `sald.discrete_forward_kl.em_conditional_fokker_planck`; `sald.discrete_forward_kl.em_interpolation_fp` | regular conditional drift, density/AC, weak FP, stitched intervals |
| `appendix.tex:388-491`: KL derivative, frozen cross bound, moving Young bound, and LSI. | `SALD.discreteForwardKlDerivativeCandidateContract`; `sald.discrete_forward_kl.kl_derivative`; `SALD.frozenDeltaCrossLipSaldContract`; `SALD.saldLsiKlFiDensityTestContract` | density/boundary regularity, integration by parts, frozen-defect specialization, LSI density-test |
| `appendix.tex:493-523`: DV velocity estimate under the EM interpolation law. | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_finite_log_mgf_witness`; `sald.discrete_forward_kl.dv_velocity_bound` | common-space, AC, measurability, finite log-mgf, source-cited DV |
| `appendix.tex:526-592`: time change, Gronwall, and accumulated-error display. | `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract` | coefficient regularity, endpoint rewrites, residual exponent, `barGamma`/`barDelta` identification |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 51 discrete forward-KL interface route | Re-check five analytic interfaces and route the theorem through source-cited EM/Fokker--Planck, derivative/LSI, DV, Gronwall, and accumulated-error interfaces after the cycle-50 scalar handoff. | cycle-49 readiness; cycle-46 discrete route; cycle-50 derivative/DV scalar handoff; EM, frozen-defect, LSI, DV, Gronwall, and accumulated-error obligations | `SALD.cycle51DiscreteForwardKlSkeletonUpperPacket`; `SALD.cycle51DiscreteForwardKlSkeletonObligation`; `ASTIS.SALD.forward_KL_discrete.cycle51_theorem_interface_route` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete`; cycle 51 lower packet | obligation |
| Cycle 51 middle derivative route audit | Verify the post-upper route and select the discrete KL derivative backend while consuming EM endpoint/conditional-FP as explicit source-cited interfaces. | cycle-51 upper route; cycle-46 middle route; cycle-50 derivative/DV scalar handoff; EM endpoint laws; conditional drift density; conditional-FP; frozen-defect; LSI; DV and Gronwall kept separate | `SALD.cycle51DiscreteForwardKlSkeletonMiddleContract`; `SALD.cycle51DiscreteForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle51_middle_route_audit` | `appendix.tex:334-491`, with EM inputs from `appendix.tex:260-385`; theorem display `main_body.tex:299-323` | lower target `sald.discrete_forward_kl.kl_derivative`; `thm:forward-KL-discrete` | obligation |
| Cycle 51 lower derivative scalar handoff | Compose supplied EM conditional-FP derivative identity, frozen-cross estimate, moving Young estimate, and LSI half-Fisher comparison into the source pre-DV inequality. | EM-FP/KL derivative identity; `lem:frozen_delta_cross_lip_sald`; Young moving term; `eq:LSI-KL-FI` half-Fisher bridge | `SALD.discreteForwardKlPostLsiDerivativeBoundScalar`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfKlFiScalar`; `SALD.cycle51DiscreteForwardKlDerivativeLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle51_derivative_lower` | `appendix.tex:388-491` | `sald.discrete_forward_kl.kl_derivative`; `thm:forward-KL-discrete` | proof-producing scalar core plus obligation |

Lower packet: target exactly
`SALD.discreteForwardKlDerivativeCandidateContract` /
`SALD.discreteForwardKlDerivativeObligation` /
`sald.discrete_forward_kl.kl_derivative` over `appendix.tex:334-491`.
First sub-slice uses the existing EM endpoint and conditional-Fokker--Planck
interfaces from `appendix.tex:334-385` as inputs to KL differentiation; this
cycle does not attempt to prove the EM/Fokker--Planck backend from scratch.
Frozen-defect, LSI/KL/FI, DV, Gronwall, endpoint stitching, and accumulated
constant collection remain separate obligations.

Cycle 51 middle refinement:
`SALD.cycle51DiscreteForwardKlSkeletonMiddleContract` and
`SALD.cycle51DiscreteForwardKlSkeletonMiddleObligation` now pin the lower-ready
map for `appendix.tex:334-491`.  The map consumes
`sald.discrete_forward_kl.em_endpoint_laws`,
`sald.discrete_forward_kl.conditional_drift_density`,
`sald.discrete_forward_kl.em_conditional_fokker_planck`, and
`sald.discrete_forward_kl.em_interpolation_fp` as named interfaces for
`appendix.tex:334-385`, then routes `appendix.tex:388-491` through
`SALD.discreteForwardKlDerivativeCandidateContract`,
`SALD.discreteForwardKlDerivativeObligation`,
`SALD.frozenDeltaCrossLipSaldContract`, and
`SALD.saldLsiKlFiDensityTestContract`.  The DV velocity witness and Gronwall
display remain separate downstream obligations; no theorem assumption or source
coefficient is changed.

Cycle 51 lower refinement:
`SALD.discreteForwardKlPostLsiDerivativeBoundScalar` now proves the scalar
bookkeeping from `appendix.tex:388-491` after the analytic interfaces are
supplied:

```text
dK = -FI + frozenCross + movingCross
frozenCross <= (1/4)FI + 2 eta^2 alpha'^(-1) Gamma K + 2 eta Delta
movingCross <= (1/4)FI + ||tilde v_s||^2
C_LSI K <= (1/2)FI
---------------------------------------------------------------
dK <= -(C_LSI - 2 eta^2 alpha'^(-1) Gamma) K
      + ||tilde v_s||^2 + 2 eta Delta
```

`SALD.discreteForwardKlPostLsiDerivativeBoundOfKlFiScalar` packages the same
handoff from the paper's `KL <= FI/(2*C_LSI)` comparison.  These declarations
do not prove EM conditional-Fokker--Planck, density/boundary integration by
parts, frozen-defect specialization, or the LSI density-test backend.

## Cycle 52 Upper Guided/General Route Closure

Upper returned to `appendix.tex:619-951` after the cycle-50 continuous
forward-KL and cycle-51 discrete forward-KL route checks.  The new Lean-facing
route data are `SALD.cycle52GuidedGeneralSkeletonUpperPacket`,
`SALD.cycle52GuidedGeneralSkeletonObligation`, and DAG node
`ASTIS.SALD.guided_general.cycle52_upper_route`.

Five-backend check before guided/general wiring:

| Backend | Guided/general consumer | Status |
|---|---|---|
| Endpoint-safe Gronwall | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_application` | obligation |
| Donsker--Varadhan | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract` | source-cited plus obligations |
| LSI/KL/FI | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `probability.lsi_to_kl_fi` | obligation |
| Continuous Fokker--Planck/KL derivative | `SALD.forwardKlDerivativeCandidateContract` for the forward-KL backend and `SALD.generalMovingTargetDerivativeCandidateContract` for `appendix.tex:765-884` | obligation; scalar handoffs only where locally compiled |
| EM interpolation Fokker--Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation` | downstream discrete obligation, not a continuous theorem assumption |

Source-to-Lean route for this cycle:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `appendix.tex:619-704`: guided normalizer derivative, centered residual identity, and mean-zero property. | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.normalizer_derivative`; `sald.guided_path_residual.identity` | differentiation under the integral, positive finite normalizer, integration by parts, product/quotient derivative, divergence cancellation |
| `appendix.tex:724-744`: general theorem statement and bound. | `SALD.generalMovingTargetStatementContract`; `SALD.generalVaSaldContract`; `SALD.cycle52GuidedGeneralSkeletonObligation` | theorem remains `contractOnly`; constants and source labels unchanged |
| `appendix.tex:765-884`: general KL derivative, Fokker--Planck, target transport velocity, Young, LSI, and time change. | `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative`; `SALD.generalMovingTargetPostYoungDerivativeBoundScalar`; `SALD.generalMovingTargetPreDvDerivativeBoundScalar` | density/law regularity, integration by parts, transport equation, LSI density-test, schedule/sigma positivity |
| `appendix.tex:885-907`: residual DV for `Z=alpha*||m_t||^2`. | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `sald.general_moving_target.dv_m_energy` | common-space, absolute-continuity, finite log-mgf, measurability, source-cited DV |
| `appendix.tex:908-945`: Gronwall display and pure-contraction specialization. | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.pure_contraction` | endpoint rewrites, coefficient regularity, exponent splitting, residual-exponent sign facts, zero-residual alpha-complexity |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 52 guided/general upper route closure | Re-check five analytic interfaces and route `prop:guided_path_residual` plus `thm:general-moving-target-SALD` through the already named guided residual, KL-derivative, LSI, residual-DV, Gronwall, and pure-contraction obligations. | cycle-49 readiness; cycle-50 and cycle-51 theorem-route wrappers; cycle-47 guided/general route; Gronwall, DV, LSI/KL/FI, continuous derivative, and EM backend interfaces | `SALD.cycle52GuidedGeneralSkeletonUpperPacket`; `SALD.cycle52GuidedGeneralSkeletonObligation`; `ASTIS.SALD.guided_general.cycle52_upper_route` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; downstream `thm:unified-forward-KL` | obligation |

Lower packet: target exactly
`SALD.generalMovingTargetDerivativeCandidateContract` /
`SALD.generalMovingTargetDerivativeObligation` /
`sald.general_moving_target.kl_derivative` over `appendix.tex:765-884`.
Alternative narrow target is `SALD.guidedResidualIdentityContract` /
`sald.guided_path_residual.identity` for `appendix.tex:630-704`.
Do not change theorem statements or promote Gronwall, DV, LSI/KL/FI,
Fokker--Planck/KL differentiation, or EM interpolation beyond their current
obligation/source-cited status.

Cycle 52 middle refinement:
`SALD.cycle52GuidedGeneralSkeletonMiddleContract` and
`SALD.cycle52GuidedGeneralSkeletonMiddleObligation` now synchronize the upper
route with the Lean DAG and proof-obligation ledger.  The audit preserves the
source order over `appendix.tex:619-951`:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `appendix.tex:619-704`: guided normalizer derivative, centered residual identity, and mean-zero property. | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.normalizer_derivative`; `sald.guided_path_residual.identity` | positive finite normalizer, differentiation under the integral, integration by parts, quotient/product derivative, divergence cancellation |
| `appendix.tex:724-884`: theorem statement, general Fokker--Planck/KL derivative, residual field `m_t=v_t-c_t`, Young, LSI, and time change. | `SALD.generalMovingTargetStatementContract`; `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; `sald.general_moving_target.kl_derivative`; scalar handoffs `SALD.generalMovingTargetPostYoungDerivativeBoundScalar`, `SALD.generalMovingTargetLsiDerivativeBoundScalar`, `SALD.generalMovingTargetTimeChangedDerivativeBoundScalar`, `SALD.generalMovingTargetPreDvDerivativeBoundScalar` | density/law regularity, mass conservation, Fokker--Planck backend, target transport, integration by parts, schedule and sigma positivity, LSI density-test |
| `appendix.tex:885-907`: residual DV with `Z=alpha*||m_t||^2`. | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `sald.general_moving_target.dv_m_energy` | common-space, absolute-continuity, finite KL/log-likelihood, measurability, finite log-mgf, source-cited DV |
| `appendix.tex:908-945`: sigma-weighted Gronwall and pure contraction. | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_application`; `sald.general_moving_target.gronwall_side_conditions`; `sald.general_moving_target.pure_contraction` | endpoint rewrites, coefficient regularity, exponent splitting, residual-exponent sign facts, zero residual alpha-complexity |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 52 guided/general middle route audit | Verify the upper cycle-52 guided/general route in paper order and select the continuous general KL derivative backend without folding in residual DV, Gronwall, pure contraction, or downstream EM interfaces. | cycle-52 upper route; cycle-49 readiness; cycle-50/51 theorem route checks; cycle-47 guided/general audit; guided residual, general derivative, LSI, residual DV, Gronwall, and EM interface obligations | `SALD.cycle52GuidedGeneralSkeletonMiddleContract`; `SALD.cycle52GuidedGeneralSkeletonMiddleObligation`; `ASTIS.SALD.guided_general.cycle52_middle_route_audit` | `appendix.tex:619-951`, lower slice `appendix.tex:765-884` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; next lower derivative packet | obligation |
| Cycle 52 lower derivative/DV scalar handoff | Compose the supplied general KL derivative/LSI pre-DV inequality with the residual DV estimate to produce the exact sigma-weighted Gronwall coefficient and residual term. | general Fokker--Planck/KL derivative; residual Young; `eq:LSI-KL-FI` half-Fisher bridge; schedule calculus; residual DV finite-log-mgf/common-space witness | `SALD.generalMovingTargetPostDvGronwallCoefficientScalar`; `SALD.generalMovingTargetPostDvGronwallCoefficientOfSigmaScheduleScalar`; `SALD.generalMovingTargetDerivativeDvGronwallCoefficientScalar`; `SALD.cycle52GuidedGeneralDerivativeDvLowerObligation`; `ASTIS.SALD.general_moving_target.cycle52_derivative_dv_lower` | `appendix.tex:765-907` | `sald.general_moving_target.kl_derivative`; `sald.general_moving_target.dv_m_energy`; `thm:general-moving-target-SALD`; `thm:unified-forward-KL` | proof-producing scalar core plus obligation |

Lower packet: target exactly
`SALD.generalMovingTargetDerivativeCandidateContract` /
`SALD.generalMovingTargetDerivativeObligation` /
`sald.general_moving_target.kl_derivative`.  First lower sub-slice:
`appendix.tex:765-812` density/law regularity, mass conservation, general
Fokker--Planck equation, KL differentiation, and integration by parts.
Second sub-slice: `appendix.tex:813-864` target transport, residual
identification `m_t=v_t-c_t`, and the paper Young coefficient
`epsilon=2*dot t(s)/sigma_{t(s)}^2`.  Third sub-slice:
`appendix.tex:865-884` LSI handoff and schedule/sigma positivity.  The
guided residual identity is only the alternative target if the derivative
backend is blocked.

Cycle 52 lower refinement:
`SALD.generalMovingTargetDerivativeDvGronwallCoefficientScalar` now proves the
scalar bookkeeping from `appendix.tex:765-907` once the analytic interfaces are
supplied:

```text
dK/dt <= -((sigma^2/2)*dot{s}*C_LSI) K
        + sigma^(-2)*dot{s}^(-1) ||m||^2
alpha ||m||^2 <= K + log E_pi exp(alpha ||m||^2)
E_alpha(pi,m) = alpha^(-1) log E_pi exp(alpha ||m||^2)
----------------------------------------------------------------
dK/dt <= -(((sigma^2/2)*dot{s}*C_LSI)
             - sigma^(-2)*dot{s}^(-1)*alpha^(-1)) K
        + sigma^(-2)*dot{s}^(-1) E_alpha(pi,m)
```

The helper declarations
`SALD.generalMovingTargetPostDvGronwallCoefficientScalar` and
`SALD.generalMovingTargetPostDvGronwallCoefficientOfSigmaScheduleScalar`
isolate the positive-alpha/DV coefficient algebra.  They do not prove the
general Fokker--Planck/KL derivative identity, residual Young analytic
estimate, LSI density-test backend, finite-log-mgf/common-space witness,
source-cited DV theorem, Gronwall, or the theorem statement.

## Cycle 53 Unified And Discrete General Route

Upper closed the sprint-5 theorem-level route for the two remaining skeleton
nodes without changing statements or constants.  The new Lean-facing route data
are `SALD.cycle53UnifiedDiscreteGeneralUpperPacket`,
`SALD.cycle53UnifiedDiscreteGeneralSkeletonObligation`, and DAG block
`ASTIS.SALD.unified_discrete_general.cycle53_upper_route`.

Middle synchronized the route with the Lean theorem contracts and lower packet:
`SALD.cycle53UnifiedDiscreteGeneralMiddleContract`,
`SALD.cycle53UnifiedDiscreteGeneralMiddleObligation`, and DAG block
`ASTIS.SALD.unified_discrete_general.cycle53_middle_route_audit`.

Source-to-Lean route:

| Source block | Lean-facing route | Remaining backend |
|---|---|---|
| `main_body.tex:359-395`, `appendix.tex:949-951`: unified theorem specializes the continuous general theorem with `c_t=u_t`, `v_t=u_t+w_t`, and `m_t=w_t`. | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.transport_velocity_bridge`; `sald.unified_forward_kl.specialization`; cycle-52 continuous general route | correction-field existence/regularity and divergence-linearity remain obligations |
| `appendix.tex:1313-1347`: discrete general theorem display and constants. | `SALD.generalMovingTargetDiscreteStatementContract`; `SALD.generalVaSaldDiscreteContract`; `SALD.cycle53UnifiedDiscreteGeneralSkeletonObligation` | theorem remains `contractOnly` |
| `appendix.tex:1354-1387`: EM interpolation endpoint and conditional-Fokker--Planck backend. | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteEmEndpointLawPairOfNamedInterpolation`; new `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation` | regular conditional drift, density/absolute-continuity, and weak conditional Fokker--Planck remain obligations |
| `appendix.tex:1469-1552`: frozen/residual split, LSI, and residual DV. | cycle-28 derivative-side contracts; `probability.lsi_to_kl_fi`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `sald.general_moving_target_discrete.dv_m_energy` | LSI density-test and DV common-space/finite-log-mgf witnesses remain obligations |
| `appendix.tex:1573-1600`: constant-schedule Gronwall and display matching. | `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `sald.general_moving_target_discrete.gronwall_application`; `sald.general_moving_target_discrete.gronwall_side_conditions` | stitched regularity, coefficient regularity, and Gronwall backend remain obligations |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 53 upper unified/discrete route | Consume the cycle-52 continuous general skeleton and cycle-48 unified/discrete skeleton, with all five slow analytic interfaces explicit. | cycle-49 readiness; cycle-52 guided/general route; cycle-48 unified/discrete route; Gronwall, DV, LSI/KL/FI, continuous derivative, and EM interfaces | `SALD.cycle53UnifiedDiscreteGeneralUpperPacket`; `SALD.cycle53UnifiedDiscreteGeneralSkeletonObligation`; `ASTIS.SALD.unified_discrete_general.cycle53_upper_route` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 53 middle unified/discrete route audit | Verify the upper route in paper order, keep `thm:unified-forward-KL` as the continuous general specialization, keep `thm:general-moving-target-SALD-discrete` on the EM/frozen-delta/LSI/DV/Gronwall route, and select the discrete KL derivative backend. | cycle-53 upper route; cycle-52 continuous general route; cycle-48 unified/discrete route; endpoint-law backfill; Gronwall, DV, LSI/KL/FI, continuous derivative, and EM interfaces | `SALD.cycle53UnifiedDiscreteGeneralMiddleContract`; `SALD.cycle53UnifiedDiscreteGeneralMiddleObligation`; `ASTIS.SALD.unified_discrete_general.cycle53_middle_route_audit` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603`; first lower slice `appendix.tex:1354-1387` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete`; cycle 53 lower packet | obligation |
| Cycle 53 Measure.map endpoint backfill | Almost-everywhere equality of endpoint process representatives implies equality of their pushforward laws. | Mathlib `Measure.map_congr`; endpoint vector algebra; cycle-48 EM endpoint audit | `AutoSamplingTheory.lawMapEqOfAEEq`; `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation`; `ASTIS.SALD.general_moving_target_discrete.cycle53_measure_map_endpoint_backfill` | `appendix.tex:1354-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.general_moving_target_discrete.kl_derivative` | formalized narrow measure handoff |

Lower packet: keep the next lower target on
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract` /
`SALD.generalMovingTargetDiscreteDerivativeObligation` /
`sald.general_moving_target_discrete.kl_derivative`, beginning with the
remaining `appendix.tex:1354-1387` common-space, density/absolute-continuity,
regular conditional drift, and weak conditional Fokker--Planck interfaces.

The Measure.map backfill is the only new formalized detail.  It does not prove
conditional drift, densities, Fokker--Planck, KL differentiation, LSI, DV,
Gronwall, or either theorem statement.

## Cycle 54 Analytic Interface Re-Check

Upper repeated the analytic-interface ledger pass instead of adding a detached
scalar lemma.  The new Lean-facing declarations are
`SALD.cycle54MainSkeletonAnalyticInterfaceLedger`,
`SALD.cycle54MainSkeletonAnalyticInterfaceObligation`,
`SALD.cycle54MainSkeletonAnalyticMiddleContract`,
`SALD.cycle54MainSkeletonAnalyticMiddleObligation`, and DAG nodes
`ASTIS.SALD.cycle54.analytic_interface_recheck`,
`ASTIS.SALD.cycle54.middle_interface_audit`,
`ASTIS.SALD.general_moving_target_discrete.cycle54_em_fp_sigma_split`, and
`ASTIS.SALD.cycle54.lower_packet.general_discrete_em_fp`.

Five slow interfaces:

| Interface | Source anchor | Lean-facing status |
|---|---|---|
| Gronwall endpoint-safe differentiability/FTC | `appendix.tex:47-71` | `SALD.saldGronwallEndpointCalculusContract`; obligation |
| Donsker--Varadhan common-space/finite-log-mgf | `appendix.tex:73-79` | `dvVariationalFormulaInterface saldDvVariationSource`; source-cited |
| LSI to KL/FI density test | `main_body.tex:202-215` | `SALD.saldLsiKlFiDensityTestContract`; obligation |
| Continuous Fokker--Planck/KL derivative | `appendix.tex:168-252`, `appendix.tex:765-884` | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.generalMovingTargetDerivativeCandidateContract`; obligation |
| EM interpolation endpoint/conditional-law Fokker--Planck | `appendix.tex:1354-1387` | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; endpoint-law handoff and sigma-weighted divergence regrouping formalized only |

The six theorem skeletons now list the cycle-54 obligation while remaining
`contractOnly`: `thm:forward-KL`, `thm:forward-KL-discrete`,
`prop:guided_path_residual`, `thm:general-moving-target-SALD`,
`thm:unified-forward-KL`, and
`thm:general-moving-target-SALD-discrete`.

Middle audit: `SALD.cycle54MainSkeletonAnalyticMiddleContract` verifies that
the upper ledger is consumed by the six theorem nodes in paper order and adds
`SALD.cycle54MainSkeletonAnalyticMiddleObligation` to each theorem contract.
The audit does not prove or promote any analytic backend; it only sharpens the
source-to-Lean route and keeps the next useful lower target on the discrete
general EM conditional-law/Fokker--Planck backend.

Lower packet: continue at `appendix.tex:1354-1387` for
`SALD.generalMovingTargetDiscreteDerivativeCandidateContract`,
`SALD.generalMovingTargetDiscreteDerivativeObligation`, and
`sald.general_moving_target_discrete.kl_derivative`.  The endpoint-law
`Measure.map` handoff and the sigma-weighted divergence regrouping theorem
are available, but regular conditional drift, density/absolute-continuity,
weak conditional Fokker--Planck, KL differentiation, and integration by parts
remain obligations.

Cycle 54 lower proof-producing increment:

| Source fragment | Lean declaration | Translation status |
|---|---|---|
| `appendix.tex:1380-1387`: substitute the conditional-drift FP equation and Laplacian split, then regroup the `sigma_eta^2/2` term into `div(hat rho_s*((sigma_eta^2/2)*nabla log tilde pi_s-bar b_{k,s}))`. | `SALD.generalMovingTargetDiscreteConditionalFpSigmaLaplacianSplitHandoff` | Formalized algebra under explicit hypotheses: weak FP identity, Laplacian split, additivity, negation, and real-linearity of the abstract divergence operator. |
| Same source block as theorem-useful lower packet. | `SALD.cycle54GeneralMovingTargetDiscreteEmFpLowerObligation`; `ASTIS.SALD.general_moving_target_discrete.cycle54_em_fp_sigma_split` | Obligation records that common-space construction, conditional drift, density/AC, weak FP, KL differentiation, mass conservation, integration by parts, and endpoint stitching are still unproved. |

## Cycle 55 Continuous Forward-KL Skeleton Rewire

Upper returned the cycle-54 five-backend audit to the focused continuous
forward-KL theorem.  The new Lean-facing route data are
`SALD.cycle55ForwardKlSkeletonUpperPacket`,
`SALD.cycle55ForwardKlSkeletonObligation`,
`SALD.cycle55ForwardKlSkeletonMiddleContract`,
`SALD.cycle55ForwardKlSkeletonMiddleObligation`, and DAG nodes
`ASTIS.SALD.forward_KL.cycle55_continuous_skeleton_route`,
`ASTIS.SALD.forward_KL.cycle55_middle_route_audit`, and
`ASTIS.SALD.forward_KL.cycle55_lower_packet.kl_derivative`.

Source-to-Lean route:

| Source block | Lean-facing route | Remaining backend |
|---|---|---|
| `main_body.tex:238-247`: theorem display with `C_LSI(t) >= 0`, finite `E_{alpha0}`, `alpha in (0,alpha0]`, and the two-exponential terminal bound. | `SALD.continuousForwardKlStatementContract`; `SALD.continuousSaldContract`; `SALD.cycle55ForwardKlSkeletonObligation` | theorem remains `contractOnly`; no statement or coefficient changed |
| `appendix.tex:168-228`: KL derivative, SALD Fokker--Planck, target transport, LSI, and inverse-schedule time change. | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `sald.forward_kl.kl_derivative`; cycle-50 scalar handoff | mass conservation, density/AC, boundary integration by parts, KL differentiation, and schedule calculus remain obligations |
| `main_body.tex:202-215`: LSI/KL/FI bridge. | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | density, zero-set convention, admissible sqrt-density test, entropy identity, finite KL/FI, and Fisher chain rule remain obligations |
| `appendix.tex:230-241`: DV velocity-energy step with `Z=alpha*||v_t||^2`. | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `sald.forward_kl.dv_energy_bound` | common-space, absolute-continuity, finite KL/log-mgf, measurability, and alpha0-to-alpha witness remain source-cited or obligations |
| `appendix.tex:244-252`: Gronwall with `a(t)=dot{s}(t)C_LSI(t)-(1/2)dot{s}(t)^(-1)alpha^(-1)` and `b(t)=(1/2)dot{s}(t)^(-1)E_alpha`. | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract`; `sald.forward_kl.gronwall_application`; `sald.forward_kl.gronwall_side_conditions` | endpoint rewrites, coefficient regularity, exponent split, residual exponent drop, and full Gronwall backend remain obligations |
| downstream discrete slow backend | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | visible only as sibling backend for theorem-route completeness; not a continuous theorem assumption |

Middle synchronization:
`SALD.cycle55ForwardKlSkeletonMiddleContract` and
`SALD.cycle55ForwardKlSkeletonMiddleObligation` now check the cycle-55 upper
route against the exact paper order.  They keep `main_body.tex:238-247`
unchanged, route `appendix.tex:168-252` through the named derivative, LSI, DV,
and Gronwall interfaces, and keep the lower packet on
`sald.forward_kl.kl_derivative` over `appendix.tex:168-228`.  This is a
workflow audit only; it does not promote the continuous derivative,
LSI/KL/FI, DV, Gronwall, EM interpolation, or the theorem contract.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 55 continuous route | Consume the cycle-54 five-backend re-check and cycle-50 forward-KL route, then wire the exact derivative -> LSI -> DV -> Gronwall chain. | cycle-54 analytic ledger; cycle-50 forward-KL skeleton; derivative, LSI, DV, Gronwall, and EM interfaces | `SALD.cycle55ForwardKlSkeletonUpperPacket`; `SALD.cycle55ForwardKlSkeletonObligation`; `ASTIS.SALD.forward_KL.cycle55_continuous_skeleton_route` | `main_body.tex:238-247`; `appendix.tex:164-252` | `thm:forward-KL`; cycle 55 middle route audit | obligation |
| Cycle 55 middle route audit | Verify the upper cycle-55 route in paper order and select the continuous KL derivative/Fokker--Planck backend while leaving LSI, DV, Gronwall, and EM as separate obligations. | cycle-55 upper route; cycle-54 analytic middle audit; cycle-50 forward-KL middle audit; derivative, LSI, DV, Gronwall, and EM interface obligations | `SALD.cycle55ForwardKlSkeletonMiddleContract`; `SALD.cycle55ForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL.cycle55_middle_route_audit` | `main_body.tex:238-247`; `appendix.tex:164-252`; lower slice `appendix.tex:168-228` | `thm:forward-KL`; cycle 55 lower derivative packet | obligation |
| Cycle 55 lower packet | Keep proof-producing work on the continuous KL derivative/Fokker--Planck backend before DV or Gronwall backfill. | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeObligation`; density/boundary and schedule obligations; cycle-50 scalar handoff | `ASTIS.SALD.forward_KL.cycle55_lower_packet.kl_derivative` | `appendix.tex:168-228` | `sald.forward_kl.kl_derivative`; `thm:forward-KL` | obligation |

Lower packet: target exactly `SALD.forwardKlDerivativeCandidateContract` /
`SALD.forwardKlDerivativeObligation` / `sald.forward_kl.kl_derivative`.
Start with `appendix.tex:168-185` mass conservation, KL differentiation under
the integral, SALD Fokker--Planck substitution, integration by parts, and the
`-FI` identification.  Then expose the target transport and inverse-schedule
interfaces from `appendix.tex:187-228`.  LSI/KL/FI, DV finite-log-mgf,
Gronwall side conditions, and EM interpolation remain separate named
interfaces unless their exact analytic backends compile locally.

Cycle 55 lower proof-producing increment:

| Source fragment | Lean declaration | Translation status |
|---|---|---|
| `appendix.tex:168-174`: the raw KL derivative split includes the mass term corresponding to `int partial_s rho_s dx`, which the paper drops using mass conservation. | `SALD.forwardKlMassConservationDropScalar` | Formalized scalar equality under the explicit hypothesis that the mass term is zero. |
| `appendix.tex:168-185`: after the mass term is dropped, the SALD Fokker--Planck/integration-by-parts backend identifies the first term with `-FI`. | `SALD.forwardKlMassConservationFirstTermFisherScalar`; `SALD.cycle55ForwardKlDerivativeMassLowerObligation`; `ASTIS.SALD.forward_KL.cycle55_derivative_mass_lower` | Formalized scalar composition only. Mass conservation, differentiation under the integral, Fokker--Planck, boundary/no-flux integration by parts, and FI identification remain obligations under `sald.forward_kl.kl_derivative`. |

No theorem statement, source label, coefficient, theorem status, SLT reuse
status, or analytic backend status changed.

## Cycle 109 Named `barB` Source-Definition Boundary

Classification: `narrows-source-cited-boundary`.

Source-to-Lean synchronization for `appendix.tex:1368-1377`:

| Source step | Lean-facing declaration | Translation status |
|---|---|---|
| Define `bar b_{k,s}(x)` as the conditional expectation of `dot t_k c_{t_k}(X_k^eta) + (sigma_eta^2/2) nabla log pi_{t_k}(X_k^eta)` given `hat X_s=x`. | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpKernelSourceDef` | formalized local bridge from a source `condExpKernel.map` representative and sample-space kernel alignment to the downstream `hatRhoS`-a.e. canonical `condDistrib` equality |
| Treat the same source definition as a Mathlib product conditional expectation on the sample space. | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSourceDef` | formalized lower bridge: `condExp_prod_ae_eq_integral_condDistrib` plus Bochner integral linearity gives the downstream `hatRhoS`-a.e. canonical `condDistrib` equality from `barB (hatXAtS omega)` as the selected conditional-expectation representative |
| Align Mathlib `condDistrib XkEta hatXAtS P (hatXAtS omega)` with `condExpKernel P (mState.comap hatXAtS).map XkEta omega`. | `SALD.cycle109GeneralMovingTargetDiscreteNamedBarBSourceDefBoundary`; `ASTIS.SALD.cycle109.remaining_condExpKernel_source_def_and_kernel_alignment` | exact missing theorem with imports and hypotheses recorded; no direct `hbarBAe` wrapper |
| Feed the named representative equality into the existing regularity route. | `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfCanonicalAeEq`; `SALD.generalMovingTargetDiscreteCondDistribCanonicalDriftRegularity` | cycle 106 regularity remains compiled; cycle 109 only narrows the named source-definition equality needed to use it |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 109 middle source map | The paper's named `barB` must be the conditional-expectation representative of the guide-plus-score frozen drift under `hat X_s`. | cycle 106 canonical regularity; cycle 103 condExpKernel bridge; Mathlib `CondDistrib`/`Condexp` | `SALD.cycle109GeneralMovingTargetDiscreteNamedBarBSourceDefMiddleObligation`; `ASTIS.SALD.cycle109.middle_named_barB_source_def_boundary` | `appendix.tex:1368-1377` | EM interpolation FP, both discrete theorem routes | obligation |
| Compiled source-definition bridge | Transport a `condExpKernel.map` source definition of `barB` to a `hatRhoS`-a.e. canonical `condDistrib` equality. | `hhatRhoS = Measure.map hatXAtS P`; sample-space kernel alignment; equality-set measurability | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpKernelSourceDef`; `ASTIS.SALD.cycle109.compiled_named_barB_source_def_bridge` | `appendix.tex:1368-1377`; Mathlib conditional kernels | EM conditional drift regularity | formalized |
| Lower product-condExp bridge | Transport the paper's sample-space conditional-expectation representative for `barB` through Mathlib `condExp_prod_ae_eq_integral_condDistrib` and `hatRhoS = Law(hatXAtS)`. | measurable `hatXAtS`; a.e.-measurable `XkEta`; guide/score integrability; equality-set measurability | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSourceDef`; `ASTIS.SALD.cycle109.lower_named_barB_condExp_source_bridge` | `appendix.tex:1368-1377`; Mathlib conditional expectation | EM conditional drift regularity | formalized |
| Remaining lower boundary | Prove the selected sample-space representative `P[frozen guide+score | mState.comap hatXAtS] = barB (hatXAtS omega)` a.e. and the equality-set measurability for `ae_map_iff`; the older condExpKernel-map route still separately needs measure-valued kernel alignment. | finite/probability `P`; standard-Borel state; measurable `hatXAtS`; a.e.-measurable `XkEta`; complete vector codomain; guide/score Bochner integrability | `ASTIS.SALD.cycle109.remaining_condExp_source_representative_for_named_barB`; `ASTIS.SALD.cycle109.remaining_condExpKernel_source_def_and_kernel_alignment` | `appendix.tex:1368-1377`; `Mathlib.Probability.Kernel.CondDistrib`; `Mathlib.Probability.Kernel.Condexp` | lower packet | source-cited obligation |

Non-goals unchanged: no weak-FP, box-trace, KL/log-ratio, LSI, DV, Gronwall,
theorem-status, SLT import, Lake dependency, or source-index rebaseline work.

## Cycle 110 Named `barB` Equality-Set Measurability

Classification: `discharges-supplied-hypothesis`.

Cycle 110 keeps the active backend on `appendix.tex:1368-1387`: the weak-FP
source signs at `appendix.tex:1379-1387` need the named `barB` selected at
`appendix.tex:1368-1377`, and cycle 109 left two concrete side conditions for
the source representative route.  This cycle discharges only the equality-set
measurability side condition used by `ae_map_iff`.

| Source step | Lean-facing declaration | Translation status |
|---|---|---|
| Transport the source conditional-expectation equality from sample space to `hatRhoS = Law(hatXAtS)` using `ae_map_iff`. | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSourceDef` | cycle 109 bridge remains compiled |
| Prove the equality set for the canonical guide-plus-score field and named `barB` is measurable under measurable representatives. | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBEqMeasOfStronglyMeasurable` | formalized local theorem using `MeasureTheory.StronglyMeasurable.measurableSet_eq_fun` |
| Finish the selected named representative. | `ASTIS.SALD.cycle110.remaining_condExp_source_representative_after_eq_meas` | remaining exact theorem: prove `hbarBCondExp` and provide strong measurability of the chosen representatives if that route is used |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 110 middle boundary | Remove the supplied `hbarBEqMeas` side condition rather than adding a generator-to-law wrapper. | cycle 109 source bridge; cycle 104 named-law transport as already completed context | `SALD.cycle110GeneralMovingTargetDiscreteNamedBarBEqMeasMiddleObligation`; `ASTIS.SALD.cycle110.middle_named_barB_eq_meas_boundary` | `appendix.tex:1368-1377`; consumer `appendix.tex:1379-1387` | EM weak-FP backend and both discrete theorem routes | obligation |
| Cycle 110 lower helper | Strong measurability of the canonical `condDistrib` guide-plus-score field and named `barB` implies the equality-set measurability consumed by `ae_map_iff`. | Mathlib `StronglyMeasurable.measurableSet_eq_fun` | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBEqMeasOfStronglyMeasurable`; `ASTIS.SALD.cycle110.lower_named_barB_eq_meas` | `appendix.tex:1368-1377` | cycle 109 source bridge | formalized |
| Remaining lower theorem | Prove the source-selected sample-space conditional expectation representative after the equality-set side condition has been removed. | Mathlib `condExp_prod_ae_eq_integral_condDistrib`; source definition of `barB` | `ASTIS.SALD.cycle110.remaining_condExp_source_representative_after_eq_meas` | `appendix.tex:1368-1377` | weak-FP source signs through `barB` | obligation |

No new wrapper was added around `lawMapIntegral`, source signs, no-boundary,
KL/log-ratio, LSI, DV, or Gronwall.  Local SLT material was consulted only as
the prior cycle's conditional-expectation style reference; no SLT theorem was
imported or marked formalized.

## Cycle 112 Named `barB` Conditional-Expectation Representative

Classification: `narrows-source-cited-boundary`.

Cycle 112 stays on `appendix.tex:1368-1377` and the active EM backend.  It
replaces the remaining raw `hbarBCondExp` premise from
`SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSourceDef`
with Mathlib's conditional-expectation uniqueness criterion.

| Source step | Lean-facing declaration | Translation status |
|---|---|---|
| The paper defines `bar b_{k,s}(x)` as the conditional expectation of the frozen guide-plus-score drift given `hat X_s=x`. | `SALD.generalMovingTargetDiscreteNamedBarBCondExpOfSetIntegralEq` | formalized local theorem: derives the old `hbarBCondExp` equality from candidate measurability, candidate integrability, guide/score integrability, and equality of Bochner set integrals on every `hatXAtS`-measurable finite-measure set |
| Feed that derived representative into the existing product conditional-expectation source bridge. | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSetIntegralDef` | formalized downstream handoff: the canonical `condDistrib` guide-plus-score equality no longer requires primitive `hbarBCondExp` |
| Restrict the set-integral characterization to source-facing state events. | `SALD.generalMovingTargetDiscreteNamedBarBSetIntegralOfStateEvents`; `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef` | formalized local theorem: matching Bochner integrals on events `{omega | hatXAtS omega in t}` for measurable state sets `t` imply the all-`mState.comap hatXAtS` set-integral criterion |
| Finish the selected named representative. | `ASTIS.SALD.cycle112.remaining_named_barB_set_integral_characterization` | remaining exact theorem: prove `barB (hatXAtS omega)` is the integrable `mState.comap hatXAtS`-measurable representative with matching set integrals against the frozen guide-plus-score drift on source-facing state events |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 112 middle boundary | Replace `hbarBCondExp` by a conditional-expectation uniqueness boundary instead of restating the a.e. equality. | cycle 109 source bridge; cycle 110 equality-set helper; Mathlib conditional expectation uniqueness | `SALD.cycle112GeneralMovingTargetDiscreteNamedBarBCondExpRepresentativeMiddleObligation`; `ASTIS.SALD.cycle112.middle_named_barB_condExp_representative` | `appendix.tex:1368-1377` | EM weak-FP backend and both discrete theorem routes | obligation |
| Cycle 112 lower uniqueness bridge | `barB ∘ hatXAtS` satisfies the uniqueness hypotheses for conditional expectation. | `MeasureTheory.ae_eq_condExp_of_forall_setIntegral_eq`; `MeasureTheory.Integrable.comp_aemeasurable` | `SALD.generalMovingTargetDiscreteNamedBarBCondExpOfSetIntegralEq`; `ASTIS.SALD.cycle112.lower_packet.named_barB_condExp_uniqueness` | `appendix.tex:1368-1377`; Mathlib conditional expectation | cycle 109 source bridge | formalized |
| Cycle 112 downstream source bridge | Use the derived `hbarBCondExp` in the existing product-condExp bridge. | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSourceDef`; `ProbabilityTheory.condExp_prod_ae_eq_integral_condDistrib` | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSetIntegralDef`; `ASTIS.SALD.cycle112.lower_packet.named_barB_source_bridge_without_hbarBCondExp` | `appendix.tex:1368-1377` | named `barB` regularity and EM weak FP | formalized |
| Cycle 112 state-event set-integral bridge | Replace all comap-measurable sample-space sets with source-facing state events. | `MeasurableSpace.measurableSet_comap`; existing set-integral source bridge | `SALD.generalMovingTargetDiscreteNamedBarBSetIntegralOfStateEvents`; `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef`; `ASTIS.SALD.cycle112.lower_packet.named_barB_state_event_set_integral` | `appendix.tex:1368-1377` | cycle 112 remaining theorem and EM weak FP | formalized |
| Remaining theorem | Prove the source state-event set-integral characterization and candidate regularity for the selected representative. | source conditional expectation definition; Bochner integrals over `{omega | hatXAtS omega in t}` for measurable state sets `t` | `ASTIS.SALD.cycle112.remaining_named_barB_set_integral_characterization` | `appendix.tex:1368-1377` | lower packet | obligation |

No source-index rebaseline, weak-FP/no-boundary wrapper, KL/log-ratio work,
LSI, DV, Gronwall, theorem-status change, Lake change, SLT import, or
`sald_version_2.tex` use was introduced.  Local `SLT/EfronStein.lean` was
consulted only for conditional-expectation/product-measure proof style.

## Cycle 113 Discrete Forward-KL Pressure Test

Classification: `narrows-source-cited-boundary`.

Cycle 113 applies the post-cycle-84 theorem pressure test to
`thm:forward-KL-discrete` without adding another wrapper.  The currently
compiled dependency list for the theorem already routes through the EM backend
and the existing LSI/DV/Gronwall interfaces; the active route reaches the
cycle-112 named `barB` conditional-expectation representative bridge before any
new scalar theorem blocker appears.

Source-to-Lean route:

| Source step | Current Lean route | Remaining non-wrapper blocker |
|---|---|---|
| `main_body.tex:301-323`: discrete forward-KL statement and display. | `SALD.discreteForwardKlStatementContract`; `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` | theorem remains `contractOnly`; no display or Gronwall status promotion |
| `appendix.tex:334-592`: discrete proof route through EM, frozen defect, LSI, DV, and Gronwall. | existing EM wrappers plus `SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`, `SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged`, and accumulated-error display wrappers | no new LSI/DV/Gronwall blocker found before the active EM backend |
| `appendix.tex:1358-1387`: shared general EM/KL backend used by the discrete route. | cycle-111 target-time KL handoff plus cycle-112 named `barB` conditional-expectation bridge | selected `barB` representative regularity and state-event set-integral characterization at `appendix.tex:1368-1377` |
| `appendix.tex:1368-1377`: source definition of `\bar b_{k,s}` by conditioning on `\hat X_s=x`. | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateFieldSetIntegralDef` | `hbarBMeas` and `hbarBInt` are discharged from state-field regularity; remaining exact source theorem is `hbarBStateSetIntegral` on state events, plus any proof of `Integrable barB hatRhoS` not already supplied by the selected representative |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 113 pressure test | Route `thm:forward-KL-discrete` through current EM, LSI, DV, and Gronwall interfaces and stop at the first non-wrapper blocker. | cycle-111 target-time derivative; cycle-112 named `barB` state-event bridge; existing discrete scalar wrappers | `ASTIS.SALD.cycle112.remaining_named_barB_set_integral_characterization`; consuming declaration `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef` | `appendix.tex:1368-1377` | `thm:forward-KL-discrete`; `sald.general_moving_target_discrete.em_interpolation_fp` | obligation; narrowed source boundary |
| Cycle 113 lower state-field regularity | Pull candidate regularity back from the named state marginal. | `hatRhoS = Measure.map hatXAtS P`; `Measurable.of_comap_le`; `MeasureTheory.Integrable.comp_measurable` | `SALD.generalMovingTargetDiscreteNamedBarBComapRegularityOfStateField`; `ASTIS.SALD.cycle113.lower_packet.named_barB_state_field_regularity` | `appendix.tex:1368-1377` | cycle 112 state-event bridge; both discrete theorem routes | formalized |
| Cycle 113 lower state-field set-integral bridge | Feed the derived regularity facts into the cycle-112 consumer. | cycle-112 state-event bridge; state-field regularity pullback | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateFieldSetIntegralDef`; `ASTIS.SALD.cycle113.lower_packet.named_barB_state_field_set_integral_bridge` | `appendix.tex:1368-1377` | EM weak-FP backend; `thm:forward-KL-discrete` | formalized |
| Cycle 113 remaining blocker | Prove the selected representative's source state-event Bochner set-integral equality. | source conditional-expectation definition of `barB`; Bochner integrals over `{omega | hatXAtS omega in t}` | `ASTIS.SALD.cycle113.remaining_named_barB_state_event_set_integral` | `appendix.tex:1368-1377` | lower packet | obligation |

Lower-ready packet:

Prove or strictly narrow the source-cited theorem that the paper-selected
`barB` representative has matching Bochner set integrals over all state events
`{omega | hatXAtS omega in t}` with measurable `t : Set State`.  Cycle 113 lower
has already discharged the sample-space `hbarBMeas` and `hbarBInt` premises
from source-facing `StronglyMeasurable barB` and `Integrable barB hatRhoS` plus
`hatRhoS = Measure.map hatXAtS P`.  If the remaining state-event equality cannot
compile, isolate one Mathlib/conditional-expectation theorem with exact imports
and hypotheses.  Do not add a route-audit wrapper, source-index rebaseline,
LSI/DV/Gronwall packet, SLT import, theorem-status promotion, or
`sald_version_2.tex` dependency.

## Cycle 110 Dominated Generator-To-Law Weak-FP Transport

Classification: `discharges-supplied-hypothesis`.

This lower packet targets `appendix.tex:1379-1387`.  It removes the
integral-level sample-space derivative hypothesis `hsampleGenerator` from the
cycle-104 named-law split-generator route by proving that derivative from
pointwise path derivatives and Mathlib's dominated parametric-integral theorem,
then transporting through `Measure.map`/`hatRhoS = Law(hatX_s)`.

| Source step | Lean-facing declaration | Translation status |
|---|---|---|
| Differentiate the sample-space weak-test integral for the EM interpolation using pointwise derivatives and an integrable bound. | `AutoSamplingTheory.lawMapIntegralHasDerivAtOfDominated` | formalized local theorem using `hasDerivAt_integral_of_dominated_loc_of_deriv_le` |
| Rewrite from the named law `hatRhoS s` to `Measure.map (hatX s) P`. | `AutoSamplingTheory.lawIntegralHasDerivAtOfMeasureMapEqAndDominated` | formalized local named-law transport |
| Obtain the weak-FP law derivative with source signs. | `SALD.generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfDominatedSplitGeneratorHandoff` | formalized local theorem; discharges `hsampleGenerator` |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Dominated generator-to-law lower packet | Pointwise sample-path derivatives plus local domination imply the named-law weak-test derivative and source signs. | Mathlib parametric integral; cycle-79 law-map helpers; cycle-104 named-law route | `SALD.cycle110GeneralMovingTargetDiscreteWeakFpDominatedGeneratorLowerObligation`; `ASTIS.SALD.cycle110.lower_packet.dominated_generator_to_law_transport` | `appendix.tex:1379-1387` | EM weak-FP backend and both discrete theorem routes | formalized |
| Remaining parametric generator boundary | Prove the actual EM interpolation pointwise derivative and domination package for each admissible weak test, and identify the derivative integral with `driftAction + diffusionAction`. | source EM interpolation; drift `barB`; diffusion coefficient; no-boundary/source-action backends | `ASTIS.SALD.cycle110.remaining_parametric_generator_boundary_after_dominated_transport` | `appendix.tex:1379-1387`; drift source `appendix.tex:1368-1377` | weak-FP source signs | obligation |

This is not a broad wrapper churn packet: the previous theorem assumed the
sample-space integral derivative directly, while the new theorem derives it
from explicit pointwise derivative, measurability, integrability, and dominated
bound hypotheses.  Remaining source-cited work is the concrete EM path
derivative/dominated-bound proof, not another law-map transport theorem.

## Cycle 106 Canonical Conditional-Drift Regularity

Classification: `discharges-supplied-hypothesis`.

Cycle 106 stays on the active EM conditional-law/Fokker--Planck backend
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.  It discharges one old cycle 80-84 supplied
conditional integral regularity premise for the canonical conditional drift in
the source definition of

```text
bar b_{k,s}(x)
  = E[dot t_k c_{t_k}(X_k^eta)
      + (sigma_eta^2 / 2) nabla log pi_{t_k}(X_k^eta)
      | hat X_s = x].
```

Lean-facing update:

| Source step | Lean-facing route | Status |
|---|---|---|
| `appendix.tex:1368-1377`: define the frozen conditional drift by conditioning the guide and score terms on `hat X_s = x`. | `SALD.generalMovingTargetDiscreteCondDistribCanonicalDriftRegularity` | formalized local theorem proving `AEStronglyMeasurable` and `Integrable` for the canonical `condDistrib` guide+score field under `hatRhoS = Measure.map hatXAtS P` and joint guide/score integrability |
| Downstream named `barB` representative is identified with the canonical conditional integral. | `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfCanonicalAeEq` | formalized local theorem transferring `AEStronglyMeasurable` and `Integrable` to `barB` from a `hatRhoS`-a.e. equality to the canonical `condDistrib` field; the a.e. equality itself remains the exact source-cited boundary |
| Register the handoff without broadening the theorem route. | `SALD.cycle106GeneralMovingTargetDiscreteCanonicalCondDistribDriftMiddleObligation`; `SALD.cycle106GeneralMovingTargetDiscreteCanonicalCondDistribDriftLowerObligation`; `SALD.cycle106GeneralMovingTargetDiscreteCanonicalCondDistribDriftDag`; `SALD.cycle106EmCanonicalCondDistribDriftDependencyNames` | obligation wrappers plus one compiled local theorem; dependency lists for `thm:forward-KL-discrete` and `thm:general-moving-target-SALD-discrete` now include the cycle 106 packet |

The compiled theorem uses the existing local Mathlib-facing wrappers
`AutoSamplingTheory.condDistribIntegralNamedLawAEStronglyMeasurable` and
`AutoSamplingTheory.condDistribIntegralNamedLawIntegrable`.  The local SLT
reference `SLT/EfronStein.lean` was consulted only for product-measure and
conditional-integral proof style; no SLT theorem was imported or promoted.

Remaining exact boundary:

- If downstream statements continue to use an arbitrary named representative
  `barB`, prove `hatRhoS`-a.e. equality between that representative and the
  canonical `condDistrib` guide+score field above.  Once this equality is
  supplied, `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfCanonicalAeEq`
  gives the named-field regularity without reopening the component-regularity
  hypotheses.
- The weak-FP generator-to-law backend, no-boundary drift-divergence identity
  for `hatRhoS * barB`, diffusion source action, KL/log-ratio
  differentiability, LSI, DV, Gronwall, theorem status, SLT import, and Lake
  dependency status remain unchanged.

## Cycle 103 Conditional-Kernel Component Version Boundary

Classification: `narrows-source-cited-boundary`.

Cycle 103 returns to the conditional-drift definition at
`appendix.tex:1368-1377` and selects one component only, `condC`.  Lower
compiled the bridge that turns a selected `condExpKernel.map` version into the
canonical `condDistrib X_k^eta hatXAtS P` guide integral after composing with
`hatXAtS`, without assuming the old `hguideComp` equality.  The remaining
boundary is now the measure-valued kernel equality and selected field-version
facts needed by that bridge.

| Source step | Lean-facing route | Current status |
|---|---|---|
| `appendix.tex:1368-1377`: `bar b_{k,s}` uses the conditional expectation of the frozen guide component given `hat X_s=x`. | `SALD.cycle103GeneralMovingTargetDiscreteConditionalKernelVersionMiddleObligation`; `ASTIS.SALD.cycle103.middle_conditional_kernel_component_version` | obligation; selects the `condC` component-version theorem only |
| Mathlib orientation: condition `X_k^eta` on `hat X_s`, not reversed. | `AutoSamplingTheory.condDistribAeEqCondExpKernelMap`; Mathlib `ProbabilityTheory.condDistrib_apply_ae_eq_condExpKernel_map`; `ProbabilityTheory.condExp_ae_eq_integral_condExpKernel` | compiled local orientation helper plus missing version-selection theorem |
| Lower bridge. | `AutoSamplingTheory.condDistribIntegralSampleAeEqOfCondExpKernelMap`; `SALD.generalMovingTargetDiscreteCondDistribNamedFieldAeEqOfCondExpKernelMap`; `ASTIS.SALD.cycle103.lower_condExpKernel_map_version_bridge` | formalized local theorem: measure-valued `condDistrib = condExpKernel.map` a.e. plus a selected `condExpKernel.map` field version supplies the old `condDistrib` sample-space component equality |
| Exact remaining theorem boundary. | `ASTIS.SALD.cycle103.condC_condDistrib_condExpKernel_sample_version` | missing theorem: prove the measure-valued kernel equality `condDistrib X_k^eta hatXAtS P (hatXAtS omega) = condExpKernel P (mState.comap hatXAtS).map X_k^eta omega`, prove the selected `condExpKernel.map` guide-component version for `condC`, and prove the measurable equality set for `ae_map_iff` |

Required imports/hypotheses for lower: `Mathlib.Probability.Kernel.CondDistrib`,
`Mathlib.Probability.Kernel.Condexp`, Bochner integral basics,
finite-measure/standard-Borel assumptions, `hatRhoS = P.map hatXAtS`,
a.e. measurability of `hatXAtS` and `X_k^eta`, guide-component
measurability/integrability on the joint law
`P.map (fun omega => (hatXAtS omega, X_k^eta omega))`, the measure-valued
kernel equality, and the chosen `condExpKernel.map` version definition for
`condC`.

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 103 middle source map | Pick only the `condC` sample-version equality behind cycle 91; reject wrappers around `hguideComp`, `hfieldAe`, `hcanonical`, weak FP, KL, LSI, DV, Gronwall, or no-boundary hypotheses. | cycle 91 named-field transport; Mathlib `CondDistrib`/`Condexp`; `AutoSamplingTheory.condDistribAeEqCondExpKernelMap` | `SALD.cycle103GeneralMovingTargetDiscreteConditionalKernelVersionMiddleObligation`; `ASTIS.SALD.cycle103.middle_conditional_kernel_component_version` | `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfSampleVersions`; EM backend | obligation |
| Cycle 103 lower bridge | A measure-valued `condDistrib`/`condExpKernel.map` a.e. equality and selected `condExpKernel.map` field version imply the old canonical `condDistrib` guide integral sample-space equality. | `MeasureTheory.integral_congr_ae`; cycle 91 named-field transport | `AutoSamplingTheory.condDistribIntegralSampleAeEqOfCondExpKernelMap`; `SALD.generalMovingTargetDiscreteCondDistribNamedFieldAeEqOfCondExpKernelMap`; `ASTIS.SALD.cycle103.lower_condExpKernel_map_version_bridge` | `appendix.tex:1368-1377` | cycle 91 remaining boundary; named conditional drift regularity | formalized local bridge |
| Exact remaining theorem | Prove the measure-valued kernel a.e. equality, selected `condExpKernel.map` guide-component version for `condC`, and equality-set measurability. | `condDistrib_apply_ae_eq_condExpKernel_map`; `condExp_ae_eq_integral_condExpKernel`; Bochner integral congruence/version selection | `ASTIS.SALD.cycle103.condC_condDistrib_condExpKernel_sample_version` | `appendix.tex:1368-1377`; Mathlib `Condexp.lean`/`CondDistrib.lean` | cycle 91 remaining boundary | obligation |

No SLT theorem is imported or marked formalized.  Local SLT
`SLT/EfronStein.lean` was consulted only for conditional-expectation and
product-measure proof style.  The weak-FP, KL, no-boundary, LSI, DV, Gronwall,
theorem status, and Lake dependency status are unchanged.

## Cycle 104 Named-Law Generator-To-Law Transport

Classification: `discharges-supplied-hypothesis`.

Cycle 104 returns to `appendix.tex:1379-1387`, where the paper invokes the
Fokker-Planck equation for the named law `hatRhoS = Law(hatX_s)`.  The cycle
keeps the active lower packet on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387` and narrows only the generator-to-law transport
bookkeeping: once `hatRhoS s = Measure.map (hatX s) P`, a sample-space
split-generator derivative now transports directly to the named-law weak-test
derivative.

| Source step | Lean-facing declaration | Current status |
|---|---|---|
| `appendix.tex:1379-1387`: `hat rho_s` is the law of the frozen interpolation and the weak test is integrated against that named law. | `AutoSamplingTheory.lawIntegralHasDerivAtOfMeasureMapEqAndSample` | formalized local helper; combines named-law equality with `lawMapIntegralHasDerivAtOfSample` |
| Same weak-FP generator-to-law step, with generator already split as drift plus diffusion. | `SALD.generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfSampleSplitGeneratorHandoff` | formalized local handoff; removes a primitive named-law `hlawDerivative`/rewrite premise under `hatRhoS s = Measure.map (hatX s) P` |
| Remaining exact theorem boundary. | `ASTIS.SALD.cycle104.remaining_generator_to_law_after_named_transport` | prove sample-path/Bochner derivative of the split generator, drift source through `barB` and no-boundary divergence, diffusion source action, admissible-test regularity, density/time regularity, and conditional-law compatibility |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 104 upper packet | Select named-law generator-to-law transport, not a wrapper around source signs, no-boundary, KL, LSI, DV, or Gronwall hypotheses. | cycle 79 `lawMapIntegral` helpers; cycle 92 split-generator route; `hatRhoS s = Measure.map (hatX s) P` | `SALD.cycle104GeneralMovingTargetDiscreteWeakFpNamedLawTransportUpperObligation`; `ASTIS.SALD.cycle104.global_phase_judgment` | `appendix.tex:1379-1387` | EM backend; both discrete theorem routes | obligation |
| Cycle 104 lower transport | Transport a supplied sample-space split-generator `HasDerivAt` to the named law path and rewrite the derivative value to the source signs. | `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; weak-test measurability against `hatRhoS`; drift/diffusion source-action inputs | `AutoSamplingTheory.lawIntegralHasDerivAtOfMeasureMapEqAndSample`; `SALD.generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfSampleSplitGeneratorHandoff`; `ASTIS.SALD.cycle104.lower_packet.named_law_generator_to_law_transport` | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.discrete_forward_kl.em_interpolation_fp` | formalized local theorem |
| Remaining boundary | Prove the actual sample-path generator derivative and source actions. | Mathlib parametric/Bochner integral APIs; cycle 100/102 no-boundary boundary; cycle 103 conditional kernel component boundary | `ASTIS.SALD.cycle104.remaining_generator_to_law_after_named_transport` | `appendix.tex:1368-1387` | weak-FP and KL handoffs | obligation |

Local SLT files consulted: `SLT/EfronStein.lean`,
`SLT/GaussianLSI/TensorizedGLSI.lean`, and `SLT/GaussianMeasure.lean`, only for
`Measure.map`/`integral_map` orientation style.  No SLT theorem is imported or
marked formalized, and no Lake dependency or theorem status changed.

## Cycle 105 Pure No-Mass KL/Log-Ratio Boundary

Classification: `narrows-source-cited-boundary`.

Cycle 105 returns to `appendix.tex:1358-1366`, the differentiated
`KL(hat rho_s || tilde pi_s)` display.  It keeps the theorem statements fixed
and narrows the cycle-99 no-mass finite-KL `llr` package: once the mass term is
already absent, the remaining KL differentiability theorem is purely a
measure-path statement and no longer needs sample-space `P`, `hatX`, `s0`,
`hatX` a.e. measurability, or mapped-law mass-derivative data.

| Source step | Lean-facing declaration | Current status |
|---|---|---|
| `appendix.tex:1358-1366`: after finite KL selects the Mathlib `llr` representative and the mass term has been removed, prove the no-mass KL derivative display. | `SALD.GeneralMovingTargetDiscretePureRawKlDerivativeNoMassAtFiniteKlLlr` | source-cited analytic theorem boundary |
| Extract the no-mass display from that pure package using finite-KL `llr` regularity. | `SALD.generalMovingTargetDiscretePureRawKlDerivativeNoMassAtFiniteKlLlrHkl` | formalized local handoff |
| Feed the exact admissible `llr` test and source-signed weak-FP action into the `dK` display. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfPureNoMassRawKlBoundaryAtFiniteKlLlrWithLogAction` | formalized local handoff |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 105 middle source map | Isolate the remaining no-mass KL differentiability theorem without sample-space law or mass-derivative fields. | cycle-99 no-mass boundary; finite-KL `llr` regularity | `SALD.cycle105GeneralMovingTargetDiscretePureRawKlDerivativeMiddleObligation`; `ASTIS.SALD.cycle105.middle_pure_raw_kl_derivative_source_map` | `appendix.tex:1358-1366` | EM/KL backend | obligation |
| Cycle 105 lower handoff | Extract `dK = partialS (llr hatRho tildePi) - targetTimeTerm`, derive admissibility through the cycle-88 closure package, and apply the existing source-sign-with-log-action theorem. | cycle-87 finite-KL regularity; cycle-88 admissibility closure; cycle-73/83 source-sign handoff | `SALD.generalMovingTargetDiscretePureRawKlDerivativeNoMassAtFiniteKlLlrHkl`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfPureNoMassRawKlBoundaryAtFiniteKlLlrWithLogAction` | `appendix.tex:1358-1366` | both discrete theorem routes | formalized local handoff |
| Remaining pure KL theorem | Prove endpoint-safe no-mass KL differentiation and target-time derivative formula from Mathlib KL/`llr` and parametric-integral/Bochner APIs. | Mathlib KL/log-likelihood; parametric integral candidates | `ASTIS.SALD.cycle105.remaining_pure_raw_kl_boundary` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative` | obligation |

Local SLT files consulted: `SLT/EfronStein.lean` and
`SLT/GaussianMeasure.lean`, only for `Measure.map`/integral idioms.  No SLT
theorem is imported or marked formalized.

## Cycle 111 Target-Time KL Derivative

Classification: `narrows-source-cited-boundary`.

Cycle 111 stays on `appendix.tex:1358-1366` and narrows the cycle-105 pure
raw-KL boundary to the target-density time derivative term in
`eq:general_KL_derivative_0_discrete`.

| Source step | Lean-facing declaration | Current status |
|---|---|---|
| `appendix.tex:1363-1364`: identify and justify the target-time term `- int (hat rho_s / tilde pi_s) * partial_s tilde pi_s dx`. | `SALD.generalMovingTargetDiscreteTargetTimeDerivativeOfDominated` | formalized local Mathlib parametric-integral subtheorem |
| Source density-ratio representative for the target-time term. | `SALD.generalMovingTargetDiscreteTargetTimeDerivativeSourceRatioCongr` | formalized local a.e. congruence bridge; remaining source work is the a.e. equality with `hat rho_s / tilde pi_s` |
| Feed the target-time integrability and derivative formula into the existing pure finite-KL `llr` package without reintroducing sample-space or mass data. | `SALD.generalMovingTargetDiscretePureRawKlTargetTimeFieldsOfDominated` | formalized local handoff with explicit source-specific bridges |
| Remaining source theorem after the target-time narrowing. | `ASTIS.SALD.cycle111.remaining_pure_raw_kl_after_target_time` | obligation: a.e. source density-ratio equality, pointwise target-density derivative/domination, source bridges, and endpoint-safe first-term KL differentiation |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 111 middle source map | Isolate the target-time subterm inside the remaining pure no-mass finite-KL `llr` KL-differentiability package. | cycle-105 pure raw-KL boundary; `eq:general_KL_derivative_0_discrete` | `SALD.cycle111GeneralMovingTargetDiscreteTargetTimeDerivativeMiddleObligation`; `ASTIS.SALD.cycle111.middle_target_time_derivative_boundary` | `appendix.tex:1358-1366` | EM/KL backend | obligation |
| Dominated target-time theorem | Fixed density-ratio weight plus target-density pointwise derivative/domination imply weighted derivative integrability and the weighted target-integral `HasDerivAt` formula. | Mathlib `hasDerivAt_integral_of_dominated_loc_of_deriv_le`; Bochner integrals | `SALD.generalMovingTargetDiscreteTargetTimeDerivativeOfDominated`; `ASTIS.SALD.cycle111.lower_packet.target_time_dominated_derivative` | `appendix.tex:1358-1366` | pure raw-KL target-time fields | formalized local theorem |
| Source-ratio congruence bridge | Transfer target-time term identification, integrability, and the target-integral `HasDerivAt` formula from the chosen fixed weight to the paper's source density-ratio representative under a.e. equality. | `MeasureTheory.integral_congr_ae`; `MeasureTheory.Integrable.congr` | `SALD.generalMovingTargetDiscreteTargetTimeDerivativeSourceRatioCongr`; `ASTIS.SALD.cycle111.lower_packet.target_time_source_ratio_congr` | `appendix.tex:1358-1366` | remaining target-time source bridge | formalized local theorem |
| Target-time fields handoff | Finite KL supplies `llr` regularity; the dominated target-time theorem supplies `targetTimeTermIntegrable` and `targetTimeDerivativeFormula` through explicit source bridges. | `SALD.generalMovingTargetDiscreteKlLogRatioRegularityOfFiniteKl`; dominated target-time theorem | `SALD.generalMovingTargetDiscretePureRawKlTargetTimeFieldsOfDominated`; `ASTIS.SALD.cycle111.lower_packet.target_time_fields_for_pure_raw_kl` | `appendix.tex:1358-1366` | both discrete theorem routes | formalized local handoff |
| Remaining pure KL theorem after target-time | Prove the a.e. equality identifying the fixed weight with `hat rho_s / tilde pi_s` and the target-density derivative/domination bridge, plus endpoint-safe first-term KL differentiation. | Mathlib KL/`llr`; parametric integral/Bochner APIs | `ASTIS.SALD.cycle111.remaining_pure_raw_kl_after_target_time` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative` | obligation |

Local SLT files consulted: `SLT/EfronStein.lean`,
`SLT/GaussianLSI/TensorizedGLSI.lean`, `SLT/GaussianMeasure.lean`, and
`SLT/SmallBallProb.lean` for measure/integral idioms only.  No SLT theorem is
imported or marked formalized.

## Cycle 100 BarB Weak-Pairing Definition Alignment

Cycle 100 returns to the generator-to-law weak-FP drift-source line at
`appendix.tex:1379-1387`, with `appendix.tex:1368-1377` supplying the named
conditional drift `barB`.

| Source step | Lean-facing declaration | Remaining obligation |
|---|---|---|
| `appendix.tex:1379-1387`: the weak drift source is the law integral of the test-gradient contraction against `barB`. | `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryBoundedPairingWeakGradDef` | compiled definition-alignment handoff; `weakGradPairing f phi` is specialized to `int x, fieldPairing phi f x d hatRhoS`, so the old `hweakGradIntegral` premise is no longer supplied |
| Same drift-source route, consumed by the cycle-94/98 handoffs. | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBBoundedNoBoundaryWeakGradDef` | feeds the definition-aligned weak pairing into the bounded no-boundary drift-source theorem |
| Remaining exact theorem after cycle 100. | `ASTIS.SALD.cycle100.remaining_no_boundary_after_weakGrad_def` | prove the concrete a.e. contraction bound for `fieldPairing phi barB`, and prove `driftDiv phi = - int x, fieldPairing phi barB x d hatRhoS` by the no-boundary divergence theorem for `hatRhoS * barB` |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 100 middle source map | Select the `hweakGradIntegral` definition-alignment premise inside the cycle-98 no-boundary theorem, not a new wrapper around `hbarBWeakDivergence`. | cycle 98 no-boundary handoff; Mathlib Bochner integral notation | `SALD.cycle100GeneralMovingTargetDiscreteBarBWeakGradDefMiddleObligation`; `ASTIS.SALD.cycle100.middle_barB_weakGrad_def_source_map` | `appendix.tex:1379-1387` | EM backend; both discrete theorem routes | obligation |
| Cycle 100 lower packet | Remove `hweakGradIntegral` by taking the weak pairing to be the `hatRhoS` law integral of `fieldPairing`. | `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryBoundedPairing`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBWeakAction` | `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryBoundedPairingWeakGradDef`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBBoundedNoBoundaryWeakGradDef` | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | weak-FP source signs; KL handoff; both discrete theorem routes | formalized local theorem; `narrows-source-cited-boundary` |

No theorem statement, source label, sign, coefficient, weak-FP/KL backend
status, SLT reuse status, or Lake dependency changed.

## Cycle 101 Discrete Forward-KL Pressure Sync

Classification: `narrows-source-cited-boundary`.

Cycle 101 pressure-tests `thm:forward-KL-discrete` through the already compiled
EM wrappers plus the existing LSI/DV/Gronwall and accumulated-error interfaces.
The route consumes the cycle-89/cycle-95 pressure-test data and the cycle-100
weak-pairing/inner-gradient handoffs; it does not need a new theorem-route
wrapper.

| Source step | Lean-facing declaration | Remaining obligation |
|---|---|---|
| `main_body.tex:301-323` and `appendix.tex:260-592`: discrete theorem route through EM, KL, LSI, DV, Gronwall, and accumulated-error interfaces. | `SALD.cycle101DiscreteForwardKlClosurePressureMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle101_middle_pressure_sync` | pressure sync only; theorem remains `contractOnly` |
| `appendix.tex:1379-1387`, with `barB` from `appendix.tex:1368-1377`: weak-FP drift source sign for `-div(hatRhoS * barB)`. | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientBound`; `ASTIS.SALD.cycle100.remaining_no_boundary_after_inner_gradient` | prove `hdivNoBoundary`: `driftDiv phi = - int x, inner (testGrad phi x) (barB x) d hatRhoS`, and carry `hgradNormBound` explicitly |
| Cycle 101 lower product-rule handoff. | `SALD.generalMovingTargetDiscreteDriftDivNoBoundaryOfProductRule`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientProductRuleBoundary`; `ASTIS.SALD.forward_KL_discrete.cycle101_lower_product_rule_handoff` | formalized local handoff; replaces monolithic `hdivNoBoundary` by product-rule total divergence, Mathlib divergence-theorem boundary flux, and zero boundary flux |
| Lower packet guard after the handoff. | `ASTIS.SALD.forward_KL_discrete.cycle101_next_non_wrapper_blocker` | prove the Euclidean weighted-field product rule and zero-boundary-flux/divergence-theorem instantiation for `hatRhoS * barB`; carry `hgradNormBound`; reject wrappers that merely restate `hdivNoBoundary`, `hgradNormBound`, KL, LSI, DV, Gronwall, or display assumptions |

Local SLT consultation: no SLT theorem was needed.  The only cited candidates
are Mathlib `MeasureTheory.Integral.DivergenceTheorem`,
`Analysis.InnerProductSpace.Basic`, and Bochner integral APIs already named by
cycle 100.

## Cycle 102 Zero-Flux Trace Boundary

Classification: `narrows-source-cited-boundary`.

Cycle 102 keeps the conversion window on the same source paragraph:
`appendix.tex:1379-1387` rewrites the weak-FP drift source through
`-div(hatRhoS * barB)`, with `barB` defined at `appendix.tex:1368-1377`.
After the cycle-101 product-rule handoff, the selected boundary is the raw
`hzeroBoundary` premise.

| Source step | Lean-facing declaration | Remaining obligation |
|---|---|---|
| No boundary contribution from the `hatRhoS * barB` divergence term. | `SALD.generalMovingTargetDiscreteZeroBoundaryFluxOfTraceProductZero`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientTraceBoundary`; `ASTIS.SALD.forward_KL_discrete.cycle102_zero_flux_trace_boundary` | compiled handoff: zero boundary flux follows from a boundary integral representation plus a.e. zero trace product |
| Zero trace of admissible weak tests on the boundary. | `SALD.generalMovingTargetDiscreteTraceProductZeroOfTestTraceZero`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientTraceBoundaryOfTestTraceZero`; `ASTIS.SALD.forward_KL_discrete.cycle102_test_trace_zero_lower` | compiled handoff: `testTrace phi = 0` a.e. implies the boundary trace product is zero a.e. |
| Boundary trace/decay backend for admissible tests. | `ASTIS.SALD.forward_KL_discrete.cycle102_next_trace_boundary_blocker` | prove `boundaryFlux phi = int_y testTrace phi y * normalFluxTrace y d boundaryMeasure`, then prove `testTrace phi = 0` a.e. by compact support or decay of admissible tests |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 102 trace-boundary handoff | Replace `hzeroBoundary : boundaryFlux phi = 0` by `hboundaryFluxIntegral` and `htraceProductZero`. | cycle-101 product-rule handoff; `MeasureTheory.integral_congr_ae`; Mathlib divergence theorem remains source-cited | `SALD.cycle102DiscreteForwardKlZeroFluxTraceBoundaryMiddleObligation`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientTraceBoundary` | `appendix.tex:1379-1387` | EM backend; both discrete theorem routes | formalized local handoff plus obligation |
| Cycle 102 zero-test-trace lower handoff | Replace `htraceProductZero` by `htestTraceZero : testTrace phi = 0` a.e. on the boundary. | cycle-102 trace-boundary handoff; a.e. monotonicity; scalar product by zero | `SALD.cycle102DiscreteForwardKlTraceZeroLowerObligation`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientTraceBoundaryOfTestTraceZero` | `appendix.tex:1379-1387` | EM backend; both discrete theorem routes | formalized local handoff plus obligation |
| Next trace-boundary blocker | Prove the boundary integral/trace representation and the zero-test-trace fact for admissible weak tests. | `Mathlib.MeasureTheory.Integral.DivergenceTheorem`; boundary trace/decay hypotheses; `appendix.tex:1368-1377` regularity for `barB` | `ASTIS.SALD.forward_KL_discrete.cycle102_next_trace_boundary_blocker` | `appendix.tex:1379-1387` | weak-FP source signs; KL handoff | obligation |

Local SLT consultation: no SLT theorem was imported or needed.  The only local
SLT guidance consulted was the existing audit instruction to expose
measurable/topological/trace hypotheses explicitly; the compiled proof uses
Mathlib `MeasureTheory.integral_congr_ae` and local a.e. monotonicity.

## Cycle 107 Discrete Forward-KL Pressure Sync

Classification: `narrows-source-cited-boundary`.

Cycle 107 repeats the requested closure pressure test for
`thm:forward-KL-discrete`.  The source theorem remains
`main_body.tex:301-323`.  The route through the compiled EM wrappers and the
existing LSI/DV/Gronwall interfaces reaches the active EM backend, not a new
scalar theorem-display boundary:

| Source step | Lean-facing declaration | Remaining obligation |
|---|---|---|
| `main_body.tex:301-323`: discrete forward-KL theorem display with linear slowdown. | Existing dependency route under `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"`; scalar pieces include `SALD.discreteForwardKlPostLsiDerivativeBoundOfLawConstantTestMassScalar`, `SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`, and `SALD.discreteForwardKlMainDisplayBoundScalar`. | no theorem-status promotion; no new route wrapper |
| `appendix.tex:1379-1387`: substitute the weak Fokker-Planck equation with drift source `-div(hatRhoS * barB)`. | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientTraceBoundaryOfTestTraceZero` | exact remaining premise selected for lower: `hboundaryFluxIntegral`; carry `hproductRule`, `hdivergenceTheorem`, `hgradNormBound`, and `htestTraceZero` explicitly |
| `appendix.tex:1368-1377`: `barB` is the frozen conditional drift. | Cycle 106 regularity handoff: `SALD.generalMovingTargetDiscreteCondDistribCanonicalDriftRegularity`; named representative bridge `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfCanonicalAeEq`. | if a downstream named representative is used, the remaining equality is only `hatRhoS`-a.e. equality with the canonical field |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 107 pressure sync | Reject a new theorem-route wrapper; route `thm:forward-KL-discrete` through compiled EM, LSI, DV, Gronwall, and display handoffs. | cycles 101/102/106 dependency registrations; existing scalar wrappers | existing `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` route | `main_body.tex:301-323`; `appendix.tex:260-592` | discrete forward-KL theorem contract | obligation; route synchronized |
| Boundary-flux integral lower packet | Instantiate the Mathlib divergence theorem for the weighted field and identify the resulting signed face integral with the existing `boundaryFlux` trace integral. | `MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable`; face/normal trace setup; regularity of `barB`; admissible-test trace setup | proposed lower target `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfDivergenceTheoremBox`; consumer `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBInnerGradientTraceBoundaryOfTestTraceZero` | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | weak-FP source signs; KL handoff; both discrete theorem routes | obligation; selected next boundary |

Mathlib/API map:

- `MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable` and
  `MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable'` give the
  box divergence theorem as a signed sum of face integrals.
- `MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable_of_equiv`
  is the candidate if the state space is represented through a linear
  equivalence rather than literally `Fin n -> Real`.
- The product-rectangle specializations show how the signed face sum can be
  rewritten into interval integrals in low dimension, but they do not by
  themselves identify the SALD `boundaryFlux` abstraction.

Lower should prove the boundary-flux integral representation, or strictly
narrow it to one Mathlib/local theorem with these hypotheses exposed:
weighted-field continuity on the box, Frechet differentiability away from an
allowed countable set, divergence integrability, signed face-sum to
`boundaryFlux` identification, and normal trace identification.  A packet that
only restates `hboundaryFluxIntegral`, `hzeroBoundary`, `hdivNoBoundary`,
`hgradNormBound`, KL, LSI, DV, Gronwall, or display assumptions is
`rejected-wrapper-churn`.

Local SLT consultation: no SLT theorem was needed or imported.  A targeted
search found no SLT divergence theorem; `SLT/GaussianLSI/TensorizedGLSI.lean`
was only checked for Frechet-derivative idiom.

## Cycle 108 Product-Flux Continuity Slice

Classification: `narrows-source-cited-boundary`.

Cycle 108 stays inside the cycle-107 box-trace instantiation boundary for
`appendix.tex:1379-1387`, with `barB` from `appendix.tex:1368-1377`.  The
non-EM fallback is rejected because the active EM boundary is not blocked by a
named Mathlib gap; the concrete missing theorem is still the `hatRhoS * barB`
trace/divergence instantiation.

| Source step | Lean-facing declaration | Remaining obligation |
|---|---|---|
| `appendix.tex:1368-1377`: `barB` is the conditional drift field. | Cycle 106 regularity handoff remains the named-law source for `barB`; cycle 108 additionally requires a source-facing continuity hypothesis for the selected Euclidean representative. | prove the theorem-specific density and `barB` continuity facts if a lower packet targets regularity instead of trace geometry |
| `appendix.tex:1379-1387`: apply no-boundary divergence theorem to the product flux. | `SALD.generalMovingTargetDiscreteHatRhoBarBWeightedFieldContinuousOnBox`; `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfHatRhoBarBBox` | compiled local handoff discharges the generic weighted-field continuity premise from separate continuity of `hatRhoDensity` and `barB` |
| Remaining box-trace instantiation | `ASTIS.SALD.forward_KL_discrete.cycle108.remaining_hatRho_barB_box_trace_boundary` | Frechet derivative of `x |-> hatRhoDensity x • barB x` off a countable interior set, divergence integrability, `boundaryFlux` equals the interior divergence integral, and signed faces equal the existing `testTrace`/`normalFluxTrace` boundary integral |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 108 product-flux continuity | Prove continuity of `hatRhoDensity • barB` on the Mathlib source box and feed that concrete product flux into the cycle-107 box theorem. | separate density continuity; separate `barB` continuity; `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfDivergenceTheoremBox` | `SALD.cycle108DiscreteForwardKlHatRhoBarBFluxContinuityLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle108.lower_packet.hatRho_barB_flux_continuity` | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | EM backend; both discrete theorem routes | formalized local handoff plus obligation |

Rejected wrapper churn: no wrapper was added around `hboundaryFluxIntegral`,
`hzeroBoundary`, `hdivNoBoundary`, `hgradNormBound`, KL, LSI, DV, Gronwall, or
display matching.  The next lower packet should target one of the remaining
derivative, integrability, boundaryFlux/divergence, or face-trace
identifications for the same concrete product flux.

## Cycle 98 BarB No-Boundary Integral Boundary

Cycle 98 keeps the active backend on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the weak Fokker--Planck source signs at
`appendix.tex:1379-1387`.

Source-to-Lean map:

| Source step | Lean-facing declaration | Remaining obligation |
|---|---|---|
| `appendix.tex:1379-1387`: source sign `-div(hat rho_s * bar b_{k,s})`. | `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryIntegral` | compiled local equality handoff from law-integral pairing plus no-boundary divergence identity to the old `hbarBWeakDivergence` shape |
| Same source line, consumed by the cycle-94 drift-source route. | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBNoBoundaryIntegral` | feeds the integral no-boundary theorem into `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBWeakAction`; no weak-FP status promotion |
| Bounded-pairing integrability discharge. | `SALD.generalMovingTargetDiscreteBarBPairIntegrableOfNormBound`; `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryBoundedPairing`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBBoundedNoBoundaryIntegral` | proves the abstract `hpairIntegrable` input from `Integrable barB hatRhoS`, measurability of the test-gradient contraction, and an a.e. norm bound by `pairBound phi * ||barB||` |
| Lower-ready exact theorem. | `ASTIS.SALD.cycle98.remaining_exact_no_boundary_theorem` | prove the concrete a.e. contraction bound, align `weakGradPairing` with that integral, and prove `driftDiv phi = - integral` by the no-boundary divergence theorem for `hatRhoS * barB` |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 98 middle source map | Keep lower work on the divergence/no-boundary half of `ASTIS.SALD.cycle94.remaining_barB_divergence_boundary`. | cycles 94--97; Mathlib divergence theorem candidate | `SALD.cycle98GeneralMovingTargetDiscreteBarBDivergenceNoBoundaryMiddleObligation`; `ASTIS.SALD.cycle98.middle_barB_divergence_no_boundary_source_map` | `appendix.tex:1379-1387` | EM backend; both discrete theorem routes | obligation |
| Cycle 98 lower packet | Remove primitive `hbarBWeakDivergence` under explicit law-integral and no-boundary hypotheses. | cycle-94 drift-source handoff | `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryIntegral`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBNoBoundaryIntegral`; `ASTIS.SALD.cycle98.lower_packet.barB_no_boundary_integral` | `appendix.tex:1379-1387` | weak-FP source signs; KL handoff; both discrete theorem routes | formalized local handoff plus obligation |
| Cycle 98 lower bounded-pairing discharge | Remove the abstract paired-integrability input under `Integrable barB hatRhoS` and a concrete a.e. norm bound for the weak-test contraction. | cycle-91 `barB` integrability; Mathlib `Integrable.mono'` | `SALD.generalMovingTargetDiscreteBarBPairIntegrableOfNormBound`; `SALD.generalMovingTargetDiscreteBarBWeakDivergenceOfNoBoundaryBoundedPairing`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBBoundedNoBoundaryIntegral` | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | weak-FP source signs; KL handoff; both discrete theorem routes | formalized local theorem; `discharges-supplied-hypothesis` for `hpairIntegrable` |

Classification: `discharges-supplied-hypothesis` for `hpairIntegrable` and
`narrows-source-cited-boundary` for the still-open no-boundary IBP/definition
alignment.  No theorem statement, source label, sign, coefficient, EM/KL
backend status, SLT reuse status, or Lake dependency changed.

## Cycle 99 Raw KL Finite-KL `llr` Boundary

Cycle 99 returns to `appendix.tex:1358-1366` and narrows the remaining raw
KL/log-ratio analytic boundary.  The selected packet is not a new theorem-route
audit and not a wrapper around `hklRaw`: it replaces the primitive scalar raw
KL display with a source-cited finite-KL `llr` differentiability package.

Source-to-Lean map:

| Source step | Lean-facing declaration | Remaining obligation |
|---|---|---|
| `appendix.tex:1358-1366`: differentiate `KL(hat rho_s||tilde pi_s)` at the log-ratio weak test and keep the paper target-time minus term. | `SALD.GeneralMovingTargetDiscreteRawKlDerivativeAtFiniteKlLlr` | source-cited analytic package: density/path regularity, endpoint-safe KL integral differentiation, `llr` weak-action integrability, target-time term integrability/formula, and mapped-law constant-test mass derivative |
| Same source display after using `since int partial_s hat rho_s dx = 0`. | `SALD.GeneralMovingTargetDiscreteRawKlDerivativeNoMassAtFiniteKlLlr`; `SALD.generalMovingTargetDiscreteRawKlDerivativeNoMassAtFiniteKlLlrHkl` | stricter source-cited package: no `massTermDerivative` field remains; the only raw-KL boundary is `dK = partialS (llr hatRho tildePi) - targetTimeTerm` under finite-KL `llr` regularity and target-time hypotheses |
| Mathlib representative of `log(hat rho_s/tilde pi_s)`. | `SALD.generalMovingTargetDiscreteRawKlDerivativeAtFiniteKlLlrHklRaw`; reuses `SALD.generalMovingTargetDiscreteKlLogRatioRegularityOfFiniteKl` | finite KL supplies AC, a.e. measurability, and integrability of `MeasureTheory.llr`; the analytic differentiation fields remain source-cited |
| Handoff from raw KL to the weak-FP action at the exact `llr` test. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfRawKlBoundaryAtFiniteKlLlrWithLogAction`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfNoMassRawKlBoundaryAtFiniteKlLlrWithLogAction` | compiled local composition; the no-mass route proves the constant mapped-law weak-test derivative by `lawMapIntegralHasDerivAtOfSample` and removes the mass-derivative field from the remaining package |
| Lower-ready exact theorem. | `ASTIS.SALD.cycle99.raw_kl_derivative_at_finite_kl_llr` | prove the package fields using Mathlib KL/`llr`, `ParametricIntegral`, Bochner integral APIs, and the mapped-law constant-test derivative; keep cycle-88 admissibility closure and downstream IBP/FI separate |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 99 middle source map | Narrow `hklRaw` to a finite-KL `llr` raw-differentiability theorem with target-time and mass-derivative fields. | cycles 87, 88, and 93 KL/log-ratio handoffs | `SALD.cycle99GeneralMovingTargetDiscreteRawKlDerivativeMiddleObligation`; `ASTIS.SALD.cycle99.middle_raw_kl_derivative_source_map` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | obligation |
| Source-cited analytic package | Prove raw KL differentiability at `MeasureTheory.llr hatRho tildePi` from explicit regularity and parametric-integral hypotheses. | Mathlib `KullbackLeibler.Basic`, `LogLikelihoodRatio`, `ParametricIntegral`, Bochner integrals; `lawMapIntegralHasDerivAtOfSample` | `SALD.GeneralMovingTargetDiscreteRawKlDerivativeAtFiniteKlLlr`; `ASTIS.SALD.cycle99.raw_kl_derivative_at_finite_kl_llr` | `appendix.tex:1358-1366` | KL handoff and downstream derivative route | source-cited |
| No-mass source-cited package | Prove the post-mass-conservation KL derivative display directly at `MeasureTheory.llr hatRho tildePi`. | Mathlib finite-KL `llr` regularity, parametric-integral/Bochner KL differentiation, target-time formula; local mapped-law constant-test derivative handled by the handoff | `SALD.GeneralMovingTargetDiscreteRawKlDerivativeNoMassAtFiniteKlLlr`; `ASTIS.SALD.cycle99.no_mass_raw_kl_derivative_at_finite_kl_llr` | `appendix.tex:1358-1366` | no-mass KL handoff and downstream derivative route | source-cited |
| Cycle 99 lower packet | Compose the package with finite-KL admissibility, mapped-law mass drop, and weak-FP source signs; no-mass variant proves the mapped-law mass derivative internally. | cycle 88 closure; `lawMapIntegralHasDerivAtOfSample` | `SALD.generalMovingTargetDiscreteRawKlDerivativeAtFiniteKlLlrHklRaw`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfRawKlBoundaryAtFiniteKlLlrWithLogAction`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfNoMassRawKlBoundaryAtFiniteKlLlrWithLogAction` | `appendix.tex:1358-1366` | weak-FP-to-`dK`; both discrete theorem routes | formalized local handoff plus obligation |

Classification: `narrows-source-cited-boundary`.  The exact missing theorem is
now further narrowed to
`SALD.GeneralMovingTargetDiscreteRawKlDerivativeNoMassAtFiniteKlLlr`, not a
broad `hklRaw` or a package carrying the mass-derivative field.  No theorem
statement, source label, sign, coefficient,
theorem status, SLT reuse status, or Lake dependency changed.

## Cycle 93 Middle KL/Log-Ratio Mass-Derivative Backfill

Source fragment: `appendix.tex:1358-1366`.

Paper line:

```tex
\frac{\dd}{\dd s}\KL(\hat\rho_s\|\tilde\pi_s)
=
\int \partial_s\hat\rho_s\log\frac{\hat\rho_s}{\tilde\pi_s}\,\dd x
-
\int \frac{\hat\rho_s}{\tilde\pi_s}\partial_s\tilde\pi_s\,\dd x,
```

with the source justification `since \int \partial_s\hat\rho_s\,\dd x=0`.

Lean-facing update:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| Name `hat rho_s = Law(hat X_s)` and isolate the mass term in the raw differentiated KL display. | `SALD.cycle93GeneralMovingTargetDiscreteKlMassDerivativeMiddleObligation`; `ASTIS.SALD.cycle93.middle_kl_mass_derivative_source_map` | obligation; selected boundary |
| Prove the constant weak-test mapped-law derivative is zero once the raw KL backend identifies `massTerm` as that derivative. | `SALD.generalMovingTargetDiscreteKlMassTermZeroOfLawConstantTestDerivative` | formalized local theorem |
| Feed the derived mass drop into the raw KL plus weak-FP source-sign handoff without a primitive `hmass` premise. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfLawConstantTestMassAndSourceSignsWithLogAction`; `SALD.cycle93GeneralMovingTargetDiscreteKlMassDerivativeLowerObligation`; `ASTIS.SALD.cycle93.lower_law_constant_test_mass` | formalized local handoff plus obligation; `discharges-supplied-hypothesis` for `hmass` |
| Specialize the handoff to the Mathlib `llr hatRho tildePi` test, deriving admissibility from finite KL plus the cycle-88 closure package and the mass drop from the mapped-law constant-test derivative. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfFiniteKlLlrLawConstantTestMassWithLogAction`; `ASTIS.SALD.cycle93.lower_finite_kl_llr_law_mass_handoff` | formalized local handoff; `discharges-supplied-hypothesis` for primitive `hlog` and `hmass` in the `llr` route |
| Remaining raw KL and target-time boundary. | `ASTIS.SALD.cycle93.remaining_raw_kl_target_time_boundary` | obligation; prove `hklRaw`, identify `massTerm` with the constant-test derivative, prove target-time derivative formula, and discharge the cycle-88 closure package internals |

Classification: `discharges-supplied-hypothesis` for the local `hmass`
premise and for the primitive `hlog` premise in the exact finite-KL `llr`
route behind
`SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfRawKlAndSourceSignsWithLogAction`;
`narrows-source-cited-boundary` for the remaining
`massTerm`-to-constant-test derivative identification and the cycle-88 closure
package internals.  Raw KL differentiability, target-time derivative
identification, weak FP source signs, integration by parts, FI, LSI, DV,
Gronwall, theorem status, SLT reuse, and Lake dependencies remain unpromoted.

## Cycle 94 Middle Conditional-Drift Weak-Action Backfill

Source fragment: `appendix.tex:1379-1387`, using the conditional drift defined
at `appendix.tex:1368-1377`.

Paper line:

```tex
\partial_s\hat\rho_s
=
-\nabla\cdot(\hat\rho_s\bar b_{k,s})
+
\frac{\sigma_{\eta}^2}{2}\Delta\hat\rho_s.
```

Lean-facing update:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| Replace the primitive `hdriftSource : driftAction phi = -(driftDiv phi)` used by the weak-FP generator/source-sign route. | `SALD.cycle94GeneralMovingTargetDiscreteWeakFpDriftActionMiddleObligation`; `ASTIS.SALD.cycle94.middle_weak_fp_drift_action_source_map` | obligation; selected boundary |
| Name the smaller conditional-drift action boundary: the frozen EM drift generator action is the weak test-gradient pairing against `barB`, and the pairing is the negative drift-divergence action by integration by parts/no-boundary. | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBWeakAction` | formalized local handoff from the two sharper assumptions to the old `hdriftSource` shape |
| Feed the derived drift source into the cycle-92 direct mapped-law derivative route without a primitive `hdriftSource` premise. | `SALD.generalMovingTargetDiscreteWeakConditionalFpLawDerivativeOfSampleSplitGeneratorBarBActionHandoff`; `SALD.cycle94GeneralMovingTargetDiscreteWeakFpDriftActionLowerObligation`; `ASTIS.SALD.cycle94.lower_barB_drift_action_handoff` | formalized local handoff plus obligation; `narrows-source-cited-boundary` for `hdriftSource` |
| Feed the same derived drift source into the normalized weak-FP source-sign route without a primitive `hdriftSource` premise. | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorBarBActionHandoff`; `SALD.cycle94GeneralMovingTargetDiscreteWeakFpDriftActionLowerObligation`; `ASTIS.SALD.cycle94.lower_barB_drift_action_handoff` | formalized local handoff plus obligation; `narrows-source-cited-boundary` for `hdriftSource` |
| Remaining `barB` divergence boundary. | `ASTIS.SALD.cycle94.remaining_barB_divergence_boundary`; `Mathlib.MeasureTheory.Integral.DivergenceTheorem` | obligation; prove the conditional-expectation generator action and the no-boundary divergence/integration-by-parts theorem for `hatRhoS * barB` |

Classification: `narrows-source-cited-boundary`.  The old supplied
`hdriftSource` premise is no longer primitive in the new direct law-derivative
route or in the normalized weak-FP source-sign route; it is factored into two
exact source-cited facts tied to `barB`.
Conditional-expectation generator action, divergence/no-boundary integration
by parts, diffusion source action, sample-path generator differentiation,
density/time regularity, admissible-test closure, weak FP theorem, KL
derivative, theorem status, SLT reuse, and Lake dependencies remain
unpromoted.

## Cycle 95 Discrete Forward-KL Pressure Test

Global phase judgment: cycle 94 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The single lower packet that now reduces the largest proof risk is
the active EM backend
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the `barB` conditional-expectation
generator pairing and divergence/no-boundary theorem at
`appendix.tex:1368-1387`.

Pressure-test route for `thm:forward-KL-discrete`:

| Source step | Lean-facing route | Current status |
|---|---|---|
| `main_body.tex:299-323`: theorem display. | `SALD.discreteForwardKlStatementContract`; `SALD.discreteForwardKlMainDisplayBoundScalar`; `SALD.cycle95DiscreteForwardKlClosurePressureUpperObligation`; `SALD.cycle95DiscreteForwardKlClosurePressureMiddleObligation`; `SALD.cycle95DiscreteForwardKlClosurePressureLowerObligation` | contract-only theorem; scalar display wrappers already compiled under named analytic inputs |
| `appendix.tex:1358-1387`: shared EM weak-FP/KL backend. | `sald.general_moving_target_discrete.em_interpolation_fp`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorBarBActionHandoff`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfFiniteKlLlrLawConstantTestMassWithLogAction` | active source-cited backend; not formalized |
| `appendix.tex:1368-1377`: conditional drift definition. | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftActionOfBarBComponentPairings`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBComponentPairings`; `ASTIS.SALD.forward_KL_discrete.cycle95_lower_barB_component_pairing` | lower compiled local reduction: direct `barB` action is reduced to component conditional-expectation pairings for `condC`/`condScore` plus weak-pairing linearity/congruence |
| `appendix.tex:1379-1387`: Fokker--Planck source signs. | `ASTIS.SALD.cycle94.remaining_barB_divergence_boundary`; `Mathlib.MeasureTheory.Integral.DivergenceTheorem` | next lower packet: prove weak divergence/no-boundary identity for `hatRhoS * barB`, or isolate the exact theorem |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 95 global judgment | No recovery; Phase 1 stable; select the shared `barB` weak-action backend. | cycle 94 lower; active EM backend | `ASTIS.SALD.cycle95.global_phase_judgment` | `main_body.tex:299-323`; `appendix.tex:1358-1387` | both discrete theorem routes | obligation |
| Discrete theorem pressure route | Existing wrappers route forward-KL-discrete through EM, KL/log-ratio mass, LSI, DV, Gronwall, and accumulated-error inputs; the first non-wrapper blocker is upstream in weak-FP source signs. | cycles 89-94; LSI/DV/Gronwall wrappers | `ASTIS.SALD.forward_KL_discrete.cycle95_pressure_route` | `main_body.tex:299-323`; `appendix.tex:260-592`; `appendix.tex:1358-1387` | `thm:forward-KL-discrete` | obligation |
| Middle route audit | Synchronize the pressure-test result and lower-ready blocker without adding a new wrapper around KL, LSI, DV, Gronwall, source signs, or display algebra. | cycle 95 upper route; cycle 94 barB handoff; cycle 93 KL mass/log-ratio handoff | `SALD.cycle95DiscreteForwardKlClosurePressureMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle95_middle_route_audit` | `main_body.tex:299-323`; `appendix.tex:1368-1387` | `thm:forward-KL-discrete`; shared EM backend | obligation |
| Lower component-pairing reduction | Replace the direct supplied `driftAction phi = weakGradPairing barB phi` boundary by component pairings for `condC` and `condScore` plus weak-pairing additivity, scalar linearity, and congruence under the source `barB` component formula. | cycle 91 named conditional drift; cycle 94 barB handoff | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftActionOfBarBComponentPairings`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBComponentPairings`; `ASTIS.SALD.forward_KL_discrete.cycle95_lower_barB_component_pairing` | `appendix.tex:1368-1377`; `appendix.tex:1379-1387` | weak-FP backend and both discrete theorem routes | formalized local theorem plus obligation |
| Next blocker | Component conditional-expectation generator pairings for `condC`/`condScore`, plus divergence/no-boundary theorem for `hatRhoS * barB`. | `CondDistrib`; `Condexp`; divergence theorem; boundary hypotheses | `ASTIS.SALD.forward_KL_discrete.cycle95_next_blocker`; `ASTIS.SALD.cycle94.remaining_barB_divergence_boundary` | `appendix.tex:1368-1387` | weak-FP backend and both discrete theorem routes | obligation |

Classification: `narrows-source-cited-boundary`.  No theorem statement,
source label, sign, coefficient, backend status, SLT reuse status, or Lake
dependency changed.

## Cycle 96 Condexp Generator-Pairing Middle Packet

Upper cycle 96 rejects the non-EM backend fallback because the EM conditional
law / weak-FP interface still has named blockers.  Middle therefore keeps the
conversion window on `appendix.tex:1358-1387`, with the lower-ready source
slice at `appendix.tex:1368-1377`.

| Source step | Lean-facing route | Current status |
|---|---|---|
| `appendix.tex:1368-1377`: `bar b_{k,s}` is the conditional expectation of the frozen guide and score summands given `hat X_s=x`. | `SALD.cycle96GeneralMovingTargetDiscreteCondexpGeneratorPairingMiddleObligation`; `ASTIS.SALD.cycle96.middle_condexp_generator_pairing_boundary`; Mathlib `Probability.Kernel.CondDistrib` / `Condexp`; local `AutoSamplingTheory.condDistribIntegralNamedFieldRegularity` and sample-version helpers | obligation; lower should prove one component generator weak-action pairing for `condC` or `condScore`, or isolate one smaller Mathlib theorem |
| `appendix.tex:1379-1387`: weak-FP source signs use `barB`. | `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftActionOfBarBComponentPairings`; `SALD.generalMovingTargetDiscreteWeakConditionalFpDriftSourceOfBarBComponentPairings` | cycle-95 local algebra already reduces `barB` action to component pairings; divergence/no-boundary remains separate |
| Cycle-focus fallback guard | `ASTIS.SALD.cycle96.middle_non_em_fallback_rejected`; `ASTIS.SALD.cycle96.lower_packet.condexp_component_generator_pairing` | no LSI/DV/Gronwall fallback this cycle; classification is `narrows-source-cited-boundary` unless lower proves a component pairing and removes that supplied premise |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Fallback rejected | EM remains active because named conditional-law and divergence/no-boundary blockers remain. | cycle 95 next blocker; cycle 94 `barB` boundary | `ASTIS.SALD.cycle96.middle_non_em_fallback_rejected` | `appendix.tex:1358-1387` | both discrete theorem routes | obligation |
| Condexp component generator boundary | Prove one `condC`/`condScore` generator weak-action pairing from `condDistrib`/`condexp`, named `hatRhoS`, and local component conditional-integral regularity/versioning helpers. | `CondDistrib`; `Condexp`; cycle-91 named-field helpers; cycle-95 barB component theorem | `SALD.cycle96GeneralMovingTargetDiscreteCondexpGeneratorPairingMiddleObligation`; `ASTIS.SALD.cycle96.middle_condexp_generator_pairing_boundary` | `appendix.tex:1368-1377` | weak-FP source signs; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation |
| Lower packet classification | Prove and remove one component-pairing premise, or record one smaller missing Mathlib theorem with imports and hypotheses. | cycle 95 lower; Mathlib conditional kernel APIs | `ASTIS.SALD.cycle96.lower_packet.condexp_component_generator_pairing` | `appendix.tex:1368-1377` | cycle 96 lower/reviewer | obligation |

## Cycle 97 Middle Canonical CondDistrib Disintegration Pairing

Global judgment: cycle 96 passed reviewer/build and needs no recovery.  Phase
1 theorem-skeleton translation is stable enough for cited-theory backfill.
The single lower packet that best reduces the remaining proof risk is the
canonical `condDistrib` component-action theorem behind
`appendix.tex:1368-1377`, before the separate divergence/no-boundary theorem.

Source fragment: `appendix.tex:1368-1377` defines
`\bar b_{k,s}(x)` as the conditional expectation of the frozen guide and score
summands given `\hat X_s=x`.

| Source step | Lean-facing route | Current status |
|---|---|---|
| `hatRhoS = Law(hat X_s)` and conditioning `X_k^eta | hat X_s=x`. | `AutoSamplingTheory.condDistribIntegralMapIntegral`; `AutoSamplingTheory.condDistribIntegralNamedLawIntegral`; `ProbabilityTheory.compProd_map_condDistrib`; `MeasureTheory.Measure.integral_compProd` | formalized local theorem for the map-law disintegration integral |
| Canonical component weak action for `condC` or `condScore`. | `SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfIntegralAction`; `SALD.cycle97GeneralMovingTargetDiscreteCanonicalCondDistribPairingLowerObligation`; `ASTIS.SALD.cycle97.lower_packet.canonical_condDistrib_component_pairing` | formalized local handoff: instantiate the disintegration theorem with the weak test-gradient paired component integrand, remove raw `hcanonical`, and leave paired-integrand integrability plus the two definition-alignment equalities explicit |
| Cycle-focus wrapper guard. | `ASTIS.SALD.cycle97.rejected_wrapper_churn_guard` | reject wrappers that only rename `hcanonical`, `hdriftSource`, source signs, KL, LSI, DV, Gronwall, or display algebra |

Classification: `discharges-supplied-hypothesis` for the map-law
disintegration part of the cycle-96 `hcanonical` boundary, and
`narrows-source-cited-boundary` for the lower theorem.  The remaining exact
boundary is no longer raw `hcanonical`: expand `componentAction` and
`weakGradPairing` to the paired Bochner integrals, establish integrability of
that paired test-gradient component under the joint law
`P.map (fun omega => (hatX_s omega, X_k^eta omega))`, and prove the
component-field a.e. version and weak-pairing a.e. congruence hypotheses.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 97 global judgment | No recovery; keep the backend on EM conditional-law/Fokker-Planck and select the canonical `condDistrib` disintegration pairing. | cycle 96 lower; cycle 95 next blocker | `ASTIS.SALD.cycle97.global_phase_judgment` | `appendix.tex:1358-1387`, especially `1368-1377` | both discrete theorem routes | obligation |
| Compiled disintegration theorem | Integral through `condDistrib` equals the sample-law integral for an integrable paired component test, with named `hatRhoS=Law(hatX_s)` variant. | `ProbabilityTheory.compProd_map_condDistrib`; `MeasureTheory.Measure.integral_compProd`; `MeasureTheory.integral_map` | `AutoSamplingTheory.condDistribIntegralMapIntegral`; `AutoSamplingTheory.condDistribIntegralNamedLawIntegral`; `ASTIS.SALD.cycle97.compiled_condDistrib_disintegration_pairing` | `appendix.tex:1368-1377`; Mathlib `CondDistrib.lean` | cycle-96 `hcanonical`; both discrete theorem routes | formalized |
| Compiled lower component pairing handoff | Instantiate the compiled theorem with the weak test-gradient pairing against one frozen component, then feed the cycle-96 a.e.-version handoff. | cycle 96 a.e. field-version handoff; component weak-pairing route | `SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfIntegralAction`; `ASTIS.SALD.cycle97.lower_packet.canonical_condDistrib_component_pairing` | `appendix.tex:1368-1377` | weak-FP drift source; both discrete theorem routes | formalized |
| Wrapper-churn guard | Reject new wrappers around already named supplied hypotheses unless they use the compiled disintegration theorem or isolate an exact missing theorem. | cycles 94-96 EM blockers | `ASTIS.SALD.cycle97.rejected_wrapper_churn_guard` | `appendix.tex:1368-1387` | cycle 97 reviewer | obligation |

## Cycle 87 Middle/Lower KL Log-Ratio Boundary

Source fragment: `appendix.tex:1358-1366`.

```tex
\frac{\dd}{\dd s}\KL(\hat\rho_s\|\tilde\pi_s)
=
\int \partial_s\hat\rho_s\log\frac{\hat\rho_s}{\tilde\pi_s}\,\dd x
-
\int \frac{\hat\rho_s}{\tilde\pi_s}\partial_s\tilde\pi_s\,\dd x,
```

The paper justifies the missing raw mass term by
`\int \partial_s\hat\rho_s\,dx=0`.

Lean-facing split:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| Raw KL differentiation before the mass drop: `dK = partialS(logRatioTest) + massTerm - targetTimeTerm`. | `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryMiddleObligation`; `ASTIS.SALD.cycle87.middle_kl_log_ratio_source_map` | obligation; narrows-source-cited-boundary |
| Mass conservation: `massTerm=0`, corresponding to `\int \partial_s\hat\rho_s dx=0`. | `SALD.generalMovingTargetDiscreteKlDerivativeMassConservationDropScalar` | formalized local Real equality after the analytic identity is supplied |
| Handoff from raw KL display plus weak-FP source signs to the source-signed `dK` display. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfRawKlAndSourceSignsWithLogAction`; `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryLowerObligation`; `ASTIS.SALD.cycle87.lower_kl_mass_conservation_handoff` | formalized local scalar/equality wrapper plus obligation |
| Log-ratio as Mathlib weak test: `llr hatRho tildePi = log ((d hatRho / d tildePi).toReal)` and finite KL implies `hatRho << tildePi`, a.e. strong measurability, and integrability under `hatRho`. | `SALD.generalMovingTargetDiscreteKlLogRatioLlrDef`; `SALD.generalMovingTargetDiscreteKlLogRatioRegularityOfFiniteKl`; `ASTIS.SALD.cycle87.lower_kl_log_ratio_regularity` | formalized local Mathlib-backed regularity from finite KL; discharges separate log-ratio AC/measurability/integrability hypotheses |
| Log-ratio weak-test admissibility beyond measure/integrability: smooth/Sobolev approximation, boundary behavior, and validity for the weak-FP test class. | `ASTIS.SALD.cycle87.lower_packet.kl_log_ratio_boundary`; `sald.general_moving_target_discrete.kl_derivative` | remaining analytic boundary |
| Target-time term integrability and differentiability under the KL integral. | `sald.general_moving_target_discrete.kl_derivative` | remaining analytic boundary |

Classification: `discharges-supplied-hypothesis` for log-ratio
absolute-continuity/measurability/integrability under finite KL, plus
`narrows-source-cited-boundary` for the raw KL/mass split.  The cycle
formalizes the mass-conservation equality bookkeeping and replaces the old
supplied post-mass-drop `hkl` display with the smaller raw KL derivative plus
`massTerm=0` boundary.  It does not prove KL differentiability, mass
conservation, weak-test admissibility of the log-ratio, weak FP, integration
by parts, FI identification, LSI/KL/FI, DV, Gronwall, theorem closure, SLT
reuse, or any Lake dependency.

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 87 middle source map | Split `eq:general_KL_derivative_0_discrete` into raw KL differentiation, explicit mass conservation, target-time derivative integrability, and log-ratio regularity before weak-FP source signs are used. | cycle-86 generator-to-law narrowing; cycle-83/cycle-84 source-sign-to-KL wrappers | `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryMiddleObligation`; `ASTIS.SALD.cycle87.middle_kl_log_ratio_source_map` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | obligation |
| Cycle 87 lower mass handoff | Drop the explicit mass term and route the raw display through the existing log-action weak-FP handoff. | raw KL display; `massTerm=0`; admissible log-ratio test; normalized weak-FP source signs | `SALD.generalMovingTargetDiscreteKlDerivativeMassConservationDropScalar`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfRawKlAndSourceSignsWithLogAction`; `SALD.cycle87GeneralMovingTargetDiscreteKlLogRatioBoundaryLowerObligation`; `ASTIS.SALD.cycle87.lower_kl_mass_conservation_handoff` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | formalized local wrapper plus obligation |
| Cycle 87 lower log-ratio regularity | Use Mathlib `llr` as the zero-set convention for `log(hat rho_s/tilde pi_s)` and derive absolute continuity, a.e. strong measurability, and integrability from finite KL. | finite `klDiv hatRho tildePi`; Mathlib `klDiv_ne_top_iff`, `stronglyMeasurable_llr`, `llr_def` | `SALD.generalMovingTargetDiscreteKlLogRatioLlrDef`; `SALD.generalMovingTargetDiscreteKlLogRatioRegularityOfFiniteKl`; `ASTIS.SALD.cycle87.lower_kl_log_ratio_regularity` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | formalized local Mathlib-backed regularity |

## Cycle 88 Middle Log-Ratio Admissibility Boundary

Source fragment: `appendix.tex:1358-1366`, continuing the same
`eq:general_KL_derivative_0_discrete` KL derivative step.

Cycle 87 already makes the paper's
`log(hat rho_s / tilde pi_s)` test concrete as Mathlib
`llr hatRhoS tildePiS` and derives absolute continuity,
a.e. strong measurability, and integrability from finite KL.  The remaining
supplied hypothesis selected in cycle 88 is narrower: the weak-FP handoff still
assumes `hlog : Admissible logRatioTest`.

Lean-facing split:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| Use the finite-KL `llr` representative as the only log-ratio test candidate; do not reintroduce separate AC/measurability/integrability hypotheses. | `SALD.generalMovingTargetDiscreteKlLogRatioLlrDef`; `SALD.generalMovingTargetDiscreteKlLogRatioRegularityOfFiniteKl` | formalized local Mathlib-backed regularity from cycle 87 |
| Replace the broad supplied `hlog : Admissible logRatioTest` input by a smaller admissibility theorem for `llr hatRhoS tildePiS`. | `SALD.cycle88GeneralMovingTargetDiscreteKlLogRatioAdmissibilityMiddlePacket`; `SALD.cycle88GeneralMovingTargetDiscreteKlLogRatioAdmissibilityMiddleObligation`; `ASTIS.SALD.cycle88.middle_log_ratio_admissibility_boundary` | obligation; `narrows-source-cited-boundary` |
| Lower finite-KL-to-admissible-`llr` handoff: finite KL supplies the measure-regularity inputs, then a named closure package supplies density/time regularity, zero-set convention, smoothing/Sobolev approximation, boundary/no-flux, drift-divergence action closure, Laplacian action closure, and target-time integrability. | `SALD.GeneralMovingTargetDiscreteKlLogRatioAdmissibilityClosure`; `SALD.generalMovingTargetDiscreteKlLogRatioAdmissibleOfFiniteKlClosure`; `SALD.cycle88GeneralMovingTargetDiscreteKlLogRatioAdmissibilityLowerObligation`; `ASTIS.SALD.cycle88.lower_packet.log_ratio_admissibility` | compiled local handoff; `narrows-source-cited-boundary`; replaces opaque `hlog` shape with the smaller closure theorem boundary |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 88 middle source map | Narrow the log-ratio weak-test supplied hypothesis after cycle 87 finite-KL regularity. | cycle-87 raw-KL/mass split; finite-KL `llr` regularity; cycle-83/cycle-84 weak-FP-to-KL handoffs | `SALD.cycle88GeneralMovingTargetDiscreteKlLogRatioAdmissibilityMiddleObligation`; `ASTIS.SALD.cycle88.middle_log_ratio_admissibility_boundary` | `appendix.tex:1358-1366` | `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | obligation |
| Cycle 88 lower packet | Compile the finite-KL-to-admissible-`llr` handoff and isolate the remaining approximation/closure theorem. | finite KL; `SALD.generalMovingTargetDiscreteKlLogRatioRegularityOfFiniteKl`; density/time regularity; zero-set convention; boundary/no-flux; weak-FP action closure | `SALD.GeneralMovingTargetDiscreteKlLogRatioAdmissibilityClosure`; `SALD.generalMovingTargetDiscreteKlLogRatioAdmissibleOfFiniteKlClosure`; `SALD.cycle88GeneralMovingTargetDiscreteKlLogRatioAdmissibilityLowerObligation`; `ASTIS.SALD.cycle88.lower_packet.log_ratio_admissibility` | `appendix.tex:1358-1366` | weak-FP action to `dK`; integration by parts; FI identification | formalized local handoff plus obligation; `narrows-source-cited-boundary` |

Mode discipline: no theorem statement, source label, coefficient, theorem
status, SLT reuse status, or analytic backend status changed.  Raw KL
differentiability, mass conservation, target-time integrability, weak FP,
integration by parts, and FI identification remain separate blockers.

## Cycle 89 Discrete Forward-KL Pressure Test

Global phase judgment: cycle 88 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill. The active shared backend still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; the pressure test routes
`thm:forward-KL-discrete` through the current EM/KL wrappers and existing LSI,
DV, Gronwall, and accumulated-error interfaces, and the next non-wrapper
blocker is the derivative/integration-by-parts/FI boundary in
`SALD.discreteForwardKlDerivativeObligation` /
`sald.discrete_forward_kl.kl_derivative` at `appendix.tex:388-413`.

Pressure-test route:

| Source step | Lean-facing route | Status |
|---|---|---|
| `main_body.tex:299-323` theorem display | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract` | `contractOnly`; unchanged |
| EM/KL inputs from the shared backend | cycles 85--88 handoffs, especially `SALD.generalMovingTargetDiscreteKlLogRatioAdmissibleOfFiniteKlClosure` and `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfRawKlAndSourceSignsWithLogAction` | compiled local handoffs plus obligations; backend unpromoted |
| Middle source-map audit | `SALD.cycle89DiscreteForwardKlClosurePressureMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle89_middle_route_audit` | obligation; records the pressure-test route and selected lower packet without adding a theorem wrapper |
| `appendix.tex:388-413`: weak-FP log-ratio action to `-FI` plus frozen cross term | `SALD.discreteForwardKlDerivativeObligation`; `sald.discrete_forward_kl.kl_derivative` | next blocker; `narrows-source-cited-boundary` |
| `appendix.tex:414-436`: target transport action | `SALD.discreteForwardKlDerivativeObligation`; continuous target-transport side conditions | same blocker family |
| Cycle 89 lower raw-derivative split | `SALD.discreteForwardKlDerivativeSplitOfRawIbpsScalar`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfRawIbpsScalar`; `SALD.cycle89DiscreteForwardKlClosurePressureLowerObligation` | compiled scalar handoff plus obligation; replaces opaque post-IBP `hderiv` with raw KL, mass, first-term IBP/FI, and target-transport IBP inputs |
| `appendix.tex:454-491`: scalar derivative to pre-DV inequality once analytic inputs are supplied | `SALD.cycle51DiscreteForwardKlDerivativeLowerObligation`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfKlFiScalar` | compiled scalar wrapper plus obligation |
| `appendix.tex:493-592`; `main_body.tex:309-323` | `sald.discrete_forward_kl.dv_velocity_bound`; `SALD.cycle56DiscreteForwardKlGronwallLowerObligation`; cycle-61/cycle-66 accumulated display wrappers | existing route under supplied analytic inputs |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 89 global judgment | No recovery; Phase 1 stable; pressure test selects the discrete derivative/IBP/FI blocker. | cycle-88 lower; cycle-66 discrete route | `SALD.cycle89DiscreteForwardKlClosurePressureUpperPacket`; `ASTIS.SALD.cycle89.global_phase_judgment` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete` | obligation |
| Active EM backend check | Keep the shared packet on `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`; the pressure test only locates the downstream discrete blocker. | cycle-88 finite-KL-to-admissible-`llr`; cycle-87 raw-KL/mass split | `ASTIS.SALD.cycle89.active_em_backend_check` | `appendix.tex:1358-1387` | both discrete theorem routes | obligation |
| Discrete theorem pressure route | Route through current EM/KL handoffs, LSI, DV, Gronwall, and accumulated-error wrappers; stop before analytic derivative action. | cycles 51/56/61/66; cycles 85--88 | `SALD.cycle89DiscreteForwardKlClosurePressureUpperObligation`; `ASTIS.SALD.forward_KL_discrete.cycle89_pressure_route` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete` | obligation |
| Cycle 89 middle route audit | Synchronize the pressure-test route into the theorem DAG and lower packet: existing scalar route interfaces are sufficient once the analytic derivative action is supplied, so lower should not add wrapper churn. | cycle-89 upper pressure packet; cycles 51/56/61/66; cycles 85--88 | `SALD.cycle89DiscreteForwardKlClosurePressureMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle89_middle_route_audit` | `appendix.tex:388-413`; `appendix.tex:414-436` | `sald.discrete_forward_kl.kl_derivative`; `thm:forward-KL-discrete` | obligation; `narrows-source-cited-boundary` |
| Next blocker | Integration by parts and Fisher identification for `eq:KL-derivative-1-discrete`, plus target-transport integration by parts. | weak-FP log-ratio action; target-time term; log-ratio admissibility; density/boundary hypotheses | `SALD.discreteForwardKlDerivativeObligation`; `sald.discrete_forward_kl.kl_derivative`; `ASTIS.SALD.forward_KL_discrete.cycle89_next_blocker` | `appendix.tex:388-413`; `appendix.tex:414-436` | derivative-to-DV handoff; theorem route | obligation |
| Cycle 89 lower derivative split | Replace the opaque derivative display used by the scalar route with the raw KL split plus explicit mass-conservation, first-term IBP/FI, and target-transport IBP inputs. | cycle-89 middle audit; cycle-51 post-LSI scalar route; cycle-88 log-ratio admissibility handoff | `SALD.discreteForwardKlDerivativeSplitOfRawIbpsScalar`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfRawIbpsScalar`; `ASTIS.SALD.forward_KL_discrete.cycle89_lower_derivative_ibp_split` | `appendix.tex:388-436` | `sald.discrete_forward_kl.kl_derivative`; `thm:forward-KL-discrete` | compiled scalar handoff plus obligation; `narrows-source-cited-boundary` |

Selected lower packet: `narrows-source-cited-boundary`. Lower should prove or
isolate exactly one theorem boundary inside
`SALD.discreteForwardKlDerivativeObligation`: divergence integration by parts
for the log-ratio test, target-transport integration by parts, or
Fisher-information identification of the first term. Cycle 89 lower narrowed
that boundary by compiling `SALD.discreteForwardKlDerivativeSplitOfRawIbpsScalar`
and `SALD.discreteForwardKlPostLsiDerivativeBoundOfRawIbpsScalar`, so the next
packet should prove or isolate one of the three remaining analytic inputs
(`hmass`, `hfirst`, or `htarget`) rather than reintroducing an opaque
post-IBP derivative hypothesis.

No theorem statement, source label, coefficient, theorem status, SLT reuse
status, Lake dependency, or analytic backend status changed.

## Cycle 90 Middle Mass-Derivative Route

Middle translated the source sentence "since
`\int \partial_s \hat\rho_s dx = 0`" in
`eq:KL-derivative-0-discrete` into a smaller Lean-facing boundary.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:338-388`: the raw KL derivative contains a mass term, then the paper drops it by mass conservation of the EM interpolation law. | `SALD.discreteForwardKlMassTermZeroOfTotalMassDerivative` | formalized local `HasDerivAt` calculus lemma: if `massTerm` is the derivative of a locally constant total-mass function, then `massTerm=0` |
| Feed that derived mass equality into the cycle-89 raw derivative split instead of taking `hmass` as primitive. | `SALD.discreteForwardKlDerivativeSplitOfMassDerivativeScalar`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfMassDerivativeScalar` | compiled scalar handoff; `discharges-supplied-hypothesis` for the scalar `hmass` input |
| Specialize the total-mass pairing to the mapped law `\hat\rho_s=Law(\hat X_s)` and the constant weak test `1`. | `SALD.discreteForwardKlLawConstantTestTotalMassOne`; `SALD.discreteForwardKlLawConstantTestHasDerivAtZero`; `SALD.discreteForwardKlMassTermZeroOfLawConstantTestDerivative` | compiled local Mathlib/Measure.map handoff: mapped probability-law mass is one, and the concrete constant-test law pairing has derivative zero |
| Feed the concrete mapped-law mass drop into the cycle-89 raw derivative split. | `SALD.discreteForwardKlDerivativeSplitOfLawConstantTestMassScalar`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfLawConstantTestMassScalar`; `SALD.cycle90DiscreteForwardKlMassConservationLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle90_lower_law_constant_test_mass` | compiled scalar handoff; remaining boundary is identifying the paper `massTerm` with the derivative of this concrete constant-test pairing |
| Remaining analytic boundary for lower/reviewer. | `SALD.cycle90DiscreteForwardKlMassConservationMiddleObligation`; `SALD.cycle90DiscreteForwardKlMassConservationLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle90_middle_mass_derivative_route` | obligation: identify `massTerm` as the derivative of the total-mass pairing for `\hat\rho_s=Law(\hat X_s)` using derivative-under-integral/constant weak-test semantics |

The active EM backend remains
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; this middle route only addresses the reviewed
theorem-route exception from cycle 89.  It does not prove KL differentiability,
weak Fokker--Planck, density-to-law mass preservation, integration by parts,
FI identification, LSI/KL/FI, DV, Gronwall, or theorem closure.

Cycle 90 lower removes the abstract local-normalization side condition from the
mass route: the concrete mapped-law constant-test derivative is zero once
`P` is a probability measure and `hatX s` is a.e. measurable.  The remaining
source-cited theorem is not another scalar `hmass`; it is the raw KL
differentiability/density theorem identifying `massTerm` with the derivative of
`s ↦ ∫ 1 d(Measure.map (hatX s) P)`.

## Cycle 91 Middle Conditional-Kernel Named-Drift Backfill

Cycle 91 returns from the cycle-90 theorem-route exception to the active EM
backend `sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the conditional-kernel definition at
`appendix.tex:1368-1377`.  Packet classification:
`discharges-supplied-hypothesis`.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1368-1377`: name `hat rho_s=Law(hat X_s)` and define `bar b_{k,s}` as the conditional expectation of the frozen guide and score summands given `hat X_s=x`. | `SALD.generalMovingTargetDiscreteCondDistribNamedFieldAeEqOfSample`; `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfSampleVersions`; `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularity` | formalized local theorem: from `hatRhoS = Measure.map hatXAtS P`, sample-space component version equalities after composing with `hatXAtS`, measurable equality sets, canonical `condDistrib X_k^eta hat X_s P` component integrals, and the pointwise `barB` formula, derive `AEStronglyMeasurable barB hatRhoS` and `Integrable barB hatRhoS` |
| Cycle 91 ledger | `SALD.cycle91GeneralMovingTargetDiscreteConditionalKernelMiddleObligation`; `SALD.cycle91GeneralMovingTargetDiscreteConditionalKernelLowerObligation`; `ASTIS.SALD.cycle91.lower_condDistrib_named_drift_regular` | obligation plus compiled theorem; no weak-Fokker--Planck, KL derivative, theorem-status, SLT, or Lake promotion |

The supplied law-space component-version and component-field/barB regularity
hypotheses behind
`SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfSwappedComponents`
and `SALD.generalMovingTargetDiscreteEndpointConditionalDriftRegularityHandoff`
are no longer the blocker once the sample-space component versions are tied to
the canonical Mathlib conditional integrals and transported through
`hatRhoS = Law(hatXAtS)` by `MeasureTheory.ae_map_iff`.

Remaining exact boundary: prove the SALD-specific sample-space
conditional-expectation/disintegration equalities for `condC_{k,s}` and
`condScore_{k,s}` after composing with `hatXAtS`, prove the measurable
equality-set side conditions needed by `ae_map_iff`, and prove the
conditional-kernel compatibility theorem.

## Cycle 92 Middle/Lower Split-Generator Backfill

Cycle 92 keeps the active EM backend on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the generator-to-law weak
Fokker--Planck invocation at `appendix.tex:1379-1387`.  Packet
classification: `discharges-supplied-hypothesis`.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1379-1387`: before identifying drift and diffusion source actions, the frozen EM weak generator is the sum of its drift and diffusion actions. | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorHandoff` | formalized local theorem: removes the explicit `hgeneratorSplit` input by making `generatorAction phi` definitionally `driftAction phi + diffusionAction phi` |
| `appendix.tex:1379-1387`: transport the split-generator sample derivative to the weak-test law derivative and preserve the source signs. | `SALD.generalMovingTargetDiscreteWeakConditionalFpLawDerivativeOfSampleSplitGeneratorHandoff` | formalized local theorem: removes the separate `hlawDerivative` premise for the direct `HasDerivAt` weak-FP route by using `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample` |
| Cycle 92 ledger | `SALD.cycle92GeneralMovingTargetDiscreteWeakFpGeneratorSplitMiddleObligation`; `SALD.cycle92GeneralMovingTargetDiscreteWeakFpGeneratorSplitLowerObligation`; `ASTIS.SALD.cycle92.lower_sample_split_generator_handoff`; `ASTIS.SALD.cycle92.lower_law_derivative_of_sample_split_generator` | obligation plus compiled theorems; no weak-Fokker--Planck, KL derivative, theorem-status, SLT, or Lake promotion |

The theorem reuses the cycle-86 sample-space derivative to mapped-law weak
derivative transport, so `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`
still performs the `Measure.map` handoff.  The direct weak-test derivative
route now has a compiled handoff whose conclusion is a `HasDerivAt` statement
with derivative value
`-(driftDiv phi) + (sigma_eta^2/2) • laplacian phi`, so it no longer needs a
separate `hlawDerivative` witness.  Remaining exact boundary:
sample-path/Bochner parametric-integral differentiation of the split generator
sum, drift source-action identification through `bar b_{k,s}`, diffusion
source-action identification with coefficient `sigma_eta^2/2`, density/time
regularity, admissible-test closure, and boundary hypotheses.

## Cycle 86 Lower Generator-To-Law Handoff

Lower kept the active packet on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1379-1387` and compiled a local theorem that removes the older
abstract generator/time-derivative equality from the weak-FP source-sign route.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1379-1387`: associated Fokker--Planck equation for `hat rho_s=Law(hat X_s)` before source-sign rewriting. | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleGeneratorPiecesHandoff` | formalized local handoff under explicit `HasDerivAt` and source-action hypotheses |
| Register the lower boundary and keep the EM backend below theorem closure. | `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryLowerObligation`; `ASTIS.SALD.cycle86.lower_packet.weak_fp_generator_to_law_boundary` | obligation plus compiled local theorem |

The theorem derives `partialS phi = generatorAction phi` for admissible tests
from a supplied sample-space generator derivative, the existing
`AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample` transport to the
`Measure.map` law integral, a supplied weak-law derivative witness for
`partialS phi`, and uniqueness of `HasDerivAt`.  It then calls
`SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`
to preserve the source signs `-div(hat rho_s*bar b_{k,s})` and
`+(sigma_eta^2/2) Delta hat rho_s`.

Classification: `narrows-source-cited-boundary`.  The old coarse
`hgenerator` hypothesis is removed from this local route, while the remaining
analytic theorem boundaries are sample-path/parametric-integral generator
differentiation, weak law derivative existence for admissible tests, drift
source-action identification via the conditional field, diffusion source-action
identification with coefficient `sigma_eta^2/2`, density/time regularity,
admissible-test, and boundary hypotheses.  No weak-FP, KL derivative, theorem,
SLT, or Lake status is promoted.

## Cycle 85 Middle Conditional-Kernel Boundary Narrowing

Middle kept the active packet on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to `appendix.tex:1368-1377`, and compiled
the first local Mathlib-backed conditional-kernel helpers.  Packet
classification: `narrows-source-cited-boundary`.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1368-1377`: orient `X_k^eta | hat X_s=x` against Mathlib kernels. | `AutoSamplingTheory.condDistribAeEqCondExpKernelMap` | formalized local helper; `condDistrib X_k^eta hatX_s mu (hatX_s omega)` agrees a.e. with `condExpKernel mu (mState.comap hatX_s)` mapped by `X_k^eta` |
| `appendix.tex:1368-1377`: component conditional-integral regularity. | `AutoSamplingTheory.condDistribIntegralAEStronglyMeasurable`; `AutoSamplingTheory.condDistribIntegralIntegrable` | formalized local helpers for vector-valued conditional integral measurability/integrability under Mathlib finite-measure, standard-Borel, a.e.-measurability, and integrability hypotheses |
| Middle handoff | `SALD.cycle85GeneralMovingTargetDiscreteConditionalKernelBoundaryMiddleObligation`; `ASTIS.SALD.cycle85.middle_condDistrib_condExpKernel_boundary` | obligation plus formalized helper node; EM weak FP, KL, theorem, SLT, and Lake statuses remain unpromoted |

Remaining lower theorem boundary:

| Boundary | Exact statement to prove or record |
|---|---|
| `hat rho_s` state-field versioning | From `hatRhoS = Law(hat X_s)` and the sample-space a.e. `condDistrib`/`condExpKernel` integral facts, construct named `hatRhoS`-a.e. component fields `condC_{k,s}` and `condScore_{k,s}` and feed `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfSwappedComponents` or `SALD.generalMovingTargetDiscreteEndpointConditionalDriftRegularityHandoff` without supplied component-regularity hypotheses. |

No source statement, source label, coefficient, theorem status, EM backend
status, SLT reuse status, or Lake dependency changed.

## Cycle 86 Middle Generator-To-Law Weak-FP Boundary

Middle keeps the active packet on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to `appendix.tex:1379-1387`.
Packet classification: `narrows-source-cited-boundary`.

Source-to-Lean map:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1379-1387`: invoke the Fokker--Planck equation associated with the frozen EM interpolation, with drift sign `-div(hat rho_s*bar b_{k,s})` and diffusion coefficient `sigma_eta^2/2`. | `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryUpperObligation`; `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryMiddleObligation` | obligation; no weak-FP theorem closed |
| Law/test derivative boundary: for admissible `phi`, derive the derivative of `s ↦ ∫ phi x d(hatRhoS_s)` from the sample-space integral over `hatX_s`. | `AutoSamplingTheory.lawMapIntegral`; `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; `ASTIS.SALD.cycle86.middle_weak_fp_generator_to_law_source_map` | formalized measure-map helper plus middle source boundary |
| Generator-action handoff boundary: feed the resulting `partialS phi = generatorAction phi` into existing source-sign wrappers only after the law derivative is justified. | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfReadinessAndGeneratorPiecesHandoff` | supplied generator/time-derivative remains the target to discharge or narrow |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 86 middle source map | Name the exact theorem boundary behind the paper's associated Fokker--Planck invocation: sample-path generator differentiation, Bochner/parametric integral interchange, `Measure.map` derivative transport, and conditional-field regularity before source signs. | cycle-79 `lawMapIntegral` helpers; cycle-85 `condDistribIntegralNamedFieldRegularity`; Mathlib `ParametricIntegral`; Bochner integral APIs | `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryMiddleObligation`; `ASTIS.SALD.cycle86.middle_weak_fp_generator_to_law_source_map` | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation |
| Remaining lower theorem | Either remove the supplied `hgenerator` hypothesis for admissible tests, or record one smaller missing theorem with imports and hypotheses. | sample-path generator theorem; source-action split; density/test/boundary assumptions | `ASTIS.SALD.cycle86.lower_packet.weak_fp_generator_to_law_boundary` | `appendix.tex:1379-1387` | weak-FP source signs; KL derivative handoff | selected lower boundary |

Remaining named subtheorems:

| Boundary | Exact statement to prove or record |
|---|---|
| sample-path generator differentiation | Prove `HasDerivAt (fun s => ∫ omega, phi (hatX_s omega) dP) ...` for admissible `phi` from the frozen EM interpolation dynamics. |
| parametric/Bochner integral interchange | Justify differentiating the time-dependent sample-space integral and transporting it through `Measure.map`. |
| drift/diffusion source actions | Identify the generator drift action with `-div(hat rho_s*bar b_{k,s})` and the diffusion action with `(sigma_eta^2/2)*Delta hat rho_s`, using cycle-85 conditional-field regularity and admissible boundary/test hypotheses. |

No source statement, source label, coefficient, theorem status, EM backend
status, SLT reuse status, or Lake dependency changed.

## Cycle 82 Weak FP Source-Sign Upper Packet

Global phase judgment: cycle 81 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, now narrowed to the weak conditional
Fokker--Planck source signs at `appendix.tex:1379-1387` after the accepted
endpoint/conditional `WeakFpPrereq` readiness package.

Source-to-Lean map:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1368-1377`: endpoint/conditional readiness for the named `hat rho_s` marginal, original kernel orientation, and `bar b_{k,s}` regularity. | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpReadinessHandoff`; `SALD.generalMovingTargetDiscreteEndpointMeasureMapWeakFpPrereqHandoff`; cycle-81 obligations | formalized local wrappers under supplied hypotheses |
| `appendix.tex:1379-1387`: associated FP equation with source signs `-div(hat rho_s*bar b_{k,s})` and `+(sigma_eta^2/2)*Delta hat rho_s`. | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff` | obligation; local sign/coefficient wrappers formalized only under supplied analytic hypotheses |
| Cycle 82 middle readiness bridge: turn the cycle-81 `WeakFpPrereq hatRhoS kernel barB` output into the common-space, conditional-kernel, and drift-regularity hypotheses consumed by the generator-piece wrapper. | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfReadinessAndGeneratorPiecesHandoff`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsMiddleObligation`; `ASTIS.SALD.cycle82.middle_readiness_to_source_signs` | compiled local wrapper under supplied hypotheses; weak FP theorem remains obligation |
| Cycle 82 lower endpoint-readiness-to-source-sign bridge: start from the cycle-81 endpoint/conditional readiness hypotheses, build `WeakFpPrereq`, and compose through the generator-piece source-sign wrapper. | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpSourceSignsHandoff`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsLowerObligation`; `ASTIS.SALD.cycle82.lower_packet.weak_fp_source_signs` | compiled local wrapper under supplied hypotheses; density/time regularity, generator calculus, weak FP theorem, and KL derivative remain obligations |
| Cycle 82 upper/middle assignment for the next lower packet. | `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsUpperPacket`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsUpperObligation`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsMiddleObligation`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsDag` | workflow obligation plus local readiness bridge |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 82 global judgment | No recovery; theorem skeleton stable; active risk is the weak conditional FP source-sign backend. | cycle-81 readiness; weak FP source-sign contract | `ASTIS.SALD.cycle82.global_phase_judgment` | `appendix.tex:1358-1387` | both discrete theorem routes | obligation |
| Cycle 82 middle readiness bridge | Consume `WeakFpPrereq` for the named law/kernel/`barB`, expose common-space, conditional-kernel, and drift-regularity hypotheses, and leave density/time regularity, tests, boundary, generator, and source actions supplied. | cycle-81 readiness; cycle-77 generator-piece wrapper | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfReadinessAndGeneratorPiecesHandoff`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsMiddleObligation`; `ASTIS.SALD.cycle82.middle_readiness_to_source_signs` | `appendix.tex:1379-1387` | both discrete theorem routes | local wrapper plus obligation |
| Cycle 82 lower packet | Bridge endpoint/conditional readiness plus supplied generator/time derivative and drift/diffusion source actions to the normalized weak-test source signs. | cycle-81 readiness; cycle-72 source-sign wrappers; cycle-77 generator-piece wrapper; cycle-79 source-cited generator-to-law interface; cycle-82 middle bridge | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpSourceSignsHandoff`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsLowerObligation`; `ASTIS.SALD.cycle82.lower_packet.weak_fp_source_signs` | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.discrete_forward_kl.em_interpolation_fp` | local wrapper plus obligation |
| Cycle 82 reviewer check | Reject sign flips, hidden theorem hypotheses, theorem-status promotion, or SLT/Lake dependency changes. | task contract and reviewer discipline | `ASTIS.SALD.cycle82.reviewer_weak_fp_source_signs_check` | `appendix.tex:1379-1387` | reviewer cycle | obligation |

Mode discipline: keep `faithfulPaper` Phase 1.  The paper signs are fixed:
negative drift `-div(hat rho_s*bar b_{k,s})` and positive diffusion
`+(sigma_eta^2/2)*Delta hat rho_s`.  Conditional law, density/AC,
admissible-test, boundary, generator, weak FP, KL derivative, LSI/KL/FI, DV,
Gronwall, and theorem closure remain source-cited or obligation-level unless
they compile locally.

## Cycle 83 Endpoint Weak-FP To KL Handoff

Global phase judgment: cycle 82 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, now narrowed to substituting the cycle-82
endpoint/conditional weak-FP source signs into
`eq:general_KL_derivative_0_discrete`.

Source-to-Lean map:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1358-1366`: differentiated KL display after the mass-conservation drop, `dK=partialS(logRatioTest)-targetTimeTerm`. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffContract`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSigns` | local substitution wrapper only; KL differentiation remains obligation |
| `appendix.tex:1379-1387`: endpoint/conditional weak-FP source signs from cycle 82. | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpSourceSignsHandoff`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsLowerObligation` | compiled local wrapper under supplied hypotheses; weak FP theorem remains obligation |
| Cycle 83 endpoint source-signs-to-KL handoff. | `SALD.generalMovingTargetDiscreteEndpointConditionalKlDerivativeWeakFpHandoff`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSignsWithLogAction`; `SALD.cycle83GeneralMovingTargetDiscreteKlDerivativeEndpointWeakFpLowerObligation` | compiled local compositions under supplied hypotheses; the companion pairs the log-ratio weak-FP action with the resulting `dK` display; density/AC, weak FP, KL differentiability, integration by parts, FI, LSI, DV, and Gronwall remain obligations |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 83 global judgment | No recovery; theorem skeleton stable; active risk is the endpoint weak-FP to KL derivative handoff. | cycle-82 source-sign lower bridge; KL handoff contract | `ASTIS.SALD.cycle83.global_phase_judgment` | `appendix.tex:1358-1387` | both discrete theorem routes | obligation |
| Cycle 83 middle source map | Align `eq:general_KL_derivative_0_discrete` with the cycle-82 source signs at the admissible log-ratio test before integration by parts. | cycle-82 endpoint source signs; cycle-73/78 KL substitution wrappers | `SALD.cycle83GeneralMovingTargetDiscreteKlDerivativeEndpointWeakFpMiddleObligation`; `ASTIS.SALD.cycle83.middle_endpoint_source_signs_to_kl` | `appendix.tex:1358-1387` | `sald.general_moving_target_discrete.kl_derivative` | obligation |
| Cycle 83 lower packet | Compose endpoint/conditional weak-FP source signs with the normalized weak-FP-to-KL substitution, preserving negative drift divergence, positive `sigma_eta^2/2` Laplacian, and the target-time term; additionally expose the log-ratio weak-FP action paired with the `dK` display. | cycle-82 endpoint source signs; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSigns`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSignsWithLogAction` | `SALD.generalMovingTargetDiscreteEndpointConditionalKlDerivativeWeakFpHandoff`; `ASTIS.SALD.cycle83.lower_packet.kl_derivative_endpoint_handoff` | `appendix.tex:1358-1387` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | local wrappers plus obligation |
| Cycle 83 reviewer check | Reject sign changes, hidden analytic theorem claims, theorem-status promotion, SLT/Lake changes, or drift outside the EM backend. | task contract and reviewer discipline | `ASTIS.SALD.cycle83.reviewer_kl_derivative_handoff_check` | `appendix.tex:1358-1387` | reviewer cycle | obligation |

Non-goals: no source theorem changes, no Gronwall/DV/LSI/frozen-delta work, no
SLT import or Lake dependency change, and no promotion of EM interpolation,
weak FP, density/AC, KL derivative, or either discrete theorem contract.

## Cycle 84 Active EM Backend Upper Packet

Global phase judgment: cycle 83 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; because cycle 83 compiled the endpoint weak-FP to KL
derivative handoff, the next lower packet should continue proof-producing EM
backend consolidation before introducing any new cited Mathlib/measure
interface.

Source-to-Lean map:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1368-1377`: named conditional drift and endpoint/conditional readiness already exposed by cycles 80-81. | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpReadinessHandoff`; `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalLowerObligation` | local wrappers plus obligations; regular conditional law and component conditional expectations remain obligations |
| `appendix.tex:1379-1387`: weak conditional FP source signs already exposed by cycle 82. | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpSourceSignsHandoff`; `SALD.cycle82GeneralMovingTargetDiscreteWeakFpSourceSignsLowerObligation` | local wrapper plus obligation; generator-to-law weak FP theorem remains obligation |
| `appendix.tex:1358-1366` with the log-ratio weak-FP action: cycle 83 KL handoff. | `SALD.generalMovingTargetDiscreteEndpointConditionalKlDerivativeWeakFpHandoff`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSignsWithLogAction` | local wrappers plus obligation; KL differentiability and integration by parts remain obligations |
| Cycle 84 upper selection. | `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendUpperPacket`; `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendUpperObligation` | workflow obligation; selected lower remains active EM-backend proof work |
| Cycle 84 middle source map. | `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendMiddleObligation`; `ASTIS.SALD.cycle84.middle_active_em_backend_source_map` | workflow obligation; no new measure fallback because the cycle-81 to cycle-83 local bridges compile under supplied hypotheses |
| Cycle 84 lower endpoint log-action handoff. | `SALD.generalMovingTargetDiscreteEndpointConditionalKlDerivativeWeakFpHandoffWithLogAction`; `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendLowerObligation` | compiled local wrapper plus obligation; no new Mathlib/measure fallback opened |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 84 global judgment | No recovery; theorem skeleton stable; continue active EM backend consolidation after cycle 83. | cycle-81 readiness; cycle-82 source signs; cycle-83 KL handoff | `ASTIS.SALD.cycle84.global_phase_judgment` | `appendix.tex:1358-1387` | both discrete theorem routes | obligation |
| Cycle 84 middle source map | Keep `eq:general_KL_derivative_0_discrete`, `bar b_{k,s}`, weak FP source signs, and the log-ratio KL handoff aligned through the existing wrappers before any fallback. | cycles 80-83 local wrappers; cycle-74 and cycle-79 source-cited fallback boundaries | `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendMiddleObligation`; `ASTIS.SALD.cycle84.middle_active_em_backend_source_map` | `appendix.tex:1358-1387` | active EM backend; both discrete theorem routes | obligation |
| Cycle 84 lower packet | Consume the accepted endpoint/conditional readiness, source-sign, and log-ratio KL handoffs before adding any new measure interface; return both the log-ratio weak-FP action and the `dK` display. | cycles 81-83 local wrappers | `SALD.generalMovingTargetDiscreteEndpointConditionalKlDerivativeWeakFpHandoffWithLogAction`; `SALD.cycle84GeneralMovingTargetDiscreteActiveEmBackendLowerObligation`; `ASTIS.SALD.cycle84.lower_packet.active_em_backend` | `appendix.tex:1358-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.discrete_forward_kl.em_interpolation_fp` | compiled local wrapper plus obligation |
| Blocked measure-interface guard | Only after a concrete block, introduce one narrow source-cited conditional-law or weak-FP theorem boundary with all analytic hypotheses explicit. | cycle-74 conditional-kernel interface; cycle-79 generator-to-law interface | `ASTIS.SALD.cycle84.blocked_measure_interface_escape_hatch` | `appendix.tex:1368-1387` | active EM backend | source-cited or obligation only |
| Reviewer check | Reject fallback without a concrete block, source sign changes, hidden analytic claims, theorem-status promotion, or SLT/Lake changes. | task contract and reviewer discipline | `ASTIS.SALD.cycle84.reviewer_active_em_backend_check` | `appendix.tex:1358-1387` | reviewer cycle | obligation |

Non-goals: no source-index rebaseline beyond the acceptance gate, no broad
theorem-route audit, no Gronwall/DV/LSI/frozen-delta work, no unrelated display
algebra, no SLT import or Lake dependency change, and no promotion of EM
interpolation, weak FP, density/AC, KL derivative, or either discrete theorem
contract.

## Cycle 81 Middle Endpoint-To-Conditional Handoff

Source slice: `appendix.tex:1358-1387`, selected lines `1368-1377`.
The paper defines
`bar b_{k,s}(x)=E[dot t_k*c_{t_k}(X_k^eta)+(sigma_eta^2/2)*nabla log pi_{t_k}(X_k^eta) | hat X_s=x]`
after naming `hat rho_s=Law(hat X_s)`.  Before the weak Fokker--Planck line
can consume this field, the endpoint/common-space `Measure.map` bookkeeping
must agree with the conditional-kernel orientation.

Lean-facing update:

- `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpReadinessHandoff`
  compiles a supplied-hypothesis wrapper from endpoint laws, original/swapped
  `hat rho_s` marginal views, swap equality, original-orientation kernel
  compatibility, and `bar b_{k,s}` measurability/integrability into an
  abstract `WeakFpPrereq`.
- `SALD.generalMovingTargetDiscreteEndpointMeasureMapWeakFpPrereqHandoff`
  compiles the endpoint-only lower bridge from the cycle-76 `Measure.map`
  compatibility package plus supplied `bar b_{k,s}` regularity to the same
  abstract `WeakFpPrereq`, without rebuilding component conditional fields.
- `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalMiddleObligation`
  records this as the cycle-81 middle source map.
- `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalLowerObligation`
  records the endpoint-only lower handoff as a formalized local wrapper plus
  obligation.
- Both discrete theorem contracts still remain `contractOnly`; the EM
  conditional law, weak FP, generator theorem, density/AC, KL derivative,
  LSI/KL/FI, DV, and Gronwall backends remain obligations.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 81 middle endpoint/weak-FP readiness | Package endpoint `Measure.map` laws, named `hat rho_s` marginal views, swapped/original kernel orientation, and `bar b_{k,s}` regularity into a weak-FP prerequisite predicate. | cycle-76 endpoint/orientation wrapper; cycle-80 drift-regularity wrapper; weak-FP source-sign contract | `SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpReadinessHandoff`; `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalMiddleObligation`; `ASTIS.SALD.cycle81.middle_endpoint_conditional_weak_fp_readiness` | `appendix.tex:1368-1377` | `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | formalized local wrapper plus obligation |
| Cycle 81 lower endpoint-only weak-FP prerequisite | Use endpoint `Measure.map` compatibility and already-supplied `bar b_{k,s}` regularity to feed the abstract weak-FP prerequisite predicate. | cycle-76 endpoint/orientation wrapper; supplied `FieldMeasurable`/`FieldIntegrable`; weak-FP source-sign contract | `SALD.generalMovingTargetDiscreteEndpointMeasureMapWeakFpPrereqHandoff`; `SALD.cycle81GeneralMovingTargetDiscreteEndpointConditionalLowerObligation`; `ASTIS.SALD.cycle81.lower_endpoint_measure_map_weak_fp_prereq` | `appendix.tex:1368-1377` | `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | formalized local wrapper plus obligation |

SLT status: checked only as a local Mathlib style reference.  No SLT theorem
is imported or marked formalized, and no Lake dependency changes.

## Cycle 80 Upper Conditional-Law Backfill

Global phase judgment: cycle 79 passed reviewer/build and needs no recovery;
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill; the single lower packet that best reduces proof risk is
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the conditional-law/measurability and
named conditional drift interface at `appendix.tex:1368-1377`.

Active-packet check: this stays on the source line defining
`\bar b_{k,s}(x)` as the conditional expectation of
`\dot t_k c_{t_k}(X_k^\eta) + (\sigma_\eta^2/2)\nabla\log\pi_{t_k}(X_k^\eta)`
given `\hat X_s=x`.  Cycle 79 exposed the weak generator-to-law theorem
boundary, but that theorem still consumes this conditional-law layer.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 80 global judgment | No recovery; theorem skeletons are stable; return to the first preferred EM backend packet because weak generator-to-law still depends on the named conditional drift. | cycle-74 conditional-kernel interface; cycle-75 orientation and component regularity wrappers; cycle-79 generator-to-law source-cited interface | `SALD.cycle80GeneralMovingTargetDiscreteConditionalLawMeasurabilityUpperObligation`; `ASTIS.SALD.cycle80.global_phase_judgment` | `appendix.tex:1358-1387`, especially `1368-1377` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 80 middle source map | Pin the lower-ready theorem boundary: regular conditional kernel for `X_k^eta | hat X_s=x`, named `hat rho_s` marginal, `condDistrib`/`condExpKernel` orientation, component conditional-integral fields, and measurable/integrable `bar b_{k,s}`. | cycles 70, 74, 75; cycle-79 generator-to-law source-cited interface; SLT measure-map style reference only | `SALD.cycle80GeneralMovingTargetDiscreteConditionalLawMeasurabilityMiddleObligation`; `ASTIS.SALD.cycle80.middle_conditional_law_source_map` | `appendix.tex:1368-1377` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.discrete_forward_kl.em_interpolation_fp` | obligation |
| Cycle 80 lower packet | Refine the conditional-law/measurability interface after the middle source map by compiling a supplied-hypothesis wrapper around the endpoint/kernel and component-integral regularity facts. | cycle-80 middle map; cycles 70, 74, 75, 76; Mathlib kernel candidates; no SLT import | `SALD.cycle80GeneralMovingTargetDiscreteConditionalLawMeasurabilityLowerObligation`; `ASTIS.SALD.cycle80.lower_packet.conditional_law_measurability` | `appendix.tex:1368-1377` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.discrete_forward_kl.em_interpolation_fp` | obligation plus local wrapper |
| Cycle 80 lower drift-regularity wrapper | Compose endpoint-to-conditional compatibility with supplied component conditional-integral field regularity, returning endpoint laws, original and swapped `hat rho_s` marginal views, original-orientation kernel compatibility, and measurable/integrable `bar b_{k,s}`. | `SALD.generalMovingTargetDiscreteEndpointMeasureMapToConditionalCompatibility`; `SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityOfComponents`; cycle-76 lower wrapper | `SALD.generalMovingTargetDiscreteEndpointConditionalDriftRegularityHandoff`; `ASTIS.SALD.cycle80.lower_endpoint_conditional_drift_regularity` | `appendix.tex:1368-1377` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | formalized local wrapper under supplied hypotheses |

Non-goals: endpoint-law re-audit, weak FP source signs, KL derivative handoff,
display algebra, Gronwall/DV/LSI work, theorem status promotion, SLT import,
Lake dependency changes, and polished article export.

Reviewer checklist: verify the lower packet remains inside
`appendix.tex:1368-1377`, cycle 80 depends on existing cycle-74/cycle-75
conditional-kernel interfaces without promoting them, both discrete theorem
contracts remain `contractOnly`, and `python3 tools/astis.py source-index
ASTIS-SALD-001` plus `python3 tools/astis.py check` pass.

## Cycle 79 Weak FP Generator Measure Interface

Global phase judgment: cycle 78 passed reviewer/build and needs no recovery;
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill; the single lower packet that now reduces the largest proof risk is
still `sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the weak generator-to-law
time-derivative interface for `appendix.tex:1379-1387`.

Active source check: the source fixes `k`, names
`\hat\rho_s=\Law(\hat X_s)`, defines the frozen conditional drift
`\bar b_{k,s}`, and then invokes the Fokker--Planck equation associated with
the frozen interpolation.  Cycle 79 records the missing theorem boundary
before that invocation: differentiating the `Measure.map` law/test integral
for admissible weak tests and identifying the generator action with drift
`bar b_{k,s}` and diffusion coefficient `\sigma_\eta^2/2`.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1379-1387`: associated weak Fokker--Planck line for the frozen EM interpolation. | `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureInterface`; `ASTIS.SALD.cycle79.lower_packet.weak_fp_generator_measure_interface` | `sourceCited`; Mathlib measure/calculus audit target, not a formalized SDE theorem |
| Cycle 79 upper packet and judgment. | `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureUpperPacket`; `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureUpperObligation`; `ASTIS.SALD.cycle79.global_phase_judgment` | workflow obligation |
| Cycle 79 middle source map. | `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureMiddleObligation`; `ASTIS.SALD.cycle79.middle_weak_fp_generator_measure_source_map` | workflow obligation; source-to-Lean boundary for the cited measure/calculus theorem |
| Cycle 79 lower Measure.map weak-test handoff. | `AutoSamplingTheory.lawMapIntegral`; `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureLowerObligation`; `ASTIS.SALD.cycle79.lower_measure_map_integral_handoff` | formalized local wrapper under supplied derivative hypotheses; the EM generator theorem remains source-cited |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 79 weak generator-to-law interface | Differentiate the frozen EM interpolation law/test integral and identify the weak generator action before the cycle-77 source-sign and cycle-78 KL wrappers consume it. | cycle-74 conditional-kernel interface; cycle-77 generator-piece wrappers; cycle-78 KL handoff; Mathlib `Measure.map`, Bochner integral, and parametric integral candidates | `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureInterface`; `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureDag` | `appendix.tex:1379-1387`; Mathlib `Analysis/Calculus/ParametricIntegral.lean` | `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | `sourceCited` plus upper workflow obligation |
| Cycle 79 middle source map | Keep the source-to-Lean boundary precise: the paper's Fokker--Planck invocation is the cited generator-to-law theorem before source-sign wrappers and KL substitution. | cycle-79 cited measure interface; cycle-77 generator source signs; cycle-78 KL handoff | `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureMiddleObligation`; `ASTIS.SALD.cycle79.middle_weak_fp_generator_measure_source_map` | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; both discrete theorem routes | obligation |
| Cycle 79 lower Measure.map weak-test handoff | Rewrite weak-test integrals against `Measure.map (hat X_s) P` as sample-space integrals and transport a supplied `HasDerivAt` statement across that equality. | Mathlib `integral_map`; supplied sample-space derivative; cycle-79 source-cited interface | `AutoSamplingTheory.lawMapIntegral`; `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`; `SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureLowerObligation`; `ASTIS.SALD.cycle79.lower_measure_map_integral_handoff` | `appendix.tex:1379-1387`; Mathlib `Measure.map`/Bochner integral | `sald.general_moving_target_discrete.em_interpolation_fp`; both discrete theorem routes | formalized local wrapper plus obligation |

Non-goals: theorem-route audit, display algebra, Gronwall/DV/LSI work,
frozen-delta work, SLT import, new Lake dependency, or any promotion of the
weak FP, EM interpolation, KL derivative, or theorem statuses.

## Cycle 78 Upper Generator-To-KL Handoff

Global phase judgment: cycle 77 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill. The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, now narrowed to composing the cycle-77
generator-piece weak FP source signs into the discrete KL-derivative handoff.
Lower cycle 78 adds the intermediate normalized source-sign wrapper so the
handoff now factors as weak-FP source signs at the admissible log-ratio test,
then the generator-piece specialization.

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 78 global judgment | No recovery; keep the single-backend route on EM conditional-law/Fokker--Planck; select generator-piece weak FP to KL derivative handoff. | cycle-77 generator source-sign lower; cycle-73 KL handoff; active EM backend | `SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorUpperPacket`; `SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorUpperObligation`; `ASTIS.SALD.cycle78.global_phase_judgment` | `appendix.tex:1358-1387` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 78 middle source map | Align `eq:general_KL_derivative_0_discrete` with the cycle-77 generator-piece weak FP source signs at the admissible log-ratio test; no integration by parts, Laplacian split, FI, LSI, DV, or Gronwall step is included. | `SALD.cycle77GeneralMovingTargetDiscreteWeakFpGeneratorLowerObligation`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffContract`; cycle-73 KL substitution route | `SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorMiddleObligation`; `ASTIS.SALD.cycle78.middle_kl_derivative_generator_source_map` | `appendix.tex:1358-1387`, especially `1358-1366` and `1379-1387` | `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | obligation |
| Normalized weak-FP source signs to KL substitution | Under an already normalized admissible weak-FP identity `partialS phi = -driftDiv phi + (sigma_eta^2/2) laplacian phi`, substitute the source signs into `eq:general_KL_derivative_0_discrete` at the admissible log-ratio test. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffContract`; normalized source signs from cycle-72/cycle-77 wrappers | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfSourceSigns`; `SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorLowerObligation`; `ASTIS.SALD.cycle78.lower_kl_derivative_generator_handoff` | `appendix.tex:1358-1387`, especially `1358-1366` and `1379-1387` | `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | formalized local equality wrapper plus obligation |
| Generator-piece to KL substitution | Under supplied generator/time-derivative, generator split, drift source action, diffusion source action, admissible log-ratio test, and `sigmaCoeff=sigma_eta^2/2`, substitute the source-signed weak FP action into `eq:general_KL_derivative_0_discrete`. | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffContract`; cycle-77 lower | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfGeneratorPieces`; `SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorLowerObligation`; `ASTIS.SALD.cycle78.lower_kl_derivative_generator_handoff` | `appendix.tex:1358-1387`, especially `1358-1366` and `1379-1387` | `sald.general_moving_target_discrete.kl_derivative`; both discrete theorem routes | formalized local equality wrapper plus obligation |

Mode discipline: faithfulPaper Phase 1 only. Do not change theorem statements,
constants, source labels, or proof order; `sald_version_2.tex` remains out of
scope.

Non-goals: no generator theorem, weak Fokker--Planck theorem, density/AC,
log-ratio admissibility, integration-by-parts, LSI/KL/FI, DV, Gronwall, or
theorem-status promotion.

Reviewer checklist: confirm the new wrapper is only equality composition under
explicit hypotheses; both discrete theorem contracts remain `contractOnly`;
the active backend remains `sald.general_moving_target_discrete.em_interpolation_fp`
over `appendix.tex:1358-1387`; source-index and `python3 tools/astis.py check`
pass.

## Cycle 77 Weak FP Generator Source Signs

Objective: continue the single-backend EM conditional-law/Fokker--Planck
backfill for `sald.general_moving_target_discrete.em_interpolation_fp`, using
the original source window `appendix.tex:1358-1387` and the active line
`appendix.tex:1379-1387`.

Source fragment:

```tex
\partial_s\hat\rho_s
=
-\nabla\cdot(\hat\rho_s\bar b_{k,s})
+
\frac{\sigma_{\eta}^2}{2}\Delta\hat\rho_s.
```

Lean-facing map:

| Source symbol or step | Lean-facing declaration | Status |
|---|---|---|
| `\hat\rho_s=Law(\hat X_s)` on a fixed EM interval | `SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityContract`; cycle-76 endpoint wrappers | obligation plus local wrappers |
| `\bar b_{k,s}` conditional drift | `SALD.generalMovingTargetDiscreteConditionalLawMeasurabilityContract`; `SALD.generalMovingTargetDiscreteConditionalDriftContract` | obligation |
| associated weak FP equation | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract` | obligation |
| generator/time-derivative plus source expansion handoff | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff` | formalized local wrappers under supplied analytic hypotheses |
| downstream KL substitution | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfAdmissibleSourceSigns` | formalized local wrapper plus obligation |

Cycle-77 proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Global judgment | Cycle 76 accepted; Phase 1 stable; remain on EM backend weak FP source signs. | cycle-76 endpoint compatibility; cycle-72 weak-FP contract | `ASTIS.SALD.cycle77.global_phase_judgment` | `appendix.tex:1379-1387` | discrete theorem routes | obligation |
| Middle generator map | Split the source's "associated Fokker--Planck equation" invocation into generator/time-derivative and generator source-expansion hypotheses. | conditional law, endpoint compatibility, weak-test contract | `SALD.cycle77GeneralMovingTargetDiscreteWeakFpGeneratorMiddleObligation` | `appendix.tex:1379-1387` | EM backend | obligation |
| Lower generator wrapper | Compose supplied generator identity, supplied source expansion, or supplied split drift/diffusion source actions with `sigmaCoeff=sigma_eta^2/2` into the source-signed weak statement. | cycle-72 admissible-test wrapper; explicit regularity hypotheses | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`; `SALD.cycle77GeneralMovingTargetDiscreteWeakFpGeneratorLowerObligation` | `appendix.tex:1379-1387` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | local wrappers plus obligation |

The lower component wrapper is proof-producing local algebra only: after a
supplied generator/time-derivative identity, supplied generator split, supplied
drift source action `-div(hat rho_s*bar b_{k,s})`, supplied positive diffusion
action, and `sigmaCoeff=sigma_eta^2/2`, it derives the source-signed weak FP
identity on admissible tests.

Remaining proof obligations: the Brownian/EM generator theorem, regular
conditional law construction, density/absolute-continuity, admissible-test
approximation, boundary/integration by parts, KL differentiation, LSI/KL/FI,
DV, Gronwall, and theorem closure.  No theorem statement, coefficient, source
label, SLT status, or backend status was promoted.

## Cycle 76 Endpoint-To-Conditional Backfill

Global phase judgment: cycle 75 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The largest remaining shared proof risk is still
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; cycle 76 keeps the lower packet on
endpoint-law-to-conditional-law compatibility, connecting endpoint
`Measure.map` bookkeeping to the swapped `condDistrib` orientation needed by
the weak Fokker--Planck interface.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1354-1357`: endpoint laws `hat rho_{s_k}=rho_k^eta` and `hat rho_{s_{k+1}}=rho_{k+1}^eta`. | `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation` | formalized local `Measure.map` wrapper under supplied endpoint identities |
| `appendix.tex:1368-1377`: conditional law for `X_k^eta | hat X_s=x` uses Mathlib's swapped joint orientation `(hat X_s,X_k^eta)`. | `SALD.generalMovingTargetDiscreteHatRhoFirstMarginalOfSwappedJointMap`; `AutoSamplingTheory.lawMapProdSwap` | formalized local orientation bookkeeping |
| Cycle 76 bridge: package endpoints, swapped first marginal, original second marginal, swap equality, and original-orientation kernel compatibility under supplied kernel hypotheses. | `SALD.generalMovingTargetDiscreteEndpointMeasureMapToSwappedConditionalCompatibility`; `SALD.generalMovingTargetDiscreteEndpointMeasureMapToConditionalCompatibility`; `SALD.cycle76GeneralMovingTargetDiscreteEndpointConditionalLowerObligation` | formalized local wrappers plus obligation |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 76 global judgment | No recovery from cycle 75; theorem-skeleton route stable; active risk remains the endpoint-to-conditional layer in the shared EM backend. | cycle-75 swapped conditional-law wrapper; cycle-74 source-cited kernel interface | `SALD.cycle76GeneralMovingTargetDiscreteEndpointConditionalUpperObligation`; `ASTIS.SALD.cycle76.global_phase_judgment` | `appendix.tex:1358-1387` | both discrete theorem routes | obligation |
| Cycle 76 middle map | Align endpoint laws, named interior `hat rho_s=Law(hat X_s)`, and swapped `condDistrib` orientation before weak FP proof search. | endpoint `Measure.map` wrappers; cycle-75 swap orientation; conditional-law measurability contract | `SALD.cycle76GeneralMovingTargetDiscreteEndpointConditionalMiddleObligation`; `ASTIS.SALD.cycle76.middle_endpoint_conditional_map` | `appendix.tex:1354-1387` | `sald.general_moving_target_discrete.em_interpolation_fp` | obligation |
| Cycle 76 lower wrapper | From supplied endpoint identities and swapped kernel compatibility, return endpoint law equalities, swapped first marginal, original second marginal, swap equality, and original-orientation kernel compatibility. | `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation`; `SALD.generalMovingTargetDiscreteHatRhoFirstMarginalOfSwappedJointMap`; `SALD.generalMovingTargetDiscreteHatRhoMarginalOfJointMap`; `AutoSamplingTheory.lawMapProdSwap` | `SALD.generalMovingTargetDiscreteEndpointMeasureMapToSwappedConditionalCompatibility`; `SALD.generalMovingTargetDiscreteEndpointMeasureMapToConditionalCompatibility`; `ASTIS.SALD.cycle76.lower_endpoint_to_swapped_conditional` | `appendix.tex:1354-1387` | weak FP interface and both discrete theorem routes | formalized local wrappers plus obligation |

Non-goals: no construction of `condDistrib`/`condExpKernel`, no weak FP proof,
no KL derivative proof, no density/AC proof, no Gronwall/DV/LSI work, no
theorem-status promotion, and no SLT import.

## Cycle 70 Middle Conditional-Law Backfill

Global phase judgment: cycle 69 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for a single cited
theory/SDE backend backfill, but not for broad theorem-route rotation. The
largest remaining proof risk is still
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed in this cycle to
conditional-law/measurability and named conditional drift interfaces for
`\bar b_{k,s}`.

Source-to-Lean split for the active paragraph:

| Source step | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:1358-1366`: define `hat rho_s=Law(hat X_s)` and start differentiating KL. | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` | common probability space, density/AC, finite KL, mass conservation, endpoint-safe KL differentiation |
| `appendix.tex:1368-1377`: define `bar b_{k,s}(x)` by conditioning on `hat X_s=x`. | `SALD.generalMovingTargetDiscreteConditionalLawMeasurabilityContract`; `SALD.generalMovingTargetDiscreteConditionalDriftContract`; `SALD.generalMovingTargetDiscreteNamedConditionalDriftComponents`; `SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityHandoff`; `SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityOfComponents` | regular conditional kernel/disintegration, concrete component measurability, conditional integrability, weak-test admissibility |
| `appendix.tex:1379-1387`: insert the associated EM conditional Fokker--Planck equation. | `SALD.generalMovingTargetDiscreteConditionalFpSourceSignsHandoff`; `SALD.generalMovingTargetDiscreteConditionalFpSigmaLaplacianSplitHandoff`; `sald.general_moving_target_discrete.em_interpolation_fp` | actual weak conditional FP theorem, Laplacian split hypotheses, KL derivative handoff |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 70 global judgment | No recovery; single-backend EM conditional-law/FP backfill only. | cycle-69 source-sign wrapper; cycle-64 drift contract; cycle-48 EM audit | `ASTIS.SALD.cycle70.global_phase_judgment` | `appendix.tex:1358-1387` | cycle 70 packet | obligation |
| Cycle 70 middle conditional-law interface | Name the regular conditional kernel, component conditional fields, selected drift, and regularity side conditions. | endpoint-law helpers; drift contract; derivative side-condition contract | `SALD.cycle70GeneralMovingTargetDiscreteConditionalLawMiddleObligation`; `SALD.generalMovingTargetDiscreteConditionalLawMeasurabilityContract`; `ASTIS.SALD.cycle70.middle_conditional_law_interface` | `appendix.tex:1368-1377` | `sald.general_moving_target_discrete.em_interpolation_fp` | obligation |
| Cycle 70 lower named drift wrapper | From supplied conditional-expectation linearity and named component fields, identify `bar b_{k,s}`; derive combo regularity from component regularity using add/smul closure; transfer predicates by equality. | cycle-64 algebra wrappers; component regularity and closure predicates supplied by future analytic backend | `SALD.generalMovingTargetDiscreteNamedConditionalDriftComponents`; `SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityHandoff`; `SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityOfComponents`; `SALD.cycle70GeneralMovingTargetDiscreteConditionalLawLowerObligation`; `ASTIS.SALD.cycle70.lower_named_conditional_drift` | `appendix.tex:1368-1377` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | formalized local wrapper plus obligation |

The new Lean wrappers are not a disintegration theorem. The lower component
regularity wrapper only consumes supplied component regularity, add/smul
closure, and congruence predicates. It does not prove the regular conditional
law, concrete measurability, conditional integrability,
density/absolute-continuity, weak conditional Fokker--Planck equation, KL
differentiation, integration by parts, LSI/KL/FI, DV, Gronwall, or either
discrete theorem. Both discrete theorem contracts remain `contractOnly`; the
EM backend remains obligation-level.

## Cycle 69 Upper Analytic Interface Ledger

Global phase judgment: cycle 68 passed reviewer/build, so no failed previous
cycle needs recovery. Phase 1 theorem-skeleton translation is stable enough
for a post-route analytic-interface ledger and one narrow backend backfill, but
not for broad cited-theory, SDE, disintegration, SLT import, or reusable API
reorganization. The single lower packet that best reduces the largest proof
risk is the shared Euler--Maruyama interpolation conditional-law/Fokker--
Planck backend
`SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation` /
`SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` /
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.

Lean-facing update:

- `SALD.cycle69MainSkeletonAnalyticInterfaceLedger` records the upper
  objective, mode discipline, non-goals, lower packet, reviewer checklist, and
  the five post-route analytic interfaces.
- `SALD.cycle69MainSkeletonAnalyticInterfaceObligation`
  (`sald.main_skeleton.cycle69_analytic_interface_ledger`) is listed by all
  six theorem contracts; all six remain `contractOnly`.
- `SALD.cycle69MainSkeletonAnalyticInterfaceDag` is included in
  `SALD.forwardKlProofDag`, `SALD.discreteForwardKlProofDag`,
  `SALD.generalVaSaldProofDag`, and `SALD.generalVaSaldDiscreteProofDag`.
- `SALD.cycle69MainSkeletonDependencyNames` is included by
  `SALD.saldDependenciesForLabel` for the five slow interfaces and all six
  theorem-route labels.

Five slow interfaces checked:

| Backend | Lean-facing interface | Status discipline |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallCandidateContract`; `SALD.saldGronwallEndpointCalculusContract`; `SALD.saldGronwallExponentRewriteContract`; theorem-specific Gronwall side-condition contracts | obligation |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; theorem-specific finite-log-mgf witnesses | source-cited equality plus obligations |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `probability.lsi_to_kl_fi` | obligation |
| continuous forward-KL/KL derivative | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `SALD.generalMovingTargetDerivativeCandidateContract`; cycle-60/65/67 scalar handoffs | obligation |
| EM interpolation Fokker--Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; cycle-63 endpoint laws; cycle-64 conditional drift algebra; `sald.general_moving_target_discrete.em_interpolation_fp` | selected lower packet; obligation |

The theorem route remains paper ordered:

| Route slot | Source block | Lean-facing consumers | Status |
|---|---|---|---|
| `thm:forward-KL` | `appendix.tex:168-252` | continuous KL derivative/Fokker--Planck, LSI/KL/FI, DV velocity energy, inverse-schedule calculus, Gronwall display | `contractOnly` theorem; analytic obligations |
| `thm:forward-KL-discrete` | `appendix.tex:260-592` | EM endpoint/conditional-FP, frozen defect, LSI, DV velocity, Gronwall, accumulated-error display | `contractOnly` theorem; analytic obligations |
| `prop:guided_path_residual` | `appendix.tex:619-704` | guided normalizer differentiation, quotient/product calculus, divergence cancellation, centered residual identity | `contractOnly` proposition |
| `thm:general-moving-target-SALD` | `appendix.tex:724-949` | continuous general KL derivative, residual Young/LSI, residual DV, sigma-weighted Gronwall, pure contraction | `contractOnly` theorem; analytic obligations |
| `thm:unified-forward-KL` | `main_body.tex:359-395`; `appendix.tex:949-951` | guided residual, correction-field transport bridge, continuous general theorem specialization | `contractOnly` theorem |
| `thm:general-moving-target-SALD-discrete` | `appendix.tex:1313-1603` | general EM endpoint/conditional-FP, frozen delta, KL derivative/LSI, residual DV, constant-schedule Gronwall/display | `contractOnly` theorem; analytic obligations |

Selected lower packet split:

| Source lines | Lean-facing target | Open backend |
|---|---|---|
| `appendix.tex:1358-1366` | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` | common space, endpoint laws, density/absolute-continuity, finite KL, mass conservation, endpoint-safe KL differentiation |
| `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteConditionalDriftContract`; cycle-64 conditional-drift linearity wrappers | regular conditional law of `X_k^eta` given `hat X_s=x`, measurability, integrability, conditional-expectation linearity |
| `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; cycle-54 sigma/Laplacian split downstream | weak conditional Fokker--Planck with source signs `-div(hat rho_s bar b_{k,s})` and `+(sigma_eta^2/2) Delta hat rho_s` |

No theorem statement, source constant, source label, source-file scope, theorem
status, slow analytic backend status, or SLT reuse status changed.

## Cycle 69 Middle Analytic Interface Audit

Middle synchronized the post-route analytic-interface ledger with the Lean
contracts and proof DAG.  The new Lean-facing declarations are
`SALD.cycle69MainSkeletonAnalyticMiddleContract` and
`SALD.cycle69MainSkeletonAnalyticMiddleObligation`
(`sald.main_skeleton.cycle69_middle_interface_audit`).

Source-to-Lean check:

| Route slot | Source block | Lean-facing audit | Status |
|---|---|---|---|
| `thm:forward-KL` | `appendix.tex:168-252` | continuous KL derivative/Fokker--Planck, LSI/KL/FI, DV velocity-energy, inverse-schedule calculus, Gronwall display | theorem `contractOnly`; analytic obligations |
| `thm:forward-KL-discrete` | `appendix.tex:260-592` | EM endpoint/conditional-FP, frozen defect, LSI, DV velocity, time-changed Gronwall, accumulated-error display | theorem `contractOnly`; analytic obligations |
| `prop:guided_path_residual` | `appendix.tex:619-704` | guided normalizer derivative, quotient/product calculus, divergence cancellation, centered residual and mean-zero proof | proposition `contractOnly` |
| `thm:general-moving-target-SALD` | `appendix.tex:724-949` | continuous general KL derivative, residual Young/LSI, residual DV, sigma-weighted Gronwall, pure contraction | theorem `contractOnly`; analytic obligations |
| `thm:unified-forward-KL` | `main_body.tex:359-395`; `appendix.tex:949-951` | correction-field transport bridge and `c_t=u_t`, `m_t=w_t` specialization | theorem `contractOnly` |
| `thm:general-moving-target-SALD-discrete` | `appendix.tex:1313-1603` | general EM endpoint/conditional-FP, frozen-delta, KL derivative/LSI, residual DV, constant-schedule Gronwall/display | theorem `contractOnly`; analytic obligations |

Selected lower packet after middle audit:

| Source lines | Lean-facing target | Open backend |
|---|---|---|
| `appendix.tex:1358-1366` | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` | common probability space, endpoint laws, density/absolute-continuity, finite KL, mass conservation, endpoint-safe KL differentiation |
| `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteConditionalDriftContract`; cycle-64 conditional-drift algebra | regular conditional law of `X_k^eta` given `hat X_s=x`, measurability, integrability, conditional-expectation linearity |
| `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `ASTIS.SALD.cycle69.lower_packet.em_interpolation_fp` | weak conditional Fokker--Planck with source signs `-div(hat rho_s bar b_{k,s})` and `+(sigma_eta^2/2) Delta hat rho_s` |

`SALD.cycle69MainSkeletonAnalyticMiddleObligation` is listed by all six
theorem contracts, and `ASTIS.SALD.cycle69.middle_interface_audit` is included
in `SALD.cycle69MainSkeletonAnalyticInterfaceDag`.  No theorem statement,
source constant, source label, theorem status, analytic backend status, or SLT
reuse status changed.

## Cycle 69 Lower EM FP Source-Sign Handoff

Lower kept the selected packet on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387` and made one proof-producing Lean step before adding
more ledger text.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1379-1387`: once the weak conditional Fokker--Planck backend supplies `partial_s hat rho_s = -div(hat rho_s*bar b_{k,s}) + sigmaCoeff*Delta hat rho_s` and the coefficient identity `sigmaCoeff=sigma_eta^2/2`, preserve the exact paper signs and diffusion coefficient. | `SALD.generalMovingTargetDiscreteConditionalFpSourceSignsHandoff` | formalized local module/equality wrapper under explicit hypotheses |
| Register this wrapper under the selected cycle-69 lower packet without promoting the EM analytic backend. | `SALD.cycle69GeneralMovingTargetDiscreteEmFpSourceSignsLowerObligation`; `sald.general_moving_target_discrete.cycle69_em_fp_source_signs_lower` | obligation plus compiled local wrapper |

The wrapper does not construct the common probability space, endpoint laws,
regular conditional drift, density/absolute-continuity, weak Fokker--Planck
identity, KL differentiation, integration by parts, LSI/KL/FI, DV, Gronwall, or
`thm:general-moving-target-SALD-discrete`.

## Cycle 67 Upper Guided/General Route

Global phase judgment: cycle 66 passed reviewer/build, so no recovery is
needed. Phase 1 theorem-skeleton translation is not yet stable enough for
cited-theory backfill because the guided residual and continuous general
moving-target route still needs a fresh post-cycle-66 wiring pass. The single
lower packet that best reduces proof risk is the residual-to-Gronwall bridge
for `thm:general-moving-target-SALD` over `appendix.tex:765-945`, with
`prop:guided_path_residual` kept on its existing normalizer and centered
residual obligations.

Lean-facing update:

- `SALD.cycle67GuidedGeneralSkeletonUpperPacket` records the upper objective,
  mode discipline, non-goals, lower packet, and reviewer checklist for
  `appendix.tex:619-951`.
- `SALD.cycle67GuidedGeneralSkeletonObligation`
  (`sald.guided_general.cycle67_upper_route`) is now listed by
  `SALD.guidedResidualContract`, `SALD.generalVaSaldContract`, and the unified
  forward-KL contract while all remain `contractOnly`.
- `SALD.cycle67GuidedGeneralResidualGronwallBridgeObligation`
  (`sald.general_moving_target.cycle67_residual_to_gronwall_bridge`) is the
  selected lower packet and remains an obligation-level source-cited bridge.
- `SALD.cycle67GuidedGeneralSkeletonDag` is included in
  `SALD.generalVaSaldProofDag`, and `SALD.cycle67GuidedGeneralDependencyNames`
  is included by `SALD.saldDependenciesForLabel` for
  `prop:guided_path_residual`, `thm:general-moving-target-SALD`, and
  `thm:unified-forward-KL`.

Five-interface check:

| Backend | Lean-facing interface | Status |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallEndpointCalculusContract`; `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_application` | obligation |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `sald.general_moving_target.dv_m_energy` | source-cited plus obligations |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `probability.lsi_to_kl_fi` | obligation |
| continuous KL derivative/Fokker--Planck | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; `sald.general_moving_target.kl_derivative`; cycle-57/62 scalar handoffs | obligation |
| EM interpolation FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.em_interpolation_fp` | downstream obligation only |

Source-to-Lean route:

| Source step | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:619-704` residual identity | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.normalizer_derivative`; `sald.guided_path_residual.identity`; `SALD.cycle67GuidedGeneralSkeletonObligation` | normalizer positivity, differentiation under the integral, integration by parts, quotient/product differentiation, mean-zero residual |
| `appendix.tex:724-744` theorem statement | `SALD.generalMovingTargetStatementContract`; `SALD.generalVaSaldContract` | theorem remains `contractOnly`; source constants unchanged |
| `appendix.tex:765-884` KL derivative and residual split | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; `sald.general_moving_target.kl_derivative`; cycle-57/62 scalar residual handoffs | mass conservation, KL differentiation, Fokker--Planck, integration by parts, target transport, sigma/schedule assumptions |
| `appendix.tex:885-907` residual DV | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `sald.general_moving_target.dv_m_energy` | common space, AC, finite KL/log-mgf, measurability, positive alpha for `Z=alpha*||m_t||^2` |
| `appendix.tex:908-945` Gronwall and pure contraction | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_side_conditions`; `sald.general_moving_target.pure_contraction`; `SALD.cycle67GuidedGeneralResidualGronwallBridgeObligation` | endpoint rewrites, coefficient regularity, Gronwall theorem, exponent splitting, zero residual alpha-complexity |
| `appendix.tex:949-951` unified reuse | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.specialization` | downstream specialization only |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 67 global judgment | No recovery; no broad cited-theory backfill; select residual-to-Gronwall bridge. | cycle-66 accepted route; cycle-62 guided/general route | `ASTIS.SALD.guided_general.cycle67_global_phase_judgment` | `appendix.tex:619-951` | cycle 67 handoff | obligation |
| Cycle 67 five-backend check | Recheck Gronwall, DV, LSI/KL/FI, continuous FP/KL derivative, and downstream EM FP before lower work. | five slow interfaces; cycle-64 analytic ledger; cycle-66 route context | `ASTIS.SALD.guided_general.cycle67_five_backend_check` | first-DAG sources plus `appendix.tex:619-951` | six theorem skeletons | obligation |
| Cycle 67 guided residual route | Wire normalizer derivative and centered residual identity without changing the proposition. | guided residual contract and obligations | `ASTIS.SALD.guided_general.cycle67_guided_residual_route` | `appendix.tex:619-704` | `prop:guided_path_residual`; unified route | obligation |
| Cycle 67 general moving-target route | Wire derivative, LSI, DV, Gronwall, and pure contraction without changing theorem constants. | continuous general derivative; residual DV; Gronwall side conditions | `ASTIS.SALD.guided_general.cycle67_general_moving_target_route` | `appendix.tex:724-945` | `thm:general-moving-target-SALD`; unified/discrete reuse | obligation |
| Cycle 67 lower packet | Source-cited residual-to-Gronwall bridge from KL derivative through LSI, DV, Gronwall, and pure contraction. | cycle-57/62 residual handoffs; LSI; DV; Gronwall side-condition interfaces | `SALD.cycle67GuidedGeneralResidualGronwallBridgeObligation`; `ASTIS.SALD.guided_general.cycle67_lower_packet.residual_to_gronwall_bridge` | `appendix.tex:765-945` | `thm:general-moving-target-SALD`; cycle 67 middle/lower handoff | obligation |

Lower packet: target exactly
`SALD.cycle67GuidedGeneralResidualGronwallBridgeObligation` /
`sald.general_moving_target.cycle67_residual_to_gronwall_bridge`.
Start by auditing the derivative-to-LSI part of `appendix.tex:765-884`, then
the residual DV instantiation `appendix.tex:885-907`, then the final
Gronwall/pure-contraction display `appendix.tex:908-945`.

## Cycle 67 Middle Guided/General Audit

Middle synchronized the upper route with the Lean-facing theorem contracts and
kept the selected lower packet on the residual-to-Gronwall bridge.  The added
Lean declarations are `SALD.cycle67GuidedGeneralSkeletonMiddleContract` and
`SALD.cycle67GuidedGeneralSkeletonMiddleObligation`
(`sald.guided_general.cycle67_middle_route_audit`).

| Source step | Lean-facing route | Remaining obligation |
|---|---|---|
| `appendix.tex:619-704`: guided residual identity | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.normalizer_derivative`; `sald.guided_path_residual.identity`; `SALD.cycle67GuidedGeneralSkeletonMiddleObligation` | normalizer positivity, differentiation under the integral, boundary integration by parts, quotient/product differentiation, mean-zero residual |
| `appendix.tex:724-744`: continuous general statement | `SALD.generalMovingTargetStatementContract`; `SALD.generalVaSaldContract` | theorem remains `contractOnly`; statement, constants, and source labels unchanged |
| `appendix.tex:765-884`: KL derivative, residual Young, LSI | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; `sald.general_moving_target.kl_derivative`; cycle-57/62 residual scalar handoffs; `SALD.saldLsiKlFiDensityTestContract` | mass conservation, KL differentiation under the integral, Fokker--Planck equation, integration by parts, target transport, sigma/schedule side conditions, LSI density-test backend |
| `appendix.tex:885-907`: residual DV | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `sald.general_moving_target.dv_m_energy`; `SALD.cycle67GuidedGeneralResidualGronwallBridgeObligation` | common space, absolute continuity, finite KL, measurability, finite log-mgf, positive-alpha division for `Z=alpha*||m_t||^2` |
| `appendix.tex:908-945`: Gronwall and pure contraction | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_side_conditions`; `sald.general_moving_target.pure_contraction`; `SALD.cycle67GuidedGeneralResidualGronwallBridgeObligation` | endpoint rewrites, coefficient regularity, endpoint-safe Gronwall, exponent splitting, zero-residual alpha-complexity |
| `appendix.tex:949-951`: unified reuse | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.specialization` | downstream specialization only; no direct VA-SALD proof route |

Cycle 67 lower proof-producing slice:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:765-907`: from the supplied raw KL residual split through residual Young, LSI half-Fisher comparison, inverse-schedule time change, and DV residual-energy input with `Z=alpha*||m_t||^2`, derive the exact differential inequality coefficient used by the Gronwall interface. | `SALD.generalMovingTargetResidualToGronwallBridgeScalar`; `SALD.cycle67GuidedGeneralResidualGronwallLowerObligation` | formalized local Real/order wrapper plus obligation |

The wrapper does not prove the continuous Fokker--Planck/KL derivative,
integration by parts, target transport, residual Young analytic estimate,
LSI/KL/FI density-test theorem, DV finite-log-mgf/common-space hypotheses,
endpoint-safe Gronwall, endpoint rewrites, or pure-contraction normalization.

Proof-DAG addition:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 67 middle route audit | Verify `appendix.tex:619-951` in source order and hand lower work to the residual-to-Gronwall bridge. | cycle-67 upper route; guided residual, derivative, LSI, DV, Gronwall, pure-contraction, unified, and EM interfaces | `SALD.cycle67GuidedGeneralSkeletonMiddleContract`; `SALD.cycle67GuidedGeneralSkeletonMiddleObligation`; `ASTIS.SALD.guided_general.cycle67_middle_route_audit` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; cycle 67 lower packet | obligation |
| Cycle 67 lower residual-to-Gronwall bridge | Compile the local scalar wrapper that turns the supplied residual derivative/LSI/DV inputs into the exact Gronwall differential inequality. | cycle-57 residual split; cycle-62 scaled residual handoff; LSI/DV interfaces; cycle-67 bridge obligation | `SALD.generalMovingTargetResidualToGronwallBridgeScalar`; `SALD.cycle67GuidedGeneralResidualGronwallLowerObligation`; `ASTIS.SALD.guided_general.cycle67_lower_packet.residual_to_gronwall_bridge` | `appendix.tex:765-907` | `sald.general_moving_target.cycle67_residual_to_gronwall_bridge`; `thm:general-moving-target-SALD` | formalized local wrapper plus obligation |

Reviewer checklist:

- `SALD.guidedResidualContract`, `SALD.generalVaSaldContract`, and
  `SALD.unifiedForwardKlContract` list
  `SALD.cycle67GuidedGeneralSkeletonMiddleObligation` while remaining
  `contractOnly`.
- `SALD.generalVaSaldProofDag` contains
  `ASTIS.SALD.guided_general.cycle67_middle_route_audit` before the selected
  residual-to-Gronwall lower packet.
- `SALD.saldDependenciesForLabel` includes
  `SALD.cycle67GuidedGeneralSkeletonMiddleContract`,
  `SALD.cycle67GuidedGeneralSkeletonMiddleObligation`, and
  `sald.guided_general.cycle67_middle_route_audit` for
  `prop:guided_path_residual`, `thm:general-moving-target-SALD`, and
  `thm:unified-forward-KL`.
- No theorem statement, source constant, source label, analytic backend status,
  theorem status, or SLT reuse status is promoted.

No theorem statement, source label, coefficient, theorem status, SLT reuse
status, or analytic backend status changed.

## Cycle 68 Upper Unified/Discrete General Route

Global phase judgment: cycle 67 passed reviewer/build, so no recovery is
needed. Phase 1 theorem-skeleton translation is stable enough to finish the
`thm:unified-forward-KL` and
`thm:general-moving-target-SALD-discrete` route before any cited-theory
backfill. The single lower packet that best reduces remaining proof risk is
`SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeObligation` /
`sald.unified_discrete_general.cycle68_discrete_general_bridge`, covering the
unified specialization and the discrete general EM/derivative/DV/Gronwall
bridge over `main_body.tex:359-395`, `appendix.tex:949-951`, and
`appendix.tex:1313-1603`.

Lean-facing update:

- `SALD.cycle68UnifiedDiscreteGeneralSkeletonUpperPacket` records the upper
  objective, mode discipline, non-goals, lower packet, and reviewer checklist.
- `SALD.cycle68UnifiedDiscreteGeneralSkeletonObligation`
  (`sald.unified_discrete_general.cycle68_upper_route`) is listed by
  `SALD.unifiedForwardKlContract` and `SALD.generalVaSaldDiscreteContract`,
  which both remain `contractOnly`.
- `SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeObligation`
  (`sald.unified_discrete_general.cycle68_discrete_general_bridge`) is the
  selected lower packet and remains an obligation-level source-cited bridge.
- `SALD.generalMovingTargetDiscreteGronwallDisplayBridgeScalar` and
  `SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeLowerObligation` compile
  the lower scalar/display handoff from the named Gronwall input plus a
  supplied Gronwall result to the theorem endpoint inequality.
- `SALD.cycle68UnifiedDiscreteGeneralDag` is included in
  `SALD.generalVaSaldProofDag` and `SALD.generalVaSaldDiscreteProofDag`.
- `SALD.cycle68UnifiedDiscreteGeneralDependencyNames` is included by
  `SALD.saldDependenciesForLabel` for `thm:unified-forward-KL` and
  `thm:general-moving-target-SALD-discrete`.

Five-interface check:

| Backend | Lean-facing interface | Status |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallEndpointCalculusContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `SALD.generalMovingTargetDiscreteGronwallInstantiationContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; cycle-59/67 wrappers | obligation |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `sald.general_moving_target_discrete.dv_m_energy` | source-cited plus obligations |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `probability.lsi_to_kl_fi` | obligation |
| continuous KL derivative/Fokker--Planck | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; `sald.general_moving_target.kl_derivative`; cycle-67 residual-to-Gronwall handoffs | obligation, reused by unified specialization |
| EM interpolation FP | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; cycle-63 endpoint helpers; cycle-64 conditional-drift interface; `sald.general_moving_target_discrete.em_interpolation_fp` | obligation |

Source-to-Lean route:

| Source step | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:359-368` and `appendix.tex:949-951` unified specialization | `SALD.guidedResidualIdentityContract`; `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.transport_velocity_bridge`; `sald.unified_forward_kl.specialization`; cycle-67 continuous general route | correction-field regularity, transport bridge, and continuous general theorem obligations remain |
| `appendix.tex:1313-1347` discrete general statement/display | `SALD.generalMovingTargetDiscreteStatementContract`; `SALD.generalVaSaldDiscreteContract`; `SALD.cycle68UnifiedDiscreteGeneralSkeletonObligation` | theorem remains `contractOnly`; display constants unchanged |
| `appendix.tex:1354-1387` EM endpoint and conditional FP | cycle-63 endpoint-law helpers; `SALD.generalMovingTargetDiscreteConditionalDriftContract`; `SALD.cycle64GeneralMovingTargetDiscreteConditionalDriftLowerObligation`; `sald.general_moving_target_discrete.em_interpolation_fp` | regular conditional law, density/AC, weak FP, KL derivative setup |
| `appendix.tex:1455-1531` frozen delta, Young, and LSI | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.frozen_delta_cross_lip`; `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | frozen-delta analytic lemma, LSI density-test backend, coefficient side conditions |
| `appendix.tex:1544-1557` residual DV | `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `sald.general_moving_target_discrete.dv_m_energy` | common-space, AC, finite KL/log-mgf, measurability, positive alpha for `Z=alpha*||m_t||^2` |
| `appendix.tex:1573-1603` time change and Gronwall/display | `SALD.generalMovingTargetDiscretePointwiseGronwallInputOfPostDvTimeChanged`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `SALD.generalMovingTargetDiscreteGronwallNamedCoefficientInput`; `SALD.generalMovingTargetDiscreteGronwallEndpointRewriteScalar`; `SALD.generalMovingTargetDiscreteGronwallDisplayBridgeScalar` | endpoint stitching, coefficient regularity, endpoint-safe Gronwall, and analytic theorem-display inputs remain obligations |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 68 global judgment | No recovery; finish unified/discrete-general route before cited-theory backfill; select the discrete general theorem bridge. | cycle-67 guided/general route; cycle-63 unified/discrete route | `ASTIS.SALD.unified_discrete_general.cycle68_global_phase_judgment` | `main_body.tex:359-395`; `appendix.tex:1313-1603` | cycle 68 handoff | obligation |
| Cycle 68 five-backend check | Recheck Gronwall, DV, LSI/KL/FI, continuous derivative, and EM endpoint/conditional-FP before lower work. | five slow interfaces; cycle-67 continuous route; cycle-63/64 EM route data | `ASTIS.SALD.unified_discrete_general.cycle68_five_backend_check` | first-DAG sources plus `appendix.tex:1354-1603` | six theorem skeletons | obligation |
| Cycle 68 unified route | Wire unified forward-KL through guided residual, correction-field transport, and continuous general specialization. | cycle-67 route; unified specialization contract | `ASTIS.SALD.unified_discrete_general.cycle68_unified_route` | `main_body.tex:359-395`; `appendix.tex:949-951` | `thm:unified-forward-KL` | obligation |
| Cycle 68 discrete theorem route | Wire discrete general theorem through EM, frozen-delta, KL derivative/LSI, residual DV, time change, and Gronwall/display interfaces. | cycle-63/64 EM route; discrete derivative and Gronwall contracts | `ASTIS.SALD.general_moving_target_discrete.cycle68_theorem_route` | `appendix.tex:1313-1603` | `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 68 middle route audit | Verify the unified specialization and discrete general theorem route in source order, then keep lower work on the source-cited bridge. | cycle-68 upper route; cycle-67 continuous route; cycle-63/64 EM route data | `SALD.cycle68UnifiedDiscreteGeneralSkeletonMiddleContract`; `SALD.cycle68UnifiedDiscreteGeneralSkeletonMiddleObligation`; `ASTIS.SALD.unified_discrete_general.cycle68_middle_route_audit` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete`; cycle 68 lower handoff | obligation |
| Cycle 68 lower packet | Source-cited bridge from unified specialization and discrete general EM/KL derivative route through residual DV and final Gronwall/display matching, with the final scalar/display wrapper compiled under an explicit Gronwall hypothesis. | cycle-67 continuous route; cycle-63/64 EM interfaces; discrete DV/Gronwall contracts; cycle-59 display wrappers | `SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeObligation`; `SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeLowerObligation`; `SALD.generalMovingTargetDiscreteGronwallDisplayBridgeScalar`; `ASTIS.SALD.unified_discrete_general.cycle68_lower_packet.discrete_general_bridge` | `main_body.tex:359-395`; `appendix.tex:949-1603` | cycle 68 middle/lower handoff | obligation |

Lower packet: target exactly
`SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeObligation` /
`sald.unified_discrete_general.cycle68_discrete_general_bridge`.  First verify
the unified specialization, then the EM endpoint/conditional-FP layer, then
the frozen-delta/LSI/residual-DV derivative route, and finally the
Gronwall/display side conditions. Lower has now compiled only the final
display handoff, `SALD.generalMovingTargetDiscreteGronwallDisplayBridgeScalar`;
the Gronwall result and analytic hypotheses are still supplied externally. If
blocked, sharpen the named source-cited interface only; do not change theorem
statements, constants, labels, or statuses.

No theorem statement, source label, coefficient, theorem status, SLT reuse
status, or analytic backend status changed.

## Cycle 68 Middle Unified/Discrete General Audit

Middle synchronized the cycle-68 upper route into
`SALD.cycle68UnifiedDiscreteGeneralSkeletonMiddleContract`,
`SALD.cycle68UnifiedDiscreteGeneralSkeletonMiddleObligation`, and DAG node
`ASTIS.SALD.unified_discrete_general.cycle68_middle_route_audit`.

Source-to-Lean checks:

| Source step | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:359-395`; `appendix.tex:949-951` | `SALD.guidedResidualIdentityContract`; `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.transport_velocity_bridge`; `sald.unified_forward_kl.specialization`; cycle-67 continuous general route | correction-field regularity, transport bridge, continuous general theorem dependencies |
| `appendix.tex:1313-1387` | `SALD.generalMovingTargetDiscreteStatementContract`; cycle-63 endpoint-law helpers; `SALD.generalMovingTargetDiscreteConditionalDriftContract`; `SALD.cycle64GeneralMovingTargetDiscreteConditionalDriftLowerObligation`; `sald.general_moving_target_discrete.em_interpolation_fp` | common space, regular conditional law, density/AC, weak Fokker--Planck, KL derivative setup |
| `appendix.tex:1389-1511` | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteFrozenResidualAlgebraVector`; cycle-28 Young/Fisher scalar helpers; `sald.general_moving_target_discrete.frozen_delta_cross_lip`; `sald.general_moving_target_discrete.kl_derivative` | frozen-delta analytic lemma, concrete field identifications, KL derivative backend |
| `appendix.tex:1513-1570` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi`; `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`; `sald.general_moving_target_discrete.dv_m_energy` | LSI density-test backend, DV common-space/AC/finite-KL/finite-log-mgf witnesses |
| `appendix.tex:1573-1600`; display `appendix.tex:1316-1347` | `SALD.generalMovingTargetDiscreteDerivativeDvTimeChangedScalar`; `SALD.generalMovingTargetDiscretePointwiseGronwallInputOfPostDvTimeChanged`; `SALD.generalMovingTargetDiscreteGronwallInstantiationContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; cycle-59 display wrappers; `SALD.generalMovingTargetDiscreteGronwallDisplayBridgeScalar` | endpoint stitching, coefficient regularity, endpoint-safe Gronwall, and analytic theorem-display inputs remain obligations |

`SALD.unifiedForwardKlContract` and
`SALD.generalVaSaldDiscreteContract` now list the cycle-68 middle obligation,
while both theorem contracts remain `contractOnly`.  The lower packet remains
`SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeObligation` /
`sald.unified_discrete_general.cycle68_discrete_general_bridge`; lower added
`SALD.cycle68UnifiedDiscreteGeneralDiscreteBridgeLowerObligation` for the
compiled scalar/display handoff only.  No broad SLT/SDE import or
theorem-status promotion was performed.

## Cycle 66 Middle Discrete Forward-KL Audit

Middle synchronized the upper cycle-66 route with the Lean proof DAG and
theorem contract.  The new Lean-facing declarations are
`SALD.cycle66DiscreteForwardKlSkeletonMiddleContract` and
`SALD.cycle66DiscreteForwardKlSkeletonMiddleObligation`
(`sald.discrete_forward_kl.cycle66_middle_route_audit`).  They audit the same
source windows as the upper packet, keep the statement fixed, and keep the
selected lower backend on `sald.discrete_forward_kl.accumulated_error_bridge`
over `appendix.tex:557-592` plus `main_body.tex:309-323`.

Source-to-Lean route:

| Source step | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:299-323` theorem display | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract`; cycle-66 upper and middle obligations | theorem remains `contractOnly`; constants, alpha ranges, source labels, and linear-slowdown display unchanged |
| `appendix.tex:260-385` EM interpolation and conditional FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_endpoint_laws`; `sald.discrete_forward_kl.conditional_drift_density`; `sald.discrete_forward_kl.em_conditional_fokker_planck` | Brownian/EM construction, regular conditional drift, density/AC, weak FP, endpoint stitching |
| `appendix.tex:388-491` KL derivative, frozen defect, LSI | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.frozenDeltaCrossLipSaldContract`; `SALD.saldLsiKlFiDensityTestContract`; cycle-51 scalar handoff | analytic KL derivative, frozen-defect specialization, LSI/KL/FI backend |
| `appendix.tex:493-523` DV velocity step | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_velocity_bound` | common space, AC, finite KL, finite log-mgf, selected-test measurability |
| `appendix.tex:526-553` time-changed Gronwall input | `SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`; `SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged`; `SALD.discreteForwardKlGronwallInstantiationContract` | endpoint-safe Gronwall theorem and stitched regularity remain obligations |
| `appendix.tex:557-592`; `main_body.tex:309-323` Gronwall output and accumulated display | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `SALD.discreteForwardKlResidualIntegralDisplayBoundScalar`; `sald.discrete_forward_kl.accumulated_error_bridge` | endpoint rewrites, exponent split, residual exponent bound, `barGamma`/`barDelta` source identifications |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 66 middle route audit | Verify the post-cycle-65 discrete route in paper order and keep lower work on the accumulated-error bridge. | cycle-66 upper route; cycle-65 continuous route context; cycle-61 recovered discrete route; cycle-56 Gronwall input | `SALD.cycle66DiscreteForwardKlSkeletonMiddleContract`; `SALD.cycle66DiscreteForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle66_middle_route_audit` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete`; cycle 66 lower handoff | obligation |

`SALD.discreteSaldContract`, `SALD.discreteForwardKlProofDag`, and
`SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` now include the
cycle-66 middle audit.  Gronwall, DV, LSI/KL/FI, continuous
Fokker--Planck/KL derivative, EM interpolation, theorem status, and SLT reuse
remain below `formalized`.

## Cycle 62 Upper Guided/General Route After Discrete Recovery

Global phase judgment: cycle 61 passed reviewer/build, so no failed-cycle
recovery is needed.  Phase 1 theorem-skeleton translation is not yet stable
enough for cited-theory backfill because the guided residual and continuous
general moving-target route still needs synchronization after the discrete
forward-KL recovery.  The single lower packet is an `appendix.tex:619-951`
guided-residual-to-general-moving-target route audit that narrows later
proof-producing work to `sald.general_moving_target.kl_derivative`.

Lean-facing update:

- `SALD.cycle62GuidedGeneralSkeletonUpperPacket` records the upper objective,
  mode discipline, non-goals, lower packet, and reviewer checklist.
- `SALD.cycle62GuidedGeneralSkeletonObligation`
  (`sald.guided_general.cycle62_upper_route`) wires
  `prop:guided_path_residual` and `thm:general-moving-target-SALD` to the
  already named interfaces after the accepted cycle-61 discrete route.
- `SALD.cycle62GuidedGeneralSkeletonMiddleContract`
  and `SALD.cycle62GuidedGeneralSkeletonMiddleObligation`
  (`sald.guided_general.cycle62_middle_route_audit`) verify the source order,
  keep both theorem statements fixed, and leave the lower proof-producing
  target at `sald.general_moving_target.kl_derivative`.
- `SALD.cycle62GuidedGeneralSkeletonDag` adds
  `ASTIS.SALD.guided_general.cycle62_global_phase_judgment`,
  `ASTIS.SALD.guided_general.cycle62_five_backend_check`,
  `ASTIS.SALD.guided_general.cycle62_upper_route`,
  `ASTIS.SALD.guided_general.cycle62_middle_route_audit`, and
  `ASTIS.SALD.guided_general.cycle62_lower_packet.route_audit`, plus the
  lower scalar node
  `ASTIS.SALD.general_moving_target.cycle62_scaled_residual_lower`.

Five-interface check:

| Interface | Lean-facing consumer | Status |
|---|---|---|
| Gronwall endpoint/FTC/coefficient interface | `SALD.saldGronwallEndpointCalculusContract`; `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract` | obligation |
| DV common-space and finite-log-mgf | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract` | source-cited plus obligations |
| LSI/KL/FI density-test bridge | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous Fokker-Planck/KL derivative identity | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative` | obligation |
| EM endpoint/conditional-law Fokker-Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.em_interpolation_fp` | downstream obligation |

Source-to-Lean route:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `thm:forward-KL` | cycle-60 continuous route and `sald.forward_kl.kl_derivative` | theorem remains `contractOnly`; derivative backend remains obligation |
| `thm:forward-KL-discrete` | cycle-61 recovered discrete route and accumulated-error bridge | theorem remains `contractOnly`; EM/FP, Gronwall, and accumulation backends remain obligations |
| `appendix.tex:619-704`: guided residual identity | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.normalizer_derivative`; `sald.guided_path_residual.identity` | normalizer positivity, differentiation under the integral, integration by parts, quotient/product differentiation, mean-zero residual |
| `appendix.tex:724-945`: continuous general moving-target theorem | `SALD.generalMovingTargetStatementContract`; `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.saldLsiKlFiDensityTestContract`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetGronwallSideConditionContract` | Fokker-Planck/KL derivative, LSI density-test, residual DV witnesses, Gronwall side conditions, pure contraction |
| `appendix.tex:813-835`: target-transport scaling and residual sign | `SALD.generalMovingTargetKlDerivativeScaledResidualDisplayScalar`; `SALD.cycle62GuidedGeneralScaledResidualLowerObligation`; `ASTIS.SALD.general_moving_target.cycle62_scaled_residual_lower` | formalized scalar sign/scale handoff after analytic target transport, integration by parts, and residual pairing inputs are supplied |
| `appendix.tex:949-951`: unified theorem reuse | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.specialization` | correction-field bridge and continuous general theorem obligations |
| `thm:general-moving-target-SALD-discrete` | existing general EM, frozen-delta, derivative/LSI/DV, and Gronwall interfaces | downstream theorem remains `contractOnly`; EM conditional-law and Gronwall-display backends remain obligations |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 62 global judgment | Records no recovery from cycle 61, no broad cited-theory backfill yet, and the single guided/general lower packet. | cycle-61 route; cycle-57 guided/general route | `ASTIS.SALD.guided_general.cycle62_global_phase_judgment` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD` | obligation |
| Cycle 62 five-backend check | Verifies Gronwall, DV, LSI/KL/FI, continuous derivative, and EM interpolation interfaces before lower work. | cycle-59 ledger; named guided/general contracts | `ASTIS.SALD.guided_general.cycle62_five_backend_check` | `appendix.tex:619-951`; downstream EM sources | all six first-DAG theorem consumers | obligation |
| Cycle 62 upper route | Wires guided residual and continuous general theorem to the existing source-cited or obligation interfaces. | cycle-61 discrete recovery; cycle-57 route; guided residual, derivative, LSI, DV, Gronwall, pure-contraction interfaces | `SALD.cycle62GuidedGeneralSkeletonObligation`; `ASTIS.SALD.guided_general.cycle62_upper_route` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; `thm:unified-forward-KL` | obligation |
| Cycle 62 middle route audit | Checks the source proof order and confirms every guided/general step maps to an existing Lean-facing interface or obligation. | cycle-62 upper route; cycle-61 discrete recovery; cycle-57 derivative split lower; guided residual, derivative, LSI, DV, Gronwall, pure contraction, unified specialization, and EM reuse interfaces | `SALD.cycle62GuidedGeneralSkeletonMiddleContract`; `SALD.cycle62GuidedGeneralSkeletonMiddleObligation`; `ASTIS.SALD.guided_general.cycle62_middle_route_audit` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; cycle 62 lower derivative packet | obligation |
| Cycle 62 lower packet | After the middle audit, target the continuous general KL derivative backend over `appendix.tex:765-884`. | `SALD.generalMovingTargetDerivativeCandidateContract`; cycle-57 derivative split lower; LSI and schedule obligations | `ASTIS.SALD.guided_general.cycle62_lower_packet.route_audit` | lower slice `appendix.tex:765-884` | `sald.general_moving_target.kl_derivative`; `thm:general-moving-target-SALD` | obligation |
| Cycle 62 lower scaled residual core | Converts supplied `c_t` and `v_t` pairings with `tilde v_s=dot{t}(s)v_{t(s)}` and `m_t=v_t-c_t` into the paper display `-(sigma^2/2)FI-dot{t}(s)<m,A>`. | target-transport scaling, residual pairing, cycle-57 raw KL split | `SALD.generalMovingTargetKlDerivativeScaledResidualDisplayScalar`; `SALD.cycle62GuidedGeneralScaledResidualLowerObligation`; `ASTIS.SALD.general_moving_target.cycle62_scaled_residual_lower` | `appendix.tex:813-835` | `sald.general_moving_target.kl_derivative`; `thm:general-moving-target-SALD` | formalized scalar core plus obligation |

Lower packet: after this middle route audit, target exactly
`SALD.generalMovingTargetDerivativeCandidateContract` /
`SALD.generalMovingTargetDerivativeObligation` /
`sald.general_moving_target.kl_derivative` over `appendix.tex:765-884`.
Cycle 62 lower has now completed the scalar `appendix.tex:813-835` sign/scale
wrapper, so the remaining derivative work is the analytic Fokker-Planck/KL,
target-transport, Young, LSI, and schedule backends.  Do not work on residual
DV, Gronwall, pure contraction, unified specialization, or downstream EM
interpolation until the derivative route is synchronized.

No theorem statement, source label, source coefficient, theorem status, SLT
reuse status, or analytic backend status changed.

## Cycle 63 Upper Unified/Discrete General Route

Global phase judgment: cycle 62 passed reviewer/build and does not need
recovery.  Phase 1 theorem-skeleton translation is stable enough to rewire
`thm:unified-forward-KL` and
`thm:general-moving-target-SALD-discrete` through the accepted
continuous/general skeletons and then begin exactly one narrow measure-theory
backfill.  The single lower packet is the discrete general EM endpoint/common
space layer, narrowed to paired `Measure.map` equality from componentwise
almost-everywhere endpoint identities over `appendix.tex:1354-1387`.

Lean-facing update:

- `SALD.cycle63UnifiedDiscreteGeneralSkeletonUpperPacket` records the upper
  objective, mode discipline, non-goals, lower packet, and reviewer checklist.
- `SALD.cycle63UnifiedDiscreteGeneralSkeletonObligation`
  (`sald.unified_discrete_general.cycle63_upper_route`) wires
  `thm:unified-forward-KL` through guided residual, correction-field
  transport, and the continuous general theorem, and wires
  `thm:general-moving-target-SALD-discrete` through the general EM,
  frozen-delta, derivative/LSI, residual DV, Gronwall, and display interfaces.
- `SALD.cycle63UnifiedDiscreteGeneralMiddleContract` and
  `SALD.cycle63UnifiedDiscreteGeneralMiddleObligation`
  (`sald.unified_discrete_general.cycle63_middle_route_audit`) verify the
  route in paper order and hand off the post-endpoint conditional-law /
  Fokker--Planck backend over `appendix.tex:1358-1387`.
- `AutoSamplingTheory.lawMapProdEqOfAEEq` and
  `AutoSamplingTheory.lawMapProdFst` / `AutoSamplingTheory.lawMapProdSnd` are
  the proof-producing endpoint-law backfill: componentwise a.e. equality
  implies equality of paired `Measure.map` pushforward laws, and measurable
  projections recover each marginal endpoint law.
- `SALD.generalMovingTargetDiscreteEmJointEndpointMeasureMapOfNamedInterpolation`
  and
  `SALD.generalMovingTargetDiscreteEmJointEndpointMarginalLawsOfNamedInterpolation`
  package the named EM endpoint identities into those helpers.
- `SALD.cycle63UnifiedDiscreteGeneralMeasureBackfillObligation` records that
  this is local endpoint-law bookkeeping only, guided by SLT `Measure.map` and
  a.e.-equality patterns but importing no SLT theorem.
- `SALD.cycle63UnifiedDiscreteGeneralDag` adds global judgment,
  five-backend check, upper route, middle audit, and paired endpoint-law
  backfill rows.

Five-interface check:

| Interface | Lean-facing consumer | Status |
|---|---|---|
| Gronwall endpoint/FTC/coefficient interface | `SALD.saldGronwallEndpointCalculusContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract` | obligation |
| DV common-space and finite-log-mgf | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| LSI/KL/FI density-test bridge | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous Fokker-Planck/KL derivative identity | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.cycle62GuidedGeneralScaledResidualLowerObligation`; `sald.general_moving_target.kl_derivative` | obligation with scalar handoff |
| EM endpoint/conditional-law Fokker-Planck | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation`; `SALD.generalMovingTargetDiscreteEmJointEndpointMeasureMapOfNamedInterpolation`; `SALD.generalMovingTargetDiscreteEmJointEndpointMarginalLawsOfNamedInterpolation`; `AutoSamplingTheory.lawMapProdEqOfAEEq`; `AutoSamplingTheory.lawMapProdFst`; `AutoSamplingTheory.lawMapProdSnd`; `sald.general_moving_target_discrete.em_interpolation_fp` | obligation with local endpoint-law backfill |

Source-to-Lean route:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `thm:forward-KL` | cycle-60 continuous route and `sald.forward_kl.kl_derivative` | theorem remains `contractOnly`; derivative backend remains obligation |
| `thm:forward-KL-discrete` | cycle-61 recovered route and accumulated-error bridge | theorem remains `contractOnly`; EM/FP, Gronwall, and accumulation backends remain obligations |
| `prop:guided_path_residual` and `thm:general-moving-target-SALD` | cycle-62 guided/general route and scaled residual lower handoff | guided residual calculus, continuous derivative, residual DV, Gronwall, and pure contraction remain obligations |
| `main_body.tex:359-395`; `appendix.tex:949-951` | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.transport_velocity_bridge`; `sald.unified_forward_kl.specialization` | correction-field regularity and continuous general theorem obligations |
| `appendix.tex:1313-1603` | `SALD.generalMovingTargetDiscreteStatementContract`; EM endpoint/conditional-FP; frozen-delta; derivative/LSI; residual DV; Gronwall/display interfaces | discrete theorem remains `contractOnly`; analytic backends remain obligations |
| `appendix.tex:1354-1357` | `AutoSamplingTheory.lawMapProdEqOfAEEq`; `AutoSamplingTheory.lawMapProdFst`; `AutoSamplingTheory.lawMapProdSnd`; `SALD.generalMovingTargetDiscreteEmJointEndpointMeasureMapOfNamedInterpolation`; `SALD.generalMovingTargetDiscreteEmJointEndpointMarginalLawsOfNamedInterpolation`; `SALD.cycle63UnifiedDiscreteGeneralMeasureBackfillObligation` | formalized paired endpoint-law and marginal projection helpers |
| `appendix.tex:1358-1387` | `SALD.cycle63UnifiedDiscreteGeneralMiddleObligation`; `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `sald.general_moving_target_discrete.em_interpolation_fp` | conditional-law, density/AC, weak FP, and KL derivative setup remain obligations |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 63 global judgment | No cycle-62 recovery; route unified/discrete general; allow one endpoint-law measure backfill. | cycle-62 guided/general route; cycle-58 unified/discrete route | `ASTIS.SALD.unified_discrete_general.cycle63_global_phase_judgment` | `main_body.tex:359-395`; `appendix.tex:1313-1603` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 63 five-backend check | Recheck Gronwall, DV, LSI/KL/FI, continuous derivative, and EM interpolation interfaces before lower work. | cycle-59 ledger; cycle-62 route; EM endpoint-law handoffs | `ASTIS.SALD.unified_discrete_general.cycle63_five_backend_check` | first-DAG sources plus `appendix.tex:1354-1387` | all six theorem nodes | obligation |
| Cycle 63 upper route | Wire unified forward-KL through continuous general reuse and discrete general through EM/frozen-delta/LSI/DV/Gronwall interfaces. | guided residual; correction bridge; continuous general theorem; discrete general side-condition contracts | `SALD.cycle63UnifiedDiscreteGeneralSkeletonObligation`; `ASTIS.SALD.unified_discrete_general.cycle63_upper_route` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 63 middle route audit | Verify the upper route in source order, keep the paired endpoint-law helper scoped, and select the conditional-law/Fokker--Planck backend as the next lower packet. | cycle-63 upper route; cycle-62 guided/general route; endpoint-law backfill; five slow interfaces | `SALD.cycle63UnifiedDiscreteGeneralMiddleContract`; `SALD.cycle63UnifiedDiscreteGeneralMiddleObligation`; `ASTIS.SALD.unified_discrete_general.cycle63_middle_route_audit` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603`; lower slice `appendix.tex:1358-1387` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete`; cycle 63 lower packet | obligation |
| Cycle 63 paired endpoint-law backfill | From componentwise a.e. endpoint identities, derive equality of paired `Measure.map` pushforward laws on the common space, then recover both marginal endpoint laws by projection. | `AutoSamplingTheory.lawMapEqOfAEEq`; existing endpoint-law handoffs; local SLT Measure.map/a.e. style patterns | `AutoSamplingTheory.lawMapProdEqOfAEEq`; `AutoSamplingTheory.lawMapProdFst`; `AutoSamplingTheory.lawMapProdSnd`; `SALD.generalMovingTargetDiscreteEmJointEndpointMeasureMapOfNamedInterpolation`; `SALD.generalMovingTargetDiscreteEmJointEndpointMarginalLawsOfNamedInterpolation`; `SALD.cycle63UnifiedDiscreteGeneralMeasureBackfillObligation`; `ASTIS.SALD.general_moving_target_discrete.cycle63_joint_endpoint_law_backfill` | `appendix.tex:1354-1357` | `sald.general_moving_target_discrete.em_interpolation_fp`; `thm:general-moving-target-SALD-discrete` | formalized local measure helper plus obligation |

No theorem statement, source label, source coefficient, theorem status, slow
analytic backend status, or SLT reuse status changed.

## Cycle 61 Upper Discrete Forward-KL Recovery

Global phase judgment: cycle 60 passed reviewer/build, so no previous-cycle
failure needs recovery.  Phase 1 theorem-skeleton translation is stable enough
to recover the interrupted cycle-56 discrete theorem route, but not broad
cited-theory or reusable API backfill.  The single lower packet that best
reduces remaining risk is
`SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
`SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
`sald.discrete_forward_kl.accumulated_error_bridge`, reusing the cycle-56
pointwise Gronwall input over `appendix.tex:526-592`.

Five slow interfaces checked before lower work:

| Backend | Lean-facing interface | Status |
|---|---|---|
| endpoint-safe Gronwall | `SALD.saldGronwallEndpointCalculusContract`; `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation` | obligation |
| Donsker-Varadhan | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_velocity_bound` | source-cited plus obligations |
| LSI/KL/FI | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| continuous FP/KL derivative reuse | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.cycle60ForwardKlDerivativeRawLowerObligation` | obligation plus scalar wrapper |
| EM interpolation FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | obligation |

Source-to-Lean route for `thm:forward-KL-discrete`:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `main_body.tex:299-323` theorem display | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract`; `SALD.cycle61DiscreteForwardKlSkeletonObligation`; `SALD.cycle61DiscreteForwardKlSkeletonMiddleObligation` | theorem remains `contractOnly` |
| `appendix.tex:260-385` EM interpolation and conditional FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; endpoint-law and conditional-FP obligations | conditional law, density/AC, weak FP, stitching |
| `appendix.tex:388-491` derivative, frozen defect, LSI | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.cycle51DiscreteForwardKlDerivativeLowerObligation`; `SALD.saldLsiKlFiDensityTestContract` | analytic KL derivative, frozen-defect specialization, LSI backend |
| `appendix.tex:493-523` DV velocity | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_velocity_bound` | common-space, AC, measurability, finite log-mgf |
| `appendix.tex:526-592` Gronwall and accumulated-error display | `SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged`; `SALD.discreteForwardKlGronwallInstantiationContract`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract` | endpoint-safe Gronwall, endpoint stitching, residual exponent, `barGamma`/`barDelta` collection |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 61 global judgment | Record cycle-60 pass, narrow Phase 1 recovery, and selected discrete lower packet. | cycle-60 route; cycle-56 route; cycle-56 Gronwall lower | `SALD.cycle61DiscreteForwardKlSkeletonUpperPacket`; `ASTIS.SALD.forward_KL_discrete.cycle61_global_phase_judgment` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete` | obligation |
| Cycle 61 five-backend check | Recheck Gronwall, DV, LSI/KL/FI, continuous FP/KL derivative reuse, and EM interpolation FP before lower work. | cycle-59 ledger; cycle-60 continuous wrapper; discrete EM and Gronwall contracts | `ASTIS.SALD.forward_KL_discrete.cycle61_five_backend_check` | `appendix.tex:47-79`; `main_body.tex:202-215`; `appendix.tex:260-592` | all six SALD theorem skeletons | obligation |
| Cycle 61 recovered theorem route | Consume EM, frozen defect, LSI, DV, cycle-56 pointwise Gronwall input, and accumulated-error bridge in paper order. | cycle-51 derivative route; cycle-56 middle/lower; theorem-specific interfaces | `SALD.cycle61DiscreteForwardKlSkeletonObligation`; `ASTIS.SALD.forward_KL_discrete.cycle61_recovered_theorem_route` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete` | obligation |
| Cycle 61 middle route audit | Verify the recovered route in source order and hand off only the accumulated-error display bridge. | cycle-61 upper route; cycle-56 pointwise Gronwall input; cycle-51 derivative/LSI handoff; EM and DV interfaces | `SALD.cycle61DiscreteForwardKlSkeletonMiddleContract`; `SALD.cycle61DiscreteForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle61_middle_route_audit` | `main_body.tex:299-323`; `appendix.tex:260-592`; lower slice `appendix.tex:557-590` and `main_body.tex:309-323` | `thm:forward-KL-discrete`; cycle 61 lower packet | obligation |
| Cycle 61 lower packet | Refine the Gronwall-output-to-main-display accumulated-error bridge without reproving EM/Fokker--Planck. | cycle-56 pointwise Gronwall input; accumulated-error contract; scalar collection helpers | `SALD.discreteForwardKlResidualIntegralDisplayBoundScalar`; `SALD.cycle61DiscreteForwardKlAccumulatedErrorLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle61_lower_packet.gronwall_accumulated` | `appendix.tex:557-590`; `main_body.tex:309-323` | `sald.discrete_forward_kl.accumulated_error_bridge` | formalized scalar wrapper plus obligation |

Lower packet: target exactly
`SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
`SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
`sald.discrete_forward_kl.accumulated_error_bridge`.  Preserve the theorem
constants `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
`(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`.  Cycle 61 lower
compiled `SALD.discreteForwardKlResidualIntegralDisplayBoundScalar`, which
plugs a supplied common-exponential residual bound into the existing
`A_alpha`/`barDelta` collection scalars.  If blocked, sharpen endpoint,
interval-integrability, coefficient-regularity, barGamma/barDelta,
finite-log-mgf, or stitched-law obligations rather than changing the theorem.

Reviewer checklist: `SALD.discreteSaldContract` lists the cycle-61 obligation;
`SALD.discreteForwardKlProofDag` contains the cycle-61 route and lower-packet
nodes; `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes
cycle-61 names; no slow analytic backend or theorem status is promoted.

Middle synchronization: `SALD.cycle61DiscreteForwardKlSkeletonMiddleContract`
maps `appendix.tex:260-385` to the EM endpoint/conditional-FP obligations,
`appendix.tex:388-491` to the cycle-51 derivative/LSI scalar handoff,
`appendix.tex:493-523` to the discrete DV witness, `appendix.tex:526-553` to
the cycle-56 pointwise Gronwall input, and `appendix.tex:557-590` plus
`main_body.tex:309-323` to the accumulated-error bridge.  The selected lower
packet remains exactly `sald.discrete_forward_kl.accumulated_error_bridge`;
endpoint stitching, residual exponent, `barGamma`/`barDelta`, and the source
identifications for `A_alpha` collection remain obligations, while the final
residual-display scalar wrapper is compiled locally.

## Cycle 59 Analytic Interface Ledger

Global phase judgment: cycle 58 passed reviewer/build, so no failed cycle
needs recovery. Phase 1 theorem-skeleton translation is stable enough for
exactly one narrow cited-theory/SDE backend backfill, not broad SLT or reusable
API work. The single lower packet that reduces the largest remaining proof
risk is still
`sald.general_moving_target_discrete.gronwall_side_conditions` over
`appendix.tex:1573-1600`, because it is the last theorem-display bridge after
the EM derivative/DV handoff.

Lean-facing update:

- `SALD.cycle59MainSkeletonAnalyticInterfaceLedger` records the upper
  objective, phase judgment, five-backend check, theorem route, lower packet,
  and reviewer checklist.
- `SALD.cycle59MainSkeletonAnalyticInterfaceObligation`
  (`sald.main_skeleton.cycle59_analytic_interface_ledger`) is now listed by
  all six theorem contracts while they remain `contractOnly`.
- `SALD.cycle59MainSkeletonAnalyticMiddleContract` and
  `SALD.cycle59MainSkeletonAnalyticMiddleObligation`
  (`sald.main_skeleton.cycle59_middle_interface_audit`) verify the upper
  ledger against the source proof order and keep the lower packet on
  `appendix.tex:1573-1600`.
- `SALD.cycle59MainSkeletonAnalyticInterfaceDag` adds
  `ASTIS.SALD.cycle59.analytic_interface_ledger`,
  `ASTIS.SALD.cycle59.theorem_route_rewire`, and
  `ASTIS.SALD.cycle59.middle_interface_audit`, plus
  `ASTIS.SALD.cycle59.lower_packet.general_discrete_gronwall_side_conditions`.
- Cycle 59 lower added `SALD.generalMovingTargetDiscreteGronwallNamedCoefficientInput`,
  `SALD.generalMovingTargetDiscreteGronwallEndpointRewriteScalar`, and
  `SALD.cycle59GeneralMovingTargetDiscreteGronwallLowerObligation` for the
  local `a(t)`, `b(t)` display match and endpoint rewrite pieces of
  `appendix.tex:1573-1600`.

Five-interface check:

| Interface | Lean-facing consumer | Status |
|---|---|---|
| Gronwall endpoint/FTC/coefficient interface | `SALD.saldGronwallEndpointCalculusContract`; theorem-specific Gronwall side-condition contracts; cycle-36/41 wrappers | obligation |
| DV common-space and finite-log-mgf | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; theorem-specific finite-log-mgf witnesses | source-cited plus obligations |
| LSI/KL/FI density-test bridge | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `probability.lsi_to_kl_fi` | obligation |
| continuous Fokker--Planck/KL derivative | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.generalMovingTargetDerivativeCandidateContract`; cycle-50/52/57 scalar handoffs | obligation |
| EM interpolation endpoint/conditional-law Fokker--Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; cycle-48/53 endpoint handoffs; cycle-54 sigma split; cycle-58 pointwise Gronwall input wrapper; cycle-59 named-coefficient and endpoint-rewrite wrappers | obligation, with only local bookkeeping/helpers formalized |

Theorem route:

| Theorem node | Cycle-59 wiring |
|---|---|
| `thm:forward-KL` | continuous derivative -> LSI -> DV velocity -> endpoint schedule -> Gronwall side conditions |
| `thm:forward-KL-discrete` | EM endpoint/conditional-FP -> frozen defect -> LSI -> DV velocity -> stitched Gronwall -> accumulated error |
| `prop:guided_path_residual` | normalizer derivative -> guided-density derivative -> divergence cancellation -> mean-zero residual |
| `thm:general-moving-target-SALD` | continuous general derivative split -> residual LSI/DV -> sigma-weighted Gronwall -> pure contraction |
| `thm:unified-forward-KL` | guided residual plus correction-field transport bridge, specializing `c_t=u_t` and `m_t=w_t` |
| `thm:general-moving-target-SALD-discrete` | general EM endpoint/conditional-FP -> frozen delta -> discrete KL derivative/LSI -> residual DV -> constant schedule -> cycle-58 pointwise Gronwall input -> final display stitching |

Middle synchronization:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 59 middle interface audit | Check the five-interface ledger against all six theorem consumers in source order, then keep the lower packet on discrete general Gronwall/display side conditions. | cycle-59 upper ledger; cycle-58 unified/discrete middle route; cycle-56 Gronwall recovery; cycle-55 continuous route; cycle-57 guided/general route | `SALD.cycle59MainSkeletonAnalyticMiddleContract`; `SALD.cycle59MainSkeletonAnalyticMiddleObligation`; `ASTIS.SALD.cycle59.middle_interface_audit` | `appendix.tex:47-79`; `main_body.tex:202-215`; `appendix.tex:168-252`; `appendix.tex:260-592`; `appendix.tex:619-951`; `appendix.tex:1313-1603`; lower slice `appendix.tex:1573-1600` | all six theorem contracts; `saldDependenciesForLabel` cycle-59 dependency list | obligation |
| Cycle 59 lower Gronwall/display wrappers | Compile local wrappers for the selected lower packet: turn the cycle-58 pointwise derivative input into named Gronwall `a(t)`, `b(t)` functions, then rewrite a supplied Gronwall endpoint bound to the theorem KL endpoints. | cycle-59 middle audit; cycle-58 pointwise Gronwall input; cycle-20 Gronwall side-condition map; `lem:gronwall` obligation | `SALD.generalMovingTargetDiscreteGronwallNamedCoefficientInput`; `SALD.generalMovingTargetDiscreteGronwallEndpointRewriteScalar`; `SALD.cycle59GeneralMovingTargetDiscreteGronwallLowerObligation` | `appendix.tex:1573-1600`; theorem display `appendix.tex:1316-1347` | `sald.general_moving_target_discrete.gronwall_side_conditions`; `thm:general-moving-target-SALD-discrete` | formalized local wrappers plus obligation |
| Cycle 60 upper continuous forward-KL route | After the accepted cycle-59 ledger, wire the source-cited analytic interfaces into `thm:forward-KL` and select the continuous derivative backend as the lower packet. | cycle-59 ledger and middle audit; cycle-55 continuous route; cycle-50 derivative/DV scalar handoff; five slow analytic interfaces | `SALD.cycle60ForwardKlSkeletonUpperPacket`; `SALD.cycle60ForwardKlSkeletonObligation`; `SALD.cycle60ForwardKlSkeletonDag`; `ASTIS.SALD.forward_KL.cycle60_post_cycle59_route` | `main_body.tex:238-247`; `appendix.tex:164-252`; lower slice `appendix.tex:168-228` | `thm:forward-KL`; `sald.forward_kl.kl_derivative`; downstream discrete forward-KL pattern | obligation |
| Cycle 60 middle continuous forward-KL route audit | Verify the post-cycle-59 upper route in paper order, keep the theorem display fixed, and keep lower work on the continuous KL derivative/Fokker--Planck backend while LSI, DV, Gronwall, and EM stay separate interfaces. | cycle-60 upper route; cycle-59 analytic middle audit; cycle-55 continuous route; cycle-50 derivative/DV scalar handoff; five slow analytic interfaces | `SALD.cycle60ForwardKlSkeletonMiddleContract`; `SALD.cycle60ForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL.cycle60_middle_route_audit` | `main_body.tex:238-247`; `appendix.tex:164-252`; lower slice `appendix.tex:168-228` | `thm:forward-KL`; cycle 60 lower derivative packet | obligation |
| Cycle 60 lower raw derivative wrapper | Start from the raw KL derivative split with the mass term, drop that term using the supplied mass-conservation input, then feed the existing first-term, Young, LSI, velocity-scaling, and inverse-schedule scalar pipeline. | cycle-60 middle route; cycle-55 mass handoff; cycle-39/50 pre-DV scalar route; LSI and schedule obligations | `SALD.forwardKlPreDvDerivativeBoundOfRawKlFiVelocityScalingScalar`; `SALD.cycle60ForwardKlDerivativeRawLowerObligation`; `ASTIS.SALD.forward_KL.cycle60_derivative_raw_lower` | `appendix.tex:168-228` | `sald.forward_kl.kl_derivative`; `thm:forward-KL` | formalized scalar wrapper plus obligation |

Lower packet:

Target exactly `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`
/ `SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` /
`sald.general_moving_target_discrete.gronwall_side_conditions` over
`appendix.tex:1573-1600`. Start with endpoint stitching for
`K(t)=KL(hat rho_{s(t)}||pi_t)`, including `K(0)=KL(rho_0||pi_0)`,
`K(T)=KL(rho_K^eta||pi_T)`, interval compatibility, and constant
inverse-schedule admissibility. Then refine coefficient regularity and exact
display matching for `a(t)` and `b(t)` using the cycle-58 pointwise Gronwall
input wrapper and the cycle-59 named-coefficient wrapper only as local inputs.
The endpoint rewrite from `K(T)`, `K(0)` to the theorem KL endpoints is now
isolated by `SALD.generalMovingTargetDiscreteGronwallEndpointRewriteScalar`;
the endpoint laws that supply those equalities remain obligations.

Reviewer checklist:

- all six theorem contracts list the cycle-59 obligation and remain
  `contractOnly`;
- all four theorem proof DAGs include the cycle-59 DAG pane;
- `saldDependenciesForLabel` includes the cycle-59 dependency names for the
  five slow interfaces and six theorem labels;
- Gronwall, DV, LSI/KL/FI, continuous derivative, EM conditional-FP, theorem
  contracts, and SLT reuse statuses are not promoted;
- `python3 tools/astis.py source-index ASTIS-SALD-001` and
  `python3 tools/astis.py check` pass.

Cycle 59 lower translation:

| Source fragment | Lean declaration | Translation status |
|---|---|---|
| `appendix.tex:1584-1597`: the final derivative inequality has to be handed to `lem:gronwall` with the named source coefficients `a(t)` and `b(t)`. | `SALD.generalMovingTargetDiscreteGronwallNamedCoefficientInput` | formalized local Real/order wrapper; coefficient regularity remains an obligation |
| `appendix.tex:1600` and display `appendix.tex:1316-1347`: after Gronwall, replace `K(T)` and `K(0)` by the theorem KL endpoints. | `SALD.generalMovingTargetDiscreteGronwallEndpointRewriteScalar` | formalized local endpoint-rewrite wrapper; endpoint-law stitching remains an obligation |

## Cycle 60 Upper Continuous Forward-KL Route

Global phase judgment: cycle 59 passed reviewer/build, so no recovery is
needed. Phase 1 theorem-skeleton translation is stable enough for focused
continuous `thm:forward-KL` route wiring, but not for broad cited-theory or
reusable API backfill. The lower packet that best reduces the current proof
risk is exactly `SALD.forwardKlDerivativeCandidateContract` /
`SALD.forwardKlDerivativeObligation` / `sald.forward_kl.kl_derivative` over
`appendix.tex:168-228`.

Source-to-Lean route:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `main_body.tex:238-247`: theorem display with `alpha in (0,alpha0]`, the two exponent factors, and the residual alpha-complexity integral. | `SALD.continuousForwardKlStatementContract`; `SALD.continuousSaldContract`; `SALD.cycle60ForwardKlSkeletonObligation` | theorem remains `contractOnly`; constants and labels unchanged |
| `appendix.tex:168-228`: KL derivative, SALD Fokker-Planck, target transport, Young split, LSI handoff, and inverse schedule. | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `sald.forward_kl.density_boundary_regular`; `sald.forward_kl.schedule_time_change`; `sald.forward_kl.kl_derivative` | selected lower obligation |
| `appendix.tex:210-217`: LSI/KL/FI substitution. | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | density, zero-set convention, admissible test, entropy identity, Fisher chain rule |
| `appendix.tex:230-241`: DV velocity-energy bound. | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `sald.forward_kl.dv_energy_bound` | source-cited DV plus finite-log-mgf/common-space obligations |
| `appendix.tex:244-252`: Gronwall and final display split. | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract`; `sald.forward_kl.gronwall_side_conditions`; `sald.forward_kl.gronwall_application` | endpoint, coefficient, interval-integrability, and exponent side conditions |
| downstream discrete sibling backend | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | visible obligation only; it does not alter the continuous theorem |

The cycle-60 DAG nodes are
`ASTIS.SALD.forward_KL.cycle60_post_cycle59_route`,
`ASTIS.SALD.forward_KL.cycle60_middle_route_audit`,
`ASTIS.SALD.forward_KL.cycle60_five_backend_check`, and
`ASTIS.SALD.forward_KL.cycle60_lower_packet.kl_derivative`; lower now also
adds `ASTIS.SALD.forward_KL.cycle60_derivative_raw_lower`.  No analytic
backend, theorem contract, SLT reuse entry, or source statement is promoted.

## Cycle 60 Middle Continuous Forward-KL Route Audit

Middle synchronized the post-cycle-59 upper route into
`SALD.cycle60ForwardKlSkeletonMiddleContract`,
`SALD.cycle60ForwardKlSkeletonMiddleObligation`, and DAG node
`ASTIS.SALD.forward_KL.cycle60_middle_route_audit`.

Source-to-Lean checks:

| Source block | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:238-247` | `SALD.continuousForwardKlStatementContract`; `SALD.continuousSaldContract`; cycle-60 upper and middle obligations | theorem remains `contractOnly`; constants, labels, and alpha range unchanged |
| `appendix.tex:168-228` | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlDerivativeObligation`; `sald.forward_kl.kl_derivative` | selected lower backend: mass conservation, KL differentiation, SALD Fokker--Planck, boundary integration by parts, target transport, and inverse schedule |
| `appendix.tex:210-217` | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | density, zero-set convention, admissible test, entropy identity, finite KL/FI, and Fisher chain rule |
| `appendix.tex:230-241` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `sald.forward_kl.dv_energy_bound` | common-space, absolute continuity, finite KL/log-mgf, measurability, and alpha-scaling witnesses |
| `appendix.tex:244-252` | `SALD.forwardKlGronwallInstantiationContract`; `SALD.forwardKlGronwallSideConditionContract`; `sald.forward_kl.gronwall_application` | endpoint-safe differentiability/FTC, coefficient regularity, exponent split, residual exponent drop, and display matching |
| downstream discrete sibling backend | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | visible for discrete reuse only; not a hidden continuous theorem assumption |

Lower packet: keep proof-producing work exactly on
`SALD.forwardKlDerivativeCandidateContract` /
`SALD.forwardKlDerivativeObligation` / `sald.forward_kl.kl_derivative` over
`appendix.tex:168-228`, starting with the derivative/Fokker--Planck route
before any LSI, DV, or Gronwall backfill.

## Cycle 60 Lower Continuous Forward-KL Raw Derivative Wrapper

Lower added one proof-producing scalar wrapper for the selected
`sald.forward_kl.kl_derivative` backend:
`SALD.forwardKlPreDvDerivativeBoundOfRawKlFiVelocityScalingScalar`.

Source map:

| Source line window | Supplied interface input | Compiled scalar output | Still open |
|---|---|---|---|
| `appendix.tex:168-174` | Raw KL derivative split includes the mass term, and mass conservation supplies `massTerm=0`. | The wrapper reuses `SALD.forwardKlMassConservationDropScalar` to reduce to the no-mass derivative display. | Differentiation under the integral and proof of mass conservation. |
| `appendix.tex:176-208` | SALD Fokker--Planck/integration-by-parts supplies `firstTerm=-FI`; target transport supplies the Cauchy estimate. | Existing Young and first-term scalar handoffs produce the post-Young derivative bound. | Fokker--Planck, boundary/no-flux integration by parts, target transport, and L2/FI identifications. |
| `appendix.tex:210-228` | `eq:LSI-KL-FI`, slowed-velocity norm scaling, and inverse-schedule product identity are supplied explicitly. | The wrapper derives the t-time pre-DV inequality with `-dot{s}(t)*C_LSI(t)*K(t)+(1/2)*dot{s}(t)^(-1)*||v_t||^2`. | LSI density-test theorem and inverse-function calculus remain obligations. |

Synchronized declarations:
`SALD.cycle60ForwardKlDerivativeRawLowerObligation` /
`sald.forward_kl.cycle60_derivative_raw_lower` and DAG node
`ASTIS.SALD.forward_KL.cycle60_derivative_raw_lower`.
The theorem statement, constants, labels, and backend statuses remain
unchanged.

## Cycle 58 Upper Unified/Discrete General Route Refresh

Global phase judgment: cycle 57 passed reviewer/build, so no recovery is
needed.  Phase 1 theorem-skeleton translation is stable enough to re-close
`thm:unified-forward-KL` and
`thm:general-moving-target-SALD-discrete` through the already named interfaces,
but broad cited-theory backfill is still deferred.  The single lower packet
that now reduces the largest proof risk is
`sald.general_moving_target_discrete.gronwall_side_conditions` over
`appendix.tex:1573-1600`.

Five slow interfaces checked before the lower packet:

| Interface | Lean-facing consumer | Status |
|---|---|---|
| Gronwall endpoint/FTC/coefficient interface | `SALD.generalMovingTargetDiscreteGronwallInstantiationContract`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `sald.general_moving_target_discrete.gronwall_side_conditions` | obligation |
| DV common-space and finite-log-mgf | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| LSI/KL/FI density-test bridge | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| continuous general derivative/Fokker--Planck | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.cycle57GuidedGeneralDerivativeSplitLowerObligation`; `sald.general_moving_target.kl_derivative` | obligation |
| EM endpoint/conditional-law Fokker--Planck | `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `SALD.generalMovingTargetDiscreteEmEndpointMeasureMapPairOfNamedInterpolation`; `sald.general_moving_target_discrete.em_interpolation_fp` | endpoint handoff plus obligation |

Source-to-Lean route:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `main_body.tex:359-395`, `appendix.tex:949-951`: unified VA-SALD is the specialization `c_t=u_t`, `m_t=w_t`. | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.transport_velocity_bridge`; `sald.unified_forward_kl.specialization`; `SALD.cycle58UnifiedDiscreteGeneralSkeletonObligation` | correction-field existence/regularity and continuous general theorem obligations |
| `appendix.tex:1313-1347`: discrete general theorem display and constants. | `SALD.generalMovingTargetDiscreteStatementContract`; `SALD.generalVaSaldDiscreteContract`; `SALD.cycle58UnifiedDiscreteGeneralSkeletonObligation` | theorem remains `contractOnly`; constants unchanged |
| `appendix.tex:1354-1552`: EM interpolation, KL derivative, frozen residual, LSI, and DV. | cycle-53 derivative/DV lower route; cycle-54 EM FP sigma split; `sald.general_moving_target_discrete.kl_derivative`; `sald.general_moving_target_discrete.dv_m_energy` | conditional law, density/AC, weak FP, KL differentiation, DV witnesses |
| `appendix.tex:1573-1600`: define `K(t)`, use constant schedule, apply Gronwall, and match the displayed bound. | `SALD.generalMovingTargetDiscreteGronwallInstantiationContract`; `SALD.generalMovingTargetDiscretePointwiseGronwallInputOfPostDvTimeChanged`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; `ASTIS.SALD.general_moving_target_discrete.cycle58_lower_packet.gronwall_display` | selected lower backend: pointwise Gronwall input now compiles; endpoint stitching, coefficient regularity, Gronwall, and display matching remain obligations |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 58 upper route refresh | Recheck the final unified/discrete general route after the clean cycle-57 guided/general pass, keeping all five slow interfaces explicit. | cycle-57 guided/general route; cycle-53 unified/discrete route; cycle-56 Gronwall recovery pattern; five slow analytic interfaces | `SALD.cycle58UnifiedDiscreteGeneralUpperPacket`; `SALD.cycle58UnifiedDiscreteGeneralSkeletonObligation`; `ASTIS.SALD.unified_discrete_general.cycle58_upper_route` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete` | obligation |
| Cycle 58 middle route audit | Verify the upper route in source order and select the discrete general Gronwall/display side conditions as the lower packet. | cycle-58 upper route; cycle-57 guided/general route; cycle-53 derivative/DV scalar handoff; cycle-56 Gronwall recovery pattern; cycle-20 discrete general Gronwall bridge | `SALD.cycle58UnifiedDiscreteGeneralMiddleContract`; `SALD.cycle58UnifiedDiscreteGeneralMiddleObligation`; `ASTIS.SALD.unified_discrete_general.cycle58_middle_route_audit` | `main_body.tex:359-395`; `appendix.tex:949-951`; `appendix.tex:1313-1603`; lower slice `appendix.tex:1573-1600` | `thm:unified-forward-KL`; `thm:general-moving-target-SALD-discrete`; cycle-58 lower packet | obligation |
| Cycle 58 lower packet | Refine the discrete general Gronwall/display backend, including endpoint stitching, constant-schedule coefficient rewrites, coefficient regularity, and exact theorem-display matching. | `SALD.generalMovingTargetDiscreteGronwallInstantiationContract`; `SALD.generalMovingTargetDiscretePointwiseGronwallInputOfPostDvTimeChanged`; `SALD.generalMovingTargetDiscreteGronwallSideConditionContract`; cycle-20 middle Gronwall bridge; cycle-53 derivative/DV handoff | `ASTIS.SALD.general_moving_target_discrete.cycle58_lower_packet.gronwall_display` | `appendix.tex:1573-1600`; theorem display `appendix.tex:1316-1347` | `sald.general_moving_target_discrete.gronwall_side_conditions`; `thm:general-moving-target-SALD-discrete` | obligation with compiled local real/order core |

Lower packet: target exactly
`SALD.generalMovingTargetDiscreteGronwallSideConditionContract` /
`SALD.generalMovingTargetDiscreteGronwallSideConditionObligation` /
`sald.general_moving_target_discrete.gronwall_side_conditions`.  First handle
stitched endpoint identities and constant-schedule admissibility, then
coefficient rewrites, then Gronwall regularity and display matching.  No
theorem statement, source constant, theorem status, SLT reuse status, or slow
analytic backend status changes.

Cycle 58 lower proof-producing increment:

| Source fragment | Lean declaration | Translation status |
|---|---|---|
| `appendix.tex:1573-1600`: after the post-DV `s`-time inequality and inverse-schedule identities are supplied, the proof needs the pointwise `K'(t) <= -a(t)K(t)+b(t)` input for `lem:gronwall`. | `SALD.generalMovingTargetDiscretePointwiseGronwallInputOfPostDvTimeChanged` | Formalized local real/order wrapper over the existing scalar time-change theorem. Stitched endpoint laws, coefficient regularity, the endpoint-safe Gronwall backend, and exact display matching remain obligations under `sald.general_moving_target_discrete.gronwall_side_conditions`. |

Middle synchronization:
`SALD.cycle58UnifiedDiscreteGeneralMiddleContract` maps the cycle focus back
to the source text.  The unified theorem stays the specialization
`c_t=u_t`, `m_t=w_t` from `appendix.tex:949-951`, and the discrete theorem
stays on the source route through EM interpolation, frozen-delta, LSI,
residual DV, and Gronwall.  The middle audit adds
`SALD.cycle58UnifiedDiscreteGeneralMiddleObligation` to
`SALD.unifiedForwardKlContract` and `SALD.generalVaSaldDiscreteContract`; the
only selected lower packet is still
`sald.general_moving_target_discrete.gronwall_side_conditions` over
`appendix.tex:1573-1600`.

## Cycle 57 Upper Guided/General Route Recheck

Global phase judgment: cycle 56 did not fail and needs no recovery; Phase 1 is
stable for the forward-KL and discrete forward-KL routes, but not yet stable
enough for broad cited-theory backfill until the guided residual and continuous
general moving-target route is rechecked against `appendix.tex:619-951`.  The
single lower packet that best reduces proof risk is the continuous general
Fokker--Planck/KL derivative backend
`SALD.generalMovingTargetDerivativeCandidateContract` /
`SALD.generalMovingTargetDerivativeObligation` /
`sald.general_moving_target.kl_derivative`.

Lean-facing update:

- `SALD.cycle57GuidedGeneralSkeletonUpperPacket` records the upper objective,
  mode discipline, non-goals, lower packet, and reviewer checklist.
- `SALD.cycle57GuidedGeneralSkeletonObligation`
  (`sald.guided_general.cycle57_upper_route`) adds the theorem-level route
  recheck to `SALD.guidedResidualContract` and `SALD.generalVaSaldContract`.
- `SALD.cycle57GuidedGeneralSkeletonMiddleContract` and
  `SALD.cycle57GuidedGeneralSkeletonMiddleObligation`
  (`sald.guided_general.cycle57_middle_route_audit`) verify the upper route
  in source order, add the middle obligation to `SALD.guidedResidualContract`
  and `SALD.generalVaSaldContract`, and keep the lower packet on
  `sald.general_moving_target.kl_derivative`.
- `SALD.cycle57GuidedGeneralSkeletonDag` adds
  `ASTIS.SALD.guided_general.cycle57_upper_route`,
  `ASTIS.SALD.guided_general.cycle57_middle_route_audit`, and
  `ASTIS.SALD.guided_general.cycle57_lower_packet.general_derivative`.

Five-interface check:

| Interface | Lean-facing consumer | Status |
|---|---|---|
| Gronwall endpoint/FTC/coefficient interface | `SALD.saldGronwallEndpointCalculusContract`; `SALD.generalMovingTargetGronwallInstantiationContract`; `sald.general_moving_target.gronwall_application` | obligation |
| DV common-space and finite-log-mgf | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract` | source-cited plus obligations |
| LSI/KL/FI density-test bridge | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| Continuous Fokker--Planck/KL derivative identity | `SALD.generalMovingTargetDerivativeCandidateContract`; `sald.general_moving_target.kl_derivative` | selected lower obligation |
| EM interpolation endpoint/conditional-law Fokker--Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; `sald.general_moving_target_discrete.em_interpolation_fp` | downstream obligation interface only |

Source-to-Lean route:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `appendix.tex:619-704`: residual identity for the guided path. | `SALD.guidedResidualIdentityContract`; `sald.guided_path_residual.normalizer_derivative`; `sald.guided_path_residual.identity`; `SALD.guidedResidualContract`; `SALD.cycle57GuidedGeneralSkeletonObligation` | normalizer positivity, differentiation under the integral, boundary integration by parts, product/quotient differentiation, and mean-zero residual |
| `appendix.tex:724-744`: general moving-target statement. | `SALD.generalMovingTargetStatementContract`; `SALD.generalVaSaldContract` | theorem remains `contractOnly`; statement and coefficients unchanged |
| `appendix.tex:765-884`: KL derivative, general Fokker--Planck, target transport, residual Young, LSI, and time change. | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; `sald.general_moving_target.kl_derivative`; scalar handoffs from cycle 52 | selected lower backend: density/law regularity, mass conservation, KL differentiation, integration by parts, target transport, sigma/schedule side conditions |
| `appendix.tex:885-907`: residual DV with `Z=alpha*||m_t||^2`. | `SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`; `SALD.generalMovingTargetDvPositiveAlphaScalingContract`; `sald.general_moving_target.dv_m_energy` | common-space, AC, finite KL/log-mgf, measurability, positive alpha, source-cited DV |
| `appendix.tex:908-945`: Gronwall and pure contraction. | `SALD.generalMovingTargetGronwallInstantiationContract`; `SALD.generalMovingTargetGronwallSideConditionContract`; `sald.general_moving_target.gronwall_side_conditions`; `sald.general_moving_target.pure_contraction` | endpoint rewrites, coefficient regularity, exponent splitting, residual-exponent monotonicity, zero-residual alpha-complexity |
| `appendix.tex:949-951`: unified theorem reuse. | `SALD.unifiedForwardKlSpecializationContract`; `sald.unified_forward_kl.specialization` | downstream specialization only; no direct VA-SALD proof route |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 57 upper route | Recheck guided residual and continuous general theorem skeleton after the clean cycle-56 discrete recovery. | cycle-56 route; cycle-52 guided/general route; five slow analytic interfaces | `SALD.cycle57GuidedGeneralSkeletonUpperPacket`; `SALD.cycle57GuidedGeneralSkeletonObligation`; `ASTIS.SALD.guided_general.cycle57_upper_route` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; `thm:unified-forward-KL` | obligation |
| Cycle 57 middle audit | Verify `appendix.tex:619-951` in paper order and map each source step to existing contracts, cited interfaces, or obligations before lower work. | cycle-57 upper route; cycle-56 middle route; cycle-52 middle route; guided residual, general derivative, LSI, residual DV, Gronwall, pure contraction, EM reuse | `SALD.cycle57GuidedGeneralSkeletonMiddleContract`; `SALD.cycle57GuidedGeneralSkeletonMiddleObligation`; `ASTIS.SALD.guided_general.cycle57_middle_route_audit` | `appendix.tex:619-951` | `prop:guided_path_residual`; `thm:general-moving-target-SALD`; cycle 57 lower derivative packet | obligation |
| Cycle 57 lower packet | Refine the continuous general KL derivative/Fokker--Planck backend before DV or Gronwall backfill. | `SALD.generalMovingTargetDerivativeCandidateContract`; `SALD.generalMovingTargetDerivativeObligation`; cycle-52 scalar handoffs; LSI and schedule obligations | `ASTIS.SALD.guided_general.cycle57_lower_packet.general_derivative` | `appendix.tex:765-884` | `sald.general_moving_target.kl_derivative`; `thm:general-moving-target-SALD` | obligation |

Lower packet: target exactly
`SALD.generalMovingTargetDerivativeCandidateContract` /
`SALD.generalMovingTargetDerivativeObligation` /
`sald.general_moving_target.kl_derivative` over `appendix.tex:765-884`.
Start with `appendix.tex:765-812` law regularity, mass conservation, the
general moving-target Fokker--Planck equation, KL differentiation under the
integral, and integration-by-parts side conditions.  Then expose
`appendix.tex:813-864` target transport, residual identification
`m_t=v_t-c_t`, and Young coefficient
`epsilon=2*dot t(s)/sigma_{t(s)}^2`, followed by the `appendix.tex:865-884`
LSI and schedule handoff.

No theorem statement, source label, coefficient, theorem status, SLT reuse
status, or analytic backend status changed.

Middle synchronization:
`SALD.cycle57GuidedGeneralSkeletonMiddleContract` now records the
source-to-Lean audit for `appendix.tex:619-951`: guided residual normalizer and
identity, general moving-target KL derivative, target transport, residual
Young coefficient, LSI handoff, residual DV witness, Gronwall side conditions,
pure contraction, and unified specialization.  The new middle obligation is
listed on `SALD.guidedResidualContract` and `SALD.generalVaSaldContract`; the
selected lower packet remains exactly `sald.general_moving_target.kl_derivative`.
All slow analytic interfaces remain obligations/source-cited.

Lower synchronization:

- `SALD.generalMovingTargetKlDerivativeResidualSplitScalar` compiles the
  `appendix.tex:765-835` real-algebra handoff from a supplied raw KL derivative
  split, zero mass term, Fokker--Planck first-term evaluation, target-transport
  second-term evaluation, and residual identity `m_t=v_t-c_t` to the derivative
  display
  `dK/ds = -(sigma_t^2/2)*FI + residualCross`.
- `SALD.generalMovingTargetKlDerivativePreDvBoundOfSplitScalar` composes that
  split with the existing cycle-47/52 Young, LSI, and schedule scalar pipeline,
  giving the pre-DV `t`-time inequality under explicit analytic inputs.
- `SALD.cycle57GuidedGeneralDerivativeSplitLowerObligation` and DAG node
  `ASTIS.SALD.general_moving_target.cycle57_derivative_split_lower` record this
  as proof-producing scalar bookkeeping only.  Mass conservation, KL
  differentiation under the integral, Fokker--Planck, integration by parts,
  target transport, residual Young, LSI/KL/FI, sigma positivity, and
  inverse-schedule calculus remain obligations; no theorem statement or backend
  status changed.

## Cycle 56 Discrete Forward-KL Theorem Interface Route

Upper returned to `thm:forward-KL-discrete` for the cycle focus.  The new
Lean-facing route data are `SALD.cycle56DiscreteForwardKlSkeletonUpperPacket`,
`SALD.cycle56DiscreteForwardKlSkeletonObligation`, and DAG node
`ASTIS.SALD.forward_KL_discrete.cycle56_theorem_interface_route`.

Five slow interfaces checked before the lower packet:

| Interface | Lean-facing consumer | Status |
|---|---|---|
| Gronwall endpoint/FTC/coefficient interface | `SALD.discreteForwardKlGronwallInstantiationContract`; `sald.discrete_forward_kl.gronwall_accumulation` | obligation |
| DV common-space and finite-log-mgf | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| LSI/KL/FI density-test bridge | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi` | obligation |
| continuous derivative/Fokker--Planck reuse | `SALD.forwardKlDerivativeSideConditionContract`; cycle-55 mass handoff | analytic backend still obligation |
| EM endpoint/conditional-law Fokker--Planck | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | source-cited obligation interface |

Source-to-Lean route:

| Source step | Lean-facing route | Remaining backend |
|---|---|---|
| `main_body.tex:299-323`: linear slowdown theorem display and constants. | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract`; `SALD.cycle56DiscreteForwardKlSkeletonObligation` | theorem remains `contractOnly`; constants unchanged |
| `appendix.tex:260-385`: EM interpolation, endpoint laws, conditional drift, conditional-FP, and Laplacian split. | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_endpoint_laws`; `sald.discrete_forward_kl.em_conditional_fokker_planck`; `sald.discrete_forward_kl.em_interpolation_fp` | regular conditional drift, density/AC, weak FP, stitched endpoint laws |
| `appendix.tex:388-491`: KL derivative through frozen defect, moving Young term, and LSI. | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.cycle51DiscreteForwardKlDerivativeLowerObligation`; `SALD.discreteForwardKlPostLsiDerivativeBoundOfKlFiScalar` | analytic KL derivative, frozen-defect specialization, LSI density-test |
| `appendix.tex:493-523`: DV velocity estimate. | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_velocity_bound` | common-space, AC, measurability, finite log-mgf |
| `appendix.tex:526-592`: time change, Gronwall, and accumulated-error display. | `SALD.discreteForwardKlGronwallInstantiationContract`; `SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`; `SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `sald.discrete_forward_kl.gronwall_accumulation` | scalar and pointwise `s`-to-`t` coefficient handoff formalized; Gronwall, endpoint stitching, residual exponent, `barGamma`/`barDelta` collection remain obligations |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 56 discrete theorem route | Consume explicit EM endpoint/conditional-FP, cycle-51 derivative/LSI scalar handoff, discrete DV velocity, and Gronwall/accumulated-error interfaces to match the main theorem display. | cycle-54 five-backend audit; cycle-55 continuous route; cycle-51 discrete derivative lower; EM, frozen-defect, LSI, DV, Gronwall, accumulated-error obligations | `SALD.cycle56DiscreteForwardKlSkeletonUpperPacket`; `SALD.cycle56DiscreteForwardKlSkeletonObligation`; `ASTIS.SALD.forward_KL_discrete.cycle56_theorem_interface_route` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete`; cycle 56 lower Gronwall packet | obligation |
| Cycle 56 middle route audit | Verify the upper route in source order, keep EM/Fokker--Planck as named source-cited interfaces, and select the Gronwall accumulation backend over `appendix.tex:526-592` for lower work. | cycle-56 upper route; cycle-54 analytic audit; cycle-55 continuous route; cycle-51 derivative lower; EM, LSI, DV, Gronwall, and accumulated-error obligations | `SALD.cycle56DiscreteForwardKlSkeletonMiddleContract`; `SALD.cycle56DiscreteForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL_discrete.cycle56_middle_route_audit` | `main_body.tex:299-323`; `appendix.tex:260-592`; lower slice `appendix.tex:526-592` | `thm:forward-KL-discrete`; cycle 56 lower Gronwall packet | obligation |
| Cycle 56 lower Gronwall handoff | Convert the supplied post-DV `s`-time inequality to the exact pointwise `t`-time `a(t)` and `b(t)` consumed by Gronwall. | cycle-56 middle route; cycle-51 derivative lower; discrete DV velocity witness; schedule side conditions | `SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`; `SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged`; `SALD.cycle56DiscreteForwardKlGronwallLowerObligation`; `ASTIS.SALD.forward_KL_discrete.cycle56_gronwall_lower` | `appendix.tex:526-553` | `sald.discrete_forward_kl.gronwall_accumulation`; `thm:forward-KL-discrete` | formalized scalar core plus obligation |

Lower packet: target exactly
`SALD.discreteForwardKlGronwallInstantiationContract` /
`SALD.discreteForwardKlGronwallAccumulationObligation` /
`sald.discrete_forward_kl.gronwall_accumulation` over `appendix.tex:526-592`.
Use the existing derivative and DV interfaces as inputs.  Do not prove the
EM/Fokker--Planck backend from scratch; keep it source-cited/obligation-level.

Middle synchronization:
`SALD.cycle56DiscreteForwardKlSkeletonMiddleContract` and
`SALD.cycle56DiscreteForwardKlSkeletonMiddleObligation` now check the upper
cycle-56 route against the paper split.  They add the middle obligation to
`SALD.discreteSaldContract`, route `appendix.tex:260-385` only through the
named EM endpoint/conditional-FP interfaces, reuse the cycle-51
derivative/LSI scalar handoff and discrete DV witness as inputs, and keep
lower work focused on `sald.discrete_forward_kl.gronwall_accumulation`.
Endpoint stitching, linear slowdown, residual exponent, and
`barGamma`/`barDelta` collection remain downstream obligations.

Lower recovery:
`SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar` now compiles the
real-order handoff from the supplied post-DV `s`-time inequality to the
`t`-time Gronwall coefficient in `appendix.tex:526-553`.
`SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged` lifts this
same local algebra to the pointwise-in-`t` derivative inequality expected by
the Gronwall accumulation interface.  The corresponding ledger node is
`SALD.cycle56DiscreteForwardKlGronwallLowerObligation` /
`ASTIS.SALD.forward_KL_discrete.cycle56_gronwall_lower`.  The theorem still
depends on source-cited EM/Fokker--Planck, LSI/KL/FI, DV, Gronwall, endpoint
stitching, residual-exponent, and accumulated-error interfaces.

No theorem statement, source label, coefficient, theorem status, SLT reuse
status, or analytic backend status changed.
## Cycle 64 Upper Analytic Interface Ledger

Global phase judgment: cycle 63 passed reviewer/build, so no recovery is
needed. Phase 1 theorem-skeleton translation is stable enough for exactly one
narrow cited-theory/SDE backend backfill, but not for broad SLT, disintegration,
or reusable API work. The lower packet that best reduces remaining proof risk
is the EM interpolation conditional-law/Fokker--Planck backend over
`appendix.tex:1358-1387`, because it supports both discrete theorem routes.

Lean-facing update:

- `SALD.cycle64MainSkeletonAnalyticInterfaceLedger` records the upper
  objective, mode discipline, non-goals, lower packet, and reviewer checklist.
- `SALD.cycle64MainSkeletonAnalyticInterfaceObligation`
  (`sald.main_skeleton.cycle64_analytic_interface_ledger`) is listed by all
  six theorem contracts while the theorem contracts remain `contractOnly`.
- `SALD.cycle64MainSkeletonAnalyticInterfaceDag` is included in the continuous,
  discrete, guided/general, and discrete-general proof DAGs.
- `SALD.cycle64MainSkeletonDependencyNames` is included by
  `SALD.saldDependenciesForLabel` for the five slow interfaces and the six
  theorem-route labels.

Five slow interfaces checked before lower work:

| Backend | Lean-facing interface | Status |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallEndpointCalculusContract`, `SALD.saldGronwallExponentRewriteContract`, cycle-36/41 Gronwall wrappers | obligation |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`, `SALD.saldDvFiniteLogMgfContract`, theorem-specific DV witnesses | source-cited plus obligations |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`, `SALD.lsiKlFiDensityTestObligation`, `probability.lsi_to_kl_fi` | obligation |
| continuous KL derivative/Fokker--Planck | `SALD.forwardKlDerivativeSideConditionContract`, `SALD.generalMovingTargetDerivativeCandidateContract`, cycle-60/62 scalar handoffs | obligation |
| EM interpolation conditional-FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`, `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`, `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`, cycle-63 endpoint-law helpers | obligation |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 64 global judgment | No recovery; one narrow backend backfill only; select EM conditional-law/FP. | cycle-63 route and endpoint-law backfill | `ASTIS.SALD.cycle64.global_phase_judgment` | `appendix.tex:1358-1387` | cycle 64 lower packet | obligation |
| Cycle 64 five-backend check | Recheck Gronwall, DV, LSI/KL/FI, continuous FP/KL derivative, and EM conditional-FP interfaces. | cycle-44/54/59 ledgers; cycle-60/61/63 route data | `ASTIS.SALD.cycle64.five_backend_check` | `appendix.tex:47-79`; `main_body.tex:202-215`; `appendix.tex:168-252`; `appendix.tex:1358-1387` | six theorem skeletons | obligation |
| Cycle 64 theorem route rewire | Keep the route order `forward-KL`, discrete `forward-KL`, guided residual, general moving-target, unified forward-KL, discrete general moving-target. | six theorem contracts; cycle-60/61/62/63 middle obligations | `ASTIS.SALD.cycle64.theorem_route_rewire` | `appendix.tex:164-1603` | six theorem skeletons | obligation |
| Cycle 64 middle interface audit | Synchronize the upper ledger with the source-to-Lean theorem route and keep endpoint-law helpers scoped to endpoint bookkeeping. | cycle-64 upper ledger; cycle-63 endpoint-law helpers; cycle-60/61/62/63 route audits | `SALD.cycle64MainSkeletonAnalyticMiddleContract`; `SALD.cycle64MainSkeletonAnalyticMiddleObligation`; `ASTIS.SALD.cycle64.middle_interface_audit` | `appendix.tex:1358-1387` | six theorem skeletons; cycle 64 lower packet | obligation |
| Cycle 64 lower packet | Refine common-space/density assumptions, regular conditional drift, and weak conditional-FP signs after endpoint-law bookkeeping. | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`; cycle-63 endpoint helpers | `ASTIS.SALD.cycle64.lower_packet.general_discrete_em_conditional_fp` | `appendix.tex:1358-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; discrete theorem routes | obligation |

Lower packet: target exactly
`SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation` /
`SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` /
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`. Start with common probability-space data,
`\hat\rho_s` and `\tilde\pi_s` density/absolute-continuity, endpoint-law
stitching, then the regular conditional drift `\bar b_{k,s}(x)`, and then the
weak conditional Fokker--Planck equation with the source drift-divergence and
`sigma_eta^2/2` Laplacian signs.

No theorem statement, source label, coefficient, theorem status, SLT reuse
status, or analytic backend status changed.

## Cycle 64 Middle Analytic Interface Audit

Middle synchronized the upper ledger into
`SALD.cycle64MainSkeletonAnalyticMiddleContract`,
`SALD.cycle64MainSkeletonAnalyticMiddleObligation`, and DAG node
`ASTIS.SALD.cycle64.middle_interface_audit`.

The theorem route remains paper ordered:

| Route slot | Source block | Lean-facing consumers | Status |
|---|---|---|---|
| `thm:forward-KL` | `appendix.tex:168-252` | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.saldLsiKlFiDensityTestContract`; DV witnesses; Gronwall side conditions | `contractOnly` theorem; analytic obligations |
| `thm:forward-KL-discrete` | `appendix.tex:260-592` | EM interpolation side conditions; discrete KL derivative; frozen defect; LSI; DV; Gronwall; accumulated-error bridge | `contractOnly` theorem; analytic obligations |
| `prop:guided_path_residual` | `appendix.tex:619-704` | guided normalizer and centered residual identity obligations | `contractOnly` proposition |
| `thm:general-moving-target-SALD` | `appendix.tex:724-949` | continuous general KL derivative; residual LSI/DV; sigma-weighted Gronwall | `contractOnly` theorem; analytic obligations |
| `thm:unified-forward-KL` | `appendix.tex:949-951` | specialization through `prop:guided_path_residual` and `thm:general-moving-target-SALD` | `contractOnly` theorem |
| `thm:general-moving-target-SALD-discrete` | `appendix.tex:1313-1603` | general EM endpoint/conditional-FP; frozen delta; KL derivative/LSI; residual DV; constant-schedule Gronwall/display stitching | `contractOnly` theorem; analytic obligations |

Selected lower slice over `appendix.tex:1358-1387`:

| Source lines | Lean-facing target | Open backend |
|---|---|---|
| `appendix.tex:1358-1366` | `SALD.cycle48GeneralMovingTargetDiscreteEmEndpointFpAuditObligation`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` | endpoint-safe KL differentiation, mass conservation, density/AC for `hat rho_s` and `tilde pi_s`, finite KL |
| `appendix.tex:1368-1377` | `sald.general_moving_target_discrete.em_interpolation_fp` conditional drift interface | regular conditional law of `X_k^eta` given `hat X_s=x`, measurability, integrability |
| `appendix.tex:1379-1387` | weak conditional Fokker-Planck interface under `sald.general_moving_target_discrete.em_interpolation_fp` | source signs `-div(hat rho_s bar b_{k,s})` and `+(sigma_eta^2/2) Delta hat rho_s` |

Cycle-63 endpoint-law Measure.map helpers remain local endpoint/common-space
bookkeeping only. They do not prove conditional drift, density/absolute
continuity, weak Fokker-Planck, KL differentiation, LSI/KL/FI, DV, Gronwall,
or theorem closure.

## Cycle 64 Lower Conditional-Drift Interface

Lower performed one proof-producing Lean step before adding this ledger text.
The new compiled wrappers are
`SALD.generalMovingTargetDiscreteConditionalDriftLinearCombination` and
`SALD.generalMovingTargetDiscreteConditionalDriftFieldOfLinearCombination`.
They formalize only the abstract conditional-expectation linearity algebra for
the source drift

`dot t_k*c_{t_k}(X_k^eta) + (sigma_eta^2/2)*nabla log pi_{t_k}(X_k^eta)`.

Source-to-Lean synchronization for `appendix.tex:1368-1377`:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| Define `bar b_{k,s}(x)` by conditioning on `hat X_s=x`. | `SALD.generalMovingTargetDiscreteConditionalDriftContract`; `SALD.cycle64GeneralMovingTargetDiscreteConditionalDriftLowerObligation` | obligation |
| Split the conditional expectation of the two scaled summands when linearity is supplied. | `SALD.generalMovingTargetDiscreteConditionalDriftLinearCombination`; `SALD.generalMovingTargetDiscreteConditionalDriftFieldOfLinearCombination` | formalized local algebra under explicit hypotheses |
| Insert `bar b_{k,s}` into `partial_s hat rho_s = -div(hat rho_s bar b_{k,s}) + (sigma_eta^2/2) Delta hat rho_s`. | `sald.general_moving_target_discrete.em_interpolation_fp`; `SALD.generalMovingTargetDiscreteDerivativeSideConditionContract` | regular conditional law, measurability, integrability, density/AC, and weak FP remain obligations |

The theorem contracts remain `contractOnly`; this does not formalize the
regular conditional law, conditional drift measurability, density,
absolute-continuity, weak Fokker--Planck equation, KL differentiation, LSI,
DV, Gronwall, or any SLT backend.

## Cycle 71 Middle Endpoint-To-Conditional Compatibility

Cycle 71 keeps the active packet on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the compatibility between the joint
`Measure.map` law of `(X_k^eta, hat X_s)` and the named conditional-law
interface for `bar b_{k,s}`.

Source-to-Lean map:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1368-1377`: condition `X_k^eta` on `hat X_s=x` under the same law whose marginal is `hat rho_s=Law(hat X_s)`. | `SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityContract` | obligation |
| Identify the second marginal of `Measure.map (fun omega => (X_k^eta omega, hat X_s omega)) P` with the named `hat rho_s`. | `SALD.generalMovingTargetDiscreteHatRhoMarginalOfJointMap` | formalized local `Measure.map` wrapper |
| Transport a supplied conditional-kernel compatibility predicate from the joint-law second marginal to the named `hat rho_s` marginal. | `SALD.generalMovingTargetDiscreteConditionalKernelCompatibilityOfJointMapMarginal` | formalized local equality-transport wrapper |
| Package the marginal equality and transported kernel compatibility for the weak-FP handoff. | `SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityOfJointMap` | formalized local wrapper; no kernel existence claim |
| Register the cycle packet without promoting the analytic backend. | `SALD.cycle71GeneralMovingTargetDiscreteEndpointConditionalMiddleObligation`; `SALD.cycle71GeneralMovingTargetDiscreteEndpointConditionalLowerObligation`; `SALD.cycle71GeneralMovingTargetDiscreteEndpointConditionalDag` | obligation plus local wrappers |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 71 endpoint-to-conditional compatibility | Joint `Measure.map` law has named `hat rho_s` as second marginal, and supplied kernel compatibility is transported to that named marginal. | cycle-63 joint/marginal helpers; cycle-70 conditional-law contract; `AutoSamplingTheory.lawMapProdSnd` | `SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityContract`; `SALD.generalMovingTargetDiscreteHatRhoMarginalOfJointMap`; `SALD.generalMovingTargetDiscreteConditionalKernelCompatibilityOfJointMapMarginal`; `SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityOfJointMap` | `appendix.tex:1358-1387`, especially `1368-1377` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | formalized local wrapper plus obligation |

This is compatibility bookkeeping only.  Regular conditional probabilities,
disintegration, conditional expectation, conditional field measurability and
integrability, density/absolute-continuity, the weak conditional
Fokker--Planck identity, KL differentiation, LSI/KL/FI, DV, Gronwall, and both
downstream theorem closures remain obligations.

## Cycle 72 Weak Conditional Fokker--Planck Source Signs

Cycle 72 keeps the active packet on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the weak Fokker--Planck source line
`appendix.tex:1379-1387`.

Source-to-Lean map:

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1379-1387`: the frozen interpolation law satisfies `partial_s hat rho_s = -div(hat rho_s bar b_{k,s}) + (sigma_eta^2/2) Delta hat rho_s`. | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract` | obligation |
| For every admissible weak test, preserve the negative drift-divergence action and positive `sigma_eta^2/2` Laplacian action after the analytic weak-FP identity is supplied. | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsAdmissibleHandoff` | formalized local wrappers under explicit hypotheses |
| Register the cycle packet without promoting the analytic backend. | `SALD.cycle72GeneralMovingTargetDiscreteWeakFpMiddleObligation`; `SALD.cycle72GeneralMovingTargetDiscreteWeakFpLowerObligation`; `SALD.cycle72GeneralMovingTargetDiscreteWeakFpDag` | obligation plus local wrappers |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 72 weak conditional FP source signs | Weak-test conditional Fokker--Planck statement with `-div(hat rho_s*bar b_{k,s})` and `+(sigma_eta^2/2)*Delta hat rho_s`. | cycle-70 conditional-law/measurability; cycle-71 endpoint-to-conditional compatibility; cycle-69 and cycle-54 FP algebra wrappers | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsAdmissibleHandoff`; `SALD.cycle72GeneralMovingTargetDiscreteWeakFpLowerObligation` | `appendix.tex:1379-1387` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | formalized local wrappers plus obligation |

The wrappers do not construct the regular conditional law, prove density or
absolute-continuity of `hat rho_s`, prove the weak conditional Fokker--Planck
theorem, justify integration by parts, differentiate KL, or close LSI, DV,
Gronwall, or theorem-level claims.  The admissible-test variant only keeps the
weak-test predicate visible while performing the same coefficient/sign rewrite.

## Cycle 77 Upper Weak FP Source-Sign Backend

Global phase judgment: cycle 76 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for continued
single-backend cited-theory backfill. The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, now narrowed to the weak conditional
Fokker--Planck source-sign theorem at `appendix.tex:1379-1387`.

Active source check: the paper fixes `k`, sets
`\hat\rho_s=\Law(\hat X_s)`, defines
`\bar b_{k,s}(x)=E[\dot t_k c_{t_k}(X_k^\eta) +
(\sigma_\eta^2/2)\nabla\log\pi_{t_k}(X_k^\eta)\mid \hat X_s=x]`, and then
invokes the associated FP equation
`partial_s hat rho_s = -div(hat rho_s*bar b_{k,s}) +
(sigma_eta^2/2) Delta hat rho_s`. The negative drift-divergence sign and
positive diffusion sign must be preserved exactly.

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 77 upper weak FP source-sign backend | Select the analytic weak conditional Fokker--Planck source-sign theorem, not another coefficient rewrite: lower must either prove a narrower handoff from supplied generator/conditional-law hypotheses or record the exact missing Mathlib/SDE theorem as source-cited. | cycles 70-76 conditional-law, endpoint, and kernel-orientation wrappers; cycle 72 sign/coefficient wrappers; cycle 69/54 FP algebra handoffs | `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsAdmissibleHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorHandoff`; `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff` | `appendix.tex:1358-1387`, especially `1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.discrete_forward_kl.em_interpolation_fp`; `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation; local wrappers formalized under explicit hypotheses |

Lower packet requirements:

- keep the lower target inside `sald.general_moving_target_discrete.em_interpolation_fp`;
- reuse the cycle 72 wrappers as compiled packaging and do not duplicate them;
- expose the missing analytic hypotheses explicitly: common probability space,
  regular conditional kernel, conditional drift measurability/integrability,
  density/absolute-continuity and time regularity of `hat rho_s`, admissible
  weak-test class, covariance coefficient `sigma_eta^2/2`, and
  boundary/integration-by-parts behavior;
- if the actual weak FP theorem is too large, record a narrowly cited
  interface below `formalized` status rather than strengthening any paper
  theorem.

Non-goals: theorem-route audit, source-index rebaseline beyond the mandatory
gate, KL derivative handoff except as a direct consumer of the weak-FP
identity, display algebra unrelated to `appendix.tex:1379-1387`, SLT imports,
or any promotion of EM FP/KL/LSI/DV/Gronwall obligations to formalized status.

## Cycle 73 Upper KL-Derivative Handoff From Weak FP

Global phase judgment: cycle 72 passed reviewer/build, so no recovery is
needed. Phase 1 theorem-skeleton translation is stable enough for continued
single-backend backfill. The single lower packet that best reduces proof risk
is still `sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, now narrowed to the KL-derivative handoff from the
weak conditional Fokker--Planck identity.

Cycle 73 connects the weak FP statement to
`eq:general_KL_derivative_0_discrete` without claiming the analytic backend is
proved.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1358-1366`: differentiate `KL(hat rho_s||tilde pi_s)` and keep the target-time term `-int (hat rho_s/tilde pi_s) partial_s tilde pi_s`. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffContract` | obligation |
| `appendix.tex:1379-1387`: apply the supplied weak FP identity to the log-density-ratio test, preserving `-div(hat rho_s*bar b_{k,s})` and `+(sigma_eta^2/2) Delta hat rho_s`. | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffScalar`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfAdmissibleSourceSigns` | formalized local scalar substitutions under explicit hypotheses; the second composes through the cycle-72 admissible source-sign wrapper |
| Register the upper/middle/lower packet while keeping the backend below `formalized`. | `SALD.cycle73GeneralMovingTargetDiscreteKlDerivativeWeakFpUpperObligation`; `SALD.cycle73GeneralMovingTargetDiscreteKlDerivativeWeakFpMiddleObligation`; `SALD.cycle73GeneralMovingTargetDiscreteKlDerivativeWeakFpLowerObligation`; `SALD.cycle73GeneralMovingTargetDiscreteKlDerivativeWeakFpDag` | obligation plus local wrappers |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 73 weak-FP-to-KL handoff | Substitute the supplied admissible-test weak FP identity into the differentiated KL formula at `log(hat rho_s/tilde pi_s)`. | cycle-70 conditional-law/measurability; cycle-71 endpoint-to-conditional compatibility; cycle-72 weak FP source signs | `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffContract`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffScalar`; `SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfAdmissibleSourceSigns`; cycle-73 obligations/DAG | `appendix.tex:1358-1387` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | formalized local wrappers plus obligation |

This does not prove the weak conditional Fokker--Planck theorem, admissibility
of the log-ratio test, density/absolute-continuity, KL differentiability, mass
conservation, boundary integration by parts, Laplacian split, FI
identification, LSI/KL/FI, DV, Gronwall, or theorem closure.

## Cycle 74 Conditional-Kernel Measure Interface

Global phase judgment: cycle 73 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The single lower packet that now reduces the largest remaining
proof risk is still `sald.general_moving_target_discrete.em_interpolation_fp`
over `appendix.tex:1358-1387`, narrowed to the Mathlib
`condExpKernel`/conditional-kernel measure interface for
`appendix.tex:1368-1377`.

Active-packet check: cycle 74 does not move to theorem-route audits, display
algebra, Gronwall/DV/LSI backfill, or broad SLT APIs.  It records the blocked
conditional-law backend needed before the weak conditional Fokker--Planck
identity can be proved.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1368-1377`: condition `X_k^eta` on `hat X_s=x` under the joint law whose second marginal is the named `hat rho_s`. | `SALD.cycle74GeneralMovingTargetDiscreteConditionalKernelMeasureInterface`; `sald.general_moving_target_discrete.cycle74_conditional_kernel_measure_interface` | `sourceCited` Mathlib measure interface |
| Record the upper packet and keep the lower target fixed on the active EM backend. | `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceUpperPacket`; `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceUpperObligation`; `ASTIS.SALD.cycle74.global_phase_judgment` | workflow obligation |
| Middle source-to-Lean map for the blocked kernel theorem. | `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceMiddleObligation`; `sald.general_moving_target_discrete.cycle74_measure_interface_middle`; `ASTIS.SALD.cycle74.middle_conditional_kernel_source_map` | workflow obligation |
| Once the cited kernel backend supplies compatibility and component integral regularity, transport compatibility to named `hat rho_s` and derive regularity for `bar b_{k,s}`. | `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfComponents`; `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceLowerObligation`; `sald.general_moving_target_discrete.cycle74_conditional_kernel_lower`; `ASTIS.SALD.cycle74.lower_conditional_kernel_regularity_handoff` | formalized local wrapper plus obligation |
| Candidate upstream APIs to audit, without importing or claiming reuse. | `Mathlib.Probability.Kernel.Condexp`; `Mathlib.Probability.Kernel.CondDistrib`; `Mathlib.Probability.Kernel.Disintegration.StandardBorel` | reference/source-cited only |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 74 conditional-kernel blocker | Standard-Borel finite-measure conditional-kernel/conditional-expectation backend needed to define measurable/integrable `bar b_{k,s}` from the joint law of `(X_k^eta,hat X_s)`. | cycles 70-73 conditional-law wrappers; endpoint-to-conditional compatibility; Mathlib kernel candidates | `SALD.cycle74GeneralMovingTargetDiscreteConditionalKernelMeasureInterface`; `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceDag` | `appendix.tex:1358-1387`, especially `1368-1377`; Mathlib `Probability/Kernel/Condexp.lean` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete`; `sald.general_moving_target_discrete.em_interpolation_fp` | `sourceCited` plus workflow obligation |
| Cycle 74 middle map | Align `condDistrib`/`condExpKernel` candidates with the joint law, named `hat rho_s` marginal, and vector-valued conditional drift integrals. | cycle-70 conditional drift fields; cycle-71 marginal compatibility; cycle-73 KL handoff | `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceMiddleObligation`; `ASTIS.SALD.cycle74.middle_conditional_kernel_source_map` | `appendix.tex:1368-1377`; Mathlib `CondDistrib.lean`, `Condexp.lean` | `sald.general_moving_target_discrete.em_interpolation_fp`; both discrete theorem routes | obligation |
| Cycle 74 lower supplied-kernel handoff | Package the part that can be proved locally after the cited kernel backend is supplied: named-marginal compatibility and `bar b_{k,s}` regularity from component integral fields. | cycle-71 marginal compatibility; cycle-70 component regularity; cycle-74 source-cited kernel interface | `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfComponents`; `SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceLowerObligation`; `ASTIS.SALD.cycle74.lower_conditional_kernel_regularity_handoff` | `appendix.tex:1368-1377`; Mathlib `CondDistrib.lean`, `Condexp.lean` as cited backend | `sald.general_moving_target_discrete.em_interpolation_fp`; both discrete theorem routes | formalized local wrapper plus obligation |

Mode discipline: faithfulPaper Phase 1 only.  Do not add standard-Borel,
finite-measure, measurability, integrability, density, or admissibility
hypotheses to the theorem statements; keep them attached to this interface
until a local ASTIS declaration compiles.

Non-goals: no weak conditional Fokker--Planck theorem, no KL derivative proof,
no theorem-status promotion, no SLT import, and no broad reusable API design.

Reviewer checklist: verify that the new interface stays below `formalized`,
that both discrete theorem contracts remain `contractOnly`, that
`sald_version_2.tex` remains out of scope, and that source-index plus
`python3 tools/astis.py check` pass.

## Cycle 75 Upper Conditional-Law Backfill

Global phase judgment: cycle 74 passed reviewer/build and needs no recovery;
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill; the single lower packet that best reduces proof risk remains
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the conditional-law/measurability and
named conditional drift construction interface for `appendix.tex:1368-1377`.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:1368-1377`: condition `X_k^eta` on `hat X_s=x`, preserving the joint law, named `hat rho_s` marginal, and component conditional drift integrals. | `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillUpperPacket`; `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillUpperObligation`; `ASTIS.SALD.cycle75.global_phase_judgment` | workflow obligation |
| Middle source map: Mathlib `condDistrib Y X mu` conditions `Y` on `X` and orders the joint law as `(hat X_s,X_k^eta)`, while the existing SALD compatibility map names `(X_k^eta,hat X_s)`. | `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillMiddleObligation`; `ASTIS.SALD.cycle75.middle_conditional_law_source_map`; `AutoSamplingTheory.lawMapProdSwap` | workflow obligation plus formalized local `Measure.map` orientation helper |
| Lower packet: instantiate or sharpen the cycle-74 `condDistrib`/`condExpKernel` source-cited interface for the named joint law and vector-valued component integrals. | `ASTIS.SALD.cycle75.lower_packet.conditional_law_measurability`; feeds `SALD.cycle74GeneralMovingTargetDiscreteConditionalKernelMeasureInterface` and `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfComponents` | obligation; no analytic status promotion |
| Cycle 75 lower wrapper: from supplied swapped-joint kernel compatibility for `(hat X_s,X_k^eta)`, component integral fields, and component regularity consequences, bridge back to the existing `(X_k^eta,hat X_s)` SALD orientation. | `SALD.generalMovingTargetDiscreteHatRhoFirstMarginalOfSwappedJointMap`; `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfSwappedComponents`; `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillLowerObligation` | formalized local `Measure.map`/regularity wrapper under supplied hypotheses; conditional law and weak FP remain obligations |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 75 global phase judgment | No recovery from cycle 74; theorem-skeleton route stable; active risk is still the conditional-law layer in the shared EM backend. | cycle-74 conditional-kernel measure interface; cycles 70-71 conditional-law wrappers | `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillUpperObligation`; `ASTIS.SALD.cycle75.global_phase_judgment` | `appendix.tex:1358-1387`, especially `1368-1377` | both discrete theorem routes | obligation |
| Cycle 75 middle source map | Orient the Mathlib conditional-distribution backend: instantiate `condDistrib` with `X=hat X_s`, `Y=X_k^eta`, then bridge the paper's existing `(X_k^eta,hat X_s)` joint-law naming by swapping the paired pushforward law. | cycle-74 source-cited interface; cycle-71 marginal compatibility; local SLT `Measure.map` style check | `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillMiddleObligation`; `ASTIS.SALD.cycle75.middle_conditional_law_source_map`; `AutoSamplingTheory.lawMapProdSwap` | `appendix.tex:1368-1377`; Mathlib `CondDistrib.lean`, `Condexp.lean` | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.discrete_forward_kl.em_interpolation_fp`; both discrete theorem routes | obligation plus formalized local orientation helper |
| Cycle 75 lower packet | Compile the local supplied-hypothesis bridge for Mathlib's `(hat X_s,X_k^eta)` condDistrib orientation: first marginal is named `hat rho_s`, the swapped pushforward equals the paper joint law orientation, and component integral-field regularity transfers to `bar b_{k,s}`. | cycle-74 source-cited interface; `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfComponents`; cycle-70 named component drift wrappers; `AutoSamplingTheory.lawMapProdSwap` | `SALD.cycle75GeneralMovingTargetDiscreteConditionalLawBackfillLowerObligation`; `SALD.generalMovingTargetDiscreteHatRhoFirstMarginalOfSwappedJointMap`; `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfSwappedComponents`; `ASTIS.SALD.cycle75.lower_packet.conditional_law_measurability` | `appendix.tex:1368-1377`; Mathlib `CondDistrib.lean`, `Condexp.lean` as audit candidates | `sald.general_moving_target_discrete.em_interpolation_fp`; `sald.discrete_forward_kl.em_interpolation_fp`; both discrete theorem routes | formalized local wrapper plus obligation |

Mode discipline: faithfulPaper Phase 1 only.  Do not add standard-Borel,
finite-measure, measurability, integrability, density, or admissibility
hypotheses to theorem statements.  Use local `lean-stat-learning-theory` only
as a Mathlib style reference; do not import it or claim SLT formalization.

Non-goals: no endpoint-law re-audit, weak FP proof, KL derivative proof,
Gronwall/DV/LSI work, frozen-delta algebra, theorem-status promotion, or
project-article export.

Reviewer checklist: confirm the active lower packet still targets
`appendix.tex:1368-1377`, cycle 75 depends on the cycle-74 source-cited
conditional-kernel interface without duplicating/promoting it, both discrete
theorem contracts remain `contractOnly`, and source-index plus
`python3 tools/astis.py check` pass.

## Cycle 65 Upper Continuous Forward-KL Route

Global phase judgment: cycle 64 passed reviewer/build, so no recovery is
needed. Phase 1 theorem-skeleton translation is stable enough for this narrow
continuous `thm:forward-KL` route audit, but not for broad cited-theory, SDE,
disintegration, or reusable API backfill. The single lower packet that best
reduces the remaining continuous theorem risk is
`SALD.forwardKlDerivativeCandidateContract` /
`SALD.forwardKlDerivativeObligation` / `sald.forward_kl.kl_derivative` over
`appendix.tex:168-228`.

Lean-facing update:

- `SALD.cycle65ForwardKlSkeletonUpperPacket` records the upper objective, mode
  discipline, non-goals, lower packet, and reviewer checklist for the
  continuous theorem route.
- `SALD.cycle65ForwardKlSkeletonObligation`
  (`sald.forward_kl.cycle65_continuous_route`) is listed by
  `SALD.continuousSaldContract`, which remains `contractOnly`.
- `SALD.cycle65ForwardKlSkeletonDag` is included in
  `SALD.forwardKlProofDag` after the cycle-64 analytic ledger and cycle-60
  continuous route data.
- `SALD.cycle65ForwardKlDependencyNames` is included by
  `SALD.saldDependenciesForLabel "thm:forward-KL"`.

Five slow interfaces checked before lower work:

| Backend | Lean-facing interface | Status |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallEndpointCalculusContract`, `SALD.forwardKlGronwallSideConditionContract`, cycle-36/41 wrappers | obligation |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`, `SALD.saldDvFiniteLogMgfContract`, `SALD.forwardKlDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`, `SALD.lsiKlFiDensityTestObligation`, `probability.lsi_to_kl_fi` | obligation |
| continuous KL derivative/Fokker--Planck | `SALD.forwardKlDerivativeCandidateContract`, `SALD.forwardKlDerivativeSideConditionContract`, `SALD.forwardKlDerivativeObligation`, cycle-60 raw scalar wrapper | selected obligation |
| EM interpolation FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`, `sald.discrete_forward_kl.em_interpolation_fp` | downstream discrete obligation |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 65 global judgment | No recovery; narrow continuous forward-KL route audit only; select continuous KL derivative backend. | cycle-64 ledger; cycle-64 conditional-drift lower; cycle-60 continuous route | `ASTIS.SALD.forward_KL.cycle65_global_phase_judgment` | `main_body.tex:238-247`; `appendix.tex:164-252` | cycle 65 handoff | obligation |
| Cycle 65 five-backend check | Recheck Gronwall, DV, LSI/KL/FI, continuous FP/KL derivative, and EM interpolation FP before lower work. | cycle-64 analytic ledger; theorem-specific interfaces | `ASTIS.SALD.forward_KL.cycle65_five_backend_check` | first-DAG sources plus `appendix.tex:168-252` | six theorem skeletons | obligation |
| Cycle 65 continuous route | Wire `thm:forward-KL` through derivative/Fokker--Planck, LSI, DV velocity-energy, and Gronwall display matching. | cycle-64 ledger; cycle-60 route; forward-KL statement and proof-block contracts | `SALD.cycle65ForwardKlSkeletonObligation`; `ASTIS.SALD.forward_KL.cycle65_continuous_route` | `main_body.tex:238-247`; `appendix.tex:164-252` | `thm:forward-KL` | obligation |
| Cycle 65 lower packet | Keep lower work on the continuous KL derivative/Fokker--Planck backend. | derivative candidate and side-condition contracts; cycle-60 raw derivative wrapper | `ASTIS.SALD.forward_KL.cycle65_lower_packet.kl_derivative` | `appendix.tex:168-228` | `sald.forward_kl.kl_derivative` | obligation |

Selected lower slice over `appendix.tex:168-228`:

| Source lines | Lean-facing target | Open backend |
|---|---|---|
| `appendix.tex:168-185` | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlDensityBoundaryObligation` | mass conservation, differentiating KL under the integral, SALD Fokker--Planck, boundary/no-flux integration by parts, `-FI` identification |
| `appendix.tex:187-208` | `SALD.forwardKlDerivativeCandidateContract`; target-transport side conditions | slowed target velocity, target integration by parts, Cauchy-Schwarz/Young with the exact `1/2` share, L2 velocity term |
| `appendix.tex:218-228` | `SALD.forwardKlScheduleTimeChangeObligation`; cycle-60 raw derivative wrapper | inverse-schedule chain rule, slowed-velocity square scaling, `dot{s}(t)*dot t(s(t))^2=dot{s}(t)^(-1)` |

No theorem statement, source label, coefficient, theorem status, SLT reuse
status, or analytic backend status changed.

## Cycle 65 Middle Continuous Forward-KL Audit

Middle synchronized the upper cycle-65 route with the Lean proof DAG and
theorem contract.  The new Lean-facing declarations are
`SALD.cycle65ForwardKlSkeletonMiddleContract` and
`SALD.cycle65ForwardKlSkeletonMiddleObligation`
(`sald.forward_kl.cycle65_middle_route_audit`).  They audit the same source
windows, add no theorem hypotheses, and keep the selected lower backend on
`sald.forward_kl.kl_derivative` over `appendix.tex:168-228`.

Source-to-Lean route:

| Source step | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:238-247` theorem display | `SALD.continuousForwardKlStatementContract`; `SALD.continuousSaldContract`; cycle-65 upper and middle obligations | theorem remains `contractOnly`; constants and labels unchanged |
| `appendix.tex:168-185` KL derivative and `-FI` term | `SALD.forwardKlDerivativeSideConditionContract`; `SALD.forwardKlDensityBoundaryObligation`; `sald.forward_kl.density_boundary_regular` | mass conservation, KL differentiation, SALD Fokker--Planck, boundary/no-flux integration by parts |
| `appendix.tex:187-208` slowed target transport and Young split | `SALD.forwardKlDerivativeCandidateContract`; `SALD.forwardKlDerivativeObligation`; `sald.forward_kl.kl_derivative` | target transport identity, integration by parts, Cauchy-Schwarz/Young analytic backend |
| `appendix.tex:210-228` LSI and inverse-schedule time change | `SALD.saldLsiKlFiDensityTestContract`; `probability.lsi_to_kl_fi`; `SALD.forwardKlScheduleTimeChangeObligation`; cycle-60 raw derivative wrapper | density-test LSI/KL/FI backend, inverse-function calculus, slowed-velocity square scaling |
| `appendix.tex:230-241` DV velocity-energy step | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.forwardKlDvFiniteLogMgfWitnessContract`; `sald.forward_kl.dv_energy_bound` | common space, AC, finite KL, selected-test measurability, finite log-mgf |
| `appendix.tex:244-252` Gronwall and theorem display matching | `SALD.saldGronwallEndpointCalculusContract`; `SALD.forwardKlGronwallSideConditionContract`; `sald.forward_kl.gronwall_application` | endpoint rewrites, coefficient regularity, exponent split, residual exponent drop |

Proof-DAG update:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 65 middle route audit | Verify `thm:forward-KL` in source order and keep lower work on continuous KL derivative. | cycle-65 upper route; cycle-64 ledger; cycle-60 derivative wrapper; LSI/DV/Gronwall interfaces | `SALD.cycle65ForwardKlSkeletonMiddleContract`; `SALD.cycle65ForwardKlSkeletonMiddleObligation`; `ASTIS.SALD.forward_KL.cycle65_middle_route_audit` | `main_body.tex:238-247`; `appendix.tex:164-252` | `thm:forward-KL`; cycle 65 lower handoff | obligation |

`SALD.continuousSaldContract`, `SALD.forwardKlProofDag`, and
`SALD.saldDependenciesForLabel "thm:forward-KL"` now include the cycle-65
middle audit.  Gronwall, DV, LSI/KL/FI, continuous Fokker--Planck/KL
derivative, EM interpolation, theorem status, and SLT reuse remain below
`formalized`.

## Cycle 65 Lower Continuous Forward-KL Pointwise Wrapper

Lower kept the selected packet on `sald.forward_kl.kl_derivative` and added a
proof-producing Lean wrapper for the pointwise theorem shape needed by the
continuous `thm:forward-KL` skeleton.

| Source step | Lean-facing declaration | Status |
|---|---|---|
| `appendix.tex:168-228`: after the analytic backend supplies the raw KL derivative split, mass conservation, first-term `-FI`, target Cauchy estimate, LSI/KL/FI comparison, slowed-velocity scaling, and inverse-schedule product identity at each `t`, derive the `t`-time pre-DV inequality pointwise. | `SALD.forwardKlPointwisePreDvDerivativeBoundOfRawKlFiVelocityScaling` | formalized local Real/order wrapper under explicit hypotheses |
| Register the wrapper as the cycle-65 lower handoff without promoting the Fokker--Planck/KL derivative backend. | `SALD.cycle65ForwardKlDerivativePointwiseLowerObligation`; `ASTIS.SALD.forward_KL.cycle65_derivative_pointwise_lower` | obligation plus compiled local wrapper |

The wrapper consumes `SALD.forwardKlPreDvDerivativeBoundOfRawKlFiVelocityScalingScalar`
pointwise.  It does not prove mass conservation, differentiation under the KL
integral, SALD Fokker--Planck, integration by parts, target transport,
Cauchy--Schwarz, LSI/KL/FI, inverse-function calculus, DV, Gronwall, or
`thm:forward-KL`.

## Cycle 66 Upper Discrete Forward-KL Route

Global phase judgment: cycle 65 passed reviewer/build, so no failed previous
cycle needs recovery. Phase 1 theorem-skeleton translation is stable enough for
this narrow discrete `thm:forward-KL-discrete` route audit, but not for broad
cited-theory, SDE, disintegration, or reusable API backfill. The single lower
packet that best reduces the remaining discrete theorem risk is
`SALD.discreteForwardKlAccumulatedErrorBridgeContract` /
`SALD.discreteForwardKlAccumulatedErrorBridgeObligation` /
`sald.discrete_forward_kl.accumulated_error_bridge` over
`appendix.tex:557-592` and `main_body.tex:309-323`.

Lean-facing update:

- `SALD.cycle66DiscreteForwardKlSkeletonUpperPacket` records the upper
  objective, mode discipline, non-goals, lower packet, and reviewer checklist
  for the discrete theorem route.
- `SALD.cycle66DiscreteForwardKlSkeletonObligation`
  (`sald.discrete_forward_kl.cycle66_discrete_route`) is listed by
  `SALD.discreteSaldContract`, which remains `contractOnly`.
- `SALD.cycle66DiscreteForwardKlSkeletonDag` is included in
  `SALD.discreteForwardKlProofDag` after the cycle-61 recovered discrete
  route.
- `SALD.cycle66DiscreteForwardKlDependencyNames` is included by
  `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"`.

Five slow interfaces checked before lower work:

| Backend | Lean-facing interface | Status |
|---|---|---|
| `lem:gronwall` | `SALD.saldGronwallEndpointCalculusContract`; `SALD.discreteForwardKlGronwallInstantiationContract`; cycle-56 pointwise Gronwall input | obligation |
| `lem:dv_variation` | `dvVariationalFormulaInterface saldDvVariationSource`; `SALD.saldDvFiniteLogMgfContract`; `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract` | source-cited plus obligations |
| `eq:LSI-KL-FI` | `SALD.saldLsiKlFiDensityTestContract`; `SALD.lsiKlFiDensityTestObligation`; `probability.lsi_to_kl_fi` | obligation |
| continuous KL derivative/Fokker--Planck | `SALD.forwardKlDerivativeSideConditionContract`; cycle-65 continuous route data | obligation, reused only as sibling context |
| EM interpolation FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; endpoint-law, conditional-drift, conditional-FP, and stitched-interval obligations | obligation |

Source-to-Lean route:

| Source step | Lean-facing route | Remaining obligation |
|---|---|---|
| `main_body.tex:299-323` theorem display | `SALD.discreteForwardKlStatementContract`; `SALD.discreteSaldContract`; cycle-66 upper obligation | theorem remains `contractOnly`; constants and labels unchanged |
| `appendix.tex:260-385` EM interpolation and conditional FP | `SALD.discreteForwardKlEmInterpolationSideConditionContract`; `sald.discrete_forward_kl.em_interpolation_fp` | Brownian/EM construction, regular conditional drift, density/AC, weak FP, stitched intervals |
| `appendix.tex:388-491` KL derivative, frozen defect, LSI | `SALD.discreteForwardKlDerivativeCandidateContract`; `SALD.frozenDeltaCrossLipSaldContract`; `SALD.saldLsiKlFiDensityTestContract`; cycle-51 scalar handoff | analytic KL derivative, frozen-defect specialization, LSI/KL/FI backend |
| `appendix.tex:493-523` DV velocity step | `SALD.discreteForwardKlDvFiniteLogMgfWitnessContract`; `sald.discrete_forward_kl.dv_velocity_bound` | common space, AC, finite KL, finite log-mgf, selected-test measurability |
| `appendix.tex:526-553` time-changed Gronwall input | `SALD.discreteForwardKlPostDvTimeChangedDerivativeScalar`; `SALD.discreteForwardKlPointwiseGronwallInputOfPostDvTimeChanged` | analytic inputs remain separate; compiled wrapper is local Real/order only |
| `appendix.tex:557-592`; `main_body.tex:309-323` Gronwall output and accumulation | `SALD.discreteForwardKlAccumulatedErrorBridgeContract`; `SALD.discreteForwardKlResidualIntegralDisplayBoundScalar`; `SALD.discreteForwardKlMainDisplayBoundScalar`; `sald.discrete_forward_kl.accumulated_error_bridge` | endpoint stitching, exponent split, residual exponent bound, `barGamma`/`barDelta` source identifications |

Proof-DAG pane:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 66 global judgment | No recovery; narrow discrete forward-KL route audit only; select accumulated-error bridge. | cycle-65 route; cycle-61 recovered route; cycle-61 lower residual display | `ASTIS.SALD.forward_KL_discrete.cycle66_global_phase_judgment` | `main_body.tex:299-323`; `appendix.tex:260-592` | cycle 66 handoff | obligation |
| Cycle 66 five-backend check | Recheck Gronwall, DV, LSI/KL/FI, continuous FP/KL derivative, and EM interpolation FP before lower work. | theorem-specific interfaces; cycle-64 ledger; cycle-65 sibling route | `ASTIS.SALD.forward_KL_discrete.cycle66_five_backend_check` | first-DAG sources plus `appendix.tex:260-592` | six theorem skeletons | obligation |
| Cycle 66 discrete route | Wire `thm:forward-KL-discrete` through EM conditional-FP, KL derivative/frozen-defect/LSI, DV velocity, time-changed Gronwall, and accumulated-error display matching. | cycle-51/56/61 discrete route data; five slow interfaces | `SALD.cycle66DiscreteForwardKlSkeletonObligation`; `ASTIS.SALD.forward_KL_discrete.cycle66_discrete_route` | `main_body.tex:299-323`; `appendix.tex:260-592` | `thm:forward-KL-discrete` | obligation |
| Cycle 66 lower packet | Keep lower work on the accumulated-error bridge and display matching. | cycle-56 pointwise input; cycle-61 residual-display wrapper; cycle-66 main-display wrapper; accumulated-error bridge contract | `ASTIS.SALD.forward_KL_discrete.cycle66_lower_packet.accumulated_error`; `SALD.cycle66DiscreteForwardKlAccumulatedDisplayLowerObligation` | `appendix.tex:557-592`; `main_body.tex:309-323` | `sald.discrete_forward_kl.accumulated_error_bridge` | proof-producing scalar wrapper plus obligation |

Selected lower slice:

| Source lines | Lean-facing target | Open backend |
|---|---|---|
| `appendix.tex:557-592` | `SALD.discreteForwardKlGronwallInstantiationContract`; `SALD.discreteForwardKlAccumulatedErrorBridgeContract` | endpoint-safe Gronwall application across stitched EM intervals; coefficient regularity; endpoint rewrites |
| `main_body.tex:309-317` | `SALD.discreteForwardKlGronwallInitialExponentSplitOfPieces`; `SALD.discreteForwardKlResidualExponentBoundScalar` | source exponent split and `barGamma` accumulation with the exact `2*r*eta^2/alpha'` coefficient |
| `main_body.tex:318-323` | `SALD.discreteForwardKlAlphaComplexityCollectionScalar`; `SALD.discreteForwardKlDeltaAccumulationScalar`; `SALD.discreteForwardKlResidualIntegralDisplayBoundScalar` | collection into `(1/r)*A_alpha(pi,v)+2*r*eta*barDelta_{alpha'}` after the common exponential bound |
| `main_body.tex:309-323` | `SALD.discreteForwardKlMainDisplayBoundScalar`; `SALD.cycle66DiscreteForwardKlAccumulatedDisplayLowerObligation` | final scalar/order composition from the supplied Gronwall initial term and supplied residual display to the exact two-term theorem display; endpoint stitching, residual exponent monotonicity, and `barGamma`/`barDelta` source identifications remain obligations |

No theorem statement, source label, coefficient, theorem status, SLT reuse
status, or analytic backend status changed.
