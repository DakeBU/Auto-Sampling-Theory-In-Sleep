# ASTIS-CHEWI-001 Cycle 25

Run id: `20260713-ASTIS-CHEWI-001-cycle025`

## Textbook Frontier

The active source edge remains Chewi, Chapter 1, Example 1.2.8 to Corollary
1.2.9.  Cycle 25 closes the first-order cutoff interfaces needed to state the
next integral leaf, but it does not prove a tail limit, whole-space weighted
integration by parts, generator-domain semantics, or the invariant Gibbs law.

```text
radial support, smoothness, compact support, pointwise exhaustion       [blue]
  -> one C for all R > 0: ||fderiv chi_R(x)|| <= C / R                 [blue]
  -> totalized fderiv is zero on ||x|| >= 2R, including the boundary   [blue]
  -> PiLp chain-rule producer for z |-> chi_R(WithLp.toLp 2 z)         [blue]
  -> trace of chi'.smulRight G on the standard Pi basis = chi' G      [blue]
  -> generic L1 cutoff-gradient integral limit from Integrable G       [red]
  -> Gibbs-specific domination and main-term convergence               [red]
  -> whole-space Gibbs-weighted integration by parts                    [red]
  -> generator/semigroup domain semantics                               [red]
  -> invariant Gibbs law                                                [red]

separate on-demand branch:
radial cutoff -> Hessian/Laplacian O(R^-2) for a named consumer         [red]
```

## Hierarchical Agent Decisions

| Role | Decision |
|---|---|
| upper | The first-order tail route does not need a Hessian leaf.  Close the finite-Pi consumer interfaces, then target a generic L1 cutoff-gradient limit. |
| middle | State the outer derivative-zero theorem with the non-strict condition `2 * R <= ||x||`; handle the boundary through a global minimum, not local constancy. |
| lower source/API | Mathlib already supplies the generic support machinery, while the active divergence consumer needs an explicit `WithLp.toLp 2` chain-rule bridge and basis-trace identity. |
| lower Lean | Compile one cutoff theorem and two finite-dimensional divergence interfaces without adding measure-theoretic conclusions. |
| reviewer | Accept the three narrow leaves.  Reject tail, IBP, invariance, and arbitrary-norm differentiability overclaims; keep source-field integrability and dominated convergence red. |

## External Reference Audit

- Checkout:
  `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/lean-stat-learning-theory`
- `HEAD == origin/main == d0f506f0a695018265dccb33bcb05e2f5ca1c876`.
- The checkout is tagged `v4.32.0` and has no source edits; `.lake/` is an
  untracked build cache.
- `lake build SLT.GaussianSobolevDense.Cutoff` passed under Lean `v4.32.0`
  (3115 jobs, including rebuilt dependencies).
- The latest source change does not alter the cutoff definition or the
  first-derivative proof pattern used by ASTIS.

## Compiled Lean Progress

Three registered leaves were added:

- `radialSmoothCutoff_fderiv_eq_zero_of_two_mul_le_norm`;
- `hasFDerivAt_radialSmoothCutoff_comp_toLp`;
- `sum_smulRight_apply_pi_single_eq_apply`.

The first theorem uses Mathlib's totalized `fderiv`.  At the sphere
`||x|| = 2R`, it obtains derivative zero from the global-minimum property; it
does not assert genuine differentiability of an arbitrary norm.  The other two
theorems are pointwise finite-dimensional interfaces and contain no
measurability or integrability claim.  The registry total is now `253`.

## Documentation And Visuals

- The Chapter 1 graphs now show the blue `C/R` bound, closed-outer derivative
  zero, PiLp derivative producer, and `smulRight` trace identity before the red
  L1 cutoff-gradient tail.
- The Hessian/Laplacian branch remains separately red and is not drawn as a
  prerequisite for the first-order tail route.
- The root README, overview, module graph, module cards, source anchors, and
  external-library card were refreshed.

## Verification Gates

- `lake build Tests`: passed (3641 jobs).
- `python3 tools/astis.py check`: passed.
- `python3 -m py_compile tools/astis.py`: passed.
- `git diff --check`: passed.

## Next Exact Red Packet

Prove a generic L1 cutoff-gradient integral limit for the PiLp-wrapped radial
cutoff from `Integrable G` and the compiled `C/R` bound.  Keep the main-term
dominated-convergence theorem and the Gibbs source-field integrability theorem
as separate red leaves.  Add Hessian/Laplacian estimates only when a named
second-order consumer requires them.
