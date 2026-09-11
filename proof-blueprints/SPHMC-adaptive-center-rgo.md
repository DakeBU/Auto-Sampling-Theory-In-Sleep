# Adaptive-center joint RGO recovery

For probability base mu on finite-dimensional real inner-product Borel E, fixed b>=0 and a>0, construct Markov kernels T,H:E to E and B:E times E to E times E before every probability center law lambda. Every T(u) is the normalized base tilt -b/2*norm(x-u)^2; every H(u) is actual GaussianSmoothing(Tu,sqrta). Every B(u,y) is the map x to (u,x) of Tu tilted by -norm(x-y)^2/(2a), equivalently of mu tilted with precision b+a^-1 and center (b+a^-1)^-1*(b*u+a^-1*y). Prove actual joint measure recovery B composed with (lambda compProd H)=lambda compProd T for every probability lambda, retaining the center coordinate.

Joint state/center measurability for fixed base,precision andvariance, not joint selection over all base/precision/variance/history parameters. Input must be actual ideal joint lambda compProd H, not arbitrary correlated center-observation law. General probability base abstracts source Gibbs; no marginal moments, approximate recursive kernel, measurable proxy,error orcost guarantee. Expanded source-needed probability semantics, not a verbatim paper theorem.

Construct T using the existing conditional kernel at inverse b when b>0, and const mu when b=0. Construct a global backward fiber via the existing conditional kernel at inverse(b+a^-1), composed with the measurable precision-weighted center map(u,y). Normalize and identify fibers via RGOClosure. Construct H using product noise plus addition and B using deterministic retained center times backward fiber. Apply RGOBackward pointwise only to prove the already-constructed global sections recover; integrate the actual identity under arbitrary lambda using compProd and measurable event sections.

Root sole writer. Bounded packet precedes Lean development.
