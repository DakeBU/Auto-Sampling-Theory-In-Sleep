# Self-Reflection and Efficiency Rules

ASTIS should spend long autonomous runs on source-backed theorem progress, not
on replaying history or manufacturing role-local artifacts. The current Harness
measures progress at the level of the formal graph and treats context as a
finite research resource.

## 1. Evidence from ASTIS's own logs

### Post-cycle-98 SALD waste pattern

The earlier SALD audit found that Upper, Middle, Lower, and Reviewer prompts
repeatedly ingested broad source contracts, long trial memory, theorem-route
reminders, and the same current blocker. Once the residual theorem became
narrow, most of that context was no longer decision-relevant. The system could
remain active while the mathematical boundary stayed unchanged.

The key failure was delegation granularity. A role-local action was often
smaller than a substantive mathematical advance, so each handoff paid context
again while preventing one agent from carrying a useful insight through source,
proof design, Lean implementation, and focused diagnosis.

### Brenier/Rockafellar integration pattern

The Brenier branch produced many correct leaves, but the global operator had to
continually reconstruct the join across local geometry, common-mass slicing,
product laws, integrability, finite cost, optimality, closed-chain algebra, and
the Rockafellar potential. Many theorem branches also needed separate
smoke-check and clean-port steps. The output was mathematically valuable; the
coordination and integration overhead was high.

After substantive advances became canonical, the proper Rockafellar root,
relation-point support, effective-domain convexity, open-domain a.e.
differentiability, and marginal a.e. pullback were naturally expressed as
independent DAG deltas with explicit truth boundaries. This supports the
Universal Worker model.

The next bottleneck is global synthesis. A single Master should not read every
transcript and reproduce every local proof relation. The current Harness
therefore uses connected Frontier Cells, ephemeral local synthesis by Universal
Workers, and bounded frontier evidence for the Thin Master.

ASTIS has not yet established a universal numerical speedup. External informal
reports motivate the design, but any ASTIS speedup claim must be backed by
comparable theorem-DAG, token, and active-agent-hour measurements.

## 2. What counts as progress

Every SAU return has exactly one primary classification:

- `theorem-edge`: a named source-backed theorem edge compiles;
- `reusable-interface`: a named compiled interface removes duplicated future
  proof work;
- `integration-node`: several verified parents are joined into a higher graph
  node;
- `strict-obstruction`: a counterexample, retired route, or strictly smaller
  evidenced blocker changes the proof plan;
- `rejected-activity`: wrappers, reports, broad audits, repeated attempts, or
  tests that do not change the mathematical boundary.

The first three correspond to `PROVED_LOCAL`. A strict obstruction corresponds
to a fully evidenced `BLOCKED` return. `rejected-activity` never becomes a
success state even when a branch exists or a broad build is green.

Examples that do **not** count by themselves:

- a branch, commit, PR, or new file;
- a smoke test disconnected from a named theorem delta;
- a helper that simply restates an assumed hypothesis;
- renaming or moving the same proof obligation;
- repeating the same Lean error with more prose;
- producing a human report while the theorem boundary is unchanged;
- scheduling more agents without a new independent SAU.

## 3. Universal Worker context policy

A Worker receives a bounded local packet:

- exact source anchor and source mode;
- theorem delta, target declaration names, and truth boundary;
- the connected DAG parents and consumers for one Frontier Cell;
- owned and forbidden shared files;
- exact current interfaces or compiler residuals;
- relevant validated discoveries and the latest cell synthesis;
- focused acceptance checks;
- explicit omission counts and context budget.

The Worker does not replay raw project history. It retrieves deeper evidence
only for a named uncertainty. Former Upper/Middle/Lower role artifacts may be
consulted as memory but are never mandatory stages.

For old SALD cycles, `tools/astis.py` still generates `05_context_pack.md`.
Current scheduling should additionally consume:

```bash
python3 tools/astis_advance.py capsule
```

The capsule is structured state, not a transcript summary.

## 4. No-progress control

A bounded checkpoint records:

```text
route_fingerprint
progress_signature
mathematical_delta
exact_residual
context_characters
```

Let `(r, p)` be the route fingerprint and progress signature.

- first occurrence: continue normally;
- first unchanged repeat: warning;
- second unchanged repeat: mark the SAU as requiring diagnosis;
- any further identical checkpoint: reject and freeze the route.

The Worker must then change route, publish a strict blocker/counterexample, or
produce a theorem/interface delta. Network/provider failures are retried
separately and do not count as mathematical repeats.

At the global level, the same principle applies to scheduling. If the same
Frontier Cell snapshot produces the same Master decision twice without an SAU,
discovery, verification, or stabilization delta, stop spawning. Request local
synthesis, resolve a named conflict, or choose another cell.

## 5. Frontier Cell synthesis

A Frontier Cell is a connected local subgraph of active advances. When a cell
contains multiple SAUs or a no-progress signal, any Universal Worker may
temporarily synthesize it.

A useful synthesis states:

- which theorem edges actually changed;
- which exact truth boundaries remain;
- shared parents and downstream joins;
- duplicate or conflicting routes;
- discoveries that should become reusable nodes;
- routes retired and why;
- the next independent SAUs;
- whether the cell is ready for global verification or stabilization.

Semantic synthesis is independently validated. This is not a permanent Middle
role. The synthesizing agent remains free to notice and act on mathematical
facts outside a narrow responsibility box.

The Thin Master reads compact cell evidence first. It opens raw Worker evidence
only for a named cross-frontier conflict or admission decision.

## 6. Prompt and memory compression

