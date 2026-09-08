# Independent review: RandomScanHeatBath

Verifier: `/root/random_scan_proof_review` (`random_scan_proof_review` in the SAU ledger), distinct from proving owner `random_scan_worker`, decoder `/root/random_scan_decoder`, and source reviewer `/root/random_scan_source_review`.

Scope: exactly one integration node, `ASTIS-20260908-RandomScanHeatBath` / `ASTIS-SHARED-random-scan-heat-bath`: the actual `randomScan` construction, its Markov instance, and `randomScan_apply_singleton`. The independently verified shared kernel/coordinate/positive-fiber cells are reused, not reproved or counted again.

Verdict: **ACCEPTED, independently verified**, for the exact frozen construction and supported-start singleton law, with source equivalence restricted to the explicitly cited explanatory one-update target. This is not acceptance of the literal full printed algorithm.

## Frozen artifacts

Checked proof commit: `90581ec87c039ae9597f76d3a434eb08e14aa579`. The proving owner was stopped before review. Direct Git comparison to this commit is clean for both public files, and their current SHA-256 values match the packet.

| File | Git blob | SHA-256 |
|---|---|---|
| `AutoSamplingTheory/TechnicalLemmas/Probability/RandomScanHeatBath.lean` | `a4961957ab173e960a37824f1f02c1d7bfa378b9` | `1e13857e6f317ae22ccbb0f5a0c47b395d20ee950a3e8968489afefaff7db42d` |
| `Tests/RandomScanHeatBath.lean` | `33ea92c17b93ef27d1a331131e856629292e3f65` | `cafb0a9033d196990aab0633947ea90aa356ade0c5fefbd4fd54b8d853c57429` |

Every Lean invocation explicitly set `ELAN_TOOLCHAIN=leanprover/lean4:v4.33.0` and `LEAN_NUM_THREADS=1`. Mathlib checkout is exactly `db584cd6d46c92f209a44c0f1c829460d327499d` (Apache-2.0).

## Mathematical and implementation audit

For `N=n+1>0` sites, a Boolean probability target `μ`, and a supported starting state `μ{x}≠0`, the actual uniform random-site kernel satisfies

`Pμ(x,{y}) = (1/N) Σ_i 1[∀j≠i, y_j=x_j] μ({y})/μ(F_i(x))`,

where `F_i(x)` is the full off-site agreement fiber. The selected-site Boolean value is resampled conditionally; no site-selection mass is lost, and a holding transition receives the contributions of all possible selected sites.

- The public file imports only `CoordinateHeatBathConditional` and `KernelMixture`. The construction literally calls the existing finite mixture of existing coordinate heat baths with constant NNReal weights `(n+1)⁻¹`; it is not a newly assumed transition identity or an unrelated replacement kernel.
- The Markov instance supplies the actual finite weight-sum proof. The `Fin(n+1)` cardinality discharges the nonzero denominator. Probability of the target supplies finite-measure instances, while Bool and its finite products supply the needed nonempty, Standard Borel, and measurable-singleton instances. No extra mathematical typeclass assumptions are hidden in the public signature.
- Each `F_i(x)` contains `{x}`. The proof explicitly applies measure monotonicity to derive nonzero fiber mass from the single starting-atom hypothesis. Finiteness comes from the probability measure, so the conditional inverse represents an ordinary positive finite denominator. The proof does not assume positive mass of all ambient configurations.
- `hret` proves equivalence between literal equality at every unselected site and equality of the tuple enumerated by `i.succAbove`. Both directions use the native Fin enumeration/injectivity-covering facts. Thus the denominator and the test retain exactly the same coordinates, with each coordinate's own old value.
- The singleton formula expands the proved `heatBath_eq_cond`, then Mathlib `cond_apply'` on a measurable singleton, and splits its intersection with the fiber. The NNReal-to-ENNReal inverse coercion explicitly uses positivity of `n+1`.
- The full-cube construction remains Markov at unsupported/null-fiber inputs, inheriting the library's conditional versions. The displayed normalized-fiber formula does not apply there. Zero probability targets themselves are excluded by `IsProbabilityMeasure`; zero-mass destinations and proper supported subsets are permitted.

Read-only shared evidence reused: independently verified finite mixture (commit `5d67af28a7d2bc8cbe3a1bf2881dae6deb2b1e85`), coordinate heat bath (`5576ad81fbfcf0dbd68a1fc2e34de8b8ac435164`), and positive-fiber identification (`ce0a871f65382df2d5e5200f42af984f092af74b`). The historical positive-fiber source discrepancy is not erased or retroactively promoted by this new source audit.

## Fresh checks

1. Direct public check: `lake env lean AutoSamplingTheory/TechnicalLemmas/Probability/RandomScanHeatBath.lean` passed, exit 0. This freshly elaborated the frozen public source; it was not merely a cached Lake status.
2. Independent scratch check: `lake env lean .astis/random-scan-proof-review/IndependentEdges.lean` passed, exit 0, with the three exact public types printed and added named proofs:
   - For any admissible dimension and target, every zero-mass destination has transition probability zero from a supported start.
   - For any admissible dimension and target, if two distinct sites differ, the one-step singleton probability is zero.
   - For the nonuniform two-bit target `μ=(δ00+3δ10)/4`, the actual kernel has `Pμ(00,{10})=3/8`.
