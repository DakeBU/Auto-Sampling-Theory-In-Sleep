Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 22
Role: upper
Run directory: runs/20260525-043242-009044-ASTIS-SALD-001-cycle22

Mandatory gate:

```bash
python3 tools/astis.py check
```

Task contract:

```text
# Faithfully reproduce the original VA-SALD paper proofs

Task id: `ASTIS-SALD-001`
Kind: `paperReproduction`
Mode: `faithfulPaper`
Status: `active`

## Goal

Reproduce the proof structure of `/home/nitanda_sub/mark/repos/sald/paper` in
Lean-facing contracts and, incrementally, Lean proofs.  The source file
`sald_version_2.tex` is explicitly out of scope.

## First Proof DAG

- `lem:gronwall`
- `lem:dv_variation`
- LSI/KL/FI definitions
- `thm:forward-KL`
- `thm:forward-KL-discrete`
- `prop:guided_path_residual`
- `thm:general-moving-target-SALD`
- `thm:unified-forward-KL`
- `thm:general-moving-target-SALD-discrete`

## Acceptance Gate

```bash
python3 tools/astis.py source-index ASTIS-SALD-001
python3 tools/astis.py check
```
```

Cycle focus:

```text
Continuous forward-KL theorem: `thm:forward-KL`, moving-target assumptions, and the Gronwall/DV/LSI dependency chain.
```

Recent trial memory:

```text
2026-05-25 04:18:46 middle/handoff queued gate=not-run :: Cycle 21 middle source-to-Lean map added: SALD.cycle21FirstAppendixMiddleAuditContract plus synchronized conversion window, proof-obligation ledger, SLT audit, and first-label dependencies. Lower target: SALD.saldGronwallExponentRewriteContract / sald.gronwall.exponent_rewrite. source-index refreshed 24 declarations; check passed.
2026-05-25 04:19:24 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:27:54 lower/handoff queued gate=not-run :: Cycle 21 lower formalized SALD.gronwallExpProductRewriteIntegralCongr for appendix.tex:63-69, pushing the Gronwall exponent rewrite through the outer b_t integral under adjacent interval-integrability hypotheses. Ledgers synchronized; source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 04:28:30 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:31:49 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 21 after source-index refresh and mandatory gate. Only SALD.gronwallExpProductRewriteIntegralCongr is accepted as compiled local interval-integral congruence for appendix.tex:63-69; full Gronwall, endpoint calculus, theorem-specific integrability, DV, PI, LSI/KL/FI, forward-KL and VA-SALD theorem proofs remain obligations/source-cited. No fake closures, source-index drift, sald_version_2.tex use, or SLT promotion found.
2026-05-25 04:32:18 reviewer/build compiled gate=not-run :: Reviewer final mandatory gate: python3 tools/astis.py check passed after source-index refresh and handoff logging.
2026-05-25 04:32:33 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:32:42 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-043242-009044-ASTIS-SALD-001-cycle22/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-043242-009044-ASTIS-SALD-001-cycle22 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-043242-009044-ASTIS-SALD-001-cycle22 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end.
