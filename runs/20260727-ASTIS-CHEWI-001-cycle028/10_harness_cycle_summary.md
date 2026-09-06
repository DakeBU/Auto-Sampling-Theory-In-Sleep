# ASTIS-CHEWI-001 Cycle 28

Run id: `20260727-ASTIS-CHEWI-001-cycle028`

## Textbook Frontier

The active source edge remains Chewi, Chapter 1, Example 1.2.8 to Corollary
1.2.9. Cycle 28 closes only dominated convergence for the main integrable
field multiplied by the PiLp-wrapped radial cutoff.

```text
Integrable H + radial cutoff in [0,1] + pointwise cutoff exhaustion          [blue]
  -> integral of cutoff * H tends to integral of H                          [blue]
  -> integrability of the concrete Gibbs-weighted generator display          [red]
  -> Gibbs-tail passage                                                       [red]
  -> whole-space Gibbs-weighted integration by parts                          [red]
  -> generator/semigroup domain semantics                                     [red]
  -> invariant Gibbs law                                                       [red]

separate on-demand branch:
radial cutoff -> Hessian/Laplacian O(R^-2) for a named consumer              [red]
```

## Hierarchical Agent Decisions

| Role | Decision |
|---|---|
| upper | Close a generic but cutoff-specific DCT leaf on the exact raw finite-Pi consumer surface. |
| middle | Freeze an arbitrary-measure, real normed-space-valued theorem with sole premise `Integrable H μ`. |
| lower source/API | Reuse Mathlib filter DCT plus the compiled cutoff continuity, range, and pointwise-exhaustion leaves; no duplicate theorem or external port exists. |
| lower Lean | Compile the frozen declaration in `Divergence.lean` without a `CompleteSpace` assumption. |
| reviewer | Accept eventual positive-scale measurability, norm domination, pointwise smul convergence, Mathlib's totalized incomplete-target semantics, and the strict downstream boundary. |

## Compiled Lean Progress

One registered leaf was added:

- `tendsto_integral_radialSmoothCutoff_comp_toLp_smul`.

The proof applies `MeasureTheory.tendsto_integral_filter_of_dominated_convergence`.
For eventually positive scales the cutoff composite is continuous and hence
strongly measurable; its values in `[0,1]` dominate the norm of the product by
`‖H x‖`; and pointwise cutoff exhaustion gives convergence to `H x`. The
registry total is now `256`.

## External Reference Audit

- The current public PDF was checked against the Chapter 1 weighted-IBP route.
- The configured `outer_repos` and `outer_papers` Linux checkouts are absent
  from this Windows mirror. No fetch was attempted in Cycle 28.
- The latest recorded safe SLT audit remains commit
  `d0f506f0a695018265dccb33bcb05e2f5ca1c876`, toolchain `v4.32.0`.

## Documentation And Visuals

- Registry, tests, README, module cards, chapter DAGs, roadmap, retrieval
  indexes, trial log, memory digest, and todo packet were synchronized.
- The Chapter 1 DAG colors generic main-term dominated convergence blue while
  retaining concrete generator-display integrability, Gibbs tails, IBP,
  domains, and invariance as distinct red nodes.
- Regenerated PNGs are visually checked after the final memory refresh.

## Verification Gates

- `lake build Tests`: passed (3641 jobs).
- `python3 tools/astis.py check`: passed (including full build and `Tests`).
- `python3 -m py_compile tools/astis.py`: passed.
- `git diff --check`: passed.

## Next Exact Red Packet

Prove integrability of the concrete Gibbs-weighted scalar Langevin generator
display `exp(-V) * (Delta f - <grad V, grad f>)` under explicit potential and
test-function assumptions. Keep Gibbs-tail passage, whole-space weighted
integration by parts, generator/semigroup domains, invariant-law semantics,
and second-order cutoff estimates separate.
