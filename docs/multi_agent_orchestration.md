# ASTIS Harness: Substantive-Advance Frontier Mesh

ASTIS formalizes sampling theory as a source-backed Lean dependency graph. Its
control plane must optimize **mathematical graph progress**, not the number of
agents, role handoffs, prompts, files, or locally green wrappers.

The active unit is a **Substantive Advance Unit (SAU)**: one bounded mathematical
delta in the live theorem DAG, owned end to end by one Universal Worker. Nearby
advances form dynamic **Frontier Cells** so routine local aggregation does not
become a monolithic-Master bottleneck.

The architecture is a frontier mesh:

1. deterministic code maintains the board, ownership, state machine, duplicate
   suppression, checkpoints, and stabilization lock;
2. Universal Workers solve theorem-sized deltas and may temporarily synthesize
   one connected Frontier Cell;
3. a Thin Master reads bounded cell evidence and resolves only cross-frontier
   priority, conflict, route-reset, and stabilization decisions.

Fixed Upper/Middle/Lower responsibilities are no longer the organizational
skeleton. Their typed artifacts remain readable historical memory, and their
useful guarantees—source fidelity, explicit evidence, typed failure memory, and
independent review—remain part of the current Harness.

## 1. Why the delegation unit changed

### 1.1 Earlier role-ladder architecture

The earlier Harness deliberately separated responsibilities:

```text
source / paper
    ↓
Upper
source audit · mathematical strategy · proof-DAG planning
    ↓
Middle
source↔Lean correspondence · retrieval · theorem mapping
    ↓
Lower workers
proof scout · Lean implementation · technical/API scout
    ↓
Reviewer
Lean gate · source audit · fake-closure rejection
    ↺
typed feedback and replanning
```

This structure made source fidelity and review visible. The post-cycle-98 SALD
audit, however, showed a recurring cost: broad source contracts, route reminders,
trial memory, and the same blocker were separately loaded by Upper, Middle,
Lower, and Reviewer prompts even after the true residual problem had become
narrow. Each role could produce a locally valid artifact while the same
mathematical edge remained open.

The important diagnosis is not “specialization is always bad”. It is that the
**handoff was smaller than the useful unit of mathematical progress**. A source
reader could identify a decisive regularity issue but not repair the Lean
statement; a Lean worker could discover a better theorem decomposition but be
asked to touch one script; a reviewer could diagnose wrapper churn only after a
whole cycle had consumed context.

### 1.2 Integration and synthesis cost

The Brenier/Rockafellar work produced many useful verified leaves, often as a
theorem commit plus a focused smoke-check commit. The mathematics advanced, but
the global operator repeatedly had to reconstruct how local blocks, common-mass
slicing, product laws, cost bookkeeping, optimality, closed-chain algebra, and
the Rockafellar potential fit together. Shared import, test, Registry, and PR
work also became a serial queue.

Once theorem-sized substantive advances became the work unit, the proper
Rockafellar root, relation-point support, effective-domain convexity,
open-domain a.e. differentiability, and marginal a.e. pullback could be treated
as independent DAG deltas with explicit truth boundaries. The remaining
bottleneck then moved upward: a single Master should not have to read every SAU
report, reconcile every local discovery, and decide every local join.

The current Harness therefore distributes **local synthesis** through Frontier
Cells without reintroducing permanent reasoning roles.

ASTIS does not assume a numerical speedup from this architecture. Efficiency
claims must be backed by comparable theorem-DAG delta, token, and active-agent
hour measurements.

## 2. Canonical architecture

