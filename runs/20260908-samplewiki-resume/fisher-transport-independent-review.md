# Canonical Fisher transport pairing: independent proof review

Date: 2026-09-08. Reviewer: `fisher_pairing_statement_review` (independent of the proving Worker).

## Verdict and scope

**PROOF GATE PASS for the two frozen analytic declarations and their conditional integration test. Source-specific certification is WITHHELD after the independent `domain-mismatch` / `needs-revision` source review. The advance remains `PROVED_LOCAL` and the cell remains `proved_locally`; this report does not publish `VERIFIED`, assimilation, or Chewi Theorem 8.4.1 completion.**

Reviewed commit: `74243f263bf4ed5fd632f4f3a0950b58ed77b4d7`.

- `AutoSamplingTheory/TechnicalLemmas/InformationTheory/CanonicalFisherTransportPairing.lean`: SHA256 `df036c56eaea8f427d1947736cc76522000502d6ee6d9ca43c5cef020f7116b0`.
- `Tests/CanonicalFisherTransportPairing.lean`: SHA256 `98d1677aac36484690c19598eaef7660ac33f0be531457d2621025cb836483ed`.

HEAD and both hashes were checked independently before and after elaboration. The frozen commit changes exactly these two Lean files; neither was edited during review. The compact Worker packet was read once after it became available. Existing unrelated working-tree changes were preserved.

## Independent Lean evidence

Every Lean invocation explicitly used `ELAN_TOOLCHAIN=leanprover/lean4:v4.33.0` and `LEAN_NUM_THREADS=1`.

1. `lake env lean AutoSamplingTheory/TechnicalLemmas/InformationTheory/CanonicalFisherTransportPairing.lean`: PASS, exit 0, no diagnostics.
2. `lake env lean Tests/CanonicalFisherTransportPairing.lean`: PASS, exit 0. Both exact public signatures printed, with no probability or sigma-finiteness premises.
3. Fresh producer elaboration with `lean -o` into ignored `.astis/fisher-transport-review/lib/.../CanonicalFisherTransportPairing.olean`: PASS. The existing local dependency namespace was copied into that ignored search root, then only the reviewed module was replaced with freshly elaborated bytes. With this root prepended to `LEAN_PATH`, the submitted test file again elaborated successfully. This avoids relying on the Worker's cached producer artifact for the integration check.
4. Independent ignored `EdgeCases.lean`, importing the freshly elaborated producer: PASS. Four named checks establish genuine score differentiability at gamma-a.e. first coordinate, finite W2 from the optimal coupling and two moments without a score/probability/SFinite premise, vanishing pairing at zero Fisher information, and vanishing pairing at zero Wasserstein distance.

Both public declarations and all four final scratch declarations depend only on `propext`, `Classical.choice`, and `Quot.sound`. There is no `sorryAx` in the final checks.

Review-harness diagnostics, not producer failures: the first fresh import root hid sibling namespace modules until the dependency namespace was mirrored; the first edge-test draft had a newline dot-notation parse issue and an incorrect convenience-lemma name. Only ignored review files were corrected. The frozen producer and submitted tests required no changes.

Reproduction scripts and scratch tests are under `.astis/fisher-transport-review/`. No root build, graph regeneration, source audit, or protocol status publication was performed by this proof reviewer.

## Mathematical inspection

- **Integrability is produced.** Measurability of the total gradient is composed with the first projection; squared-score integrability is transferred using the actual coupling marginal. The two marginal moments produce displacement L2. Holder yields integrability of the product of norms, and `norm_inner_le_norm` supplies integrability of the actual inner-product pairing. No pairing-integrability or Cauchy-Schwarz conclusion is assumed.
- **The domain guard is genuine but bounded.** The existing `SmoothFiniteScoreDomain` contains absolute continuity, a.e. differentiability of the chosen RN log-ratio, and integrability of its squared gradient. Its a.e. differentiability transfers through the first marginal, as independently elaborated. The estimate itself only needs the L2 field and measurable total gradient; this does not establish RN-representative invariance, weak/Sobolev gradient identification, or that textbook smooth densities imply this chosen-representative domain.
- **The Fisher factor is the existing definition.** The first marginal and `integral_map` identify gamma's score-energy integral with `CanonicalRelativeFisher.information`; no duplicate Fisher hierarchy or arbitrary replacement score is introduced. `MeasurePreserving.integral_comp` is correctly avoided because the projection need not be an embedding.
- **The transport factor is not an infinity-to-zero artifact.** Optimality is an actual coupling/cost-attainment witness. The two moments give integrable squared displacement, and the existing ENNReal optimal-cost identity equates `ofReal` of this finite integral to W2 squared. Consequently W2 cannot be infinity, checked both in the submitted test and independently. The producer's real-cost identity and `ENNReal.toReal_pow` are therefore legitimate; the square-root rewrite also handles zero without division or strict-positivity assumptions.
- **Orientation and measure assumptions are sound.** The pairing uses `y - x`; the quadratic cost's `x - y` is reconciled by `norm_sub_rev`. Arbitrary-mass couplings cause no missing probability or SFinite obligation in this L2 argument. Probability normalization remains a separate source-level interpretation.

