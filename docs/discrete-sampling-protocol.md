# Discrete Sampling: source, shared graph and acceptance contract

Discrete refers to the **state space**, not the time variable. The first source window
is finite spin/configuration spaces, including Ising, hard-core and matroid bases.
Countably infinite chains, infinite-volume Gibbs states and numerical discretizations
require separately scoped contracts; none is silently included here.

## Source-primary, not source-only

The source is Chen–Štefankovič–Vigoda, arXiv:2307.13826v4. The source map pins the PDF
SHA-256, preserves 12 source-section identities, and maps 72 subsection anchors.
The arXiv version date and PDF title date differ and are separately recorded.
The proposed prerequisite edges are ASTIS scheduling choices, not an attributed source diagram.

Levin–Peres (with Wilmer), *Markov Chains and Mixing Times* (2nd edition, 2017),
is classical background, not an arXiv claim. Duminil-Copin's arXiv:1707.00520v1
supplies Ising/Potts equilibrium and phase-transition background, not every mixing proof.
For §12, the monograph explicitly omits proofs. Resolve each original citation,
pin its theorem/version and record a `source_detail_audit` (`cites_external`, exact
gap, consulted theorem and hypothesis adapter). If the cited proof remains unresolved,
return a typed obstruction rather than mark the target complete. Check suspected
source typos via Original text → Lean statement → reconstructed text, recording any repair.

## One shared floor, not a DiscreteSampling mini-Mathlib

Read `Libraries/frontloaded-shared-spine.json`. Pull §3 forward after §§1.1–1.3;
§12.1 model definitions can be read early but give no credit for Ising mixing theorems.

Shared kernel composition and scalar decay come before domain-specific adapters.
The finite lane branches from measures/PMFs and finite linear algebra, not from SDEs,
spatial calculus, Brenier theory or manifold geometry. Kernel composition, stationarity,
finite integrals, conditional probability, variance, entropy, covariance and scalar
decay are shared; Ising conditional laws and uniform pinning bounds are explicit adapters.

Search Samplinglib, pinned Mathlib, active shared cells, then compatible upstreams.
Useful *search locations*, not certificates:

- `TechnicalLemmas/Probability/ConditionalKernel.lean` and Mathlib's
  `ProbabilityTheory.Kernel`, `Kernel.comp`, Markov-kernel composition instances;
- `TechnicalLemmas/FunctionalInequalities/{Poincare,Generator,SemigroupDecay}.lean`
  and `TechnicalLemmas/StochasticProcesses/ReversibleGenerator.lean`;
- Mathlib `PMF`, finite sums, `SimpleGraph`, `Matroid`, covariance and PSD matrices.

Public Mathlib documentation was inspected at Kernel/Defs, Composition/Comp,
Combinatorics/SimpleGraph/Basic and Combinatorics/Matroid/Basic. Live docs can differ
from this repository's pinned Mathlib: inspect actual types and compile the minimal
adapter before claiming reuse. No external candidate is promoted by this inventory.

Exact type match → one canonical declaration. Near match → common core plus
an explicit adapter. A missing shared result → one `route: shared` Frontier Cell.
Do not recreate finite-state versions of generic kernel lemmas in a model namespace.

## Mandatory finite-state contract

Every Frontier Cell on `discrete-sampling`, **and any shared cell listing it as a
consumer**, must carry `discrete_state_contract` with:

| Field | Required mathematical information |
|---|---|
| state_space / support | Finite configuration type; forbidden states; positive weights on actual support |
| target | Normalization, graph, inverse-temperature sign/scaling, external fields and boundary conditions |
| operator | Transition kernel/matrix or generator; action on functions versus laws |
| time_model / clock | `static`, `discrete-time`, or `continuous-time`; total rate one versus per-site rate one |
| reversibility | Detailed balance or why inapplicable; stationarity is separate from irreducibility/mixing |
| pinning | All feasible positive-probability conditioning events; frozen sites and marginal lower bounds |
| regime | Exact size, degree, temperature/uniqueness and other theorem assumptions |
| metric / cost | TV, chi-square, KL, transport metric; updates, sweeps, total work and desired precision |
| source_proof_status | What is proved in the primary source versus an external citation or unresolved gap |

Discrete-time cells additionally require `aperiodicity_or_absolute_gap` (with a
reasoned not-applicable entry for purely static subclaims). A static shared lemma
can explain why a clock is inapplicable; blank or omitted fields are rejected.
Schema-2 source-detail/reuse gates remain mandatory. Finite cardinality, construction
of a stationary Gibbs law, or passing a tiny numerical example is not fast mixing.

For uniform random-site Glauber, `P = (1/n) sum_i P_i` is one update.
`L=P-I` gives total Poisson rate one; per-site rate one gives `n(P-I)`.
Constants differ by n. A positive ordinary relaxation gap is not enough for a
periodic discrete-time chain; use the appropriate absolute gap, laziness or
aperiodicity argument. Preserve minimum stationary mass/warm-start terms.

## Conceptual mirrors: persist candidates, validate before admission

All schema-v3 SAUs inherit the existing mandatory `conceptual_mirror_audit` and
Discovery Ledger. Worker discovery and verifier acceptance remain separate.
The new catalogue displays four **candidate** bridges, explicitly pending independent
review, so useful ideas survive without masquerading as accepted results:

| Stable bridge | Reusable mechanism | Required separate adapter |
|---|---|---|
| `transport:discrete-pi` | L2 coercivity + dissipation → exponential chi-square decay | Finite reversible Dirichlet identity; exact time and constants |
| `transport:discrete-mlsi` | KL energy controlled by dissipation → exponential KL decay | Modified LSI using E(r,log r), not a diffusion chain rule |
| `transport:discrete-transport` | Entropy as a gradient-flow energy | Maas chain-dependent logarithmic-mean metric, not ordinary finite-set W2 |
| `transport:discrete-influence` | Conditional covariance/spectral control | Every feasible pinning, normalization, then a local-to-global theorem |

The seeds are not new mathematical discoveries. Their parent sources and full
hypothesis/conclusion/failure maps live once in `functor_hypergraph.json`; compact
retrieval lives in `graph_memory_index.json`. The finite log-Sobolev, modified
log-Sobolev and Poincare conditions must not be conflated. Generating-polynomial
log-concavity is not density log-concavity. Chain-specific slow mixing is not a
SampleWiki all-algorithms oracle lower bound.

New seed `review.status=candidate` is not admission to the validated mirror ledger.
Only a reviewer different from the proposer, with explicit source-review evidence,
may set `independently-reviewed`; the renderer exposes this state. The general
Discovery Ledger validation/stabilization process still applies to contributor work.
Even reviewed mirrors retain `not-Lean-certified` and empty formal transport refs
until a separate certificate verifier is implemented. Concepts never become solid
Lean dependency edges, and broad search nodes never auto-create compiled bindings.

## Evidence and integration

`tools/tests/test_discrete_sampling.py` checks source inventory, route admission,
clock requirements, pinnings, topology, and rejection of self-review/fake certificates.
The same site/MathJax/browser pipeline renders all six peer libraries.
Run the existing focused checks, then `python3 tools/astis.py check` for a mathematical
advance. Independent proof/source review and the single stabilization lane precede
registry/graph status upgrades. This library-integration change adds **no Lean theorem**.
