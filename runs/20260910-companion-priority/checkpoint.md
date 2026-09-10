# Companion-paper first proof checkpoint

The current app Goal prioritizes arXiv:2609.06905v1 and 2609.06906v1. It is
active; this checkpoint is not a completion of either paper or the older route.
The repository remains on `main`, based on
`4fec6664ccbb0c338b81febe48c02e76486f0da4`. Original cycle/frontier memory and
the prior contributor-graph protocol changes have been preserved.

- SPHMC: `RecursiveCondition.contraction_bounds`, the strict-domain scalar
  component of Lemma 6.6(i), has focused and independent compilation plus an
  accepted independent semantic round trip. The old closed-domain attempt is
  retained as revision history, not erased or presented as a source repair.
- PBPS: `GaussianReflection.reflection_preserves_augmentation` proves the
  involution and full joint pushforward-law equality. Focused compilation,
  independent direct elaboration and source review passed. Its broader
  probability/scale domain and still-open density identification are explicit.
- Both modules are imported publicly and both tests are in `Tests.lean`.
- `website/scripts/lean_gate.py` passed the aggregate ASTIS gate: root build
  8,945 jobs; Tests 9,056 jobs; ATLAS memory and fake-closure checks passed.
  The source-bound gate digest is
  `60601bd7d7ef6aefcc52b0ac7f105fd1e4d5079be10572e55d53c30bfdf509ca`.
- The semantic registry validates six audits; publication validation checks
  three source items; 44 focused Python regression tests passed. Frontier
  validation reports 14 cells. Python syntax and Git whitespace checks passed.

At this checkpoint the new proof files are still working-tree changes, so the
two SAUs and cells remain `PROVED_LOCAL`/`proved_locally` despite independent
hash-bound proof checks. Do not invent a verified commit. Registry remains 396;
these two new declarations are not silently counted as Registry admissions.
Website generation/visual QA and commit-bound stabilization are tracked by
their actual later results, not claimed by this file in advance.

Next mathematics: SPHMC Lemma 6.4 RGO closure, retaining normalization and the
infinite-variance case via nonnegative precision; PBPS density-to-generative
identification before operator/process uses. See the two conversion windows.
Main theorems, actual algorithms, error budgets and expected query-cost bounds
remain open. Graph/citation/download feature expansion stays secondary.

## Reader integration follow-up

The first full site build exposed a real generation-order error: publication
projection tried to attach the new proof lessons before companion pages
existed. `build_site.py` now creates those pages first, and a structural
regression test protects that order. The ensuing 45 focused Python tests and
full site build/check passed: 12 Chewi chapters, 396 Registry leaves,
526 modules, 3,625 declarations and 77 reviewed teaching declarations.

Actual browser inspection confirmed rendered PBPS formulas in the page's
accessibility tree and opened the adjacent Lean-statement disclosure; its
screenshot showed readable hypotheses, explanation and highlighted code.
The next browser action was blocked by the browser approval service reporting
a usage limit. The remaining PBPS proof-disclosure, SPHMC visual and new-node
graph inspections are not claimed as completed. No alternate UI automation
was used to bypass that rejection. The foreground localhost preview was
stopped after capturing the successful site-check result.

Commit-bound verification, Registry admission, push/deployment and deferred
product features remain outstanding. The next mathematical packet can proceed
independently of those browser inspections; no overall Goal status changed.

## Second mathematical batch (2026-09-10)

Three additional declarations compiled locally and passed independent direct
Lean checks, with the original source-review artifacts retained:

- `RGOClosure.quadratic_tilt_tilt`: equality of normalized measures under two
  quadratic tilts, including zero initial precision. The proof establishes
  integrability and positive normalizers rather than assuming the desired law.
- `IsotropicGaussianDensity.map_sqrt_smul_stdGaussian_eq_withDensity`:
  the scaled standard Gaussian has its explicit density relative to canonical
  volume in every finite dimension, including dimension zero.
- `GaussianAugmentation.augmentation_eq_withDensity`: the joint augmentation
  density relative to `mu.prod volume`, allowing singular input laws. Replacing
  `mu` with the paper's Gibbs density is a separate obligation.