3. Exactly one final focused command after freeze: `lake build Tests.RandomScanHeatBath` passed, exit 0, 2982 jobs. Lake replayed the unchanged cached test target; the independent direct checks above supply fresh elaboration evidence. No broad root build was run in this verification lane.
4. Public tests inspected: uniform two-bit row `(1/2,1/4,1/4,0)`; disconnected diagonal target with forbidden states; derived positive finite fibers; nonzero Dirac target at an invalid ambient start, where the normalized-fiber mixture is zero but the actual kernel has mass one; one-site case; existing invariance and powers consuming this exact kernel. The invariance/power test inputs are not new proof parents or separately credited advances.
5. Axiom output for the construction, Markov adapter, singleton theorem, and all three independent scratch theorems is exactly within `propext`, `Classical.choice`, `Quot.sound`. No `sorryAx` or custom axiom remains in the successful check.
6. Canonical `astis.FORBIDDEN_REGEX` applied after the repository's comment/string stripping to the public module, public tests, and final scratch file returned no matches. Scoped Git diff/whitespace checks are clean. Frontier Cell protocol checker passed: 9 registered cells.

Evidence logs live only in ignored `.astis/random-scan-proof-review/`. The independent scratch arithmetic went through three unsuccessful elaborations before the final pass: NNReal scalar coercion and numeric proof normalization were diagnosed and corrected without changing either public file or mathematical target. Failed outputs are retained as `edge-attempt-1.log` through `edge-attempt-3.log`; only `independent-edges.log` is successful certificate evidence.

## Source and semantic acceptance boundary

The independent source role returned `equivalent-after-elaboration` / `accepted` for the explicitly cited Section 1.1 support definition and Section 1.3 site-selection, conditional-sampling and explanatory one-update target, arXiv `2307.13826v4`, PDF pages 4–5. It audited all seven slots and independently inspected the complete source pages. This verifier checked its report and the canonical audit rather than claiming to have repeated that PDF review.

- Primary PDF SHA-256: `3cc2f911b33bb5538157ef8a70f0c7e0f3c812ecd06dc9c1d5ea0bfdae11a52a`.
- Canonical semantic audit: `ASTIS-RT-20260908-RandomScanLaw`.
- Elaborated singleton statement SHA-256: `c7bd862adeaa76beb38df77209598550a44ded4b90d6945ff443497fcca74dd4`, matching the public signature inspected here.
- Immutable source-review result: `runs/20260908-samplewiki-resume/random-scan.source-review-result.json`, SHA-256 `b62914b54efc84122813b1530f2175ea35bdf6f170861bc1bdd8c67d14410935`.
- Canonical source reviewer-packet hash: `fa10a2be8138a2f1f238507c1039ac79ceeea230dca5544f1b266675a4aa657e`; raw packet-byte digest is separately `975db7bb8844ed8f57918fa0ab8abd142e731c8d4a6f36e3d820182d8074d35d`. They are not conflated.
- Same-reviewer presentation amendment SHA-256: `ddc01efea1d05316622a2598d8a0f2b88e28a93e14461ea6fe3b4816a7534e2a`, only changing a local source path to repository-relative form.
- Same-reviewer approved schema amendment v2 SHA-256: `17aa2172d2f2ac6485fe1dfc942805035e841e9eca888db92b74a51bacbe409e`. The first four delta `evidence` values are exact copies of their original reviewed slot evidence; the PDF-provenance delta copies the approved path-redacted provenance evidence. This verifier independently compared all seven slots, all five original delta payloads/severities, the verdict, acceptance state, and all five added evidence strings: unchanged or exact as specified. The rejected first schema adapter remains recorded and is not used for acceptance.

The printed general step 2 still says to copy the selected site's old value into other sites, conflicting with the conditional-sampling expression and explanatory prose. It is excluded from the expressly pinned target. Neither this review nor the narrow equivalent verdict certifies the literal complete numbered algorithm. Separate copy-index repair evidence is not conflated with this target's semantic acceptance.

Final canonical gate: this verifier independently reran `tools/astis_semantic_roundtrip.py check` after root's synchronization, PASS: 2 audits, 1 repair proposal. An initial read-only checker run had found that five delta entries lacked their mandatory `evidence` string (they had `impact`); it was reported to root without modifying the semantic registry. The accepted same-reviewer mechanical amendment resolves that schema defect without changing the assessment. Source response, publication/schema amendments, and final public/test hashes were independently rechecked. Acceptance uses only this final passing gate and the fresh proof evidence above.

## Strict residuals and ownership

No executable conditional sampler, empty-site law, arbitrary spin alphabet, null-fiber normalized law, concrete Gibbs-density normalization, detailed balance, reversibility, irreducibility, aperiodicity/absolute gap, convergence or mixing bound, continuous-time clock, numerical bias, or computational-cost theorem is newly proved. Existing invariance/power APIs are only test consumers of this integration node.

The `none-found` conceptual-mirror audit is appropriate: this is literal finite-mixture and atomic-conditional reuse. The existing block-draw/block-optimization candidate was inspected and not validated or promoted to a formal edge.

Registry/import/root-build/graph/site/publishing work remains owned by the sole stabilization lane, `KernelInvariance`; the Registry count is not increased by this review. No public Lean/test edits, source-registry edits, Git/remote mutations, daemon, background process, extra stabilization lane, or claimed chapter completion were performed here.

The only authorized canonical cell edits are `status=independently_verified` and a nonempty string at `evidence.independent_verification`. The distinct-verifier `PROVED_LOCAL -> VERIFIED` event is published through `tools.astis_advance.transition_advance`; this does not enter or duplicate the stabilization lane. All verifier-owned writes stop after closeout.
