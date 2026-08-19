# Chewi prerequisite spine for the SampleWiki frontier

This file answers one question only:

> When a SampleWiki frontier theorem depends on mathematics from Sinho Chewi's
> *Log-Concave Sampling*, which textbook nodes must ASTIS close first?

The order is a dependency order, not chapter-number order.

## T0 — measure / density substrate already shared

Reuse the existing Samplinglib Radon--Nikodym, Gibbs-density, KL-density,
Rényi, product-measure, and transport interfaces.  Do not create a second
SampleWiki-only probability layer.

## T1 — Chewi Chapter 1: continuous-time common language

### §1.1 stochastic calculus

Needed by later LMC/ULD/stochastic-gradient/mirror diffusion arguments:

\[
\text{Brownian motion}
\to
\text{Itô integral}
\to
\text{quadratic variation}
\to
\text{Itô formula}
\to
\text{SDE solution / Markov property}.
\]

Ownership stays with the active Chapter 1.1 closure branches.

### §1.2 Markov semigroup theory

Required nodes:

\[
P_t,\quad L,\quad L^*,\quad \Gamma,\quad \text{reversibility},
\]

plus the measure-evolution layer and the regularity-aware relative Fisher
information interface

\[
\mathrm{FI}(\mu\|\pi)
=
\mathbb E_\mu\|\nabla\log(d\mu/d\pi)\|^2
\]

on its legitimate energy domain.  Outside that domain, the extended-valued
notion must not be silently replaced by a finite integral formula.

The KL-dissipation edge is

\[
\frac{d}{dt}\mathrm{KL}(\mu_t\|\pi)
=-\mathrm{FI}(\mu_t\|\pi)
\]

for the Langevin normalization; the heat-flow half-step used in Chapter 8 has
the corresponding factor \(1/2\).

### §1.3–§1.4 optimal transport and Wasserstein gradient flow

Close the source-facing Wasserstein-geodesic machinery and Chewi Theorem 1.4.5:

\[
V\ \alpha\text{-convex}
\Longrightarrow
\mathrm{KL}(\cdot\|\pi)
\text{ is }\alpha\text{-convex along }W_2\text{-geodesics}.
\]

The log-concave first-order consequence needed by the proximal proof is

\[
\mathrm{KL}(\mu\|\pi)^2
\le
\mathrm{FI}(\mu\|\pi)W_2^2(\mu,\pi).
\]

## T2 — Chewi Chapter 2: functional inequalities

This layer must precede SampleWiki's PI/LSI proximal rows and many
strongly-log-concave rows.

Required reusable nodes:

\[
\operatorname{Var}_\pi(f)
\le C_{\rm PI}\,\mathcal E(f,f),
\]

\[
\operatorname{Ent}_\pi(f^2)
\le 2C_{\rm LSI}\,\mathcal E(f,f),
\]

and the Bakry--Émery / strong-log-concavity implications used by the book.

For proximal sampling, the proof also needs the behavior of PI/LSI under the
Gaussian convolution / heat-flow transformations appearing in the forward and
backward half-steps.  These should be formalized as shared Chapter 2 operations,
not hidden inside Theorem 8.5.1 or 8.5.2.

## T3 — Chewi Chapter 3: path-space change of measure

Before the frontier exact-ULD/FORS paper, close the reusable part of §3.2:

\[
\frac{d\mathbb P_b}{d\mathbb P_0}
=
\exp\!\left(
\int_0^T\langle b_t,dB_t\rangle
-\frac12\int_0^T\|b_t\|^2dt
\right).
\]

The desired ASTIS node is a path-law/Girsanov interface strong enough to support
Rényi control of approximate diffusion simulation.  The FORS paper should import
this node rather than restating Girsanov locally.

## T4 — Chewi Chapter 8: proximal sampler core

Formalize in this exact order.

### Theorem 8.3.1 — simultaneous f-divergence flow

\[
\frac d{dt}D_f(\mu_t\|\nu_t)
=-\int f''(\rho_t)\Gamma_t(\rho_t)d\nu_t,
\qquad
\rho_t=\frac{d\mu_t}{d\nu_t}.
\]

### Heat-flow / time-reversal specializations

Forward heat flow, backward heat flow, simultaneous \(W_2\) contraction, and
the time-reversal identification are explicit DAG nodes.

### Theorem 8.4.1 — log-concave ideal proximal chain

\[
\mathrm{KL}(\mu_n\|\pi)
\le
\frac{W_2^2(\mu_0,\pi)}{nh}.
\]

This closes the currently active SampleWiki case once the analytic one-step
reciprocal inequality is connected to the already-compiled telescoping tail.

