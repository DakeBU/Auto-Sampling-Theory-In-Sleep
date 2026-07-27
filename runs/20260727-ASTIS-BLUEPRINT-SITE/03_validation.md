# ASTIS Blueprint-style site validation

Validated on 2026-07-27 in the protected dirty worktree.

## Generated inventory

- 337 generated files under `_site/`
- 12 chapter pages plus the textbook index
- 258 Registry theorem cards
- 31 Lean module cards
- 256 blue compiled local declarations
- 14 fine-grained source correspondence entries
- 10 version-controlled Mermaid diagram sources
- 3 visual themes: Blueprint, Modern, Bold
- light and dark color schemes

## Website gates

Passed:

```text
python tools/astis.py site-build
python tools/astis.py site-check
python -m py_compile tools/astis.py tools/astis_site.py
node --check website/static/app.js
git diff --check
```

`site-check` validated:

- all required pages and assets;
- all internal file links and fragment anchors;
- every blue Registry declaration resolves to Lean source;
- every blue declaration has a theorem card;
- every source mapping declaration exists in the Registry;
- chapter modules resolve to real module cards;
- compiled Registry count equals the `Tests/Basic.lean` baseline;
- no absolute Windows path is present in generated content;
- theme, formula, Lean-code, Mermaid, and attribution hooks.

## Lean and ASTIS gates

Passed:

```text
lake build Tests
# Build completed successfully (3641 jobs).

python tools/astis.py check
# cache retrieval, lake build, lake build Tests
# ASTIS check passed
```

The Windows environment did not expose `python3` directly, so the bundled
Python 3 runtime executed the same scripts.

## Frontier preservation

- branch: `main`
- commit: `83d32c30d8020086904ccf2459630ef14936771b`
- Registry: 256 compiled local leaves
- no Cycle 29 theorem implementation was added
- no theorem statement or proof was changed by the website task
- the current first red route remains concrete generator-display
  integrability / weighted-score integrability
- Gibbs tail, whole-space weighted IBP, generator/semigroup domains, and
  invariant Gibbs law remain independent red nodes
- Hessian/Laplacian `O(R^-2)` remains deferred pending a real second-order
  consumer

