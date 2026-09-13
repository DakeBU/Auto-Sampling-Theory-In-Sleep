# Strong convexity and nonlinear numerical PL pullback

Source: Chewi arXiv2605.07006v1 Exercise2.3, Definition2.5 and Section2.
SAU ANDI-OPT-pl-pullback-001; cell ASTIS-SHARED-strong-convex-pl-pullback.

The actual derivative A=Dg maps E to F; source Jacobian J is its adjoint.
Coercivity of A A-adjoint gives sigma times the base gradient square.
StrongConvexFirstOrder + Cauchy-Schwarz + completing a square gives
2alpha(f(gx)-fz)<=norm(gradient f(gx))². The chain rule identifies the true
composite gradient with A-adjoint gradient f(gx). Surjectivity supplies one
minimizing preimage of the supplied attained base minimum. Multiply by sigma>=0.

This is a numerical inequality, not an assertion of the whole C1 positive-modulus
Definition2.5 package. Exercise wording leaves continuity of Dg and positive
sigma implicit/unstated. Sigma0 is degenerate; general differentiability and
Hilbert spaces are explicit extensions. No composite convexity, unique/minimum
multiplicity, algorithm rate, matrix-coordinate certificate or paper completion.
The initial proposed C1 target was refined before proof admission after the
independent source audit: retain the precise numerical component without adding
continuity merely to claim full definition coverage.

Reuse: ASTIS first-order bound and pinned Mathlib adjoint, Riesz and Frechet chain
rule APIs. Optlib/CvxLean bounded searches in canonical upstream-review.json.
Compiler diagnosis: chain rule point argument and adjoint orientation are explicit;
normalize Riesz derivative equality without inventing a gradient premise.

Conceptual-mirror audit: none-found. This is an actual compiled within-Hilbert
pullback mechanism, not new evidence for a Riemannian or measure-space transport.
Existing gap-gradient family retained; no invented cross-domain bridge.

Focused compilation PASS2458, with actual nonlinear g(x)=x+x³ and f(t)=t²/2.
The test proves surjectivity by the intermediate value theorem, the nonconstant
derivative 1+3x², and sigma1 operator coercivity; it consumes the composite
inequality at the constructed minimizing preimage. Standard axioms only.
Independent review, source roundtrip, root gate and visual publication pending. Next consumer: use a supplied upper model only when deriving GD rates;
PL does not imply gradient Lipschitz smoothness. Keep full definition regularity
and positive-modulus source obligations separate.
