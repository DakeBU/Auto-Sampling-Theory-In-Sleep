# SampleWiki frontier formalization plan

## Goal

SampleWiki is not only a comparison table.  Samplinglib should expose every row as a
source theorem node:

\[
\text{paper/version}
\longrightarrow
\text{exact theorem/corollary}
\longrightarrow
\text{displayed bound}
\longrightarrow
\text{proof equations}
\longrightarrow
\text{shared prerequisites}
\longrightarrow
\text{Lean target}.
\]

The formalization order follows the shared theorem DAG, **not** the order of the
34 comparison-table rows.  If a frontier paper invokes a theorem from Sinho
Chewi's *Log-Concave Sampling*, ASTIS first closes the reusable Chewi node and
then returns to the frontier paper.  No SampleWiki-local duplicate may be used
to bypass an unfinished shared root.

## Reader contract for every row

Every public case page must distinguish the following facts.

1. **Pinned row** — the exact SampleWiki row and its cryptographic fingerprint.
2. **Primary source** — paper/monograph version and exact theorem/corollary when audited.
3. **Source statement** — assumptions and conclusion, with the principal bound rendered in LaTeX.
4. **Source proof status** — proved in the cited source, proof omitted, bibliographical attribution only, or literature-open.
5. **Proof equations** — the shortest equation-level route actually used by the source.
6. **Prerequisite chain** — Chewi / Mathlib / Samplinglib nodes needed before the source theorem can be assembled.
7. **Lean frontier** — exact next reusable leaf or source-facing theorem, with no stronger claim than the compiled code.

`sourcePinned` therefore remains weaker than `sourceTheoremAudited`, and a source
theorem audit remains weaker than a compiled and semantically reviewed Lean theorem.

## Shared spine first

The highest-reuse path is the analytic spine behind Chewi Theorem 8.4.1.

### C1. Chewi §1.2: relative Fisher information and KL dissipation

Use a regularity-aware definition.  Chewi explicitly treats
\(\mathrm{FI}(\mu\|\pi)\) as infinite when the square-root density is outside the
Dirichlet-energy domain; ASTIS must not define the gradient formula for arbitrary
measures without this boundary.

Target identities:

\[
\mathrm{FI}(\mu\|\pi)
=
\mathbb E_\mu\!\left[\|\nabla\log(\mu/\pi)\|^2\right],
\]

and, for the appropriate Langevin/heat-flow contract,

\[
\frac{d}{dt}\mathrm{KL}(\mu_t\|\pi)
=-\mathrm{FI}(\mu_t\|\pi).
\]

The proximal half-step uses the heat-flow normalization
\(\partial_t\mathrm{KL}=-\tfrac12\mathrm{FI}\).

### C2. Chewi §1.3–§1.4: Wasserstein geodesics and KL convexity

Close the source-facing form of Theorem 1.4.5 on top of the existing transport,
Wasserstein-space, and displacement-interpolation roots:

\[
V\text{ is }\alpha\text{-convex}
\quad\Longrightarrow\quad
\mathrm{KL}(\cdot\|\pi)
\text{ is }\alpha\text{-convex along }W_2\text{-geodesics}.
\]

The log-concave case \(\alpha=0\), first variation, and Cauchy--Schwarz must yield
the exact bridge used later:

\[
\mathrm{KL}(\mu\|\pi)^2
\le
\mathrm{FI}(\mu\|\pi)\,W_2^2(\mu,\pi).
\]

### C3. Chewi Theorem 8.3.1: simultaneous-flow f-divergence dissipation

For
\(\partial_t\mu_t=L_t^*\mu_t\) and
\(\partial_t\nu_t=L_t^*\nu_t\), formalize the diffusion-chain-rule calculation

\[
\frac{d}{dt}D_f(\mu_t\|\nu_t)
=-\int
f''\!\left(\frac{d\mu_t}{d\nu_t}\right)
\Gamma_t\!\left(\frac{d\mu_t}{d\nu_t}\right)\,d\nu_t.
\]

The proof DAG is:

\[
\partial_t\!\int f(\rho_t)d\nu_t
\to L_t^*\text{ adjoint}
\to L_t(uv)=uL_tv+vL_tu+2\Gamma_t(u,v)
\to L_tf(\rho)=f'(\rho)L_t\rho+f''(\rho)\Gamma_t(\rho)
\to \text{cancellation}.
\]

### C4. Heat-flow / backward-flow specializations

Formalize the forward heat flow, simultaneous \(W_2\) contraction, and the
backward heat/time-reversal identification required by the proximal sampler.
The source-facing contracts must expose rather than hide the time-reversal edge.

