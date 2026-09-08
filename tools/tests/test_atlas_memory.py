from __future__ import annotations

import contextlib
import hashlib
import io
import sys
import unittest
from pathlib import Path
from unittest import mock

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


class AtlasMemoryCheckWithoutSourceTests(unittest.TestCase):
    def setUp(self) -> None:
        # Synthetic metadata only: these checks never read external source or
        # depend on the checkout's newline representation of pinned fragments.
        self.fragments = {"Fixture.jsonl": b'{"status":"external-reference"}\n'}
        self.manifest = {
            "repository": "fixture-repository",
            "pinned_commit": "fixture-source-commit",
            "source_subdirectory": "v1",
            "lean_toolchain": "fixture-toolchain",
            "mathlib_commit": "fixture-mathlib-commit",
            "license": "fixture-license",
            "expected_books": 1,
            "expected_source_files": 1,
            "expected_named_source_declarations": 1,
        }
        self.summary = {
            "source": {
                "repository": self.manifest["repository"],
                "commit": self.manifest["pinned_commit"],
                "subdirectory": self.manifest["source_subdirectory"],
                "lean_toolchain": self.manifest["lean_toolchain"],
                "mathlib_commit": self.manifest["mathlib_commit"],
                "license": self.manifest["license"],
            },
            "inventory": {
                "books": 1,
                "source_files": 1,
                "counts": {"named_source_declarations": 1},
            },
            "fragments": {
                name: {"sha256": hashlib.sha256(payload).hexdigest(), "records": 1}
                for name, payload in self.fragments.items()
            },
            "index_sha256": atlas_memory.index_digest(self.fragments),
        }
        self.certification = {
            "source_commit": self.manifest["pinned_commit"],
            "index_sha256": self.summary["index_sha256"],
            "lean_toolchain": self.manifest["lean_toolchain"],
            "mathlib_commit": self.manifest["mathlib_commit"],
            "source_scan": "passed",
            "full_lake_build": "passed",
        }
        certification_path = mock.Mock(spec=Path)
        certification_path.exists.return_value = True
        metadata = {
            atlas_memory.MANIFEST: self.manifest,
            atlas_memory.SUMMARY: self.summary,
            certification_path: self.certification,
        }
        for name, replacement in (
            ("CERTIFICATION", certification_path),
            ("read_json", mock.Mock(side_effect=metadata.__getitem__)),
            ("load_fragments", mock.Mock(return_value=self.fragments)),
            ("source_git_commit", mock.Mock(side_effect=AssertionError("unexpected source access"))),
            ("scan_source", mock.Mock(side_effect=AssertionError("unexpected source scan"))),
        ):
            patcher = mock.patch.object(atlas_memory, name, replacement)
            patcher.start()
            self.addCleanup(patcher.stop)

    def run_check(self, source=None, *, require_source: bool = False):
        output, errors = io.StringIO(), io.StringIO()
        with contextlib.redirect_stdout(output), contextlib.redirect_stderr(errors):
            result = atlas_memory.check(source=source, require_source=require_source)
        return result, output.getvalue(), errors.getvalue()

    def test_no_source_validates_snapshot_and_certification(self) -> None:
        result, output, errors = self.run_check()
        self.assertEqual(result, 0)
        self.assertIn("ATLAS memory check passed", output)
        self.assertEqual(errors, "")

    def test_missing_optional_source_path_is_allowed(self) -> None:
        source = mock.Mock(spec=Path)
        source.is_dir.return_value = False
        result, _, errors = self.run_check(source)
        self.assertEqual(result, 0)
        self.assertEqual(errors, "")
        source.is_dir.assert_called_once_with()

    def test_required_source_is_still_required(self) -> None:
        result, output, errors = self.run_check(require_source=True)
        self.assertEqual(result, 1)
        self.assertEqual(output, "")
        self.assertIn("required ATLAS source checkout is missing", errors)

    def test_no_source_rejects_each_certification_mismatch(self) -> None:
        cases = {
            "source_commit": "ATLAS build certification is for a different source commit",
            "index_sha256": "ATLAS build certification is for a different memory index",
            "lean_toolchain": "ATLAS certification uses a different Lean toolchain",
            "mathlib_commit": "ATLAS certification uses a different Mathlib commit",
            "source_scan": "ATLAS certification source scan is not passed",
            "full_lake_build": "ATLAS full Lake build is not certified as passed",
        }
        for field, expected_error in cases.items():
            with self.subTest(field=field), mock.patch.dict(self.certification, {field: "mismatch"}):
                result, output, errors = self.run_check()
                self.assertEqual(result, 1)
                self.assertEqual(output, "")
                self.assertIn(expected_error, errors)

    def test_no_source_still_requires_certification_evidence(self) -> None:
        atlas_memory.CERTIFICATION.exists.return_value = False
        result, output, errors = self.run_check()
        self.assertEqual(result, 1)
        self.assertEqual(output, "")
        self.assertIn("ATLAS build certification evidence is missing", errors)

    def test_no_source_rejects_fragment_and_combined_digest_mismatch(self) -> None:
        self.fragments["Fixture.jsonl"] += b" "
        result, output, errors = self.run_check()
        self.assertEqual(result, 1)
        self.assertEqual(output, "")
        self.assertIn("fragment digest mismatch: Fixture.jsonl", errors)
        self.assertIn("combined ATLAS index digest mismatch", errors)


if __name__ == "__main__":
    unittest.main()
