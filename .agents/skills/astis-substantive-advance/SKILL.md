# ASTIS Substantive Advance Worker Packet

Use this packet for one Universal Worker and one source-backed theorem-DAG
advance. Delete fields that truly do not apply, but never hide a truth boundary,
source gap, compiler failure, unchanged route, or source-to-Lean semantic delta.

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
semantic_roundtrip_required: true | false
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
semantic_roundtrip:
  required:
  audit_id:
  state: not-applicable | draft | blind-reconstructed | semantic-diffed | source-reviewed | accepted | rejected
  verdict:
  remaining_semantic_delta:
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

## Source-facing semantic addendum

A source-facing theorem is not assimilated merely because its Lean declaration
compiles. When `semantic_roundtrip_required: true`, open or update an audit in
`research-wiki/semantic-roundtrip/registry.json` and follow
`.agents/skills/astis-semantic-roundtrip/SKILL.md`.

The formalizer may prepare the draft audit, but cannot serve as the blind
decoder or source reviewer. Export the anonymous decoder packet and the later
anti-anchored review packet through:

```bash
python3 tools/astis_semantic_roundtrip.py decoder-packet \
  --audit-id ASTIS-RT-... \
  --output runs/semantic-roundtrip/ASTIS-RT-....decoder.json
python3 tools/astis_semantic_roundtrip.py reviewer-packet \
  --audit-id ASTIS-RT-... \
  --output runs/semantic-roundtrip/ASTIS-RT-....review.json
python3 tools/astis_semantic_roundtrip.py check
```

A repair proposal is evidence about a source gap; it is not permission to mutate
`faithfulPaper`. Until independent source review accepts it, keep the pinned
source theorem, Lean target, semantic delta, and proposed repair separately
visible.

## Independent verification addendum

The proving Worker cannot publish `VERIFIED`. An independent verifier records:

```yaml
verifier_id:
verified_commit:
gate:
source_audit:
semantic_roundtrip_audit:
fake_closure_scan:
```

A green local helper is not enough if it only restates a supplied assumption,
does not exercise the named declaration, or proves a Lean proposition whose
fidelity to the source remains unaudited.

## Stabilization addendum

Only the designated stabilization owner may:

- clean-port onto current `main`;
- edit shared aggregators and root tests;
- resolve duplicate theorem names;
- update Registry, graph, source, semantic-roundtrip, and site surfaces;
- declare `STABILIZING` or `MERGED` with gate evidence.
