# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `1`

## Upper Decision

Objective for cycle 1: faithful source-index and first appendix contract
alignment for `lem:gronwall`, `lem:dv_variation`, `def:PI`, and the
KL/FI/LSI vocabulary block `eq:LSI-KL-FI`.

Mode discipline: `faithfulPaper`.  Keep all source theorem labels fixed.  Do
not add assumptions, weaken constants, replace DV/Gronwall with alternate
inequalities, or mark any analytic dependency formalized until it compiles in
Lean.

Non-goals: no proof search for `thm:forward-KL`; no restatement of the
continuous or discrete SALD theorems beyond source-anchored contracts; no use
of `sald_version_2.tex`.

Lower packet: next lower should refine `SALD.gronwallAnalyticObligation` into a
candidate Lean statement preserving the appendix hypotheses and the displayed
exponential bound.  If Mathlib integration/differentiation APIs are not enough,
record the exact source gap instead of changing the statement.

Reviewer checklist: confirm `research-wiki/source-index/SALD_original.jsonl`
excludes `sald_version_2.tex`; confirm `def:PI`, KL/FI/LSI, DV, and Gronwall
have source anchors and Lean-facing contracts; reject any fake closure or
source-cited DV claim marked formalized.

## Middle Formalization State

Updated:

- `AutoSamplingTheory/SALD.lean` now has label-specific source anchors,
  `saldKLContract`, `saldFIContract`, `saldLSIContract`, `saldPIContract`,
  `piDefinitionContract`, `lsiKlFiVocabularyContract`, and a refined first
  proof-DAG dependency/reuse map.
- `conversion-windows/ASTIS-SALD-001.md` now contains source fragments and the
  required proof-DAG table columns.
- `proof-obligations/ASTIS-SALD-001.md` now records the cycle 1 lower packet
  and reviewer checklist.
- `python3 tools/astis.py source-index ASTIS-SALD-001` regenerated
  `research-wiki/source-index/SALD_original.jsonl` with 24 declarations.

## Lower Attempts

No lower proof attempt was assigned in this upper cycle.  Gronwall remains an
explicit obligation; DV remains source-cited.

## Reviewer Findings

Gate result: `python3 tools/astis.py check` passed.

## Next Cycle Objective

Lower/middle should start from `SALD.gronwallAnalyticObligation` and decide
whether the exact appendix Gronwall statement can be expressed cleanly with the
current Mathlib real integration APIs.  If not, add the minimum precise source
dependency gap to `proof-obligations/ASTIS-SALD-001.md`.
