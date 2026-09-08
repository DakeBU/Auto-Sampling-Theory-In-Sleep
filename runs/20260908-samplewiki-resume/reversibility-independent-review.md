# Independent review: actual random-scan reversibility

Verifier: `reversibility_proof_review` (`/root/reversibility_proof_review`), distinct
from formalizer `random_scan_reversibility_worker`, blind decoder
`/root/reversibility_blind_decoder`, and source reviewer
`/root/reversibility_source_review`. Date: 2026-09-08.

Verdict: accepted as **one integration node** at frozen proof commit
`865871bfe058e073421a478103bd5fc9f9b1a3eb`. The countable atomic bridge is genuinely
consumed by the existing Boolean random-scan kernel theorem; it is not a second
substantive count. Source acceptance is limited to the expressly selected Boolean
reversibility clause of LPW Section 3.3.2 / Exercise 3.2.

## Independent proof and API audit

`KernelReversibility.isReversible_of_singleton_balance` requires only a measurable
space with `Countable` and `MeasurableSingletonClass`, an arbitrary measure and
an arbitrary kernel, and symmetric singleton flux. The actual Mathlib definition
of `Kernel.IsReversible` asks for equality of the two set lower integrals; despite
its documentation mentioning Markov kernels, the definition imposes no Markov
instance. The bridge adds no finite, probability, sigma-finite or s-finite premise.

The proof decomposes each measure of a set into the sum of its singleton masses,
then each outer set integral into a countable sum. `ENNReal.tsum_mul_right` and
`ENNReal.tsum_comm` exchange nonnegative extended sums without integrability or
summability side conditions. The final pointwise equality is precisely the
supplied atomic balance, with multiplication order reversed as required by
`lintegral_countable`. No cancellation, subtraction of infinities, or finite-mass
shortcut is used. All subsets are measurable under the stated countability and
singleton assumptions. An independent converse consumer recovers singleton
balance from the actual set-integral conclusion.

`RandomScanHeatBath.randomScan_isReversible` concerns the already constructed
`randomScan`, not a replacement kernel or a supplied reversibility hypothesis.
The construction is the constant uniform mixture of the existing coordinate
conditional updates. Its probability-target and Boolean finite-product instances
supply all immediate parent hypotheses; `n+1` means at least one site.

The private flux proof separates the zero-source case first. When both atoms
vanish, both products are zero. When exactly one vanishes, the singleton law is
used only from the *opposite positive atom*, whose probability of reaching the
zero target atom vanishes. Thus no normalized-fiber formula is applied at a null
start. When both atoms are positive, both parent formulas apply. Off-site
agreement is symmetric; `Fin.succAbove_ne` identifies equal retained tuples and
hence literally equal fiber masses. Commutative multiplication establishes each
site's flux equality, and finite summation preserves it. There is no new inverse
cancellation and no hidden full-support premise. Probability normalization and
positive finite conditioning denominators are already proved in the parent law.

Only the two intended public declarations are new. Existing
`IsReversible.invariant` and `KernelInvariance.invariant_pow` are test consumers,
not proof parents or new public wrappers. The `none-found` conceptual-mirror
audit is appropriate for this exact atomic-algebra integration; no conceptual
transport or new categorical correspondence is admitted.

## Fresh checks and exact bytes

Every Lean command explicitly set `ELAN_TOOLCHAIN=leanprover/lean4:v4.33.0` and
`LEAN_NUM_THREADS=1`. Pinned Mathlib revision independently checked:
`db584cd6d46c92f209a44c0f1c829460d327499d`.

- Fresh direct elaboration of each public module and the complete focused test
  `Tests/RandomScanHeatBathReversibility.lean`: PASS, exit 0. These were actual
  `lake env lean` source checks, not a cached Lake-target replay.
- Fresh `.astis/reversibility-proof-review/Independent.lean`: PASS on first
  attempt, exit 0. Exact public and immediate Mathlib signatures were printed.
  It independently consumes reversibility to recover atomic balance, proves
  constant-self kernels reversible for arbitrary countable-space measures,
  exercises an infinite-mass atom `(infinity) • dirac 0`, checks its kernel
  really has infinite mass, and exercises arbitrary targets with zero kernel.
- Both public theorems and the independent named checks depend only on
  `propext`, `Classical.choice`, `Quot.sound`. No `sorryAx` or custom axiom.
- Canonical comment/string-stripped `astis.FORBIDDEN_REGEX` found no fake closure
  in the two public files, focused test, or independent Lean scratch.
- All three public/test byte strings match the frozen commit exactly, checked
  using unfiltered committed bytes as well as the worker's SHA-256 values.

| File suffix | SHA-256 |
| --- | --- |
| `Probability/KernelReversibility.lean` | `439e00b3aea2e674925eecde68ce43d62a7b9b168762f07d414c1feb51e8408a` |
| `Probability/RandomScanHeatBathReversibility.lean` | `9e4e6b3d792884660e1b9da65f804e7e497e046f3986613731dd9289ad026ac8` |
| `Tests/RandomScanHeatBathReversibility.lean` | `03fad6ab86be3dc1fad2de1e6dae47e22a331bf37cbe6aa5f013bd35c96b0c6f` |

