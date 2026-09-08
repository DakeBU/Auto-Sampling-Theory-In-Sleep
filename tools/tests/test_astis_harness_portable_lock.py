from __future__ import annotations

import errno
import hashlib
import multiprocessing
import os
import tempfile
import unittest
from pathlib import Path
from unittest import mock

from tools import astis_harness as harness


def lock_worker(root: str, path: str, ready, acquired, release) -> None:
    harness.ROOT = Path(root)
    ready.set()
    with harness.file_lock(Path(path)):
        acquired.set()
        if not release.wait(30):
            raise TimeoutError("test did not release lock worker")


def publish_worker(root: str, path: str, text: str, ready, staged, proceed, done) -> None:
    harness.ROOT = Path(root)
    replace_and_sync = harness._replace_and_sync

    def publish(source: str, destination: Path) -> None:
        staged.set()
        if not proceed.wait(30):
            raise TimeoutError("test did not release staged publisher")
        replace_and_sync(source, destination)

    with mock.patch.object(harness, "_replace_and_sync", side_effect=publish):
        ready.set()
        harness.atomic_write_text(Path(path), text)
        done.set()


class TemporaryHarnessTests(unittest.TestCase):
    def setUp(self) -> None:
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        root_patch = mock.patch.object(harness, "ROOT", self.root)
        root_patch.start()
        self.addCleanup(root_patch.stop)
        self.path = self.root / "events.jsonl"
        self.context = multiprocessing.get_context("spawn")

    def start_worker(self, path: Path):
        ready = self.context.Event()
        acquired = self.context.Event()
        release = self.context.Event()
        process = self.context.Process(
            target=lock_worker,
            args=(str(self.root), str(path), ready, acquired, release),
        )
        process.start()

        def cleanup() -> None:
            # A terminated process may have died holding an Event's internal
            # mutex. Do not touch that Event after the process has exited.
            if process.is_alive():
                release.set()
            process.join(5)
            if process.is_alive():
                process.terminate()
                process.join(5)
            process.close()

        self.addCleanup(cleanup)
        self.assertTrue(ready.wait(10), "worker did not reach lock acquisition")
        return process, acquired, release

    def assert_waiter_excluded_then_released(self, waiter_path: Path) -> None:
        with harness.file_lock(self.path):
            process, acquired, release = self.start_worker(waiter_path)
            self.assertFalse(acquired.wait(0.3), "two processes held the same lock")
            self.assertTrue(process.is_alive())
        self.assertTrue(acquired.wait(10), "waiter did not acquire released lock")
        release.set()
        process.join(10)
        self.assertEqual(process.exitcode, 0)


