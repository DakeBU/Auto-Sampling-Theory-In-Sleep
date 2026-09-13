# Exact quadratic-gradient trajectories

Source: Chewi arXiv:2605.07006v1 Exercise3.3 (Section3 GD convention).
SAU `ANDI-OPT-quadratic-gd-001`; cells
`ASTIS-SHARED-quadratic-gradient-iterate` and
`ASTIS-SHARED-quadratic-gradient-eigenmode`.
Proof/lesson candidate `14b1bcffa4208b16884a8e3f39599f9932bb102c`.

For symmetric continuous linear H on a complete real Hilbert space, the actual
objective f(x)=⟨x,Hx⟩/2 and update T_h(x)=x−h∇f(x) satisfy:

- `quadratic_gradient_iterate`: T_h^[N](x)=(I−hH)^N x.
- `quadratic_eigenmode`: if Hx=μx, then T_h^[N](x)=(1−hμ)^N x,
  its norm is |1−hμ|^N‖x‖ and its objective value is (1−hμ)^(2N)f(x).

The gradient is derived internally from the true quadratic, not assumed as an
oracle identity. Differentiation of the inner product and symmetry give
Df(x)[v]=⟨Hx,v⟩. Reuse Mathlib `FunLike.coe_pow_eq_iterate` and
`Module.End.HasEigenvector.pow_apply`, splitting x=0 before requiring a nonzero
Mathlib eigenvector. Norm and quadratic homogeneity give the other equalities.
Lean4.33.0; pinned Mathlib db584cd6d46c92f209a44c0f1c829460d327499d.

## Retrieval and source boundary

Samplinglib's existing GD results supply inequalities, not these identities.
Optlib5da27c5 LASSO.quadratic_gradient and ADMM.Gradient_of_quadratic_forms treat
squared norms of Ax using A†A; inspected CvxLean c62c2f has spectral algebra but
no matching actual GD trajectory. No external code is copied; the search is
bounded, not an exhaustive absence claim. Canonical derivative/eigenvector
results are reused rather than re-proving linear-algebra power induction.

Positive-definite Euclidean source matrices specialize the symmetric Hilbert
operator statement. Arbitrary real steps, indefinite/zero H, N=0 and x=0 are
legitimate identity domains, not enlarged convergence claims. A supplied mode
relation does not prove the existence of spectral endpoint eigenvectors in
infinite dimensions. To witness a nonzero sharp factor, x≠0 is essential.

Tests use the actual diagonal matrix diag(1,3) and each orthonormal basis vector:
at h=1/2 both norms equal (1/2)^N, with opposite signs on the high mode. A unit
scalar quadratic at h=3 has norm 2^N‖x‖ and value 4^N f(x), demonstrating that no
stability premise is hidden. Zero H and arbitrary h,N exercise the initial-point
identity. Focused build PASS2470, standard axioms only. Independent admission and
aggregate gates remain pending.

Conceptual-mirror audit: none-found. This step exposes exact scalar evolution of
an existing quadratic gradient mechanism, without constructing a new transport
between optimization, Markov spectral theory or other domains. Planned §5
polynomial-method reuse is not an existing compiled consumer or an oracle lower
bound. The publication leaves the full Section3 sharpness comparison uncovered.

## Integration notes and next boundary

Pending independent proof/source admission, root Tests import, Registry, full
ASTIS gate, site/graph checks and actual reader/branch inspection. Do not repeat
this trajectory target once admitted. Further work should select a new exact
source obligation, such as the remaining sharpness comparisons or a quadratic
polynomial consumer, after its own dependency and reuse audit. Neither companion
paper nor the full chapter is completed by these two declarations.
