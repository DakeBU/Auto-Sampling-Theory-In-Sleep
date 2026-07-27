#!/usr/bin/env python3
"""Run the canonical ASTIS Lean gate and record source-bound site evidence."""

from __future__ import annotations

import datetime as dt
import json
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))

import astis_site  # noqa: E402


def main() -> int:
    command = [sys.executable, "tools/astis.py", "check"]
    result = subprocess.run(command, cwd=ROOT, check=False)
    if result.returncode != 0:
        print("Lean gate failed; no site evidence was written.", file=sys.stderr)
        return result.returncode

    commit = subprocess.run(
        ["git", "rev-parse", "HEAD"],
        cwd=ROOT,
        check=True,
        text=True,
        stdout=subprocess.PIPE,
    ).stdout.strip()
    evidence = {
        "passed": True,
        "commit": commit,
        "source_digest": astis_site.source_digest(),
        "generated_at": dt.datetime.now(dt.timezone.utc).isoformat(),
        "commands": ["python3 tools/astis.py check"],
        "note": "The canonical ASTIS gate ran Lake build, Tests, and fake-proof checks.",
    }
    target = astis_site.GATE_EVIDENCE
    target.parent.mkdir(parents=True, exist_ok=True)
    temporary = target.with_suffix(".tmp")
    temporary.write_text(
        json.dumps(evidence, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    temporary.replace(target)
    print(f"Recorded current Lean gate evidence at {target.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