```mermaid
flowchart LR
  DAG["Live source / theorem / Lean DAG"] --> CP["Deterministic control plane"]
  CP --> B["Substantive Advance Board"]

  subgraph C1["Frontier Cell A"]
    W1["Universal Worker"]
    W2["Universal Worker"]
    LS1["Ephemeral local synthesis"]
    W1 --> LS1
    W2 --> LS1
  end

  subgraph C2["Frontier Cell B"]
    W3["Universal Worker"]
    W4["Universal Worker"]
    LS2["Ephemeral local synthesis"]
    W3 --> LS2
    W4 --> LS2
  end

  B --> W1
  B --> W2
  B --> W3
  B --> W4
  LS1 --> M["Thin Master"]
  LS2 --> M
  W1 -. discovery .-> D["Discovery / synthesis ledger"]
  W2 -. discovery .-> D
  W3 -. discovery .-> D
  W4 -. discovery .-> D
  D --> LS1
  D --> LS2
  M --> V["Independent verification"]
  V --> S["Single stabilization lane"]
  S --> G["Lean · source · fake-closure · site gates"]
  G --> R["Samplinglib Registry / Underlying Lean Graph"]
  R -. reusable parents .-> DAG
```

The checked-in diagram is
`docs/assets/substantive-advance-architecture.mmd`.

## 3. Deterministic control plane

The control plane should do what code can do more reliably and cheaply than an
LLM:

- recover append-only state after interruption;
- enforce legal lifecycle transitions;
- assign and preserve SAU ownership;
- normalize and reject duplicate active theorem targets;
- keep source anchors, truth boundaries, DAG parents, target declarations, and
  focused checks explicit;
- group nearby advances into named Frontier Cells;
- count unchanged route/progress checkpoints;
- freeze repeated no-progress routes;
- expose bounded frontier and Master capsules;
- enforce one stabilization owner.

The implementation is `tools/astis_advance.py`. Its durable I/O continues to use
`tools/astis_harness.py`, so earlier role artifacts and interrupted JSONL remain
readable.

The control plane must not invent proof strategy, paraphrase exact assumptions,
or decide that a plausible report is mathematically true.

## 4. Substantive Advance Board

A proposal records:

- `advance_id`, task id, and Frontier Cell;
- exact goal and source anchor;
- explicit theorem delta and target declaration names;
- current truth boundary;
- DAG parents/inputs;
- proposed owned files;
- focused acceptance checks;
- temporary Worker modes;
- priority.

The semantic fingerprint excludes the Worker and branch name. It normalizes
harmless presentation differences and fingerprints the mathematical target. A
matching active proposal is rejected rather than assigned twice.

The board is pull-friendly. The Master may identify high-value frontiers, but a
Universal Worker may also surface a dependency-ready SAU or a validated
discovery that should become one. The deterministic board—not a long Master
monologue—owns identity, status, and conflicts.

## 5. Universal Workers

One Worker owns one SAU **end to end**. It may switch among:

- source and assumption audit;
- natural-language proof design;
- Samplinglib/Mathlib retrieval;
- counterexample or boundary search;
- Lean theorem design and implementation;
- focused compiler diagnosis;
- local refactoring and exposition;
- local frontier synthesis.

These are modes, not permissions. A Worker that discovers a better decomposition
may use it; a Worker that sees a source flaw must record it; a Worker that closes
a reusable API may publish the interface. The Worker does not stop merely
because an earlier role boundary has been reached.

A `PROVED_LOCAL` result must be one of:

1. `theorem-edge` — a source-backed theorem edge was compiled;
2. `reusable-interface` — a general interface needed by multiple consumers was
   compiled;
3. `integration-node` — several verified parents were joined into a higher DAG
   node.

It must name the declaration, files, focused checks, and remaining truth
boundary. A helper that simply restates an assumption does not qualify.

## 6. Why this is not simply AI writing proofs

AI-generated proof prose can be useful mathematical exploration, but prose alone
is not a mechanically checked theorem. Hidden assumptions, type mismatches,
invalid boundary arguments, or a subtly changed statement can remain inside a
fluent proof. An isolated prose proof also does not automatically become a
named, callable interface that future proofs can safely retrieve and reuse.

ASTIS adds three layers:

1. **Lean verification** — exact declarations, hypotheses, types, imports, and
   proof terms are checked;
2. **reusable formal memory** — verified lemmas and interfaces can be retrieved
   by later Workers instead of rediscovered as informal text;
3. **graph placement** — every admitted result has explicit parents and
   consumers in the existing formal dependency graph.

