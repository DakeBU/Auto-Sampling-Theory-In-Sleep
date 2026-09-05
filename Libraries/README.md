# Samplinglib Libraries

This directory records source maps, upstream formal libraries, and truth boundaries for the first-class Samplinglib libraries.

| Library | Primary source | Additional source layer | Current status |
|---|---|---|---|
| Log-Concave Sampling | Sinho Chewi, *Log-Concave Sampling* | Chewi's official `supp.pdf` + explicitly attributed rigor/background references | active |
| SampleWiki | source-pinned frontier papers | primary-paper audits | active |
| Riemannian Optimization | Nicolas Boumal | Mathlib / shared geometry references | chapter scaffold |
| Optimisation | Sinho Chewi, *Lectures on Optimization* (arXiv:2605.07006) | Bubeck / Beck / Nesterov background + Optlib / CvxLean | chapter scaffold |
| Statistical Optimal Transport | Sinho Chewi, Jonathan Niles-Weed, Philippe Rigollet | Villani / Santambrogio / Ambrosio–Gigli–Savaré when source details are omitted | chapter scaffold |

The four textbook spines are scheduled by mathematical dependency, not independently cover-to-cover. The machine-readable early critical path is [`frontloaded-shared-spine.json`](frontloaded-shared-spine.json), with the coarser all-route DAG in [`cross-domain-program.json`](cross-domain-program.json). In particular, OT Chapter 1 supplies the shared coupling/Wasserstein floor used by Sampling §1.3; Optimization Chapter 1 supplies the early convex core; Boumal Chapter 3 may be pulled forward for the minimal manifold interface needed by Sampling §2.5; and only the required Fenchel/conjugacy lemmas from Optimization Chapter 9 are pulled forward for OT §§1.5–1.6. Pull-forward never implies source-chapter completion.

SampleWiki is a frontier route, not the owner of the Log-Concave Sampling textbook spine. Frontier cells depend on canonical textbook/shared nodes and receive contribution credit only for their own source-facing mathematical delta.

ATLAS v1 supplies a pinned external retrieval memory: 36,469 named source declarations are indexed with exact source anchors, placeholder evidence, and route tags. These records remain external and non-callable until a minimal ASTIS-owned port or proof passes the local Lean gate.

A scaffold establishes stable chapter URLs, source boundaries, and future graph locations. It does not certify any theorem.

The source hierarchy is explicit: a primary source controls source-facing statements; an official supplement is additional source material; background books can justify omitted standard details but do not silently replace the primary theorem; formal upstream code is classified as `reuse`, `adapt`, `missing`, or `out_of_scope` before it enters the shared graph.
