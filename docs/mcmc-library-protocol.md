# MCMC Library: source, overlap and formal acceptance

## Controlling source and attached extensions

Fearnhead–Nemeth–Oates–Sherlock, *Scalable Monte Carlo for Bayesian Learning*,
arXiv:2407.12751v1 is the six-chapter source spine. Its 244-page PDF is byte-pinned;
printed page + 6 = PDF page. The preface prioritizes exposition over complete
measure-theoretic details. Recover omitted hypotheses through source_detail_audit,
not by silently weakening the conclusion or adding assumptions.

Ten **ASTIS extended subchapters** are attached to primary chapters, with identities
E1–E10, rather than invented Chapters 7–16. General-state convergence and CLTs use
Roberts–Rosenthal, *General state space Markov chains and MCMC algorithms*,
Probability Surveys 1 (2004), 20–71, arXiv:math/0404033v4 (2007 revision). Both the
publication date and version are retained. Yang–Roberts–Rosenthal 1904.12157v3,
Neal 1206.1901v1, the author's geometric-random-walk survey and explicit modern
handbook/preprint extensions fill distinct gaps. A version-pinned reading lead
without an exact theorem anchor is not source-audited formalization evidence;
record the final anchor and downloaded-byte fingerprint before a theorem claim.

Source maps record accessible preprints, not an assertion of open-source licensing
for the copyrighted books. Link to originals; write original explanations and
proof contracts rather than republishing books or entire proofs. Do not substitute
the latest mutable web PDF for a pinned version.

## MCMC is not a target class

The **Methods × targets** subview belongs to Overview's curated truth layer:

- MCMC is a large method family, not all sampling. Rejection/direct iid methods
  need not be MCMC. Monte Carlo estimation is not identical to sampling a law.
- Log-concavity is a target property. A uniform law on a full-dimensional bounded
  convex body is log-concave but its extended potential is not a smooth
  unconstrained Langevin potential.
- Hit-and-Run is continuous-state despite discrete update time. Glauber on a
  finite Ising model may have discrete or continuous time.
- ULA/LMC and MALA intersect MCMC and log-concave sampling perspectives. ULA's
  fixed step generally changes the stationary law, where such a law exists;
  Metropolis correction can preserve the intended target under its own contract.
- Optimization, Riemannian geometry, optimal transport and SampleWiki provide
  analytic/problem/source lenses; their entire textbooks are not subsets of MCMC.

`website/content/sampling_perspectives.json` is the single machine-readable source
for this map. Edges have typed taxonomy, conditional applicability or reader-scope
labels. They never enter the formal-relation whitelist. Colours encode curated
source affiliation / planned reuse, **not verified multi-consumer use**. Shared
scope means multiple named lenses; grey means unaudited, not useless or unproved.
Proof status remains a separate dot/inspector label; solid versus dashed remains
structural versus curated evidence. A named module's sharing scope creates no
transitive proof-use claim and no duplicate declaration. Only explicit, existing
module IDs are admitted. Exact compiled dependency paths remain independently
inspectable in Lean Branches.

## Shared route before textbook order

One general-state kernel floor feeds MH, Gibbs and finite Glauber; no SDE or RKHS
prerequisite is imposed on these kernels. Detailed balance implies stationarity
under the relevant contract, not conversely, and neither alone gives convergence.
Markov transition kernels and positive-definite/RKHS kernels are a false friend.

RR drift/minorisation/coupling, CLT/Poisson equations, SDE/discretization,
Hamiltonian geometry, and PDMP existence are separate branches. Scalar decay,
couplings, conditional expectations and convex analysis are shared candidates.
Existing contracts that assume a semigroup do not construct one. Existing
nonnegative-time transition families need explicit discrete-kernel-power adapters.
The finite-jump zero-density log-domain obstruction in
`Libraries/DiscreteSampling/reuse-audit.md` remains a blocker to direct MLSI reuse.

Search Samplinglib, pinned Mathlib, active shared cells and audited upstreams.
Identical type -> one declaration. Near type -> common core + explicit adapter.
Multiple users of a missing result -> one `route: shared` cell. Do not create a
new MCMC-local Grönwall, coupling, variance or entropy library just for attribution.

## Machine-checked contribution contract

Every `mcmc` cell and every shared cell with `mcmc` among its consumers must use
Frontier schema 2 and pass source-detail/reuse audits. Its `mcmc_contract` records:
state space, target and support; kernel/generator and action; time model and clock;
invariance class and assumptions; ergodicity; initialization; error metric;
computational cost; objective (law approximation versus expectation estimation);
and source-proof status. Discrete-time contracts address periodicity. Approximate
targets require a separate bias contract. Static subclaims give reasoned
not-applicable entries instead of pretending to prove convergence.

For MH handle reverse moves, singular proposals and zero denominators via a
source-valid density/flux Radon–Nikodym or support-specific adapter. Finite density
ratios alone are not a general-state theorem. Gibbs scan order and conditional
representatives, HMC mass/refreshment/correction, PDMP nonexplosion and test-function
domain, and stochastic-gradient bias are preserved. Stationarity, finite-time
mixing, asymptotic variance/CLT and error of a reported Monte Carlo average are
separate proof obligations. Diagnostics alone never certify convergence.

## Conceptual mirror acceptance

The existing SAU schema-3 conceptual_mirror_audit / Discovery Ledger applies
unchanged. New candidates for invariance correction, scaling limits, augmentation,
perturbation and block-conditionals retain formula, source, hypothesis/conclusion
maps and failure boundaries. A distinct reviewer and evidence are required for
independently-reviewed status. All current edges remain not-Lean-certified with
empty formal_refs; no functor certificate verifier has been fabricated.

Reusing a concept family is distinct from proving a transport theorem. No generic
acceleration guarantee is inferred from nonreversibility, and standard reversible
HMC is not relabelled nonreversible. A rigorous scaling limit needs its mode of
convergence and stationary/initial regime; it is not a uniform finite-dimension
complexity claim. Coordinate minimization and conditional sampling share a local
update pattern, not automatically their convergence assumptions or kernels.

## Acceptance for this integration

No `.lean` file, proof status or project citation author changes. New chapters and
extensions are outlines. Validate Python/JavaScript, source maps and all peer
readers, both membership colours and evidence-edge invariants, then the standard
HTTP Chromium/MathJax and Pages pipeline. For future mathematics the canonical
`python3 tools/astis.py check`, independent source/proof review and stabilization
are mandatory before declarations or graph truth are promoted.
