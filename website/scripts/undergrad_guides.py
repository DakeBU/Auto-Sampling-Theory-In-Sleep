#!/usr/bin/env python3
"""Render a beginner-first learning path into Chapter 1 textbook sections.

The layer is pedagogical only. It does not change source correspondence,
Registry status, or completion evidence. Its job is to give a mathematics
undergraduate a conceptual story, tiny examples, and a vocabulary ramp before
the source-item stream and the rigorous/Lean layers.
"""

from __future__ import annotations

import argparse
import html
import json
import os
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
CONTENT = ROOT / "website" / "content"
DEFAULT_OUTPUT = ROOT / "_site"
START = "<!-- ASTIS_UNDERGRAD_GUIDE_START -->"
END = "<!-- ASTIS_UNDERGRAD_GUIDE_END -->"


def esc(value: object) -> str:
    return html.escape(str(value), quote=True)


def slugify(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9]+", "-", value).strip("-").lower()
    return value or "entry"


def section_path(output: Path, section: str) -> Path:
    chapter = int(section.split(".", 1)[0])
    return output / "textbook" / f"chapter-{chapter:02d}" / f"section-{slugify(section)}.html"


def load_guides() -> dict[str, dict[str, object]]:
    path = CONTENT / "undergrad_guides.json"
    raw = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(raw, dict):
        raise RuntimeError("undergrad_guides.json must contain an object keyed by section id")
    required = {"audience", "question", "promise", "before_you_start", "story", "vocabulary"}
    guides: dict[str, dict[str, object]] = {}
    for section, candidate in raw.items():
        if not re.fullmatch(r"\d+\.\d+", str(section)):
            raise RuntimeError(f"invalid undergraduate guide section id: {section}")
        if not isinstance(candidate, dict):
            raise RuntimeError(f"guide {section} must be an object")
        missing = sorted(required.difference(candidate))
        if missing:
            raise RuntimeError(f"guide {section} is missing fields: {missing}")
        if not list(candidate["story"]):
            raise RuntimeError(f"guide {section} has an empty story")
        if not list(candidate["vocabulary"]):
            raise RuntimeError(f"guide {section} has an empty vocabulary")
        guides[str(section)] = dict(candidate)
    return guides


def normalize_story(item: object, index: int) -> dict[str, str]:
    if isinstance(item, dict):
        return {
            "title": str(item.get("title", f"Step {index}")),
            "intuition": str(item.get("intuition", "")),
            "tiny_example": str(item.get("tiny_example", "")),
            "remember": str(item.get("remember", "")),
        }
    if isinstance(item, list) and len(item) >= 2:
        return {
            "title": str(item[0]),
            "intuition": str(item[1]),
            "tiny_example": str(item[2]) if len(item) >= 3 else "",
            "remember": str(item[3]) if len(item) >= 4 else "",
        }
    raise RuntimeError(f"story step {index} must be an object or [title, explanation] pair")


def normalize_vocab(item: object) -> tuple[str, str]:
    if isinstance(item, list) and len(item) == 2:
        return str(item[0]), str(item[1])
    if isinstance(item, dict) and "term" in item and "plain" in item:
        return str(item["term"]), str(item["plain"])
    raise RuntimeError("vocabulary entry must be [term, explanation] or {term, plain}")


