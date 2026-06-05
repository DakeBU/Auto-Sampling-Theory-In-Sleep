# Boucheron DV Variational Formula

Task: `ASTIS-SALD-001`

Source anchor: `/home/nitanda_sub/mark/repos/sald/paper/appendix.tex:73-79`

Paper citation: `boucheron2013concentration`, Corollary 4.15.

Status: full supremum equality source-cited, not locally formalized.

Lean-facing interface:

| Field | Contract |
|---|---|
| same-space laws | `mu` and `nu` are probability distributions on the same measurable space |
| entropy term | `KL(nu || mu)` |
| test class | real measurable random variables `Z` |
| finite-log-mgf predicate | `log E_mu[exp Z] < +infty` |
| variational display | `KL(nu || mu) = sup_Z (E_nu[Z] - log E_mu[exp Z])` |
| one-sided consequence | `E_nu[Z] <= KL(nu || mu) + log E_mu[exp Z]` for admissible `Z` |
| scalar bridges | `AutoSamplingTheory.dvVariationalOneSidedConsequenceScalar` proves `E_nu[Z]-logMgf <= KL -> E_nu[Z] <= KL+logMgf`; `AutoSamplingTheory.dvVariationalOneSidedFromSupremumScalar` proves the order step from admissible-value membership plus the source supremum identity to the same one-sided bound |
| tilted one-sided backend | `AutoSamplingTheory.dvVariationalOneSidedOfTiltedRight` proves `E_nu[Z]-log E_mu[exp Z] <= KL(nu||mu)` under explicit Mathlib absolute-continuity, integrability, finite-log-mgf, and log-likelihood hypotheses |
| tilted one-sided consequence | `AutoSamplingTheory.dvVariationalTiltedRightOneSidedConsequence` proves `E_nu[Z] <= KL(nu||mu)+log E_mu[exp Z]` by composing the tilted backend with the scalar rearrangement under the same explicit selected-test hypotheses |
| scaled selected-test backend | `AutoSamplingTheory.dvFiniteLogMgfOfLeAlpha` proves the alpha0-to-alpha finite-log-mgf handoff for `Z=alpha*q`; `AutoSamplingTheory.dvVariationalOneSidedOfScaledTest` composes that handoff with the tilted one-sided backend under explicit selected-test hypotheses |

ASTIS declarations:

| Declaration | Role | Status |
|---|---|---|
| `dvVariationalFormulaInterface saldDvVariationSource` | precise source-cited interface for `appendix.tex:73-79` | source-cited |
| `probability.dv_variational_formula` | proof obligation naming the cited formula | source-cited |
| `SALD.dvContract` | theorem contract for `lem:dv_variation` | source-cited |
| `SALD.cycle32DvVariationInterfaceObligation` | cycle 32 handoff interface | source-cited |
| `SALD.cycle32DvVariationMiddleAuditContract` | middle source-to-Lean map after Mathlib audit | obligation |
| `SALD.cycle32DvVariationMiddleObligation` | middle handoff obligation for the source-cited equality plus scalar bridge | obligation |
| `AutoSamplingTheory.dvVariationalOneSidedConsequenceScalar` | local real-order rearrangement after a DV upper bound is supplied | formalized scalar lemma |
| `AutoSamplingTheory.dvVariationalOneSidedFromSupremumScalar` | local real-order bridge from an admissible test value and source supremum identity to the one-sided consequence | formalized scalar lemma |
| `SALD.cycle32DvVariationLowerObligation` | lower handoff obligation tracking the scalar supremum bridge while DV equality and admissibility witnesses remain explicit | obligation |
| `SALD.saldDvFiniteLogMgfContract` | local instantiation side-condition ledger | obligation |
| `AutoSamplingTheory.dvVariationalOneSidedOfTiltedRight` | Mathlib-backed one-sided admissible-test inequality via exponential tilting | formalized one-sided sublemma |
| `SALD.cycle37DvVariationMiddleAuditContract` | middle source-to-Lean map classifying the one-sided theorem and preserving source-cited equality status | obligation |
| `SALD.cycle37DvVariationMiddleObligation` | handoff obligation for the one-sided tilted backend and remaining supremum equality gap | obligation |
| `AutoSamplingTheory.dvVariationalTiltedRightOneSidedConsequence` | Mathlib-backed one-sided consequence in the form consumed by SALD | formalized one-sided sublemma |
| `SALD.cycle37DvVariationLowerObligation` | lower handoff obligation tracking the composed one-sided consequence and remaining theorem-specific witnesses | obligation |
| `AutoSamplingTheory.dvFiniteLogMgfOfLeAlpha` | finite-log-mgf monotonicity for scaled selected tests from an `alpha0` exponential moment and `0 <= alpha <= alpha0` | formalized local measure-order sublemma |
| `AutoSamplingTheory.dvVariationalOneSidedOfScaledTest` | one-sided tilted DV inequality for `Z=alpha*q` after the finite-log-mgf handoff and explicit selected-test hypotheses | formalized selected-test sublemma |
| `SALD.cycle42DvVariationMiddleObligation` | middle handoff obligation tracking the selected scaled-test interface and remaining theorem-specific witnesses | obligation |
| `AutoSamplingTheory.dvVariationalScaledTestEnergyBound` | selected-test energy estimate after dividing the one-sided inequality by `alpha>0` and rewriting the log-mgf quotient as `eAlpha` | formalized selected-test sublemma |
| `AutoSamplingTheory.dvVariationalScaledTestEnergyBoundWithCoeff` | coefficient-preserving version of the selected-test energy estimate for the downstream Gronwall prefactor | formalized selected-test sublemma |
| `SALD.cycle42DvVariationLowerObligation` | lower handoff obligation tracking the scaled-energy bridge and remaining theorem-specific witnesses | obligation |

