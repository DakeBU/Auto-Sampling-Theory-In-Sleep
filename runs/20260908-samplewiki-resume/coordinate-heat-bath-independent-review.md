# Independent review: operational coordinate heat-bath

Verdict: accepted as **one source-neutral integration node**, not four
independent mathematical leaves. Verifier: `coordinate_heatbath_review`,
independent of `coordinate_heatbath_worker`. Date: 2026-09-08.
Checked commit: `5576ad81fbfcf0dbd68a1fc2e34de8b8ac435164`.
Advance: `ASTIS-20260908-CoordinateHeatBath`.

## Independent gates and exact bytes

All Lean/Lake calls used `ELAN_TOOLCHAIN=leanprover/lean4:v4.33.0` and
`LEAN_NUM_THREADS=1` in the original physical D: repository/cache. Independently
checked Mathlib revision: `db584cd6d46c92f209a44c0f1c829460d327499d`.
The worktree was clean at the start of final verification.

- `lake build Tests.CoordinateHeatBath`: passed, 2980 jobs, replaying the
  up-to-date focused target and its signature/axiom output.
- `lake env lean AutoSamplingTheory/TechnicalLemmas/Probability/CoordinateHeatBath.lean`:
  fresh direct public-module check passed, exit 0.
- `lake env lean --stdin`: fresh independent check passed, exit 0. It checked
  all four public signatures and axioms, exact Mathlib proof-API signatures,
  the pointwise product-law formula, both split-coordinate formulas, and the
  additional mixed-coarse and empty-retained boundary examples described below.
- All four public declarations depend only on `propext`, `Classical.choice`,
  and `Quot.sound`; no `sorryAx` dependency appeared. Scoped source scanning
  found no `sorry`, `admit`, custom `axiom`, `Prop := True`, or `:= trivial` closure.
- `python tools/astis_frontier_cells.py check`: passed, 7 registered cells.
  Scoped `git diff --check` was clean.

Unfiltered working-file Git hashes matched all five committed blobs before
review evidence was added:

| Artifact | Checked Git blob |
| --- | --- |
| `Probability/CoordinateHeatBath.lean` | `9137baf2d1d3ea49bd8e1861d46dfb3fdf214af9` |
| `Tests/CoordinateHeatBath.lean` | `af7e9f5ea36dea6e7ee8c75f43df40d3fb71ec87` |
| Coordinate Frontier Cell | `0689dcae876874285ad363f9efadbe1abf5b7e1b` |
| Coordinate module card | `985e11e2bfd041d62ef4f1f7086c6aca98cc4541` |
| Worker packet | `01fcbfb80c776605f4812fc9223f8f35d688c281` |

The public module is under `AutoSamplingTheory/TechnicalLemmas/`. Its SHA-256 is
`b621e7142e4b3a69ec1d72b90befb7a638603cf06e806dd120734f776f0a5662`;
the test SHA-256 is
`368f172a931af8046156235ee15daad538c4d666ea434483f2731e9acdd6a13a`.

## Exact public contract and proof audit

The shared parameters are `{n : Nat}`, `X : Fin (n+1) -> Type u`, measurable
spaces on every `X j`, a finite measure `mu` on the dependent product, selected
index `i`, and `StandardBorelSpace (X i)` plus `Nonempty (X i)`.

- `heatBath X mu i` returns a kernel on that dependent product.
- `heatBath_isMarkovKernel` supplies its Markov instance.
- `heatBath_invariant` proves `(heatBath X mu i).Invariant mu`.
- `heatBath_ae_apply_eq` additionally takes `j`,
  `MeasurableSingletonClass (X j)`, `hji : j != i`, and input `x`; its conclusion
  is `forall-a.e. y` under the pointwise measure `heatBath X mu i x`, `y j = x j`.

