---
name: astis-formalize-paper
description: Turn one SDE/Sampling paper or proof block into a compiled Lean skeleton, proof obligation ledger, or proof increment.
argument-hint: "[paper key or task id] --target: Lean file"
---

# ASTIS Formalize Paper

Use this for faithful reproduction tasks such as `ASTIS-SALD-001`.

## Workflow

1. Identify the exact mathematical object: state space, law, density, target
   path, diffusion/flow, guide or reward, discretization, and error metric.
2. Classify the mode and phase. In `faithfulPaper`, do not change theorem
   statements, hypotheses, or rates. Phase 1 is a faithful transcript of
   theorem labels, constants, proof steps, and obligations. Phase 2, only after
   that transcript is complete, reorganizes reusable APIs for teaching, future
   SDE/Sampling papers, and `exploratoryProof` mode. In `exploratoryProof`,
   keep candidate assumptions and unresolved proof routes visible instead of
   promoting them to facts.
3. Build a source-contract audit before Lean work: source anchor, assumptions,
   named inequalities, cited results, equation labels, and proof dependencies.
4. Translate the source theorem and proof structure into a conversion window.
   Every source proof step must map to an existing Lean declaration, a planned
   local lemma, an external cited-result row, or a proof obligation. Maintain
   the reverse map as well: after lower/reviewer work, translate the current
   Lean declarations and remaining obligations back into Markdown/LaTeX notes.
5. Check the SLT reuse audit before formalizing probability/concentration
   facts. `YuanheZ/lean-stat-learning-theory` is a reference source, not an
   imported dependency, until the borrowed result builds locally.
6. Write Lean declarations conservatively. Heavy analytic facts should remain
   `ProofObligation` data until they are actually formalized.
7. Add or update a proof-DAG table for repeated arguments such as Gronwall,
   DV variational formula, LSI-to-KL/FI, Euler--Maruyama one-step error, or
   Feynman--Kac particle error.
8. Run `python3 tools/astis.py check`.
9. At the end of a multi-hour batch, after the final cycle and reviewer gate
   have completed, run `python3 tools/astis.py export-latex` to refresh the
   Overleaf-ready project article and SALD case appendix.

## Acceptance

- `python3 tools/astis.py check` succeeds.
- Source indexes and conversion windows match the paper labels.
- Unproved mathematical content is represented as explicit obligations.
- Reusable proof blocks are named and tracked instead of repeated informally.
- Phase 1 faithful-paper work is not displaced by broad API reorganization.
