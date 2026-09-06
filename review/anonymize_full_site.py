#!/usr/bin/env python3
"""Post-process the complete generated reader for double-blind review.

This script changes presentation/provenance surfaces only.  It does not rewrite
Lean sources, theorem statements, graph evidence, source maps, or mathematical
status.  Run normal site/Lean validation first, then this script, then the
review-site identity/browser checks.
"""
from __future__ import annotations

import argparse
import html
import re
from pathlib import Path
from urllib.parse import unquote

ANON_REPO = "https://anonymous.4open.science/r/Auto-Sampling-Theory-In-Sleep-CE8E/"
PUBLIC_REPO = "https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep"
PUBLIC_SITE = "https://dakebu.github.io/Auto-Sampling-Theory-In-Sleep"

# Sinho Chewi is deliberately not globally redacted: he is a primary textbook
# author and must remain named in bibliographic/source attribution.  The project
# author footer that also contains his name is removed as one semantic block.
PROJECT_IDENTITY_TERMS = [
    "Dake Bu",
    "Ji Cheng",
    "Huanjian Zhou",
    "Andi Han",
    "Zonghao Chen",
    "Matthew S. Zhang",
    "Hau-San Wong",
    "Qingfu Zhang",
    "Atsushi Nitanda",
]
TEXT_SUFFIXES = {".html", ".htm", ".css", ".js", ".json", ".txt", ".xml", ".svg", ".md"}


def _rewrite_repo_links(text: str) -> str:
    # Exact blob/tree links become anonymous-proxy file links.  The proxy URL is
    # intentionally reviewer-facing; the underlying owner/repository is never
    # exposed by the final static site.
    pattern = re.compile(
        r"https://github\.com/DakeBU/Auto-Sampling-Theory-In-Sleep/"
        r"(?:blob|tree)/[^/]+/([^\s\"'<>?#)]+)"
    )
    text = pattern.sub(lambda m: ANON_REPO + m.group(1), text)
    text = text.replace(PUBLIC_REPO + "/", ANON_REPO)
    text = text.replace(PUBLIC_REPO, ANON_REPO.rstrip("/"))
    # Public Pages links are internal navigation in the review snapshot.
    text = text.replace(PUBLIC_SITE + "/", "/")
    text = text.replace(PUBLIC_SITE, "")
    return text


def _strip_project_author_blocks(text: str) -> str:
    # Generated footer used by the live site.
    text = re.sub(
        r"<p><strong>Organizer \(Authors\):</strong>.*?</p>",
        '<p><strong>Review snapshot:</strong> Anonymous submission.</p>',
        text,
        flags=re.IGNORECASE | re.DOTALL,
    )
    text = re.sub(
        r"<p><strong>Project contributors:</strong>.*?</p>",
        "",
        text,
        flags=re.IGNORECASE | re.DOTALL,
    )
    # Markdown/escaped variants can occur in generated source-reader panes.
    text = re.sub(
        r"\*\*Project contributors:\*\*[^\n<]*",
        "**Project contributors:** Anonymous during review.",
        text,
        flags=re.IGNORECASE,
    )
    return text


def _inject_review_headers(text: str) -> str:
    if "<head" not in text.lower():
        return text
    injection = (
        '<meta name="robots" content="noindex,nofollow,noarchive">\n'
        '<meta name="referrer" content="no-referrer">\n'
    )
    if 'name="robots"' not in text.lower():
        text = re.sub(r"(<head[^>]*>)", r"\1\n" + injection, text, count=1, flags=re.IGNORECASE)
    elif 'name="referrer"' not in text.lower():
        text = re.sub(
            r"(<head[^>]*>)",
            r'\1\n<meta name="referrer" content="no-referrer">',
            text,
            count=1,
            flags=re.IGNORECASE,
        )
    return text


def rewrite_text(text: str, *, is_html: bool) -> str:
    text = _strip_project_author_blocks(text)
    text = _rewrite_repo_links(text)
    for term in PROJECT_IDENTITY_TERMS:
        text = text.replace(term, "Anonymous Author")
    # Account/username strings can occur inside URLs, badges, generated git
    # provenance, or source excerpts.
    text = re.sub(r"(?i)DakeBU", "anonymous", text)
    text = re.sub(r"159223240\+anonymous@users\.noreply\.github\.com", "anonymous@users.noreply.github.com", text)
    if is_html:
        text = _inject_review_headers(text)
    return text


def scan(root: Path) -> list[str]:
    problems: list[str] = []
    banned = [
        re.compile(r"Dake\s+Bu", re.I),
        re.compile(r"DakeBU", re.I),
        re.compile(r"github\.com/DakeBU/Auto-Sampling-Theory-In-Sleep", re.I),
        re.compile(r"dakebu\.github\.io/Auto-Sampling-Theory-In-Sleep", re.I),
    ]
    for path in root.rglob("*"):
        if not path.is_file() or path.suffix.lower() not in TEXT_SUFFIXES:
            continue
        try:
            text = html.unescape(unquote(path.read_text(encoding="utf-8")))
        except UnicodeDecodeError:
            continue
        for pattern in banned:
            if pattern.search(text):
                problems.append(f"{path.relative_to(root)}: {pattern.pattern}")
    return problems


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("site", type=Path)
    args = parser.parse_args()
    root = args.site.resolve()
    if not root.is_dir():
        raise SystemExit(f"site directory not found: {root}")

    changed = 0
    for path in root.rglob("*"):
        if not path.is_file() or path.suffix.lower() not in TEXT_SUFFIXES:
            continue
        try:
            before = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        after = rewrite_text(before, is_html=path.suffix.lower() in {".html", ".htm"})
        if after != before:
            path.write_text(after, encoding="utf-8")
            changed += 1

    (root / "robots.txt").write_text("User-agent: *\nDisallow: /\n", encoding="utf-8")
    (root / "_headers").write_text(
        "/*\n"
        "  X-Robots-Tag: noindex, nofollow, noarchive\n"
        "  Referrer-Policy: no-referrer\n"
        "  X-Content-Type-Options: nosniff\n"
        "  Permissions-Policy: camera=(), microphone=(), geolocation=()\n",
        encoding="utf-8",
    )

    problems = scan(root)
    if problems:
        print("Anonymous-site identity scan: FAIL")
        for problem in problems[:50]:
            print(" -", problem)
        return 1
    print(f"Anonymous-site post-processing: PASS ({changed} files rewritten)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
