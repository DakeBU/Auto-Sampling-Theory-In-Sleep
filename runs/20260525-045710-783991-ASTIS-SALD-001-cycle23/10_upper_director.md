Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 23
Role: upper
Run directory: runs/20260525-045710-783991-ASTIS-SALD-001-cycle23

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
2026-05-25 04:45:36 middle/handoff queued gate=not-run :: Cycle 22 middle source-to-Lean map added: SALD.cycle22ForwardKlMiddleContract plus synchronized conversion window, proof-obligation ledger, SLT audit, and thm:forward-KL dependencies. Lower target remains SALD.forwardKlGronwallSideConditionContract / sald.forward_kl.gronwall_side_conditions, first sub-slice coefficient regularity and adjacent interval-integrability before SALD.gronwallExpProductRewriteIntegralCongr. Source-index refreshed 24 declarations; check passed.
2026-05-25 04:45:56 middle/build compiled gate=pass :: Cycle 22 middle mandatory gate: source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 04:46:13 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:53:37 lower/handoff queued gate=not-run :: Cycle 22 lower formalized SALD.forwardKlGronwallCoeffIntervalIntegrable, SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable, and SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces for the continuous forward-KL Gronwall side-condition bridge. Source-index refreshed; mandatory check passed. Remaining obligations: source piece regularity/integrability for dot{s}*C_LSI, alpha coefficient, b(t), endpoint rewrites, residual exponent monotonicity, DV/LSI/KL derivative/full Gronwall.
2026-05-25 04:54:13 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:56:26 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 22. Source-index refreshed 24 labels and mandatory check passed. Accepted only the compiled local coefficient interval-integrability and exponent-congruence assembly lemmas; continuous forward-KL theorem and analytic backends remain obligations/source-cited. No fake proof closures, sald_version_2.tex use, source-index drift, or SLT promotion found.
2026-05-25 04:57:02 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:57:10 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-045710-783991-ASTIS-SALD-001-cycle23/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-045710-783991-ASTIS-SALD-001-cycle23 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-045710-783991-ASTIS-SALD-001-cycle23 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end.

## Cycle 23 Upper Decision

Objective: return to `thm:forward-KL-discrete` and rebaseline the full source
spine from Euler--Maruyama interpolation through one-step frozen score defects
and accumulated error, while selecting exactly one lower target:
`SALD.discreteForwardKlCoefficientChainAuditContract` /
`SALD.discreteForwardKlCoefficientChainObligation` /
`sald.discrete_forward_kl.coefficient_chain_audit`.

Mode discipline:

- `faithfulPaper`; use only the original `main_body.tex:273-323` and
  `appendix.tex:260-592`; keep `sald_version_2.tex` excluded.
- Preserve `t(s)=s/r`, the source step-size condition, alpha ranges,
  `Gamma`, `Delta`, `barGamma`, `barDelta`, and the constants
  `T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
  `(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`.
- Keep EM Fokker--Planck, omitted SALD frozen-defect proof, LSI-to-KL/FI,
  DV, Gronwall, endpoint stitching, coefficient integrability, and
  interval-integral monotonicity as obligations/source-cited facts.
- Middle must keep the Lean packet, conversion window, proof-obligation
  ledger, source index, and TeX windows synchronized in both directions.

Lower packet:

- First lower sub-slice: audit `appendix.tex:454-553`, including the two
  `1/4*FI` cross-term bounds, LSI conversion, DV coefficient
  `dot{t}(s)^2*alpha^(-1)`, and the time-change rewrite to
  `dot{s}(t)^(-1)*alpha^(-1)`.
- If stable, extend only to the bridge from `appendix.tex:557-590` to
  `main_body.tex:309-323`, recording endpoint stitching, residual exponent
  drop, and full-interval integral collection gaps explicitly.

Non-goals:

- Do not prove or restate `thm:forward-KL-discrete`.
- Do not reopen the continuous forward-KL theorem except as an inherited
  dependency.
- Do not replace the one-step frozen-defect route with an alternate entropy,
  path-space, or Girsanov route.
- Do not promote `lem:dv_variation`, `lem:gronwall`, `eq:LSI-KL-FI`, EM
  Fokker--Planck, or the omitted frozen-defect proof.

Reviewer checklist:

- `SALD.discreteForwardKlProofDag` contains
  `ASTIS.SALD.forward_KL_discrete.cycle23_upper_packet` before
  `ASTIS.SALD.forward_KL_discrete.coefficient_chain_audit`.
- `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes
  `SALD.cycle23DiscreteForwardKlUpperPacket` while retaining cycle-15 and
  cycle-19 packets.
- The conversion window, source index, and proof-obligation ledger cite
  `main_body.tex:273-323` and `appendix.tex:260-592` and still exclude
  `sald_version_2.tex`.
- No analytic dependency is marked formalized and the fake-proof scan remains
  clean.