Downstream SALD theorem blocks may use the formula only through the explicit
source-cited dependency above.  They still owe common-space,
absolute-continuity, measurability, finite-log-mgf, alpha0-to-alpha
monotonicity, and positive-alpha scaling witnesses before applying the
one-sided consequence.

Cycle 32 lower update: the new scalar supremum bridge is formalized only for a
bounded set of real admissible variational values.  It does not prove the
Boucheron DV equality, boundedness of the admissible set, or membership of any
SALD squared-velocity/residual test in that set.

Cycle 37 middle update: the new tilted-measure theorem proves the
admissible-test upper bound using Mathlib `klDiv`, `Measure.tilted`, Gibbs
nonnegativity, and the tilted log-likelihood integral identity.  It still does
not prove the Boucheron supremum equality or discharge theorem-specific SALD
common-space, absolute-continuity, measurability, finite-log-mgf, or finite-KL
witnesses.

Cycle 37 lower update: the composed one-sided consequence now proves the exact
post-DV inequality shape consumed by SALD, `E_nu[Z] <= KL(nu||mu)+log
E_mu[exp Z]`, from the tilted backend and scalar rearrangement.  This remains
one-sided and selected-test dependent; the source-cited supremum equality and
theorem-specific SALD witness obligations are unchanged.

Cycle 42 middle update: `AutoSamplingTheory.dvFiniteLogMgfOfLeAlpha` now
compiles the local alpha0-to-alpha finite-log-mgf bridge for scaled tests
`Z=alpha*q`, using Mathlib's exponential-moment interval lemma.  The new
`AutoSamplingTheory.dvVariationalOneSidedOfScaledTest` applies the existing
tilted one-sided backend to that selected test.  The Boucheron supremum
equality, common-space/absolute-continuity witnesses, selected-test
integrability under `nu`, and log-likelihood integrability remain explicit
source-cited or obligation dependencies.

Cycle 42 lower update: `AutoSamplingTheory.dvVariationalScaledTestEnergyBound`
now compiles the source-shaped post-DV energy estimate for selected tests:
after the explicit hypotheses for `Z=alpha*q`, `alpha>0`, and
`eAlpha=alpha^{-1} log E_mu[exp(alpha*q)]` are supplied, it derives
`E_nu[q] <= alpha^{-1} KL(nu||mu)+eAlpha`.  The companion coefficient theorem
preserves the nonnegative prefactor used before Gronwall.  This does not
formalize the Boucheron supremum equality or any theorem-specific SALD
common-space, absolute-continuity, selected-test integrability, alpha0
finite-mgf, or log-likelihood witness.
