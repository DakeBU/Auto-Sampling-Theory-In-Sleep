#!/usr/bin/env python3
"""Serve a private ASTIS preview using Basic Auth credentials from the environment."""

from __future__ import annotations

import argparse
import base64
import hmac
import os
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


class AuthenticatedHandler(SimpleHTTPRequestHandler):
    expected_authorization = ""

    def authorized(self) -> bool:
        supplied = self.headers.get("Authorization", "")
        return hmac.compare_digest(supplied, self.expected_authorization)

    def require_authentication(self) -> None:
        self.send_response(401)
        self.send_header("WWW-Authenticate", 'Basic realm="ASTIS preview"')
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(b"Authentication required.\n")

    def do_GET(self) -> None:  # noqa: N802
        if not self.authorized():
            self.require_authentication()
            return
        super().do_GET()

    def do_HEAD(self) -> None:  # noqa: N802
        if not self.authorized():
            self.require_authentication()
            return
        super().do_HEAD()

    def log_message(self, format_string: str, *args: object) -> None:
        # SimpleHTTPRequestHandler never logs request headers, so credentials
        # stay out of the preview log.
        super().log_message(format_string, *args)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--host", default=os.environ.get("ASTIS_PREVIEW_HOST", "127.0.0.1"))
    parser.add_argument(
        "--port",
        type=int,
        default=int(os.environ.get("ASTIS_PREVIEW_PORT", "8765")),
    )
    parser.add_argument("--directory", default=str(ROOT / "_site"))
    args = parser.parse_args()

    username = os.environ.get("ASTIS_PREVIEW_USER", "")
    password = os.environ.get("ASTIS_PREVIEW_PASSWORD", "")
    if not username or not password:
        parser.error("set ASTIS_PREVIEW_USER and ASTIS_PREVIEW_PASSWORD")
    directory = Path(args.directory).resolve()
    if not (directory / "index.html").exists():
        parser.error(f"generated site not found at {directory}")

    token = base64.b64encode(f"{username}:{password}".encode("utf-8")).decode("ascii")
    AuthenticatedHandler.expected_authorization = f"Basic {token}"
    handler = lambda *handler_args, **kwargs: AuthenticatedHandler(  # noqa: E731
        *handler_args,
        directory=str(directory),
        **kwargs,
    )
    server = ThreadingHTTPServer((args.host, args.port), handler)
    print(f"ASTIS private preview: http://{args.host}:{args.port}/")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