### C5. Chewi Theorem 8.4.1: ideal proximal sampler under log-concavity

The source theorem is

\[
\mathrm{KL}(\mu_n^X\|\pi^X)
\le
\frac{W_2^2(\mu_0^X,\pi^X)}{nh}.
\]

The equation route is

\[
\partial_t K_t=-\tfrac12 I_t,
\qquad
K_t^2\le I_t W_t^2,
\qquad
W_t^2\le W_0^2,
\]

hence

\[
K_t'\le -\frac{K_t^2}{2W_0^2}
\quad\Longrightarrow\quad
\frac1{K_h}\ge \frac1{K_0}+\frac{h}{2W_0^2}.
\]

The backward half-step gives the second \(h/(2W_0^2)\), so a full proximal step
gives

\[
\frac1{K_{j+1}}
\ge
\frac1{K_j}+\frac{h}{W_0^2}.
\]

The final telescoping/inversion segment is already compiled as
`IdealProximalChain.kl_rate_from_reciprocal_step`.

## Dependency-ordered execution phases

### Phase A — finish common Chapter 1 interfaces

- Finish Chapter 1.1 Itô/SDE/Markov-process closure through the existing quadratic-variation and Itô-formula lane.  This is needed later by ULD, stochastic-gradient, and mirror-diffusion papers.
- Merge/reuse the Chapter 1.2–1.3 semigroup/Γ/Wasserstein lane; do not fork its APIs.
- Add the regularity-aware relative-Fisher object and KL/FI dissipation.
- Close the exact source-facing Theorem 1.4.5 and its first-order Fisher--transport consequence.

### Phase B — proximal-sampler spine

1. Theorem 8.3.1 simultaneous f-divergence flow.
2. Forward/backward heat-flow specializations and \(W_2\) contraction.
3. Theorem 8.4.1.
4. Theorem 8.5.1 (PI / \(\chi^2\) proximal contraction).
5. Theorem 8.5.2 (LSI / KL proximal contraction).
6. Corollary 8.6.3, separating convergence of the ideal chain from the cost/error of the RGO implementation.

This phase unlocks several SampleWiki rows simultaneously.

### Phase C — classical LMC / ULD / MALA spine

Formalize the Chewi results that are direct prerequisites of many table rows:

- Theorem 4.2.7 — LMC under LSI;
- Theorems 4.3.6 and 4.3.11 — averaged LMC under log-concavity / weak smoothness;
- Theorem 5.3.17 — randomized-midpoint ULMC;
- Theorem 6.1.2 — Rényi interpolation for LMC;
- Corollary 6.3.2 — ULMC warm-start construction;
- Theorem 7.3.5 — MALA upper bound;
- Theorem 7.6.5 — MALA lower bound.

### Phase D — first frontier-paper layer: high-accuracy proximal implementation

Audit and formalize Chen--Chewi--Daskalakis--Rakhlin,
*High-accuracy sampling for diffusion models and log-concave distributions*,
Theorem G.1.

Part (3) states, under the paper's weak-smoothness assumption,

\[
D_{\rm KL}(\widehat\mu\|\mu)\le\varepsilon^2,
\qquad
N=\widetilde O\!\left(
\beta_s^{2/(1+s)}d^{s/(1+s)}
\frac{W_2^2(\mu_0,\mu)}{\varepsilon^2}
\right).
\]

The source explicitly says the proof follows RGO-error tracking as in
Altschuler--Chewi and omits the repeated argument.  Therefore ASTIS must first
formalize the inherited proximal/RGO error-composition theorem, then assemble
G.1(3); it must not invent a new source proof.

### Phase E — second frontier-paper layer: exact ULD / FORS

Audit and formalize Chen--Chewi--Rakhlin--Zhang,
*Exact simulation of diffusions and improved algorithms for log-concave sampling*.

Theorem 3.2(ii) supplies the high-accuracy strongly-log-concave building block:
under LSI and the displayed step/iteration conditions,

\[
\mathsf R_q(\widehat\nu\|\pi)\le\delta.
\]

Its proof DAG is

\[
\text{Girsanov path density}
\to
\text{FORS unbiased log-density-ratio estimator}
\to
\text{single-step Rényi error}
\to
\text{continuous ULD contraction}
\to
\text{Rényi composition/interpolation}.
\]

Formalize these as shared ULD/FORS nodes before the source-facing theorem.

### Phase F — non-log-concave Fisher frontier

1. Chewi Theorem 11.2.1 (averaged LMC Fisher bound):
   \[
   \frac1{Nh}\int_0^{Nh}\!\mathrm{FI}(\widehat\mu_t\|\pi)dt
   \le
   \frac{2\mathrm{KL}(\widehat\mu_0\|\pi)}{Nh}+6\beta^2dh.
   \]
