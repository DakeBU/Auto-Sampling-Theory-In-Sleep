# One-sided smoothness equivalences

SAU: ANDI-OPT-smoothness-001. Source: Chewi, arXiv:2605.07006v1,
Definition1.12 equation(1.7) and Proposition1.13, both equivalence clauses.
User explicitly continued this optimisation lane. Companion scheduling and
latest handoff were checked for reuse; their live sampler tasks remain separate.
Baseline4e94f0a includes PR265 without modifying its proof or audit artifacts.

Target: quadratic upper model iff one-sided gradient upper bound (C1), and
iff the genuine Hessian diagonal upper bound (C2). The shared declarations
allow complete real inner-product spaces and any real beta, explicitly
extending the source Euclidean/nonnegative-beta domain. No convexity premise
and no Lipschitz-gradient conclusion. The latter needs extra structure.

Reuse audit: Samplinglib ConvexityC1 signed gradient-to-chord integral,
StrongConvexFirstOrder first-order lower bound, and ConvexityC2 signed
Hessian equivalence are the actual parents. Apply them to -f with modulus
-beta. Their source specializations requiring nonnegative modulus cannot be
used this way. Existing QuadraticRegularization remains intact; its sandwich
assumptions are stronger than this task. Mathlib negation rules operate on
actual fderiv and the Riesz gradient, not arbitrary supplied derivative fields.

Independent read-only retrieval reviewer smoothness_review checked pinned
Mathlib db584cd6d46c92f209a44c0f1c829460d327499d, Optlib5da27c5 and
CvxLean c62c2f. Optlib Function/Lsmooth.lean upper bounds assume a genuinely
Lipschitz gradient; related equivalences require convexity and positive
constant. No matching CvxLean interface found in the inspected scope. No
upstream dependency or port was introduced; classification adapt_existing.

Source omits the proof by reference to Proposition1.6. Expansion: sum the two
upper models for the forward C1 implication; negate the gradient condition,
apply signed gradient-to-chord FTC, derive the first-order lower model, negate.
For C2 compose with the prior signed gradient/Hessian equivalence of -f.
Its positive-direction limit and Hessian FTC justify both implications.
C1/C2 supplies all segment regularity. No division by beta or direction norm.

Focused tests cover signed sharp quadratics, a beta=0 concave quadratic whose
gradient is not 0-Lipschitz, a genuine gradient-step descent estimate from the
Hessian upper bound, and the zero-dimensional constant-function instance.
Initial compile feedback concerned outer-function extensionality for the
second derivative of -f and simplification of a real quadratic derivative;
neither required a mathematical assumption or route change.

Conceptual-mirror audit: none-found. Negation is an elementary reuse adapter
inside the existing curvature/upper-lower calculus context, not a newly
certified cross-domain transport or a new mathematical mechanism. No conceptual
edge is promoted to a formal dependency. Current boundary: focused tests,
independent commit/source review, root test wiring, Registry and reader/graph
admission must all pass before integration.

Both production declarations and focused tests compiled (2727 jobs); standard
axioms only. Draft audit schema passes, while the real publication gate
correctly withholds admission until independent source review is completed.

Independent smoothness_review checked frozen5434944361508bbe8e41eba9135d071f17978532,
repeated focused PASS2727 with no warnings, and found no fake closures or
substantive issues. Anonymous smoothness_blind reconstruction and separate
anti-anchored smoothness_source reviews accepted both source clauses with
explicit domain-mismatch generalizations; no repairs. Publication38items and
semantic48audits passed. Root recorded attributed independent VERIFIED only
after those conditions. TwoNoise PR265 stale reservation was released on a
separate independent preservation audit and gh-confirmed merge, without
rewriting historical events or impersonating its owner's MERGED transition.

Root Analysis and Tests imports now reach the new module and focused tests.
Registry adds exactly two declarations, count403→405. The joint full gate and
reader/graph acceptance remain required on this integrated tree.

Canonical whole-project gate passed on e42cf9db4d4830cc31ea5e24a7477d26eef44155
at2026-09-11T04:40:45.532304+00:00:9124jobs including root Tests, fake-closure
scan and pinned ATLAS36469declarations/26books. Full harness passed250tests
with6optional/environment skips. Independent final integration review on the
same commit confirmed both root imports, exactly2Registry additions, unchanged
reviewed proof/test/lesson/publication bytes, all46upstream audits intact,
correct new packet/result hashes and publication38/semantic48 PASS.

Canonical website build/check passed:12chapters,405compiled local leaves,
594modules,3677declarations. Both cell graph checks passed. Desktop source
formulas and the C2 sign-reversal proof were visually inspected; focused graph
14nodes25edges5direct relations shows two actual named parents, solid module
structure versus dashed scanned references/source/audit links, compiled target
and partial chapter. Mobile390x844 reader/inspector are legible. Temporary
viewport, tab and server cleaned up. Source generalizations remain visible as
domain-mismatch; no exact-source/chapter badge is forced or hand-edited.
Ready for authorized direct-main integration. Next useful bounded target:
convex one-sided smoothness to gradient Lipschitz/cocoercivity; first audit the
precise source regularity and reuse Optlib/Mathlib/QuadraticRegularization.

The initial atomic push was rejected because main advanced to PR266
24d166c0160e0a8c43dc08f356e3eed7d4e36c60 (merged2026-09-11T04:40:36Z).
No ref was overwritten. Merge bbcb641e7127a2f3730fa370b18216e7a9d819ab
preserves both contributions. Audit conflicts resolved by exact id-based
three-way merge with no overlapping id edits; all49audits remain valid.
Ledger merge preserves exact base prefix, local unique tail, upstream unique
tail, removing only exact duplicates. Concurrent branch-local transitions keep
their original timestamp/from-state; no fabricated sequential history. The
upstream original-owner TwoNoise MERGED event is replayed last. All four
independently reviewed smoothness file hashes are unchanged. Final joint gate
is repeated because the upstream change adds a production module and root test.

Final synchronized canonical gate PASS9126jobs onbbcb641e7127a2f3730fa370b18216e7a9d819ab
at2026-09-11T04:51:46.329733+00:00, rootTests/fake-closure/ATLAS included.
Synchronized harness250tests6skips, publication39items, semantic49audits and
58cells PASS. Canonical website build/check PASS12chapters,405compiled local
leaves,596modules,3678declarations. Both regenerated affected graph reports
are exactly identical to the reports already visually inspected; proof/test/
lesson/publication bytes unchanged. Independent preservation review accepted
the actual ledger/audit conflict resolution and AdaptiveCenter's unchanged
historical proof/source artifacts; its already-merged stale reservation was
released with attribution, without impersonating its owner.

Authorized direct-main integration completed atb8952166ded42202504f446f04c7e54b00320bc0.
Atomic push confirmed main and task branch updated together. Both cells and
SAU now MERGED; this records actual integration, not a prediction.
