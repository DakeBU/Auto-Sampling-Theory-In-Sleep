# Cross-domain program: sources, reusable foundations and conceptual transports

## Five peer source libraries, five coordinated routes

The controlling sources are Chewi's [Log-Concave Sampling](https://chewisinho.github.io/main.pdf) with its [official supplement](https://chewisinho.github.io/supp.pdf); [SampleWiki](https://samplewiki.morning-recipe-422a.workers.dev/) and its individually pinned papers; [Boumal](https://www.nicolasboumal.net/book/); Chewi's [Lectures on Optimization](https://arxiv.org/abs/2605.07006); and Chewi–Niles-Weed–Rigollet's [Statistical Optimal Transport](https://chewisinho.github.io/st_flour.pdf). SampleWiki is a frontier collection, not literally a textbook. These are equal navigation/source layers, not a claim of equal proof completion.

OT has eight chapters and appendices A/B. The machine-readable source map is `Libraries/StatisticalOptimalTransport/source-map.json`. Public PDF page = printed page + 6 in this audited copy. Its preface Figure 0.1 (printed p.4/PDF p.10) makes Chapter 1 prerequisite to 2/3/4/5/7, followed by 5→6 and 7→8. Dotted 2→3, 3→4, 5→7 are cross-references, not mandatory dependencies. We preserve this distinction.

## Recover omitted mathematics without changing the target

First search Samplinglib, Mathlib at the pinned revision, active shared cells and compatible formal upstreams (including Optlib/CvxLean when relevant). Record actual declaration names, types, imports, licenses and local compatibility checks. Existing source files are reuse candidates, not fresh compiler evidence.

If this does not settle a missing mathematical detail, follow the primary reference and then use a targeted authoritative textbook. These are starting shelves, not a ranking or exhaustive bibliography:

| Need | Background shelf | What must remain explicit |
|---|---|---|
| Convex/proximal/high-order optimisation | Bubeck, *Convex Optimization: Algorithms and Complexity* (2015); Beck, *First-Order Methods in Optimization* (2017); Nesterov, *Lectures on Convex Optimization* (2018) | Norms, oracle access, constants and extended-real conventions |
| Transport/weak metric gradient flows | Villani, *Topics in Optimal Transportation* (2003), *Optimal Transport: Old and New* (2009); Santambrogio, *Optimal Transport for Applied Mathematicians* (2015); Ambrosio–Gigli–Savaré, *Gradient Flows* (2008) | Moments, topology, absolute continuity, EDI/EVI and weak-solution contracts |
| Manifold analysis | Boumal; Lee's smooth/Riemannian manifold texts; Absil–Mahony–Sepulchre, *Optimization Algorithms on Matrix Manifolds* (2008) | Metric, tangent identification, retractions versus geodesics, curvature |
| Sampling/stochastic analysis | Bakry–Gentil–Ledoux, *Analysis and Geometry of Markov Diffusion Operators* (2014); Karatzas–Shreve; Revuz–Yor; Protter | Generator domain, integration by parts, domination, filtrations and representatives |
| Numerical SDE local error | Kloeden–Platen, *Numerical Solution of Stochastic Differential Equations* (1992), and the precise sampler paper | Strong versus weak order; moments; simulated stochastic integrals; target bias |
| Statistical testing and information bounds | Tsybakov, *Introduction to Nonparametric Estimation* (2009); Wainwright, *High-Dimensional Statistics* (2019), and exact oracle lower-bound papers | Statistical experiment, oracle transcript, adaptivity, costs and reduction direction |

A source-gap packet records primary edition/anchor, missing step, consulted theorem/page, hypotheses/conventions, and the adapter or proposed repair. Background mathematics never silently becomes a replacement source statement. False or incomplete source statements go through Semantic Fidelity & Repair. All sources and formal upstreams retain their licensing boundaries, including the existing ATLAS restrictions.

## Shared order is a partial order

`Libraries/cross-domain-program.json` is the canonical scheduled prerequisite plan. After contract alignment, convex analysis, measures/kernels and calculus can proceed independently. Convexity + couplings unlock basic OT; convexity + probability unlock Gibbs/KL tools. Only the flow-specific branch joins transport, entropy and differential geometry. Statistical estimation, metric geometry and high-order numerical analysis branch rather than waiting for all flows.

The first searches target existing `TechnicalLemmas/Analysis/ConvexSubgradient`, `Geometry/StrongConvexity`, `Measure/ProbabilityCouplingCompactness`, `Measure/TransportGluing`, `Measure/CouplingQuadraticIntegrability`, `Measure/DisplacementInterpolationCoupling`, `InformationTheory/FisherTransport`, and the two Taylor interfaces. These are **source-present search locations**, not an assertion that their types discharge the new targets. Pin exact matching declarations before classifying reuse/adapt/missing/out_of_scope.

Choose a dependency-ready theorem-sized advance by downstream reuse and realistic proof cost. Do not create a huge abstract interface before it has at least two genuine consumers. Keep one shared declaration for an exact match, a common core plus explicit adapters for a proved near match, and different statements separate.

## Functor Hypergraph is not the proof DAG

A presentation records its space/objects, objective or divergence, admissible hypotheses, solution notion and access model. A conceptual transport is a typed hyperedge

\[
e:(P_1,\ldots,P_m;H_e)\rightsquigarrow(Q_1,\ldots,Q_n).
\]

All input presentations and side hypotheses are required jointly; the SVG's individual incidence lines are not independent implications. The metadata retain entire input/output sets, assumption and conclusion maps, sources, failure boundaries and candidate formal substrates. A conceptual cycle is not a cyclic proof dependency.

The initial atlas has nine bridges: metric/gradient change; shared prox/RGO energy; deterministic maps to Dirac kernels; Wasserstein free-energy flows; MFLD entropy sandwich; transport duality; Taylor-to-sampling local accuracy; conditional oracle reductions; statistical-versus-computational budget comparison. Optimization is the organizing center, not a claim that all subjects are optimization on different spaces. Lower bounds additionally change the information model.

A genuine functor requires specified source/target categories, object and morphism assignments and proofs of identity/composition preservation. None of the present records has that certification. The Dirac embedding is a precise candidate: a measurable map T maps to K_T(x,·)=δ_T(x), with K_(S∘T)=K_T K_S when products act first T then S. A shared-energy span is **not** a functor merely because its two outputs have the same input.

The runtime preserves relation kinds and rejects a `Lean-certified` status without a certificate verifier. Future compression must preserve the original assumption/source boundary, primitive theorem support and an expandable certificate; no semantic resemblance can identify Lean propositions automatically. Human review of conceptual content remains separate from schema validation.

### Two central bridges

For a proper convex g and h>0, the proximal map and restricted Gaussian oracle use E_(y,h)(x)=g(x)+||x−y||²/(2h), but select an argmin and a Gibbs law respectively. Minimizer existence/uniqueness and positive finite normalization are separate. The RGO alone is not the complete proximal sampler or automatically a JKO step. Source: [Liu–Chewi (2026)](https://arxiv.org/abs/2605.12461v1).

For the [Nitanda–Wu–Suzuki (2022)](https://proceedings.mlr.press/v151/nitanda22a.html) setup, mixture-convex differentiable F and L=F+λ Ent give, under their minimizer/integrability contracts,

\[
\lambda\mathrm{KL}(\mu\Vert\mu_*)\leq L(\mu)-L(\mu_*)\leq\lambda\mathrm{KL}(\mu\Vert q_\mu),\qquad q_\mu\propto\exp(-\delta F(\mu)/\lambda).
\]

An **additional** uniform LSI for q_μ gives KL≤I/(2ρ). Combining with dL/dt=−λ²I yields the PL-type decay control. The lower sandwich controls growth in KL; W₂ quadratic growth needs a transport-entropy inequality for μ*, such as one implied by suitable additional LSI assumptions. Mixture convexity is not displacement convexity, and none of those extra conditions follows from adding entropy alone.

## High-order smoothness research route

The field is not empty: [Mou et al. (2021)](https://jmlr.org/papers/v22/20-576.html), [Shen–Lee (2019)](https://arxiv.org/abs/1909.05503v1), and [Dang et al. (2025)](https://arxiv.org/abs/2508.17545v1) already study different high-order/dynamic/discretization mechanisms. These are entry points, not an exhaustive novelty review.

Distinguish p: smoothness of V; q: derivative access; k: dynamical order; r: local/weak/strong numerical accuracy. Start with strongly convex smooth Euclidean potentials and a fixed oracle. Derive a usable local-error/moment/invariance interface, combine with an independently checked mixing or contraction result, and charge derivative/tensor/linear-algebra work. Vary only one contract dimension at a time before exploring manifolds or weaker curvature.

The proposed first reusable recurrence is e_(j+1)≤a e_j + C h^(r+1), giving e_N≤a^N e_0 + C h^(r+1)(1−a^N)/(1−a), when 0≤a<1. This is an elementary audit/reuse target, not new mathematics. For W₂ sampling, the real obligations are finite moments, exact-kernel invariance/contraction, and uniform control of one-step error along the numerical orbit. No r is inferred directly from p.

SampleWiki's lower-bound lane builds hard families, oracle transcripts, testing/indistinguishability and explicit reductions. It does not wait for the high-order integrator. The upper/lower lanes meet only under matched potential classes, derivative access, initial laws, accuracy metric, failure probability and work/parallel-depth costs. OT statistical observations n and sampling queries Q are not interchangeable. Use [Chatterji et al.](https://arxiv.org/abs/2002.00291) as an oracle-model entry point, not an automatic bound for another regime.

## Status and checks

This increment establishes source environments, route contracts, schema validation and an interactive conceptual atlas. It adds **no Lean proof closure**. All nine conceptual bridges are explicitly unverified as formal transports; mathematical source validity and eventual novelty still require theorem-level audits. The existing theorem-driven Harness, source roundtrip checks and independent stabilization gate remain authoritative.

```bash
python3 -m unittest tools.tests.test_cross_domain_program
python3 tools/astis_frontier_cells.py check
python3 website/scripts/build_site.py
python3 website/scripts/check_site.py
```
