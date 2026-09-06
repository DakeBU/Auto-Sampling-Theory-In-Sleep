# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `12`

## Upper Decision

Cycle 12 upper packet selected the guided/general residual DV witness:
`SALD.cycle12GeneralVaSaldUpperPacket`.

Objective: keep `prop:guided_path_residual`,
`thm:general-moving-target-SALD`, `thm:unified-forward-KL`, and
`thm:general-moving-target-SALD-discrete` fixed while isolating the
finite-log-mgf/common-space side condition for the residual DV step
`Z=alpha*||m_t||^2`.

Mode discipline: `faithfulPaper`; use `main_body.tex:359-395`,
`appendix.tex:724-951`, and `appendix.tex:1544-1603`; keep
`sald_version_2.tex` excluded; keep DV source-cited and do not add theorem
hypotheses.

Lower packet: target one of
`SALD.generalMovingTargetDvFiniteLogMgfWitnessContract`,
`SALD.generalMovingTargetDiscreteDvFiniteLogMgfWitnessContract`, or the named
obligations.  Refine only one backend: alpha0-to-alpha monotonicity for `m_t`,
common-space/absolute-continuity, measurability of `||m_t||^2`, positive-alpha
scaling, or the discrete EM interpolation common-space interface.  Preserve the
continuous coefficient `sigma_t^(-2)*dot{s}(t)^(-1)*alpha^(-1)` and the
discrete doubled coefficient `2*sigma_eta^(-2)*dot t(s)^2`.

Non-goals: do not prove or restate the general, unified, or discrete general
theorems; do not replace the residual DV route with another entropy or
path-space argument; do not simplify away sigma-weighted coefficients.

Reviewer checklist: the two new residual DV witness obligations are listed in
the appropriate theorem contracts before the DV-energy obligations; both proof
DAGs contain witness blocks before DV-energy; conversion window,
proof-obligation ledger, SLT audit, source index, and fake-proof gate remain
synchronized.

## Middle Formalization State

## Lower Attempts

## Reviewer Findings

## Next Cycle Objective
