# C1 convex smooth gradient interfaces

SAU `ANDI-OPT-cocoercivity-001`; base `e2307b21eed782c6a2718e8666ec3ce0bf6207cd`.
The user continued the optimisation lane. Companion execution/handoff was
checked; this shared textbook result is not companion-paper frontier progress.

Source: Chewi, arXiv:2605.07006v1, Exercise3.1 (3.4)–(3.5), using
Definition1.12 and Lemma3.1. Canonical module:
`AutoSamplingTheory/TechnicalLemmas/Analysis/ConvexSmoothGradient.lean`.

- `gradient_gap_sq_le_bregman`: positive beta; squared gradient difference
  bounded by `2 beta` times the ordered Bregman gap.
- `gradient_cocoercive`: nonnegative beta, including zero; division-free
  cocoercivity with coefficient beta.
- `gradient_lipschitz`: nonnegative beta encoded by NNReal; global beta-Lipschitz
  genuine gradient.

All require C1 convex f on the whole complete real inner-product space and the
actual quadratic upper model. Hilbert space is a disclosed source generalization.
The reciprocal source (3.4) has an implicit positive denominator domain; no
claim covers its undefined zero denominator. A positive relaxation and real
limit establish the scaled and Lipschitz zero cases without `inv_zero`.
No constrained-domain, Hessian, Riemannian, SALD or sampler theorem is asserted.

Reuse audit: Samplinglib StrongConvexFirstOrder supplies the actual first-order
support bound at modulus zero. SmoothnessEquivalences is composed in a focused
consumer. QuadraticRegularization only has a stronger C2 sandwich interface.
Pinned Mathlib db584cd6d46c92f209a44c0f1c829460d327499d had no exact interface
in the bounded search. Pinned Optlib5da27c5 Function/Lsmooth.lean
`convex_to_lower` and `lower_to_lipschitz` supply related mathematics under
positive modulus and a different quadratic-shift interface (Lean4.13,
Apache-2.0). No external Lean dependency is imported. Classification:
`adapt_existing`, with independent retrieval review by `smoothness_review`.

Proof route: use d=gradient f y-gradient f x and z=y-d/beta; combine convex
support at x with the upper model from y to z. This is the source tilted-function
descent algebra. Exchange endpoints, add, then pass positive relaxed beta+epsilon
to beta. Cauchy–Schwarz and cancellation of a positive gradient-difference norm
yield Lipschitz. The real right-neighborhood limit is nontrivial.

Conceptual-mirror audit: none-found. Existing gap-gradient and curvature-growth
families already retain the recurring convex-gradient mechanism. No new
cross-domain bridge or formal transport is inferred.

Independent `smoothness_review` checked frozen
`04ad482f3bf397c1d5fe40e8ced7772f4315f0b2`; focused build PASS2728, no warnings
or fake closures, standard axioms only. Four consumers cover reciprocal source
form, previous single-sided interface composition, zero-modulus gradient
constancy and nonexpansive gradient step. `coco_blind` reconstructed three
anonymous packets; independent `coco_source` accepted scoped source support:
implicit-assumption-exposed for (3.4), domain-mismatch for the Hilbert
cocoercivity/Lipschitz generalizations. No pinned-source repair was proposed.
Exact source, packets and result hashes live in the existing semantic registry.
Publication42items and semantic54audits validate. Root records the independent
recommendation with attribution; root is not the verifier.

Only the designated integration lane adds Analysis and Tests root imports,
three Registry entries (405→408), and the count check. Every new test must be
reachable from Tests.lean; a focused-only test is not CI coverage.
Reader lessons are authored once in convex-smooth-gradient.json; Exercise3.1
source binding is in optimisation.json.

Canonical full gate PASS9132 on cdcd99aba67cd59f1e299661237d9eeda22d44e6.
During checks remote main advanced to PR271/272/273. Synchronized merge
10df43c1704b81d9caaf4bb5d1101ba6adf090e6 preserves both parents' theorem,
test, lesson and publication bytes. Independent review recomputed the exact
registry three-way union (51 baseline +3 local +3 remote =57 audits) and ledger
base prefix plus exact unique local/upstream tails. Original timestamps and
branch-local events remain intact. Upstream owner StateDependentRGO MERGED
remains after the earlier reservation release. FiniteRGOKLError's stale
reservation was released through an independent historical-artifact preservation
audit plus fresh remote Git merge evidence, not a fabricated owner MERGED.

Final synchronized canonical gate PASS9138 on 10df43c at
2026-09-11T08:02:40.731398+00:00, including root Tests, fake-closure scan and
ATLAS36469declarations/26books. Synchronized harness PASS250tests with6skips;
publication45items, semantic57audits and66cells validate before the later
layout-only rebind. Inherited upstream FiniteRGOProgram EOF whitespace is
preserved to avoid invalidating its audit; the own diff against main is clean.

Actual desktop inspection prompted a layout-only change: place the upper model,
Bregman definition and conclusion on three rows. Independent smoothness_review
confirmed unchanged mathematical content and unchanged proof/test/publication
bytes; The later self-contained d definition gives final lesson hash
4d5345d17647f9a52d75d67154bbb1a24195c6086b7ffe3575ae56861eed6bff.
Unchanged anonymous decoding is reused; the new publication binding undergoes
a fresh anti-anchored source review. This does not require another Lean build.

Next bounded candidate: a source-pinned gradient-descent convergence edge using
these interfaces, after a fresh reuse/ownership audit. Nonexpansive gradient-step
algebra already exists in the focused test and must not be reproved blindly.

Final fresh `coco_layout_source` reviews accepted exact revised packets; the
local notation issue is retained in review evidence. Publication45items and
semantic57audits PASS on the final binding. Canonical website build/check PASS12chapters,408compiled local leaves,608modules,3686declarations; all3cell graph checks PASS. Actual desktop source/proof/Lean disclosure inspected; final cocoercivity graph10nodes15edges5direct relations, Bregman parent and Lipschitz consumer, solid structural vs dashed scanned/source/audit edges, compiled target and partial chapter. Mobile390x844 statement formulas and inspector legible; documentwidth390,0matherrors. No Riemannian/companion credit. Viewport reset; temporary tab/server closed.
Actual main integration is recorded only after the push succeeds.

Actual atomic push integrated main and task branch at
6065400403908cb58353accbe0fa7fedba1b80b6. SAU and three cells are now MERGED.
The final stabilized-status edit invalidated the local graph fingerprint; the
actual merged-status view is regenerated and checked before closeout. This is
a reader metadata refresh, not a change to compiled mathematics or a claim
that GitHub CI/deployment has already finished.

Merged-status regeneration completed: canonical site check PASS12chapters,
608modules,3686declarations,77reviewed teaching declarations. All three focused
graph checks PASS and their bounded reports exactly equal the versions already
visually inspected; mathematical lesson and proof bytes are unchanged. Thus
the actual desktop/mobile QA remains applicable. No graph/cell input is changed
after this final regenerated check.