class PortableLockTests(TemporaryHarnessTests):
    def test_cross_process_exclusion_and_normal_release(self) -> None:
        self.assert_waiter_excluded_then_released(self.path)

    def test_resolved_path_alias_uses_same_lock(self) -> None:
        (self.root / "nested").mkdir()
        self.assert_waiter_excluded_then_released(self.root / "nested" / ".." / self.path.name)

    @unittest.skipUnless(os.name == "nt", "Windows paths are case-insensitive")
    def test_windows_case_alias_uses_same_lock(self) -> None:
        self.assert_waiter_excluded_then_released(Path(str(self.path).upper()))

    def test_nonempty_lock_file_preserves_exclusion_and_contents(self) -> None:
        canonical = os.path.normcase(str(self.path.resolve()))
        lock_path = self.root / ".astis" / "locks" / (
            hashlib.sha256(canonical.encode("utf-8")).hexdigest() + ".lock"
        )
        lock_path.parent.mkdir(parents=True)
        lock_path.write_bytes(b"existing lock file")
        self.assert_waiter_excluded_then_released(self.path)
        self.assertEqual(lock_path.read_bytes(), b"existing lock file")

    def test_exception_releases_lock_for_waiting_process(self) -> None:
        with self.assertRaisesRegex(RuntimeError, "test failure"):
            with harness.file_lock(self.path):
                process, acquired, release = self.start_worker(self.path)
                self.assertFalse(acquired.wait(0.3))
                raise RuntimeError("test failure")
        self.assertTrue(acquired.wait(10), "exception leaked the held lock")
        release.set()
        process.join(10)
        self.assertEqual(process.exitcode, 0)

    def test_process_termination_releases_lock(self) -> None:
        holder, held, _ = self.start_worker(self.path)
        self.assertTrue(held.wait(10))
        waiter, acquired, release = self.start_worker(self.path)
        self.assertFalse(acquired.wait(0.3))
        holder.terminate()
        holder.join(10)
        self.assertFalse(holder.is_alive())
        self.assertTrue(acquired.wait(10), "terminated process leaked the held lock")
        release.set()
        waiter.join(10)
        self.assertEqual(waiter.exitcode, 0)

    def test_distinct_paths_do_not_block_each_other(self) -> None:
        with harness.file_lock(self.path):
            process, acquired, release = self.start_worker(self.root / "other.jsonl")
            self.assertTrue(acquired.wait(10), "unrelated paths shared a lock")
            release.set()
            process.join(10)
            self.assertEqual(process.exitcode, 0)

    @unittest.skipUnless(os.name == "nt", "Windows locking error contract")
    def test_windows_contention_retries_without_attempt_limit(self) -> None:
        with mock.patch.object(
            harness.msvcrt, "locking",
            side_effect=[OSError(errno.EACCES, "locked")] * 12 + [None, None],
        ) as locking, mock.patch.object(harness.time, "sleep") as sleep:
            with harness.file_lock(self.path):
                pass
        self.assertEqual(sleep.call_count, 12)
        self.assertEqual(locking.call_count, 14)
        self.assertTrue(all(
            call.args[1:] == (harness.msvcrt.LK_NBLCK, 1)
            for call in locking.call_args_list[:-1]
        ))
        self.assertEqual(locking.call_args.args[1:], (harness.msvcrt.LK_UNLCK, 1))

    @unittest.skipUnless(os.name == "nt", "Windows locking error contract")
    def test_windows_unrelated_error_is_not_retried_or_unlocked(self) -> None:
        with mock.patch.object(
            harness.msvcrt, "locking", side_effect=OSError(errno.EBADF, "bad descriptor")
        ) as locking, mock.patch.object(harness.time, "sleep") as sleep:
            with self.assertRaises(OSError) as raised:
                with harness.file_lock(self.path):
                    self.fail("lock acquisition unexpectedly succeeded")
        self.assertEqual(raised.exception.errno, errno.EBADF)
        locking.assert_called_once()
        sleep.assert_not_called()


