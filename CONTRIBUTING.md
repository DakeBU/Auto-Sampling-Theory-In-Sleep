# Contributing to ASTIS and Samplinglib

ASTIS welcomes focused corrections, reusable Lean lemmas, faithful textbook
reconstruction, proof-route metadata, diagrams, and website improvements. This
guide keeps mathematical claims, local Lean evidence, and route progress
separate throughout review.

## 1. Discuss the scope

Small corrections and narrowly scoped API improvements can go directly to a
pull request. Open an issue before starting any of the following:

- a new textbook theorem route or paper-reproduction target;
- a new module, namespace, or import boundary;
- a change to an existing theorem statement, source correspondence, or
  mathematical assumptions;
- a large port from Mathlib or another Lean repository;
- a change to the ASTIS harness, typed artifacts, or acceptance gate.

State the mathematical result, source, proposed owner module, expected
dependencies, and whether the result is a reusable technical leaf or a
textbook/paper-specific consumer.

## 2. Develop in the owning layer

Before proving a new lemma, search the [declaration catalog](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/declarations/),
the [implementation map](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/implementation-map/),
the local Lean tree, and Mathlib. Prefer an existing declaration when its
statement and hypotheses really match.

Keep these ownership boundaries explicit:

| Contribution | Canonical owner |
|---|---|
| Reusable measure, probability, analysis, process, SDE, or sampler lemma | The corresponding subject module under `AutoSamplingTheory/TechnicalLemmas/` |
| Selected reusable leaf and its provenance | `AutoSamplingTheory/TechnicalLemmas/Registry.lean` after it compiles locally |
| Log-concave-sampling theorem consumer | The relevant sampling/textbook module and source-correspondence record |
| Paper-specific theorem route | `research-wiki/paper-contributions/<paper>/` |
| Open proof target or agent handoff | A typed ASTIS packet; never a claim of local proof completion |
| Teaching exposition or route milestone | Reviewed metadata under `website/content/` |
| Diagram | Editable Mermaid under `website/diagrams/` |

Use the Lean and Mathlib versions pinned by `lean-toolchain` and
`lakefile.lean`. Follow nearby Mathlib-style naming, imports, docstrings, and
file headers. Preserve original authorship and license notices when adapting
external code, and record the exact source and any substantive changes.

Do not close mathematics with `sorry`, `admit`, `axiom`, `constant`,
`postulate`, `Prop := True`, or `:= trivial`. A task card, interface structure,
natural-language theorem, or successfully elaborated proposition is not a
proof. Add a Registry entry only for a reusable ASTIS-owned declaration that
compiles under the pinned toolchain.

## 3. Verify the change

Install the pinned dependency cache once, then run the full relevant gate from
the repository root:

```bash
lake exe cache get
LEAN_NUM_THREADS=$(nproc) lake build
python3 tools/astis.py check
python3 tools/astis.py harness-test
python3 website/scripts/lean_gate.py
ASTIS_PUBLIC_SOURCE_LINKS=1 python3 website/scripts/build_site.py
ASTIS_PUBLIC_SOURCE_LINKS=1 python3 website/scripts/check_site.py
```

The public-source flag is appropriate only when the current commit is available
on the public remote. Omit it for unpushed or private preview work; generated
pages will use checked site-local source anchors.

Before submission, confirm:

- the whole Lean build and ASTIS deterministic check pass;
- no forbidden placeholder or fake-closure token was introduced;
- imports follow the subject dependency direction and avoid a new cycle;
- the mathematical source, assumptions, constants, and endpoint conditions are
  recorded precisely;
- local declaration status and textbook/paper route status are not conflated;
- new reusable leaves have focused tests and Registry metadata when warranted;
- website metadata names only declarations that exist in the current source;
- generated files under `_site/` are not committed.

## 4. Submit a focused pull request

Use the pull request template. A reviewer should be able to identify the result
and acceptance evidence without reconstructing them from the diff. Include:

- the mathematical statement and exact source anchor;
- the owning module and dependency/API decisions;
- reusable leaves, paper/textbook consumers, and remaining obligations;
- the local declaration status and mathematical route status;
- commands run and their results;
- adapted-code provenance, copyright, license, and authorship changes;
- any deliberate follow-up work, stated as open rather than complete.

Review checks source fidelity, hidden hypotheses, theorem drift, module
ownership, duplicate APIs, proof completeness, and gate evidence. Accepted
contributions are credited in Git history and relevant source-file author
headers. For co-written commits, add one trailer for each additional author:

```text
Co-authored-by: Full Name <email@example.com>
```

This workflow is informed by StatsMLlib's staged contribution process, adapted
to ASTIS's source correspondence, dual status model, hierarchical proof
packets, and Samplinglib memory boundary.
