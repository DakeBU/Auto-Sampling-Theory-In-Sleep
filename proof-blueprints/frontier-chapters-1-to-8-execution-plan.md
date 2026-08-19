# ASTIS Chapters 1–8 execution plan

## Purpose

This document is the execution contract for formalizing Sinho Chewi's *Log-Concave Sampling* through the end of Chapter 8 while building the shortest reusable Lean graph for SampleWiki/frontier sampling theorems.

It replaces a naive chapter-by-chapter queue with two synchronized lanes:

1. **Frontier spine lane.** Close the shared analytic/stochastic nodes that unlock many later results, then reach the Chapter 8 proximal-sampler contraction chain as early as dependencies allow.
2. **Coverage lane.** Backfill every source definition/theorem/proof route in Chapters 1–8 without duplicating APIs or weakening the source statement.

The lanes share one public-reader contract and one Lean evidence contract. A result is not considered complete merely because a prose page exists or because an algebraic shadow of the theorem compiles.

---

## Non-negotiable acceptance contract for every Chewi source item

### Mathematical textbook surface

With Lean, hidden assumptions and foundation references collapsed, the canonical page must still work as a self-contained textbook.

The visible order is:

1. Chewi result kind and number;
2. exact mathematical statement in displayed notation;
3. short explanatory prose only after the formula;
4. source proof / derivation in equations, collapsed by default when the source contains a proof;
5. if Chewi omits a proof or technical detail, say so explicitly and label any extra proof as an **ASTIS formal expansion** rather than a Chewi proof;
6. Lean correspondence, hidden hypotheses and classical foundation references remain secondary disclosures.

No source result may be represented only by a large prose heading such as “the squared L2 norm is finite”. The mathematical statement itself is the primary object.

### Lean evidence

A source item may be marked `compiled` only when:

- the source-facing theorem/definition exists at the intended mathematical strength;
- all nontrivial assumptions are explicit in the Lean type;
- the declaration has no `sorry`, `admit`, placeholder axiom or semantic stub;
- a focused test imports/checks or instantiates the declaration;
- `lake build` and the ASTIS consistency gate pass;
- the source-correspondence row points to the actual declaration and does not claim a stronger theorem than Lean proves;
- its outgoing dependency/consumer edges appear in the Underlying Lean Graph.

A useful algebraic leaf may be merged earlier, but it stays a technical node until the source-facing assembly theorem compiles.

---

# Lane A — Frontier spine

The high-reuse spine is

```text
Chapter 1.1 stochastic calculus
  -> concrete SDE / Markov law bridge
  -> Chapter 1.2 KL/Fisher dissipation
  -> Chapter 1.3–1.4 W2 geometry + KL geodesic first variation
  -> Chapter 2 functional-inequality/curvature leaves needed by the target route
  -> Chapter 3 path-space / time-reversal leaves needed by the target route
  -> Chapter 8.1 proximal joint law and conditional kernels
  -> Chapter 8.3 simultaneous-flow / time-reversal contraction
  -> Chapter 8.4 log-concave convergence
  -> SampleWiki / frontier sampling theorem assemblies
```

Chapters 4–7 are not skipped; their reusable kernels and error-composition theorems are developed in the coverage lane and promoted into the spine whenever Chapter 8 or a frontier theorem consumes them.

---

# Phase A0 — Finish Chapter 1.1: stochastic calculus and SDE existence

**Status: active.** Most Itô-integration/localization infrastructure is already compiled. The remaining source-critical chain is quadratic variation -> Itô formula -> SDE existence/uniqueness.

## A0.1 Brownian quadratic variation

Already compiled on main:

- finite-grid centered quadratic-variation expectation identities;
- centered Gaussian fourth moment
  \[
  X\sim N(0,v)\quad\Longrightarrow\quad \mathbb E[X^4]=3v^2.
  \]

Active packets:

1. one-cell L2 identity
   \[
   \mathbb E\left[((B_t-B_s)^2-(t-s))^2\right]=2(t-s)^2;
   \]
