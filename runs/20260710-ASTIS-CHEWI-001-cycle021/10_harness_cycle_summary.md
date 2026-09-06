# ASTIS-CHEWI-001 Cycle 021 Harness Summary

## Frontier

Chapter 1 cutoff/exhaustion route for the Langevin/Gibbs integration-by-parts
chain.

Cycles 019-020 closed the support-API mismatch from Mathlib `tsupport` to the
finite-box zero-face and zero-integral handoffs.  This cycle begins the next
red edge by adding the closed-inner-box / open-outer-box bookkeeping needed for
local cutoff construction during exhaustion arguments.

## Agent Split

| Layer | Responsibility | Outcome |
|---|---|---|
| upper/director | move from support wrappers to the first exhaustion prerequisite | selected inner closed box inside outer open box leaves |
| middle/reviewer | audit whether the leaves overclaim a full cutoff family | approved; warned not to claim `χ = 1` near `x` or on the whole inner box |
| lower Lean worker | compile the set-containment and pointwise cutoff wrapper | 2 local declarations compiled |
| reviewer gate | keep tail/IBP/invariance out of scope | notes explicitly exclude exhausting families and whole-space limits |

## External Lean Reference

`outer_repos/sampling_theory_sde/lean-stat-learning-theory` was checked with
`git pull --ff-only`; it was already up to date at
`216e578c9576bab6b0abc3ba6c65762536768e96`.

## New Blue Leaves

| Declaration | Role |
|---|---|
| `Icc_subset_univ_pi_Ioo_of_strict_bounds` | proves an inner closed Pi-box is contained in a coordinatewise strictly larger open Pi-box |
| `exists_contDiff_cutoff_support_subset_outer_univ_pi_Ioo_of_mem_Icc` | for a point in the inner closed box, constructs a local smooth cutoff with support and topological support inside the outer open box |

`formalizedTechnicalLemmaCount` is now `230`.

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

The current closed-box/open-box bridge is still pointwise.  The next Ch.1
frontier is:

- construct or identify a smooth cutoff equal to `1` on a whole inner closed
  Pi-box with support in a larger open Pi-box;
- organize a genuine exhausting cutoff family;
- prove derivative/continuity packages for the chosen cutoffs;
- prove tail/exhaustion passage before stating whole-space weighted IBP or
  invariant Gibbs law.