2. Chewi--Wibisono reduction / the source-facing form quoted as Theorem 6.1 in the 2026 FORS paper.
3. Chen--Chewi--Rakhlin--Zhang Theorem 6.2:
   \[
   \mathrm{FI}(\widehat\pi\|\pi)\le\varepsilon^2,
   \qquad
   \widetilde O\!\left(M(d^{1/3}+\log(M/p))\right),
   \quad
   M=O\!\left(1+\frac{\beta\mathrm{KL}_0}{\varepsilon^2}\right).
   \]
   Its Appendix-F proof is a reduction:
   \[
   R_\infty(\nu_0\|\varpi\otimes N(0,I))\lesssim d
   \to R_3(\widehat\nu\|\varpi\otimes N(0,I))\le\delta_{\rm RGO}^2
   \to \text{data processing}
   \to \text{Theorem 6.1}.
   \]
4. Theorem 11.4.3 / 11.4.4 lower bounds after a common oracle-complexity interface exists.

### Phase G — stochastic / finite-sum oracle results

First formalize the stochastic-gradient oracle model and the Chewi Chapter 10
interfaces, then the COLT 2026 source theorem.  In particular, Theorem 10.1.3
should appear on the site as

\[
\|\widehat\mu-\pi\|_{\rm TV}\le\varepsilon,
\qquad
\widetilde O\!\left(
(\kappa\sqrt d+\sigma_\psi^2/\alpha)
\operatorname{polylog}(1/\varepsilon)
\right)
\]

under the theorem's sub-Gaussian stochastic-gradient condition.

### Phase H — weak-smooth / mirror geometry

Formalize the mirror/Bregman geometry used by Chewi Theorem 10.3.28 and only then
assemble the weak-smooth mirror-Langevin row.  Reuse the Chapter 1.1 Itô formula
rather than proving an example-specific stochastic chain rule.

### Phase I — convex-body membership-oracle branch

This branch needs a distinct oracle-complexity and convex-body interface.  After
those foundations exist, audit/formalize:

- Kook--Zhang, constrained proximal sampler / Rényi-infinity sampling;
- Kook--Vempala Theorem 1.1, warm-start proximal/In-and-Out with restart;
- Kook--Vempala Theorem 1.5 and Corollary 1.6, annealing/warm-start generation and the from-scratch result.

The four `lower unknown` rows remain literature-open nodes throughout.

## All 34 rows: source and execution map

`exact` means that the theorem label was already checked against the primary source;
`pinned` means that the SampleWiki reference is known but the exact source theorem
and proof still require a primary-source audit before Lean work begins.

