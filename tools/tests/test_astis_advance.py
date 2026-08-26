from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from tools import astis_advance as advance


class SubstantiveAdvanceHarnessTest(unittest.TestCase):
    def setUp(self) -> None:
        self.tempdir = tempfile.TemporaryDirectory()
        root = Path(self.tempdir.name)
        self.advance_ledger = root / "advances.jsonl"
        self.discovery_ledger = root / "discoveries.jsonl"

    def tearDown(self) -> None:
        self.tempdir.cleanup()

    def proposal(self, advance_id: str = "A1") -> advance.AdvanceProposal:
        return advance.AdvanceProposal(
            advance_id=advance_id,
            task_id="CHEWI-BRENIER",
            goal="close the finite replacement cost edge",
            source_anchor="Chewi Theorem 1.3.23, optimality implication",
            theorem_delta="prove the canonical replacement has strictly smaller quadratic cost",
            truth_boundary="does not yet invoke optimal-coupling contradiction",
            created_by="coordinator",
            dag_inputs=("cyclic expectation gap", "equal-mass replacement"),
            proposed_files=("AutoSamplingTheory/TechnicalLemmas/Measure/CostJoin.lean",),
            focused_checks=("lake env lean Tests/CostJoin.lean",),
            modes=("proof-design", "lean-implementation"),
            priority=90,
        )

    def test_duplicate_active_fingerprint_is_rejected(self) -> None:
        advance.propose_advance(self.proposal("A1"), self.advance_ledger)
        with self.assertRaisesRegex(advance.HarnessError, "duplicate active substantive advance"):
            advance.propose_advance(self.proposal("A2"), self.advance_ledger)

    def test_full_advance_state_machine_and_single_stabilization_lane(self) -> None:
        advance.propose_advance(self.proposal("A1"), self.advance_ledger)
        advance.transition_advance(
            "A1", "CLAIMED", worker_id="worker-a", modes=("proof-design",),
            path=self.advance_ledger,
        )
        advance.transition_advance(
            "A1", "EXPLORING", worker_id="worker-a", modes=("mathlib-retrieval",),
            path=self.advance_ledger,
        )
        advance.transition_advance(
            "A1",
            "PROVED_LOCAL",
            worker_id="worker-a",
            modes=("lean-implementation",),
            evidence={
                "theorem_delta": "compiled strict finite cost inequality",
                "lean_files": ["AutoSamplingTheory/TechnicalLemmas/Measure/CostJoin.lean"],
                "focused_checks": ["lake env lean Tests/CostJoin.lean"],
                "truth_boundary": "global optimality contradiction remains downstream",
            },
            path=self.advance_ledger,
        )
        advance.transition_advance(
            "A1",
            "VERIFIED",
            worker_id="worker-a",
            modes=("review",),
            evidence={"gate": {"lean": "success", "site": "success"}},
            path=self.advance_ledger,
        )
        advance.transition_advance(
            "A1",
            "STABILIZING",
            worker_id="stabilizer",
            modes=("stabilization",),
            evidence={
                "canonical_branch": "harness/test-cost-join",
                "integration_owner": "stabilizer",
            },
            path=self.advance_ledger,
        )

        advance.propose_advance(
            advance.AdvanceProposal(
                **{
                    **self.proposal("A2").__dict__,
                    "source_anchor": "Chewi Theorem 1.3.24",
                    "theorem_delta": "prove a second independent cost edge",
                }
            ),
            self.advance_ledger,
        )
        advance.transition_advance(
            "A2", "CLAIMED", worker_id="worker-b", modes=("proof-design",),
            path=self.advance_ledger,
        )
        advance.transition_advance(
            "A2", "EXPLORING", worker_id="worker-b", modes=("lean-implementation",),
            path=self.advance_ledger,
        )
        advance.transition_advance(
            "A2",
            "PROVED_LOCAL",
            worker_id="worker-b",
            modes=("lean-implementation",),
            evidence={
                "theorem_delta": "second local edge",
                "lean_files": ["Second.lean"],
                "focused_checks": ["lake env lean Tests/Second.lean"],
                "truth_boundary": "join remains downstream",
            },
            path=self.advance_ledger,
        )
        advance.transition_advance(
            "A2", "VERIFIED", worker_id="worker-b", modes=("review",),
            evidence={"gate": "success"}, path=self.advance_ledger,
        )
        with self.assertRaisesRegex(advance.HarnessError, "single stabilization lane"):
            advance.transition_advance(
                "A2",
                "STABILIZING",
                worker_id="other-stabilizer",
                modes=("stabilization",),
                evidence={
                    "canonical_branch": "harness/second",
                    "integration_owner": "other-stabilizer",
                },
                path=self.advance_ledger,
            )

        advance.transition_advance(
            "A1",
            "MERGED",
            worker_id="stabilizer",
            modes=("stabilization",),
            evidence={"pr": 999, "commit": "abc123"},
            path=self.advance_ledger,
        )
        state = advance.current_advances(self.advance_ledger)
        self.assertEqual(state["A1"]["state"], "MERGED")
        self.assertEqual(state["A2"]["state"], "VERIFIED")

    def test_proved_local_requires_substantive_evidence(self) -> None:
        advance.propose_advance(self.proposal(), self.advance_ledger)
        advance.transition_advance(
            "A1", "CLAIMED", worker_id="worker", path=self.advance_ledger
        )
        advance.transition_advance(
            "A1", "EXPLORING", worker_id="worker", path=self.advance_ledger
        )
        with self.assertRaisesRegex(advance.HarnessError, "lacks evidence"):
            advance.transition_advance(
                "A1",
                "PROVED_LOCAL",
                worker_id="worker",
                evidence={"lean_files": ["OnlyFile.lean"]},
                path=self.advance_ledger,
            )

    def test_discovery_bus_survives_worker_completion(self) -> None:
        advance.propose_advance(self.proposal(), self.advance_ledger)
        advance.publish_discovery(
            advance.Discovery(
                discovery_id="D1",
                advance_id="A1",
                kind="interface",
                statement="finite-measure pushforward naturality is reusable outside Brenier",
                evidence="compiled theorem CommonMassProductMap.commonMassProduct_map_prodMap",
                where_it_matters="future SampleWiki transport competitors",
                provenance="worker-a while proving A1",
                created_by="worker-a",
            ),
            self.discovery_ledger,
        )
        advance.transition_discovery(
            "D1",
            "validated",
            actor="reviewer",
            note="statement and declaration were checked",
            path=self.discovery_ledger,
        )
        capsule = advance.coordinator_capsule(
            self.advance_ledger, self.discovery_ledger, max_advances=4, max_discoveries=4
        )
        self.assertEqual(capsule["discoveries"][0]["discovery_id"], "D1")
        self.assertEqual(capsule["discoveries"][0]["status"], "validated")
        self.assertGreater(capsule["serialized_characters"], 0)
        self.assertNotIn("transcript", capsule)

    def test_interrupted_tail_is_recovered(self) -> None:
        advance.propose_advance(self.proposal(), self.advance_ledger)
        with self.advance_ledger.open("ab") as handle:
            handle.write(b'{"event":"interrupted"')
        state = advance.current_advances(self.advance_ledger)
        self.assertIn("A1", state)
        self.assertTrue(self.advance_ledger.read_bytes().endswith(b"\n"))


if __name__ == "__main__":
    unittest.main()
