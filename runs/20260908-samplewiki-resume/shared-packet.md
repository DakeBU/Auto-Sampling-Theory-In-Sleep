# Shared kernel packet: local proof evidence

## Recovered work and mathematical delta

- PR #246: `KernelInvariance.invariant_pow` propagates a supplied one-step
  invariant law to all finite kernel powers. The measure, kernel and measurable
  state space are arbitrary; no Markov normalization is added to this theorem.
- `KernelInvariance.bind_pow_eq` is the measure-notation adapter, not a second
  mathematical leaf. Its focused consumer starts from reversibility with the
  Markov hypothesis required by Mathlib's reversibility-to-invariance theorem.
- PR #247: `ConditionalResampling.fst_compProd_condDistrib_snd_eq_self` adapts
  Mathlib disintegration to a product-state law. This is a reusable interface,
  not a new proof of disintegration or a Gibbs invariance theorem.

Namespaces begin `AutoSamplingTheory.TechnicalLemmas.Probability`.
The intended next real consumer is a state-to-state heat-bath update retaining
the first coordinate and drawing the second from its regular conditional law.

## Exact boundary

The conditional adapter assumes a finite joint measure and a nonempty Standard
Borel resampled space; the retained coordinate is merely measurable. The zero
measure is allowed. Conditional versions are only marginal-almost-everywhere;
no null-fiber support, pointwise density, positivity, irreducibility, uniqueness,
mixing, estimator-error or complexity assertion is made.

Kernel invariance under iteration does not prove convergence to the invariant
measure. Neither packet addresses general-state MH flux/Radon–Nikodym support,
finite-jump modified-log-Sobolev zero-density domains or SDE generator domains.

## Source and mirror classification

Source anchors and exact Mathlib provenance are in the two Frontier Cells.
These are source-neutral shared interfaces motivated by textbook consumers,
not closures of numbered textbook/paper theorems. Consequently semantic
round-trip is not applicable to source-theorem assimilation here; no source
theorem is marked assimilated. Independent review must still compare all actual
Lean assumptions with the contracts above.

Conceptual-mirror audit: **none found**. Reuse across MCMC and Discrete Sampling
is literal reuse of the same formal kernel interface, not a new conceptual
transport. Existing mirror/family metadata is left unchanged.

## Compiler evidence

- Lean 4.33.0, commit d8b18978322de05a8f3dba51ef03cf5461676c17.
- Mathlib db584cd6d46c92f209a44c0f1c829460d327499d.
- `lake build Tests.KernelInvariance`: passed, 1884 jobs.
- `lake build Tests.ConditionalResampling`: passed, 2973 jobs.
- Incoming API errors were repaired without changing the theorem statements:
  kernel-power result type annotation, removal of a spurious measurability
  argument, and explicit selection of the already supplied measurable space.
- Root build, independent mathematical verification and graph refresh are
  separate pending gates. Registry remains 393 at this checkpoint.
