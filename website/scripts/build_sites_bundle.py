#!/usr/bin/env python3
"""Package the checked ASTIS static site behind a minimal OpenNext entrypoint."""

from __future__ import annotations

import argparse
import json
import shutil
import tarfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SITE = ROOT / "_site"
BUNDLE = ROOT / ".open-next"
HOSTING = ROOT / ".openai" / "hosting.json"

WORKER = """\
export default {
  async fetch(request, env) {
    const direct = await env.ASSETS.fetch(request);
    if (direct.status !== 404 || !["GET", "HEAD"].includes(request.method)) {
      return direct;
    }

    const url = new URL(request.url);
    const candidates = url.pathname.endsWith("/")
      ? [`${url.pathname}index.html`]
      : [`${url.pathname}.html`, `${url.pathname}/index.html`];

    for (const pathname of candidates) {
      url.pathname = pathname;
      const response = await env.ASSETS.fetch(new Request(url, request));
      if (response.status !== 404) return response;
    }
    return direct;
  },
};
"""


def build_bundle() -> None:
    if not (SITE / "index.html").is_file():
        raise SystemExit("generated _site/index.html is missing; run build_site.py first")
    if not (SITE / "search-index.json").is_file():
        raise SystemExit("generated search index is missing")
    if not HOSTING.is_file() or not json.loads(HOSTING.read_text(encoding="utf-8")).get(
        "project_id"
    ):
        raise SystemExit(".openai/hosting.json is missing a project_id")

    shutil.rmtree(BUNDLE, ignore_errors=True)
    shutil.copytree(SITE, BUNDLE / "assets")
    (BUNDLE / "worker.js").write_text(WORKER, encoding="utf-8", newline="\n")


def write_archive(target: Path) -> None:
    target.parent.mkdir(parents=True, exist_ok=True)
    with tarfile.open(target, "w:gz") as archive:
        archive.add(BUNDLE, arcname=".open-next")
        archive.add(HOSTING, arcname=".openai/hosting.json")
        archive.add(ROOT / "package.json", arcname="package.json")
        archive.add(ROOT / "wrangler.jsonc", arcname="wrangler.jsonc")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--archive",
        type=Path,
        help="optional .tar.gz path for the exact generated deployment bundle",
    )
    args = parser.parse_args()
    build_bundle()
    entries = sum(1 for _ in (BUNDLE / "assets").rglob("*"))
    print(f"built {BUNDLE.relative_to(ROOT)} with {entries} entries")
    if args.archive:
        target = args.archive.resolve()
        write_archive(target)
        print(f"wrote {target}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
