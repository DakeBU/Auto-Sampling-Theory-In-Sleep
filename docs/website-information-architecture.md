# Samplinglib website information architecture

This document is the reader-facing hierarchy contract for the generated ASTIS site.
It is intentionally separate from the mathematical theorem DAG: navigation hierarchy
answers **where a reader starts**, while the theorem DAG answers **what depends on what**.

## Two first-class knowledge sources

The public site has two equal top-level mathematical sources:

1. **Log-Concave Sampling** — Sinho Chewi's textbook reconstructed as a readable,
   source-traceable, Lean-backed learning route.
2. **SampleWiki** — the live sampling frontier, normalized into source-pinned result
   cases and then assimilated into the same reusable Lean graph.

Neither source is a child of the other. In particular, SampleWiki must not appear as
an extra chapter of *Log-Concave Sampling*.

## What is not a top-level source

The following are tools or companion views and therefore sit below the two sources:

- Study Guide (formerly Book Map)
- Chapter 1 Companion
- Chapter 1 Formalization Status (formerly Chapter 1 Matrix in navigation)
- Proof Atlas (formerly Lean Foundations as a teaching entry point)
- Implementation Map
- Lean Declarations
- Source Correspondence
- Live Formalization / ASTIS Harness

The complete book table of contents belongs *inside* the Log-Concave Sampling source
navigation. It is not a peer of the textbook itself.

## Chapter 1 companion model

Chapter 1 is where the site currently needs the most supplementary exposition. The
companion landing page groups the existing teaching layers instead of exposing them
as unrelated global pages:

- 1.1 stochastic calculus — Brownian motion, filtrations, Itô integration,
  stopping/localization, Itô formula, SDEs;
- 1.2 Markov semigroups — kernels, semigroups, generators, reversibility,
  carré du champ, PI/LSI, Bakry–Émery;
- 1.3 optimal transport — couplings, transport cost, W2, duality, geodesics;
- 1.4 Wasserstein gradient flow — the bridge from the SDE to distributional geometry;
- 1.5 convergence overview — where the chapter's foundations feed the later algorithms.

Each section page remains the canonical place for beginner narrative, vocabulary,
classical references, hidden prerequisites, source statements, rigorous details, and
Lean expansion.

## Proof graph: three zoom levels

The site should not present one giant Lean DAG as the default explanation.

### Zoom 1 — mathematical proof route

Show a small conceptual path with theorem/proof-technique nodes only. No filenames,
fully-qualified Lean names, or implementation bookkeeping unless needed.

### Zoom 2 — shared formal roots

Show reusable roots clustered by mathematical domain. Chapter/case nodes point into
these roots rather than duplicating local proof trees. The first clusters are:

- stochastic calculus;
- Markov semigroups and functional inequalities;
- optimal transport and Wasserstein geometry;
- sampling algorithms / complexity / Example Cases.

Status color belongs to a precise formal node, not to a chapter merely because one
leaf below it compiled.

### Zoom 3 — exact Lean node

The theorem card is the machine-level view: exact statement, source line, imports,
dependencies, consumers, Registry status, focused tests, and source correspondence.

`Implementation Map` is an engineering/audit table over these nodes, not the teaching
front page.

## Concision rules

- The sidebar should show chapters by default, not every section of all twelve chapters.
  Only the current chapter expands to section-level navigation.
- Long declaration lists never appear on the Study Guide.
- Source URLs, Lean identifiers, file paths, code, formulas, and tables must wrap or
  scroll inside their own component; they must never widen the whole page.
- Default section spacing and card padding should be smaller than the original
  Blueprint layout. Progressive disclosure (`details`) is preferred for audit-heavy
  material.
- Mobile and narrow desktop layouts must use `min-width: 0` on grid/flex children and
  one-column fallbacks for proof/portal grids.
