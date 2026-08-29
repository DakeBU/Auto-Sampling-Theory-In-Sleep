# Riemannian Optimization Library

**Primary source:** Nicolas Boumal, *An Introduction to Optimization on Smooth Manifolds*  
**Website:** `/libraries/riemannian-optimization/`

The eleven chapter directories are represented first as a source map and stable website scaffold. Formalization proceeds by:

1. auditing exact definitions, theorems, assumptions, and source anchors;
2. searching Mathlib and Samplinglib geometry interfaces;
3. classifying each node as `reuse`, `adapt`, `missing`, or `out_of_scope`;
4. opening only genuine missing edges as theorem-sized Frontier Cells;
5. exposing Euclidean → Riemannian translations in the shared Lean graph.

The first cross-library experiment is to determine which Euclidean optimization arguments transport compositionally to smooth manifolds and where genuinely geometric assumptions enter.
