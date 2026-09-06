# SampleWiki source ledger

## Identity

- Source ID: `SAMPLEWIKI`
- Canonical root: `https://samplewiki.morning-recipe-422a.workers.dev/`
- ASTIS lane: `Example Cases / SampleWiki`
- Formalization blueprint: `proof-blueprints/ASTIS-SAMPLEWIKI-001.md`
- Lean intake contract: `AutoSamplingTheory/ExampleCases/SampleWiki.lean`

## Why ASTIS tracks this source

SampleWiki is treated as a live stream of mathematical problems, worked
arguments, and proof ideas that can stress-test and expand Samplinglib. The
objective is not to archive the site verbatim. The objective is to convert
source-pinned mathematical units into reviewed Lean theorems and reusable proof
leaves, then connect those leaves to the existing ASTIS dependency graph.

## Snapshot policy

The watcher records a deterministic structural manifest containing:

- canonical same-origin page URLs;
- page titles and short heading metadata;
- raw-page and normalized-visible-text SHA-256 fingerprints;
- detected theorem/problem/proof-like semantic block metadata and hashes;
- same-origin link graph;
- one global tree fingerprint.

It intentionally does **not** commit a wholesale raw-HTML or prose mirror.
Mathematical statements used by ASTIS are rewritten as original ASTIS
restatements and linked back to the exact source URL and source fingerprint.

Generated manifest path after the first accepted source refresh:

`research-wiki/source-index/SampleWiki_manifest.json`

## Current bootstrap state

The local environment that created the first version of this ledger could not
resolve the Worker hostname. The first GitHub-hosted PR probe subsequently
**did** reach the source and crawled 24 same-origin pages. Its initial tree
fingerprint began `2332244eb06af2db`.

That first generic classifier detected zero theorem/problem/proof semantic
blocks. ASTIS treats this as **parser uncertainty, not evidence that the source
contains no mathematical cases**. The PR probe therefore now exports a bounded
page/title/heading catalog and an ephemeral source manifest so the detector can
be adapted to the site's actual structure before any mathematical statement is
claimed or formalized.

No current SampleWiki theorem/problem is marked formalized solely from this
crawl. The first committed manifest remains a provenance checkpoint, while each
mathematical case still needs its own source restatement, assumption audit, Lean
proof, and semantic source review.

## Change semantics

A changed page fingerprint means only **source changed**. It does not by itself
mean a theorem changed. The update PR must be triaged into one of:

- navigation/style-only change;
- prose-only change with unchanged mathematical content;
- statement/hypothesis change;
- proof change with unchanged statement;
- new mathematical case;
- removed mathematical case;
- source inaccessible / parser uncertainty.

Any statement/hypothesis/proof change reopens semantic review for the affected
ASTIS case even when its old Lean proof still compiles.

## Provenance rule for accepted cases

Every accepted case records both a page fingerprint and, when the watcher can
isolate it, a semantic-block fingerprint. A reviewer then records the source
URL/anchor used for the ASTIS restatement. This separates three questions:

1. Did we retrieve the same source object?
2. Does the Lean theorem prove its own statement?
3. Is that Lean statement a faithful formalization of the source mathematics?

ASTIS considers a case assimilated only after all three questions have been
answered explicitly.
