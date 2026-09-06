# Anonymous Review Artifact — Sampling Theory Lean Library

This frozen branch accompanies the double-blind submission **“An Automated Theorem Proving System and Visualized Lean Library for Sampling Theory.”**

It contains only reviewer-facing material:

- a minimal reproducible Lean case study for the shared strong-convexity interface;
- a static anonymous reader under `site/`;
- no author list, institution, development-account link, GitHub Actions URL, or development history file.

## Reproduce the Lean case

```bash
lake update
lake exe cache get
lake build ReviewLibrary ReviewTest
lake env lean AxiomCheck.lean
```

The case study demonstrates one compiled shared foundation. It does **not** claim that the five source routes are fully formalized, and conceptual graph edges are not Lean proof dependencies unless explicitly stated.

## Local website

```bash
python3 -m http.server 8000 --directory site
```

Then open `http://localhost:8000`. The website is static and contains no analytics. Standard third-party mathematical citations are retained.
