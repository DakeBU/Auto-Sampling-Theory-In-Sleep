# Riemannian Optimization contributor prompt

Use the following prompt to start a Codex/ChatGPT formalization session for the Riemannian Optimization Route.

---

You are working on the **Riemannian Optimization Route** of Samplinglib:

https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep

The primary mathematical source is Nicolas Boumal's *An Introduction to Optimization on Smooth Manifolds*. The goal is to formalize the book into the shared Samplinglib Lean graph while reusing genuinely common lower-level mathematics with the sampling and optimisation routes.

Before doing any work, read:

`docs/formalization-protocol.md`  
`.agents/skills/astis-substantive-advance/SKILL.md`  
`.agents/skills/astis-cross-library-coordination/SKILL.md`  
`Libraries/shared-foundations.yml`  
`research-wiki/frontier-cells/README.md`

Then inspect the latest collaboration dashboard:

`/progress/#riemannian`

Do not work from a stale chapter plan. Use the current repository graph and progress state.

Work on **one theorem-sized Frontier Cell at a time**. Choose a currently reachable Boumal theorem, definition/interface, or prerequisite that materially advances the route. Prefer foundational nodes with several downstream consumers over isolated terminal lemmas when the graph makes that useful.

Before introducing any Lean declaration, search Samplinglib and Mathlib, then inspect active shared Frontier Cells and `Libraries/shared-foundations.yml`.

The first major cross-route checkpoint is:

Chewi sampling §2.5 Riemannian Manifolds ↔ Boumal's geometric foundations.

Therefore be especially careful around manifolds, tangent spaces, differentials, Riemannian metrics, gradients, Hessians, exponential/retraction interfaces, and general analytic lemmas.

Do **not** conclude that two declarations are the same merely because both are called “Riemannian gradient” or “tangent space”. Compare their actual semantic theorem fingerprints and conventions.

Record one classification:

`reuse | adapt | missing | out_of_scope`

and one decision:

`reuse_existing | adapt_existing | new_route_local | new_canonical_shared | out_of_scope`

For an exact common theorem, reuse one canonical declaration.

For a near-equivalent theorem, factor the genuinely shared mathematical core and keep a small explicit Boumal/Chewi convention adapter.

If a missing lower-level theorem will be needed by another route, **do not prove a Riemannian-local copy**. Record `decision: new_canonical_shared`, create/reference one `route: shared` Frontier Cell, and make the Riemannian cell depend on it.

Register the cell under `research-wiki/frontier-cells/` before substantial implementation.

Follow exactly:

`claimed → proved_locally → independently_verified → stabilized → merged`

or, when necessary:

`blocked → strictly smaller child theorem → verification → re-entry`

A local Lean compile only permits `proved_locally`. The proving worker cannot certify its own independent verification.

Keep source-facing Boumal statements pinned to Boumal. Shared lower-level abstractions may be source-neutral, but a route theorem must not silently change assumptions or conventions just to fit a common API.

During exploration, work in isolated theorem modules with focused checks. Do not independently rewrite stable shared APIs, root registries, or common aggregators. Shared integration and API collision resolution belong to the single stabilization lane.

Start by reading the current `main`, the Riemannian dashboard state, Boumal's next reachable source nodes, existing Samplinglib/Mathlib geometry, and active shared cells. Select the next substantive Frontier Cell, perform the reuse audit first, and then implement the maximum legitimate mathematical advance under the ASTIS protocol.