### Theorem 8.5.1 — PI contraction

The forward and backward half-steps each contribute

\[
\chi^2_{\rm out}
\le
\frac{1}{1+h/C_{\rm PI}}\chi^2_{\rm in},
\]

so

\[
\chi^2(\mu_n\|\pi)
\le
\frac{\chi^2(\mu_0\|\pi)}{(1+h/C_{\rm PI})^{2n}}.
\]

### Theorem 8.5.2 — LSI contraction

Chewi states the analogous KL theorem and leaves its proof as Exercise 8.5:

\[
\mathrm{KL}(\mu_n\|\pi)
\le
\frac{\mathrm{KL}(\mu_0\|\pi)}{(1+h/C_{\rm LSI})^{2n}}.
\]

ASTIS should formalize it by reusing the same simultaneous-flow skeleton with
LSI/Fisher dissipation, while the website must preserve the source fact that the
book omits the proof.

### Lemma 8.6.2 — inexact RGO accumulation

If each RGO call is within \(\delta\) in total variation of the exact RGO, then

\[
\|\widehat\mu_N-\mu_N\|_{\rm TV}\le N\delta.
\]

This becomes the common implementation-error composition node.

### Corollary 8.6.3 — high-accuracy implemented proximal sampler

Only after the ideal convergence and RGO-error layer are closed should ASTIS
assemble the source-facing query-complexity corollary.  This one corollary feeds
multiple SampleWiki rows (convex/log-concave, PI, and LSI), so it must not be
proved independently three times.

## T5 — Chewi Chapters 4–7: classical algorithmic roots

After T1–T3 are stable, formalize the source theorems that directly appear in
SampleWiki:

- 4.2.7 — LMC under LSI;
- 4.3.6 / 4.3.11 — averaged LMC and the EVI/telescoping route;
- 5.3.17 — RM--ULMC high-accuracy rate, depending on hypocoercive convergence plus discretization;
- 6.1.2 — LMC in Rényi divergence, including hypercontractive order growth;
- 6.3.2 — ULMC guarantees;
- 7.3.5 / 7.6.5 — MALA upper/lower results.

These nodes feed the SampleWiki LMC/ULMC/MALA rows and also provide
subroutines used to implement RGOs.

## T6 — frontier paper: Chen--Chewi--Daskalakis--Rakhlin

Only after T4 should ASTIS assemble Theorem G.1(3).  The source explicitly omits
the repeated RGO-error proof, so the DAG is

\[
\text{Chewi ideal proximal convergence}
+\text{inexact-RGO composition}
+\text{FORS RGO implementation}
\Longrightarrow
\text{Theorem G.1(3)}.
\]

Do not invent a paper-local proof where the source says the proof is omitted.

## T7 — frontier paper: Chen--Chewi--Rakhlin--Zhang (FORS / exact ULD)

Required shared nodes:

\[
\text{Girsanov/path law (T3)}
\to
\text{unbiased log-density-ratio estimator}
\to
\text{FORS simulation error}
\to
\text{continuous ULD contraction}
\to
\text{Rényi composition}.
\]

Then assemble Theorem 3.2(ii), followed by the Theorem 6.1 reduction and
Theorem 6.2 Fisher guarantee.

## T8 — Chewi Chapters 9–11: oracle and Fisher branches

### Chapter 9

Build a common oracle/query-complexity vocabulary before the Gaussian and
first-order lower-bound results.  Then formalize the exact lower-bound theorems;
do not encode query complexity as informal metadata only.

### Chapter 10

For stochastic/finite-sum SampleWiki rows, formalize the stochastic-gradient
oracle model and its variance/sub-Gaussian assumptions before Theorems 10.1.2
and 10.1.3.  For mirror Langevin, build the Bregman/mirror geometry interface
before Theorem 10.3.28 and reuse the T1 Itô machinery.

### Chapter 11

Reuse the T1 relative-Fisher object.  Formalize 11.2.1 first, then the
Fisher-query lower bounds 11.4.3/11.4.4 after T8's oracle model exists.

## T9 — convex-body membership-oracle papers

This branch is structurally different and should come after a reusable
convex-body/membership-query interface exists.  Then audit/formalize
Kook--Zhang and Kook--Vempala source theorems.  The matching lower-bound rows
which SampleWiki marks unknown remain literature-open.

## Operational rule

At any point, choose the next theorem by topological readiness:

1. exact primary theorem/proof audit complete;
2. all shared prerequisites already on `main` or owned by an active prerequisite PR;
3. prove missing reusable leaves first;
4. keep the final source-facing theorem thin;
5. only after compile + semantic source review move the case toward assimilation.
