# Cycle 205 Middle Packet: Selected-Line Raw Taylor Split

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

This is strictly below the accepted cycle-204 boundary
`hSourceTaylorIntegrandSelectedIncrementDef`: cycle 188 already compiled
`SALD.selectedWeakTestSelectedLineTaylorSplitDefOfRawTaylorAndTermDefs`, and
cycle 189/192/193 compiled bridges reuse that raw split to feed
`hBrownianCoordinateGeneratorTaylorIntegralDef` and the Taylor moment
consumer.  The remaining question is the source-backed one-dimensional Taylor
identity for the selected scalar line, not another endpoint or source-integrand
naming wrapper.

Source anchors checked:

- `appendix.tex:958-970`: discrete EM update and Brownian increment.
- `appendix.tex:983-996`: frozen interpolation definition.
- `appendix.tex:1161-1176`: normalized Gaussian coordinate representation.
- `appendix.tex:1379-1387`: weak Fokker--Planck consumer.

Local ASTIS/Mathlib ingredients already available:

- `SALD.selectedWeakTestSelectedLineTaylorSplitDefOfRawTaylorAndTermDefs`
- `SALD.selectedWeakTestSourceTaylorIntegrandDefOfRawAndLineTaylorSplit`
- `SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralRawTaylorAndTermDefs`
- `SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs`
- `SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfScalarPushforwardRawTaylorAndDominatedRemainder`
- Mathlib notation/API already imported in `AutoSamplingTheory/SALD.lean`: `deriv`, `taylorCoeffWithin`, `Set.univ`
- Callable technical lemma memory for adjacent Brownian/Ito backend:
  `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`,
  `AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero`

No external SLT theorem is callable or queued by this packet.  The SLT Taylor
queue remains only a port candidate until an ASTIS-owned compiled declaration
is added.

## lower_1 Task

Write exactly one natural-language route for `hSelectedLineTaylorRawSplitDef`.
Use the scalar line

```lean
fun q : Real =>
  selectedTest phi (x + q • (stdOrthonormalBasis Real E i))
```

and check whether the original SALD source states either:

1. the displayed raw one-dimensional Taylor expansion with the first derivative
   term, the `2 * taylorCoeffWithin ... 2 Set.univ 0` quadratic term, and
   `normalizedRemainder`; or
2. a definition of `normalizedRemainder phi x i z` as the residual after those
   two Taylor terms.

If the source only implies this via an unstated Taylor theorem plus an
unstated residual definition, report that as the exact source-contract gap.
Do not reopen `hSourceHasHessian`, `hSourceHessianBound`, endpoint definitions,
sourceTaylorIntegrand naming, VP score-Hessian regularity, or `testRegular`
repackaging.

## lower_2 Task

Inspect whether the local Lean names in the boundary unfold enough to prove the
identity by definitional rewriting.  If they do, implement exactly one
ASTIS-owned theorem for `hSelectedLineTaylorRawSplitDef`.

If they do not, record a compiled `ProofObligation`/DAG with typed verifier
feedback:

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
```

Suggested obligation names if the source gap remains:

```lean
SALD.cycle205GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedLineTaylorRawSplitLower2Obligation
SALD.cycle205GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedLineTaylorRawSplitLower2Dag
```

## lower_3 Task

Do not add a wrapper.  Only act if lower_2 reports a concrete missing Mathlib or
ASTIS technical lemma below this exact raw Taylor boundary.  A possible future
technical target is a local ASTIS-owned Taylor-residual theorem, but it is not
callable until compiled locally and it cannot replace the missing source
definition of `normalizedRemainder`.