Let `e = piFinSuccAbove X i` followed by `prodComm`. The split has
`(e x).1 k = x (i.succAbove k)` and `(e x).2 = x i`. The public construction
comaps the one-block kernel by `e` and maps its output by `e.symm`.
Independent Lean checking verified that its pointwise law is exactly

`((dirac (e x).1).prod (condDistrib snd fst (mu.map e) (e x).1)).map e.symm`.

Thus this is the actual selected-coordinate conditional update, not an
arbitrary invariant kernel. Both map directions carry genuine measurability;
the nonmeasurable `Kernel.map` zero fallback is not used. Invariance applies
the existing transport theorem to `e.symm` and cancels the pushed target in
the correct direction. Markovness and invariance are literal shared reuse.

For retention, `Fin.exists_succAbove_eq hji` identifies the retained index
without an off-by-one or heterogeneous-cast gap. The conditional law is a
probability measure at every retained input, providing the `SFinite` instance
needed by `Measure.map_fst_prod`. `ae_eq_dirac'` is applied to the measurable
evaluation map into `X j`; its singleton assumption concerns that codomain,
not the whole retained product. `ae_of_ae_map` pulls back through the first
projection. `ae_map_iff` uses the measurable coordinate-singleton event to
push through the inverse split. Finally, `hprod.mono` and `hcoord` explicitly
identify the original coordinate. The final `change` is definitional
normalization, not a new assumption or discarded obligation.

The public module has exactly the two needed shared imports, `HeatBath` and
`KernelTransport`. No new public split or marginal wrapper was introduced.
`KernelMixture` and `KernelInvariance` are consumer-test inputs, not proof
parents of the operational retention result.

## Consumer coverage and failure boundary

The committed tests exercise the public kernel, generic per-coordinate
singleton assumptions, simultaneous retention by finite intersections,
Fin 3 / Bool with middle site 1 retaining sites 0 and 2, a concrete
nonconstant input with zero target, and fixed finite mixtures with all finite
powers. The private marginal test expands the public definition; it does not
define another update. The coarse two-point retained-space test transports
only the selected Bool instances and asserts marginal-law/invariance results,
not unsupported literal retained equality.

The verifier additionally compiled a dependent three-coordinate family with
Boolean retained site 0, Boolean selected site 1, and a two-point indiscrete
retained site 2. Literal retention at site 0 compiled for arbitrary finite
targets and for zero target without any singleton assumption at site 2.
An independent empty-retained-space example also compiled Markovness and
zero-target invariance. These checks supplement, rather than replace, the
generic theorem and elaborated-signature audit.

Finite coordinate count does not imply finite state space. Retained spaces
need not be Standard Borel or nonempty; only the selected site needs those
conditions. Equality of retained marginal laws on a coarse sigma-algebra is
not silently upgraded to literal a.e. coordinate equality. The conditional
version is characterized only marginal-almost-everywhere, while the proved
retention assertion is pointwise in input. It supplies no feasible conditional
support or density normalization on null fibers.

## Source and publication boundary

The source-neutral classification and `conceptual_mirror_audit = none-found`
are accepted: this is literal equivalence/product/Dirac reuse, not a new
cross-domain analogy or a certified functor. Numbered-source semantic roundtrip
is not applicable to this explicit interface. The existing primary-page audit
was read as motivation; this verifier did not repeat or certify its source
inspection, copy-index witness, or proposed repair. The source issue remains
pending independent source/semantic review.

No numbered Gibbs/Glauber theorem, source copy-index repair, executable
conditional sampler, null-fiber support, Gibbs normalization, reversibility,
mixing, continuous-time domain, estimator guarantee, or cost bound is accepted.

This verifier owns only this report, the cell's independent evidence/status,
and this SAU's supported `VERIFIED` event. The observed sole stabilization
lane remains `ASTIS-20260908-KernelInvariance`. The final canonical root/site
gate, shared imports, Registry, graph/site truth, commit, stabilization and
remote publication remain the root owner's separate scope; no global gate
was run or represented as passed by this verifier.
