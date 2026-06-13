# Agent Guide for Auto-Sampling-Theory-In-Sleep

This is a Lean-first SDE/Sampling proof project.  The repository is allowed to
contain theorem contracts and explicit proof obligations, but completed claims
must compile in Lean.

## Non-Negotiable Gate

```bash
python3 tools/astis.py check
```

The gate runs the Lake build and scans for fake proof closures.

## Operating Loop

1. Pick one task from `tasks/` or `AutoSamplingTheory/Automation.lean`.
2. Maintain a conversion window when translating between LaTeX, Markdown, and
   Lean.
3. Keep source labels indexed under `research-wiki/source-index/`.
4. Keep unproved analysis in `proof-obligations/` or
   `research-wiki/cited-results/`.
5. Keep task-local paper contribution memory separate from reusable technical
   lemma memory.  For SALD, unfinished source lines live in the canonical
   `research-wiki/paper-contributions/SALD/unfinished_source_map.md`; the old
   `research-wiki/paper-memory/ASTIS-SALD-001/` path is a compatibility mirror.
6. If using SLT-inspired results, first read
   `research-wiki/technical-lemmas/README.md` and search
   `AutoSamplingTheory/TechnicalLemmas`.  Then update
   `research-wiki/cited-results/SLT_reuse_audit.md` with port status and
   exact ASTIS local declarations.
7. Run the gate.
8. Log serious attempts with `tools/astis.py trial-log`.  Failed or partial
   lower attempts must include typed verifier feedback, for example
   `--feedback-field leaf=... --feedback-field error_class=...`.

## Layered Agent Roles

ASTIS uses lightweight inner cycles and bounded final-audit panels.  The goal
is not bureaucracy; it is to prevent one passive upper agent or one overloaded
middle agent from turning the loop into a handoff copier.

| Layer | Role | Responsibility |
|---|---|---|
| Upper | `upper_source_math` | Audits source anchors, assumptions, regularity, boundary conditions, and source-contract gaps. |
| Upper | `upper_proof_dag` | Chooses the root-to-leaf dependency path and retires stale leaves. |
| Upper | `upper_process_memory` | Audits repeated failures, stale memory, report usability, and wasted routes. |
| Upper | `upper_director` | Synthesizes the upper panel or, in lightweight mode, directly chooses one executable leaf. |
| Middle | `middle_source_correspondence` | Maintains source-to-Lean DAG, exact LaTeX line range, hypotheses, and theorem boundary. |
| Middle | `middle_technical_lemma` | Searches ASTIS TechnicalLemmas, retrieval index, Mathlib/SLT provenance, and prevents duplicate lemma invention. |
| Middle | `middle_report_export` | Keeps Chinese summaries, Markdown status, article updates, and technical-report snippets human-readable. |
| Middle | `middle_formalizer` | Synthesizes middle panel output into lower packets. |
| Lower | `lower_1` | Natural-language proof scout: route, dependencies, and theorem shape. |
| Lower | `lower_2` | Lean implementation worker: one compiled theorem or a strictly smaller source-cited boundary. |
| Lower | `lower_3` | Technical-lemma/API scout for the smallest background fact needed by the active leaf. |
| Lower | `lower_4` | Optional refiner after a concrete Lean failure; not enabled by default. |
| Reviewer | `reviewer_gate` | Deterministic Lean gate, source correspondence, and fake-closure rejection. |
| Reviewer | `reviewer_waste` | Final-audit progress-economics audit: detects wrapper churn, context replay, and low-value targets. |

The dialogue should show these names explicitly.  `agent-note` and `trial-log`
accept specialized roles such as `upper_source_math`, `middle_technical_lemma`,
and `lower_3`; do not collapse them back to the four base names when writing
handoffs.

Default `launch-sald-6h` cadence:

- inner cycles: `upper_director -> middle_formalizer -> lower_1/lower_2/lower_3 -> reviewer_gate`;
- final audit: upper panel -> `upper_director` -> middle panel -> `middle_formalizer` -> `reviewer_gate/reviewer_waste`.

In long SALD runs, lower agents should be independent Codex processes by
default.  The harness records each lower output under `runs/<run>/agent-logs/`
and counts active-agent time as the sum of lower process durations.  `lower_3`
should avoid editing the same SALD theorem block as `lower_2`; it should
produce a retrieval packet, ProofObligation, or isolated TechnicalLemmas patch
unless the middle coordinator explicitly assigns a code edit.

## Canonical Memory Protocol

ASTIS now follows ABEIS-style names where the function is similar, while the
semantics stay Sampling/SDE-specific.

| Function | Canonical path | Legacy mirror |
|---|---|---|
| Proof blueprint | `proof-blueprints/` | `research-wiki/blueprints/` |
| Paper contribution memory | `research-wiki/paper-contributions/SALD/` | `research-wiki/paper-memory/ASTIS-SALD-001/` |
| Technical lemma memory | `research-wiki/technical-lemmas/` | `research-wiki/technical-lemma-memory/` |
| Compact retrieval index | `research-wiki/retrieval-index/` | none |
| Typed verifier feedback | `verifier-feedback/` and trial-log feedback JSON | none |
| Agent briefs | `agent-briefs/` | none |

At the end of each completed proof cycle, the harness should refresh compact
memory and TODO state.  Human-facing Chinese summaries are written once at the
final 6h closeout, not after every inner cycle.

```bash
python3 tools/astis.py memory-refresh ASTIS-SALD-001 --run-id latest
python3 tools/astis.py project-article-update ASTIS-SALD-001 --run-id latest
```

`finalize-sald-cycle` and `sleep-run-window --after-latex` call this chain for
SALD; the finalizer additionally writes `cycle-zh-summary`.

For long `launch-sald-6h` windows, Chinese human summaries are written once at
the finalization step, not after every inner cycle.  Per-cycle memory and TODO
artifacts still refresh, but the human-facing report should be a clear 6h
executive report: conclusion first, exact blocker second, source-line and
technical-lemma details as evidence.

## Mode Discipline

`faithfulPaper` mode reproduces a paper.  Do not add assumptions, weaken the
statement, or replace the proof route without recording the exact source gap.

`exploratoryProof` mode validates active research.  Candidate proof routes can
compete, but success still requires a Lean-checkable target and reviewer audit.

## Review Discipline

Reject:

- `axiom`, `sorry`, `admit`, `Prop := True`, or `:= trivial` used to close math;
- hidden assumptions not present in the source proof;
- SLT/Mathlib dependencies marked as formalized before an ASTIS-owned local
  declaration builds;
- faithful tasks that do not update source-to-Lean correspondence;
- SALD completion claims whose unfinished paper leaves lack concrete LaTeX
  line ranges;
- lower-agent handoffs that cite a technical lemma before it exists as a
  compiled local declaration.