All five new public modules and focused tests are in the aggregate roots. The
aggregate gate completed successfully: `lake build`, `lake build Tests`
(9,062 jobs), the ATLAS memory check and ASTIS fake-closure checks. Its recorded
source digest is
`0a990efa20e8daa05f7dd975b1586b47577b0c5f31f052d8f6b75a97d8aa0cd5`.
This is evidence for that source snapshot, not for later unbuilt changes.

Reader integration found and repaired two engineering issues: the publication
tests now select their historical fixture by identity rather than catalog
order, and lesson dependency links must be exact declaration identifiers rather
than identifiers followed by explanatory prose. The validator and regression
tests enforce the latter. All 36 publication/underlying-graph unit tests pass.
The two changed lessons require fresh hash-bound source-review packets even
though their Lean, mathematical statements and anonymous reconstructions are
unchanged; their original reviewer artifacts remain available.

Both v2 source reviews are now accepted (`equivalent-after-elaboration`, no
blocking deltas), and the five frozen declarations pass the strict per-advance
publication check. Another 35 proof-reader/metadata-reader tests pass. The
release-wide diff check correctly detects the next unfinished integrability
packet and cannot pass until that packet is published and reviewed. A new
density import was moved from the declaration-bearing compatibility module
`Measure.lean` to the declaration-free `TechnicalLemmas.lean` root; the old
compatibility theorem is unchanged and no admission gate was weakened.

The five cells/SAUs remain locally proved, not commit-verified or admitted to
the Registry. The Registry count remains 396. No paper main theorem, process
invariance, curvature update, convergence rate or query complexity is claimed.
The next shared mathematical prerequisite is Gibbs integrability without a
supplied minimizer. The paper's Hessian-to-strong-convexity bridge remains
explicitly distinct. The prior Chewi representative/score-Fisher frontier and
cycle history remain intact.

## Shared normalization advance

The next prerequisite is now compiled as
`StrongConvexGibbsIntegrability.integrable_exp_neg_of_strongConvexOn`.
Module SHA256:
`6497a5901e6fa898524821007f053d8c7396cd4d72d12ee647379d8bfa3dacf1`;
focused-test SHA256:
`ea1c94fac4d7f5a5c459116978ec03ab6d06612faa4eacdc6f83d873ac2a0403`.
Focused build passed (2,801 jobs) and independent focused/direct module and
test elaborations passed, with only the three standard Lean axioms. The tests
derive a positive normalizer, a Gibbs probability and a genuine RGO closure
consumer. The official SAU is `PROVED_LOCAL`, not commit-verified. An anonymous
reconstruction is complete; the fresh source review is pending at this entry.
The new module/test imports are integrated; the subsequent aggregate gate is
running. All 84 focused publication, graph, proof-reader, metadata-reader and
semantic-roundtrip regression tests passed, as did Python syntax and Git
whitespace checks. The Registry remains 396; none of the six paper-priority
declarations has been silently Registry-admitted.

Read-only next-edge audit (publication_gate_review): no existing multivariate
Hessian-to-strong-convexity adapter was found in the searched ASTIS/Mathlib
surfaces. Proposed, not yet elaborated, target: `ContDiff R 2 V` and
`alpha * norm(v)^2 <= (fderiv R (fderiv R V) x v) v` for every `x,v` imply
`StrongConvexOn univ alpha V`. Restrict to `x+t*(y-x)`, subtract the scalar
quadratic, apply Mathlib's scalar second-derivative convexity criterion, and
rearrange the endpoint inequality. Genuine C2 regularity is indispensable;
an inequality on totalized second derivatives alone is not this theorem.
Finite dimension, inner product, upper Hessian bound and positivity of alpha
are not needed for that proposed analytic implication. This is a reviewed
route suggestion, not a compiled statement, new SAU or closed paper boundary.

