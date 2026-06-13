# Cycle 205 lower_3: Selected-Line Taylor API Scout

Packet classification: `rejected-wrapper-churn`.

Packet type: dynamic-leaf worker packet, technical-lemma/API scout.

Exact boundary checked:

```lean
hSelectedLineTaylorRawSplitDef :
  testRegular ->
    forall phi x i z,
      selectedTest phi (x + z • stdOrthonormalBasis Real E i) -
          selectedTest phi x =
        deriv
            (fun q : Real =>
              selectedTest phi (x + q • stdOrthonormalBasis Real E i)) 0 * z +
          ((2 : Real) *
            taylorCoeffWithin
              (fun q : Real =>
                selectedTest phi (x + q • stdOrthonormalBasis Real E i))
              2 Set.univ 0) * z ^ 2 +
          normalizedRemainder phi x i z
```

## Local Search Result

No isolated ASTIS technical lemma should be added in this lower_3 packet.
The middle packet allowed lower_3 action only if a concrete missing Mathlib or
ASTIS technical lemma appeared below this exact raw Taylor boundary.  The
available local bridge
`SALD.selectedWeakTestSelectedLineTaylorSplitDefOfRawTaylorAndTermDefs`
already consumes `hSelectedLineTaylorRawSplitDef`; it does not define or prove
that raw split.  Its proof only rewrites the raw derivative and
`taylorCoeffWithin` terms into the source linear and quadratic term names.

`AutoSamplingTheory/TechnicalLemmas/Taylor.lean` currently provides the
reusable Hessian/operator-norm and quadratic-variation packaging lemmas:

- `AutoSamplingTheory.TechnicalLemmas.Taylor.hessianOpNormOfSourceHessianField`
- `AutoSamplingTheory.TechnicalLemmas.Taylor.iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm`
- `AutoSamplingTheory.TechnicalLemmas.Taylor.stdOrthonormalBasisUnit`
- `AutoSamplingTheory.TechnicalLemmas.Taylor.quadraticVariationNormalizationOfCoeffDefAndVarianceOne`

None of these can identify the paper-specific
`normalizedRemainder phi x i z` with the selected scalar-line residual.  Adding
a wrapper around them would not discharge a supplied hypothesis or create a
smaller source-cited boundary.

## Source / Provenance Check

Source anchors checked for this packet:

- `appendix.tex:958-970`: discrete EM update and Brownian increment.
- `appendix.tex:983-996`: frozen EM interpolation.
- `appendix.tex:1161-1176`: normalized Gaussian coordinate representation.
- `appendix.tex:1379-1387`: weak Fokker--Planck consumer.

These anchors justify the Brownian coordinate line and its downstream weak-FP
use, but they do not display the raw one-dimensional Taylor equality above and
do not define `normalizedRemainder` as the residual after the first derivative
and `2 * taylorCoeffWithin ... 2 Set.univ 0` terms.

The external SLT reference
`SLT/GaussianPoincare/TaylorBound.lean` contains real one-dimensional Taylor
mean-value bounds such as `TaylorBound.taylor_order_one` and
`TaylorBound.taylor_mean_value_bound`.  They are reference-only here.  They do
not provide the SALD-specific `normalizedRemainder` source definition, are not
imported, and are not queued as callable ASTIS facts in this packet.

## lower_2 Interface

If lower_2 finds that local definitions do not reduce, the correct typed
feedback remains the middle-specified source-contract gap:

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

No `TechnicalLemmas` edit, no SLT import/call/queue, no source-Hessian work,
no VP score-Hessian substitution, and no endpoint/source-integrand naming
wrapper were introduced.
