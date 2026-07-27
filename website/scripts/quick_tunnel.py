#!/usr/bin/env python3
"""Run the authenticated ASTIS preview behind a temporary cloudflared tunnel."""

from __future__ import annotations

import argparse
import os
import shutil
import socket
import subprocess
import sys
import time
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


def wait_for_port(host: str, port: int, process: subprocess.Popen[bytes]) -> None:
    deadline = time.monotonic() + 15
    while time.monotonic() < deadline:
        if process.poll() is not None:
            raise RuntimeError("authenticated preview server exited before startup")
        try:
            with socket.create_connection((host, port), timeout=0.4):
                return
        except OSError:
            time.sleep(0.2)
    raise RuntimeError("timed out waiting for authenticated preview server")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--port", type=int, default=int(os.environ.get("ASTIS_PREVIEW_PORT", "8765")))
    parser.add_argument("--directory", default=str(ROOT / "_site"))
    args = parser.parse_args()
    if not os.environ.get("ASTIS_PREVIEW_USER") or not os.environ.get("ASTIS_PREVIEW_PASSWORD"):
        parser.error("set ASTIS_PREVIEW_USER and ASTIS_PREVIEW_PASSWORD")
    cloudflared = shutil.which("cloudflared")
    if not cloudflared:
        parser.error("cloudflared is not installed or not on PATH")

    server_command = [
        sys.executable,
        str(ROOT / "website" / "scripts" / "serve_preview.py"),
        "--host",
        "127.0.0.1",
        "--port",
        str(args.port),
        "--directory",
        args.directory,
    ]
    server = subprocess.Popen(server_command, cwd=ROOT)
    try:
        wait_for_port("127.0.0.1", args.port, server)
        tunnel = subprocess.run(
            [
                cloudflared,
                "tunnel",
                "--url",
                f"http://127.0.0.1:{args.port}",
                "--no-autoupdate",
            ],
            cwd=ROOT,
            check=False,
        )
        return tunnel.returncode
    finally:
        server.terminate()
        try:
            server.wait(timeout=5)
        except subprocess.TimeoutExpired:
            server.kill()


if __name__ == "__main__":
    raise SystemExit(main())
