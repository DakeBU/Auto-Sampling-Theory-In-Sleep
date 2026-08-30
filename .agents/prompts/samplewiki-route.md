# SampleWiki Route contributor prompt

Use the following prompt to start a Codex/ChatGPT formalization session for the SampleWiki Route.

---

You are working on the **SampleWiki Route** of Samplinglib:

https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep

Your goal is to make a real theorem-sized advance in the formalization of Sinho Chewi's *Log-Concave Sampling* and then reach useful SampleWiki frontier results through the shortest dependency-first route.

Before doing any mathematical work, read the current repository state and in particular:

`docs/formalization-protocol.md`  
`.agents/skills/astis-substantive-advance/SKILL.md`  
`.agents/skills/astis-cross-library-coordination/SKILL.md`  
`.agents/skills/astis-semantic-roundtrip/SKILL.md`  
`Libraries/shared-foundations.yml`  
`research-wiki/frontier-cells/README.md`

Also inspect the current dashboard and detailed SampleWiki route rather than relying on an old plan:

`/progress/#samplewiki`  
`/progress/samplewiki-detail.html`

Primary mathematical sources are Sinho Chewi's `main.pdf`, his official `supp.pdf`, and the exact primary papers behind the relevant SampleWiki cases. Background textbooks may be used to recover omitted standard details, but they must not silently change the source theorem.

Work on **one substantive theorem-sized Frontier Cell at a time**. Choose the smallest currently reachable cell that materially advances the dependency path toward useful SampleWiki results. Do not ask me to choose a theorem if the existing graph/progress state gives enough evidence for you to choose well.

Before creating any Lean declaration, perform the mandatory shared-floor audit. Search existing Samplinglib declarations, Mathlib, active `route: shared` Frontier Cells, and `Libraries/shared-foundations.yml`. Compare theorem semantics, not only names: objects, domains, quantifiers, assumptions, normalization, conclusion, and intended consumers.

Classify the candidate as `reuse`, `adapt`, `missing`, or `out_of_scope`, and record the corresponding decision.

If the missing lower-level theorem is also useful to Riemannian Optimization or Optimisation, **do not implement a SampleWiki-local duplicate**. Record `decision: new_canonical_shared`, open or reference one `route: shared` Frontier Cell, and make the SampleWiki cell depend on that shared cell.

Create/update the persistent Frontier Cell JSON under `research-wiki/frontier-cells/` before substantial implementation.

Follow the ASTIS state machine strictly:

`claimed → proved_locally → independently_verified → stabilized → merged`

If blocked:

`blocked → strictly smaller child theorem → verification → re-entry`

A blocked result must identify the exact mathematical/Lean obstruction and create or name a smaller child cell. Repeating the same failed proof route is not progress.

In `faithfulPaper` mode, never weaken, strengthen, or repair the source statement merely to make Lean compile. A compiled Lean proposition is not enough: source-facing results also require the semantic/source-fidelity workflow.

During exploration, prefer isolated theorem modules and focused tests. Do not casually edit shared aggregators, Registry/root interfaces, or another route's stable API. Shared integration belongs to the stabilization lane.

The proving worker may move a cell to `proved_locally` with real focused-check evidence, but must **not self-certify `independently_verified`**.

Keep the Frontier Cell record and PR template synchronized with actual evidence. Never claim a state beyond what has passed.

Start now by inspecting the latest `main`, the current SampleWiki dependency frontier, existing shared foundations, and available Lean declarations. Select the next substantive Frontier Cell, record its source/reuse audit, and then push the mathematics and Lean implementation as far as the protocol legitimately allows.
