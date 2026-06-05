Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 4
Role: upper
Run directory: runs/20260524-200351-331721-ASTIS-SALD-001-cycle04

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
Guided and general VA-SALD path: `prop:guided_path_residual`, `thm:general-moving-target-SALD`, `thm:unified-forward-KL`, and `thm:general-moving-target-SALD-discrete`.
```

Recent trial memory:

```text
2026-05-24 19:52:22 middle/handoff queued gate=pass :: Middle handoff: split discrete forward-KL Gronwall accumulation from linear-slowdown specialization; Lean contract data, conversion window, proof obligations, SLT audit, and source index synchronized; python3 tools/astis.py check passed.
2026-05-24 19:52:41 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 19:59:56 lower/handoff queued gate=not-run :: Split discrete EM interpolation setup into endpoint-law, conditional-drift/Fokker--Planck, and stitched-interval regularity obligations; synchronized Lean, conversion window, proof obligations, source index; check passed.
2026-05-24 20:00:22 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 20:02:35 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 3: source-index refreshed with 24 declarations excluding sald_version_2.tex; discrete forward-KL source correspondence and proof-status audit passed; analytic discrete pieces remain obligations/source-cited; check passed.
2026-05-24 20:03:35 reviewer/build compiled gate=pass :: Cycle 3 reviewer gate: source-index refreshed and python3 tools/astis.py check passed after handoff logging.
2026-05-24 20:03:44 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 20:03:51 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-200351-331721-ASTIS-SALD-001-cycle04/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-200351-331721-ASTIS-SALD-001-cycle04 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260524-200351-331721-ASTIS-SALD-001-cycle04 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving.

## Upper Selection

Objective: pin the continuous guided/general VA-SALD route, centered on
`thm:general-moving-target-SALD`, with `prop:guided_path_residual` and
`thm:unified-forward-KL` included only as source dependencies/specializations.

Source anchors:

- `prop:guided_path_residual`: `appendix.tex:619-704`;
- `thm:general-moving-target-SALD`: statement `appendix.tex:724-760`, proof
  `appendix.tex:765-949`;
- `thm:unified-forward-KL`: statement `main_body.tex:372-395`, proof
  specialization `appendix.tex:949-951`.

Mode discipline:

- `faithfulPaper`; keep the source theorem and sigma-weighted constants fixed;
- preserve `m_t=v_t-c_t`, and for the unified theorem only specialize
  `c_t <- u_t`;
- keep DV, Gronwall, Fokker--Planck, integration by parts, and time-change
  facts as obligations or source-cited dependencies.

Lower packet:

- target `SALD.generalMovingTargetDerivativeCandidateContract`;
- preserve
  `dK/dt <= -(sigma_t^2/2)*dot{s}(t)*C_LSI(t)*K(t)
  + sigma_t^(-2)*dot{s}(t)^(-1)*||m_t||_{L2(rho_{s(t)})}^2`;
- expose `eq:general_moving_target_FP`, the residual combination
  `m_t=v_t-c_t`, and Young's parameter
  `epsilon=2*dot{t}(s)/sigma_{t(s)}^2`;
- record sigma positivity, density/boundary regularity, and inverse-schedule
  requirements as obligations/source gaps.

Non-goals:

- do not prove the full theorem;
- do not replace the residual DV route with Girsanov/path-space reasoning;
- do not touch `sald_version_2.tex`;
- do not start the discrete general theorem until this continuous derivative
  interface is audited.

Reviewer checklist:

- `SALD.generalMovingTargetStatementContract` matches `appendix.tex:724-949`;
- `SALD.guidedResidualIdentityContract` preserves the centered residual
  `g_t-E_{pi_t}[g_t]`;
- `SALD.unifiedForwardKlSpecializationObligation` is only the source
  specialization `c_t <- u_t`;
- no obligation is marked formalized and no forbidden fake closure is used.
