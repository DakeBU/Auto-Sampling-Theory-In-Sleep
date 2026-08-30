# Optimisation contributor prompt

Use the following prompt to start a Codex/ChatGPT formalization session for the Optimisation Route.

---

You are working on the **Optimisation Route** of Samplinglib:

https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep

The primary formalization source is:

Sinho Chewi, *Lectures on Optimization*  
https://arxiv.org/pdf/2605.07006

Formalize Chewi's notes section by section. Bubeck, Beck, and Nesterov are background/cross-check references rather than the controlling public source. Mathlib, Optlib, and CvxLean are formal upstreams that must be searched before reproving existing mathematics.

Before starting, read:

`docs/formalization-protocol.md`  
`.agents/skills/astis-substantive-advance/SKILL.md`  
`.agents/skills/astis-cross-library-coordination/SKILL.md`  
`Libraries/shared-foundations.yml`  
`Libraries/FirstOrderOptimization/upstreams.yml`  
`research-wiki/frontier-cells/README.md`

Then inspect:

`/progress/#optimisation`

Use the current graph/progress state rather than a stale chapter schedule.

Advance **one theorem-sized Frontier Cell at a time**. Choose the smallest currently reachable theorem/interface that materially advances Chewi's notes and has useful downstream leverage.

Before adding a Lean declaration, search in this order:

Samplinglib → Mathlib → active shared Frontier Cells / `Libraries/shared-foundations.yml` → Optlib / CvxLean → route-local near-equivalent declarations.

Compare exact mathematical semantics rather than declaration names.

Record:

`classification: reuse | adapt | missing | out_of_scope`

and

`decision: reuse_existing | adapt_existing | new_route_local | new_canonical_shared | out_of_scope`

Important sampling intersections include:

Chewi Sampling §4.3 ↔ Optimisation §§1–3 and §9  
Chewi Sampling Chapter 8 ↔ Optimisation §8 Proximal methods  
Chewi Sampling Chapter 10 ↔ Optimisation §10 Mirror methods and §12 Stochastic optimization

These are **candidate intersections, not assumed equivalences**.

For example, a convexity/proximal/mirror lemma that is mathematically identical across the two fields should become one canonical shared Lean node. A sampling-specific Markov kernel, invariant-law argument, RGO construction, or stochastic correction remains route-specific.

If you discover a missing theorem needed by both Optimisation and Sampling, **do not implement a private Optimisation version**. Record `decision: new_canonical_shared`, open/reference one `route: shared` Frontier Cell, and make the current cell depend on it.

Register/update the Frontier Cell JSON before substantial implementation.

Use the ASTIS state machine:

`claimed → proved_locally → independently_verified → stabilized → merged`

If blocked:

`blocked → strictly smaller child theorem → verification → re-entry`

A blocked cell must identify the exact obstruction and a smaller child. Do not keep broadening the task or replaying an unchanged proof attempt.

In `faithfulPaper` mode, Chewi's exact theorem remains controlling. Background books may clarify the proof but cannot silently replace his assumptions or theorem statement.

Prefer focused compilation/tests during exploration. Do not independently edit root registries, shared aggregators, or stable common interfaces. Those changes are serialized during stabilization.

The proving worker may establish `proved_locally`, but **cannot self-assign `independently_verified`**.

Start now by inspecting the latest `main`, current Optimisation dashboard, Chewi's next reachable theorem(s), Mathlib/Optlib/CvxLean matches, and existing shared cells. Select the next substantive Frontier Cell, perform the complete reuse audit, register it, and then push the formalization forward as far as real evidence allows.