def render_guide(section: str, guide: dict[str, object]) -> str:
    before = "".join(f"<li>{esc(item)}</li>" for item in list(guide["before_you_start"]))
    story = []
    for index, raw in enumerate(list(guide["story"]), 1):
        item = normalize_story(raw, index)
        tiny = (
            f'<div class="tiny-example"><strong>Tiny example.</strong> {esc(item["tiny_example"])}</div>'
            if item["tiny_example"] else ""
        )
        remember = (
            f'<div class="remember-box"><strong>Only remember this for now.</strong> {esc(item["remember"])}</div>'
            if item["remember"] else ""
        )
        story.append(
            f"""<article class="story-step">
  <div class="story-step-number">{index:02d}</div>
  <div><h3>{esc(item['title'])}</h3><p>{esc(item['intuition'])}</p>{tiny}{remember}</div>
</article>"""
        )
    vocab = []
    for raw in list(guide["vocabulary"]):
        term, plain = normalize_vocab(raw)
        vocab.append(f'<div class="vocabulary-card"><dt>{esc(term)}</dt><dd>{esc(plain)}</dd></div>')
    return f"""{START}
<section class="undergrad-guide" id="undergrad-guide" data-undergrad-guide="{esc(section)}">
  <header class="undergrad-guide-header">
    <span class="eyebrow">Start here · undergraduate path</span>
    <h2>{esc(guide['question'])}</h2>
    <p class="guide-question">Audience: {esc(guide['audience'])}</p>
    <p>{esc(guide['promise'])}</p>
  </header>
  <div class="undergrad-guide-body">
    <div class="undergrad-start-here">
      <div><h3>Before you start</h3><ul>{before}</ul></div>
      <div><h3>How to use this page</h3><p>First read only the story ladder and tiny examples. Then read the textbook-facing theorem cards. Open rigorous details only when you want to know why a step is legal. Open Lean learner mode last, where the same result is decomposed into exact declarations and proof dependencies.</p></div>
    </div>
    <h3>The story of Section {esc(section)}</h3>
    <div class="story-ladder">{''.join(story)}</div>
    <h3>Vocabulary you may meet</h3>
    <dl class="vocabulary-grid">{''.join(vocab)}</dl>
    <div class="guide-depth-note"><strong>Three-layer rule.</strong> A beginner explanation may simplify the route, but it never changes the theorem statement. The rigorous layer records hidden assumptions and source references; the Lean layer records the exact formal claim and certificate.</div>
  </div>
</section>
{END}"""


def strip_existing(text: str) -> str:
    return re.sub(re.escape(START) + r".*?" + re.escape(END), "", text, flags=re.DOTALL)


def asset_href(page: Path, output: Path) -> str:
    return os.path.relpath(output / "assets" / "undergrad-guide.css", page.parent).replace(os.sep, "/")


def enrich_site(output: Path = DEFAULT_OUTPUT) -> int:
    guides = load_guides()
    asset = output / "assets" / "undergrad-guide.css"
    if not asset.exists():
        raise RuntimeError("generated assets/undergrad-guide.css is missing")
    changed = 0
    for section, guide in guides.items():
        path = section_path(output, section)
        if not path.exists():
            raise RuntimeError(f"generated textbook section does not exist: {path}")
        text = strip_existing(path.read_text(encoding="utf-8"))
        marker = '<div class="reader-prose">'
        if marker not in text:
            raise RuntimeError(f"reader-prose marker missing in {path}")
        css = asset_href(path, output)
        text = re.sub(r'\n?\s*<link rel="stylesheet" href="[^"]*undergrad-guide\.css">', "", text)
        text = text.replace("</head>", f'  <link rel="stylesheet" href="{css}">\n</head>', 1)
        text = text.replace(marker, render_guide(section, guide) + "\n  " + marker, 1)
        path.write_text(text, encoding="utf-8")
        changed += 1
    return changed


def validate_site(output: Path = DEFAULT_OUTPUT) -> list[str]:
    errors: list[str] = []
    try:
        guides = load_guides()
    except Exception as exc:
        return [str(exc)]
    if not (output / "assets" / "undergrad-guide.css").exists():
        errors.append("generated assets/undergrad-guide.css is missing")
    for section, guide in guides.items():
        path = section_path(output, section)
        if not path.exists():
            errors.append(f"missing undergraduate section page: {path}")
            continue
        text = path.read_text(encoding="utf-8")
        checks = (
            (text.count(START) == 1 and text.count(END) == 1, "guide marker"),
            (f'data-undergrad-guide="{section}"' in text, "section identity"),
            ("undergraduate path" in text, "beginner label"),
            (esc(guide["question"]) in text, "guiding question"),
            ("story-ladder" in text, "story ladder"),
            ("vocabulary-grid" in text, "vocabulary grid"),
            ("undergrad-guide.css" in text, "guide stylesheet"),
            ("Three-layer rule" in text, "scope boundary"),
        )
        for ok, label in checks:
            if not ok:
                errors.append(f"{path}: missing {label}")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", default=str(DEFAULT_OUTPUT))
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    output = Path(args.output).resolve()
    if args.check:
        errors = validate_site(output)
        for error in errors:
            print(f"ERROR: {error}")
        return 1 if errors else 0
    changed = enrich_site(output)
    print(f"Rendered undergraduate guides into {changed} Chapter 1 section(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
