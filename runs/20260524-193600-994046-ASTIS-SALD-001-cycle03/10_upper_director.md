Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 3
Role: upper
Run directory: runs/20260524-193600-994046-ASTIS-SALD-001-cycle03

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
Discrete forward-KL theorem: `thm:forward-KL-discrete`, Euler--Maruyama interpolation, one-step defects, and accumulated error.
```

Recent trial memory:

```text
2026-05-24 19:19:37 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 19:26:38 middle/handoff queued gate=pass :: Middle handoff: forward-KL proof DAG refined into Lean-facing contract data; source-index refreshed; python3 tools/astis.py check passed.
2026-05-24 19:27:05 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 19:31:46 lower/handoff queued gate=pass :: Refined thm:forward-KL derivative block with compiled side-condition contract and two named obligations for density/boundary regularity and inverse-schedule time change; source-index and check passed.
2026-05-24 19:32:23 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 19:35:31 reviewer/handoff queued gate=pass :: Reviewer accepted cycle 2: source-index refreshed with 24 declarations excluding sald_version_2.tex; forward-KL statement/proof split matches source; DV source-cited and Gronwall/LSI/forward-KL obligations preserved; SLT status not overstated; check passed.
2026-05-24 19:35:53 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 19:36:00 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-193600-994046-ASTIS-SALD-001-cycle03/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-193600-994046-ASTIS-SALD-001-cycle03 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260524-193600-994046-ASTIS-SALD-001-cycle03 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving.
