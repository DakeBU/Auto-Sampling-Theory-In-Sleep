import AutoSamplingTheory.TechnicalLemmas.Geometry.GeodesicConvexity

namespace AutoSamplingTheory.Tests.GeodesicConvexity

#check AutoSamplingTheory.TechnicalLemmas.Geometry.GeodesicConvexity.IsAlphaGeodesicallyConvex
#check AutoSamplingTheory.TechnicalLemmas.Geometry.GeodesicConvexity.firstOrder_geodesicConvexity

open AutoSamplingTheory.TechnicalLemmas.Geometry.GeodesicConvexity

example {M : Type*} [MetricSpace M]
    {isGeodesic : (ℝ → M) → Prop} {F : M → ℝ} {alpha : ℝ}
    (hconvex : IsAlphaGeodesicallyConvex isGeodesic F alpha)
    {path : ℝ → M} (hpath : isGeodesic path)
    {gradientPairing : ℝ}
    (hderiv : HasDerivAt (fun t => F (path t)) gradientPairing 0) :
    F (path 1) ≥ F (path 0) + gradientPairing +
      alpha / 2 * dist (path 0) (path 1) ^ 2 :=
  firstOrder_geodesicConvexity hconvex hpath hderiv

end AutoSamplingTheory.Tests.GeodesicConvexity
