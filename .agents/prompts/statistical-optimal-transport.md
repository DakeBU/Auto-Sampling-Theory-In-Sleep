# Statistical Optimal Transport

Read `AGENTS.md`, `.agents/skills/astis-substantive-advance/SKILL.md`, `docs/formalization-protocol.md`, `docs/cross-domain-program.md`, `Libraries/frontloaded-shared-spine.json`, and `Libraries/shared-foundations.yml`. Use route `statistical-optimal-transport` and mode `faithfulPaper`.

The first priority is not to build an OT-local mini-library. Statistical OT Chapter 1 is the principal early producer of the canonical coupling/Wasserstein floor consumed immediately by Chewi Sampling §1.3. Audit and reuse existing Samplinglib/Mathlib coupling, marginal, finite-moment, gluing and transport-cost APIs before introducing anything new.

For Chapter 1, follow the front-loaded gates:

- §§1.1-1.3 consume/produce `sf-measure-map-integral` and `sf-coupling-wasserstein`;
- §1.4 Brenier consumes the shared Euclidean convex/subgradient floor but keeps its OT-specific hypotheses and optimal-map conclusion source-facing;
- §§1.5-1.6 consume `sf-convex-duality`. If the exact needed conjugacy/Fenchel lemma lives in Optimization Chapter 9, pull **only that prerequisite** forward into a shared cell. This gives no Chapter-9 completion credit and does not identify Kantorovich duality with Fenchel duality without an explicit adapter.

OT Chapter 2 should reuse `sf-empirical-concentration` together with the canonical Wasserstein core. Empirical-measure bookkeeping and basic concentration can be shared with Sampling §2.4; dyadic partitions, chaining, smooth-measure rates and minimax statistical arguments remain OT-local unless an exact theorem match is demonstrated. Statistical sample size `n` is never a sampling oracle-query budget by notation alone.

Select one theorem-sized SAU from `Libraries/frontloaded-shared-spine.json` / `Libraries/cross-domain-program.json`. Search Samplinglib, Mathlib, active shared cells and compatible formal upstreams. If source proof details are insufficient, recover them from an exact authoritative background theorem and record all convention/assumption adapters in a schema-2 `source_detail_audit`. Shared missing lemmas get one `route: shared` cell.

A source chapter is not completed by importing shared prerequisites. Conversely, a shared source-neutral theorem is not owned by OT merely because OT exposed the need first.

The functor hypergraph is a conceptual overlay: no analogy or source-present Lean module is a proof certificate. Preserve the whole joint input set, hypotheses and primitive proof supports. Return a real compiled delta or typed obstruction, then independent verification and the single stabilization lane; do not label your own mathematical work verified.
