---
name: astis-proof-dag
description: Plan and review ASTIS proof work as reusable Lean proof DAGs instead of repeated flat proof traces.
argument-hint: "[task id or Lean theorem]"
---

# ASTIS Proof DAG

Use this when a proof target has repeated analytic or formalization subblocks.

## Typical Blocks

- measure definitions and density normalization;
- KL/FI/LSI/PI interfaces;
- Donsker--Varadhan and entropy duality;
- Gronwall or differential inequality integration;
- Fokker--Planck and continuity-equation identities;
- Euler--Maruyama one-step and accumulated discretization error;
- predicted-clean or guide-surrogate error decomposition;
- SMC/Feynman--Kac particle approximation.

## Required Table

Add or maintain this table in the conversion window or proof-obligation file:

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|

## Protocol

- Upper chooses the next reusable block or proof route.
- Middle keeps the DAG synchronized with source anchors and obligations.
- Lower works on one block interface at a time.
- Reviewer rejects duplicated informal proofs and hidden assumptions.

In `faithfulPaper` mode, the DAG decomposes the paper proof only. It must not
add hypotheses, change constants, or replace the theorem target.

