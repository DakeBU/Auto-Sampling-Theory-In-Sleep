# ASTIS-SAMPLEWIKI-001 — SampleWiki Example Cases

## Mission

Build a parallel `Example Cases` lane for the mathematical problems and proofs
published at:

- source: `https://samplewiki.morning-recipe-422a.workers.dev/`
- ASTIS role: external worked-example stream feeding reusable Lean leaves and
  proof-technique nodes into Samplinglib.

This lane is deliberately independent of the Chapter 1.1 closure work and the
parallel Chapter 1.2–1.3 foundation work.  It may reuse compiled roots from
those lanes, but it must not duplicate them under SampleWiki-specific names.

## Non-negotiable truth boundary

A source item passes through these distinct states:

1. **discovered** — URL or semantic block found by the watcher;
2. **sourcePinned** — source URL plus content hashes recorded;
3. **normalized** — ASTIS writes an original mathematical restatement and
   records every explicit and implicit hypothesis;
4. **leanTarget** — the exact Lean proposition/interface has been chosen;
5. **compiled** — Lean accepts the proof with the pinned project toolchain;
6. **sourceReviewed** — a reviewer checks that the Lean theorem still means the
   source theorem/problem solution;
7. **assimilated** — reusable leaves and proof techniques have been connected to
   the scientific ASTIS DAG.

`compiled` is not synonymous with `sourceReviewed`, and neither source text nor
an LLM-generated theorem-shaped declaration counts as a proof.

The Lean contract enforcing this distinction lives in
`AutoSamplingTheory/ExampleCases/SampleWiki.lean`.

## Source watcher

`tools/samplewiki_sync.py` performs a same-origin crawl and writes a deterministic
source manifest under `research-wiki/source-index/`.  The committed manifest
stores structural metadata and hashes rather than a wholesale mirror of the
site.  This gives ASTIS a reproducible change detector without silently
republishing long third-party prose.

`.github/workflows/samplewiki-sync.yml` runs the watcher periodically and opens
or refreshes one fixed source-update PR when the source fingerprint changes.
A source update therefore becomes a reviewable Git diff rather than an
unlogged mutation of ASTIS.

The environment used to create this blueprint could not resolve the Worker
hostname.  That is **not** evidence that SampleWiki itself is down.  We do not
invent any current SampleWiki theorem statement from that failure.  The first
successful GitHub Actions crawl becomes the first committed source snapshot.

## Case identity

Every reviewed mathematical case receives a stable ASTIS ID:

`ASTIS-SW-<source-key>`

The source card must record:

- canonical source URL and, when available, source anchor;
- page SHA-256 and statement/block SHA-256 from the watcher snapshot;
- original ASTIS mathematical restatement;
- assumptions visible in the source;
- assumptions required by the Lean statement but implicit in the source;
- source proof skeleton;
- reusable proof-technique tags;
- exact Lean target declaration;
- technical-lemma dependencies;
- focused test(s);
- source-review status and reviewer note;
- downstream ASTIS consumers.

## File layout

The source-independent skeleton is:

```text
AutoSamplingTheory/
  ExampleCases.lean
  ExampleCases/
    SampleWiki.lean
    SampleWiki/
      Cases/                 # one reviewed mathematical case/module at a time
Tests/
  SampleWikiExampleCases.lean
research-wiki/
  source-index/
    SampleWiki.md
    SampleWiki_manifest.json # generated after the first successful crawl
  lemma-dags/
    SampleWiki_example_cases.md
website/
  content/
    samplewiki_example_cases.json
  scripts/
    samplewiki_examples.py
proof-blueprints/
  ASTIS-SAMPLEWIKI-001.md
```

A mathematical case should normally be split further into existing shared
technical leaves under `AutoSamplingTheory/TechnicalLemmas/` when its proof
contains a reusable fact.  The case module should then be thin: it assembles
those leaves into the source-facing theorem.

## Assimilation algorithm

For each newly discovered or changed candidate:

1. diff source fingerprints against the previous manifest;
2. identify the exact problem/theorem/proof unit at the source URL;
3. search Samplinglib and Mathlib before writing a new lemma;
4. produce the natural-language source card and assumption audit;
5. draw the minimal dependency DAG;
6. classify every node as:
   - existing Mathlib interface,
   - existing Samplinglib leaf,
   - missing reusable leaf,
   - source-facing assembly theorem;
7. formalize missing leaves from the bottom up;
8. add focused Lean tests;
9. run the pinned Lean/site gates;
10. perform semantic source review;
11. connect the accepted leaves into `research-wiki/lemma-dags/` and record
    downstream consumers.

## Reuse policy against the Chapter 1 lanes

At creation time, PR #11 owns the Chapter 1.1 stochastic-calculus frontier and
PR #12 owns the parallel Chapter 1.2–1.3 foundation frontier.  SampleWiki work
must therefore:

- reuse their declarations when a case depends on those concepts;
- wait or remain explicitly blocked when the required root is not yet on main;
- never clone the same theorem simply to make an example close locally;
- prefer cases whose prerequisites are already on `main` so this lane can make
  independent progress immediately.

Once those PRs merge, dependency links should point to the merged declaration,
not to historical PR-specific names.

## Proof-technique graph

The value of this lane is not only the final theorem.  Each reviewed case must
extract technique nodes such as:

- conditioning / tower-property reduction;
- Jensen / convexity reduction;
- coupling construction;
- change of measure;
- semigroup interpolation;
- localization / truncation;
- integration by parts;
- Grönwall / differential inequality;
- martingale or stopping-time reduction;
- transport / Wasserstein duality;
- spectral-gap / Poincaré / LSI step;
- algebraic normalization or finite-dimensional bridge.

The exact list is source-driven.  Tags are added only after the actual case is
read; this blueprint does not assert that SampleWiki currently contains any
particular technique.

## Definition of done for one case

A case is green only when all of the following are true:

- source identity is pinned;
- ASTIS restatement is reviewed;
- assumptions are explicit;
- no `sorry` or `axiom` occurs in the accepted proof path;
- focused Lean test passes;
- shared leaves have reusable names and ownership;
- source-facing theorem compiles;
- source semantic review passes;
- theorem and technique nodes are linked into the SampleWiki DAG;
- public Example Cases page reports the same status without collapsing these
  separate gates.
