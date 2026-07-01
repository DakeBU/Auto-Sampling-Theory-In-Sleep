# ASTIS Proof Blueprint: ASTIS-CHEWI-001

Task id: `ASTIS-CHEWI-001`
Title: Build the Chewi Log-Concave Sampling Lean foundation
Updated: `2026-07-02 02:55:30`
Blueprint stage: `Log-concave sampling foundation Stage-1: chapter map, shared-root DAG, and Mathlib-ready leaf growth`

This is ASTIS's compact system-of-record snapshot for long-horizon Lean proof
automation.  It follows the LeanMarathon/QBE blueprint lesson, but the
correspondence surface is SDE/Sampling-specific: Lean declarations,
source-paper labels, proof obligations, ASTIS technical lemma memory,
SLT/SDE cited-result port audits, and
Lean-Markdown-LaTeX exports must stay synchronized.

## Current Directive

```text
Mode: `ASTIS-CHEWI-001` follows `Log-concave sampling foundation Stage-1: chapter map, shared-root DAG, and Mathlib-ready leaf growth`.
Current dynamic leaf: No reviewer blocker recorded yet; use source index and proof-obligation ledger.
Current illness area: No reviewer blocker recorded yet; use source index and proof-obligation ledger.
Upper/middle must retire stale leaves before assigning lower work.
Lower work should be one local Lean declaration/proof boundary at a time.
Reviewer accepts progress only through `python3 tools/astis.py check` plus source correspondence.
```

## Dynamic Leaf Queue

Lower agents should work on one item at a time.  If a leaf is stale, upper or
middle must retire it before spending more proof-search tokens.

| Leaf | Status |
|---|---|
| No reviewer blocker recorded yet; use source index and proof-obligation ledger. | candidate |

## Open Obligation Signals

```text
no compact obligation signals found
```

## Recent Packet Classifications

- `discharges-supplied-hypothesis`: 0
- `narrows-source-cited-boundary`: 0
- `rejected-wrapper-churn`: 0

## Proof Status Counts

- `blocked`: 0
- `contractOnly`: 34
- `formalized`: 286
- `obligation`: 1175
- `planned`: 9
- `sourceCited`: 16

## Lean Declaration Index

