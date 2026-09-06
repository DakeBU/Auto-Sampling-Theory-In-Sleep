# ASTIS Blueprint-style site insertion baseline

Recorded before website source changes on 2026-07-27 (Asia/Singapore).

## Repository identity

- Project: `Auto-Sampling-Theory-In-Sleep`
- Repository: `D:\Users\HUAWEI\Desktop\Github\Auto-Sampling-Theory-In-Sleep`
- Branch: `main`
- Commit: `83d32c30d8020086904ccf2459630ef14936771b`
- Worktree: dirty; all pre-existing changes are preserved.

## Goal and cycle state

- Existing ASTIS Goal: paused for this temporary insertion task; not replaced,
  completed, or forked.
- Historical user baseline: Cycle 25 complete, Cycle 26 opened at 253 compiled
  leaves.
- Current repository truth: Cycle 26, Cycle 27, and Cycle 28 artifacts exist;
  Cycle 28 passed its gates; Cycle 29 had reached statement audit only when the
  website task paused it.
- Resume contract: restore the same Cycle 29 statement-audit frontier after the
  website task. Do not roll back to the historical Cycle 26 snapshot.
- Registry/test count: `256` compiled local leaves.

## Pre-existing uncommitted changes

The exact `git status --short` output was recorded in the controlling chat
before site edits. Its paths fall into these preserved groups:

- Lean progress:
  `Analysis/Calculus/Divergence.lean`, `Registry.lean`,
  `StochasticProcesses/Langevin.lean`, and `Tests/Basic.lean`.
- Primary documentation and generators:
  `README.md`, `MANIFEST.md`, and `tools/astis.py`.
- Generated diagrams:
  Chapter/status/foundation/module/SDE SVG and PNG assets.
- Generated research metadata:
  roadmap, retrieval indexes, module cards, external-library cards, and
  log-concave-sampling overview material.
- Harness memory:
  `runs/trials.jsonl`, `runs/trials_summary.csv`, and the untracked Cycle
  26–28 run directories.
- Existing line-ending-only/no-semantic noise includes `lake-manifest.json`;
  no reset or checkout is authorized.

## Existing website infrastructure

No `.openai/hosting.json`, Blueprint, Verso, doc-gen4, Sphinx, MkDocs,
Docusaurus, package manifest, or GitHub Pages workflow existed at this
baseline. The repository did contain reusable ASTIS documentation, Registry
metadata, chapter roadmaps, theorem/module cards, retrieval indexes, and
version-controlled Mermaid/SVG/PNG graphs.

## Copyright decision

- The June 12, 2026 `Log-Concave Sampling` book draft and the author's book
  page expose no explicit license for republication.
- A Creative Commons license on a different Chewi work does not license this
  book draft.
- The site therefore uses faithful ASTIS paraphrase, original supplemental
  derivations, precise source correspondence, and only necessary short
  quotations. It does not reproduce the book wholesale.
- Sho Sonoda's `lean-ridgelet` repository is Apache-2.0 and uses a Verso
  Blueprint. ASTIS takes organizational inspiration only; no code, template,
  or style is copied.