The normalization source review is now accepted, with seven slots, four
informational deltas and no blocking delta. Its independent raw artifact is
`normalization.source-review-result.json` (SHA256
`6caa91069b710826108f97d68b85f570c262f017e48efde35070fb9ac149accf`).
All six new declarations pass the release-wide publication check against the
baseline commit. The new aggregate Lean/Tests/ASTIS gate passed (9,064 Tests
jobs), with source digest
`26b82e24c088bd6975ca94c488aa4df74d7815e6eaa248a90bcfa63171fb47a4`.
The website rebuild is underway; this line does not certify visual QA,
commit verification, Registry admission or deployment.

The first six-result website check passed the base inventory/link checks but
rejected a stale contribution-graph digest: the final cell review evidence was
written after the build had read its input snapshot. Freeze the metadata and
rerun the official build/check. No validator was weakened and no stale graph
was accepted. This timing failure does not alter the successful Lean or
source-fidelity checks.

With metadata frozen, the official website build and complete site check now
pass: 12 chapters, 534 modules, 3,634 declarations, 77 curated reviewed teaching
declarations, and 396 Registry leaves. All six result cells pass their bounded
contribution-graph coverage checks. This is structural/freshness validation;
it does not substitute for the browser/visual checks whose earlier approval
limit remains recorded above. Commit-bound verification, Registry admission
and deployment are still separate outstanding steps.

## Commit authority checkpoint

The attempted combined stage/commit operation was rejected by automatic safety
review before execution: committing the broadly staged changes directly to
`main` could include the pre-existing contributor-graph/protocol batch outside
the narrowly selected paper work. No commit, push or ref change was performed,
and no alternate Git/API route was used to bypass the rejection. The user must
confirm whether that accompanying batch is to be committed with the six proofs,
or choose a narrower commit scope. Preserve all current staged and unstaged
changes meanwhile. This is a stabilization-authority boundary, not a Lean,
mathematical or source-fidelity failure. The active overall Goal is not marked
complete or replaced, and the reviewed next Hessian adapter remains the next
mathematical frontier. All bounded proof/reviewer tasks have completed.

## Goal continuation after commit rejection

The previous goal turn made mathematical and validation progress: six local
source-reviewed results, aggregate Lean/Tests/ASTIS PASS, 84 regression tests,
and a fresh website/graph-coverage PASS. It was not a no-progress turn. The
unchanged `main` commit and six `PROVED_LOCAL` SAUs were rechecked on resumption.
No submission approval has been received, so no Git staging/commit/push retry
or alternate publication route is authorized by this continuation. Mathematical
work remains available and the overall Goal remains active: one writer now
owns the missing Hessian-to-strong-convexity implication; a bounded read-only
scout audits the subsequent PBPS source-density consumer. The prior six proof
packets, staged contributor work and Chewi frontier remain preserved.

## Seventh local result: genuine Hessian bound to strong convexity

`ASTIS-SA-20260910-HessianStrongConvexity` is officially PROVED_LOCAL.
The single new theorem is
`Analysis.HessianStrongConvexity.strongConvexOn_univ_of_fderiv2_lower`.
It preserves arbitrary real modulus and arbitrary real normed space, using
genuine C² derivative witnesses and a scalar compensated-line proof to obtain
the exact alpha/2 chord convention. Production focused PASS2113, consumer
Tests PASS2802; the independent verifier also focused-built and directly
elaborated both unchanged files. Only the standard three Lean axioms occur.
Tests derive Gibbs integrability, strictly positive normalizer, actual Gibbs
probability and RGO closure directly from positive source Hessian hypotheses;
zero modulus and dimension zero are separately checked.

Semantic audit `ASTIS-RT-20260910-HessianStrongConvexity` is accepted for the
supporting implication only. The source-blind decoder and independent source
reviewer agree; all seven slots are checked, with four informational deltas
and no blocking delta. Exact source/module/lesson/publication hashes and the
independent result are preserved in the audit and hessian.owner.json. The
source review artifact SHA256 is
`f2c37c86de56789717efab9667ff0866560b39ac89cfe515cf136a12e78fa10a`.
All 84 publication/graph-reader/semantic regression tests pass after this
integration. Aggregate and website gates will run after the next bounded
source-density packet freezes, avoiding duplicate unchanged full builds.

