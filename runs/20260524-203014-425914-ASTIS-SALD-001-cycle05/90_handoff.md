# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `5`

## Upper Decision

Objective: re-audit the source-index and first appendix/vocabulary layer for
`lem:gronwall`, `lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI`.

Mode discipline: `faithfulPaper`; keep the original theorem statements and
appendix labels fixed, keep `sald_version_2.tex` excluded, and leave
Gronwall, DV, and LSI-to-KL/FI as obligations/source-cited facts until Lean
proofs replace them.

Implemented upper refinement:

- added `eq:LSI-KL-FI` to `SALD.firstFaithfulLabels` and therefore to
  `SALD.saldFirstProofDag`;
- mapped the label to `saldKlFiLsiSource`,
  `AutoSamplingTheory/Probability.lean`, dependencies on `KLContract`,
  `FIContract`, `LSIContract`, and `probability.lsi_to_kl_fi`, and reuse by
  all forward-KL theorem contracts;
- synchronized the conversion window and proof-obligation upper packet.

Lower packet: refine one vocabulary interface among `SALD.saldLSIContract`,
`SALD.saldKLContract`, `SALD.saldFIContract`, and
`SALD.lsiKlFiVocabularyContract`; expose the smooth-density,
absolute-continuity, finite-KL/FI, and smooth-test-function hypotheses behind
the source substitution `phi=sqrt(rho/pi)`.

Non-goals: do not prove or restate forward-KL theorems; do not replace LSI by
PI, Pinsker, Talagrand, or another entropy inequality; do not promote DV or
Gronwall beyond their current statuses.

Reviewer checklist: confirm source index includes `lem:gronwall`,
`lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI`; confirm
`sald_version_2.tex` is excluded; confirm `eq:LSI-KL-FI` remains an obligation;
confirm no fake proof closure was introduced.

## Middle Formalization State

Re-read the cycle-focus source excerpts:

- `main_body.tex:202-215` defines LSI, applies it with
  `phi=sqrt(rho/pi)`, and defines KL/FI;
- `appendix.tex:47-79` contains the Gronwall and DV source statements;
- `appendix.tex:86-94` contains the PI vocabulary statement.

Implemented middle refinement:

- added `SALD.saldLsiKlFiBridgeContract` for the exact LSI-to-KL/FI bridge;
- added `SALD.lsiKlFiDensityTestObligation` for absolute continuity,
  density-ratio normalization, admissibility of `sqrt(rho/pi)`, finite KL/FI,
  entropy identification, and the Fisher-information chain rule;
- changed `SALD.lsiKlFiVocabularyContract` to obligation status and attached
  the new bridge obligation alongside `probability.lsi_to_kl_fi`;
- synchronized `conversion-windows/ASTIS-SALD-001.md` and
  `proof-obligations/ASTIS-SALD-001.md`.

No theorem target was changed.  Gronwall remains an obligation, DV remains
source-cited, PI remains contract-only, and `eq:LSI-KL-FI` remains an
obligation.

## Lower Attempts

## Reviewer Findings

## Next Cycle Objective
