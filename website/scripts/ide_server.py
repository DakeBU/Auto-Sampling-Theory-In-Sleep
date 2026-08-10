#!/usr/bin/env python3
"""Serve Samplinglib with loopback-only formalization and Lean compilation."""

from __future__ import annotations

import argparse
import base64
import hmac
import json
import os
import subprocess
import sys
import tempfile
import threading
import time
from functools import partial
from http import HTTPStatus
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import urlsplit


ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from tools.astis_formalizer import (  # noqa: E402
    MAX_LATEX_CHARACTERS,
    formalize,
    request_from_dict,
)


DEFAULT_SITE = ROOT / "_site"
MAX_SOURCE_BYTES = 200_000
MAX_REQUEST_BYTES = 240_000
COMPILE_LOCK = threading.Lock()


def lean_version() -> str:
    try:
        result = subprocess.run(
            ["lake", "env", "lean", "--version"],
            cwd=ROOT,
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
            timeout=30,
            check=False,
        )
    except (OSError, subprocess.TimeoutExpired) as error:
        return f"Lean unavailable: {error}"
    return (result.stdout or result.stderr).strip().splitlines()[0]


class SamplinglibIDEHandler(SimpleHTTPRequestHandler):
    server_version = "SamplinglibLocalIDE/0.1"
    lean_version_text = "Lean version not checked"
    compile_timeout = 120
    auth_user = ""
    auth_password = ""

    def authorized(self) -> bool:
        if not self.auth_user and not self.auth_password:
            return True
        value = self.headers.get("Authorization", "")
        if not value.startswith("Basic "):
            return False
        try:
            decoded = base64.b64decode(value[6:], validate=True).decode("utf-8")
            user, password = decoded.split(":", 1)
        except (ValueError, UnicodeDecodeError):
            return False
        return hmac.compare_digest(user, self.auth_user) and hmac.compare_digest(
            password, self.auth_password
        )

    def require_authorization(self) -> bool:
        if self.authorized():
            return False
        body = b"Authentication required.\n"
        self.send_response(HTTPStatus.UNAUTHORIZED)
        self.send_header("WWW-Authenticate", 'Basic realm="Samplinglib preview"')
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)
        return True

    def send_json(self, status: int, payload: dict[str, object]) -> None:
        body = (json.dumps(payload, ensure_ascii=False) + "\n").encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.send_header("X-Content-Type-Options", "nosniff")
        self.send_header("Referrer-Policy", "no-referrer")
        self.end_headers()
        self.wfile.write(body)

    def read_json(self, maximum: int) -> dict[str, object] | None:
        try:
            length = int(self.headers.get("Content-Length", "0"))
        except ValueError:
            length = 0
        if length <= 0 or length > maximum:
            self.send_json(
                HTTPStatus.REQUEST_ENTITY_TOO_LARGE,
                {"ok": False, "error": f"request must be between 1 and {maximum} bytes"},
            )
            return None
        try:
            payload = json.loads(self.rfile.read(length).decode("utf-8"))
        except (UnicodeDecodeError, json.JSONDecodeError):
            self.send_json(
                HTTPStatus.BAD_REQUEST,
                {"ok": False, "error": "request body is not valid UTF-8 JSON"},
            )
            return None
        if not isinstance(payload, dict):
            self.send_json(
                HTTPStatus.BAD_REQUEST,
                {"ok": False, "error": "request JSON must be an object"},
            )
            return None
        return payload

    def do_GET(self) -> None:  # noqa: N802
        if self.require_authorization():
            return
        if urlsplit(self.path).path == "/api/health":
            self.send_json(
                HTTPStatus.OK,
                {
                    "ok": True,
                    "mode": "local_verified",
                    "lean_version": self.lean_version_text,
                    "formalizer": "deterministic_astis_adapter",
                    "general_semantic_provider": "not_configured",
                    "source_writes": False,
                    "public_execution": False,
                },
            )
            return
        super().do_GET()

    def do_POST(self) -> None:  # noqa: N802
        if self.require_authorization():
            return
        path = urlsplit(self.path).path
        if path == "/api/compile":
            self.handle_compile()
            return
        if path == "/api/formalize":
            self.handle_formalize()
            return
        self.send_json(HTTPStatus.NOT_FOUND, {"ok": False, "error": "unknown API endpoint"})

    def handle_formalize(self) -> None:
        payload = self.read_json(MAX_REQUEST_BYTES)
        if payload is None:
            return
        try:
            request = request_from_dict(payload)
            if len(request.latex) > MAX_LATEX_CHARACTERS:
                raise ValueError("LaTeX request exceeds the formalizer limit")
            result = formalize(request)
        except ValueError as error:
            self.send_json(HTTPStatus.BAD_REQUEST, {"ok": False, "error": str(error)})
            return
        self.send_json(
            HTTPStatus.OK,
            {"ok": result.status == "candidate", "result": result.as_dict()},
        )

    def handle_compile(self) -> None:
        payload = self.read_json(MAX_SOURCE_BYTES)
        if payload is None:
            return
        code = payload.get("code")
        if not isinstance(code, str) or not code.strip():
            self.send_json(
                HTTPStatus.BAD_REQUEST,
                {"ok": False, "output": "the `code` field must be a nonempty string"},
            )
            return
        if len(code.encode("utf-8")) > MAX_SOURCE_BYTES:
            self.send_json(
                HTTPStatus.REQUEST_ENTITY_TOO_LARGE,
                {"ok": False, "output": "Lean source exceeds the local size limit"},
            )
            return
        if not COMPILE_LOCK.acquire(blocking=False):
            self.send_json(
                HTTPStatus.TOO_MANY_REQUESTS,
                {"ok": False, "output": "another Lean snippet is compiling"},
            )
            return
        started = time.perf_counter()
        try:
            with tempfile.TemporaryDirectory(prefix="samplinglib-lean-") as temporary:
                source = Path(temporary) / "Main.lean"
                source.write_text(code, encoding="utf-8", newline="\n")
                try:
                    result = subprocess.run(
                        ["lake", "env", "lean", str(source)],
                        cwd=ROOT,
                        capture_output=True,
                        text=True,
                        encoding="utf-8",
                        errors="replace",
                        timeout=self.compile_timeout,
                        check=False,
                    )
                    output = "\n".join(
                        item for item in (result.stdout.strip(), result.stderr.strip()) if item
                    )
                    output = output.replace(str(source), "Main.lean").replace(
                        temporary, "<temporary>"
                    )
                    ok = result.returncode == 0
                    if not output:
                        output = "Lean accepted the snippet." if ok else f"Lean exited with code {result.returncode}."
                    status = HTTPStatus.OK
                except subprocess.TimeoutExpired:
                    ok = False
                    output = f"Lean compilation exceeded the {self.compile_timeout}-second timeout."
                    status = HTTPStatus.REQUEST_TIMEOUT
                except OSError as error:
                    ok = False
                    output = f"Could not start the pinned Lean toolchain: {error}"
                    status = HTTPStatus.SERVICE_UNAVAILABLE
        finally:
            COMPILE_LOCK.release()
        self.send_json(
            status,
            {
                "ok": ok,
                "output": output,
                "duration_ms": round((time.perf_counter() - started) * 1000),
                "certificate_boundary": "elaboration_or_compilation_only",
            },
        )

    def log_message(self, format_string: str, *args: object) -> None:
        # Request bodies contain user mathematics and are never logged.
        super().log_message(format_string, *args)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=8088)
    parser.add_argument("--directory", type=Path, default=DEFAULT_SITE)
    parser.add_argument("--compile-timeout", type=int, default=120)
    args = parser.parse_args()
    if args.host not in {"127.0.0.1", "localhost", "::1"}:
        raise SystemExit("ide_server.py is intentionally loopback-only")
    directory = args.directory.resolve()
    if not (directory / "index.html").exists():
        raise SystemExit(f"built site not found at {directory}")
    SamplinglibIDEHandler.lean_version_text = lean_version()
    SamplinglibIDEHandler.compile_timeout = max(1, args.compile_timeout)
    SamplinglibIDEHandler.auth_user = os.environ.get("ASTIS_PREVIEW_USER", "")
    SamplinglibIDEHandler.auth_password = os.environ.get("ASTIS_PREVIEW_PASSWORD", "")
    if bool(SamplinglibIDEHandler.auth_user) != bool(SamplinglibIDEHandler.auth_password):
        raise SystemExit("set both ASTIS_PREVIEW_USER and ASTIS_PREVIEW_PASSWORD, or neither")
    handler = partial(SamplinglibIDEHandler, directory=str(directory))
    server = ThreadingHTTPServer((args.host, args.port), handler)
    print(f"Samplinglib local verified mode: http://{args.host}:{args.port}/live/")
    print("Security: loopback only; snippets are temporary and never written to repository source.")
    print(
        "Basic Auth: enabled from environment."
        if SamplinglibIDEHandler.auth_user
        else "Basic Auth: disabled for loopback-only development."
    )
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
