from __future__ import annotations

import copy
import json
import unittest

from tools.astis_semantic_roundtrip import (
    DECODER_INPUT_ARTIFACTS,
    SEMANTIC_SLOTS,
    decoder_packet,
    semantic_reviewer_packet,
    sha256_text,
    validate_registry,
)


def valid_registry() -> dict:
    source_text = "For every x in the domain, P x implies Q x."
    lean_statement = "∀ x : α, P x → Q x"
    reconstructed_text = "For every x of type α, if P x holds, then Q x holds."
    repaired_text = "Assume x lies in α; if P x holds, then Q x holds."
    slots = {
        slot: {
            "original": f"source {slot}",
            "reconstructed": f"source {slot}",
            "relation": "same",
            "evidence": f"the {slot} agree",
        }
        for slot in SEMANTIC_SLOTS
    }
    audit = {
        "id": "ASTIS-RT-TEST-001",
        "state": "accepted",
        "graph_node": "source:test",
        "source": {
            "source_id": "SOURCE-SECRET-99",
            "anchor": "Theorem 1",
            "original_text": source_text,
            "text_sha256": sha256_text(source_text),
        },
        "lean": {
            "declaration": "Test.theoremOne",
            "file": "Test.lean",
            "statement": lean_statement,
            "statement_sha256": sha256_text(lean_statement),
            "compiled": True,
            "formalizer": "formalizer-test",
            "decoder_context": ["P : α → Prop", "Q : α → Prop"],
        },
        "semantic_slots": slots,
        "deltas": [],
        "verdict": "exact",
        "source_review": {
            "state": "accepted",
            "reviewer": "independent-reviewer",
            "independent_from_formalizer": True,
            "independent_from_decoder": True,
            "evidence": "slot-by-slot comparison checked",
        },
        "repairs": [],
    }
    packet = decoder_packet(audit)
    audit["reconstruction"] = {
        "text": reconstructed_text,
        "text_sha256": sha256_text(reconstructed_text),
        "decoder": "independent-decoder-test",
        "decoder_run_sha256": sha256_text("decoder-run-test"),
        "decoder_packet_sha256": packet["packet_sha256"],
        "source_text_visible": False,
        "lean_statement_sha256": sha256_text(lean_statement),
        "input_artifacts": packet["input_artifacts"],
    }
    audit["_test_repaired_text"] = repaired_text
    return {
        "schema_version": 1,
        "protocol": {
            "name": "ASTIS Semantic Round-Trip",
            "status": "active",
            "decoder_blindness": "required",
            "independent_source_review": "required",
            "decoder_allowed_inputs": list(DECODER_INPUT_ARTIFACTS),
            "semantic_slots": list(SEMANTIC_SLOTS),
        },
        "audits": [audit],
    }


