# ASTIS Multi-Agent Orchestration Audit

This note records the 2026-06-13 audit of recent SALD 6h loops.

## Diagnosis

The old prompt deck had one upper agent, one middle agent, several lower
agents, and one reviewer.  Recent cycle logs show that this was too weak for
long Sampling/SDE formalization runs.

- The upper agent often acted as a dispatcher.  It translated the latest
  reviewer blocker into the next lower packet, but did not consistently ask
  whether that packet was still the best global target.
- The middle agent was overloaded.  It had to maintain source-line mapping,
  theorem boundaries, technical lemma lookup, Lean/Markdown/LaTeX conversion,
  and report writing.  In practice this encouraged ledger copying.
- Lower agents were already partially specialized, but the harness collapsed
  `lower_1` and `lower_2` into the generic role `lower` in trial memory.
  That made collaboration harder to audit.
- The reviewer enforced the Lean gate, but it did not separately audit
  opportunity cost, repeated wrapper churn, or whether agents replayed old
  context instead of closing the active leaf.
- The 6h Chinese report contained the needed evidence, but the order was hard
  for humans: details and handoff text appeared before a clean answer to
  "what changed, what is still blocked, and why?"

## New Prompt Deck

Inner proof-search cycles use a lightweight deck; final audit cycles use
bounded panels.

| Role | Job |
|---|---|
| `11_upper_source_math` | Source, assumptions, regularity, boundary conditions, conditional-law choices. |
| `12_upper_proof_dag` | Root theorem, dependency path, active leaf, stale leaf retirement. |
| `13_upper_process_memory` | Repeated failures, stale memory, report usability, wasted routes. |
| `10_upper_director` | Synthesis into one executable decision. |
| `21_middle_source_correspondence` | Exact source-line to Lean-boundary mapping. |
| `22_middle_technical_lemma` | Technical lemma memory, Mathlib/SLT provenance, port status. |
| `23_middle_report_export` | Chinese report, Markdown/LaTeX status, technical report snippets. |
| `20_middle_formalizer` | Synthesis into lower packets. |
| `lower_1` | Natural-language proof route and dependency analysis. |
| `lower_2` | Lean implementation of one theorem or one smaller boundary. |
| `lower_3` | Technical-lemma/API scout for the smallest background fact needed by the active leaf. |
| `lower_4` | Optional refiner after a concrete Lean failure; not enabled by default. |
| `reviewer_gate` | Deterministic Lean/source/fake-closure gate. |
| `reviewer_waste` | Audits wasted time, duplicate wrappers, and low-value targets. |

The specialized role name is now preserved in `agent-note`, `trial-log`, and
the CSV trial summary.

The default 6h cadence mirrors ABEIS only at the harness level:

- inner cycles keep panels off and run proof work with three lower roles;
- final audit runs upper and middle panels plus `reviewer_waste`;
- inner panels are enabled only when source correspondence, proof-DAG focus,
  technical-lemma memory, or human reports drift.

ASTIS-specific difference: the middle panel is not about finite-matrix
verification.  It is about analysis proof boundaries: laws, kernels,
conditional representatives, measurability, integrability, Fokker--Planck,
Ito/Taylor, KL/FI/LSI/PI, and boundary terms.

## Reporting Rule

The 6h Chinese report should be an executive report first and a proof ledger
second:

1. completion status;
2. real progress in this window;
3. current exact blocker;
4. whether the run wasted effort;
5. next high-level decision for the human;
6. source-line and technical-lemma tables as evidence.

Per-cycle memory refreshes remain useful for the harness, but the human-facing
Chinese summary is generated once at the final 6h closeout.

## Success Criteria For The Next 6h Run

The new orchestration is useful only if the final dialogue shows:

- `upper_source_math`, `upper_proof_dag`, and `upper_process_memory` produced
  distinct final-audit signals;
- `upper_director` chose a single source-line leaf rather than a broad area;
- `middle_source_correspondence`, `middle_technical_lemma`, and
  `middle_report_export` produced different information;
- lower work either compiled one theorem or strictly narrowed one boundary;
- `reviewer_waste` recorded whether any time was spent on wrapper churn,
  context replay, or non-active targets.
