# ASTIS-CHEWI-001 Memory Index

Source: Sinho Chewi, `Log-Concave Sampling`.

Local PDF:
`/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Chewi-Log-Concave-Sampling/main.pdf`

This memory is for textbook-guided foundation building.  It should not record
paper-owned contribution claims.  Its job is to map Chewi chapters to reusable
Lean leaf families and to record the exact source or upstream theorem behind
each bottom-level assumption.

## Initial Chapter Map

| Chewi chapter/topic | Lean target |
|---|---|
| Langevin diffusion in continuous time | Markov semigroup, generator, invariant measure, Wasserstein gradient-flow leaves |
| Functional inequalities | PI, LSI, transport, concentration/isoperimetry, preservation leaves |
| Stochastic analysis topics | Ito, quadratic variation, Girsanov, Doob transform, Follmer drift, Schrodinger bridge |
| LMC analysis | interpolation, weak-FP, coupling, Girsanov, discretization-error leaves |
| Faster and high-accuracy samplers | HMC, underdamped, randomized midpoint, MALA, proximal sampler consumer layers |
| Renyi divergence | information-theory extension beyond current KL/DV leaves |
| Structured and non-log-concave sampling | later consumer layer after convex/log-concave foundation is stable |

## Active External Reference Additions

- `research-wiki/external-lean-libraries/lean-asymptotic-statistical-theory.md`
- `research-wiki/cited-results/hypothesis_disciplined_asymptotic_statistical_theory_2606_20642.md`

## Visualization Artifacts

- `research-wiki/lemma-dags/Chewi_log_concave_sampling_foundation.md`
- `docs/assets/chewi_log_concave_foundation.svg`
- `docs/assets/chewi_log_concave_foundation.png`
- `research-wiki/sampling-sde-library/roadmap/chewisinho_to_lean_tree.md`
- `research-wiki/retrieval-index/ASTIS-CHEWI-001.json`
