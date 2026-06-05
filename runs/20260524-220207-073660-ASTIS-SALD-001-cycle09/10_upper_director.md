Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 9
Role: upper
Run directory: runs/20260524-220207-073660-ASTIS-SALD-001-cycle09

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
Source-index and first appendix contracts: `lem:gronwall`, `lem:dv_variation`, `def:PI`, and KL/FI/LSI vocabulary.
```

Recent trial memory:

```text
2026-05-24 21:45:38 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 21:51:31 middle/handoff queued gate=not-run :: Middle handoff: added discrete general VA-SALD Gronwall side-condition contract/obligation for stitched endpoint laws, constant inverse-schedule coefficient rewrites, coefficient regularity, and exact theorem-display matching; source-index refreshed; check passed.
2026-05-24 21:52:02 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 21:59:13 lower/handoff queued gate=not-run :: Lower handoff: added unified VA-SALD specialization contract for eq:SALD_Ito, guided residual/correction-field bridge, v_t=u_t+w_t transport identification, and m_t=w_t theorem instantiation; updated conversion window, proof obligations, SLT audit, proof DAG/dependencies; source-index refreshed; python3 tools/astis.py check passed.
2026-05-24 21:59:50 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 22:01:46 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 8: source-index refreshed with 24 declarations; audited guided residual, continuous/discrete general VA-SALD Gronwall side-condition contracts, unified specialization bridge, source anchors, fake-proof scan, and SLT reuse status; sald_version_2.tex remains excluded; all analytic steps remain obligations/source-cited; python3 tools/astis.py check passed.
2026-05-24 22:01:59 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 22:02:07 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-220207-073660-ASTIS-SALD-001-cycle09/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-220207-073660-ASTIS-SALD-001-cycle09 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260524-220207-073660-ASTIS-SALD-001-cycle09 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving.
