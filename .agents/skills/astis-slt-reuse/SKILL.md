---
name: astis-slt-reuse
description: Port or audit reusable probability/concentration results from YuanheZ/lean-stat-learning-theory into ASTIS under the Lean 4.29.1 toolchain.
argument-hint: "[upstream declaration]"
---

# ASTIS SLT Reuse

Use this before relying on a theorem from
`YuanheZ/lean-stat-learning-theory`.

## Source

- GitHub: `https://github.com/YuanheZ/lean-stat-learning-theory`
- Paper: `https://arxiv.org/abs/2602.02285`
- Local clone: `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory`
- Upstream toolchain: `leanprover/lean4:v4.27.0-rc1`
- ASTIS toolchain: `leanprover/lean4:v4.29.1`

## Workflow

1. Locate the upstream file and declaration.
2. Copy the exact statement into a reuse entry or conversion window.
3. Classify status as `direct-port`, `needs-mathlib-api-update`,
   `reference-only`, `blocked`, or `formalized`.
4. If porting, adapt imports and Mathlib API changes in a local ASTIS module.
5. Run `python3 tools/astis.py check`.
6. Update `research-wiki/cited-results/SLT_reuse_audit.md`.

Do not treat an upstream theorem as proved in ASTIS until it builds locally.

