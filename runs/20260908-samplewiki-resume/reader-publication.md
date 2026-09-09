# Reader-facing publication checkpoint — 2026-09-09

## Resumed publication and branch consolidation

After the quota interruption, the user explicitly requested website branch
consolidation, removal of useless branches, push and deployment. This supersedes
the earlier publication pause, not the unfinished full-exposition requirement.
The root remains the single integration writer; no Goal, frontier, Registry,
Lean theorem, semantic verdict or ignored mathematical scratch is changed by
this website revision. Starting branch: `codex/samplewiki-shared-stabilization`;
HEAD: `de33b695fe0a9c111858fb6190d2f67b1ad39abb`; main:
`3ce020d0098a891ce86646ae85e745aaa49ae825`. The existing dirty website files
were preserved and stabilized rather than reset.

The candidate contains 249 authored teaching units, plus 1,046 separately
audited data constructions (not proofs) and 16 unresolved constructions.
The exhaustive generated ledger continues to expose the missing expositions.
Registry stays 394; 12 Chewi chapters, 522 modules and 3,622 declarations remain
inventoried. Adjacent Lean disclosures use exact checkout code. Source-body
digests and exact rendered-body checks prevent truncated or falsely explained
metadata records from passing validation.

Validation before source publication: `lake build Tests` and canonical ASTIS
check passed (9,050 jobs); 152 website/reader/metadata/Harness regression tests
passed; generator compilation and whitespace checks passed. The full generated
website inventory/link/status gate passed. The final published source must
receive a refreshed commit-bound Lean gate and website build, not reuse a
gate marker from the preceding commit.

Legacy website branches are consolidated by preserving the modern equivalent,
not overlaying old generated pages. Before any remote deletion, preserve each
exact tip under `archive/website-20260909/<branch>` and push that tag:

| Branch | Audited tip | Disposition |
| --- | --- | --- |
| harness-vnext1-public-copy-fix | 1557f61dfd4979c7c7ef2f4343ffc4db810b1af6 | Port the three surviving copy/idempotence fixes to current harness.py with regression test; obsolete renderer stays removed. |
| library-shelves-beck-boumal-20260829 | b32470e010857ad318262cc6561d34d592349d41 | Superseded by main f359a10 / PR 207 and subsequent library work. |
| progress-routes-theme-harness-20260830 | 55d252d1f8fba932bc22a95102a5c3788b680363 | Superseded by main 0cc34c6, f3c1005 and 73ce30a. |
| live-pages-verification | 920378b4710ca5f2165f2581a6121761c8339ba6 | Closed temporary old-date deployment check; do not merge obsolete assertions. |
| harness-frontier-cells-vnext1 | 936d046ea066f07c23ed03712ad35e4f711d7c40 | Already an ancestor of the stabilization branch. |

Independent mathematical branches, including the duplicate Discrete Sampling
branch with unique audit notes, are outside this cleanup. Preserve them.
Public GitHub Pages and the existing owner-private Sites site keep their
current audiences. Deployment success is reported only after its actual gate;
the branch table is a cleanup plan until remote refs have been verified absent.

## Active user correction: complete per-declaration textbook exposition

The later user message explicitly rejected the three-reader scope as
insufficient. The current task is the full existing-Lean teaching expansion:
complete mathematical statements, all actual hypotheses, formula-by-formula
proofs, and an adjacent folded Lean explanation beneath each statement and
proof. Do not resume the mathematical frontier or present this task as done
while that expansion is incomplete. No overall Goal transition is authorized.

The local candidate `de33b695fe0a9c111858fb6190d2f67b1ad39abb` contains the
earlier three readers; it has not been pushed. New revisions use individual
theorem units, an exhaustive source-derived teaching ledger, and authored
module-complete batches. The proof inventory currently distinguishes 3,572
production declarations from 50 test declarations; many production definitions
are provenance or workflow data, not theorems. Registry remains 394 and its
content hash is unchanged. Source records and stored status strings must not
be counted as mathematical proofs.

Bounded researchers author only ignored dossiers. Root is the sole website
writer. The kernel and heat-bath expositions received independent cross-review;
the two finite-measure/s-finiteness prose corrections were applied. Browser
checks of the revised first 22 declaration units found rendered equations,
closed adjacent Lean controls, and no MathJax errors or document overflow.
These checks certify that bounded batch, not the full-library completion claim.
Further batches and the full site gates remain tracked by generated coverage.

## Earlier publication checkpoint (historical scope)

The user explicitly authorized pushing current progress. The existing 17
commits through `4a0a049012ae78348b01789385e2e67a54418da0` were pushed to
`origin/codex/samplewiki-shared-stabilization`. Remote main was unchanged at
`3ce020d0098a891ce86646ae85e745aaa49ae825`. No merge, force push, PR creation,
Pages workflow dispatch, Sites deployment or overall Goal transition occurred.

The website uses its existing static generator, canonical reader shell,
MathJax, Lean highlighter and native details disclosures. New original
exposition in `website/content/proof_readers.json` contains three supporting
proof readers, thirteen proof steps and five public theorem declarations:

- actual random-scan singleton law (four steps);
- actual-kernel reversibility and atomic-to-set bridge (four steps);
- canonical Fisher/transport pairing integrability and estimate (five steps).

This is not complete book exposition or an increase to the 77 reviewed
teaching declarations. Registry remains 394. Source inventory remains 522
modules / 3622 declarations over the twelve-chapter Chewi spine. The renderer
reads the existing inventory, current build gate, Frontier Cells and semantic
registry; the content cannot independently mark a source theorem complete.
Fisher remains proved locally, with domain-mismatch / needs-revision source
certification. Discrete source acceptance is still limited to the previously
audited statement. No mathematical packet or Lean source was modified.

Complete modules (including private helper proofs, imports and namespaces)
and exact focused tests are embedded from checkout files, not retyped copies.
ASTIS result declarations, reused ASTIS parents and called Mathlib results
have separate lists. Mathlib links use its exact pinned commit and verified
source lines. The link gate distinguishes repository and external commits.
Existing source and proof-review records remain immutable.

Browser observations on the generated pages: all three reader statement and
proof equation sets rendered without MathJax errors; step explanations and
full-source disclosures open correctly; code has syntax highlighting; initial
optional disclosures are closed. Desktop, narrow screen, long-formula horizontal
scroll and light/dark toggle were checked. The observed narrow CSS viewport
was 278 pixels (device scaling applied), with 16px body type and no document
horizontal overflow. Temporary viewport and theme settings were restored.
The chapter/library/module and home/progress pages link into these readers.

Checks are reproducible through `website/scripts/build_site.py`,
`website/scripts/check_site.py`, `tools.tests.test_proof_readers`, and the
existing canonical Lean gate. Generated output, preview service and gate logs
are not committed. Publication of a branch does not update the live Pages
site: its workflow targets main or an explicitly dispatched run.

The representative-obstruction Worker was paused at the user's interruption.
Its ignored scratch is preserved for future independent review, not published
as an admitted theorem or typed blocker. Resume the same mathematical frontier
only after this publication task; do not create a replacement Goal or cycle.
