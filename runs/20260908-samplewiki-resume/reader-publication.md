# Reader-facing publication checkpoint — 2026-09-09

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
