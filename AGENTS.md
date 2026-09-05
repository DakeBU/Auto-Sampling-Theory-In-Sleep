# Agent Guide for Auto-Sampling-Theory-In-Sleep

ASTIS is a Lean-first SDE/Sampling proof project. The repository may contain
source contracts and explicit proof obligations, but completed mathematical
claims must compile in Lean and match their cited source boundary.

## Non-Negotiable Gate

```bash
python3 tools/astis.py check
```

The gate runs the Lake build and scans for fake proof closures.

## Canonical Operating Model: ASTIS Harness

The active unit of work is a **Substantive Advance Unit (SAU)**: one bounded,
source-backed mathematical delta in the live theorem/Lean DAG. One generalist
Worker owns an SAU end to end. Source reading, proof design, Samplinglib/Mathlib
retrieval, counterexample search, Lean implementation, compiler diagnosis, and
local exposition are temporary modes, not permanent role boundaries.

The coordinator is a thin global arbiter. It must not replay full Worker
transcripts or reproduce proofs. It reads a bounded synthesis-first capsule,
assigns ownership, suppresses duplicate theorem targets, resolves cross-cell
conflicts, and admits verified work to the single stabilization queue.

The current state is inspected with:

```bash
python3 tools/astis_advance.py capsule
```

`tools/astis_advance.py` is the active Harness control plane.
`tools/astis_harness.py` remains the durable compatibility substrate for old
Upper/Middle/Lower/Reviewer artifacts, locks, append-only JSONL, interrupted-tail
recovery, exact-field memory, and old run replay. Legacy role names are execution
slot labels only. They do not restrict what an agent may notice, prove, refactor,
test, or explain, and a new theorem must not be routed through the old ladder
merely to manufacture handoff artifacts.

## Operating Loop

1. Reconcile source and theorem state. For the main textbook program, select a
   dependency-ready DAG delta rather than recovering a frontier from old prose:

   ```bash
   python3 tools/astis.py harness-reconcile
   python3 tools/astis_advance.py capsule
   ```

2. Propose or claim one SAU with an exact source anchor, theorem delta, truth
   boundary, DAG parents, frontier cell, owned files, target declarations, and
   focused checks. Semantic duplicates must share one owner rather than become
   parallel branches.
3. Let the owning Universal Worker cross all temporary modes needed to finish
   the mathematics. Run the smallest useful Lean check early.
4. Record bounded checkpoints. After the first occurrence and two unchanged
   repeats of the same route fingerprint and progress signature, the route is
   frozen for diagnosis. A fourth identical attempt is rejected; change the
   mathematical route or publish a strict blocker.
5. Return exactly one substantive outcome:
   - a compiled theorem edge;
   - a reusable compiled interface;
   - a compiled integration node joining existing parents; or
   - a typed obstruction that retires a route or strictly shrinks the remaining
     theorem boundary.
6. Publish cross-boundary ideas to the Discovery Ledger. Lemmas, interfaces,
   counterexamples, source gaps, refactors, conjectures, and process insights
   must survive Worker termination without silently becoming formal truth.
7. When several advances occupy the same connected frontier cell, any
   generalist Worker may temporarily perform **local frontier synthesis** and
   publish a `synthesis` discovery. This is an ephemeral mode, not a new fixed
   role. The global arbiter consumes validated cell syntheses before raw advance
   records.
8. Verify independently. The verifier must name the checked commit, Lean/source
   gate, source audit, and fake-closure scan. The proving Worker cannot publish
   its own `VERIFIED` transition.
9. Serialize repository integration. Exactly one stabilization owner may
   clean-port onto current `main`, modify shared imports/root tests, update the
   Registry/source correspondence/Underlying Lean Graph/site, and publish the
   canonical PR or merge commit.
10. Run the gate and refresh compact memory/TODO state.

Branches, commits, files, prompt count, longer logs, isolated smoke tests,
wrapper lemmas that restate assumptions, and repeated unchanged attempts are
observability data. They are not mathematical progress.

## Frontier Cells and the Master Bottleneck

Parallel exploration is organized by connected **frontier cells**: nearby SAUs
that share DAG parents, source anchors, theorem declarations, or integration
surfaces. This is a context-compression device, not a hierarchy of mathematical
ability.

- A Worker reads the local DAG slice, exact interfaces/errors, and validated
  discoveries for its cell, not the whole project transcript.
