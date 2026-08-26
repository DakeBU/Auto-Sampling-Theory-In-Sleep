# ASTIS Substantive Advance Worker Packet

Use this packet for one generalist worker. Delete fields that truly do not
apply, but never hide a truth boundary, source gap, or compiler failure.

## Input contract

```yaml
advance_id:
task_id:
mode: faithfulPaper | exploratoryProof
goal:
source_anchor:
active_dag_slice:
  parents: []
  consumers: []
theorem_delta:
truth_boundary:
owned_files: []
forbidden_shared_files:
  - AutoSamplingTheory/TechnicalLemmas/Analysis.lean
  - AutoSamplingTheory/TechnicalLemmas/Measure.lean
  - Tests.lean
relevant_memory_cards: []
exact_interfaces_or_errors: []
temporary_modes: []
focused_acceptance_checks: []
```

## Worker instruction

Own the mathematical advance end to end. Read the exact source, challenge the
statement when necessary, search ASTIS and Mathlib before inventing an API,
implement an isolated theorem module, add a focused test, and run the smallest
useful check early. Do not stop at a role boundary. Do not edit shared
aggregators in the discovery lane.

A successful return closes the proposed theorem edge. A blocked return must
strictly reduce the boundary and include evidence. Record any useful
cross-boundary idea in the discovery section even when it does not help finish
the current edge.

## Output contract

```yaml
advance_id:
state: PROVED_LOCAL | BLOCKED | QUARANTINED
mathematical_result:
theorem_delta:
lean_declarations: []
lean_files: []
focused_checks:
  - command:
    result:
source_fidelity:
truth_boundary:
exact_blocker:
new_discoveries:
  - discovery_id:
    kind: lemma | interface | counterexample | source-gap | refactor | conjecture | process
    statement:
    evidence:
    where_it_matters:
    provenance:
integration_notes:
  public_imports_needed: []
  registry_or_site_updates: []
  downstream_consumers: []
branch:
commit:
```

## Stabilization addendum

Only the designated stabilization owner may:

- clean-port onto current `main`;
- edit shared aggregators and root tests;
- resolve duplicate theorem names;
- update Registry, graph, source, and site surfaces;
- declare `VERIFIED`, `STABILIZING`, or `MERGED` with gate evidence.
