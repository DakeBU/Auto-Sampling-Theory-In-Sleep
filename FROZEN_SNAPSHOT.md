# Frozen review snapshot

This review branch mirrors the mathematical and system state of development revision

```text
458d3c9f8d2f7286030c2ccb2893f8a685c38101
```

with reviewer-facing author surfaces replaced by anonymous equivalents and a review-only static-site post-processing/verification workflow added.

The frozen source includes the full Lean library, tests, source maps, Harness protocols, textbook/frontier routes, graph memory and website generators present at that revision. It is not a reduced demo branch.

## Evidence policy

The anonymous review workflow must pass before a website bundle is distributed. It checks the pinned external-memory contract, source/semantic contracts, the Lean gate, Frontier Cells, source-derived site generation, static-site validation, browser graph interaction, and an identity-leak scan on the final deployable site.

The frozen branch does not auto-sync from the live development branch. Updating the review snapshot requires an explicit new freeze and a fresh verification run.