class SemanticRoundTripTests(unittest.TestCase):
    def test_valid_exact_audit_passes(self) -> None:
        registry = valid_registry()
        registry["audits"][0].pop("_test_repaired_text")
        self.assertEqual(validate_registry(registry), [])

    def test_decoder_packet_is_anonymous_and_source_blind(self) -> None:
        audit = copy.deepcopy(valid_registry()["audits"][0])
        packet = decoder_packet(audit)
        encoded = json.dumps(packet)
        for secret in (
            audit["id"],
            audit["source"]["original_text"],
            audit["source"]["source_id"],
            audit["source"]["anchor"],
            audit["lean"]["declaration"],
            audit["lean"]["file"],
        ):
            self.assertNotIn(secret, encoded)
        self.assertFalse(packet["non_disclosure"]["source_text_included"])
        self.assertFalse(packet["non_disclosure"]["audit_identity_included"])
        self.assertEqual(packet["lean"]["statement"], audit["lean"]["statement"])
        self.assertEqual(packet["input_artifacts"], list(DECODER_INPUT_ARTIFACTS))
        self.assertEqual(len(packet["packet_sha256"]), 64)

    def test_decoder_that_saw_source_or_used_wrong_packet_is_rejected(self) -> None:
        registry = valid_registry()
        audit = registry["audits"][0]
        audit.pop("_test_repaired_text")
        reconstruction = audit["reconstruction"]
        reconstruction["source_text_visible"] = True
        reconstruction["input_artifacts"].append("original-theorem")
        reconstruction["decoder_packet_sha256"] = sha256_text("wrong-packet")
        errors = validate_registry(registry)
        self.assertTrue(any("source_text_visible=false" in error for error in errors))
        self.assertTrue(any("canonical blind packet" in error for error in errors))
        self.assertTrue(any("input_artifacts" in error for error in errors))

    def test_formalizer_decoder_and_reviewer_must_be_distinct(self) -> None:
        registry = valid_registry()
        audit = registry["audits"][0]
        audit.pop("_test_repaired_text")
        audit["reconstruction"]["decoder"] = audit["lean"]["formalizer"]
        audit["source_review"]["reviewer"] = audit["lean"]["formalizer"]
        errors = validate_registry(registry)
        self.assertTrue(any("decoder must be independent" in error for error in errors))
        self.assertTrue(any("reviewer identity must differ" in error for error in errors))

    def test_accepted_repair_requires_review_hash_and_real_reference(self) -> None:
        registry = valid_registry()
        audit = registry["audits"][0]
        repaired_text = audit.pop("_test_repaired_text")
        audit["state"] = "semantic-diffed"
        audit["verdict"] = "source-underspecified"
        audit["source_review"] = {
            "state": "pending",
            "reviewer": "",
            "independent_from_formalizer": False,
            "independent_from_decoder": False,
            "evidence": "",
        }
        audit["repairs"] = [
            {
                "id": "ASTIS-REPAIR-TEST-001",
                "class": "assumption-addition",
                "status": "accepted",
                "necessity": "mathematically-necessary",
                "proposed_change": "Add measurability of f.",
                "reconstructed_statement": repaired_text,
                "statement_sha256": sha256_text(repaired_text),
                "justification": "The integral is otherwise not defined.",
                "minimality_evidence": "Only measurability is used.",
                "reference_or_counterexample": "none",
            }
        ]
        errors = validate_registry(registry)
        self.assertTrue(any("accepted source review" in error for error in errors))
        self.assertTrue(any("real reference or counterexample" in error for error in errors))
        self.assertTrue(any("state=accepted" in error for error in errors))

    def test_formalization_artifact_cannot_be_accepted_as_source_repair(self) -> None:
        registry = valid_registry()
        audit = registry["audits"][0]
        repaired_text = audit.pop("_test_repaired_text")
        audit["verdict"] = "source-underspecified"
        audit["repairs"] = [
            {
                "id": "ASTIS-REPAIR-TEST-002",
                "class": "assumption-addition",
                "status": "accepted",
                "necessity": "formalization-artifact-risk",
                "proposed_change": "Add boundedness.",
                "reconstructed_statement": repaired_text,
                "statement_sha256": sha256_text(repaired_text),
                "justification": "Current proof route uses it.",
                "minimality_evidence": "No source-level necessity was established.",
                "reference_or_counterexample": "A cited proof-route note, not a source correction.",
            }
        ]
        errors = validate_registry(registry)
        self.assertTrue(any("cannot be accepted as source repair" in error for error in errors))
        self.assertTrue(any("mathematically necessary or source implicit" in error for error in errors))

    def test_reviewer_packet_is_anti_anchored_but_contains_comparison_inputs(self) -> None:
        audit = copy.deepcopy(valid_registry()["audits"][0])
        packet = semantic_reviewer_packet(audit)
        encoded = json.dumps(packet, ensure_ascii=False)
        self.assertIn(audit["source"]["original_text"], encoded)
        self.assertIn(audit["reconstruction"]["text"], encoded)
        self.assertNotIn('"verdict": "exact"', encoded)
        self.assertNotIn("slot-by-slot comparison checked", encoded)
        self.assertTrue(packet["anti_anchoring"]["prior_repairs_included"] is False)
        self.assertEqual(set(packet["output_contract"]["semantic_slots"]), set(SEMANTIC_SLOTS))
        self.assertEqual(len(packet["packet_sha256"]), 64)


if __name__ == "__main__":
    unittest.main()