This continuation is mathematical progress, not a no-progress turn. Registry
remains 396; all seven new results have local proof/review evidence but no
verified-commit admission. No Git operation was retried after the scope
rejection. The next single writer owns PBPS's normalized joint Gibbs density,
including explicit positive normalizer and probability certification so that
the density formula cannot succeed through a zero totalized measure.

## Eighth local result and eight-result integration gate

`ASTIS-ADV-20260910-PBPSGibbsAugmentation` is PROVED_LOCAL. The single
`ProximalBPS.GibbsAugmentation.normalized_augmentation_density` certificate
proves positive Gibbs integral, probability of the generative joint law and
its exact product-volume density from C², positive genuine lower Hessian
curvature and eta>0. Focused PASS3134 and independent direct elaboration of
both files preserve module SHA256
`093c6d7805a176198cc3178c493910005cece7ae1155ac7d1e1f67aa4d9401c8`
and test SHA256
`6767cd921df603c71133f47c3280674642b1409733c0014b3f88a4b387eecf3d`.
Tests consume all three conclusions for the explicit source-density
probability/reflection result and exercise the full zero-dimensional case.

The four-step lesson distinguishes ASTIS analytic/Gaussian parents from
Mathlib normalization and product-density contracts. Before source review,
one prose-valued Mathlib dependency was replaced by exact declaration IDs,
and the product-integration explanation was made explicit; no Lean change.
The final full publication binding is
`8958de0388cfee2eccb21adc2c2c03711fe76293941d611aaa060eddfde26321`.
Independent source-blind reconstruction and source review accept
`ASTIS-RT-20260910-PBPSGibbsAugmentation` as equivalent-after-elaboration
for the normalized-law edge only: seven slots, four informational deltas,
no blocking mismatch or repair. Review artifact SHA256 is
`33155d0c62e58e9dfa72b89da71bd1649265811e7706764bd5d19c6891c75773`.

One official admission attempt correctly rejected the coordinator's invalid
audit-state spelling `reconstructed`. It was corrected to the schema's
`blind-reconstructed`, the semantic checker passed, and the official retry
admitted PROVED_LOCAL. No theorem, assumption, decoder or source-review input
changed; this was bookkeeping, not a mathematical blocker. The final audit
is accepted. No VERIFIED/commit-bound assertion is made.

Final aggregate gate PASS: lake build, lake build Tests (9068 jobs), ASTIS,
ATLAS memory, Python syntax and git diff --check. Source-bound evidence:
`50e6db37bade4e7e0184d68716aa47aef42ed3083bb318520d12136a469f989b`,
generated at `2026-09-10T05:21:24.336455+00:00`. Existing unrelated linter
warnings were replayed; the two new focused modules have no remaining warning.
The 84 publication/graph-reader/semantic regressions passed in this
continuation; the final semantic registry and publication gates pass with
12 audits, one preserved repair proposal, nine source items and 20 cells.

After freezing cell metadata, the official site build and complete site check
pass on the eight-result snapshot: 12 chapters, 538 modules, 3,636 declarations
and 396 Registry leaves. The checker's reviewed-teaching counter reports 77;
it must not be relabelled as a count of every new byte-bound local lesson.
All eight bounded contribution-graph coverage checks pass. Their reports
explicitly state that reference scans are incomplete and structural coverage
is not visual QA or a proof certificate. Earlier browser/visual-inspection
limits remain unresolved; no new visual pass or deployment is claimed.

All bounded writer/scout/decoder/reviewer tasks have finished. The overall
Goal remains active, with no background ASTIS session or new parallel Goal.
No staging/commit/push operation was retried: main remains
`4fec6664ccbb0c338b81febe48c02e76486f0da4`. Registry admission and deployment
await the user's commit-scope decision. The original Chewi frontier and
pre-existing staged contributor changes are preserved.

Next mathematics: the read-only audited RGO quadratic curvature plus genuine
gradient-Lipschitz packet in the companion proof-obligations document. Use
local Hessian-shift and Rayleigh-quotient norm arguments within one substantive
theorem, then connect its actual constants to source recursion. This successor
is proposed, not yet elaborated or proved. Do not redo the eight accepted
local results or interpret their success as either complete sampling theorem.

## Ninth packet in progress: actual quadratic regularization

