from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[2]
BUILD_SITE = ROOT / "website" / "scripts" / "build_site.py"
README = ROOT / "README.md"

CANONICAL_NAMES = [
    "Dake Bu",
    "Ji Cheng",
    "Huanjian Zhou",
    "Andi Han",
    "Zonghao Chen",
    "Sinho Chewi",
    "Matthew S. Zhang",
    "Hau-San Wong",
    "Qingfu Zhang",
    "Atsushi Nitanda",
]


class ProjectAuthorsFooterTests(unittest.TestCase):
    def test_footer_uses_canonical_organizer_authors_order(self) -> None:
        text = BUILD_SITE.read_text(encoding="utf-8")
        marker = '<p><strong>Organizer (Authors):</strong>'
        self.assertIn(marker, text)
        start = text.index(marker)
        end = text.index("</p>", start)
        footer = text[start:end]
        positions = [footer.index(name) for name in CANONICAL_NAMES]
        self.assertEqual(positions, sorted(positions))
        self.assertIn("repair_project_author_footer(output)", text)

    def test_readme_authors_match_footer_membership(self) -> None:
        readme = README.read_text(encoding="utf-8")
        for name in CANONICAL_NAMES:
            self.assertIn(name, readme)


if __name__ == "__main__":
    unittest.main()