The third layer changes how mathematical contribution can be inspected. A new
result can be studied as a terminal leaf, a bridge between branches, a shortcut
through an important proof route, a reusable interface, or a larger
reorganization of the dependency structure—not only as another standalone proof
narrative.

## 7. Strict obstructions are progress; vague blockers are not

Some mathematically useful runs do not close the original theorem. They still
count only when the result changes the proof graph or future scheduling.

A `BLOCKED` packet therefore records:

- blocker class;
- exact residual statement/error;
- strict reduction achieved;
- at least one smaller next delta, retired route, counterexample, or minimal
  reproducer.

This lets the system preserve genuine negative knowledge while rejecting
“failed to solve” handoffs that consume context without narrowing the problem.

## 8. No-progress control

Every bounded checkpoint records:

```text
route_fingerprint
progress_signature
mathematical_delta
exact_residual
context_characters
```

Repeated unchanged route/progress states trigger diagnosis and eventually freeze
the route. The Worker must then change the mathematical route, return a strict
obstruction or counterexample, or produce a new theorem/interface delta.

This is analogous to coordinator-side no-progress protection in general agent
systems, but the signal is ASTIS-specific: unchanged formal target, route, and
residual proof state rather than repeated generic tool calls.

## 9. Frontier Cells and ephemeral local synthesis

A **Frontier Cell** is a connected local neighborhood of the live proof graph.
Advances may be grouped because they share source statements, DAG parents,
interfaces, theorem declarations, owned modules, or a later integration node.
The grouping is dynamic and may change as the graph advances.

When a cell has several active SAUs, any Universal Worker can temporarily
synthesize that cell, recording:

- the verified/blocked graph delta in that cell;
- shared parents and consumers;
- conflicts or duplicate routes;
- reusable discoveries;
- retired paths;
- next independent SAUs and the eventual join condition.

Another Worker validates semantic synthesis when model judgment is needed.
Routine aggregation is deterministic. This removes most local recomposition work
from the Thin Master while avoiding a permanent “middle manager” whose role
could suppress ideas outside a fixed responsibility box.

## 10. Thin Master

The Thin Master performs only decisions requiring cross-frontier understanding:

- choose among competing high-value Frontier Cells;
- resolve overlapping ownership or shared-file conflicts;
- decide whether a validated discovery should become a new SAU;
- schedule joins whose parents live in different cells;
- authorize resets of frozen routes;
- order the verified stabilization queue;
- retire stale global routes.

It reads bounded frontier evidence from `tools/astis_advance.py` and opens deeper
evidence only for a named unresolved conflict or admission audit.

This is the answer to the Master bottleneck: distribute local synthesis, make
bookkeeping deterministic, and reserve scarce global reasoning for true
cross-frontier decisions.

## 11. Independent verification

The proving Worker cannot publish `VERIFIED`. An independent verifier records:

- verifier identity;
- exact checked commit;
- Lean/focused gate output;
- source/assumption audit;
- fake-closure scan.

`PROVED_LOCAL` is weaker than `VERIFIED`, and `VERIFIED` remains weaker than
`MERGED`. Vocabulary may not turn branch-local compilation into public truth.

## 12. Single stabilization lane

Mathematical work can be parallel; **shared repository truth is serialized**.
Exactly one integration owner may occupy `STABILIZING`.

That owner may:

- clean-port a verified theorem onto current `main`;
- resolve theorem/import collisions;
- edit shared parent imports and root tests;
- update the Samplinglib Registry;
- update source correspondence and completion matrices;
- update Underlying Lean Graph evidence;
- update public site status;
- publish the canonical PR/merge commit.

Workers should own isolated theorem modules and focused tests during exploration.
They should not concurrently edit root aggregators, Registry tables, source
matrices, or public truth surfaces.

## 13. Discovery and synthesis ledger

Workers often find useful facts outside the assigned theorem: a reusable measure
interface, a missing Mathlib bridge, a counterexample, a source ambiguity, a
refactor, a conjecture, or a better process rule. These must survive Worker
termination without becoming unverifiable lore.

