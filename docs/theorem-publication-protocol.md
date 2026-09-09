# Theorem publication: mathematics once, reader views automatically

Applies to **every new or changed production declaration** in every ASTIS route,
including reusable shared foundations. An unchanged historical proof is not
retroactively certified; its missing exposition or semantic audit remains debt.
The current mathematical Goal and frontier are not changed by this protocol.

## One bounded packet

```bash
python3 tools/astis_publication.py packet --cell CELL_ID
```

Read that cell's source contract, existing parents and exact interfaces. Do not
load all books, all transcripts or all Lean lessons. Search reusable APIs first.
There are no automatic model calls, background agents or new Goals in this tool.
The hosting agent follows the instructions below; mechanical CI verifies them.

## Author once

1. Maintain the existing Frontier Cell: exact canonical declaration, compiled
   checks, independent commit-bound review, consumers and residual boundary.
2. Write one authored unit per declaration in
   `website/content/declaration_lessons/*.json`. State **all** objects, domains,
   quantifiers and assumptions. Give a readable formula proof, not a tactic
   paraphrase; explain each step's Lean correspondence. Keep the exact Lean
   statement and proof in source: the renderer extracts them into separate,
   initially closed disclosures immediately beside the statement and proof.
   List actual ASTIS calls separately from Mathlib calls and external provenance.
3. Add a source item/binding in `website/content/publications/*.json` (schema 1;
   `optimisation.json` is the concrete example). Store the full attributed source
   statement once, with formulas, version and exact anchor. Bind its individual
   proof obligations to declarations and cell IDs. `proof-edge` and
   `prerequisite` are different: a convexity helper alone does not partially
   formalize a downstream gradient-flow theorem. Do not author chapter status.
4. Fill `assumption_deltas`: source wording, actual formal assumption,
   classification and mathematical explanation. Categories are `same`,
   `source-implicit`, `mathematically-necessary`, `API-limitation`,
   `generalization`, `unresolved`. A technical limitation is not a textbook
   correction. Explicitly address relevant measurability, representatives,
   regularity, integrability, domination, boundaries, domains and constants;
   explain why irrelevant categories truly do not apply.

Mathematical exposition is authored and independently checked, not inferred from
declaration names. Existing authored units are reused in the chapter reader.
No copied status table, HTML editing or new wrapper theorem is required.

## Encoder–denoiser: required semantic round trip

Follow [.agents/skills/astis-semantic-roundtrip/SKILL.md](../.agents/skills/astis-semantic-roundtrip/SKILL.md).
Compilation certifies the Lean proposition, **not** fidelity to the source.

1. Pin the original/faithfully paraphrased source and fully elaborated Lean
   statement in the canonical semantic registry. Link `audit_id` from the
   publication binding. A draft audit is allowed at `PROVED_LOCAL`, not at
   `VERIFIED` or `STABILIZING`.
2. Export `review-context --item ITEM_ID --declaration FULL_NAME` with
   `tools/astis_publication.py` and copy its `publication_binding_sha256` and
   `publication_context` into that audit. They bind the
   entire Lean module (including imports and scoped parameters), toolchain,
   dependency manifest, source statement, obligation map, assumption ledger and
   authored lesson. Both enter the independent source/repair review packets, so
   refreshing a hash cannot replay an older review. The candidate context omits
   earlier verdicts and assumption-delta classifications. A stale binding fails.
3. Export the anonymous `decoder-packet` using the existing round-trip tool.
   Give **only this packet** to a distinct source-blind decoder. The publication
   packet contains source identity and must never be used as decoder input.
4. Export a fresh anti-anchored `reviewer-packet` for a reviewer distinct from
   formalizer and decoder. Compare all seven canonical semantic slots and
   record packet/run-bound evidence. No self-certified equivalence.
5. If a source gap is discovered, retain four separate objects: the pinned
   source, actual Lean theorem, semantic mismatch and proposed repaired theorem.
   Expose the gap and its reason publicly. A repair requires its own blinded-to-
   prior-verdict, independent exact-proposal `repair-reviewer-packet`, minimality
   evidence and rigorous reference/counterexample. API convenience cannot justify
   adding a mathematical assumption to the source.

Reuse unchanged audit evidence. Reaudit only the affected bounded packet when
code, source, assumptions or explanation changes. File-level invalidation is
conservative; it intentionally catches changes outside the visible theorem body.
The system does not claim this is an optimal token budget or replace human review.

## Admission and generated views

New Harness advances use schema 4. At `PROVED_LOCAL`, include
`publication_declarations` equal to `lean_declarations`; real metadata validation
runs. `VERIFIED` and `STABILIZING` carry that same target set and require completed
independent source review. Rejected source fidelity can be published as explicit
local mathematics and a visible mismatch, never as source assimilation.
Schema 1–3 ledgers remain replayable; the Git diff gate also covers legacy lanes.

```bash
python3 tools/astis_publication.py check --base BASE_COMMIT
python3 tools/astis_semantic_roundtrip.py check
python3 website/scripts/build_site.py
python3 website/scripts/check_site.py
lake build Tests
python3 tools/astis.py check
git diff --check
```

The diff gate is intentionally conservative: all declarations in a changed
production module need publication coverage (including scoped-variable/import
changes). Root imports, Tests and the generated Registry catalog are not new
theorem proofs. CI checks the PR/push base before the expensive Lean build.
The site projects the same mapping into source chapter readers, chapter labels,
route progress and overview graph. No mapping means no inferred chapter credit.
The declaration-level Lean gate remains authoritative for **blue**; chapter
partial progress is orange and never implies exhaustive source coverage.

Migration boundary: precisely the two unchanged StrongConvexFirstOrder proofs
present at commit `5c6adf3b812f3ba9315c92ba78a4ff59ccc2a53e` may retain visible
historical round-trip debt. This is a fixed file-hash allowlist, not a contributor
opt-out. They supply partial proof components, not a source-complete certificate.
