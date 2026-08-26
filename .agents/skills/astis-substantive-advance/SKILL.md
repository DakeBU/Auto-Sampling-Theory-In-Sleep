# ASTIS Substantive Advance Worker Packet

Use this packet for one Universal Worker and one source-backed theorem-DAG
advance. Delete fields that truly do not apply, but never hide a truth boundary,
source gap, compiler failure, or unchanged route.

A Worker is not a narrow proof-script executor. It may cross source reading,
mathematical derivation, library retrieval, counterexample search, Lean editing,
focused verification, refactoring, and exposition whenever those actions help
close the assigned mathematical delta.

## Input contract

```yaml
advance_id:
task_id:
mode: faithfulPaper | exploratoryProof
frontier_cell:
goal:
source_anchor:
active_dag_slice:
  parents: []
  consumers: []
theorem_delta:
target_declarations: []
truth_boundary:
owned_files: []
forbidden_shared_files:
  - AutoSamplingTheory/TechnicalLemmas/Analysis.lean
  - AutoSamplingTheory/TechnicalLemmas/Measure.lean
  - Tests.lean
  - AutoSamplingTheory/TechnicalLemmas/Registry.lean
relevant_memory_cards: []
validated_cell_syntheses: []
exact_interfaces_or_errors: []
temporary_modes: []
focused_acceptance_checks: []
context_budget:
  maximum_characters:
  omitted_records:
```

## Worker instruction

Own the mathematical advance end to end. Read the exact source, challenge the
statement when necessary, search ASTIS and Mathlib before inventing an API,
implement an isolated theorem module, add a focused test, and run the smallest
useful check early. Do not stop at a former Upper/Middle/Lower boundary. Do not
edit shared aggregators in the exploration lane.

A successful return closes the proposed theorem edge, reusable interface, or
integration node. A blocked return must strictly reduce the boundary and include
evidence strong enough to change the next scheduling decision. “Lean failed” or
“more work remains” is not a result.

Useful cross-boundary ideas belong in the Discovery Ledger even when they do not
finish the current edge. When several advances share one connected frontier
cell, the Worker may temporarily synthesize that cell and publish a `synthesis`
discovery. This temporary mode does not limit the Worker’s mathematical scope
and does not create a permanent hierarchy.

## Bounded checkpoint contract

Checkpoints are observability, not progress claims:

```yaml
route_fingerprint:
progress_signature:
mathematical_delta:
exact_residual:
context_characters:
```

After the first occurrence and two unchanged repeats of the same route and
progress signature, the route is frozen for diagnosis. The next action must
change the route fingerprint, publish a strict blocker/counterexample, or close
a theorem delta. Do not spend another context window replaying the same state.

## Output contract

```yaml
advance_id:
frontier_cell:
state: PROVED_LOCAL | BLOCKED | QUARANTINED
result_kind: theorem-edge | reusable-interface | integration-node | strict-obstruction
mathematical_result:
theorem_delta:
lean_declarations: []
lean_files: []
focused_checks:
  - command:
    result:
source_fidelity:
truth_boundary:
route_fingerprint:
progress_signature:
exact_blocker:
blocker_class:
strict_reduction:
next_smaller_delta:
retired_route:
minimal_reproducer:
new_discoveries:
  - discovery_id:
    kind: lemma | interface | counterexample | source-gap | refactor | conjecture | process | synthesis
    frontier_cell:
    statement:
    evidence:
    where_it_matters:
    provenance:
integration_notes:
  public_imports_needed: []
  registry_or_site_updates: []
  downstream_consumers: []
context_accounting:
  input_characters:
  output_characters:
  reused_cell_synthesis:
branch:
commit:
```

For `PROVED_LOCAL`, `result_kind` must be `theorem-edge`,
`reusable-interface`, or `integration-node`, and declaration/check evidence is
mandatory.

For `BLOCKED`, use `result_kind: strict-obstruction` and provide a typed blocker,
strict reduction, plus at least one smaller next delta, retired route,
counterexample, or minimal reproducer.

## Independent verification addendum

The proving Worker cannot publish `VERIFIED`. An independent verifier records:

```yaml
verifier_id:
verified_commit:
gate:
source_audit:
fake_closure_scan:
```

A green local helper is not enough if it only restates a supplied assumption or
does not exercise the named declaration.

## Stabilization addendum

Only the designated stabilization owner may:

- clean-port onto current `main`;
- edit shared aggregators and root tests;
- resolve duplicate theorem names;
- update Registry, graph, source, and site surfaces;
- declare `STABILIZING` or `MERGED` with gate evidence.
