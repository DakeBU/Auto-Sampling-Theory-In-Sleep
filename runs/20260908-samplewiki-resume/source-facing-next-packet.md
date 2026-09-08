# Historical next-route audit: positive-fiber source alignment

Implemented by `CoordinateHeatBath.heatBath_eq_cond` at `ce0a871` with focused
consumer tests. The independent semantic comparison records a mismatch, not
exact source assimilation. See `finite-model-next-packet.md` for the remaining
source/model route; the API search below is retained as historical evidence.

Read-only API audit, 2026-09-08. This does not freeze a theorem, admit a source
repair, or add a new proof leaf. Reuse the operational coordinate kernel rather
than creating another resampling definition.

## Already available: do not reprove the atomic conditional formula

At Mathlib `db584cd6d46c92f209a44c0f1c829460d327499d`,
`ProbabilityTheory.condDistrib_apply_of_ne_zero` in
`Mathlib/Probability/Kernel/CondDistrib.lean:75` already states:

\[
 \kappa(x,s)
 = (\mu.map\,X\,\{x\})^{-1}
   (\mu.map\,(X,Y))(\{x\}\times s),
 \qquad \mu.map\,X\,\{x\}\ne0.
\]

Here `κ = condDistrib Y X μ`, the target measure is finite, the sampled space
is nonempty and Standard Borel, the conditioning space has measurable
singletons, and `Y` is measurable. The exact API asks for the nonzero marginal
atom and a set `s`; it does not add countability or finiteness of the state
space. Inspect the elaborated signature when consuming it rather than guessing
an extra `Measurable X` argument.

Its measure-level parent is `MeasureTheory.Measure.condKernel_apply_of_ne_zero`
in `Probability/Kernel/Disintegration/StandardBorel.lean:389`, itself reusing
`Measure.IsCondKernel.apply_of_ne_zero`. No occurrence of either API was found
in the ASTIS source, tests or current Frontier Cells during this audit.

## The actual missing consumer

Connect `CoordinateHeatBath.heatBath` to the source's conditional update on a
**positive retained-coordinate fiber**. A useful target is its normalized
restriction law on that fiber, or the resulting singleton transition formula
for the finite-discrete consumer. Select one minimal statement after inspecting
the existing conditional-probability, restriction and pushforward APIs; do not
implement both as separately counted wrappers.

This must expose the conditioning denominator and prove its nonzero contract.
Do not assume every ambient configuration is feasible. For a positive-mass
starting configuration, its retained fiber contains that configuration, so
measure monotonicity is the expected denominator adapter. Finite measure
controls the upper endpoint. The zero-marginal case is excluded from this
formula: the always-Markov selected conditional version is not a license to
divide by zero or claim source support on null fibers.

The final pointwise formula should distinguish unchanged retained coordinates
from the resampled coordinate and use the actual canonical kernel, not a
hypothetically invariant replacement. This would supply the missing bridge
between the source's update instructions and the shared law construction.

## Source/semantic workflow is part of that packet

- Keep the byte-pinned original Discrete Sampling section 1.3 wording and its
  existing copy-index issue unchanged. The neighboring prose and the proposed
  two-bit witness are evidence for review, not an accepted repair.
- After the exact source-facing Lean statement compiles, pin its elaborated
  statement and minimal anonymous definition context. Run independent blind
  reconstruction and the separate anti-anchored source comparison, with all
  seven semantic slots and packet/run hashes.
- Any correction needs its own exact-proposal independent repair review.
  An accepted shared proof or green root build cannot substitute for it.
- MCMC section 2.1.1, finite-discrete support, scan selection and mixing each
  retain their own conclusion and domain. No whole chapter or SampleWiki
  complexity row closes merely because this construction is source-aligned.

## Execution boundary

The six-packet shared kernel route provides the prerequisites; use compact
cell/review evidence. Public Registry remains 394 pending the serialized
integration queue. No remote publication permission has been received.
Do not bypass the kernel-powers stabilization lane or create a replacement Goal.
