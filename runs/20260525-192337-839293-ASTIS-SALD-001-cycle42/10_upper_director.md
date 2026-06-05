Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 42
Role: upper
Run directory: runs/20260525-192337-839293-ASTIS-SALD-001-cycle42

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

## Current 6h Priority: Proof Closure Sprint

The first transcript pass is broad enough to stop spending cycles on
rebaseline/source-index work unless a reviewer finds a blocking source anchor
gap.  The next batch should prioritize translating the paper's actual LaTeX
proofs into Lean code and closing theorem dependencies in this order:

1. `lem:gronwall`
2. `lem:dv_variation`
3. `eq:LSI-KL-FI`
4. the forward-KL Fokker--Planck/KL derivative identity
5. the Euler--Maruyama interpolation Fokker--Planck backend

Upper and middle agents must explicitly check this priority before assigning
lower work.  Lower agents should attempt proof-producing Lean lemmas first.
If a source-cited analytic theorem is too large for the current local Mathlib
state, create a precise source-cited theorem interface and use it only as an
explicit dependency; do not mark it formalized.  Systematic migration of
external SDE/Sampling facts, including material analogous to
`YuanheZ/lean-stat-learning-theory`, belongs after these proof-closure
interfaces are in place.

## Acceptance Gate

```bash
python3 tools/astis.py source-index ASTIS-SALD-001
python3 tools/astis.py check
```
```

Cycle focus:

```text
Proof-closure sprint 2: Donsker--Varadhan: Translate `appendix.tex:73-79` and the cited DV result into a precise Lean interface or proof; if source-cited, keep status source-cited and use it as an explicit dependency only.
```

Recent trial memory:

```text
2026-05-25 19:10:22 middle/handoff queued gate=not-run :: Cycle 41 middle compiled source-facing Gronwall deriv K wrappers for appendix.tex:47-71; conversion window and proof-obligation ledger updated; python3 tools/astis.py check passed; full lem:gronwall still awaits endpoint-safe differentiability/FTC bridge.
2026-05-25 19:10:56 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 19:20:18 lower/handoff queued gate=not-run :: Cycle 41 lower compiled endpoint-safe Gronwall right-derivative FTC/order-integration bridge and interior C1 wrappers for appendix.tex:47-71; updated conversion window, proof obligations, SALD dependency metadata, and test count; python3 tools/astis.py check passed; gronwall contract remains obligation pending source differentiability interpretation.
2026-05-25 19:20:44 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 19:22:59 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 41: ASTIS check passed; Gronwall source-derivative and endpoint-safe bridge declarations compile as local proof-producing wrappers; full lem:gronwall remains obligation pending endpoint-safe differentiability/FTC interpretation; no fake closure, source drift, SLT promotion, or ledger-only discipline issue.
2026-05-25 19:23:16 reviewer/build compiled gate=pass :: Cycle 41 reviewer gate: python3 tools/astis.py check passed after auditing Gronwall wrappers, source anchors, fake-proof scan, and SLT status.
2026-05-25 19:23:28 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 19:23:37 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-192337-839293-ASTIS-SALD-001-cycle42/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-192337-839293-ASTIS-SALD-001-cycle42 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-192337-839293-ASTIS-SALD-001-cycle42 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and now prioritize proof closure over new transcript/ledger expansion. Before assigning middle/lower work, explicitly check the current proof-closure order: (1) Gronwall, (2) DV, (3) LSI/KL/FI, (4) forward-KL Fokker--Planck/KL derivative, (5) EM interpolation Fokker--Planck. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized.

## Upper Packet

Priority check before lower assignment: (1) `lem:gronwall` advanced in cycle
41 with source-facing `deriv K` wrappers and endpoint-safe right-derivative
assembly, but the source-level differentiability/FTC interpretation remains an
obligation; (2) this cycle therefore returns to `lem:dv_variation`; (3)
`eq:LSI-KL-FI`, (4) the forward-KL Fokker--Planck/KL derivative identity, and
(5) the Euler--Maruyama interpolation Fokker--Planck backend remain later
proof-closure targets.

