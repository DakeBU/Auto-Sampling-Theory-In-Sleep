# Cycle 205 Lower_1 Route: Selected-Line Raw Taylor Split

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet.

Exact missing theorem boundary:

```lean
hSelectedLineTaylorRawSplitDef :
  testRegular ->
    forall phi x i z,
      selectedTest phi
          (x + z • (stdOrthonormalBasis Real E i)) -
          selectedTest phi x =
        deriv
            (fun q : Real =>
              selectedTest phi
                (x + q • (stdOrthonormalBasis Real E i))) 0 * z +
          ((2 : Real) *
            taylorCoeffWithin
              (fun q : Real =>
                selectedTest phi
                  (x + q • (stdOrthonormalBasis Real E i)))
              2 Set.univ 0) * z ^ 2 +
          normalizedRemainder phi x i z
```

This packet narrows the cycle-204 `hSourceTaylorIntegrandSelectedIncrementDef`
source naming gap to the raw scalar selected-line Taylor residual. It is not an
endpoint replay, a `sourceTaylorIntegrand` naming wrapper, a source-Hessian
re-audit, or a consumer wrapper for the weak-Fokker--Planck backend.

## Source Check

- `appendix.tex:958-970` gives the EM update and the Gaussian innovation
  `xi_k ~ N(0,I_d)`.
- `appendix.tex:983-996` defines the frozen interpolation
  `hat X_s = X_k^eta + ... + sigma_eta (W_s - W_{s_k})`.
- `appendix.tex:1161-1176` rewrites the frozen increment using
  `xi ~ N(0,I)` and bounds its second moment.
- `appendix.tex:1379-1387` invokes the Fokker--Planck equation associated with
  the frozen interpolation.

These anchors justify why the selected Brownian coordinate is a normalized
Gaussian scalar line and why the identity feeds the weak-FP backend, but they
do not state the displayed one-dimensional Taylor expansion and do not define
`normalizedRemainder phi x i z` as the residual after the first and second
Taylor terms. A targeted search of the original SALD paper sources used in this
task, excluding `sald_version_2.tex`, did not find a paper-level definition of
this `normalizedRemainder` field.

## Classical Route

Fix `testRegular`, `phi`, `x`, coordinate `i`, and scalar `z`. Set

```lean
g q := selectedTest phi (x + q • (stdOrthonormalBasis Real E i))
```

The desired identity is exactly

```lean
g z - g 0 =
  deriv g 0 * z +
  ((2 : Real) * taylorCoeffWithin g 2 Set.univ 0) * z ^ 2 +
  normalizedRemainder phi x i z
```

The proof is immediate if the source or local Lean definitions provide either
of the following strictly smaller facts:

```lean
hNormalizedRemainderResidualDef :
  testRegular ->
    forall phi x i z,
      normalizedRemainder phi x i z =
        selectedTest phi
            (x + z • (stdOrthonormalBasis Real E i)) -
          selectedTest phi x -
          deriv
            (fun q : Real =>
              selectedTest phi
                (x + q • (stdOrthonormalBasis Real E i))) 0 * z -
          ((2 : Real) *
            taylorCoeffWithin
              (fun q : Real =>
                selectedTest phi
                  (x + q • (stdOrthonormalBasis Real E i)))
              2 Set.univ 0) * z ^ 2
```

or the same equality oriented as the displayed Taylor expansion. Under either
orientation, lower_2 can prove the boundary by introducing the variables,
rewriting by that residual definition, and closing the real algebra by
`ring_nf` or `ring`.

No Gaussian integration lemma, DCT lemma, or SLT theorem is needed for this
pointwise identity. The adjacent compiled bridges that consume it are:

- `SALD.selectedWeakTestSelectedLineTaylorSplitDefOfRawTaylorAndTermDefs`
- `SALD.selectedWeakTestSourceTaylorIntegrandDefOfRawAndLineTaylorSplit`
- `SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralRawTaylorAndTermDefs`
- `SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs`
- `SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfScalarPushforwardRawTaylorAndDominatedRemainder`

The adjacent callable ASTIS technical lemma memory remains the existing
Brownian/Ito Gaussian law and integrability package, especially registry keys
`sald.brownian-normalization-bridges`,
`sald.remainder-meas-gaussian-law`, and
`sald.normalized-remainder-bound-int-quadratic`; none of those proves this raw
Taylor residual definition.

## Lower_2 Handoff

First inspect whether `normalizedRemainder` has a reducible local definition
or whether a source-backed residual field already exists under another name. If
yes, implement exactly one theorem proving `hSelectedLineTaylorRawSplitDef`
from that residual definition by rewriting and real algebra.

If no such definition unfolds, record the strictly smaller compiled obligation
instead of a wrapper:

```text
leaf=hSelectedLineTaylorRawSplitDef
error_class=source_contract_gap_missing_selected_line_taylor_raw_split_definition
needed_shape=testRegular -> forall phi x i z,
  selectedTest phi (x + z smul stdOrthonormalBasis Real E i) - selectedTest phi x =
    deriv (fun q => selectedTest phi (x + q smul stdOrthonormalBasis Real E i)) 0 * z +
    ((2 : Real) * taylorCoeffWithin (fun q => selectedTest phi (x + q smul stdOrthonormalBasis Real E i)) 2 Set.univ 0) * z ^ 2 +
    normalizedRemainder phi x i z
source_lines=appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1176;appendix.tex:1379-1387
blocked_by=no original-paper or local Lean definition was found identifying normalizedRemainder with the residual of the selected scalar Taylor expansion
packet_type=dynamic-leaf worker packet
```

Suggested names:

```lean
SALD.cycle205GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedLineTaylorRawSplitLower2Obligation
SALD.cycle205GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedLineTaylorRawSplitLower2Dag
```

