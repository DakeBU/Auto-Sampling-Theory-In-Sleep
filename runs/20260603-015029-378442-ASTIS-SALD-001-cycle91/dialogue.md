# Dialogue: ASTIS-SALD-001 cycle 91

Append short role-tagged handoffs here.

## upper handoff

Global phase judgment: cycle 90 passed reviewer/build and needs no recovery. Phase 1 theorem-skeleton translation is stable enough for cited-theory backfill. The active lower packet still targets `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`; the single packet that now reduces the largest remaining proof risk is the conditional-kernel/named-law theorem boundary at `appendix.tex:1368-1377`, with the cycle-90 massTerm-to-constant-test blocker treated only as a consumer check for the same named law `hat rho_s = Law(hat X_s)`.

Faithful-paper objective: backfill the real Mathlib conditional-law boundary for `X_k^eta | hat X_s=x`. Middle should keep the conversion window on the paper definitions of `hat rho_s`, `bar b_{k,s}`, and the two component conditional integrals. Lower should try to compile one local theorem that uses `ProbabilityTheory.condDistrib` / `condExpKernel` plus the existing `AutoSamplingTheory.condDistribIntegralNamedFieldRegularity` to remove an older supplied component-field regularity hypothesis feeding `SALD.generalMovingTargetDiscreteConditionalKernelRegularityOfSwappedComponents` or `SALD.generalMovingTargetDiscreteEndpointConditionalDriftRegularityHandoff`. If that is too large, lower must record one exact missing theorem with imports and hypotheses, not another wrapper.

Mode discipline: `faithfulPaper`; do not change statements, constants, source labels, or theorem statuses. A declaration may be marked formalized only if it compiles locally under this Lake project. SLT files are reference-only; do not import the SLT repo or claim SLT reuse as formalized.

Non-goals: no broad theorem-route audit, no display algebra, no new reusable API layer, no source-index rebaseline, no work on `sald_version_2.tex`, and no scalar hmass wrapper unless it is used only to check that the same `hatRhoS = Measure.map (hatX s) P` marginal is feeding the conditional-law backend.

Lower packet: `discharges-supplied-hypothesis` if it removes supplied `KernelIntegralField`/component measurability/integrability hypotheses by instantiating the canonical `condDistrib` integral fields under `hatRhoS`; otherwise `narrows-source-cited-boundary` only if it names the smallest missing Mathlib theorem, imports, typeclass hypotheses, and source line. Anything that merely repackages existing `hcompatSwapped`, `hcondC`, `hcondScore`, `hmeasOfKernel`, or `hintOfKernel` assumptions is `rejected-wrapper-churn`.

Proof DAG:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Conditional kernel/named law | `condDistrib X_k^eta hatX_s P x` with `hatRhoS = P.map hatX_s` and named component fields a.e. equal to canonical conditional integrals | `Probability.Kernel.CondDistrib`, `Probability.Kernel.Condexp`, `StandardBorelSpace`, finite/probability law, `AEMeasurable` `hatX_s`/`X_k^eta`, joint-law integrability of frozen drift and score summands | Existing: `AutoSamplingTheory.condDistribIntegralNamedFieldRegularity`; target: component-field-to-`bar b_{k,s}` regularity without supplied component regularity | `appendix.tex:1368-1377` | `sald.general_moving_target_discrete.em_interpolation_fp`, `thm:general-moving-target-SALD-discrete`, `thm:forward-KL-discrete` | open lower packet |
| Named marginal consumer check | Same `hatRhoS = Law(hatX_s)` must be the law used by the constant weak-test mass route | `AutoSamplingTheory.lawMapIntegral`, `AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`, cycle-90 mapped-law mass lemmas | Existing: `SALD.discreteForwardKlPostLsiDerivativeBoundOfLawConstantTestMassScalar`; target only if needed: identify raw massTerm derivative with this concrete constant weak-test derivative | `appendix.tex:1358-1366` | `thm:forward-KL-discrete` pressure route | downstream consumer, not primary packet |
| Weak conditional FP | Generator-to-law weak-test derivative and source signs after conditional drift is constructed | conditional drift regularity, density/AC, admissible weak tests, parametric integral/generator calculus | Existing wrappers under `cycle77`/`cycle82`; no new work this packet | `appendix.tex:1379-1387` | discrete theorem skeletons | blocked until conditional-law packet improves |

Reviewer checklist: require the global phase judgment above, verify the packet stays on `sald.general_moving_target_discrete.em_interpolation_fp` and `appendix.tex:1368-1377`, reject supplied-hypothesis wrappers that do not discharge or strictly narrow an older hypothesis, confirm any missing theorem record names exact Mathlib imports and hypotheses, confirm no fake closures (`axiom`, `sorry`, `admit`, `Prop := True`, `:= trivial` as math), no SLT import or Lake drift, no theorem-status promotion, and run `python3 tools/astis.py source-index ASTIS-SALD-001` plus `python3 tools/astis.py check`.

## upper @ 2026-06-03 01:53:31

Global phase judgment: cycle 90 passed reviewer/build and needs no recovery; Phase 1 theorem-skeleton translation is stable enough for cited-theory backfill; keep the active packet on sald.general_moving_target_discrete.em_interpolation_fp over appendix.tex:1358-1387, narrowed to the conditional-kernel/named-law boundary at appendix.tex:1368-1377. Lower should compile one real condDistrib/condExpKernel theorem removing component-field regularity hypotheses or record the exact missing Mathlib theorem; source-index and astis check passed.

## middle @ 2026-06-03 02:07:01

Cycle 91 middle discharges-supplied-hypothesis for the conditional-kernel component-field route: compiled SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularity derives barB AEStronglyMeasurable/Integrable under hatRhoS from canonical condDistrib component integrals plus a.e. component version equalities. Remaining blocker is the SALD-specific hatRhoS-a.e. version equalities for condC/condScore and conditional-kernel compatibility/disintegration before endpoint weak-FP readiness. source-index and astis check passed.

## lower @ 2026-06-03 02:15:51

Cycle 91 lower discharges-supplied-hypothesis for the conditional-kernel versioning route: compiled SALD.generalMovingTargetDiscreteCondDistribNamedFieldAeEqOfSample and SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfSampleVersions, transporting sample-space component version equalities through hatRhoS=Law(hatXAtS) via MeasureTheory.ae_map_iff before applying the existing condDistrib named-drift regularity theorem. Remaining blocker is the SALD-specific sample-space conditional-expectation/disintegration equalities for condC/condScore, measurable equality-set side conditions, and conditional-kernel compatibility. source-index ASTIS-SALD-001 and astis check passed.


## reviewer @ 2026-06-03 02:18:43

Cycle 91 reviewer accepted: proof-diagnostics reported zero forbidden Lean hits; source-index ASTIS-SALD-001 and mandatory astis check passed. Classification discharges-supplied-hypothesis: lower compiled the condDistrib named-field ae_map_iff transport and sample-version drift-regularity route, reducing law-space component-version/component-field regularity assumptions behind appendix.tex:1368-1377. Remaining blocker is the SALD-specific sample-space conditional-expectation/disintegration equalities for condC/condScore, measurable equality-set side conditions for ae_map_iff, and conditional-kernel compatibility before endpoint weak-FP readiness. No fake closures, SLT import, Lake drift, theorem-status promotion beyond the compiled local DAG node, source-label drift, or wrapper churn found.

