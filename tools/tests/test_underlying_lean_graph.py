from __future__ import annotations

import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
GRAPH_JS = ROOT / "website" / "static" / "underlying-lean-graph.js"
GRAPH_CSS = ROOT / "website" / "static" / "underlying-lean-graph.css"
GRAPH_BUILDER = ROOT / "website" / "scripts" / "underlying_lean_graph.py"


class UnderlyingLeanGraphInteractionTests(unittest.TestCase):
    def test_focus_preserves_context_and_marks_direct_relations(self) -> None:
        js = GRAPH_JS.read_text(encoding="utf-8")
        self.assertIn("Focus is a visual overlay, not a graph filter", js)
        self.assertIn('classes.push(related ? "related" : "muted")', js)
        self.assertIn('focusNeighbors.has(n.id)', js)
        self.assertIn('direct relations highlighted', js)
        self.assertIn('Escape', js)

    def test_formal_and_curated_edges_have_distinct_evidence_styles(self) -> None:
        js = GRAPH_JS.read_text(encoding="utf-8")
        css = GRAPH_CSS.read_text(encoding="utf-8")
        builder = GRAPH_BUILDER.read_text(encoding="utf-8")

        for relation in ("imports", "declares", "depends-on", "closes leaf"):
            self.assertIn(f'"{relation}"', js)
        self.assertIn("FORMAL_RELATIONS", js)
        self.assertIn('`${relationEvidence(e.relation)}-edge`', js)
        self.assertIn('data-evidence', js)

        self.assertIn(".ulg-edge.formal-edge", css)
        self.assertIn(".ulg-edge.overlay-edge", css)
        self.assertIn("stroke-dasharray:none", css)
        self.assertIn("stroke-dasharray:7 5", css)
        self.assertIn(".ulg-edge.related", css)
        self.assertIn(".ulg-edge.muted", css)
        self.assertIn(".ulg-node.related", css)
        self.assertIn(".ulg-node.muted", css)

        self.assertIn("Solid edges", builder)
        self.assertIn("dashed edges", builder)
        self.assertIn("ulg-line-key formal", builder)
        self.assertIn("ulg-line-key overlay", builder)


if __name__ == "__main__":
    unittest.main()
