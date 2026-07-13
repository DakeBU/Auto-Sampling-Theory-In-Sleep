# ASTIS-CHEWI-001 Cycle 18 Summary

Objective: continue the faithful `Log-Concave Sampling` Ch.1 finite-box cutoff
route by closing small smooth-cutoff/source-package leaves, without claiming
whole-space weighted integration by parts, invariant law, reversibility, or
semigroup-domain closure.

## Blue leaves added

| Declaration | File | Role |
|---|---|---|
| `exists_contDiff_cutoff_tsupport_subset_univ_pi_Ioo` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Divergence.lean:503` | local smooth real-valued cutoff inside a finite Pi-open box; `tsupport` stays in the box, the cutoff has compact support, takes values in `[0,1]`, and equals `1` at the chosen interior point |
| `integral_coordinateDivergence_toPi_box_eq_zero_of_scalar_support_subset_univ_pi_Ioo_of_fderiv` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Divergence.lean:1151` | scalar-support finite-box zero-integral handoff with the vector-field derivative specialized to canonical `fderiv ℝ G` |

## Registry and tests

- `AutoSamplingTheory/TechnicalLemmas/Registry.lean` records both leaves.
- `Tests/Basic.lean` smoke tests call both leaves.
- `formalizedTechnicalLemmaCount = 223`.
- Both JSONL lemma ledgers have 104 rows with no duplicate keys before refresh.

## Remaining boundary

The cycle does not build an exhausting cutoff family, derive concrete cutoff
derivative formulas for a chosen family, discharge trace integrability for that
chosen family, pass from boxes to whole space, prove weighted integration by
parts, or prove Gibbs invariance/reversibility.  Those remain red.
