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