2. distinct-cell orthogonality
   \[
   i\ne j\Longrightarrow \mathbb E[Y_iY_j]=0,
   \qquad Y_i=(\Delta B_i)^2-\Delta t_i;
   \]
3. exact finite-grid identity
   \[
   \mathbb E\left[\left(\sum_iY_i\right)^2\right]
   =2\sum_i(\Delta t_i)^2;
   \]
4. deterministic mesh estimate
   \[
   \sum_i(\Delta t_i)^2\le |\Pi|\sum_i\Delta t_i;
   \]
5. dyadic mesh limit using the existing `FiniteTimeGrid.dyadicMesh_tendsto_zero`;
6. vector cross variation
   \[
   [B^a,B^b]_t=\delta_{ab}t.
   \]

**Exit theorem:** a source-shaped Brownian quadratic-variation theorem in the convergence mode used by the Chapter 1.1 Itô proof.

## A0.2 Itô formula

Target source theorem: Chewi Theorem 1.1.19 and its immediate corollaries.

Proof graph:

```text
finite partition
  -> second-order Taylor expansion on each cell
  -> telescope zeroth-order terms
  -> first-order Brownian terms -> Itô integral
  -> drift terms -> ordinary time integral
  -> quadratic Brownian terms -> quadratic/cross variation
  -> Taylor remainder -> 0
  -> finite-dimensional coordinate assembly
```

Required reusable leaves:

- second-order Fréchet Taylor formula with quantitative remainder on a compact path range;
- continuity/uniform-continuity control of the Hessian along an a.s. continuous path;
- finite-grid stochastic-sum convergence in L2/probability as required by the source proof;
- matrix/Hessian contraction identity
  \[
  \frac12\sum_{a,b}(\sigma\sigma^\top)_{ab}\,\partial_{ab}f;
  \]
- source-facing finite-dimensional Itô formula with exact regularity assumptions.

## A0.3 SDE existence and uniqueness — Chewi Theorem 1.1.22

Do not assume a solution in the theorem used to construct later Langevin kernels.

Construction route:

- Picard iterates on a finite horizon;
- Lipschitz drift/diffusion estimate using deterministic integral bounds + Itô isometry/Doob L2;
- factorial/geometric convergence of iterates;
- adapted continuous limiting process;
- pass drift and stochastic integrals to the limit;
- pathwise uniqueness via an L2 difference estimate and continuous Grönwall;
- concatenate finite horizons if the source theorem is global under global Lipschitz assumptions.

**Exit nodes:**

- strong solution constructor;
- pathwise uniqueness;
- measurable dependence on the initial condition sufficient for the Markov-kernel construction.

---

# Phase A1 — Chapter 1.2: Markov evolution, generator, KL and Fisher information

**Status: active.** Canonical transition-kernel algebra and measure evolution are already compiled; concrete SDE-to-kernel and entropy dissipation remain central blockers.

## A1.1 SDE law -> transition-kernel bridge

Build a single canonical API, not a second semigroup hierarchy:

\[
K_t(x,A)=\mathbb P(X_t^x\in A),\qquad
P_tf(x)=\int f(y)K_t(x,dy).
\]

Prove:

- measurability in the starting point;
- Markov property / restart;
- Chapman–Kolmogorov;
- law evolution agrees with the already-merged `evolveMeasure`;
- Feller property and strong continuity on the chosen concrete observable space when the source route requires them.

## A1.2 Relative Fisher information

Use the regularity-aware layer

\[
I(q,r)=\int q(x)\|\nabla r(x)\|^2\,dx,
\]

where the RN/log-density-ratio representative is a separate theorem obligation.

Next bridge:

\[
r=\log\frac{d\mu}{d\pi}
\quad\Longrightarrow\quad
I(\mu\|\pi)=\int\left\|\nabla\log\frac{d\mu}{d\pi}\right\|^2d\mu.
\]

Explicit obligations:

- absolute continuity and RN representative;
- positivity/zero-density convention;
- differentiability/Sobolev representative;
- integrability of the score energy;
- representative independence at the gradient level.

