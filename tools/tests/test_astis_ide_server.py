from __future__ import annotations

import base64
import json
import tempfile
import threading
import unittest
from functools import partial
from http.server import ThreadingHTTPServer
from pathlib import Path
from urllib.error import HTTPError
from urllib.request import ProxyHandler, Request, build_opener

from website.scripts.ide_server import SamplinglibIDEHandler


class QuietHandler(SamplinglibIDEHandler):
    lean_version_text = "Lean test version"
    compile_timeout = 60
    auth_user = ""
    auth_password = ""

    def log_message(self, format_string: str, *args: object) -> None:
        pass


class SamplinglibIDEServerTest(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary = tempfile.TemporaryDirectory()
        site = Path(self.temporary.name)
        (site / "index.html").write_text("Samplinglib", encoding="utf-8")
        handler = partial(QuietHandler, directory=str(site))
        self.server = ThreadingHTTPServer(("127.0.0.1", 0), handler)
        self.thread = threading.Thread(target=self.server.serve_forever, daemon=True)
        self.thread.start()
        self.base = f"http://127.0.0.1:{self.server.server_port}"
        self.opener = build_opener(ProxyHandler({}))

    def tearDown(self) -> None:
        self.server.shutdown()
        self.server.server_close()
        self.thread.join(timeout=5)
        self.temporary.cleanup()

    def json_request(self, path: str, payload: dict[str, object]) -> tuple[int, dict[str, object]]:
        request = Request(
            f"{self.base}{path}",
            data=json.dumps(payload).encode("utf-8"),
            headers={"Content-Type": "application/json"},
            method="POST",
        )
        try:
            with self.opener.open(request, timeout=90) as response:
                return response.status, json.load(response)
        except HTTPError as error:
            return error.code, json.load(error)

    def test_health_and_formalizer_contract(self) -> None:
        with self.opener.open(f"{self.base}/api/health", timeout=10) as response:
            health = json.load(response)
        self.assertEqual(health["mode"], "local_verified")
        self.assertFalse(health["source_writes"])
        self.assertFalse(health["public_execution"])

        status, payload = self.json_request(
            "/api/formalize",
            {
                "latex": (
                    r"\[\operatorname{Var}_\pi(f) \le C_{\mathrm P} "
                    r"\int \|\nabla f(x)\|^2\,d\pi(x).\]"
                )
            },
        )
        self.assertEqual(status, 200)
        result = payload["result"]
        self.assertEqual(result["translation_status"], "candidate")
        self.assertEqual(result["semantic_review_status"], "not_reviewed")
        self.assertEqual(result["proof_status"], "unproved")

        status, payload = self.json_request("/api/formalize", {"latex": ""})
        self.assertEqual(status, 400)
        self.assertIn("nonempty", payload["error"])

    def test_compile_success_and_failure(self) -> None:
        status, payload = self.json_request("/api/compile", {"code": "#check Nat"})
        self.assertEqual(status, 200)
        self.assertTrue(payload["ok"])
        self.assertEqual(payload["certificate_boundary"], "elaboration_or_compilation_only")

        status, payload = self.json_request(
            "/api/compile", {"code": "example : False := by trivial"}
        )
        self.assertEqual(status, 200)
        self.assertFalse(payload["ok"])
        self.assertIn("False", payload["output"])


class SamplinglibIDEAuthTest(unittest.TestCase):
    def test_basic_auth_guards_static_and_api_routes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            site = Path(temporary)
            (site / "index.html").write_text("Samplinglib", encoding="utf-8")

            class AuthHandler(QuietHandler):
                auth_user = "reviewer"
                auth_password = "test-secret"

            server = ThreadingHTTPServer(
                ("127.0.0.1", 0), partial(AuthHandler, directory=str(site))
            )
            thread = threading.Thread(target=server.serve_forever, daemon=True)
            thread.start()
            url = f"http://127.0.0.1:{server.server_port}/api/health"
            opener = build_opener(ProxyHandler({}))
            try:
                with self.assertRaises(HTTPError) as caught:
                    opener.open(url, timeout=10)
                self.assertEqual(caught.exception.code, 401)

                token = base64.b64encode(b"reviewer:test-secret").decode("ascii")
                request = Request(url, headers={"Authorization": f"Basic {token}"})
                with opener.open(request, timeout=10) as response:
                    self.assertEqual(json.load(response)["mode"], "local_verified")
            finally:
                server.shutdown()
                server.server_close()
                thread.join(timeout=5)


if __name__ == "__main__":
    unittest.main()
