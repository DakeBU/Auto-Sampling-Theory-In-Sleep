## Frontier Cell

- Route: `samplewiki-route | riemannian-optimization | optimisation | shared | n/a`
- Frontier Cell ID / record:
- Harness state: `claimed | proved_locally | independently_verified | stabilized | merged | blocked | quarantined | n/a`
- Exact textbook/paper/source anchor:
- Exact theorem-sized target:

## Reuse / shared-floor audit

- Samplinglib searched:
- Mathlib searched:
- Optlib / CvxLean searched when relevant:
- Active shared Frontier Cells / `Libraries/shared-foundations.yml` searched:
- Classification: `reuse | adapt | missing | out_of_scope | n/a`
- Decision: `reuse_existing | adapt_existing | new_route_local | new_canonical_shared | out_of_scope | n/a`
- Canonical declaration / shared cell when applicable:

If a missing lower-level lemma is useful to two or more routes, do **not** implement parallel route-local copies. Open/use one `route: shared` Frontier Cell and make the route-local theorem depend on it.

## Mathematical change

- Result or correction:
- Owning Lean module:
- Reusable technical leaf, textbook/paper consumer, shared foundation, harness, or website change:
- Known parents and downstream consumers:

## Status boundary

- Local declaration status:
- Mathematical route/paper-reproduction status:
- Remaining obligations or external dependencies:
- If blocked: exact blocker and strictly smaller child Frontier Cell(s):

## Design and provenance

- Important statement, naming, import, or API decisions:
- Adapted code, license, authorship, and changes from the source:
- Source-to-Lean semantic drift risks:

## Verification

- [ ] `python3 tools/astis_frontier_cells.py check`
- [ ] Relevant focused Lean tests exercise the named declaration
- [ ] Independent verification performed by someone/agent other than the proving worker before `independently_verified`
- [ ] `lake build`
- [ ] `python3 tools/astis.py check`
- [ ] `python3 tools/astis.py harness-test`
- [ ] `python3 website/scripts/lean_gate.py`
- [ ] Site build and `python3 website/scripts/check_site.py` when site-facing
- [ ] Graph/index regenerated before `stabilized`
- [ ] No `sorry`, `admit`, hidden axiom/interface closure, or fake completion
- [ ] Generated `_site/` output is not committed

## Reviewer notes

Describe statement drift risks, hidden analytic assumptions, shared-foundation collisions, unresolved source correspondence, or follow-up work that must remain visibly open.
