# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `6`

## Upper Decision

Keep `thm:forward-KL` fixed and refine the theorem-level moving-target
dependency chain.  Added `SALD.forwardKlMovingTargetDependencyContract` and
`SALD.forwardKlMovingTargetDependencyObligation` to record the SALD law,
slowed target, transport velocity, LSI bridge, DV finite-log-mgf bridge,
Gronwall coefficients, and endpoint identities as obligation data.

Lower packet: target one slice of
`sald.forward_kl.moving_target_dependency_chain` only: endpoint schedule
identities, slowed-target transport velocity, DV finite-log-mgf witness, or
Gronwall coefficient regularity.  Preserve the source theorem statement and
the derivative -> LSI -> DV -> Gronwall route.

Reviewer checklist: ensure the new obligation is listed in
`SALD.continuousSaldContract`, the forward-KL proof DAG includes
`ASTIS.SALD.forward_KL.moving_target_dependencies`, `sald_version_2.tex`
stays excluded, and no analytic dependency is promoted to formalized.

## Middle Formalization State

## Lower Attempts

## Reviewer Findings

## Next Cycle Objective
