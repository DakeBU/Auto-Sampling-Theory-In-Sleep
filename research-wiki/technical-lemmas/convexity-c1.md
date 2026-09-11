# C1 convexity equivalences

Main cell: ASTIS-OPT-convexity-c1. Advance: ANDI-OPT-convexity-c1-001.
Source: Chewi arXiv:2605.07006v1, Proposition 1.6 part 1, (1.3)-(1.5).
Shared prerequisite cells: ASTIS-SHARED-segment-gradient-ftc and
ASTIS-SHARED-gradient-integral-convexity. One owned SAU, three exact declarations.

The shared ConvexityC1 module proves the affine-segment FTC identity, the
source integral converse from quantitative gradient monotonicity to chord
convexity, and the exact Euclidean C1 nonnegative-modulus equivalences.
It reuses the existing first-order theorem; the earlier MVT converse
remains a separate reusable result. No duplicate convexity or gradient API.

C1 supplies real gradients, continuous scalar integrands and interval
integrability. For t<1, cancellation uses only s(1-t)>0 on the open interval;
t=1 is handled separately. No division by m or by a zero displacement occurs.
The first two leaves allow Hilbert spaces and signed modulus; the final adapter
restores the source hypotheses. C2/Hessian, complete Proposition1.6 and
Riemannian versions remain open. Existing curvature-growth/segment calculus
exhaust the conceptual-mirror audit; no new bridge is claimed.

Focused module/tests pass 2725 jobs. Independent c1_proof_review repeated
compilation, checked all three standard-axiom reports and found no mathematical
issue. Blind reconstruction and anti-anchored source review are separate.
Root Tests import, Registry, graph and full acceptance are integration work.

## Independent admission and integration

Frozen proof commit: 7616533a656e149a972c1d52af4bbbcdec148baa.
Independent proof/commit reviewer: c1_proof_review. Source-blind decoder:
c1_blind_decoder. Distinct source reviewer: c1_source_reviewer. Source packets
and immutable run artifacts are in runs/semantic-roundtrip/andi-opt-convexity-c1.
The shared FTC and integral-converse audits retain domain-mismatch verdicts
with accepted explicit source specializations. The exact Euclidean C1
equivalence is equivalent-after-elaboration. No source repair was needed.

Root Analysis and Tests now import the new module/test. Registry has three
new entries (397 to 400). The stationary-point test uses the two equivalences
together to obtain quadratic growth. Historical publication tests now identify
exactly two legacy declarations independently of the source item's total
binding count; all five bindings still undergo validation. All44 focused Python
tests pass. Independent integration review of d7cffce found no weakening of
the gate, stale source hash or test-wiring problem.

Full canonical gate passed before main sync (9112 jobs in Tests). Integration
commit51e07c9 also preserves main99aa052 and its complete source audit objects;
a fresh aggregate gate covers the new joint source tree. PR262's completed
reservation is independently reconciled using c1_proof_review's preservation
audit and attributed historical evidence. No other owner's merge is impersonated.

Final synchronized gate on 51e07c9 passed, including root Tests (9114 jobs),
fake-closure scan and pinned ATLAS validation. Publication (34 source items),
semantic review (40 audits), frontier cells (49), generated graph checks for
all three cells, and full site check passed. Site has 400 registered leaves,
584 modules and 3669 declarations. Desktop and mobile source/graph inspection
confirmed readable assumptions, proof steps, horizontally scrollable formulas,
compiled status and distinct structural/reference edges.

Next dependency-ready optimisation work: inspect existing Hessian APIs and
source detail for Proposition 1.6 part 2 before choosing one C2 implication.
Do not mark the complete proposition or Riemannian analogue finished.

Integrated directly into main at c6419942741d2ef3fe535859c22ef222aa936448 after all local gates and
independent reviews passed; the atomic remote push succeeded. No PR created.

Current follow-up: ConvexityC2 now supplies the exact C2 Hessian equivalence
and its derivative-limit/integral proof, documented in convexity-c2.md. Earlier
C2-open wording above describes the C1 checkpoint only. The C1 reader scope
sentence is refreshed with a new independent source review; its Lean statement,
proof and blind reconstruction are unchanged. Next candidate: audit source
smoothness equivalences and existing shared APIs before claiming a new edge.
