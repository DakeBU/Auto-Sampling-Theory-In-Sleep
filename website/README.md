# Samplinglib website

Samplinglib is the public formal library, learning environment, and
verification surface maintained by Auto-Sampling-Theory-In-Sleep (ASTIS).
This directory contains the maintainable website source. Generated output is
written to the ignored `_site/` directory.

## Source of truth

`tools/astis_site.py` deterministically combines:

- all project Lean modules, imports, declarations, source lines, docstrings,
  and placeholder signals;
- `AutoSamplingTheory/TechnicalLemmas/Registry.lean` and `Tests/Basic.lean`;
- chapter, source-correspondence, milestone, and reviewed teaching metadata in
  `website/content/`;
- editable Mermaid sources in `website/diagrams/`;
- source-bound Lean gate evidence in ignored `.astis/site-lean-gate.json`.

Local declaration status and mathematical-route status remain independent.
Task cards, prose, metadata, and a well-typed proposition do not count as a
proof.

## Build

From the repository root:

```bash
python3 website/scripts/lean_gate.py
python3 website/scripts/build_site.py
python3 website/scripts/check_site.py
```

The generated site includes the overview, twelve-chapter learning path,
implementation map, exhaustive declaration and module catalogs, reviewed
teaching pages, roadmap, ASTIS workflow, the four-stage contributor guide,
attribution, and Live Formalization workspace. Search, source anchors, status,
diagrams, and source links are all checked before publication.

## Live Formalization

Static GitHub Pages supports LaTeX rendering, reviewed mappings, library
navigation, dependency inspection, and ASTIS packet export. It cannot execute
Lean or call a formalizer.

Local verified mode adds a deterministic ASTIS formalization adapter and the
pinned Lean compiler:

```bash
python3 website/scripts/build_site.py
python3 website/scripts/ide_server.py
# http://127.0.0.1:8088/live/
```

The server is deliberately loopback-only. It limits request size and runtime,
serializes compiler work, uses a temporary directory, does not alter repository
source, and does not log submitted source bodies. It is a development service,
not a public execution sandbox.

The workspace never merges these states:

- candidate translation;
- Lean elaboration or compilation;
- semantic review;
- proof status;
- reviewer acceptance.

Unsupported formulas remain unresolved and can be exported with
`analytic_contract`, `formalization_map`, `proof_attempt`, and `review`
boundaries for ASTIS decomposition. No provider credentials are sent to the
browser.

## Authenticated private preview

Set both credentials in the remote shell before starting local verified mode:

```bash
export ASTIS_PREVIEW_USER='reviewer'
export ASTIS_PREVIEW_PASSWORD='generate-a-secret-outside-git'
python3 website/scripts/ide_server.py --port 8087
```

The same process then protects both static pages and `/api/*` with Basic Auth.
Forward it from a local computer:

```bash
ssh -N -o ExitOnForwardFailure=yes \
  -L 127.0.0.1:18087:127.0.0.1:8087 USER@SERVER
curl -I http://127.0.0.1:18087/  # 401 Unauthorized
cloudflared tunnel --url http://127.0.0.1:18087
```

Keep the preview server, SSH forward, and `cloudflared` process running. A
`trycloudflare.com` URL is temporary and is not a production deployment.
Credentials must never be committed.

For a static-only authenticated preview, `website/scripts/serve_preview.py`
remains available with the same environment variables.

## Source links and gate rules

The build checks the current commit, ref, remotes, and dirty files. Source
links use site-local declaration anchors by default. Set
`ASTIS_PUBLIC_SOURCE_LINKS=1` only after confirming the remote is public; clean
files then link to the exact published commit SHA, never assumed `main`.

`lean_gate.py` writes evidence only after the canonical ASTIS check succeeds.
The site refuses to show “Lean gate passed” when the evidence does not match
the current commit and Lean-source digest.

`check_site.py` rejects stale gate claims, Registry/test drift, unknown
metadata declarations, incomplete inventories, missing anchors, broken links,
unpinned source links, missing formulas/diagrams/assets, leaked paths, and
missing public/system identity markers.

## CI and Pages

`.github/workflows/blueprint-site.yml` runs Python and JavaScript contract
checks, harness tests, the Lean gate, site generation, site validation, and
Pages artifact creation. Pages receives only `_site/`; the loopback compiler
server is never deployed.

Website prose is original Samplinglib/ASTIS exposition. Chewi's public draft
is summarized with source correspondence rather than copied at length.