Objective: sharpen the faithful-paper DV target at `appendix.tex:73-79` by
turning the existing source-cited Boucheron Corollary 4.15 interface into a
lower-ready theorem-instance boundary.  The next useful proof-producing work
is not another broad source-index pass: it is either a local Mathlib-backed
selected-test lemma feeding `AutoSamplingTheory.dvVariationalOneSidedOfTiltedRight`
or a precise source-cited interface for the same selected-test hypotheses.

Mode discipline:

- `faithfulPaper` Phase 1 only; use the original `appendix.tex:73-79` and keep
  `sald_version_2.tex` excluded.
- Keep the source theorem fixed: probability laws `mu, nu` on the same space,
  supremum over real random variables `Z`, finite predicate
  `log E_mu[exp Z] < +infty`, and equality
  `KL(nu||mu)=sup_Z(E_nu[Z]-log E_mu[exp Z])`.
- Keep `SALD.dvContract`, `probability.dv_variational_formula`, and
  `SALD.saldStatusForLabel "lem:dv_variation"` at `sourceCited` unless a
  compiled Lean theorem proves the full supremum equality.
- Treat cycle 37's tilted one-sided theorem as a formalized selected-test
  backend only; theorem-specific SALD witnesses must remain explicit inputs.

Non-goals:

- Do not rebaseline the source index unless reviewer finds a blocking source
  anchor defect.
- Do not mark the Boucheron supremum equality formalized from the one-sided
  tilted inequality, scalar order bridges, or selected-test consequence.
- Do not add hidden finite-mgf, absolute-continuity, measurability, finite-KL,
  or log-likelihood assumptions to `thm:forward-KL` or downstream theorem
  statements.
- Do not switch to LSI/KL/FI, forward-KL derivative, EM interpolation, PI,
  guided/general VA-SALD, or broad SLT migration in this cycle.

Lower packet:

- Middle must first synchronize the exact source line window
  `appendix.tex:73-79` with `AutoSamplingTheory/Probability.lean`,
  `AutoSamplingTheory/SALD.lean`, `conversion-windows/ASTIS-SALD-001.md`,
  `proof-obligations/ASTIS-SALD-001.md`, and
  `research-wiki/cited-results/Boucheron_DV.md`.
- Target exactly one DV declaration/interface around
  `dvVariationalFormulaInterface saldDvVariationSource`,
  `SALD.dvFiniteLogMgfInterfaceObligation`,
  `SALD.saldDvFiniteLogMgfContract`, and
  `AutoSamplingTheory.dvVariationalOneSidedOfTiltedRight`.
- First proof-producing attempt: for a selected SALD test `Z`, expose or prove
  the common measurable space, `nu << mu`, `Integrable Z nu`,
  `Integrable (fun x => exp (Z x)) mu`, and `Integrable (llr nu mu) nu`
  hypotheses needed by the tilted one-sided backend.  If proving a theorem
  instance is too large, create the precise source-cited interface and keep its
  status below formalized.
- Keep `AutoSamplingTheory.dvVariationalOneSidedConsequenceScalar`,
  `AutoSamplingTheory.dvVariationalOneSidedFromSupremumScalar`, and
  `AutoSamplingTheory.dvVariationalTiltedRightOneSidedConsequence` classified
  as post-DV or selected-test consequences, not as proofs of the source
  variational equality.
- Downstream SALD uses must still supply their own common-space,
  absolute-continuity, measurability, finite-log-mgf, finite-KL/log-likelihood,
  alpha0-to-alpha monotonicity, and positive-alpha scaling witnesses before
  invoking DV.

Reviewer checklist:

- `SALD.dvContract` and `SALD.saldStatusForLabel "lem:dv_variation"` remain
  `ProofStatus.sourceCited`.
- The cycle uses `appendix.tex:73-79` and Boucheron Corollary 4.15 as the fixed
  source anchor; no `sald_version_2.tex` dependency appears.
- Any new Lean theorem is only a selected-test/backend lemma under explicit
  hypotheses, or the new item is a source-cited interface below formalized
  status.
- No `axiom`, `sorry`, `admit`, `Prop := True`, `:= trivial`, hidden theorem
  assumption, SLT promotion, or alternate entropy route appears.
- `python3 tools/astis.py check` passes; no source-index rebaseline is required
  for this upper packet.
