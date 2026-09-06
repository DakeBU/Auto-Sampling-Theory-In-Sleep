# Conceptual Mirror Protocol

ASTIS keeps two kinds of graph truth separate:

1. **formal topology** — what Lean modules and declarations actually depend on;
2. **conceptual topology** — where the same mathematical mechanism reappears after changing the space, metric, energy, oracle, or error functional.

The second layer is valuable precisely because it is weaker than theorem equivalence. It must therefore be recorded systematically without being promoted silently into the first layer.

## Three graph views, three questions

| View | Main question | What counts as truth |
|---|---|---|
| **Overview Graph** | Where are the books, shared stages and frontier branches? | Source/project topology and audited status. |
| **Lean Branches Graph** | Which declarations really prove or import which others? | Compiler-backed declaration/module structure. |
| **Functor Hypergraph** | Which proof mechanisms recur across fields, and how do their hypotheses/conclusions translate? | Source-backed conceptual transport records with explicit failure boundaries. |

Visual proximity never upgrades epistemic status. A Functor Hypergraph edge is dashed/curated unless a separate formal certificate proves an actual transport theorem or functor law.

For machines, use stable identities throughout:

- domain: `concept:<slug>`;
- conceptual family: `family:<slug>`;
- typed bridge: `transport:<slug>`;
- Lean nodes: the exact module/declaration identity emitted by the graph builder.

The compact read order is:

1. `Libraries/conceptual-mirror-protocol.json`;
2. `website/content/graph_memory_index.json`;
3. `website/content/functor_hypergraph.json`;
4. `Libraries/frontloaded-shared-spine.json`;
5. the current SAU/Frontier Cell;
6. the full built Lean graph only when exact dependency expansion is needed.

## Mandatory discovery gate

Starting with substantive-advance schema 3, every `PROVED_LOCAL` packet must contain

```json
{
  "conceptual_mirror_audit": {
    "status": "none-found",
    "discovery_ids": []
  }
}
```

or

```json
{
  "conceptual_mirror_audit": {
    "status": "candidates-published",
    "discovery_ids": ["..."]
  }
}
```

A candidate must already exist in the Discovery Ledger with `kind = conceptual-mirror`. It carries a stable `bridge_id`, `family_id`, participating domains, formula, mechanism, hypothesis map, conclusion map, failure boundary, source ids and graph-view placement. The proving Worker cannot validate its own conceptual mirror. Independent validation checks the mathematical/source correspondence; it still does **not** certify a Lean implication.

This means a useful mathematical analogy survives agent termination even if no new theorem is proved from the analogy yet.

## Mother pattern: metric gradient flow

A large family of optimisation and sampling arguments can be read through

\[
\dot z_t=-\operatorname{grad}_g \mathcal E(z_t),
\qquad
\frac{d}{dt}\bigl(\mathcal E(z_t)-\mathcal E_*\bigr)
=-\|\operatorname{grad}_g\mathcal E(z_t)\|_g^2.
\]

A metric-PL coercivity bound

\[
\|\operatorname{grad}_g\mathcal E(z)\|_g^2
\ge 2\alpha\bigl(\mathcal E(z)-\mathcal E_*\bigr)
\]

closes the scalar differential inequality and gives exponential decay. What changes between fields is not the final Grönwall argument but the meaning of the state space, metric, energy, gradient and proof of the coercivity premise.

This family includes, with separate hypotheses:

- Euclidean optimisation PL;
- Riemannian PL after the Riemannian metric determines `grad f`;
- Wasserstein PL for suitable functionals on probability laws;
- LSI as a PL-shaped inequality for the KL functional along Langevin/Wasserstein gradient flow, where relative Fisher information is the dissipation / formal squared Wasserstein-gradient norm.

The last bullet is a conceptual mirror, not the statement that LSI *is* the Euclidean PL theorem.

## Poincaré and chi-square: a second coercivity mirror

If \(\rho=d\mu/d\pi\), then

\[
\chi^2(\mu\Vert\pi)=\|\rho-1\|_{L^2(\pi)}^2.
\]

Poincaré controls the corresponding quadratic density gap by Dirichlet dissipation. For the reversible semigroup this yields

\[
\chi^2(\pi_t\Vert\pi)
\le e^{-2t/C_{\rm PI}}\chi^2(\pi_0\Vert\pi).
\]

This belongs to the same **gap → dissipation → exponential decay** proof family, but it must remain distinct from the LSI/KL branch. PI and LSI are different functional inequalities, and \(\chi^2\) and KL are different gaps.

## Second-order curvature and strong convexity

The current shared strong-convexity work is a canonical example of another family. In Euclidean form,

\[
f(y)\ge f(x)+\langle\nabla f(x),y-x\rangle
+\frac{m}{2}\|y-x\|^2.
\]

The reusable idea is **lower curvature gives a quadratic model, which can then imply growth or PL-style coercivity**. Its analogues must be typed separately:

- Euclidean strong convexity;
- geodesic strong convexity on a Riemannian manifold;
- geodesic/displacement convexity of functionals on Wasserstein space;
- Bakry–Émery curvature lower bounds implying LSI in the diffusion setting.

These are not interchangeable assumptions. The Functor Hypergraph may group them under `family:curvature-growth`, while the Lean Branches Graph may only connect arrows whose actual declarations compile.

## Stabilization rule

When a validated conceptual mirror reaches stabilization, update together:

- `website/content/graph_memory_index.json` — compact family memory;
- `website/content/functor_hypergraph.json` — typed bridge with evidence/failure boundary;
- Underlying Lean Graph candidate substrates — search locations only unless compiled dependencies exist;
- source anchors and reader explanation.

If an actual category/functor claim is ever desired, it needs explicit objects, morphisms, identity and composition certificates plus a current Lean gate and independent source-fidelity review. Naming the page “Functor Hypergraph” never supplies those obligations by itself.
