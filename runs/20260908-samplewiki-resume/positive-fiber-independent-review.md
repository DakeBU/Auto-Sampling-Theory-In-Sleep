# Independent Lean review: positive-fiber coordinate heat-bath

Verifier: `positive_fiber_review`, independent of `positive_fiber_worker`.
Date: 2026-09-08. Advance: `ASTIS-20260908-CoordinateHeatBathConditional`.

Mathematical verdict: accepted as one compiled generic integration theorem at
`ce0a871f65382df2d5e5200f42af984f092af74b`. The theorem is mathematically/API sound
and passed independent Lean, edge and frozen-commit focused checks. This is not
acceptance of exact source fidelity. The canonical record gives a separate source
verdict `possible-source-error`, accepted as diagnosis only, with
`exact_source_fidelity = false`. After independently checking that canonical
evidence, this reviewer published the supported `VERIFIED` transition for the
generic exploratory theorem only and changed the cell to
`independently_verified`. Source assimilation and repair approval remain excluded.

## Exact theorem boundary

The single new public declaration is
`AutoSamplingTheory.TechnicalLemmas.Probability.CoordinateHeatBath.heatBath_eq_cond`.
It has parameters `{n : Nat}`, a dependent family `X : Fin (n+1) -> Type u`,
measurable spaces on each coordinate, a finite measure `mu` on the full product,
selected index `i`, `StandardBorelSpace (X i)` and `Nonempty (X i)`, and
`MeasurableSingletonClass` on the native retained product
`(j : Fin n) -> X (i.succAbove j)`. For an input `x`, the sole mass assumption is
`mu {y | retained_i y = retained_i x} != 0`. The conclusion is exact equality of
the existing pointwise measure `heatBath X mu i x` with `cond mu` on that fiber.

This is not a new kernel definition or an assumed conditional-law wrapper.
There is no probability-target assumption, no finite-state/countable-state
assumption, no Standard Borel assumption on retained spaces, and no extra global
coordinate Nonempty assumption. Finiteness excludes infinite fiber mass. The
native retained singleton assumption makes the fiber measurable and supports
the pinned atomic conditional-law API; it is not asserted to be logically the
weakest possible pointwise hypothesis.

## Proof/API audit

The coordinate equivalence is the existing `piFinSuccAbove` followed by
`prodComm`; its first component retains exactly `i.succAbove j`, and its second
component selects exactly `i`. The proof transports the already-defined
`HeatBath.heatBathSnd` law back using the inverse equivalence.

Every `Measure.map` evaluation and kernel output map uses genuine measurability:
the split, inverse split, first/second projections and fixed-retained insertion.
No nonmeasurable-map zero fallback is used. Two map evaluations identify the
first marginal atom with the original retained fiber, transferring the nonzero
mass assumption without adding an unproved denominator condition.

`condDistrib_apply_of_ne_zero` is reused directly from pinned Mathlib. Its selected
map argument is `measurable_snd`; it does not require an invented extra
measurability parameter. `dirac_prod` and map composition evaluate the actual
output law. The pair of projections simplifies to the identity pushforward.
The numerator is pulled back through the coordinate equivalence. The final
set equivalence is checked pointwise: on equal retained first components,
`e.symm ((e x).1, (e y).2) = y`. This gives exactly intersection with the retained
fiber, in the same normalization convention as `cond_apply'`.

The two public imports are the existing coordinate module and Mathlib's
conditional-probability module. There is one new integration theorem, not a
separate atomic conditional-law leaf or duplicate coordinate interface.

## Independent checks completed before final commit

All Lean/Lake calls set `ELAN_TOOLCHAIN=leanprover/lean4:v4.33.0` and
`LEAN_NUM_THREADS=1`. Checks used the original physical D: repository/cache.
Mathlib revision was independently read as
`db584cd6d46c92f209a44c0f1c829460d327499d`.

- Fresh direct public check:
  `lake env lean AutoSamplingTheory/TechnicalLemmas/Probability/CoordinateHeatBathConditional.lean`
  passed, exit 0.
- Fresh independent scratch check:
  `lake env lean .astis/positive-fiber-review/Independent.lean` passed, exit 0.
  This checked the elaborated public signature, the pinned atomic-law and
  conditional-evaluation signatures, and the examples below.
- `#print axioms` for the public theorem reports only `propext`,
  `Classical.choice` and `Quot.sound`, not `sorryAx` or a custom axiom.
- Scoped textual scans of the public/the-test files found no `sorry`, `admit`,
  custom `axiom`, `Prop := True`, or `:= trivial` fake closure.
- The independently checked public-file SHA-256 is
  `f46810ed241b0883d33b0a8db517fe88646ebd97fdf4df670ce766f9b0d83174`.

The verifier scratch first encountered only local test-elaboration issues
(unqualified `cond`, a data-valued finite case split, and contradiction syntax).
These were fixed locally; they were not theorem failures, hidden hypotheses, or
changes to worker-owned files. The final scratch check is warning-free.

The exact independent Lean source is preserved at the ignored path above. A
verbatim successful compiler-output excerpt is retained below; the other output
consists only of the checked API signatures, with no errors or warnings:

```text
'AutoSamplingTheory.TechnicalLemmas.Probability.CoordinateHeatBath.heatBath_eq_cond' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
```

## Additional edge coverage

1. The public signature is consumed independently with the right side expanded
   to inverse fiber mass times target restriction. This confirms the actual
   equality and parameter boundary rather than only rechecking a theorem name.
