# ASTIS-CHEWI-001 Cycle 17 Summary

Objective: continue the faithful `Log-Concave Sampling` Ch.1 finite-box cutoff
route without claiming whole-space integration by parts or invariant-law
closure.

## Blue leaves added

| Declaration | File | Role |
|---|---|---|
| `continuousOn_smul_vectorField_trace_of_component_continuousOn` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Divergence.lean:624` | diagonal component continuity implies closed-box continuity of the cutoff-smul product-rule trace |
| `continuousOn_smul_vectorField_trace_of_components` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Divergence.lean:661` | convenience wrapper from CLM-valued continuity of `chi'` and `G'` |
| `integral_coordinateDivergence_toPi_box_eq_zero_of_cutoff_eq_zero_off_univ_pi_Ioo_of_component_continuous` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Divergence.lean:1050` | component trace-continuity plus cutoff vanishing gives the finite-box zero integral handoff |
| `integral_coordinateDivergence_toPi_box_eq_zero_of_scalar_support_subset_univ_pi_Ioo_of_component_continuous` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Divergence.lean:1162` | scalar-support version of the component-continuity finite-box zero integral handoff |

## Registry and tests

- `AutoSamplingTheory/TechnicalLemmas/Registry.lean` now records the four leaves.
- `Tests/Basic.lean` smoke tests call all four leaves.
- `formalizedTechnicalLemmaCount = 221`.
- Both JSONL lemma ledgers are expected to have 102 rows after this cycle.

## Remaining boundary

The cycle does not construct a smooth cutoff, prove that a concrete textbook
cutoff/vector field supplies the component-continuity hypotheses, pass from
finite boxes to whole space, prove weighted integration by parts, or prove
Gibbs invariance/reversibility.  Those remain red.
