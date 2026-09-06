# ASTIS-CHEWI-001 Cycle 019 Harness Summary

## Frontier

Chapter 1 finite-box cutoff route for the Langevin/Gibbs integration-by-parts
chain.

The previous blue edge constructed a local smooth cutoff with topological
support contained in a finite Pi-open box.  The missing API bridge was that
downstream finite-box zero-face handoffs consume plain `Function.support`.

## Agent Split

| Layer | Responsibility | Outcome |
|---|---|---|
| upper/director | keep the cycle scoped to Ch.1 support/cutoff infrastructure | selected support-API bridges, not invariant law |
| middle/reviewer | audit whether `tsupport -> Function.support` is a valid small leaf | approved; recommended a direct cutoff-smul consumer bridge |
| lower Lean worker | compile the selected leaves and connect them to tests/registry | 3 local declarations compiled |
| reviewer gate | reject overclaims beyond finite-box support staging | no tail, weighted IBP, generator domain, invariant law, or reversibility claimed |

## External Lean Reference

`outer_repos/sampling_theory_sde/lean-stat-learning-theory` was updated with
`git pull --ff-only`; it was already up to date at
`216e578c9576bab6b0abc3ba6c65762536768e96`.

## New Blue Leaves

| Declaration | Role |
|---|---|
| `support_subset_univ_pi_Ioo_of_tsupport_subset_univ_pi_Ioo` | converts Mathlib topological-support containment into plain `Function.support` containment inside a finite Pi-open box |
| `exists_contDiff_cutoff_support_subset_univ_pi_Ioo` | packages local smooth cutoff existence with both `tsupport` and `Function.support` conclusions |
| `support_smul_subset_univ_pi_Ioo_of_scalar_tsupport_subset_univ_pi_Ioo` | directly feeds a scalar cutoff with `tsupport` inside the box into the cutoff-smul support handoff |

`formalizedTechnicalLemmaCount` is now `226`.

## Gates Run

```bash
lake env lean AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Divergence.lean
lake build Tests
python3 tools/astis.py module-graph-refresh
python3 tools/astis.py lemma-dag-refresh
python3 tools/astis.py blueprint-refresh ASTIS-CHEWI-001
```

The final global gate is run after memory refresh.

## Remaining Red Edge

The next Ch.1 frontier is still the actual cutoff/tail machinery:

- choose or organize an exhausting smooth cutoff family;
- prove the concrete derivative/continuity package for the selected cutoffs
  and vector fields;
- prove finite-box-to-whole-space tail or exhaustion passage;
- only then state weighted Gibbs integration by parts, generator-domain, and
  invariant-law theorems.