## A1.3 KL/Fisher dissipation

For the source normalization actually used by the Langevin/heat flow, prove the exact coefficient in

\[
\frac d{dt}\mathrm{KL}(\mu_t\|\pi)
=-c_{\rm diff}\,I(\mu_t\|\pi).
\]

The proof must expose:

- differentiating under the integral;
- Fokker–Planck/weak generator identity;
- mass derivative vanishes;
- weighted integration by parts;
- boundary/cutoff passage;
- integrability/dominating fields.

Do not encode the dissipation equality as an assumption in any theorem that claims to prove it.

---

# Phase A2 — Chapters 1.3–1.4: Wasserstein geometry and the Fisher–transport bridge

**Status: foundations partial/compiled.** Couplings, W2 value, displacement interpolation and abstract geodesic-convexity leaves exist; the full analytic first-variation bridge is not yet closed.

## A2.1 W2 foundations

Close the source routes needed by Chapter 8:

- probability measures with finite second moment;
- coupling set and quadratic cost;
- W2 metric properties on the intended space;
- optimal-coupling existence in finite-dimensional Euclidean space;
- displacement interpolation as a constant-speed W2 geodesic.

## A2.2 KL along displacement geodesics

For a suitable geodesic \(\mu_t\) from \(\mu\) to \(\pi\), formalize the source first variation rather than only abstract convexity algebra.

Target estimate:

\[
\mathrm{KL}(\mu\|\pi)
\le
\left|\frac d{dt}\mathrm{KL}(\mu_t\|\pi)\Big|_{t=0^+}\right|.
\]

Then identify the derivative with a score/transport pairing and use Cauchy–Schwarz:

\[
\mathrm{KL}(\mu\|\pi)
\le
\sqrt{I(\mu\|\pi)}\,W_2(\mu,\pi),
\]

hence

\[
\boxed{\mathrm{KL}(\mu\|\pi)^2
\le I(\mu\|\pi)W_2(\mu,\pi)^2.}
\]

This analytic theorem feeds the already-existing pure algebra in `InformationTheory/FisherTransport.lean`.

---

# Phase A3 — Chapter 2: functional inequalities needed by frontier contraction

**Chapter title:** Functional Inequalities.

Formalize all Chapter 2 source items in the coverage lane, but prioritize these shared nodes first.

## A3.1 Canonical measure-level PI/LSI contracts

Use source-normalized definitions:

\[
\operatorname{Var}_\pi(f)
\le C_{\rm PI}\int\|\nabla f\|^2d\pi,
\]

and

\[
\operatorname{Ent}_\pi(g)
\le \frac{C_{\rm LSI}}2
\int \frac{\|\nabla g\|^2}{g}\,d\pi
\]

