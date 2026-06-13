# lower_3 Packet: Gaussian Quadratic Integrability

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker support packet for the Brownian/Ito frozen
backend under `sald.general_moving_target_discrete.em_interpolation_fp`.

## Exact Boundary

This packet narrows the cycle-196 `hNormalizedRemainderBoundInt` leaf.  Once
the source correspondence supplies

```lean
hNormalizedRemainderBoundDef :
  testRegular ->
    forall phi x i z,
      remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
```

and the normalized scalar coordinate law is rewritten to
`ProbabilityTheory.gaussianReal 0 1`, the remaining integrability fact is no
longer an open SALD-specific analysis claim.  It is the compiled ASTIS-owned
Gaussian lemma

```lean
AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero
```

with registry key `gaussian.quadratic-bound-integrable`.

The remaining source-cited theorem boundary after this lower_3 support packet
is exactly `hNormalizedRemainderBoundDef`, plus the already local normalized
coordinate-law bridge.  This packet does not reopen `hSourceHasHessian` or
`hSourceHessianBound`.

## Compiled Local Declaration

```lean
theorem AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero
    (v : NNReal) (C : Real) :
    MeasureTheory.Integrable
      (fun z : Real => C * z ^ 2)
      (ProbabilityTheory.gaussianReal 0 v)
```

The proof uses only Mathlib:

- `ProbabilityTheory.integrable_exp_mul_gaussianReal`
- `ProbabilityTheory.integrable_pow_of_integrable_exp_mul`
- `MeasureTheory.Integrable.const_mul`

No external SLT theorem was imported, called, queued, or marked formalized.

## Source Anchors

- `appendix.tex:958-970`
- `appendix.tex:983-996`
- `appendix.tex:1161-1170`
- `appendix.tex:1379-1387`

These anchors keep the normalized scalar Brownian coordinate and the weak-FP
diffusion prefactor separate; they do not supply the selected weak-test
Hessian source contract.

## Files Updated

- `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean`
- `AutoSamplingTheory/TechnicalLemmas/Registry.lean`
- `Tests/Basic.lean`
- `research-wiki/technical-lemmas/technical_lemma_registry.jsonl`
- `research-wiki/technical-lemma-memory/technical_lemma_registry.jsonl`
- `research-wiki/cited-results/SLT_reuse_audit.md`

## Gate

`python3 tools/astis.py check` passed.