- A local synthesis records the cell graph delta, conflicts, retired routes,
  reusable discoveries, and next independent candidates.
- The global arbiter sees one bounded summary per cell and only opens raw
  evidence for unresolved cross-cell conflicts or stabilization decisions.
- Fanout, repeated spawning, and unchanged global decisions are bounded. When a
  cell has multiple active advances but no validated synthesis, or a Worker hits
  the no-progress threshold, the cell enters the arbiter queue instead of
  causing another blind spawn.
- Shared repository truth remains serialized even though mathematical
  exploration is parallel.

This keeps the useful FrontierAgent ideas—bounded parallelism, a task board,
structured reports, checkpoint/resume, and coordinator no-progress guards—while
retaining ASTIS-specific theorem-DAG truth, exact source contracts, Lean gates,
and graph provenance.

## Substantive Evidence Contracts

A `PROVED_LOCAL` packet must contain:

- `result_kind`: `theorem-edge`, `reusable-interface`, or `integration-node`;
- the exact theorem delta and Lean declaration names;
- the Lean files and focused checks that exercise those declarations;
- the remaining truth boundary;
- useful discoveries and downstream integration notes.

A `BLOCKED` packet must contain:

- a typed blocker class and exact residual problem;
- the strict reduction achieved relative to the assigned SAU;
- at least one of a smaller next delta, a retired route, a counterexample, or a
  minimal reproducer.

“Lean failed”, “more work is needed”, a broad literature note, or a handoff that
merely restates the original target is not an admissible blocker.

The canonical Worker packet is:

```text
.agents/skills/astis-substantive-advance/SKILL.md
```

## Conversion and Source Discipline

Maintain a conversion window when translating between LaTeX, Markdown, and
Lean. Keep source labels indexed under `research-wiki/source-index/`. Exact
assumptions, measures, spaces, domains, representatives, and source anchors may
not be paraphrased away by capsule compaction.

Keep unproved analysis in `proof-obligations/` or
`research-wiki/cited-results/`. Keep task-local paper contribution memory
separate from reusable technical-lemma memory. For SALD, unfinished source lines
live in the canonical
`research-wiki/paper-contributions/SALD/unfinished_source_map.md`; the old
`research-wiki/paper-memory/ASTIS-SALD-001/` path is a compatibility mirror.

When using SLT-inspired results, first read
`research-wiki/technical-lemmas/README.md`, search
`AutoSamplingTheory/TechnicalLemmas`, and update
`research-wiki/cited-results/SLT_reuse_audit.md` with the exact local port status
and ASTIS declarations.

## Mathlib-Ready Leaf Lemma Protocol

Reusable SDE/Sampling facts should be written as future Mathlib-ready leaf
lemmas. The immediate acceptance condition is still local: an ASTIS-owned
Lean declaration builds, or the result remains a named proof obligation. The
target shape should be general enough to survive outside one paper theorem
whenever possible.

A reusable technical-lemma packet records:

- one theorem or one strictly smaller source-cited boundary;
- proposed Lean name, namespace, file, and minimal imports;
- exact local ASTIS APIs and Mathlib declarations searched first;
- hidden regularity contracts: measurability, integrability, domination,
  smoothness, boundedness, positivity, conditional representative, and
  boundary/decay assumptions as needed;
- an intended proof route in at most seven steps;
- a failure policy.

Persistent failure is mathematical evidence. After two or three same-shape
failures, stop editing the script and diagnose the statement: missing
assumption, false theorem/counterexample risk, wrong representative, Mathlib API
mismatch, or target too large. A statement changes only when the diagnosis
identifies a real mathematical/source/API issue.

Entry points:

```bash
python3 tools/astis.py lemma-dag-refresh
python3 tools/astis.py module-graph-refresh
```

```text
docs/module-graph.svg
docs/mathlib_ready_leaf_protocol.md
research-wiki/sampling-sde-library/lean-leaf-module-graph.md
research-wiki/sampling-sde-library/cards/
research-wiki/external-lean-libraries/
research-wiki/lemma-dags/SDE_Sampling_skill_tree.md
research-wiki/lemma-dags/SALD_weak_fp_leaf_dag.md
research-wiki/lemma-dags/Pro_assimilated_leaf_targets.md
research-wiki/technical-lemmas/mathlib_ready_leaf_template.md
research-wiki/technical-lemmas/hidden_regularities.md
agent-briefs/mathlib_ready_leaf_packet.md
```

