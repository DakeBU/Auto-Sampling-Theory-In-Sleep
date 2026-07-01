# Memory Digest: ASTIS-CHEWI-001 cycle 207

Generated: `2026-07-02 02:10:45`

Run directory: `runs/20260613-054827-700501-ASTIS-SALD-001-cycle207`

This is the ABEIS-style compact retrieval packet for ASTIS.  Upper and middle
should read this before replaying long logs.

## Plain-Language Status

The current SALD state is not missing the VA-SALD idea.  The remaining work is mainly background analysis that papers cite as standard but Lean must instantiate for the exact law, conditional representative, measurability/integrability assumptions, domination argument, boundary condition, and KL/FI/LSI or Fokker--Planck statement in use.

## Active Proof-DAG Leaves

- No reviewer blocker recorded yet; use source index and proof-obligation ledger.
- No reviewer blocker recorded yet; use source index and proof-obligation ledger.

## Open Obligation Signals

- No reviewer blocker recorded yet; use source index and proof-obligation ledger.

## Mathlib-Ready Leaf Discipline

- Decompose aggressively: one lower packet should target one small lemma.
- Specify the theorem together with local APIs, imports, hidden regularity
  contracts, and an intended proof route.
- Search Mathlib and `AutoSamplingTheory/TechnicalLemmas` before inventing a
  local bridge.
- Treat repeated failure as a mathematical signal: missing assumption, false
  statement, representative mismatch, API mismatch, or over-large target.
- Do not churn the theorem shape or proof route without reviewer diagnosis.
- Protocol: `docs/mathlib_ready_leaf_protocol.md`.
- Skill tree: `research-wiki/lemma-dags/SDE_Sampling_skill_tree.md`.
- Compressed Pro leaf targets:
  `research-wiki/lemma-dags/Pro_assimilated_leaf_targets.md`.

## Open SALD Contribution Obligations

_None._

## Open External Technical Lemma Obligations

| id | source | status | used by | next action |
| --- | --- | --- | --- | --- |
| SLT/GaussianPoincare/TaylorBound.lean | SLT/GaussianPoincare/TaylorBound.lean | port-candidate | selected scalar Taylor integral/remainder and bounded-Hessian leaves | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianPoincare/Limit.lean | SLT/GaussianPoincare/Limit.lean | future-port | Taylor remainder limits and Gaussian Poincare backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/DualityEntropy.lean | SLT/GaussianLSI/DualityEntropy.lean | future-port | DV/KL variational formula backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/TensorizedGLSI.lean | SLT/GaussianLSI/TensorizedGLSI.lean | future-port | product Gaussian LSI backend | Port to ASTIS-owned TechnicalLemmas before using. |

## Recent Typed Verifier Feedback

_None._

## Next Lower-Agent Split

| role | goal | artifact |
| --- | --- | --- |
| lower-1-natural-language-proof-scout | Translate the active SALD source-line leaf into a dependency DAG with exact technical lemma needs. | proof-attempts/<task>/...-natural-language-dag.md or a dialogue handoff. |
| lower-2-lean-implementation-worker | Close one compiled Lean theorem or strictly narrow one source-cited Sampling/SDE boundary. | Lean declaration plus typed verifier feedback fields. |
