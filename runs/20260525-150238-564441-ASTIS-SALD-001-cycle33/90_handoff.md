# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `33`

## Upper Decision

Proof-closure priority check: (1) `lem:gronwall` remains an obligation after
cycle 31 partial sublemmas, (2) `lem:dv_variation` remains source-cited after
cycle 32 scalar bridges, so cycle 33 selects item (3) `eq:LSI-KL-FI`.  Items
(4) forward-KL Fokker--Planck/KL derivative and (5) EM interpolation
Fokker--Planck remain later targets.

Objective: keep the source statement fixed and translate
`main_body.tex:202-215` into proof-producing density/test-function slices for
the LSI-to-KL/FI bridge, starting with `phi=sqrt(r)` where
`r=d rho/d pi`.

Mode discipline: `faithfulPaper`, Phase 1 only.  Preserve
`KL(rho||pi) <= FI(rho||pi)/(2*C_LSI)`, keep all density,
admissibility/approximation, finite KL/FI, zero-density, entropy, and FI
chain-rule requirements explicit, and do not use `sald_version_2.tex`.

Non-goals: no source-index rebaseline unless reviewer finds an anchor defect;
no replacement by PI, Pinsker, Talagrand, transport, or direct forward-KL
arguments; no status promotion for `eq:LSI-KL-FI`,
`probability.lsi_to_kl_fi`, or `SALD.lsiKlFiDensityTestObligation`.

Lower packet: target exactly `SALD.saldLsiKlFiDensityTestContract` /
`SALD.lsiKlFiDensityTestObligation` /
`sald.lsi_kl_fi.density_test_interface`.  First attempt a compiled local
lemma for the `sqrt(r)` pointwise square/normalization or entropy handoff
under explicit `0 <= r` and density hypotheses.  If that closes, connect it to
the integral normalization or entropy rewrite.  Treat the FI chain rule as a
separate obligation unless a narrow compiled calculus lemma actually builds.

Reviewer checklist: verify the cycle chose proof-closure item (3); any new
Lean proof must be a local density/test-function or scalar lemma tied to
`main_body.tex:202-215`; no hidden smoothness, positivity, or integrability
assumption may enter later theorem contracts; fake proof closures remain
rejected; `python3 tools/astis.py check` must pass.

## Middle Formalization State

Cycle 33 middle stayed on proof-closure priority item (3), `eq:LSI-KL-FI`,
after checking that Gronwall and DV remain in the statuses accepted by cycles
31 and 32.  The pass added proof-producing scalar density-test lemmas in
`AutoSamplingTheory/Probability.lean` for the source substitution
`phi=sqrt(r)` in `main_body.tex:208-215`:

- `AutoSamplingTheory.lsiKlFiSqrtDensitySquareScalar` proves
  `(sqrt r)^2=r` from `0<=r`.
- `AutoSamplingTheory.lsiKlFiSqrtDensityEntropyIntegrandScalar` rewrites
  `phi^2*log(phi^2)` to `r*log(r)` pointwise under the same nonnegativity
  input.
- `AutoSamplingTheory.lsiKlFiSqrtDensityNormalizationScalar` transports
  density normalization to the LSI test normalization once the integral backend
  has identified `testMass=densityMass`.

The new `SALD.cycle33LsiKlFiDensityTestMiddleObligation` wires these scalar
lemmas into `sald.lsi_kl_fi.density_test_interface`.  The Radon-Nikodym
density construction, a.e. nonnegativity, integral transport, smooth/admissible
`sqrt(r)` or approximation, finite KL/FI, zero-density convention, and FI
chain rule remain explicit obligations.  `eq:LSI-KL-FI` and
`probability.lsi_to_kl_fi` were not promoted.

## Lower Attempts

Cycle 33 lower added `SALD.lsiKlFiDensityTestBridgeScalar`, a compiled scalar
bridge for `main_body.tex:208-215`.  Given the normalized LSI test inequality
for `phi=sqrt(r)`, the entropy identity `entropy=KL`, the FI chain-rule input
`dirichlet=(1/4)*FI`, and `C_LSI != 0`, it derives the displayed
`KL <= FI/(2*C_LSI)` by reusing `SALD.lsiKlFiCoefficientAuditScalar`.

The new `SALD.cycle33LsiKlFiDensityTestLowerObligation` wires this into
`sald.lsi_kl_fi.density_test_interface`.  The Radon-Nikodym density backend,
integral transport, smooth/admissible `sqrt(r)` or approximation, finite
KL/FI, zero-density convention, FI chain rule, and
`probability.lsi_to_kl_fi` remain obligations.  No theorem target or source
status was changed.

## Reviewer Findings

## Next Cycle Objective
