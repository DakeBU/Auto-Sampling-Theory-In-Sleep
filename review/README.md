# Author-only review branch

This branch is an export workspace, NOT an anonymous repository. Never put its URL, the development account, an Actions URL, or an author-side preparation archive into a double-blind submission.

The review input is fixed to source revision `458d3c9f8d2f7286030c2ccb2893f8a685c38101`. Later mathematical progress belongs on `main`; do not merge main into this branch, and do not merge this branch into main. The review workflow has no schedule and no Pages deployment permission. It will not replace the public website.

`export_reader.py` exports five selected reader pages, the native three-view graph and theme, source/family metadata, and a minimal renamed Lean case. It excludes public project links, author footers, history, private paths and external theorem corpora. Literature author names are preserved as third-party attribution. The workflow compiles the renamed fixture and checks every conceptual formula through the existing MathJax renderer before creating the reviewer artifact.

Only the artifact named `anonymous-review-snapshot` is intended for review distribution. Download it and upload the sanitized files as supplementary material or to a separately controlled anonymous host. This branch itself remains attributable. No public anonymous hosting URL is created by this workflow. Use a frozen hosting deployment with no public link back to the source repository, no analytics and no later main-branch synchronization.

The manuscript is delivered privately as an Overleaf ZIP rather than committed here, to avoid associating its anonymous title with this public repository. The original project README, author citation, main-branch deployment and Lean sources are unchanged.

Anonymization minimizes direct identifiers; it cannot prevent intentional reverse identification of already-public mathematics. Check the exported files and rendered pages before submission. Keep legitimate mathematical/source attribution intact.
