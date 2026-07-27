# ASTIS literate formalization website

This directory contains the maintainable sources for the generated
Auto-Sampling-Theory-In-Sleep website. The site follows the actual ASTIS
sampling/SDE modules and the twelve-chapter *Log-Concave Sampling* route.
Generated output is written to the ignored `_site/` directory.

## Source of truth

The Python standard-library generator combines:

- every project Lean module, import, named declaration, source line, docstring,
  and placeholder signal;
- `AutoSamplingTheory/TechnicalLemmas/Registry.lean` for selected reusable
  leaf provenance and Registry cards;
- `Tests/Basic.lean` for the Registry baseline;
- `content/chapters.json` for the textbook chapter route;
- `content/source_correspondence.json` for exact Chewi source anchors;
- `content/teaching_declarations.json` for the small set of manually reviewed
  teaching declarations;
- `content/milestones.json` for mathematical-route status;
- editable Mermaid sources under `diagrams/`;
- a source-bound Lean gate record under ignored
  `.astis/site-lean-gate.json`.

Local declaration status and mathematical route status are independent.
Compiling a helper declaration never marks an incomplete textbook theorem as
formalized.

## Rebuild

From the repository root:

```bash
python3 website/scripts/lean_gate.py
python3 website/scripts/build_site.py
python3 website/scripts/check_site.py
```

`lean_gate.py` runs the canonical `python3 tools/astis.py check` gate, which
builds the Lean library and `Tests` and scans for fake proof closures. It writes
gate evidence only after success. The site refuses to display “Lean gate
passed” when that evidence is absent or does not match the current commit and
Lean-source digest.

The established commands remain available:

```bash
python3 tools/astis.py site-build
python3 tools/astis.py site-check
```

## Generated pages

- Overview;
- Sampling/SDE Implementation Map;
- Guided Learning Path and twelve textbook chapters;
- exhaustive Declaration Catalog and search index;
- one page for every Lean module and stable declaration anchors;
- reviewed declaration explanations and Registry leaf cards;
- Progress and Roadmap;
- ASTIS Automation Workflow;
- Attribution and build metadata.

All named declarations enter the catalog. Only selected interfaces receive
long mathematical explanations; internal helper lemmas receive source,
status, module, and exact-line metadata without generated mathematical prose.

## Status rules

Local status:

- `Compiled`: accepted by gate evidence for the exact Lean source digest;
- `Partial`: real local source, but the current generated build has no matching
  gate evidence or the object is only part of a larger interface;
- `Stated/incomplete`: `sorry`, `admit`, `axiom`, or an explicitly incomplete
  contract boundary;
- `External/upstream dependency`: not an ASTIS-owned local certificate.

Route status:

- `Compiled`, `Partial`, `Planned`, or `Blocked`, as recorded in reviewed
  milestone metadata;
- external source and port dependencies remain explicit.

Task cards, natural-language theorem cards, proof obligations, and compiled
metadata structures do not count as theorem proofs.

## Source links

The build inspects the current Git commit, ref, origin, remote refs, and dirty
files. By default, source links point to checked site-local module anchors and
are labeled `local preview source`; this avoids public 404s for a private
repository. After verifying that the remote is public, set
`ASTIS_PUBLIC_SOURCE_LINKS=1`. Clean Lean files at a remote-published commit
then link to that exact SHA, while modified or untracked files remain local.
The generator never assumes checkout content already exists on `main`.

## Private preview

Credentials must come from environment variables:

```bash
export ASTIS_PREVIEW_USER='reviewer'
export ASTIS_PREVIEW_PASSWORD='generate-a-secret-outside-git'
python3 website/scripts/serve_preview.py
```

The default address is `http://127.0.0.1:8765/`. Neither credential is written
to generated output or committed files.

When `cloudflared` is installed, a temporary authenticated review tunnel can
be opened with:

```bash
python3 website/scripts/quick_tunnel.py
```

A Cloudflare Quick Tunnel is temporary and has no uptime, hostname, or
production-security guarantee. It is not the formal deployment.

## CI and Pages

`.github/workflows/blueprint-site.yml` installs the pinned Lean toolchain,
runs the canonical Lean/Tests/consistency gate, compiles the Python tools,
builds and validates the site, uploads the Pages artifact, and deploys it on
non-PR runs. GitHub Pages must still be enabled for Actions in the repository
settings; the workflow does not invent a successful URL before deployment.

The same checked `_site/` tree can be packaged for the private Sites project:

```bash
python3 website/scripts/build_sites_bundle.py \
  --archive /tmp/astis-sites.tar.gz
```

This creates an ignored `.open-next/` directory containing the static assets
and a minimal asset-serving Worker. It does not regenerate mathematical
content or replace the GitHub Pages artifact. The archive must be created
after the exact source commit has passed the Lean gate.

## Validation

`check_site.py` rejects:

- stale or fabricated Lean gate claims;
- Registry/test count drift;
- unknown declarations in teaching, milestone, or source metadata;
- an incomplete declaration/module/search inventory;
- missing stable anchors or broken internal links/fragments;
- source links pinned to `main` or to the wrong commit;
- missing formulas, Lean code, Mermaid sources, static assets, or attribution;
- leaked absolute Windows paths.

Website prose must remain original ASTIS writing. The public Chewi draft is
summarized and linked by precise source correspondence; long source passages
must not be copied into metadata.
