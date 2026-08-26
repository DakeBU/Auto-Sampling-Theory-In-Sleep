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
            frontier_cell="brenier-cost",
            target_declarations=("strictCost_commonSlicePermutationReplacement",),
        )

    @staticmethod
    def proved_evidence(name: str = "strictCost_commonSlicePermutationReplacement") -> dict:
        return {
            "result_kind": "theorem-edge",
            "theorem_delta": "compiled strict finite cost inequality",
            "lean_declarations": [name],
            "lean_files": ["AutoSamplingTheory/TechnicalLemmas/Measure/CostJoin.lean"],
            "focused_checks": ["lake env lean Tests/CostJoin.lean"],
            "truth_boundary": "global optimality contradiction remains downstream",
        }

    @staticmethod
    def verified_evidence(verifier: str = "verifier-a") -> dict:
        return {
            "gate": {"lean": "success", "site": "success"},
            "verifier_id": verifier,
            "verified_commit": "deadbeef",
            "source_audit": "source statement and assumptions match",
            "fake_closure_scan": "clean",
        }

    def claim_and_explore(self, advance_id: str = "A1", worker: str = "worker-a") -> None:
        advance.transition_advance(
            advance_id, "CLAIMED", worker_id=worker, modes=("proof-design",),
            path=self.advance_ledger,
        )
        advance.transition_advance(
            advance_id, "EXPLORING", worker_id=worker, modes=("mathlib-retrieval",),
            path=self.advance_ledger,
        )

    def test_duplicate_active_fingerprint_normalizes_presentation(self) -> None:
        advance.propose_advance(self.proposal("A1"), self.advance_ledger)
        duplicate = advance.AdvanceProposal(
            **{
                **self.proposal("A2").__dict__,
                "goal": "  CLOSE   THE FINITE replacement COST EDGE ",
            }
        )
        with self.assertRaisesRegex(advance.HarnessError, "duplicate active substantive advance"):
            advance.propose_advance(duplicate, self.advance_ledger)

    def test_full_advance_state_machine_and_single_stabilization_lane(self) -> None:
        advance.propose_advance(self.proposal("A1"), self.advance_ledger)
        self.claim_and_explore()
        advance.transition_advance(
            "A1", "PROVED_LOCAL", worker_id="worker-a", modes=("lean-implementation",),
            evidence=self.proved_evidence(), path=self.advance_ledger,
        )
        advance.transition_advance(
            "A1", "VERIFIED", worker_id="verifier-a", modes=("review",),
            evidence=self.verified_evidence(), path=self.advance_ledger,
        )
        advance.transition_advance(
            "A1", "STABILIZING", worker_id="stabilizer", modes=("stabilization",),
            evidence={
                "canonical_branch": "harness/test-cost-join",
                "integration_owner": "stabilizer",
            },
            path=self.advance_ledger,
        )

        second = advance.AdvanceProposal(
            **{
                **self.proposal("A2").__dict__,
                "source_anchor": "Chewi Theorem 1.3.24",
                "theorem_delta": "prove a second independent cost edge",
                "target_declarations": ("secondCostEdge",),
            }
        )
        advance.propose_advance(second, self.advance_ledger)
        self.claim_and_explore("A2", "worker-b")
        advance.transition_advance(
            "A2", "PROVED_LOCAL", worker_id="worker-b", modes=("lean-implementation",),
            evidence=self.proved_evidence("secondCostEdge"), path=self.advance_ledger,
        )
        advance.transition_advance(
            "A2", "VERIFIED", worker_id="verifier-b", modes=("review",),
            evidence=self.verified_evidence("verifier-b"), path=self.advance_ledger,
        )
        with self.assertRaisesRegex(advance.HarnessError, "single stabilization lane"):
            advance.transition_advance(
                "A2", "STABILIZING", worker_id="other-stabilizer",
                modes=("stabilization",),
                evidence={
                    "canonical_branch": "harness/second",
                    "integration_owner": "other-stabilizer",
                },
                path=self.advance_ledger,
            )

        advance.transition_advance(
            "A1", "MERGED", worker_id="stabilizer", modes=("stabilization",),
            evidence={"pr": 999, "commit": "abc123"}, path=self.advance_ledger,
        )
        state = advance.current_advances(self.advance_ledger)
        self.assertEqual(state["A1"]["state"], "MERGED")
        self.assertEqual(state["A2"]["state"], "VERIFIED")

    def test_worker_lane_is_owned_end_to_end(self) -> None:
        advance.propose_advance(self.proposal(), self.advance_ledger)
        self.claim_and_explore()
        with self.assertRaisesRegex(advance.HarnessError, "owned by worker-a"):
            advance.transition_advance(
                "A1", "PROVED_LOCAL", worker_id="worker-b",
                evidence=self.proved_evidence(), path=self.advance_ledger,
            )

    def test_verification_must_be_independent_and_evidenced(self) -> None:
        advance.propose_advance(self.proposal(), self.advance_ledger)
        self.claim_and_explore()
        advance.transition_advance(
            "A1", "PROVED_LOCAL", worker_id="worker-a",
            evidence=self.proved_evidence(), path=self.advance_ledger,
        )
        with self.assertRaisesRegex(advance.HarnessError, "independent verifier"):
            advance.transition_advance(
                "A1", "VERIFIED", worker_id="worker-a",
                evidence=self.verified_evidence("worker-a"), path=self.advance_ledger,
            )

    def test_proved_local_requires_substantive_evidence(self) -> None:
        advance.propose_advance(self.proposal(), self.advance_ledger)
        self.claim_and_explore()
        with self.assertRaisesRegex(advance.HarnessError, "lacks evidence"):
            advance.transition_advance(
                "A1", "PROVED_LOCAL", worker_id="worker-a",
                evidence={"lean_files": ["OnlyFile.lean"]}, path=self.advance_ledger,
            )

    def test_blocked_requires_a_strictly_smaller_boundary(self) -> None:
        advance.propose_advance(self.proposal(), self.advance_ledger)
        self.claim_and_explore()
        with self.assertRaisesRegex(advance.HarnessError, "BLOCKED lacks substantive evidence"):
            advance.transition_advance(
                "A1", "BLOCKED", worker_id="worker-a",
                evidence={"blocker": "Lean failed"}, path=self.advance_ledger,
            )
        advance.transition_advance(
            "A1", "BLOCKED", worker_id="worker-a",
            evidence={
                "blocker_class": "mathlib-api",
                "blocker": "missing finite-measure integral rewrite",
                "strict_reduction": "isolated one exact API bridge",
                "next_smaller_delta": "prove integral_smul_normalize",
            },
            path=self.advance_ledger,
        )

    def test_no_progress_guard_freezes_fourth_unchanged_checkpoint(self) -> None:
        advance.propose_advance(self.proposal(), self.advance_ledger)
        self.claim_and_explore()
        for _ in range(3):
            checkpoint = advance.checkpoint_advance(
                "A1", worker_id="worker-a", route_fingerprint="route-1",
                progress_signature="same residual", mathematical_delta="none",
                exact_residual="one unchanged coercion goal", context_characters=1200,
                path=self.advance_ledger,
            )
        self.assertTrue(checkpoint["needs_diagnosis"])
        with self.assertRaisesRegex(advance.HarnessError, "route frozen"):
            advance.checkpoint_advance(
                "A1", worker_id="worker-a", route_fingerprint="route-1",
                progress_signature="same residual", mathematical_delta="none",
                exact_residual="one unchanged coercion goal", path=self.advance_ledger,
            )
        changed = advance.checkpoint_advance(
            "A1", worker_id="worker-a", route_fingerprint="route-2",
            progress_signature="new smaller residual", mathematical_delta="retired route-1",
            exact_residual="one localized map-measurability goal", path=self.advance_ledger,
        )
        self.assertFalse(changed["needs_diagnosis"])

    def test_discovery_bus_deduplicates_and_carries_cell_synthesis(self) -> None:
        advance.propose_advance(self.proposal(), self.advance_ledger)
        synthesis = advance.Discovery(
            discovery_id="D1", advance_id="A1", kind="synthesis",
            statement="cost cell has two independent leaves and one shared normalization parent",
            evidence="A1/A2 declarations and exact DAG parents checked",
            where_it_matters="global arbiter should schedule the join only after both leaves",
            provenance="worker-a local frontier synthesis", created_by="worker-a",
            frontier_cell="brenier-cost",
        )
        advance.publish_discovery(synthesis, self.discovery_ledger)
        with self.assertRaisesRegex(advance.HarnessError, "duplicate active discovery"):
            advance.publish_discovery(
                advance.Discovery(
                    **{**synthesis.__dict__, "discovery_id": "D2", "created_by": "worker-b"}
                ),
                self.discovery_ledger,
            )
        advance.transition_discovery(
            "D1", "validated", actor="verifier-c",
            note="cell graph delta and referenced declarations checked",
            path=self.discovery_ledger,
        )
        capsule = advance.coordinator_capsule(
            self.advance_ledger, self.discovery_ledger,
            max_advances=4, max_discoveries=4, max_cells=4,
        )
        self.assertEqual(capsule["discoveries"][0]["discovery_id"], "D1")
        self.assertEqual(capsule["frontier_cells"][0]["frontier_cell"], "brenier-cost")
        self.assertEqual(capsule["frontier_cells"][0]["validated_syntheses"], ["D1"])
        self.assertFalse(capsule["raw_worker_transcripts_included"])
        self.assertGreater(capsule["serialized_characters"], 0)

    def test_interrupted_tail_is_recovered(self) -> None:
        advance.propose_advance(self.proposal(), self.advance_ledger)
        with self.advance_ledger.open("ab") as handle:
            handle.write(b'{"event":"interrupted"')
        state = advance.current_advances(self.advance_ledger)
        self.assertIn("A1", state)
        self.assertTrue(self.advance_ledger.read_bytes().endswith(b"\n"))


if __name__ == "__main__":
    unittest.main()
