# Samplinglib Libraries

This directory records source maps, upstream formal libraries, and truth boundaries for the first-class Samplinglib libraries.

| Library | Primary source | Additional source layer | Current status |
|---|---|---|---|
| Log-Concave Sampling | Sinho Chewi, *Log-Concave Sampling* | Chewi's official `supp.pdf` + explicitly attributed rigor/background references | active |
| SampleWiki | source-pinned frontier papers | primary-paper audits | active |
| Riemannian Optimization | Nicolas Boumal | Mathlib / shared geometry references | chapter scaffold |
| Optimisation | Sinho Chewi, *Lectures on Optimization* (arXiv:2605.07006) | Bubeck / Beck / Nesterov background + Optlib / CvxLean | chapter scaffold |

ATLAS v1 supplies a pinned external retrieval memory shared by all three routes: 36,469 named source declarations are indexed with exact source anchors, placeholder evidence, and route tags. These records remain external and non-callable until a minimal ASTIS-owned port or proof passes the local Lean gate.

A scaffold establishes stable chapter URLs, source boundaries, and future graph locations. It does not certify any theorem.

The source hierarchy is explicit: a primary source controls source-facing statements; an official supplement is additional source material; background books can justify omitted standard details but do not silently replace the primary theorem; formal upstream code is classified as `reuse`, `adapt`, `missing`, or `out_of_scope` before it enters the shared graph.
