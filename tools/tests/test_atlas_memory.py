from __future__ import annotations

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

import atlas_memory


class AtlasMemoryTests(unittest.TestCase):
    def test_topics_and_routes_are_conservative(self) -> None:
        topics = atlas_memory.topic_tags(
            "TheoryOfProbability",
            "Atlas.TheoryOfProbability.code.MarkovChain",
            "MarkovChain.transitionKernel",
        )
        self.assertIn("measure-probability", topics)
        self.assertIn("stochastic-processes", topics)
        self.assertEqual(
            atlas_memory.route_candidates("TheoryOfProbability", topics),
            ["samplewiki-route"],
        )

    def test_manifold_and_optimization_routes_do_not_collapse(self) -> None:
        manifold_topics = atlas_memory.topic_tags(
            "GeometryOfManifolds",
            "Atlas.GeometryOfManifolds.code.RiemannianGradient",
            "riemannian_gradient",
        )
        self.assertIn("riemannian-optimization", atlas_memory.route_candidates(
            "GeometryOfManifolds", manifold_topics
        ))
        optimization_topics = atlas_memory.topic_tags(
            "CombinatorialOptimization",
            "Atlas.CombinatorialOptimization.code.ConvexOptimization",
            "gradient_descent",
        )
        self.assertEqual(
            atlas_memory.route_candidates("CombinatorialOptimization", optimization_topics),
            ["optimisation"],
        )

    def test_committed_snapshot_is_internally_consistent(self) -> None:
        summary, errors = atlas_memory.validate_snapshot()
        self.assertEqual(errors, [])
        self.assertEqual(
            summary["policy"]["status"],
            "external-reference",
        )
        self.assertFalse(summary["policy"]["locally_callable"])
        for route, total in summary["inventory"]["routes"].items():
            self.assertEqual(
                sum(summary["inventory"]["route_books"][route].values()), total
            )


if __name__ == "__main__":
    unittest.main()
