# ASTIS Blueprint-style site architecture

## Decision

Use a zero-extra-dependency Python static generator integrated with the
existing ASTIS CLI.

This keeps the website:

- static and GitHub Pages compatible;
- buildable on Linux and Windows;
- independent of a heavyweight SPA runtime;
- driven by the Lean Registry, source tree, and tests;
- reviewable as generated HTML plus version-controlled JSON/Mermaid sources.

## Source of truth

| Data | Authority | Website use |
|---|---|---|
| compiled local status | `AutoSamplingTheory/TechnicalLemmas/Registry.lean` | blue eligibility |
| declaration existence and statement | `AutoSamplingTheory/**/*.lean` | theorem cards |
| count baseline and explicit smoke tests | `Tests/Basic.lean` | drift check and test signal |
| chapter exposition | `website/content/chapters.json` | twelve-chapter textbook |
| source anchors | `website/content/source_correspondence.json` | book-to-Lean mapping |
| graph layout | `website/diagrams/*.mmd` | maintainable split DAGs |

Generated `_site/` is not a source of mathematical status.

## Status rule

Blue requires:

1. Registry status `formalizedLocal`;
2. a resolved ASTIS-owned Lean declaration;
3. the repository `lake build Tests` gate.

Purple marks port candidates, orange marks typed gaps or metadata/source
mismatches, gray marks external references, and red marks explicit unfinished
mathematical edges. Prose and external code are never blue.

## Information architecture

- Home
- Textbook index and twelve chapter pages
- Calculation Route
- Rigorous Details
- Lean Foundations
- Source Correspondence
- Implementation Map
- Dependency Explorer
- Progress
- Roadmap and Current Frontier
- Learn Lean Through Sampling
- Attribution and Licensing
- Build and Maintenance
- generated theorem cards
- generated module cards

## Themes

The same semantic HTML supports Blueprint, Modern, and Bold visual themes,
plus light/dark color schemes. The preference is stored in browser local
storage. Pages remain readable without JavaScript.

## Deployment

`.github/workflows/blueprint-site.yml` builds, validates, uploads, and deploys
the `_site/` artifact through GitHub Pages.

No public URL is recorded until a deployment actually succeeds. An OpenAI
Sites deployment was not created because Sites versioning requires the exact
source state to be committed and pushed; the protected dirty worktree contains
pre-existing Cycle 26-28 work that this insertion task is not authorized to
commit or publish.

