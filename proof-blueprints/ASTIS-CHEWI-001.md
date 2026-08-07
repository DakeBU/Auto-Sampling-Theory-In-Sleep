# ASTIS Proof Blueprint: ASTIS-CHEWI-001

Task id: `ASTIS-CHEWI-001`
Title: Build the Log-Concave Sampling Lean foundation
Updated: `2026-08-07`
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
Current dynamic leaf: none in the audited Chapter 1 graph; all dependency-ready local analytic and cutoff leaves compile.
Current main-line blocker: concrete Langevin Markov semigroup construction and semigroup-stable domain extension; this is an external/upstream dependency, not a lower-agent-ready proof leaf.
Upper/middle must retire stale leaves before assigning lower work.
Lower work should be one local Lean declaration/proof boundary at a time.
Reviewer accepts progress only through `python3 tools/astis.py check` plus source correspondence.
```

## Dynamic Leaf Queue

Lower agents should work on one item at a time.  If a leaf is stale, upper or
middle must retire it before spending more proof-search tokens.

| Leaf | Status |
|---|---|
| radial second-derivative/Laplacian cutoff scaling | compiled local |
| typed Poincaré probability/test/integrability interface | compiled local |
| Poincaré inequality elimination and constant/test-class monotonicity | compiled local |
| concrete Langevin Markov semigroup construction | external/upstream dependency |
| semigroup-stable domain/core extension | blocked by concrete semigroup |
| invariant normalized Gibbs law | blocked by domain extension |
| Bakry–Émery Poincaré criterion | external-blocked by semigroup/domain package |
| localization and sharp log-concave isoperimetry | external/upstream dependency |

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
| theorem | `measurableEquiv_map_withDensity` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:193` |
| theorem | `withDensity_rnDeriv_eq_of_absolutelyContinuous` | `AutoSamplingTheory/TechnicalLemmas/Measure/RadonNikodym.lean:209` |
| theorem | `integrable_of_measure_eq` | `AutoSamplingTheory/TechnicalLemmas/Measure.lean:32` |
| theorem | `condDistribIntegralNamedFieldIntegral` | `AutoSamplingTheory/TechnicalLemmas/Probability/ConditionalKernel.lean:30` |
| inductive | `LemmaMemoryStatus` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:36` |
| structure | `LemmaMemoryEntry` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:46` |
| def | `sltSourceAnchor` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:57` |
| def | `analysisMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:65` |
| def | `gaussianMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:288` |
| def | `taylorMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:441` |
| def | `calculusMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:474` |
| def | `measureMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:1357` |
| def | `stochasticProcessMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:1721` |
| def | `klDensityMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:2024` |
| def | `renyiDensityMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:2047` |
| def | `variationalMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:2090` |
| def | `geometryMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:2113` |
| def | `saldExtractedMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:2496` |
| def | `portQueueMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:2569` |
| def | `technicalLemmaMemory` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:2592` |
| def | `formalizedTechnicalLemmaCount` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean:2597` |
| theorem | `fpRewriteScalarAlgebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/FokkerPlanckAlgebra.lean:19` |
| theorem | `fisherIbpAlgebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/FokkerPlanckAlgebra.lean:33` |
| def | `finiteShiftedGaussianPathMeasure` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean:27` |
| def | `finiteGaussianGirsanovWeight` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean:33` |
| theorem | `finiteGaussianGirsanovCylinderIntegral` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean:44` |
| theorem | `finiteGaussianGirsanovCylinderMeasure_eq_withDensity` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean:56` |
| theorem | `integral_finiteGaussianGirsanovWeight_eq_one` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Girsanov.lean:108` |
| theorem | `hasDerivAt_gibbsWeight_mul_testDeriv_eq_langevinGenerator_1d` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:43` |
| theorem | `deriv_gibbsWeight_mul_testDeriv_eq_langevinGenerator_1d` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:61` |
| theorem | `weightedDivergence_gibbsWeight_langevinGenerator_algebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:78` |
| theorem | `expNeg_weightedDivergence_langevinGenerator_algebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:95` |
| theorem | `finiteCoord_weightedDivergence_langevinGenerator_algebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:114` |
| theorem | `finiteCoord_named_weightedDivergence_langevinGenerator_algebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:147` |
| theorem | `finiteCoord_toLpInner_weightedDivergence_langevinGenerator_algebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:170` |
| theorem | `finiteCoord_euclideanInner_weightedDivergence_langevinGenerator_algebra` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:201` |
| theorem | `finiteEuclidean_langevinGenerator_basisDisplay` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:227` |
| theorem | `finiteEuclidean_langevinGenerator_coordinateDisplay` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:257` |
| theorem | `finiteEuclidean_weightedDivergence_langevinGenerator_basisHandoff` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:274` |
| theorem | `finiteEuclidean_weightedDivergence_langevinGenerator_coordinateHandoff` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:321` |
| theorem | `finiteEuclidean_expNeg_weightedDivergence_langevinGenerator_basisHandoff` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:374` |
| theorem | `finiteEuclidean_expNeg_weightedDivergence_langevinGenerator_coordinateHandoff` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:409` |
| theorem | `finiteEuclidean_expNeg_lineDeriv_fderiv_coordinateSum_langevinGenerator_display` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:454` |
| theorem | `finiteEuclidean_expNeg_lineDeriv_fderiv_coordinateSum_langevinGenerator_display_of_differentiableAt` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:521` |
| theorem | `coordinateDivergence_expNeg_fderivCoordinateField_langevinGenerator_display_of_differentiableAt` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:549` |
| theorem | `trace_expNeg_fderivCoordinateField_langevinGenerator_display_of_hasFDerivAt` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:582` |
| theorem | `continuousOn_expNeg_langevinGenerator_rhs_of_components` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:629` |
| theorem | `only` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:665` |
| theorem | `continuousOn_expNeg_langevinGenerator_rhs_of_contDiff` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:674` |
| theorem | `hasFDerivAt_expNeg_fderivCoordinateField_of_differentiableAt` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:725` |
| theorem | `hasFDerivAt_expNeg_fderivCoordinateField_of_contDiff` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:770` |
| theorem | `integrableOn_trace_expNeg_fderivCoordinateField_of_continuousOn` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:804` |
| theorem | `integrableOn_trace_expNeg_fderivCoordinateField_of_component_continuousOn` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:868` |
| theorem | `integrableOn_trace_expNeg_fderivCoordinateField_of_contDiff` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:927` |
| theorem | `integrableOn_trace_expNeg_fderivCoordinateField_of_contDiff_fderiv` | `AutoSamplingTheory/TechnicalLemmas/StochasticProcesses/Langevin.lean:973` |
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
# Build the Log-Concave Sampling Lean foundation Task id: `ASTIS-CHEWI-001` Kind: `textbookReproduction` Mode: `faithfulTextbook + MathlibReadyFoundation` Status: `active-priority` ## Goal Reproduce the `Log-Concave Sampling` textbook route in a scientifically organized, Mathlib-ready Lean tree. The project follows the textbook itself: chapter order, theorem statements, constants, cited background sources, hidden regularity assumptions, and proof dependencies. Primary source: - Public PDF: https://chewisinho.github.io/main.pdf - Local PDF: `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Chewi-Log-Concave-Sampling/main.pdf` ## Source Discipline The textbook is allowed to guide theorem ordering and proof strategy, but bottom-level Lean assumptions must be justified by Mathlib, source textbooks, primary papers cited by the textbook, or audited external Lean reference projects. Every reusable leaf must record: - source anchor or upstream theorem reference; - Mathlib/API search surface; - exact hidden regularity contracts; - target module and proposed declaration name; - proof route in small steps; - failure policy if the route does not close. Do not silently strengthe...
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
