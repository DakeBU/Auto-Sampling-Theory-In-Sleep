# ASTIS-CHEWI-001 Cycle 020 Harness Summary

## Frontier

Chapter 1 finite-box cutoff route for the Langevin/Gibbs integration-by-parts
chain.

Cycle 019 connected Mathlib `tsupport` output to plain `Function.support` and
cutoff-smul support.  This cycle pushed that bridge one step downstream to the
finite-box zero-face and zero-coordinate-divergence handoffs.

## Agent Split

| Layer | Responsibility | Outcome |
|---|---|---|
| upper/director | keep the cycle on finite-box support staging | selected only two thin `tsupport` handoffs |
| middle/reviewer | audit whether direct `tsupport` variants overclaim | approved; warned not to proliferate stronger `of_regularity` variants without demand |
| lower Lean worker | compile the handoffs and update tests/registry/ledger | 2 local declarations compiled |
| reviewer gate | reject tail/IBP/invariance claims | all new notes keep continuity, differentiability, and trace integrability explicit |

## External Lean Reference

`outer_repos/sampling_theory_sde/lean-stat-learning-theory` was checked with
`git pull --ff-only`; it was already up to date at
`216e578c9576bab6b0abc3ba6c65762536768e96`.

## New Blue Leaves

| Declaration | Role |
|---|---|
| `signedFaceTermSum_smul_eq_zero_of_scalar_tsupport_subset_univ_pi_Ioo` | scalar cutoff `tsupport` inside a finite Pi-open box implies the cutoff-smul finite-box signed face-term sum is zero |
| `integral_coordinateDivergence_toPi_box_eq_zero_of_scalar_tsupport_subset_univ_pi_Ioo` | scalar cutoff `tsupport` inside the box feeds directly into the finite-box coordinate-divergence zero handoff, with continuity/differentiability/trace integrability still explicit |

`formalizedTechnicalLemmaCount` is now `228`.

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

The next Ch.1 frontier is no longer a support-API mismatch.  It is the actual
analytic cutoff/tail work:

- choose or organize an exhausting smooth cutoff family;
- prove the concrete derivative/continuity package for those cutoffs and the
  selected Langevin vector fields;
- prove finite-box-to-whole-space tail or exhaustion passage;
- only then state weighted Gibbs integration by parts, generator-domain, and
  invariant-law theorems.
