<div align="center">

# Auto-Sampling-Theory-In-Sleep

### A Hierarchical Automated Theorem Proving System for Sampling Theory


[![Samplinglib](https://img.shields.io/badge/Samplinglib-verified_sampling_theory-155EEF?style=flat-square)](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
[![Lean 4](https://img.shields.io/badge/Lean-4-6B4FBB?style=flat-square)](https://lean-lang.org/)
[![Mathlib](https://img.shields.io/badge/Mathlib-pinned_revision-008F78?style=flat-square)](https://mathlib.org/)
[![Samplinglib site](https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/actions/workflows/blueprint-site.yml/badge.svg)](https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/actions/workflows/blueprint-site.yml)

[**Samplinglib**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/)
· [**Lean Registry**](AutoSamplingTheory/TechnicalLemmas/Registry.lean)
· [**System Architecture**](docs/multi_agent_orchestration.md)

</div>

ASTIS represents mathematical proofs as source-backed, reusable dependency
DAGs. Specialized agents coordinate mathematical planning, formal
decomposition, Lean implementation, and independent verification. The first
major program reconstructs Sinho Chewi's
[*Log-Concave Sampling*](https://chewisinho.github.io/main.pdf) while building
reusable formal memory for future sampling-theory problems.

---

## News 🔥

- **July 2026** — Released the first user-facing version of
  [**Samplinglib**](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/),
  connecting the textbook route, rigorous analytic details, Lean declarations,
  and source-backed verification.
- **June 2026** — Completed the first version of
  **Auto-Sampling-Theory-In-Sleep (ASTIS)**, the hierarchical automated theorem
  proving system for sampling theory.

---

## Core Contributions ◆

### 1. Hierarchical Automated Theorem Proving Harness

ASTIS is not a single model writing tactics. It maintains a typed proof state
across four cooperating levels:

- **Upper** audits sources, assumptions, state spaces, measures, regularity,
  boundaries, failed routes, and the shared proof DAG.
- **Middle** is the natural-mathematics ↔ Lean boundary. It fixes statements,
  hypotheses, source anchors, local lemmas, Mathlib candidates, rejected API
  matches, and a ready Lean leaf DAG.
- **Lower** separates proof-route scouting, Lean implementation, and focused
  local/Mathlib retrieval for one leaf at a time.
- **Reviewers** independently check source fidelity, hidden assumptions,
  statement drift, fake closure, Lean evidence, and repeated low-value work.

The deterministic harness preserves typed artifacts, immutable proof branches,
cross-process locks, exact-field memory, interrupted-run recovery, route
fingerprints, and compiler feedback.

### 2. Samplinglib: Verified Memory for Sampling Theory

**Samplinglib** is the public Lean library, learning environment, and
verification surface produced and maintained by ASTIS. It begins with a
formal reconstruction of *Log-Concave Sampling*, but organizes the resulting
measure theory, probability, functional inequalities, stochastic processes,
SDE, Langevin, and sampler interfaces for reuse beyond one textbook.

---

## System Architecture ◇

```mermaid
flowchart TB
  Source["Paper · textbook · research problem<br/>LaTeX and natural-language mathematics"]:::source

  subgraph Upper["UPPER · mathematical planning"]
    UM["source and assumptions"]
    UD["proof DAG"]
    UX["process and failure memory"]
    UO["upper director"]
    UM --> UO
    UD --> UO
    UX --> UO
  end

  AC["analytic_contract"]:::artifact

  subgraph Middle["MIDDLE · formal decomposition"]
    MS["source correspondence"]
    MR["Samplinglib / Mathlib retrieval"]
    MF["middle formalizer"]
    MS --> MF
    MR --> MF
  end

  FM["formalization_map"]:::artifact
  Queue["Lean leaf DAG · ready queue"]:::queue

  subgraph Lower["LOWER · one formal leaf"]
    L1["proof scout"]
    L2["Lean worker"]
    L3["API / lemma scout"]
  end

  PA["proof_attempt"]:::artifact
  Lean["Pinned Lean compiler"]:::lean

  subgraph Review["INDEPENDENT REVIEW"]
    RG["source · assumptions · Lean gate"]
    RW["route · duplication · waste audit"]
  end

  RV["review"]:::artifact
  Registry["Samplinglib Registry<br/>verified reusable formal memory"]:::registry

  Source --> Upper --> AC --> Middle --> FM --> Queue --> Lower --> PA --> Lean --> Review --> RV
  RV -->|accepted| Registry
  RV -->|exact subgoal / API failure| Middle
  RV -->|statement / route failure| Upper
  Registry -. reusable lemmas .-> Middle

  classDef source fill:#172033,stroke:#172033,color:#fff,stroke-width:2px;
  classDef artifact fill:#ECE6FF,stroke:#6938EF,color:#172033,stroke-width:1.5px;
  classDef queue fill:#DCEBFF,stroke:#155EEF,color:#172033,stroke-width:1.5px;
  classDef lean fill:#DCFAE6,stroke:#087443,color:#172033,stroke-width:1.5px;
  classDef registry fill:#DCEBFF,stroke:#155EEF,color:#172033,stroke-width:2px;
```

The conversion window is bidirectional:

```text
natural mathematics  ⇄  typed formalization state  ⇄  verified Lean
```

Compiled declarations, exact residual obligations, and reviewer verdicts flow
back into source correspondence, the proof DAG, run capsules, and human-facing
status. Lean compilation never substitutes for semantic review.

---

## Samplinglib Learning Surface 📚

<p align="center">
  <img src="website/static/samplinglib-architecture.svg" alt="Samplinglib architecture from mathematical sources through ASTIS and formal memory to learning and verification surfaces" width="920">
</p>

Readers can move through the library at three linked depths:

1. **Calculation Route** — formulas, intuition, and the textbook proof route.
2. **Rigorous Details** — measurability, integrability, representatives,
   approximation, limits, boundaries, regularity, and operator domains.
3. **Lean Foundations** — exact declarations, imports, dependencies, source
   lines, Registry evidence, tests, and the current Lean gate.

The [Live Formalization workspace](https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep/live/)
adds reviewed examples, LaTeX rendering, Samplinglib/Mathlib retrieval, local
Lean diagnostics, and export to ASTIS typed packets. Candidate translation,
compilation, semantic review, proof, and reviewer acceptance remain separate
states.

---

## Organizers ✦

**Dake Bu, Ji Cheng, Atsushi Nitanda, Hau-San Wong, and Qingfu Zhang**

## Citation 📝

```bibtex
@misc{bu2026astis,
  title        = {Auto-Sampling-Theory-In-Sleep: A Hierarchical Automated
                  Theorem Proving System for Sampling Theory},
  author       = {Dake Bu and Ji Cheng and Atsushi Nitanda and
                  Hau-San Wong and Qingfu Zhang},
  year         = {2026},
  howpublished = {GitHub repository and Samplinglib formalization website},
  url          = {https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep}
}
```

ASTIS is the research system and proving harness. Samplinglib is its public
Lean library and learning interface. External libraries, textbooks, papers,
and repositories are cited as mathematical or design provenance and do not
imply endorsement.
