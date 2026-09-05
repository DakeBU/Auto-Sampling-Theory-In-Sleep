# Log-Concave Sampling canonical textbook-spine prompt

You are formalizing Sinho Chewi's *Log-Concave Sampling* as the canonical Samplinglib textbook spine. This is distinct from the SampleWiki frontier route: textbook prerequisite work may later be consumed by SampleWiki, but it is not attributed to a frontier paper.

Before doing any work, read:

- `AGENTS.md`
- `docs/formalization-protocol.md`
- `.agents/skills/astis-substantive-advance/SKILL.md`
- `.agents/skills/astis-cross-library-coordination/SKILL.md`
- `Libraries/frontloaded-shared-spine.json`
- `Libraries/shared-foundations.yml`
- `website/content/chapters.json`

For Chapters 1-2, **do not follow source order blindly when a prerequisite is already the natural responsibility of another textbook spine**. The intended cross-textbook critical path is:

1. Reuse the shared Euclidean/calculus/measure floor.
2. For §1.3, consume the canonical coupling/Wasserstein core co-developed from Statistical OT Chapter 1 rather than creating a second transport library.
3. For §1.4, join that transport core with the Sampling-owned semigroup/generator lane and shared scalar energy-dissipation lemmas; keep Wasserstein gradient flow distinct from Euclidean gradient flow.
4. For Chapter 2 convexity/strong-convexity/log-concavity prerequisites, reuse the Optimization Chapter-1 convex core with explicit density/potential adapters.
5. For §2.4, reuse empirical-measure/basic concentration leaves shared with Statistical OT Chapter 2 where statements genuinely coincide; keep isoperimetry and semigroup-specific arguments separate.
6. For §2.5, consume the minimal first-order manifold adapter extracted from Boumal Chapter 3. Do not rebuild tangent-space/metric/gradient infrastructure inside the sampling chapter.

A later chapter in another textbook may be pulled forward only at the exact theorem/interface required by this dependency path. This gives no chapter-completion credit to that source and cannot bypass its own assumptions.

For every candidate theorem, search Samplinglib → Mathlib → active shared cells → relevant audited formal upstreams before adding a new declaration. Classify `reuse | adapt | missing | out_of_scope` and decide `reuse_existing | adapt_existing | new_route_local | new_canonical_shared | out_of_scope`.

Exact shared statements get one canonical source-neutral declaration. Near matches get a common core plus explicit source adapters. False friends remain separate: Euclidean/geodesic/displacement/mixture convexity; Euclidean/Riemannian/Wasserstein gradients; deterministic maps/stochastic kernels; statistical samples/sampling oracle queries.

Keep Chewi's source-facing theorem pinned exactly. Background books may fill omitted details but may not silently replace the theorem. One theorem-sized Frontier Cell at a time; proving workers cannot self-assign independent verification.
