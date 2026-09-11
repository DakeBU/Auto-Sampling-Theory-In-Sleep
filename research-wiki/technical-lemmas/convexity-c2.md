# C2 convexity and Hessian equivalence

Advance: ANDI-OPT-convexity-c2-001. Frozen proof commit: 724e90f.
Source: Chewi, arXiv:2605.07006v1, Proposition 1.6 part 2, (1.5)-(1.6),
final proof paragraph (positive directional limit and Hessian FTC).
The proposal inherited a C1 equation-range description; this exact part-2
anchor supersedes that description, as recorded in the checkpoint.

One shared module ConvexityC2 supplies the Hessian segment identity,
gradient-monotonicity/Hessian equivalence and exact Euclidean chord/Hessian
adapter. Canonical cells: ASTIS-SHARED-gradient-hessian-ftc,
ASTIS-SHARED-gradient-hessian-equivalence and ASTIS-OPT-convexity-c2.

Reuse search found existing HessianStrongConvexity (scalar convexity sufficient
condition) and DisplacementMonotoneDerivative (nonnegative derivative of a
monotone map); neither supplies the selected source's exact two-way integral
route. Keep both intact. The new proof differentiates the scalar evaluation
Df(x+tv)[v], avoiding a duplicated Hessian field or a Riesz derivative wrapper.
C2 gives genuine derivatives and continuous, interval-integrable Hessian
pairings. Only positive t is cancelled; no division by modulus or norm occurs.
The two shared leaves allow complete real inner-product spaces and the
monotonicity equivalence allows signed m. The final adapter restores Euclidean
space and m>=0, including d=0. No Riemannian or chapter-completion claim.

Conceptual-mirror audit: none-found. Directional calculus and curvature-growth
are existing mechanisms, not a new transport certificate. The next useful
consumer is the source smoothness equivalence after its exact assumptions and
existing APIs are searched. Chapter1 optimality/existence leaves remain separate.

Independent c2_route_review repeated the focused 2727-job build (no warnings)
and canonical scoped fake-closure scan; all3 declarations use only propext,
Classical.choice and Quot.sound. Tests exercise a reversed nonconstant segment,
signed quadratic curvature, interface agreement with the old sufficient
condition, actual stationary-point growth and zero dimension/modulus.
Source-blind decoder c2_blind_decoder reconstructed the statements without
ambiguities from anonymous packets only. Separate source review is pending.
Root Tests import and Registry admission remain stabilization obligations.

Independent source reviewer c2_source_reviewer accepted all3 packets: FTC and
gradient/Hessian helper retain domain-mismatch generalizations, and the exact
Euclidean theorem is equivalent-after-elaboration. No repair needed. The
independent proof recommendation is bound to full724e90f commit and recorded
only after source review and real publication validation passed.

Latest main79dc552 (PR263) merged without conflicts into22f0e576. All41
upstream source audit objects preserved. Its stale GaussianKL reservation was
released with independent preservation review, retaining historical evidence
and explicitly recording its older development-hash discrepancy. No original
owner's MERGED transition is impersonated.

Root Analysis and Tests import ConvexityC2, and Registry includes3 exact new
declarations (400 to403). No Python test standard was changed. Full acceptance
and reader/graph verification remain the final integration checks.
