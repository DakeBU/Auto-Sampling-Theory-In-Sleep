# ASTIS-CHEWI-001 Cycle 022 Harness Summary

Date: 2026-07-13

## Frontier

Chapter 1 finite-box cutoff/exhaustion route for Langevin/Gibbs integration by
parts.

## Closed Leaves

1. `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Divergence.exists_contDiff_support_eq_univ_pi_Ioo`
   - Specializes Mathlib `IsOpen.exists_contDiff_support_eq` to finite
     Pi-open boxes.
   - Produces a smooth `[0,1]`-valued scalar function whose plain
     `Function.support` is exactly the open box.

2. `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Divergence.positive_on_univ_pi_Ioo_of_support_eq_univ_pi_Ioo`
   - Converts exact plain support plus `[0,1]` range into strict positivity at
     every point of the finite Pi-open box.

Compiled local technical lemma count: 230 -> 232.

## Reviewer Result

Reviewer/source-scout accepted the two-leaf packet as aligned with the Ch.1
cutoff frontier.

Reviewer warnings retained in docs and registry:

- The exact-support function is not a compact-support theorem.
- It does not provide `tsupport` containment.
- It does not prove a cutoff equal to `1` on an inner closed box.
- It does not choose an exhausting family, derivative bounds, tail passage,
  weighted IBP, generator domains, invariant law, reversibility, or KL/FI.

## Files Updated

- `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Divergence.lean`
- `Tests/Basic.lean`
- `AutoSamplingTheory/TechnicalLemmas/Registry.lean`
- `research-wiki/technical-lemmas/technical_lemma_registry.jsonl`
- `research-wiki/technical-lemma-memory/technical_lemma_registry.jsonl`
- `README.md`
- `research-wiki/sampling-sde-library/README.md`
- `research-wiki/sampling-sde-library/cards/AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Divergence.md`

Generated ASTIS graph, blueprint, and retrieval artifacts were refreshed.

## Verified Gates

- `lake env lean AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Divergence.lean`
- `lake env lean AutoSamplingTheory/TechnicalLemmas/Registry.lean`
- `lake build Tests`
- JSONL duplicate check: 113 entries in each ledger, no duplicate keys
- `python3 tools/astis.py module-graph-refresh`
- `python3 tools/astis.py lemma-dag-refresh`
- `python3 tools/astis.py blueprint-refresh ASTIS-CHEWI-001`
- `python3 tools/astis.py memory-refresh ASTIS-CHEWI-001 --cycle 22 --run-id 20260713-ASTIS-CHEWI-001-cycle022`
- final `lake build Tests`
- final `python3 tools/astis.py check`

Final whitespace and duplicate-key checks were run after this summary was updated.

## Next Red Edge

The next Ch.1 branch remains: build one smooth cutoff equal to `1` on an inner
closed Pi-box while staying controlled by an outer open/box support contract,
then assemble an exhausting cutoff family with derivative bookkeeping and tail
passage.
