Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 112
Role: upper
Run directory: runs/20260605-043400-136996-ASTIS-SALD-001-cycle112

Mandatory gate:

```bash
python3 tools/astis.py check
```

Task contract:

```text
# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
Remaining exact boundary: source density-ratio a.e. equality with hat rho_...

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.
```

Cycle focus:

```text
Post-84 closure 4: discharge one supplied EM hypothesis: Choose exactly one supplied hypothesis used by cycles 80-84 and replace it with a compiled local theorem or a narrower source-cited boundary.  The acceptable targets are conditional-kernel existence, conditional integral regularity, generator-to-law weak FP, or log-ratio admissibility.
```

Recent trial memory:

```text
2026-06-05 04:31:18 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-06-05 04:33:32 reviewer/handoff queued gate=not-run :: narrows-source-cited-boundary. Reviewer accepted cycle 111 after mandatory gate passed and proof-diagnostics forbidden_hits=0. The compiled target-time packet narrows ASTIS.SALD.cycle105.remaining_pure_raw_kl_boundary for appendix.tex:1358-1366: SALD.generalMovingTargetDiscreteTargetTimeDerivativeOfDominated proves the weighted target-density derivative/integrability subterm by Mathlib parametric integral, SALD.ge...
2026-06-05 04:33:50 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-06-05 04:34:00 reviewer/build compiled gate=pass :: Cycle build gate.
```

Compact context pack: `runs/20260605-043400-136996-ASTIS-SALD-001-cycle112/05_context_pack.md`

```text
# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `112`
- Generated: `2026-06-05 04:34:00`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
Remaining exact boundary: source density-ratio a.e. equality with hat rho_...

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Post-84 closure 4: discharge one supplied EM hypothesis: Choose exactly one supplied hypothesis used by cycles 80-84 and replace it with a compiled local theorem or a narrower source-cited boundary.  The acceptable targets are conditional-kernel existence, conditional integral regularity, generator-to-law weak FP, or log-ratio admissibility.

## Recent High-Signal Handoffs

- discharges-supplied-hypothesis: compiled dominated parametric-integral generator-to-law handoff for appendix.tex:1379-1387, discharging hsampleGenerator; mandatory gate passed.
- discharges-supplied-hypothesis. Reviewer accepted cycle 110 after mandatory gate passed and proof-diagnostics forbidden_hits=0. The dominated generator-to-law theorem removes hsampleGenerator via Mathlib parametric-integral plus existing lawMapIntegral transport, with no source drift, SLT import, Lake change, fake closure, theorem-status promotion, wrapper churn, or non-active work. Remaining boundary is concrete EM pointwise derivative/domination, derivative-value identification, hbarBCondExp, no-boundary, and...
- narrows-source-cited-boundary: selected the appendix.tex:1358-1366 KL target-time derivative/integrability subtheorem inside SALD.GeneralMovingTargetDiscretePureRawKlDerivativeNoMassAtFiniteKlLlr; rejects hkl/hlog/hmass/weak-FP wrapper churn; mandatory astis check passed.
- narrows-source-cited-boundary; compiled target-time dominated parametric-integral handoff for appendix.tex:1358-1366; gate passed; forbidden_hits=0
- narrows-source-cited-boundary: compiled SALD.generalMovingTargetDiscreteTargetTimeDerivativeSourceRatioCongr for appendix.tex:1358-1366; source-ratio a.e. congruence bridge for target-time integral/integrability/HasDerivAt after dominated theorem; mandatory astis check passed.
- narrows-source-cited-boundary. Reviewer accepted cycle 111 after mandatory gate passed and proof-diagnostics forbidden_hits=0. The compiled target-time packet narrows ASTIS.SALD.cycle105.remaining_pure_raw_kl_boundary for appendix.tex:1358-1366: SALD.generalMovingTargetDiscreteTargetTimeDerivativeOfDominated proves the weighted target-density derivative/integrability subterm by Mathlib parametric integral, SALD.generalMovingTargetDiscreteTargetTimeDerivativeSourceRatioCongr isolates the source density-ratio a.e....

## Local SLT And Paper Reuse

- SLT local project (exists): `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory`.
- SLT paper source (exists): `/home/nitanda_sub/mark/repos/RMFLD/Statistical Learning Theory in Lean 4 Empirical Processes from Scratch`.
- First consult `SLT/EfronStein.lean` for conditional expectation/product-measure proof engineering.
- Consult `SLT/GaussianLSI/TensorizedGLSI.lean`, `SLT/GaussianMeasure.lean`, and `SLT/SmallBallProb.lean` for `Measure.map`, integral, product, and Bochner-style rewrites.
- Consult the SLT article LaTeX for the writing principle: expose measurable/topological hypotheses explicitly; do not promote background analysis until a local ASTIS declaration compiles.
- Do not add SLT as a Lake dependency while the toolchain mismatch remains; port local statements or record cited proof obligations.

## Self-Reflection Guard

- Start the handoff with one packet classification from the allowed list.
- Name the exact supplied hypothesis discharged or the exact missing theorem boundary narrowed.
- State which local SLT/Mathlib files were consulted or why no consultation was needed.
- Reject broad source-index, route-audit, wrapper, or project-article work unless it directly closes the active blocker.
- Keep `python3 tools/astis.py check` as the mandatory gate.
```

Shared dialogue board: `runs/20260605-043400-136996-ASTIS-SALD-001-cycle112/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260605-043400-136996-ASTIS-SALD-001-cycle112 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260605-043400-136996-ASTIS-SALD-001-cycle112 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. First read the compact context pack and run the self-reflection guard: if the planned packet is wrapper churn, reject it and choose a narrower target. Begin with a concise `Global phase judgment:` paragraph that answers: did the previous cycle fail and need recovery; is Phase 1 theorem-skeleton translation stable enough for cited-theory backfill; and which single lower packet now reduces the largest proof risk. For SALD after cycle 69, treat the theorem-skeleton route as stable enough for single-backend backfill. Keep the source theorem fixed and now prioritize the active EM conditional-law/Fokker--Planck backend over new transcript/ledger expansion, broad theorem-route audits, or isolated scalar sublemmas. For SALD after cycle 84, do not let the run accumulate more supplied-hypothesis wrappers unless they discharge or strictly narrow an existing supplied hypothesis. The priority is a smallest real backend theorem boundary: conditional kernel/conditional expectation, generator-to-law weak FP, KL/log-ratio admissibility, or one named LSI/DV/Gronwall blocker. If recent trial memory shows a failed cycle after an upper or middle handoff, recover that cycle first instead of advancing to a new source target. Before assigning middle/lower work, explicitly check that the active lower packet still targets `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`, unless reviewer identified a theorem-route blocker. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized. Use `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory` as a reference for Mathlib measure/probability style when helpful, but do not import it as a Lake dependency or claim an SLT theorem is formalized unless a local ASTIS declaration compiles.