The compact state should preserve exact fields and omit replayable prose.
Compaction may not paraphrase away:

- theorem statements and target declarations;
- assumptions, measures, spaces, domains, and representatives;
- source anchors and edition information;
- current Lean errors and checked commits;
- truth boundaries;
- route fingerprints and no-progress status;
- discovery provenance and validation status.

Old records remain in append-only memory. The active packet contains only the
latest relevant entries plus explicit omission counts.

Useful entry points:

```bash
python3 tools/astis.py write-context-pack ASTIS-SALD-001 --cycle 99
python3 tools/astis.py blueprint-refresh ASTIS-SALD-001
python3 tools/astis_advance.py capsule
```

The proof blueprint remains the system-of-record snapshot for the source-backed
DAG. The substantive-advance ledger is the system of record for active theorem
deltas and ownership.

## 7. Efficiency audit metrics

A long-run report should record both mathematical output and coordination cost.

### Mathematical output

- number of merged theorem edges;
- number of merged reusable interfaces;
- number of merged integration nodes;
- number of strict obstructions and retired routes;
- number of validated discoveries later consumed by another SAU;
- graph depth/connection changes at the active frontier;
- source statements whose truth boundary was genuinely closed.

### Context and control cost

- Worker input/output characters or tokens;
- Thin-Master capsule characters or tokens;
- cell-synthesis input/output characters;
- omitted record counts;
- duplicate proposal/discovery rejections;
- checkpoint count and no-progress freezes;
- repeated global decisions;
- active Worker fanout and idle time;
- stabilization queue wait and shared-file conflicts;
- clean-port/rebase work caused by stale branches.

### Derived metrics

```text
theorem-DAG deltas / million tokens

theorem-DAG deltas / active-agent hour

Thin-Master context / total Worker context

validated discoveries reused / validated discoveries published

stabilization wait / total wall time
```

A lower Master-context ratio is desirable only when theorem progress, source
fidelity, and verification quality stay stable or improve.

The legacy command remains useful for old logs:

```bash
python3 tools/astis.py efficiency-report --log runs/logs/<log>.log
```

Future reports should add the substantive-advance ledger metrics above.

## 8. Technical Lemma Memory Protocol

ASTIS uses compiled local technical lemmas as the callable memory layer for
SDE/Sampling work. External repositories are sources for theorem shapes,
proof idioms, and provenance—not runtime dependencies or automatic proof
claims.

Before inventing a measure/probability interface, a Worker should consult:

- `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean` and
  `AutoSamplingTheory/TechnicalLemmas/Taylor.lean` for compiled local lemmas;
- `AutoSamplingTheory/TechnicalLemmas/Registry.lean` and
  `research-wiki/technical-lemma-memory/technical_lemma_registry.jsonl` for
  names, tags, and consumers;
- `research-wiki/technical-lemma-memory/SALD_remaining_map.md` for current
  SALD leaf-to-lemma mapping;
- `research-wiki/technical-lemma-memory/SLT_port_queue.jsonl` for upstream
  theorem shapes still requiring local ASTIS ports;
- the local SLT article/repository for source-level methodology.

The borrowing pattern is:

1. search existing ASTIS declarations, technical-lemma memory, and discoveries;
2. inspect external code only for a proof idiom or theorem shape if no local
   declaration exists;
3. port one small source-backed statement into
   `AutoSamplingTheory/TechnicalLemmas` and compile it;
4. otherwise publish a source-cited strict blocker or ProofObligation with the
   exact missing theorem boundary.

## 9. Paper Contribution Memory Protocol

Faithful-paper state remains separate from reusable technical-lemma memory. For
`ASTIS-SALD-001`, the canonical task-local memory is:

```text
research-wiki/paper-contributions/SALD/
```

The key file is:

```text
research-wiki/paper-contributions/SALD/unfinished_source_map.md
```

It records the source line range, Lean boundary, status, and next action for each
unfinished paper contribution. An SAU must name either one source-backed delta
from this map or one reusable compiled library delta. Verification rejects a
completion claim when an active paper leaf is still `line-range-missing`.

At the end of a long run, refresh paper memory, TODO state, Chinese summary, and
technical-report snippets together. Human-facing summaries are finalization
outputs, not per-step substitutes for theorem progress.

## 10. Retained search methods without fixed roles

ASTIS retains useful ideas from earlier systems without retaining their role
boxes:

- LeanMarathon-style blueprints and dynamic DAG leaves;
- LBG-style durable trial and negative-route memory;
- EoH-style competing candidate routes in `exploratoryProof` mode;
- ARIS/QBE-style independent verification and long-run recovery;
- FrontierAgent-style bounded task boards, parallel workers, structured reports,
  checkpoint/resume, and coordinator no-progress protection.

These are capabilities and control mechanisms. They do not imply that one agent
may only read sources, another may only design Lean, or a third may only review.

## 11. Current SALD negative cache

Do not spend another cycle on broad LSI/DV/Gronwall backfill unless the active
Euler--Maruyama backend is blocked by a named Mathlib or theory gap. The current
high-priority blockers are:

- prove the concrete contraction bound;
- align `weakGradPairing` and `driftDiv` with the `hatRhoS` law integral;
- prove the no-boundary integration-by-parts theorem for `hatRhoS * barB`.

Broad source-index rebaselines, broad theorem-route audits, article export, and
new wrappers around the same assumptions are rejected unless they directly
close one of these items or return a strict obstruction.

The current dynamic leaf is read from `blueprint-refresh`. If it differs from
this prose cache, the generated source-backed blueprint and current
substantive-advance capsule take precedence.
