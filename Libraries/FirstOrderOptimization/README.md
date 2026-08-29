# First-Order Optimization Library

**Primary source:** Amir Beck, *First-Order Methods in Optimization*  
**Formal upstreams:** [Optlib](https://github.com/optsuite/optlib), [CvxLean](https://github.com/verified-optimization/CvxLean)  
**Owners:** Dake, Huanjian, Andi  
**Website:** `/libraries/first-order-optimization/`

Beck supplies the fifteen-chapter textbook spine. Optlib supplies audited convex-analysis and convergence theorems; CvxLean supplies formal optimization problems and verified transformations.

No upstream repository is treated as an opaque vendored dependency. Every textbook node records:

- the exact source statement;
- a matching Mathlib, Optlib, or CvxLean object when one exists;
- toolchain and convention differences;
- the required adapter, or a named missing theorem;
- its future position in the shared Samplinglib graph.

The proximal and composite chapters are the first sampling-transfer benchmark.
