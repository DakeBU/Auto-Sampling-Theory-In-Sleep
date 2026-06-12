# Attribution And Design Lineage

ASTIS is not a copy of any single automation system.  It is a Lean-first
SDE/Sampling proof workflow that combines several useful ideas while keeping a
stricter proof gate than empirical search systems.

| Source | What ASTIS borrows | What ASTIS changes | ASTIS advantage |
|---|---|---|---|
| [ARIS / Auto-claude-code-research-in-sleep](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep) | Long-window autonomous research loops, plain-file artifacts, durable handoffs, and independent reviewer passes. | The loop is aimed at Lean proof state, source correspondence, and proof obligations rather than experiments and paper drafting alone. | Runs are inspectable locally; a 6h batch finishes the current upper/middle/lower/reviewer cycle before exporting notes. |
| [Learning Beyond Gradients](https://github.com/Trinkle23897/learning-beyond-gradients) | Role-separated iterative improvement, trial memory, summaries, logs, rejected directions, and treating the maintained system as the object being improved. | ASTIS adapts the layered agent loop to proof work: upper chooses the proof objective, middle translates source/Lean state, lower edits one local target, and reviewer gates source correspondence and Lean correctness. | Later agents avoid replaying broad failed routes and can focus on the current proof boundary without losing the reviewer-agent safeguard. |
| [EoH](https://github.com/FeiLiu36/EoH) | Population-style search with initialization, variation, selection, and archive pressure. | ASTIS permits this only in `exploratoryProof` mode after a Lean-checkable target is fixed; `faithfulPaper` mode must not mutate the source theorem or proof target. | Candidate proof routes can compete for RMFLD-style drafts while SALD paper reproduction stays faithful. |
| [LeanMarathon](https://github.com/YuanheZ/LeanMarathon) and [arXiv:2606.05400](https://arxiv.org/abs/2606.05400) | Blueprint as system of record, target review, dynamic proof-DAG leaves, bounded workers, illness-area refiners, and deterministic gates. | ASTIS keeps a local proof blueprint under `proof-blueprints/` with a legacy mirror under `research-wiki/blueprints/`, rather than adopting GitHub/PR/Slurm as the mandatory execution substrate. | The control layer keeps long Lean runs focused without giving up local sleep-run reproducibility. |
| [MathCode](https://github.com/math-ai-org/mathcode) | Lean proof diagnostics, theorem-reuse memory, hidden-placeholder scans, and tree-of-subgoals planning. | Diagnostics are advisory; `python3 tools/astis.py check` remains the acceptance gate. | Reviewer agents can detect fake proof closure and broad rewrites cheaply before expensive long runs. |
| [lean-stat-learning-theory](https://github.com/YuanheZ/lean-stat-learning-theory) and [arXiv:2602.02285](https://arxiv.org/abs/2602.02285) | Mathlib-based proof style for probability, concentration, entropy duality, log-Sobolev/Poincare facts, and discretization statements. | Because the upstream toolchain differs, ASTIS uses it as an audited port/reference source rather than an immediate Lake dependency. | SDE/Sampling proofs can reuse nearby measure-theory engineering without silently importing incompatible code. |
| [Quantum-Computing-Block-Encoding](https://github.com/DakeBU/Quantum-Computing-Block-Encoding/tree/wip/ghl2025-faithful-20260518-0201) | The concrete upper/middle/lower/reviewer harness, local CLI, prompt decks, conversion windows, proof obligations, and proof-blueprint discipline. | ASTIS replaces quantum registers, circuit matrices, oracle contracts, and normalizer checks with laws, densities, transport velocities, KL/FI/LSI/PI contracts, Fokker--Planck identities, and Euler--Maruyama obligations. | ASTIS becomes a domain-specialized system for SDE/Sampling theory while preserving a proven Lean automation harness shape. |
| ABEIS-style internal harness naming | Compatible directory and command names for proof blueprints, agent briefs, verifier feedback, retrieval indexes, paper contribution memory, and technical lemma memory. | ASTIS does not copy a finite-matrix or non-Lean verifier.  The feedback schema is typed for Sampling/SDE proof work: source-line coverage, Lean build, Mathlib API, measure theory, regularity assumptions, technical lemmas, and closed theorem status. | A developer can switch between ASTIS and ABEIS with less naming overhead while ASTIS keeps its own proof semantics and domain-specific gates. |

## Mode Boundary

The EoH-style population element is deliberately separated from faithful paper
reproduction.

- In `faithfulPaper`, ASTIS may keep a small population of proof attempts for a
  fixed lemma, but it may not change the paper theorem, assumptions, constants,
  or proof target.
- In `exploratoryProof`, ASTIS may use candidate populations under
  `candidate-populations/` to compare proof routes or theoretical variants,
  provided the acceptance predicate is explicit and Lean-checkable.

## Agent Stack

The retained four-role loop is:

- `upper`: chooses mode, objective, non-goals, dynamic leaf, and memory
  compression.
- `middle`: maintains source-to-Lean and Lean-to-Markdown/LaTeX conversion,
  proof obligations, cited-result ledgers, and lower-ready packets.
- `lower`: edits one local Lean declaration, proof block, source-index item, or
  candidate route.
- `reviewer`: runs the deterministic gate, checks hidden assumptions, verifies
  source correspondence, rejects fake closure, and records the next blocker.

LeanMarathon improves the control logic of this stack, but it does not replace
the ARIS/LBG/EoH-style memory and exploration layers.  ASTIS's central
acceptance rule is stricter than all search heuristics: a mathematical claim is
accepted only through compiled Lean plus explicit source correspondence, or it
remains a named proof obligation.
