# Optimisation technical-lemma agent note

Before adding acceleration-specific declarations, read:

- `../../../docs/acceleration-geometry-handoff.md`
- `../../../Libraries/acceleration-geometry-program.json`

This directory owns geometry-independent reusable optimisation leaves. Prefer one canonical scalar/algebraic certificate that can be consumed by Euclidean, Riemannian, transport, and sampling adapters.

Do not encode a conceptual mirror as a theorem. `Nesterov ≈ underdamped Langevin`, `Katyusha anchor → score-noise stabilization`, and `differing norms → cross-geometry sampling` require target-domain hypotheses and remain outside the compiled dependency DAG until explicitly proved.

For non-Euclidean work, keep the differential/covector and the geometry-specific duality map separate. A general `p != 2` norm is not automatically a Riemannian metric; route nonquadratic geometry through Banach/Finsler/Legendre abstractions when source formalization reaches that layer.
