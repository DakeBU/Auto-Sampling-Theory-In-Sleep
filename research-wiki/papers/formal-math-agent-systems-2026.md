# Formal-Math Agent Systems 2026

This card is shared by ABEIS, ASTIS, and AGNPIS. It records external systems
that are useful as retrieval, orchestration, or proof-translation references.
It is not a dependency declaration and does not authorize copying unverified
results into local proof closure.

## Local source locations

- Papers: developer checkout `outer_papers/automation_systems/agentic_theorem_proving_2026/`
- Repositories: developer checkout `outer_repos/automation_systems/agentic_theorem_proving_2026/`

## Reusable lessons

| Work | Useful mechanism | Local adoption rule |
| --- | --- | --- |
| Iteris | Explore--plan--execute research loop with project-local facts, task pools, logs, dashboard, and evolve-family state. | Borrow durable state layout and dashboards; keep domain verifier gates unchanged. |
| AlphaProof Nexus | Independent Lean subagents plus evolutionary coordination for hard open-problem proof search. | Borrow the evidence that evolutionary coordination can reduce hard-case cost; do not replace local proof-DAG/target-specific reviewer gates. |
| LeanSearch v2 | Global premise retrieval by sketch--retrieve--reflect, recovering theorem-level support sets. | Before proving a leaf from scratch, ask for Mathlib/external premise candidates and record which were tried. |
| Matlas | Semantic retrieval over mathematical statements with dependency context. | Use for paper/source discovery and theorem analogies; never treat a retrieved statement as formalized. |
| Rethlas + Archon | Natural-language reasoning system paired with Lean formalization, verifier service, DAG/dashboard, and multi-lane proving. | Keep natural-language and formal teams explicit; use NL sketches only after Lean or local domain verifier promotion. |
| Chain-of-States | Intermediate formal proof-state sequence between informal proof and tactics. | Middle agents should request state chains for hard translation leaves before sending lower Lean workers. |
| REAL-Prover | Retrieval-augmented stepwise Lean proving with proof-state/tactic pairs. | Lower Lean workers should receive retrieved premises plus local proof-state context, not just a theorem statement. |
| Herald | Natural-language annotations of Lean declarations using hierarchy and dependencies. | Human-facing summaries should annotate reusable leaves with dependency context and proof intuition. |
| AI for Mathematics survey | Distinguishes problem-specific mathematical systems from general-purpose reasoning systems. | Each project must justify domain-specific gates and not present itself as a generic prover. |

## Project-specific interpretation

- ABEIS: retrieval and NL/Lean cooperation serve block-encoding construction,
  cost ranking, Qiskit export, and Lean clean-block/unitarity certificates.
- ASTIS: retrieval should prioritize measure/probability/SDE regularity,
  KL/FI/LSI, weak-generator, and discretization lemmas.
- AGNPIS: retrieval should prioritize source-problem status, reduction gadgets,
  iff lemmas, certificate-size bounds, and known hardness templates.