The next continuation preserves main at
`4fec6664ccbb0c338b81febe48c02e76486f0da4`, all eight accepted local packets,
Registry 396 and the original Chewi frontier. The automatic continuation is
not approval of the outstanding combined-commit scope question. No Git write,
parallel Goal or background ASTIS session is attempted.

The sole writer registered and claimed
`ASTIS-SA-20260910-QuadraticRegularization` and
`ASTIS-SHARED-quadratic-regularization` before proof edits. The frozen target
is one substantive conjunction: adding `r*norm(x-u)^2/2` to a genuinely C²
potential with nonnegative diagonal Hessian bounds m,L gives strong-convexity
constant m+r and actual-gradient Lipschitz constant L+r on a complete real
inner-product space. Zero precision is allowed. Hessian shift, Riesz
representation, symmetry and the Rayleigh norm formula are local proof steps,
not new public wrappers or supplied operator-norm assumptions.

The direct source binding is SPHMC v1 Lemma 6.4's curvature/smoothness clause.
PBPS v1 (2.9)-(2.10) supplies a shared analytic consumer, but the selected
public conclusion is not the full Hessian-sandwich statement or Proposition
2.1. Conditional-law identification, Poincare, covariance, process invariance,
error and query costs remain separate. A bounded read-only audit examines the
subsequent probability-law/TV handoff; it owns no second theorem implementation.
The companion next-packet queue removes the already accepted normalized-law
edge and records this analytic priority. No ninth local result is claimed yet.

Audit bookkeeping correction: the coordinator initially reused the historical
filename `anonymous-quadratic.decoder.json` for the new gradient proposition.
The decoder detected that the filename previously described another anonymous
theorem and refused to reuse its old reconstruction. No source identity leaked.
The attempted overwrite-restoration was rejected by the safety gate before
execution. New evidence now uses the distinct `anonymous-gradient.decoder.json`.
The unchanged canonical RGO audit regenerated the historical input into the
separate `anonymous-quadratic.decoder.recovered.json`; its raw SHA256 is
`b3a57fea227b0faa8ac9becdb57659e7f0238050ccc1d2c000d016afbeeef97b`,
exactly the original hash retained in the historical decoder result. All old
proofs, decoder results and source-review results are unchanged. No fidelity
credit is transferred between these different propositions.
Read-only hashes then proved the accidental current bytes were identically
preserved in `anonymous-gradient.decoder.json`, and the recovered historical
bytes matched the earlier certificate. The same official exporter was
re-requested with these lossless-restoration checks and approved. The historical
input path is restored to its original raw SHA256 above; both separate copies
remain available. This was a recovered filename collision, not a proof change
or an accepted mismatch, and not a retry of the unrelated rejected Git action.

## Ninth accepted local result and publication authorization

`ASTIS-SA-20260910-QuadraticRegularization` is now PROVED_LOCAL; the canonical
semantic audit is accepted. The module and tests retain hashes
`516ac170f482f2e038f79292a2e5dc3ab3138ea9a574e08e088bf59cfba48303` and
`b4428f3e58b2c31cc1a33dbc011c5378a48617326b4a00b27b3dcb07525cd1e8`.
Focused PASS2943 and independent direct elaboration cover exact source
constants, zero precision, zero dimension, positive Gibbs mass and actual RGO
composition. The five-step lesson and publication are frozen at
`295dc4f698b2798d29f7a6d9ce55c43952dc80932b2acbb71d24a87187a7e783` and
`571b1f1fc860e03335aab10026f1987551c3411096622640627c2a7022c3f166`.
Full publication binding is
`81cc82aa40c055f5f0df1aaa557336947a7a60fa0e9636e38d6d94773599148d`.
Independent source review records seven slots, three informational deltas and
no repairs, with artifact SHA256
`68ae1a46c473789f5cd4259a039e2f08db9d34c167bcee345d05102de0a0a4c2`.
The nine-result publication gate passes (ten source items); whole-paper claims
remain open. The next queue selects actual Markov-kernel TV contraction.