Supported kinds include lemmas, interfaces, counterexamples, source gaps,
refactors, conjectures, process improvements, and frontier syntheses. Their
lifecycle is `raw -> validated -> scheduled -> merged` (or `rejected`). Semantic
duplicates are suppressed so later Workers retrieve one canonical record rather
than repeatedly rediscovering it.

## 14. How the graph is meant to help the field understand mathematics

Samplinglib is the public verified library, but the graph is also a mathematical
instrument. It can expose:

- the small set of lemmas and interfaces on which many sampler arguments depend;
- hidden measurability, integrability, regularity, domain, and boundary
  assumptions that prose proofs often suppress;
- recurring proof mechanisms shared across results that look different in
  natural language;
- where a new theorem attaches to the established body of knowledge;
- whether a claimed contribution is mainly another leaf or creates a new bridge,
  shortcut, interface, or proof architecture.

This is intended to make the field easier to enter and easier to inspect at
expert depth. Once the graph is sufficiently mature, compression can reveal a
smaller structural spine and may feed back into cleaner natural-language,
algebraic, or more categorical reformulations of sampling arguments.

## 15. Relation to FrontierAgent

FrontierAgent provides useful generic control-plane lessons:

- coordinator plus task board;
- bounded parallel sub-agents;
- structured report collection;
- checkpoint/resume;
- fanout/depth/time guards;
- coordinator-specific no-progress protection;
- optional lightweight final reporting.

ASTIS adopts those principles selectively. Its unit of truth is not a generic
file task or plausible report. It is a source-backed theorem-DAG delta with Lean
evidence, explicit truth boundary, reusable discovery provenance, independent
verification, and serialized admission to Samplinglib.

ASTIS also differs in where hierarchy is allowed. Deterministic state and
Frontier Cell aggregation may be hierarchical for efficiency; mathematical
capability is not. Every Worker remains generalist, and local synthesis is an
ephemeral action rather than a permanent role.

## 16. Efficiency metrics

The Harness is judged by output, not activity. Long-run reports should track:

- merged theorem edges, reusable interfaces, and integration nodes;
- strict obstructions and routes retired;
- validated discoveries later reused by another SAU;
- Worker input/output context characters;
- Thin-Master capsule characters;
- repeated route/progress checkpoints and freeze events;
- duplicate proposal/discovery rejections;
- stabilization wait time and shared-file conflict count;
- theorem-DAG delta per million tokens;
- theorem-DAG delta per active-agent hour.

A lower Master-context ratio is not sufficient by itself: theorem-DAG progress,
source fidelity, and verification quality must remain stable or improve.

## 17. Compatibility with the earlier typed Harness

No historical migration is required. `tools/astis_harness.py` still provides:

- canonical-path locking;
- fsync-backed append-only JSONL;
- interrupted-tail recovery;
- canonical JSON and hashes;
- typed historical role artifacts;
- immutable route and proof-branch memory.

Old `upper`, `middle`, `lower_*`, and `reviewer` profile keys may remain as
execution slots. They no longer define what an agent is allowed to think about,
and a new theorem should not be forced through every slot.

## 18. Operational checks

```bash
python3 -m unittest tools.tests.test_astis_advance
python3 -m unittest tools.tests.test_harness_site
python3 tools/astis_advance.py capsule
python3 tools/astis.py check
```

The tests cover duplicate target suppression, Worker-lane ownership,
substantive `PROVED_LOCAL` evidence, independent verification, strict blocker
evidence, no-progress route freezing, discovery/synthesis persistence,
Frontier Cell reduction, single stabilization ownership, interrupted JSONL
recovery, and the reader-facing Harness contract.

## 19. Success criterion

A successful ASTIS run is explainable as verified graph change:

```text
existing verified parents
    -> one substantive theorem delta or strict obstruction
    -> focused evidence
    -> optional local Frontier Cell synthesis
    -> independent verification
    -> current-main stabilization
    -> reusable Samplinglib node / corrected proof plan
```

That sequence is the object ASTIS will later compress and visualize. It is also
the right granularity for deciding whether new work adds a marginal leaf,
creates a new formal-graph connection, shortens an important route, or
introduces a genuinely new proof technique.
