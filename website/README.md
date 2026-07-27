# ASTIS Blueprint-style textbook site

This directory contains the maintainable sources for the
Auto-Sampling-Theory-In-Sleep textbook and Lean formalization website.

The site is intentionally generated from shared repository truth:

- `AutoSamplingTheory/TechnicalLemmas/Registry.lean` supplies Registry status;
- the Lean source tree supplies declarations, files, lines, statements,
  docstrings, direct dependencies, and direct consumers;
- `Tests/Basic.lean` supplies the compiled-leaf count baseline and explicit
  smoke-test signal;
- `content/chapters.json` supplies original ASTIS textbook exposition;
- `content/source_correspondence.json` supplies precise Chewi source anchors;
- `diagrams/*.mmd` supplies version-controlled diagrams.

Generated HTML under `_site/` is disposable and is not committed.

## Build

From the repository root:

```bash
python3 tools/astis.py site-build
python3 tools/astis.py site-check
```

The generator uses only the Python standard library. On Windows, use the
Python command available in the active development environment.

For a foreground local preview:

```bash
python3 -m http.server 8000 --directory _site
```

Do not run this preview as a detached ASTIS harness process.

## Metadata contracts

### Chapter entry

Each `chapters.json` entry contains:

- stable chapter ID, number, title, and source-page range;
- chapter goal, prerequisites, concepts, and source sections;
- a self-contained calculation route;
- rigorous-detail obligations;
- real current Lean modules;
- red blockers, downstream consumers, recommended order, and status.

Chapter status is pedagogical coverage status. It never turns a theorem blue.

### Source correspondence entry

Each `source_correspondence.json` entry contains:

- a stable ID and precise chapter/section/page/kind/source URL;
- `wording_status`: `licensed original`, `short quotation`, or
  `faithful paraphrase`;
- separate source summary, ASTIS exposition, and rigorous packet;
- exact Registry declaration names only;
- separate source assumptions, formal assumptions, consumers, and status.

Do not add a declaration name until it exists in the Registry. A source entry
with `status: todo` remains red even when nearby supporting declarations are
blue.

## Adding a theorem card

Do not hand-write HTML. Add the Lean theorem through the normal ASTIS process,
compile it, register it exactly once, add an explicit test when appropriate,
then rebuild the site. `tools/astis_site.py` creates the theorem card.

The source scanner intentionally computes a conservative dependency graph by
looking for direct Registry declaration references inside each declaration
block. The resulting consumer count can under-approximate tactic-mediated or
namespace-indirect uses; it must not be described as a complete call graph.

## Updating diagrams

Edit the Mermaid source in `diagrams/`. Large graphs are split into chapter,
shared-root, frontier, and theorem-local views. Blue is reserved for compiled
ASTIS-owned declarations; red marks unfinished edges.

Run the site build, open the rendered view, and check node text, edges, color,
mobile overflow, and shared-node identity.

## Validation

`site-check` rejects:

- a Registry `formalizedLocal` declaration that cannot be resolved in source;
- a blue declaration without a generated theorem card;
- a compiled-leaf count that differs from the test baseline;
- unknown declarations in source correspondence;
- missing chapter modules;
- broken or escaping internal links;
- absolute Windows paths in generated output;
- missing themes, Lean code, formula renderer, diagrams, or attribution.

The full release gate remains:

```bash
lake build Tests
python3 tools/astis.py check
python3 -m py_compile tools/astis.py tools/astis_site.py
python3 tools/astis.py site-build
python3 tools/astis.py site-check
git diff --check
```

## Copyright

The public *Log-Concave Sampling* draft exposes no explicit permission for
wholesale republication. Website prose must therefore be original ASTIS
writing, faithful to the mathematics, linked to precise source locations, and
clearly labeled. Do not paste long source passages into the metadata.