One continuation was blocked by the automatic approval service and writer's
usage-limit errors. Read-only reconciliation preserved the exact draft audit
and frozen files. A later usage query showed 1% consumed, and the original
write/check operations succeeded under unchanged permissions. The user then
explicitly confirmed the reset, stated that no spare resets remain, and
authorized pushing main and deploying the website. No reset credit was used
by the harness. Do not infer another reset authorization. This latest explicit
publication request supersedes the earlier unanswered push-scope question;
only reviewed, in-scope project/protocol/reader changes may be committed.
Safe fetch confirms local HEAD and origin/main coincide at 4fec6664; no
working-tree or collaborator update was overwritten. Batch verification and
publication now follow before the next implementation, avoiding repeated
full builds for individual prose edits.

## Nine-result publication batch

The proof-containing commit is `38e1ef64e5851b8ecab7b6a3d2771a55ab5db40e`.
Independent verifier `rgo_independent_verifier` checked its nine frozen
module/test pairs, lesson/source/statement hashes, source-review packets,
review artifacts and complete publication bindings: 9/9 match. The attestation
is `nine-results.commit-verification.json`; it explicitly distinguishes the
earlier working-tree aggregate gate from the later committed tree and records
the CRLF/LF-only bridge. Root transcribed that independent attestation, without
reassigning the original reviewers, through the official SAU transition API.
All nine SAUs are VERIFIED and their cells are independently_verified.
They are not marked as whole-paper closure or merged cells.

The unchanged compiled technical Registry is 396. The nine new declarations
are separately inventoried, imported and tested; this release does not invent
Registry entries to increase a counter. The aggregate Lean/Tests gate passed
9070 jobs, ASTIS and ATLAS checks. Publication check passes ten source items;
Frontier Cell check passes 21 cells and semantic registry check passes 13
audits with one preserved repair proposal.

Release regression checks caught two stale expectations: nine News entries
instead of the agreed eight, and MCMC's old solid-edge whitelist. News now
keeps the latest companion result and removes its superseded planning entry;
the MCMC test now requires only imports/declares as solid structural evidence,
explicitly excluding scanned/curated theorem edges. The browser suite now
checks every companion binding for rendered mathematics and adjacent folded
statement/proof Lean, including mobile overflow and disclosure interaction.
An optional installed-browser channel supports Windows without a large browser
download; CI retains its pinned Chromium default. Local test dependencies live
only under the ignored `.astis/site-browser/` directory. The slow optional
Chromium installer was stopped; no ASTIS background session was created.

Final site build, graph projection, visual inspection and online deployment
are performed after this metadata commit. Their actual outcomes will be
reported in the current thread; none is inferred from this checkpoint.

## Published release and tenth proof edge

The nine-result release actually reached GitHub main and public Pages at
f0b50de65ecea87c359294ed25d8ecd9a305d114; deployment/run evidence is recorded in
publication-release.md. The optional private mirror upload failed independently.

The next shared MarkovKernelTVContraction packet is now locally compiled and
independently proof/source reviewed. The exact factor-one eventwise theorem
uses actual measurable probability kernels, explicit input/layer integrability
and layercake on (0,1]. Frozen file hashes and reviewers live in its Frontier
Cell and semantic audit; commit-bound admission is separate. Full Lean/Tests
PASS9072, ASTIS/ATLAS and 61 focused protocol tests pass. Registry remains396.
No old Chewi frontier or cycle memory was reset. The next-rgo-packet.md records
the next actual conditional-kernel interface, without claiming it compiled.

## Eleventh proof edge: actual Gaussian backward conditional kernel

The preceding release is pushed and deployed; the remote formalization gate
also completed successfully (publication-release.md). The new theorem
GaussianConditionalKernel.exists_tilted_isCondKernel constructs an everywhere
normalized measurable Markov kernel and proves actual swapped-joint
disintegration. Probability of an arbitrary, possibly singular input and η>0
suffice; normalizers and measurability are proved internally. A focused consumer
recovers μ from the actual smoothed marginal. This is not process invariance.

