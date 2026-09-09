# Publication protocol review · 2026-09-09

Base: `5c6adf3b812f3ba9315c92ba78a4ff59ccc2a53e`, clean `main` before work.
No Lean declarations, Registry entries, Goal state or mathematical frontier changed.
Registry remains 396. This review is engineering evidence, not a semantic
round-trip certificate for the two historical strong-convexity contributions.

Independent bounded reviewer: `publication_gate_review` (read-only). Findings
addressed with regression tests: stale independent-review replay; metadata-only
review bypass; Unicode/truncated identifiers and multiline-attribute scanner
omissions; proposition definitions counted as proofs; inactive cells displayed
as proof components. The complete source token/name check fails closed when
the current declaration inventory cannot represent a syntax form.

Validation: `lake build Tests` (9052 jobs), `tools/astis.py check` (including
8943-job root build, Tests, ATLAS and fake-closure scan), 233 Harness tests,
publication diff gate, Python compilation, site build/check and `git diff --check`.
Both edited skills passed the skill-format validator using an isolated PyYAML
runtime cached under `.astis/uv-cache`; no project dependency was added.

Actual browser QA: desktop and 412px mobile reader; 13 MathJax formulas, zero
math errors, no document-wide horizontal overflow, two closed statement and
two closed proof disclosures; expanded proof displays highlighted exact Lean.
Long mobile equations have their own horizontal scrolling. Chapter 1 shows
Partially formalized; full source equivalence and the historical blind-audit
debt remain explicit. CI also checks these reader contracts on future changes.