(or the source's equivalent normalized form).

Explicitly bridge these with the generator/carré-du-champ versions already in the library.

## A3.2 Bakry–Émery

Close the reusable chain

\[
\Gamma_2(f,f)\ge \alpha\Gamma(f,f)
\Longrightarrow
\text{gradient decay}
\Longrightarrow
\text{PI/LSI with tracked constants}.
\]

For Langevin,

\[
\nabla^2V\succeq \alpha I
\Longrightarrow
\Gamma_2(f,f)\ge\alpha\Gamma(f,f).
\]

This must be connected to the concrete generator/core, not only an abstract real-valued algebraic predicate.

## A3.3 Preservation operations

Prioritize operations consumed by Chapters 4–8/frontier cases:

- tensorization;
- bounded perturbation/Holley–Stroock style transfer;
- Lipschitz pushforward where used;
- conditioning/restricted Gaussian laws used by the RGO.

Later fill concentration, isoperimetry, manifold and discrete-time sections in source order.

---

# Phase A4 — Chapter 3: stochastic-analysis nodes reused by Chapters 4, 6 and 8

**Chapter title:** Additional Topics in Stochastic Analysis.

## A4.1 Section 3.1 quadratic variation

Reuse the Chapter 1.1 Brownian qv construction. Do not create a duplicate qv API.

Add the source's general continuous-semimartingale qv/covariation statements only after the Brownian/Itô core is stable.

## A4.2 Girsanov path-space theorem

Upgrade existing algebra/cylinder leaves to the actual source theorem:

\[
Z_T
=
\exp\!\left(
\int_0^T\langle u_t,dB_t\rangle
-\frac12\int_0^T\|u_t\|^2dt
\right),
\qquad d\mathbb Q=Z_Td\mathbb P.
\]

Prove under explicit Novikov/Kazamaki-style hypotheses used by the book:

- stochastic exponential is a true martingale;
- normalization \(\mathbb E Z_T=1\);
- drift-shifted process is Brownian under the new law;
- path-law KL identity/upper bound used by LMC comparisons.

## A4.3 Doob transform, Föllmer drift, Schrödinger bridge

Build one positive space-time `h` transform API:

\[
L^hf=h^{-1}L(hf)-h^{-1}fLh
\]

in the time-homogeneous case, then the time-dependent counterpart needed by the source.

Connect:

```text
Doob h-transform
  -> conditioned/tilted transition kernels
  -> Föllmer drift
  -> endpoint-constrained entropy minimization
  -> Schrödinger bridge
```

These nodes also support later generative/frontier examples and should not be isolated chapter-local proofs.

---

# Phase A5 — Chapter 8 early spine: proximal sampler before full 4–7 backfill

Once A0–A4 shared dependencies required by the proximal proof are compiled, start Chapter 8 immediately rather than waiting for complete Chapters 4–7 coverage.

## A5.1 Section 8.1 proximal augmented law

For step parameter \(\eta>0\), define the joint law

\[
\rho(dx,dy)
\propto
\pi(dx)\exp\!\left(-\frac{\|x-y\|^2}{2\eta}\right)dy.
\]

Prove:

- measurable nonnegative joint density;
- finite positive normalizer;
- x-marginal is \(\pi\) after Gaussian integration;
- explicit `Y|X=x` Gaussian kernel;
- explicit `X|Y=y` restricted-Gaussian/proximal kernel;
- both conditional kernels are probability kernels;
- alternating Gibbs kernel preserves \(\pi\).

This becomes the canonical RGO kernel API used in 8.2–8.6 and SampleWiki.

## A5.2 Section 8.2 strongly log-concave contraction

Formalize the exact source contraction metric and constants. Reuse Chapter 2 strong convexity/functional inequalities rather than restating them as proximal assumptions.

## A5.3 Section 8.3 simultaneous flow and time reversal

This is a frontier anchor. Required graph nodes include:

- simultaneous heat/Langevin flow coupling of the relevant conditional laws;
- law differentiation and KL/Fisher dissipation from A1;
- W2 evolution/contraction from A2;
- time-reversal kernel/law identity;
- the source theorem commonly referenced in ASTIS planning as **Chewi 8.3.1**.

No time-reversal theorem may hide existence of reversed conditional densities or score fields.

## A5.4 Section 8.4 log-concave convergence

Assemble

\[
\mathrm{KL}^2\le I W_2^2,
\qquad
\frac d{dt}\mathrm{KL}=-c_{\rm diff}I,
\]

with the Chapter 8 flow/radius control to obtain the reciprocal-KL differential estimate. The pure real algebra for this step already exists in `InformationTheory/FisherTransport.lean`; the work here is to supply its analytic hypotheses from real measure objects.

Close the source theorem commonly referenced in ASTIS planning as **Chewi 8.4.1** before declaring the frontier proximal route complete.

## A5.5 Sections 8.5–8.6

- functional-inequality convergence: consume the canonical Chapter 2 PI/LSI interfaces;
- RGO implementations: define exact vs approximate oracle contracts explicitly;
- prove error propagation for approximate conditionals/kernels;
- retain all normalization, accuracy and query-complexity assumptions in source-facing theorem statements.

---

# Lane B — Full Chapter 1–8 coverage

Lane B follows source order within each chapter but reuses Lane A nodes. Its role is to ensure ASTIS is a real textbook/library rather than a frontier-only proof script.

## Chapter 1 — The Langevin Diffusion in Continuous Time

### 1.1

Close every stochastic-calculus definition/display/theorem, with A0 as the final blocker chain.

### 1.2

Backfill all Markov semigroup, generator, reversibility, carré-du-champ, Grönwall, PI/LSI decay and Bakry–Émery source items after the concrete semigroup/domain bridge is available.

### 1.3

Complete transport duality, W2 metric space, absolutely continuous curves, metric derivative, optimal maps/couplings and displacement geodesics.

### 1.4

Complete Wasserstein gradient flow, continuity/Fokker–Planck equation, first variation of KL/free energy and convergence implications.

### 1.5

Formalize each convergence-summary theorem as a corollary of earlier compiled nodes; do not duplicate the analytic proof.

## Chapter 2 — Functional Inequalities

After A3 core:

- 2.1 source definitions/equivalences;
- 2.2 all semigroup proofs with exact constants;
- 2.3 preservation operations;
- 2.4 concentration/isoperimetry;
- 2.5 manifold interfaces (only after Euclidean core is stable);
- 2.6 discrete-space/time analogues using a distinct discrete generator/kernel API linked by shared abstractions where mathematically valid.

## Chapter 3 — Additional Topics in Stochastic Analysis

After A4 core:

- general qv/covariation;
- complete Girsanov theorem and entropy identities;
- Doob transform;
- Föllmer drift;
- Schrödinger bridge and its source variational characterization.

## Chapter 4 — Analysis of Langevin Monte Carlo

Build a reusable discrete/continuous interpolation object for

\[
X_{k+1}=X_k-h\nabla V(X_k)+\sqrt{2h}\,\xi_k.
\]

Then formalize four book proof routes as separate assemblies sharing the same algorithm definition:

1. Wasserstein synchronous coupling;
2. interpolation differential inequality;
3. convex-optimization analogy, with stochastic assumptions still explicit;
4. Girsanov path-law comparison.

Core reusable nodes:

- one-step moment/increment estimates;
- frozen-drift interpolation;
- local drift mismatch integral;
- terminal-law projection/data-processing;
- error-recursion/Grönwall algebra;
- optimized step-size corollaries.

## Chapter 5 — Faster Low-Accuracy Samplers

Formalize common phase-space state first:

\[
dX_t=V_tdt,\qquad
 dV_t=-\gamma V_tdt-\nabla U(X_t)dt+\sqrt{2\gamma}\,dB_t.
\]

Then:

- randomized midpoint kernel and unbiased internal time;
- Hamiltonian deterministic flow + momentum refreshment kernel;
- underdamped Langevin strong solution;
- phase-space invariant law;
- hypocoercive mixed metric/contraction;
- discretization and low-accuracy complexity corollaries.

Keep exact Hamiltonian flow distinct from numerical integrators.

## Chapter 6 — Convergence in Rényi Divergence

Use the existing Rényi definitions but add full measure-theoretic source theorems:

- data processing and order monotonicity required by the book;
- interpolation derivative/inequality for LMC;
- Girsanov Rényi path-law comparison;
- terminal marginal projection;
- ULMC phase-space adaptation;
- optimized complexity statements with all order/step-size restrictions.

Do not turn a KL-only Girsanov bound into a Rényi theorem by renaming variables.

## Chapter 7 — High-Accuracy Samplers

Canonical kernel route:

1. rejection sampler with envelope/normalization assumptions;
2. Metropolis–Hastings kernel with totalized zero-density cases;
3. detailed balance as a measure identity;
4. stationarity from reversibility;
5. discrete-time chain powers;
6. conductance and warmness;
7. conductance-to-mixing theorem;
8. MALA proposal + acceptance estimates;
9. cold-start and warm-start source theorems.

The MH acceptance ratio

\[
\alpha(x,y)=1\wedge\frac{\pi(y)q(y,x)}{\pi(x)q(x,y)}
\]

is only the density-level ingredient; the source-facing theorem must build the actual measurable transition kernel.

## Chapter 8 — The Proximal Sampler

After A5 closes the frontier chain, backfill all remaining source items in 8.1–8.6 and expose the whole chapter as a single navigable Lean subgraph:

```text
proximal joint law
  -> Gaussian conditional
  -> restricted-Gaussian conditional / RGO
  -> alternating Gibbs kernel
  -> marginal invariance
  -> strong-log-concave contraction (8.2)
  -> simultaneous flow / time reversal (8.3)
  -> log-concave convergence (8.4)
  -> PI/LSI convergence (8.5)
  -> exact/approximate RGO implementation and error propagation (8.6)
```

---

# Merge-packet discipline

Large branches that mix unrelated source items are not the unit of progress. Each packet should normally contain one mathematical bridge and its focused test, for example:

```text
qv-fourth-moment
qv-one-cell-L2
qv-grid-orthogonality
qv-dyadic-limit
ito-taylor-remainder
ito-formula-scalar
ito-formula-vector
sde-picard
sde-pathwise-uniqueness
sde-transition-kernel
relative-fisher-rn-bridge
kl-differentiation
kl-fisher-dissipation
w2-optimal-coupling
kl-geodesic-first-variation
fisher-transport-analytic-bridge
bakry-emery-langevin
path-girsanov
proximal-joint-normalization
proximal-conditionals
proximal-invariance
proximal-simultaneous-flow
proximal-time-reversal
proximal-logconcave-convergence
```

Every packet must be independently reviewable, and a later packet may be stacked only when its mathematical dependency is genuine.

---

# Current executable queue

## Now

1. **Chapter 1.1 / qv one-cell L2** — fix and merge the active packet proving
   \(\mathbb E[((\Delta B)^2-\Delta t)^2]=2\Delta t^2\).
2. **Chapter 1.1 / qv grid L2** — retarget the stacked finite-grid orthogonality packet after #1 is green.
3. **Chapter 1.1 / qv mesh limit** — add the deterministic \(\sum \Delta t_i^2\) mesh bound and dyadic convergence.
4. **Chapter 1.2 / relative Fisher** — merge the regularity-aware definition layer when CI is green, then immediately add the RN/log-ratio bridge.
5. **Website** — enforce the self-contained formula-first reader contract on Chapter 1 and use it as the template for every newly completed Chapter 2–8 source item.

## Immediately after qv

6. scalar Itô formula remainder packet;
7. finite-dimensional Itô formula;
8. SDE Picard construction;
9. pathwise uniqueness + strong solution theorem;
10. concrete SDE transition kernel/Markov bridge.

## Then frontier analytic spine

11. KL density evolution and differentiation;
12. KL/Fisher dissipation;
13. W2 optimal-coupling/geodesic completion;
14. KL geodesic first variation;
15. analytic \(\mathrm{KL}^2\le I W_2^2\) theorem;
16. Chapter 2 Bakry–Émery/PI/LSI nodes consumed by Chapter 8;
17. Chapter 3 path Girsanov/Doob/time-reversal nodes consumed by Chapter 8;
18. Chapter 8.1 joint/conditional kernel construction;
19. Chapter 8.3 simultaneous-flow/time-reversal theorem;
20. Chapter 8.4 log-concave convergence theorem;
21. Chapter 8.5 functional-inequality route;
22. Chapters 4–7 + 8.6 coverage backfill using the now-stable shared APIs.

---

# Graph-level success criterion at Chapter 8 closure

At the end of this plan, the Underlying Lean Graph should make the following visible without reading implementation files:

- which Chewi statements are foundational shared nodes;
- which Chapter 4–8 results are alternative assemblies over the same nodes;
- which SampleWiki/frontier results add genuinely new leaves or new graph edges;
- which claims differ only by constants or terminal algebra and therefore are marginal graph additions;
- which new work introduces a new reusable technique/topology in the formal graph.

That graph-level distinction is the reason to prioritize shared formal topology rather than maximizing a raw count of formalized textbook lines.
