# Historical route audit: operational coordinate retention

Implemented at `5576ad81fbfcf0dbd68a1fc2e34de8b8ac435164`; the canonical
`ASTIS-SHARED-coordinate-heat-bath` cell owns current verification evidence.
See `source-facing-next-packet.md` for the next residual. The audit below
preserves the pre-implementation distinction between marginal laws and
literal almost-everywhere retention.

This is a bounded route audit, not a compiled claim or a frozen source theorem.
The preceding `KernelTransport.invariant_map_comap` packet has focused and root
Lean evidence. Its private coordinate tests prove invariance, not the complete
operational semantics of a Gibbs update.

## Why another invariance wrapper is not the next advance

An invariant kernel need not update the requested coordinate. In particular, a
kernel that draws afresh from the whole target can also preserve that target.
The next useful consumer must connect the already tested conjugated heat-bath
kernel to the instruction: retain every coordinate other than the selected one.

Do not add public copies of Mathlib's coordinate split or marginal-product facts.
At Mathlib `db584cd6d46c92f209a44c0f1c829460d327499d`, reuse:

- `MeasurableEquiv.piFinSuccAbove` and `MeasurableEquiv.prodComm` for the split;
- `MeasureTheory.Measure.map_fst_prod` (`Measure/Prod.lean`), requiring
  s-finiteness of the second factor; a probability conditional law supplies it;
- `ProbabilityTheory.Kernel.fst_prod` and `Kernel.fst_comp` for kernel marginals;
- `MeasureTheory.ae_dirac_eq` and `ae_eq_dirac`, whose singleton-measurability
  assumption is explicit;
- `MeasureTheory.ae_map_iff` / `ae_of_ae_map`, with genuine measurability.

## Distinguish two contracts

1. The retained marginal is a Dirac **measure**. This follows from the existing
   product-law form and Markov conditional law on arbitrary measurable retained
   spaces. It is an API reuse step, not a new mathematical leaf.
2. A sampled state has literally equal retained coordinates **almost everywhere**.
   For a retained coordinate `j`, a direct proof needs measurability of the
   singleton `{x j}` (for example `MeasurableSingletonClass (X j)`). Do not infer
   this from equality of laws on an arbitrary coarse sigma-algebra. It holds in
   the intended finite-discrete/standard-Borel applications, but it is not a new
   hypothesis of the preceding generic invariance-transport theorem.

For a dependent finite product, first prove the assertion for each `j != i` with
only that retained coordinate's singleton-measurability contract. A simultaneous
finite-coordinate assertion can then reuse finite intersections. The resampled
coordinate's nonempty Standard-Borel contract remains the one needed by
`condDistrib`; finite joint target includes zero. Null-fiber conditional support,
positive density, feasibility of arbitrary initialization, reversibility and
mixing remain separate obligations.

## Candidate substantive packet

Promote the already tested coordinate heat-bath construction to one canonical
algorithm interface only if the packet also establishes its missing operational
retention law. Reuse existing transport for invariance and existing Markov
instances. Do not count the definition, splitting notation, marginal rewrite,
or repeated invariance adapter as independent new mathematical leaves. Keep
fixed-mixture and finite-power demonstrations in consumer tests.

The public coordinate interface and exact minimal imports/names must be frozen
by its owner after searching current shared cells; no duplicate test-only
construction should remain as a second purported public source of truth.

## Source boundary

The byte-pinned Discrete Sampling section 1.3 copy-index issue was visually
confirmed in `source-coordinate-update-audit.md`; its repair is still a candidate.
The proposed finite-state witness requires an independent semantic review.
Neither this API audit nor the transport proof certifies that repair or assimilates
a numbered source theorem. The MCMC section 2.1.1 interpretation is motivated by
the actual conditional-update definition, not invariance alone.

## Integration boundary

Kernel powers retains the sole `STABILIZING` lane; Registry remains 394. Local
proof exploration does not authorize publication, bypass the queued verification
states, or close the overall Goal. No remote operation is part of this packet.