| Setting | Bound / method | Primary source unit | Main displayed bound | Audit | Earliest phase |
|---|---|---|---|---|---|
| Convex body | Proximal / In-and-Out with restart | Kook--Vempala, Thm. 1.1 (v2) | `~O(q d^2 Λ log^6(1/ε))`, `R_q≤ε` | exact label, formula audit pending | I |
| Convex body | matching general lower bound | none | unknown | literature-open | — |
| Convex body | Rényi-preserving annealing | Kook--Vempala, Cor. 1.6 (v2), via Thm. 1.5 + 1.1 | `~O(qd^2R^{3/2}Λ^{1/4}+qd^2Λ log^7(1/ε))` | exact label, formula audit pending | I |
| Convex body | constrained proximal sampler | Kook--Zhang (SODA 2025) | `~O(d^3 polylog(1/ε))`, `R_∞≤ε` | pinned; formal theorem number pending | I |
| PI/LSI | implemented proximal sampler | Chewi Cor. 8.6.3(3) | `~O(κ√d polylog(√KL_0/ε²))`, TV `≤ε` under LSI | exact | B |
| PI/LSI | matching PI/LSI lower bound | none | unknown | literature-open | — |
| PI/LSI | LMC | Chewi Thm. 4.2.7 | `~O(κ²d/ε²)` | exact label | C |
| PI/LSI | LMC Rényi interpolation | Chewi Thm. 6.1.2 | `~O(κ²dq ε^{-2} log R_2)` | exact label | C |
| PI/LSI | ULMC warm start | Chewi Cor. 6.3.2 | `~O(κ^{3/2}√d/ε)` | exact label | C |
| weak smooth | FORS + proximal sampler | Chen et al. 2026, Thm. G.1(3) | `~O(β_s^{2/(1+s)}d^{s/(1+s)}R_0²/ε²)`, KL `≤ε²` | exact | D |
| weak smooth | matching Hölder lower bound | none | unknown | literature-open | — |
| weak smooth | averaged LMC | Chewi Thm. 4.3.11 | `O(L²R_0²/ε⁴)` | exact label | C |
| weak smooth | nonsmooth mirror-Langevin | Chewi Thm. 10.3.28 | `O(L²D_φ(π,μ_{0+})/ε⁴)` | exact label | H |
| log-concave smooth | implemented proximal sampler | Chewi Cor. 8.6.3(1) | `~O(β√d R_0²/ε²)`, TV `≤ε` | exact | B |
| log-concave smooth | matching first-order lower bound | none | unknown | literature-open | — |
| log-concave smooth | FORS-implemented proximal sampler | Chen et al. 2026, Thm. G.1(3) | `~O(β√dR_0²/ε²)`, KL `≤ε²` | exact | D |
| log-concave smooth | averaged LMC | Chewi Thm. 4.3.6 | `O(βdR_0²/ε⁴)` | exact label | C |
| log-concave smooth | ideal proximal chain | Chewi Thm. 8.4.1 | `KL(μ_n||π)≤W_2²(μ_0,π)/(nh)` | exact + proof audited | B |
| non-log-concave FI | exact ULD / FORS | Chen--Chewi--Rakhlin--Zhang Thm. 6.2, using Thm. 3.2 | `FI≤ε²`, `~O(M(d^{1/3}+log(M/p)))` | exact + proof audited | F |
| non-log-concave FI | general first-order lower bound | Chewi--Gerber--Lee--Lu / Chewi Thm. 11.4.4(2) | `ε^{-2+o(1)}` | exact label | F |
| non-log-concave FI | averaged LMC | Chewi Thm. 11.2.1 | `Θ(β²dK_0/ε⁴)` after optimization | exact + proof audited | F |
| non-log-concave FI | one-dimensional lower bound | Chewi Thm. 11.4.4(1) | `Ω(ε^{-1}√log(1/ε))` | exact | F |
| non-log-concave FI | large-initial-gap lower bound | Chewi Thm. 11.4.3 | `Θ(βK_0/ε²)` in the pinned regime | exact label | F |
| stochastic | high-accuracy stochastic-gradient sampler | Chen et al. (COLT 2026) / Chewi Thm. 10.1.3 | `~O((κ√d+σ_ψ²/α)polylog(1/ε))` | exact Chewi statement | G |
| stochastic | bounded-variance lower bound | Chewi Thm. 10.1.2 | `Ω(σ²/(αε))` | exact label | G |
| finite sum | variance-reduced high-accuracy sampler | Chen et al. (COLT 2026), Chewi §10.1.2 | `~O((m+κ√(dm))polylog(1/ε))` | exact theorem audit pending | G |
| finite sum | RM-ULMC | Chewi §10.1.2 | `~O(m+κ²+κ^{4/3}d^{1/3}m^{2/3}/ε^{2/3})` | exact theorem audit pending | G |
| finite sum | zeroth-order lower bound | Chewi Ch. 9 bibliographical source | `~Θ(L²/α)` at constant accuracy | primary theorem audit pending | G/I |
| strongly LC | exact ULD / FORS | Chen--Chewi--Rakhlin--Zhang Thm. 3.2(ii) | `R_q(ν̂||π)≤δ` under (27), giving `~O(κ^{2/3}d^{1/3})` scale | exact + proof audited | E |
| strongly LC | general first-order lower bound | Chewi et al. 2023 | `~Ω(min{√κ log d,d})` | primary theorem audit pending | lower-bound lane |
| strongly LC | MALA | Chewi Thm. 7.3.5 | `~O(κ√d polylog(1/ε))` | exact label | C |
| strongly LC | randomized-midpoint ULMC | Chewi Thm. 5.3.17 | `~O(κ^{5/6}d^{1/3}/ε^{2/3})` | exact label | C |
| strongly LC | Block-Krylov Gaussian sampler | Chewi Thm. 9.4.1 | `O((d∧√κ)log(d/ε²))` | exact label | later linear/Gaussian lane |
| strongly LC | MALA lower bound | Chewi Thm. 7.6.5 | `~Ω(κ√d log(1/ε))` | exact label | C / lower-bound lane |

## Branch discipline

- One shared prerequisite PR may unlock several SampleWiki rows.
- A case PR should be thin: source-facing statement + assembly from shared leaves.
- Do not open 34 independent proof forests.
- Source audits can proceed in parallel with Lean work, but a case cannot pass
  `sourceReviewed` until the exact source theorem and proof route are checked.
- When a paper omits a proof and cites/inherits an earlier argument, the website
  must say so and the DAG must point to the inherited theorem, not an invented proof.
