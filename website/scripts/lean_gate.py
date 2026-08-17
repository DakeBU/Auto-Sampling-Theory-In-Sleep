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


def github_command_escape(text: str) -> str:
    """Escape a short diagnostic for the GitHub Actions workflow-command syntax."""
    return text.replace("%", "%25").replace("\r", "%0D").replace("\n", "%0A")


def diagnostic_tail(text: str, *, lines: int = 180) -> str:
    """Keep enough failing Lean context for CI-only debugging without dumping the full build."""
    rows = [row for row in text.splitlines() if row.strip()]
    return "\n".join(rows[-lines:])


def main() -> int:
    command = [sys.executable, "tools/astis.py", "check"]
    result = subprocess.run(
        command,
        cwd=ROOT,
        check=False,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    output = result.stdout or ""
    if output:
        print(output, end="" if output.endswith("\n") else "\n")
    if result.returncode != 0:
        tail = diagnostic_tail(output)
        if tail:
            print(
                "::error title=ASTIS Lean gate failed::"
                + github_command_escape(tail)
            )
        else:
            print("::error title=ASTIS Lean gate failed::tools/astis.py check exited nonzero with no captured output")
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
        json.dumps(evidence, indent=2, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n"
    )
    temporary.replace(target)
    print(f"Recorded current Lean gate evidence at {target.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
