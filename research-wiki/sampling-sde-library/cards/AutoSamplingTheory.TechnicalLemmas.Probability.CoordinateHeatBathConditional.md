# AutoSamplingTheory.TechnicalLemmas.Probability.CoordinateHeatBathConditional

- File: `AutoSamplingTheory/TechnicalLemmas/Probability/CoordinateHeatBathConditional.lean`.
- Layer: shared KERN/MEAS conditional-law integration.
- Evidence: [canonical Frontier Cell](../../frontier-cells/ASTIS-SHARED-coordinate-heat-bath-positive-fiber.json).
- Consumer tests: `Tests/CoordinateHeatBathConditional.lean`.
- [Local dependency slice](../../../runs/20260908-samplewiki-resume/positive-fiber-frontier.svg): actual proof parents and separate red residuals.

## Mathematical statement and calculation route

Fix a selected site `i` in a finite, possibly dependent family of coordinate
spaces. Let `r_i` collect all other coordinates, and write
`F_i(x) = {y | r_i(y) = r_i(x)}`. For a finite target measure and
`mu(F_i(x)) != 0`, the existing coordinate update has the law

\[
 K_i(x,A)=\frac{\mu(A\cap F_i(x))}{\mu(F_i(x))},
 \qquad K_i(x)=\operatorname{cond}(\mu,F_i(x)).
\]

The equality is between measures, not just equality of a chosen coordinate
marginal. It connects the actual public `heatBath` construction to normalized
restriction; there is no second kernel definition. In a finite discrete model
it yields the conditional transition probabilities on a positive fiber.

## Why this step is valid

The measurable coordinate split sends the target to a measure on the retained
tuple times the selected coordinate. Evaluate the retained Dirac product and
push it back through the inverse split. Mathlib's existing
`condDistrib_apply_of_ne_zero` evaluates the conditional law at the positive
retained atom. Genuine measurable pushforward formulas identify that atom's
mass with `mu(F_i(x))` and its numerator with `mu(A intersect F_i(x))`.
The final set identity uses the inverse equivalence pointwise.

This is one integration theorem, not a new formalization of the atomic
conditional-distribution formula already present in Mathlib.

## Hidden assumptions and Lean choices

- Each coordinate is measurable. Only the selected space must be nonempty
  and Standard Borel, exactly as in the parent conditional-law construction.
- The retained product has measurable singletons, making the conditioning
  atom and its inverse-image fiber measurable. Finite coordinate count does
  not mean finite state space. The theorem does not impose Standard Borel
  structure on every retained coordinate.
- The target is finite, not necessarily a probability measure. A positive
  fiber rules out a zero target in this particular application. Finiteness
  also rules out an infinite conditioning mass.
- Positivity belongs to the retained fiber, not to every configuration in
  the ambient product. A positive-mass starting singleton suffices by measure
  monotonicity; ambient feasibility is not assumed automatically.
- `cond` is the totalized normalized restriction. On a zero fiber it is the
  zero measure, whereas the selected regular conditional version remains
  Markov. The displayed equality therefore cannot extend to zero fibers.
- The `succAbove` index in the Lean statement is Mathlib's existing native
  enumeration of retained sites. No duplicate split/fiber wrapper is added.

## Dependencies and scope

ASTIS proof parents: `CoordinateHeatBath.heatBath` and
`HeatBath.heatBathSnd_apply`. Mathlib supplies `condDistrib_apply_of_ne_zero`,
`cond_apply'`, Dirac products, measurable map composition, and the measurable
coordinate equivalence. The public imports are the coordinate module and
`Mathlib.Probability.ConditionalProbability`.

The conditional sampler remains noncomputable. This theorem does not select
a scan distribution, build a concrete Gibbs target, prove detailed balance,
mixing, or an executable sampling cost. It is not a zero-fiber support theorem.

## Source correspondence is a separate gate

Discrete Sampling section 1.3, pinned arXiv:2307.13826v4, PDF/printed page 5,
motivates a source-facing comparison of the fixed-site update. The original
copy-index issue remains visible. A generic finite-measure law is not by itself
the full finite-binary-state algorithm or its uniform scan. The exact Lean
proposition, blind reconstruction, domain differences and independent source
review are recorded separately in the semantic-roundtrip registry. Compiled
proof status must not be read as exact source fidelity or accepted repair.

The completed comparison is `ASTIS-RT-20260908-PositiveFiberUpdate` in the
[semantic registry](../../semantic-roundtrip/registry.json). Its independent
verdict is `possible-source-error`: literal retention and the unsupported
positive-fiber qualification block exact source alignment; ambient-domain
and quantifier generalization also require review. Acceptance records the
diagnosis, not a correction. There are no accepted repair proposals.

The source reviewer supplied a separate uniform two-bit example: copying the
old selected value changes the complementary coordinate, while conditioning
on its old value keeps it fixed. Both conditioning events are positive, so
the discrepancy is not explained by a null-fiber convention. The source PDF
itself remains unchanged; a fresh exact-proposal review is still needed.
