# ASTIS-CHEWI-001 Cycle 27

Run id: `20260727-ASTIS-CHEWI-001-cycle027`

## Textbook Frontier

The active source edge remains Chewi, Chapter 1, Example 1.2.8 to Corollary
1.2.9. Cycle 27 closes only whole-space integrability of the concrete
Gibbs-weighted first-derivative coordinate field consumed by the compiled
generic cutoff-gradient theorem.

The June 12, 2026 textbook version states the integration-by-parts step in
Example 1.2.8 for unspecified functions, while Example 1.2.4 uses a `C²`
test function with bounded derivatives and the surrounding text explicitly
defers generator-domain subtleties. The compiled leaf extracts only the
`C¹` and bounded-first-derivative fragment needed by this source field; it is
not an arbitrary-function IBP theorem.

```text
finite Gibbs mass + continuous V + genuine bounded C1 fderiv              [blue]
  -> Integrable raw-Pi field exp(-V) * coordinate fderiv f               [blue]
  -> generic L1 cutoff-gradient cross-term limit                          [blue]
  -> main-term dominated convergence                                      [red]
  -> Gibbs-tail passage                                                    [red]
  -> whole-space Gibbs-weighted integration by parts                      [red]
  -> generator/semigroup domain semantics                                 [red]
  -> invariant Gibbs law                                                   [red]

separate on-demand branch:
radial cutoff -> Hessian/Laplacian O(R^-2) for a named consumer            [red]
```

## Hierarchical Agent Decisions

| Role | Decision |
|---|---|
| upper | Close exactly the `Integrable` premise for `exp(-V) ∇f` in the existing raw-Pi coordinate representation. |
| middle | Confirm the field is `exp(-V)` times the `fderiv f` coordinates under Lebesgue volume, not `f ∇V` and not an unweighted gradient under a silently substituted Gibbs measure. |
| lower source/API | Reuse `lintegral_ofReal_ne_top_iff_integrable`, `PiLp.volume_preserving_toLp`, `Integrable.smul_bdd`, and the coordinate operator-norm bound; no external port is needed. |
| lower Lean | Compile one theorem from finite Euclidean Gibbs mass, `Continuous V`, `ContDiff ℝ 1 f`, and a uniform `fderiv` norm bound. |
| reviewer | Accept the exact volume transport, genuine differentiability, raw-Pi sup-norm bound, measurability, and scalar-times-bounded-field integrability proof. Reject every downstream convergence, IBP, domain, and invariance claim. |

## Compiled Lean Progress

One registered leaf was added:

- `integrable_expNeg_fderivCoordinateField_of_lintegral_expNeg_ne_top_of_fderiv_norm_le`.

The proof first converts the finite nonnegative Euclidean Gibbs `lintegral`
into real-valued integrability, then pulls it back to raw Pi space through the
volume-preserving `WithLp.toLp` map. The derivative coordinate field is
continuous because `f` is genuinely `C¹`; its raw Pi sup norm is bounded
coordinatewise by the supplied `fderiv` operator-norm bound. Mathlib's
`Integrable.smul_bdd` then yields the exact field needed by Cycle 26. The
registry total is now `255`.

## External Reference Audit

- The current public PDF was checked directly at Example 1.2.4 and Example
  1.2.8; its version date is June 12, 2026.
- The configured `outer_repos` and `outer_papers` Linux checkouts are absent
  from this Windows mirror. No fetch was attempted in Cycle 27.
- The latest recorded safe SLT audit remains commit
  `d0f506f0a695018265dccb33bcb05e2f5ca1c876`, toolchain `v4.32.0`.

## Documentation And Visuals

- Registry, tests, README, module cards, chapter DAGs, roadmap, retrieval
  indexes, trial log, memory digest, and todo packet were synchronized.
- The Chapter 1 DAG now colors source-field integrability blue while keeping
  main-term convergence, Gibbs tails, IBP, domains, and invariance red.
- The regenerated foundation, status, sampling-leaf, and module graphs were
  rendered to PNG and visually inspected for readable text, edges, colors,
  and layout.

## Verification Gates

- `lake build Tests`: passed (3641 jobs).
- `python3 tools/astis.py check`: passed (including full build and `Tests`).
- `python3 -m py_compile tools/astis.py`: passed.
- `git diff --check`: passed.

## Next Exact Red Packet

Prove the main-term dominated-convergence leaf for multiplication by the
radial cutoff under an explicit integrable dominating Langevin-generator
display. Keep Gibbs-tail passage, whole-space weighted integration by parts,
generator/semigroup domains, invariant-law semantics, and second-order cutoff
estimates separate.
