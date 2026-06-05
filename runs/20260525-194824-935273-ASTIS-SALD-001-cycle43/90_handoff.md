# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `43`

## Upper Decision

Cycle 43 selects proof-closure item (3), `eq:LSI-KL-FI`, after the explicit
priority check:

- (1) `lem:gronwall` has cycle 41 endpoint-safe local calculus progress but
  remains an obligation.
- (2) `lem:dv_variation` has cycle 42 selected scaled-test finite-mgf and
  one-sided energy sublemmas, while the Boucheron supremum equality remains
  source-cited.
- (3) `eq:LSI-KL-FI` is the current target.
- (4) forward-KL Fokker--Planck/KL derivative and (5) EM interpolation
  Fokker--Planck remain later closure targets.

Lean-facing packet added:

- `SALD.cycle43LsiKlFiUpperPacket`
- `SALD.cycle43LsiKlFiUpperObligation`

The packet is workflow/obligation data only. It does not promote
`eq:LSI-KL-FI`, `probability.lsi_to_kl_fi`, or the density-test backend.

## Middle Formalization State

Middle should keep `main_body.tex:202-215`, `AutoSamplingTheory/SALD.lean`,
`AutoSamplingTheory/Probability.lean`, `conversion-windows/ASTIS-SALD-001.md`,
and `proof-obligations/ASTIS-SALD-001.md` synchronized.

Current synchronized docs:

- conversion window has the cycle 43 proof-DAG pane;
- proof-obligation ledger has the cycle 43 LSI/KL/FI row;
- SLT audit records no SLT import or theorem promotion;
- `Tests/Basic.lean` checks both new cycle 43 statuses.

## Lower Attempts

Lower target is exactly `SALD.saldLsiKlFiDensityTestContract`,
`SALD.lsiKlFiDensityTestObligation`, and
`sald.lsi_kl_fi.density_test_interface`.

First attempt should be one proof-producing lemma or precise source-cited
interface for a remaining `main_body.tex:208-215` backend:

- Radon-Nikodym normalization `int r d pi=1`;
- entropy integral transport `int r log r d pi = KL(rho||pi)`;
- admissibility or approximation of `phi=sqrt(r)`;
- zero-density handling;
- vector/integral Fisher chain rule
  `int ||nabla sqrt(r)||^2 d pi = (1/4)*FI(rho||pi)`.

## Reviewer Findings

Reviewer should reject theorem restatement, hidden smoothness/positivity or
finite-integrability assumptions, alternate PI/Pinsker/Talagrand/transport
routes, source drift, SLT promotion, or any fake proof closure. The full
`eq:LSI-KL-FI` bridge remains an obligation.

## Next Cycle Objective

Proceed with the selected LSI/KL/FI density-test backend unless a reviewer
finds a blocking source-anchor defect. The next lower slice should compile one
narrow backend lemma or record the exact source-cited analytic interface.

Gate status: `python3 tools/astis.py source-index ASTIS-SALD-001` passed and
`python3 tools/astis.py check` passed.