2. With `n = 0`, the retained tuple is empty. On `Fin 1 -> Nat`, for any finite
   target of nonzero total mass, the actual kernel equals
   `(mu univ)^(-1) • mu`. Thus the theorem includes an infinite selected space,
   does not accidentally require retained coordinates, and correctly normalizes
   an arbitrary finite target rather than assuming total mass one.
3. A heterogeneous two-coordinate family with selected `Nat` and an arbitrary
   retained type `R` compiles. Only `MeasurableSpace R` and
   `MeasurableSingletonClass R` are supplied. Neither `StandardBorelSpace R` nor
   `Nonempty R` is present as a generic assumption.
4. Independently of the worker's Boolean numeric suite, on `Fin 2 -> Nat` the
   target is a Dirac probability at the all-zero input, while the chosen input
   is all-one. The retained fiber has target mass zero. Lean proves both that
   the target is nonzero and that the actual kernel differs from `cond` on that
   fiber: the former has mass one, while totalized normalized restriction is
   zero. Hence removing the positive-fiber condition is genuinely false even
   for a nonzero probability target, not merely ill-defined informal notation.

## Frozen-commit gate

After the worker stopped, the verifier independently confirmed HEAD and all four
worker artifacts against `ce0a871f65382df2d5e5200f42af984f092af74b`.
Unfiltered current-file Git hashes exactly matched the committed blobs:

| Artifact | Verified Git blob |
| --- | --- |
| Public theorem module | `617c9d00e586d4a763522ac5d9328487d11b0f23` |
| Focused test module | `c318888173a2502077c0ba32f0e93a13b3b27a7e` |
| Positive-fiber Frontier Cell | `5d2b0236b2e6a371761d4c6f669fba6ad0f97690` |
| Worker packet | `ae288c6e3bab0296d6a359516d1de0d20aa21a19` |

The final test SHA-256 is
`eb2b13beb9f3e68e682b9016b5665e6a30f422d925b6282770f463b261118a1d`.
The final public SHA-256 is unchanged from the direct check and independent
signature/edge check above.

The requested single final `lake build Tests.CoordinateHeatBathConditional`
passed with exit 0, reporting `Build completed successfully (2981 jobs)`.
It replayed the frozen focused target and its correct signature/axiom output;
this is not represented as recompiling unchanged sources. Earlier fresh direct
public and independent scratch checks apply to the same public-file bytes.
The final scoped fake-closure scan and `git diff --check` were clean.

The final focused source was reread. It independently normalizes the three-atom
joint probability, identifies the selected-middle-coordinate fiber with mass
`2/3`, obtains actual transitions `3/4` and `1/4`, checks a retained-coordinate
mismatch has transition zero, derives denominator positivity from a supported
starting atom by inclusion, proves the nonzero-target null-fiber mismatch, and
consumes the same actual kernel in existing fixed-mixture/finite-power invariance.
The private singleton formula is tested reuse of the public theorem, not another
public kernel or separately counted leaf. No mathematical/API objection remains.

## Source, integration and ownership boundary

This reviewer accepts the compiled generic Lean claim at the frozen commit.
Source fidelity is a separate fresh blind/source review owned by the coordinator.
The Discrete Sampling copy-index discrepancy, its proposed repair and full source
algorithm are not approved here. Neither the MCMC nor Discrete Sampling source
is assimilated merely by the successful Lean checks. The canonical independent
source outcome is diagnosis-only `possible-source-error`, with conclusion and
positive-fiber differences blocking exact fidelity and domain/quantifiers under
review. Its separately generated uniform-square counterexample and unapproved
repair belong to that source audit, not to this Lean review.

The verifier subsequently read the canonical audit
`ASTIS-RT-20260908-PositiveFiberUpdate` and independently ran
`python tools/astis_semantic_roundtrip.py check`: passed, 1 audit, 0 repairs.
The recorded distinct formalizer, decoder and source-review identities remain
separate from this Lean review. The source-review result file SHA-256 matches
the canonical run binding:
`d8a6680eb14cb951db6bc384a0fa0dbd26a6acbf091126c774e94d0889e96480`.
The full seven-slot comparison records blocking conclusion and assumption
differences and review-level domain/quantifier differences. Its accepted status
explicitly means acceptance of the discrepancy diagnosis, not exact source
fidelity or a repair. The absence of repair proposals is preserved.

No uniform scan, feasibility of arbitrary ambient input, zero-fiber support,
Gibbs normalization, reversibility, convergence, estimator guarantee or sampling
cost is proved. Existing mixture/power laws remain consumer reuse, not new leaves.

This report, ignored verifier scratch, and only the cell's status and string-valued
independent-verification evidence have been edited. The verifier then published
the one authorized `PROVED_LOCAL -> VERIFIED` event through
`tools.astis_advance.transition_advance`, with this report, frozen commit, focused
gate, fake-closure scan and explicit blocking source residuals in the evidence.
`python tools/astis_frontier_cells.py check` passed with 8 registered cells after
the cell evidence edit. Scoped `git diff --check` found no whitespace errors.
Worker Lean files,
Registry, shared imports, root tests, semantic registry, source maps and remote
state are outside this review's mutation scope. Frozen-commit pinning and final
focused verification and canonical source-semantic schema-gate checks are complete.
Exact source alignment, any repair, integration and the sole stabilization lane
remain separate; no global/root gate is represented as passed by this verifier.