Production/test hashes and the accepted 15th semantic audit are recorded in
the cell. Independent mathematical review: rgo_independent_verifier; anonymous
decoder: heatbath_exposition_research; source review: publication_gate_review.
Full build8954, Tests9074, ASTIS/ATLAS, publication12, frontier23, py_compile,
diff whitespace and 61 protocol regressions pass. Registry remains396; the
eleven companion/shared declarations have their separate tested inventory.

Compilation diagnosed implicit prodComm parameters, lambda/uncurry matching
and swapped-projection reduction; no statement change or added assumption.
The frontier check required the Samplinglib name in reuse evidence. README
identifies that name with ASTIS; the actual original ConditionalKernel module,
Probability import surface and base Probability declarations were read and
their paths recorded. No separate nonexistent Samplinglib checkout was claimed.

Commit verification, affected reader/graph inspection and eleventh publication
remain pending here until their actual outcomes are recorded. The next planned
source integration is SPHMC Lemma6.4: combine the existing genuine quadratic
curvature and normalized-law parents with positive Gibbs normalization and the
exact condition-number identity. Preserve A=infinity through zero precision.
Neither full companion paper, its actual algorithm, mixing nor actual-input
query complexity is complete. The same Goal and older Chewi frontier remain.

## Twelfth result: source-level RGO calculus

Proof commit8ef889b89ae1b23e19d41acf25c115cfbef5e30a contains the single
RGOCalculus.rgo_calculus integration theorem and focused consumer tests.
It joins existing curvature, Gibbs-integrability and normalized-tilt parents
to prove SPHMC Lemma6.4, including (6.1), with explicit positive normalization
and probability of both source laws. Zero precision preserves A=infinity.
Tests feed the actual updated curvature ratio into the previously compiled
ill-conditioned contraction, rather than repeating its scalar hypothesis.

Focused PASS2945 (Lean4.33.0, two threads), standard axioms only, no warnings;
publication PASS13, semantic PASS16 audits/1 preserved repair, frontier PASS24.
Independent code review by rgo_independent_verifier; source-blind reconstruction
by heatbath_exposition_research; accepted anti-anchored source audit by
publication_gate_review. The latter disclosed prior authorship of a reused
parent, not this integration theorem. A lesson wording error in the final
field calculation was corrected before the source-review binding.

Exact code/statement/source bindings and commit admission live in the existing
cell/audit records, not in an inferred chapter badge. Aggregate build,
reader/graph inspection and online publication results are recorded in
publication-release.md only after execution. Registry remains396; this is the
twelfth separately inventoried companion/shared result, not paper completion.

Next dependency-ready candidate: Lemma6.6(ii)'s well-conditioned variance
contraction; inspect source before freezing it. Stage termination, actual
recursive algorithms, accuracy, mixing and actual-input expected query costs
remain red. No reset credit, replacement Goal or detached session was used.

## Thirteenth result: selected well-conditioned RGO parameter step

RecursiveVariance.variance_update_bounds and its consumer tests pass2945 on
Lean4.33.0 with two threads and standard axioms only. The result proves finite
positive updated variance, the 2c bound and exact guarded contraction; its
zero-precision case is retained and its real normalized Gibbs consumer is tested.
Registry remains396, separate from thirteen companion/shared declarations.

Independent proof and commit admission: rgo_independent_verifier at
51b3b91334b9d73e4741d1b8847a7576846edc3d. Independent anonymous decoder:
heatbath_exposition_research. Source reviewer: publication_gate_review, whose
signed amendment retains domain-mismatch/stronger-in-lean because c<1/4 is
unnecessary for this scalar proof. This is an accepted source specialization
with a disclosed valid generalization, not unrestricted equivalence. The raw
review and amendment are preserved; no schema or mathematical premise changed.

The four-step reader proof is authored once, with adjacent folded Lean and
an explicit parameter-not-covariance warning. Publication PASS14 and semantic
PASS17/1 preserved repair preceded admission. Final aggregate, graph/reader
inspection and deployment outcomes will be recorded in publication-release.md
after execution, not inferred from the focused test.

Next: source-update branch persistence and the finite-depth threshold, with
algorithm schedule and stage indices retained. Recursive sampler construction,
error, terminal FORS work, mixing and actual-input expected query costs remain
independent red obligations. The same full two-paper Goal stays active.
