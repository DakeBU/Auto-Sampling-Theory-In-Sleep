# Discrete Sampling

First-class finite-state source library, not Euler discretization of continuous sampling.

Primary monograph: Zongchen Chen, Daniel Štefankovič, Eric Vigoda,
*Spectral Independence and Local-to-Global Techniques for Optimal Mixing of Markov Chains*,
[arXiv:2307.13826v4](https://arxiv.org/abs/2307.13826v4).
`source-map.json` pins the downloaded 100-page PDF and its 12 sections/72 subsection anchors.
The source mainly develops hard-core and matroid examples; §12 surveys Ising and colouring
extensions without proofs. LPW supplies classical mixing background; Duminil-Copin supplies
Ising/Potts model background. Neither is silently substituted for the primary theorem.

Read [the contributor protocol](../../docs/discrete-sampling-protocol.md),
`../frontloaded-shared-spine.json`, `../shared-foundations.yml`,
`../../website/content/graph_memory_index.json` and `../conceptual-mirror-protocol.json`.
Use `.agents/prompts/discrete-sampling.md` and route `discrete-sampling`.
Read the [focused reuse audit](reuse-audit.md) and [machine-readable entries](reuse-audit.json)
before a finite-kernel/MLSI adapter; the zero-density domain obstruction must not be skipped.

All chapter pages are scaffolds. The four seeded conceptual bridges are candidates,
not independently reviewed transfers or certified Lean functors. An existing compiled
continuous-sampling lemma is a reuse-search lead, not evidence of a discrete adapter.