Before claiming a generic Sampling/SDE delta, read the corresponding module
card and reuse `Probability.lean`, `SDE.lean`, and
`AutoSamplingTheory/TechnicalLemmas/`. SALD/RMFLD files are consumers, not the
home of reusable background mathematics.

ATLAS v1 is searchable external memory, not a local proof certificate. Search
its pinned 26-book declaration inventory with:

```bash
python3 tools/atlas_memory.py search markov kernel --route samplewiki-route
python3 tools/atlas_memory.py search riemannian --route riemannian-optimization
python3 tools/atlas_memory.py search convex --route optimisation
```

Every returned item remains `external-reference`. Inspect its pinned source,
license, hypotheses, direct placeholders, and upstream evaluation before
porting. Do not use the source or index for commercial activity or to train,
fine-tune, distill, evaluate, or otherwise develop ML models.
Before using a candidate, port only the minimal needed statement. It becomes
callable Lean truth only after an ASTIS-owned declaration compiles, is tested,
and enters the Registry.

## Canonical Memory Protocol

| Function | Canonical path | Legacy mirror |
|---|---|---|
| Proof blueprint | `proof-blueprints/` | `research-wiki/blueprints/` |
| Paper contribution memory | `research-wiki/paper-contributions/SALD/` | `research-wiki/paper-memory/ASTIS-SALD-001/` |
| Technical lemma memory | `research-wiki/technical-lemmas/` | `research-wiki/technical-lemma-memory/` |
| Compact retrieval index | `research-wiki/retrieval-index/` | none |
| Typed verifier feedback | `verifier-feedback/` and trial-log feedback JSON | none |
| Agent briefs | `agent-briefs/` | none |
| Substantive-advance ledger | `runs/substantive_advances.jsonl` | old role artifacts remain readable |
| Discovery/synthesis ledger | `runs/substantive_discoveries.jsonl` | none |

At the end of a completed proof cycle, refresh compact memory and TODO state.
Human-facing Chinese summaries are written once at the final long-run closeout,
not after every inner action.

```bash
python3 tools/astis.py memory-refresh ASTIS-SALD-001 --run-id latest
python3 tools/astis.py project-article-update ASTIS-SALD-001 --run-id latest
```

Old `launch-sald-6h` profiles may still expose `upper`, `middle`, `lower_*`, and
`reviewer` keys for replay compatibility. Treat those keys as parallel
execution slots hosting Universal Workers and independent verification—not as a
permission system. New orchestration should write SAU/discovery state first and
should not require every slot to run on every theorem.

## Mode Discipline

`faithfulPaper` reproduces a cited source. Do not add assumptions, weaken the
statement, or replace the route without recording the exact source gap.

`exploratoryProof` validates active research. Candidate routes may compete, but
success still requires a Lean-checkable target, explicit truth boundary, and
independent review. EoH-style populations are allowed only for fixed targets in
this mode; they may not mutate a faithful theorem until it becomes provable.

## Review Discipline

Reject:

- `axiom`, `sorry`, `admit`, `Prop := True`, or `:= trivial` used to close
  mathematics;
- hidden assumptions not present in the source proof;
- SLT/Mathlib dependencies marked formalized before an ASTIS-owned local
  declaration builds;
- faithful tasks that do not update source-to-Lean correspondence;
- completion claims whose unfinished paper leaves lack concrete LaTeX line
  ranges;
- packets that cite a technical lemma before it exists as a compiled local
  declaration;
- self-verification by the SAU owner;
- vague BLOCKED returns or unchanged retry loops;
- local Workers editing shared aggregation/site truth outside stabilization;
- a global coordinator that re-reads all transcripts instead of using bounded
  frontier-cell syntheses.


## Cross-domain routes and source detail audit

Statistical Optimal Transport and Higher-Order Smoothness × Sampling are coordinated with the existing routes. Read `docs/cross-domain-program.md`; use `Libraries/cross-domain-program.json` for dependency-ready shared work. New Frontier Cells use schema 2 with `source_detail_audit`. Search formal libraries first; when textbook detail is omitted, consult exact background theorems and record hypotheses/conventions instead of silently changing the target. Conceptual transport hyperedges are not Lean dependencies or certified functors. Upper-bound integrator and lower-bound oracle-hardness lanes remain independent until their comparison contracts match.
