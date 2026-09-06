# Optimisation Library

**Primary source:** Sinho Chewi, *Lectures on Optimization*, arXiv:2605.07006  
**Background lineage:** Sébastien Bubeck (2015), Amir Beck (2017), Yurii Nesterov (2018)  
**Formal upstreams:** [Optlib](https://github.com/optsuite/optlib), [CvxLean](https://github.com/verified-optimization/CvxLean)  
**Website:** `/libraries/optimisation/`

Chewi's public theorem-proof lecture notes are the source-facing formalization spine: 13 chapters plus Appendix A. The notes explicitly state that they are primarily based on Bubeck, Beck, and Nesterov; those works therefore remain important background and cross-check references, but they do not control the public chapter route.

Every source node records:

- the exact Chewi statement and source anchor;
- a matching Mathlib, Optlib, or CvxLean object when one exists;
- toolchain and convention differences;
- the required adapter, or a named missing theorem;
- its future position in the shared Samplinglib graph.

The proximal, mirror, stochastic, and convex-duality chapters are especially important shared-floor checkpoints with Log-Concave Sampling and SampleWiki.