| Kind | Lean name | File |
|---|---|---|
| theorem | `measurable_renyiIntegrand` | `AutoSamplingTheory/TechnicalLemmas/InformationTheory/Renyi.lean:50` |
| theorem | `measurable_renyiIntegrandENNReal` | `AutoSamplingTheory/TechnicalLemmas/InformationTheory/Renyi.lean:61` |
| theorem | `lintegral_renyiIntegrandENNReal_ne_top_of_ae_le` | `AutoSamplingTheory/TechnicalLemmas/InformationTheory/Renyi.lean:69` |
| theorem | `hasDerivAt_renyiIntegrand` | `AutoSamplingTheory/TechnicalLemmas/InformationTheory/Renyi.lean:79` |
| def | `gibbsDensityENNReal` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:25` |
| theorem | `gibbsDensityENNReal_pos` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:29` |
| theorem | `gibbsDensityENNReal_lt_top` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:34` |
| theorem | `measurable_gibbsDensityENNReal` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:41` |
| theorem | `aemeasurable_gibbsDensityENNReal` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:48` |
| theorem | `lintegral_gibbsDensityENNReal_ne_zero` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:58` |
| theorem | `lintegral_gibbsDensityENNReal_ne_top_of_ae_le` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:72` |
| theorem | `gibbsDensityENNReal_le_of_potential_ge` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:82` |
| theorem | `gibbsDensityENNReal_ae_le_of_ae_potential_ge` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:88` |
| theorem | `lintegral_gibbsDensityENNReal_ne_top_of_ae_potential_ge` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:96` |
| theorem | `lintegral_gibbsDensityENNReal_ne_top_of_ae_ge_const` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:107` |
| theorem | `isProbabilityMeasure_withDensity_normalized_gibbs` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:122` |
| theorem | `isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_le` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:135` |
| theorem | `isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_potential_ge` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:151` |
| theorem | `isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_ge_const` | `AutoSamplingTheory/TechnicalLemmas/Measure/Gibbs.lean:165` |
| theorem | `lintegral_fin_nat_prod_eq_prod` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:31` |
| theorem | `lintegral_fintype_prod_eq_prod` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:75` |
| theorem | `pi_withDensity_prod` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:91` |
| theorem | `withDensity_univ_eq_lintegral` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:124` |
| theorem | `isProbabilityMeasure_withDensity_of_lintegral_eq_one` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:130` |
| theorem | `isFiniteMeasure_withDensity_of_lintegral_ne_top` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:138` |
| theorem | `lintegral_inv_lintegral_mul_eq_one` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:146` |
| theorem | `isProbabilityMeasure_withDensity_normalized_lintegral` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:156` |
| theorem | `withDensity_absolutelyContinuous_base` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:168` |
| theorem | `measurableEquiv_map_withDensity` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:175` |
| theorem | `withDensity_rnDeriv_eq_of_absolutelyContinuous` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:191` |
| theorem | `integrable_of_measure_eq` | `AutoSamplingTheory/TechnicalLemmas/Measure.lean:27` |
| theorem | `condDistribIntegralNamedFieldIntegral` | `AutoSamplingTheory/TechnicalLemmas/Probability/ConditionalKernel.lean:30` |
| inductive | `LemmaMemoryStatus` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:27` |
| structure | `LemmaMemoryEntry` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:37` |
| def | `sltSourceAnchor` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:48` |
| def | `analysisMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:56` |
| def | `gaussianMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:139` |
| def | `taylorMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:292` |
| def | `measureMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:325` |
| def | `stochasticProcessMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:549` |
| def | `klDensityMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:602` |
| def | `renyiDensityMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:625` |
| def | `variationalMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:668` |
| def | `geometryMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:691` |
| def | `saldExtractedMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:964` |
| def | `portQueueMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:1037` |
| def | `technicalLemmaMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:1060` |
| def | `formalizedTechnicalLemmaCount` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:1065` |
| theorem | `fpRewriteScalarAlgebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/FokkerPlanckAlgebra.lean:19` |
| theorem | `fisherIbpAlgebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/FokkerPlanckAlgebra.lean:33` |
| def | `finiteShiftedGaussianPathMeasure` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean:27` |
| def | `finiteGaussianGirsanovWeight` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean:33` |
| theorem | `finiteGaussianGirsanovCylinderIntegral` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean:44` |
| theorem | `finiteGaussianGirsanovCylinderMeasure_eq_withDensity` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean:56` |
| theorem | `integral_finiteGaussianGirsanovWeight_eq_one` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean:108` |
| theorem | `weakGeneratorFromSampleDerivative` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/WeakGenerator.lean:30` |
| theorem | `hessianOpNormOfSourceHessianField` | `AutoSamplingTheory/TechnicalLemmas/Taylor.lean:35` |
| theorem | `iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm` | `AutoSamplingTheory/TechnicalLemmas/Taylor.lean:51` |
| theorem | `stdOrthonormalBasisUnit` | `AutoSamplingTheory/TechnicalLemmas/Taylor.lean:68` |
| theorem | `quadraticVariationNormalizationOfCoeffDefAndVarianceOne` | `AutoSamplingTheory/TechnicalLemmas/Taylor.lean:75` |

## Correspondence Artifacts

| Artifact | Role |
|---|---|
| `tasks/ASTIS-CHEWI-001.md` | correspondence/system-of-record |
| `proof-blueprints/ASTIS-CHEWI-001.md` | correspondence/system-of-record |
| `research-wiki/sampling-sde-library/log_concave_sampling_overview.md` | correspondence/system-of-record |
| `research-wiki/lemma-dags/log_concave_sampling_foundation.md` | correspondence/system-of-record |
| `research-wiki/sampling-sde-library/roadmap/log_concave_sampling_to_lean_tree.md` | correspondence/system-of-record |
| `research-wiki/sampling-sde-library/lean-leaf-module-graph.md` | correspondence/system-of-record |
| `research-wiki/retrieval-index/ASTIS-CHEWI-001.json` | correspondence/system-of-record |
| `research-wiki/external-lean-libraries/log-concave-sampling-notes.md` | correspondence/system-of-record |
| `research-wiki/external-lean-libraries/lean-asymptotic-statistical-theory.md` | correspondence/system-of-record |
| `agent-briefs/log_concave_sampling_6h_execution_pack.md` | correspondence/system-of-record |
| `AutoSamplingTheory/TechnicalLemmas/Registry.lean` | correspondence/system-of-record |
| `runs/trials.jsonl` | correspondence/system-of-record |
| `proof-blueprints/ASTIS-CHEWI-001-blueprint-status.md` | correspondence/system-of-record |
| `paper-notes/AutoLeanInSleepSampling/markdown/status.md` | correspondence/system-of-record |
| `paper-notes/AutoLeanInSleepSampling/latex/sections/00_overview.tex` | correspondence/system-of-record |
| `docs/leanmarathon_reference_notes.md` | correspondence/system-of-record |
| `docs/self_reflection_and_efficiency.md` | correspondence/system-of-record |

## Source Contract Excerpt

```text
# Build the Chewi Log-Concave Sampling Lean foundation Task id: `ASTIS-CHEWI-001` Kind: `textbookReproduction` Mode: `faithfulTextbook + MathlibReadyFoundation` Status: `active-priority` ## Goal Reproduce the foundations needed for Sinho Chewi's `Log-Concave Sampling` in a scientifically organized, Mathlib-ready Lean tree. The goal is not to prove one SALD theorem. Chewi is the roadmap for the full Sampling/SDE arsenal; SALD, RMFLD, and future sampling papers are consumers of this foundation. Primary source: - Public PDF: https://chewisinho.github.io/main.pdf - Local PDF: `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Chewi-Log-Concave-Sampling/main.pdf` ## Source Discipline Chewi's notes are allowed to guide theorem ordering and proof strategy, but bottom-level Lean assumptions must be justified by Mathlib, source textbooks, primary papers cited by Chewi, or audited external Lean reference projects. Every reusable leaf must record: - source anchor or upstream theorem reference; - Mathlib/API search surface; - exact hidden regularity contracts; - target module and proposed declaration name; - proof route in small steps; - failure policy if the route does not clos...
```

## Gate Policy

- Textbook mode may not silently strengthen a mathematical statement to close Lean.
- Chapter summaries, shared-root DAGs, module cards, and retrieval indexes must stay synchronized.
- Algorithm chapters are consumers until their shared analytic roots compile locally.
- Lower workers compile one Mathlib-ready ASTIS-owned leaf or return one strictly smaller source-cited blocker.
- Reviewer accepts progress only through `python3 tools/astis.py check`, a precise proof obligation, a concrete port plan, or explicit rejection of an unsupported statement.


## Library And Run Entry Points

- Library overview: `research-wiki/sampling-sde-library/log_concave_sampling_overview.md`
- Master chapter/theorem DAG: `research-wiki/lemma-dags/log_concave_sampling_foundation.md`
- Blue/red status tree: `docs/assets/log_concave_sampling_status.svg`
- Six-hour execution pack: `agent-briefs/log_concave_sampling_6h_execution_pack.md`
- Launcher: `python3 tools/astis.py launch-log-concave-6h --hours 6 --wall-hours 24 --lower-count 3`


## External References

- LeanMarathon: https://github.com/YuanheZ/LeanMarathon
- LeanMarathon article: https://arxiv.org/abs/2606.05400
- Shared local LeanMarathon repo: `/home/nitanda_sub/mark/repos/outer_repos/automation_systems/LeanMarathon`
- Shared local LeanMarathon PDF: `/home/nitanda_sub/mark/repos/outer_papers/automation_systems/LeanMarathon-2606.05400.pdf`