The first two files are under `AutoSamplingTheory/TechnicalLemmas/`.
Public tests were fully inspected: arbitrary set flux, infinite counting target
and kernel, zero target, actual nonuniform transitions `3/8` and `1/8`, forbidden
atoms, nonzero Dirac target at an all-null-fiber ambient start, disconnected
absorbing diagonal support, the one-site case, and existing invariant powers.
The null-fiber counterexample explicitly distinguishes mass-one actual kernel
from zero normalized restriction; the diagonal example prevents a mixing claim.

Independent exact-rational stress testing covered 1,029 target/null-version
cases, 7,128 mass-one rows, and 52,896 symmetric weighted-flux pairs on one-,
two-, and three-site cubes. It varied zero-fiber completion among both point
masses and uniform resampling, always retaining the other sites. This is bounded
corroboration, not a Lean certificate or a separately credited theorem. Negative
controls show that state-dependent site choice can give transitions `1/2` versus
`0`, and deterministic composition can give opposite weighted fluxes `1/6`
versus `2/9`. Neither excluded generalization is silently accepted.

## Source gate and immutable-record consistency

The source reviewer independently inspected complete LPW PDF pages 58, 59 and 61
(printed 42, 43 and 45), with PDF SHA-256
`9ef39f9467d9647ff3f5e8747b9ce24b7a90d13be2f8156fbd827b95b661a772`.
This proof verifier reads that independent evidence and does not claim to repeat
the PDF inspection or the blind reconstruction.

Canonical audit `ASTIS-RT-20260908-RandomScanReversibility` is source-reviewed,
accepted, `equivalent-after-elaboration`. Independently checked exact equality of
all seven slots, all six informational deltas, the verdict, repairs (none), and
reviewer identity with the immutable response; the reconstruction text and decoder
packet hash also match. There was no schema repair of substantive reviewer text.

- Source response SHA-256:
  `5d2cfd3266f530d054cdbcefe087578ffe5dea8b6a9163ef44f3a9d3d6592528`.
- Canonical reviewer packet hash:
  `eb5e08c10f3061c782b7adedad1cc35d183b0d0776c92482cecc385809f098b6`.
- Canonical decoder packet hash:
  `ac2608ec5077c6e91f5748f3d8cd3c5e09e54f7be05f1e42258d13a1b89c692d`.
- Fresh independent semantic registry gate: PASS, 3 audits and 1 repair proposal.

The source support chain and ambient-cube implementation have equivalent
target-weighted reversibility: supported starts have positive retained fibers
and cannot move into zero target atoms; null starts have zero target weight.
This does not identify a normalized conditional law at every ambient null start.
Only the Boolean reversibility clause is accepted, not arbitrary finite spin
alphabets, every conclusion of the source section/exercise, the older CSV literal
copy-index algorithm, or the older diagnosis-only positive-fiber audit.

## Bounded historical synthesis audit

`kernel-cell-synthesis-v2.json` is accurate as an eight-member historical snapshot
at `bb6fa815270f0bb41a6ec197caecae737227acf6`, not a current nine-member snapshot.
All eight contracts were compared with canonical cells and their compact review
capsules without rebuilding old proofs. Both basis-commit and current member
status counts are one `stabilized` cell and seven `independently_verified` cells;
the corresponding ledger has one `STABILIZING` and seven `VERIFIED` members.
The sole stabilization owner remains KernelInvariance. The positive-fiber
diagnosis-only source boundary and later limited random-scan source acceptance
are distinct and accurately preserved. Proof parents versus test-only invariance
and power consumers are correctly separated.

The historical gate marker separately records PASS at that basis commit and
source digest `f65bbbdf0cc005bf640efbb7e59dc38b75e4e0b8dae138f49eb5e121a09e18f8`;
this is provenance inspection, not replay of the old root build or site tests.
The new reversibility cell is explicitly only the snapshot's next candidate,
not a member. No historical claim required weakening. This supports independent
validation of `ASTIS-DISC-20260908-shared-kernel-synthesis-v2`.

## Publication and remaining boundary

After the fresh proof and semantic gates, the verifier published the single
supported `ASTIS-20260908-RandomScanReversibility -> VERIFIED` event and the
independent validations of the historical synthesis discovery and
`ASTIS-DISC-20260908-CountableAtomicReversibility` through the supported APIs.
Only this cell's verification status/evidence and coordinator-authorized stale
source-pending prose were updated. Final Frontier Cell check passed (10 cells)
and the scoped whitespace check was clean. The raw worker packet remains
historical evidence, not self-verification.

No public Lean/test file, root import, Registry entry, source registry, graph,
remote state, commit, or stabilization owner is changed by this verifier.
No root gate was replayed. Arbitrary finite alphabets, explicit supported-subtype
kernels, concrete Gibbs normalization, pointwise null-fiber formulas, scan-order
generalizations, irreducibility, mixing, estimator accuracy, clocks/rates and
computational cost remain outside this acceptance. Verifier-owned writes stop
after the supported events and final bounded state/whitespace checks.