class AtomicPublishTests(TemporaryHarnessTests):
    def assert_no_staging_files(self, path: Path) -> None:
        self.assertEqual(list(path.parent.glob(f".{path.name}.*")), [])

    def start_publisher(self, text: str, *, paused: bool = False):
        ready = self.context.Event()
        staged = self.context.Event()
        proceed = self.context.Event()
        done = self.context.Event()
        if not paused:
            proceed.set()
        process = self.context.Process(
            target=publish_worker,
            args=(str(self.root), str(self.path), text, ready, staged, proceed, done),
        )
        process.start()

        def cleanup() -> None:
            if process.is_alive():
                proceed.set()
            process.join(5)
            if process.is_alive():
                process.terminate()
                process.join(5)
            process.close()

        self.addCleanup(cleanup)
        self.assertTrue(ready.wait(10), "publisher did not start")
        return process, staged, proceed, done

    def test_create_and_replace_unicode_text_in_new_directory(self) -> None:
        path = self.root / "new" / "检查点.txt"
        for payload in ("first checkpoint\n数学", "replacement\n" + "完整" * 100_000):
            harness.atomic_write_text(path, payload)
            self.assertEqual(path.read_text(encoding="utf-8"), payload)
            self.assert_no_staging_files(path)

    def test_staged_publish_preserves_old_visibility_and_serializes_writers(self) -> None:
        original = "old complete checkpoint"
        first_text = "first完整" * 100_000
        second_text = "second完整" * 100_000
        harness.atomic_write_text(self.path, original)
        first, first_staged, proceed, first_done = self.start_publisher(first_text, paused=True)
        self.assertTrue(first_staged.wait(10), "first writer did not finish staging")
        # The first writer has fsynced a complete new payload, but readers must
        # still see the old publication until the native replacement occurs.
        self.assertEqual(self.path.read_text(encoding="utf-8"), original)
        staging = list(self.path.parent.glob(f".{self.path.name}.*"))
        self.assertEqual(len(staging), 1)
        self.assertEqual(staging[0].read_text(encoding="utf-8"), first_text)
        second, second_staged, second_proceed, second_done = self.start_publisher(
            second_text, paused=True
        )
        self.assertFalse(second_staged.wait(0.3), "writers entered publication together")
        self.assertFalse(first_done.is_set())
        self.assertFalse(second_done.is_set())
        proceed.set()
        self.assertTrue(first_done.wait(10), "first publication failed")
        self.assertTrue(second_staged.wait(10), "second writer remained blocked")
        self.assertEqual(self.path.read_text(encoding="utf-8"), first_text)
        second_proceed.set()
        self.assertTrue(second_done.wait(10), "second publication failed")
        for process in (first, second):
            process.join(10)
            self.assertEqual(process.exitcode, 0)
        self.assertEqual(self.path.read_text(encoding="utf-8"), second_text)
        self.assert_no_staging_files(self.path)

    def test_payload_sync_failure_preserves_target_and_cleans_staging(self) -> None:
        harness.atomic_write_text(self.path, "original")
        with mock.patch.object(harness.os, "fsync", side_effect=OSError(errno.EIO, "sync failed")):
            with self.assertRaises(OSError) as raised:
                harness.atomic_write_text(self.path, "unpublished")
        self.assertEqual(raised.exception.errno, errno.EIO)
        self.assertEqual(self.path.read_text(encoding="utf-8"), "original")
        self.assert_no_staging_files(self.path)
        harness.atomic_write_text(self.path, "recovered")
        self.assertEqual(self.path.read_text(encoding="utf-8"), "recovered")

    @unittest.skipUnless(os.name == "nt", "Windows publication contract")
    def test_windows_publish_does_not_claim_directory_fsync(self) -> None:
        with mock.patch.object(harness, "_fsync_directory", side_effect=AssertionError) as sync:
            harness.atomic_write_text(self.path, "checkpoint")
        sync.assert_not_called()
        self.assertEqual(self.path.read_text(encoding="utf-8"), "checkpoint")

    @unittest.skipUnless(os.name == "nt", "Windows native sharing contract")
    def test_windows_native_failure_preserves_target_and_releases_lock(self) -> None:
        harness.atomic_write_text(self.path, "original")
        # A normal Python reader denies delete sharing on Windows. Native
        # replacement must fail visibly, without removing the old publication.
        with self.path.open("rb"):
            with self.assertRaises(OSError) as raised:
                harness.atomic_write_text(self.path, "unpublished")
        # MoveFileEx may report ACCESS_DENIED or SHARING_VIOLATION for an
        # existing destination that cannot be replaced while open.
        self.assertIn(raised.exception.winerror, (5, 32))
        self.assertEqual(self.path.read_text(encoding="utf-8"), "original")
        self.assert_no_staging_files(self.path)
        harness.atomic_write_text(self.path, "recovered")
        self.assertEqual(self.path.read_text(encoding="utf-8"), "recovered")

    @unittest.skipUnless(os.name == "nt", "Windows native write-through contract")
    def test_windows_requests_replace_and_write_through_without_copy_fallback(self) -> None:
        native_loader = harness.ctypes.WinDLL
        calls = []

        def load_kernel(*args, **kwargs):
            library = native_loader(*args, **kwargs)
            native_move = library.MoveFileExW
            native_move.argtypes = (
                harness.wintypes.LPCWSTR, harness.wintypes.LPCWSTR, harness.wintypes.DWORD
            )
            native_move.restype = harness.wintypes.BOOL

            def move(source, destination, flags):
                calls.append((source, destination, flags))
                return native_move(source, destination, flags)

            return mock.Mock(MoveFileExW=move)

        with mock.patch.object(harness.ctypes, "WinDLL", side_effect=load_kernel):
            harness.atomic_write_text(self.path, "checkpoint")
        self.assertEqual(len(calls), 1)
        source, destination, flags = calls[0]
        self.assertEqual(Path(source).parent, self.path.parent)
        self.assertEqual(destination, str(self.path))
        self.assertEqual(flags, 0x1 | 0x8)
        self.assertEqual(self.path.read_text(encoding="utf-8"), "checkpoint")

    def test_posix_replace_precedes_directory_fsync(self) -> None:
        ordered = mock.Mock()
        with mock.patch.object(harness, "os") as platform_os, mock.patch.object(
            harness, "_fsync_directory"
        ) as directory_sync:
            platform_os.name = "posix"
            ordered.attach_mock(platform_os.replace, "replace")
            ordered.attach_mock(directory_sync, "directory_sync")
            harness._replace_and_sync("source", self.path)
        self.assertEqual(ordered.mock_calls, [
            mock.call.replace("source", self.path),
            mock.call.directory_sync(self.path.parent),
        ])


if __name__ == "__main__":
    unittest.main()
