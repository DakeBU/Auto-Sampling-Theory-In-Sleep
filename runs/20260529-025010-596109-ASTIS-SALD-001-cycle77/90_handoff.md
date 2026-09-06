# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `77`

## Upper Decision

Global phase judgment: cycle 76 passed reviewer/build, so no recovery is
needed before new work. Phase 1 theorem-skeleton translation is stable enough
for continued cited-theory backfill. The single lower packet that now reduces
the largest proof risk is still
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the weak conditional Fokker--Planck
source-sign theorem at `appendix.tex:1379-1387`.

Objective: keep `thm:general-moving-target-SALD-discrete` and all constants
fixed while sharpening the weak conditional FP backend for the frozen
interpolation law `hat rho_s`. Lower should reuse the cycle 72 wrappers
`SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsHandoff` and
`SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsAdmissibleHandoff`
as already-compiled sign/coefficient packaging, then work on the missing
source-cited analytic interface that supplies the weak identity itself:
`partial_s hat rho_s = -div(hat rho_s*bar b_{k,s}) +
(sigma_eta^2/2)*Delta hat rho_s` for admissible weak tests.

Mode discipline: faithfulPaper only; use original `appendix.tex:1358-1387`
and keep `sald_version_2.tex` out of scope. Do not add assumptions to the
paper theorem statements, do not change the `sigma_eta^2/2` coefficient, and
do not promote the EM backend, KL derivative, LSI/KL/FI, DV, or Gronwall
interfaces above obligation/source-cited status unless the corresponding Lean
declaration builds locally.

Non-goals: no source-index rebaseline beyond the mandatory gate, no broad
theorem-route audit, no unrelated display algebra, no KL-derivative handoff
unless the weak-FP source-sign interface is the direct input, and no SLT import
or external theorem claim.

Lower packet: target `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract`
and the existing cycle 72 declarations. Either prove a narrower compiled
handoff from explicit supplied generator/conditional-law hypotheses to the
source-signed weak identity, or record the exact missing Mathlib/SDE theorem as
a source-cited obligation with hypotheses for common probability space,
regular conditional kernel, conditional drift measurability/integrability,
density/absolute-continuity of `hat rho_s`, admissible test class, covariance
`sigma_eta^2`, and boundary/integration-by-parts behavior.

Reviewer checklist: reject any cycle that only repeats cycle 72's coefficient
rewrite, changes theorem constants or source labels, marks the weak FP theorem
formalized without a compiled local declaration, imports SLT as a Lake
dependency, or weakens the backend to an unsigned/source-neutral FP statement.

## Middle Formalization State

Middle backfilled the weak conditional FP source-sign packet with
`SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorHandoff`.
The wrapper is proof-producing only after explicit supplied hypotheses: common
space, regular conditional kernel, drift regularity, density/time regularity,
admissible-test regularity, boundary behavior, a generator/time-derivative
identity, a generator source expansion, and `sigmaCoeff=sigma_eta^2/2`.
It composes those hypotheses into the source-signed weak identity with
negative drift-divergence and positive `(sigma_eta^2/2)` Laplacian.  The
actual weak FP/generator theorem, density/AC, conditional-law construction,
KL differentiation, LSI/KL/FI, DV, Gronwall, and theorem closure remain
obligations.

## Lower Attempts

Lower added `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`.
This proof-producing wrapper keeps the active backend at
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1379-1387` and composes a supplied generator/time-derivative
identity, a supplied generator split into drift and diffusion actions, supplied
source identifications for the negative drift-divergence and positive
diffusion actions, and `sigmaCoeff=sigma_eta^2/2` into the source-signed weak
FP statement on admissible tests.

The conversion window, proof-obligation ledger, SALD contracts/DAGs, and
theorem dependency list now reference both cycle-77 lower wrappers.  The
actual Brownian/EM generator theorem, conditional-law construction, density/AC,
admissible-test approximation, boundary/integration-by-parts, KL derivative,
LSI/DV/Gronwall, and theorem closures remain obligations.

Gate: `python3 tools/astis.py source-index ASTIS-SALD-001` indexed 103
declarations, and `python3 tools/astis.py check` passed.

## Reviewer Findings

## Next Cycle Objective