## Actual consumer and remaining boundary

The submitted geodesic example uses the actual gamma integral as its derivative value, the canonical Fisher definition, the actual Wasserstein value through an explicit metric adapter, and the actual functional `InformationTheory.klDiv(...).toReal`. It derives

`-pairing <= abs(pairing) <= sqrt(Fisher) * W2`

from the new producer and passes this result to `GeodesicFisherTransport.sq_le_fisher_mul_dist_sq_of_geodesic_first_order`. There is no assumed `hcs` or equivalent inequality among the consumer inputs. `SigmaFinite pi` occurs only in this test, for `klDiv_self`.

This is a **conditional test of actual `klDiv.toReal`, not a theorem establishing a finite-real-KL domain**. It leaves the selected geodesic, convexity, law/path representation, metric identification, and a two-sided `HasDerivAt` of that totalized KL path explicit. In particular, it supplies neither entropy finiteness nor the source's endpoint/one-sided first variation. A potentially infinite KL value is not shown finite merely by using its `toReal`. These limitations do not invalidate the analytic producer, whose conclusion contains no KL, but must remain explicit in source correspondence and any downstream completion claim.

## Fake-closure and admission boundary

Direct inspection and scoped token scan found no new `axiom`, `sorry`, `admit`, `unsafe`, external implementation, `Prop := True`, trivial closure, custom elaboration shortcut, or kernel-check disabling option in the two frozen files. The only matching `axioms` text is the expected diagnostic commands. The committed two-file diff passes `git diff --check`.

The result is a substantive shared analytic producer: existing scalar Fisher/geodesic modules accepted the missing bound; this module derives it from canonical score, marginal, and cost inputs and is consumed by a real integration example. The independent source gate did not certify the source-specific statement, so final admission is withheld notwithstanding the proof pass. Do not promote this report into whole-source equivalence, an optimal-map existence result, a first-variation producer, or the full Theorem 8.4.1.

## Final source-gate disposition

Read the compact independent result `runs/20260908-samplewiki-resume/fisher-transport.source-review-result.json` and verified its immutable SHA256 `d32e17f0b765cbfe12c3c3155c2c11ab3acb3c18aa05864a973bd8d812a0a1ae`. Its verdict is `domain-mismatch`, with `review_state=needs-revision`. This proof reviewer does not replace that verdict or act as its source reviewer.

The source result explicitly accepts the mathematical rationale for the supplementary coupling Cauchy-Schwarz generalization and alleges no Lean error. It withholds source certification because the actual statement concerns arbitrary-mass measures, a separate destination `nu`, and a library-selected RN score with its own finite-energy domain. Certification of the source calculation would additionally need the source probability/P2 laws, `nu = pi`, the optimal graph-coupling and expectation identification, and a bridge from the selected RN gradient/information to the source score/Fisher information. The finite-energy scope does not establish coverage of infinite Fisher-information cases.

Accordingly, the independent **proof pass is retained**, but the durable advance stays `PROVED_LOCAL`, the cell stays `proved_locally`, and no `VERIFIED`, independently-verified cell status, assimilation, or source repair is accepted. The raw source review is unchanged. No unchanged Lean check was rerun for this metadata-only disposition.

Outstanding route priorities are recorded for coordination, not as a new theorem assignment or acceptance of the source review's proposed repairs:

1. **Representative and score/Fisher adapter:** resolve the intended smooth heat-flow density-ratio representative against the chosen RN-log gradient and finite information. A.e. equality of representatives alone does not establish differentiability of the library-selected representative.
2. **Finite-entropy/domain adapter:** identify the actual source probability/P2 laws and justify finite entropy on the time/domain required for differentiating KL; preserve the declared finite-score-energy scope. The existing test of `klDiv.toReal` is not this domain proof.
3. **Endpoint first-variation adapter:** resolve the source's one-sided endpoint derivative against the existing consumer's two-sided `HasDerivAt`, using the actual KL displacement path and the genuine score pairing. Convexity and metric/law representation remain explicit until independently supplied.

The `nu = pi` graph-coupling specialization and pushforward-integral identity remain necessary source-certification connections; they must not be mistaken for, or used to bypass, those representative, entropy, and endpoint analytic obligations. No further theorem work or source repair is authorized by this report.
