# Hypothesis-Disciplined Multi-Agent Automated Formalization of Asymptotic Statistical Theory

- Paper: https://arxiv.org/abs/2606.20642
- PDF: https://arxiv.org/pdf/2606.20642
- Repo: https://github.com/junwei-lu/Lean-Asymptotic-Statistical-Theory
- arXiv version observed: `2606.20642v1 [cs.AI]`, dated 3 Jun 2026.
- Local PDF:
  `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Hypothesis-Disciplined-Asymptotic-Statistical-Theory/2606.20642.pdf`
- Local repo:
  `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/Lean-Asymptotic-Statistical-Theory`
- Local repo commit observed:
  `8e7f22c88cc3280e898005b6445d94c581dd8b4d`

## Relevance To ASTIS

This paper is not a sampling theorem source.  Its relevance is the
hypothesis-disciplined formalization method: every theorem field and hypothesis
must be source-anchored, justified as a Lean encoding adapter, source-implied,
or rejected as an unsupported strengthening.  Use this directly against Chewi's
compressed textbook prose so that hidden measurability, integrability,
regularity, positivity, and representative-choice obligations become explicit
source contracts rather than silently strengthened theorem assumptions.

For `ASTIS-CHEWI-001`, use this as the audit standard for extracting Chewi
statements.  It is especially relevant because Chewi's notes intentionally
compress some analytic rigor into textbook prose.  ASTIS must expose those
contracts before claiming Lean progress.

## Concrete Repository Reuse

Potentially useful source files include:

- `AsymptoticStatistics/ForMathlib/PrekopaLeindler.lean`
- `AsymptoticStatistics/ForMathlib/Brunn1D.lean`
- `AsymptoticStatistics/ForMathlib/GaussianMGF.lean`
- `AsymptoticStatistics/ForMathlib/PiGaussian.lean`
- `AsymptoticStatistics/ForMathlib/PiWithDensity.lean`
- `AsymptoticStatistics/ForMathlib/GaussianShift.lean`
- `AsymptoticStatistics/ForMathlib/RnDerivSqrt.lean`
- `AsymptoticStatistics/ForMathlib/HellingerProduct.lean`
- `AsymptoticStatistics/ForMathlib/Prohorov.lean`
- `AsymptoticStatistics/ForMathlib/MarkovKernelProhorov.lean`
- `AsymptoticStatistics/ForMathlib/MeasurableSelection.lean`

These files are reference code only.  ASTIS declarations become callable only
after local porting or reproving under this repository's Lake build.
