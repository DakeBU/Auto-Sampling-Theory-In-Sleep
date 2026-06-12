# Compiled Sublemma Inventory

This file separates reusable technical lemmas from SALD-specific theorem
content.  The current inventory is trusted only after:

```bash
python3 tools/astis.py check
```

Latest verified gate in this update: `ASTIS check passed`.

## ASTIS Technical Lemma Modules

| Module | Contents | Compile status |
|---|---|---|
| `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean` | Gaussian product coordinates, centered Gaussian mean, unit variance packaging | compiled |
| `AutoSamplingTheory/TechnicalLemmas/Taylor.lean` | Hessian-field to operator-norm bridges, iterated Frechet derivative bridge, quadratic-variation normalization algebra | compiled |
| `AutoSamplingTheory/TechnicalLemmas/Measure.lean` | `Measure.map` law/integral rewrites, dominated derivative-under-integral handoffs, conditional-distribution/named-law integral bridges | compiled |
| `AutoSamplingTheory/TechnicalLemmas/Variational.lean` | small DV one-sided consequences and LSI/FI density bookkeeping lemmas | compiled |
| `AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean` | aliases exposing reusable SALD-proved Gronwall, EM endpoint-law, and Brownian normalization bridges | compiled |
| `AutoSamplingTheory/TechnicalLemmas/Registry.lean` | searchable Lean-side memory registry with formalized and port-candidate entries | compiled |

## Source Modules Feeding The Memory

| Source module | What it already proves | Memory handling |
|---|---|---|
| `AutoSamplingTheory/Probability.lean` | generic measure map, law integral, conditional distribution, DV/LSI scalar bookkeeping | exposed through `TechnicalLemmas.Measure` and `TechnicalLemmas.Variational` |
| `AutoSamplingTheory/SALD.lean` | SALD-specific proof DAG, Gronwall scalar rewrites, discrete EM endpoint handoffs, Brownian/Ito normalization bridges | exposed selectively through `TechnicalLemmas.SALDExtracted`; still authoritative for SALD contribution proofs |
| `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean` and `Taylor.lean` | ASTIS-owned local ports/bridges inspired by Mathlib/SLT/SALD needs | directly callable by agents |

## Human Interpretation

- If a lemma is in `TechnicalLemmas/Gaussian.lean`, `Taylor.lean`,
  `Measure.lean`, or `Variational.lean`, treat it as reusable background
  infrastructure.
- If a lemma is in `TechnicalLemmas/SALDExtracted.lean`, treat it as a compiled
  SALD-derived proof block.  It is searchable memory, but it should not be
  cited as prior background without checking whether it is truly independent
  of SALD-specific notation.
- If a theorem appears only in `SLT_port_queue.jsonl`, it is not callable.  It
  must first become ASTIS-owned Lean code.

