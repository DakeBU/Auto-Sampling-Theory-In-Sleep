# Cycle 197 Middle Normalized Remainder Bound-Definition Audit Packet

Classification: `rejected-wrapper-churn`.

Packet type: dynamic-leaf worker packet for the Brownian/Ito frozen backend
under `sald.general_moving_target_discrete.em_interpolation_fp`.

Exact proposed boundary:

```lean
hNormalizedRemainderBoundDef :
  testRegular ->
    forall phi x i z,
      remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
```

Source-dependency audit result: `source-contract-gap`.

Cycle 196 compiled
`SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`, exported
as
`AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`,
so another integrability or measure-transport theorem would repeat completed
work. The only remaining equality is the concrete definition of the
source-side bound `remainderBound`.

Local source check:

- `appendix.tex:958-996` defines the EM step and frozen interpolation.
- `appendix.tex:1161-1170` rewrites the frozen increment as a drift part plus
  a Gaussian Brownian increment.
- `appendix.tex:1358-1387` states the KL derivative handoff and conditional
  Fokker--Planck equation.
- `appendix.tex:1422-1434` states the FI/IBP rewrite.
- A TeX search over `/home/nitanda_sub/mark/repos/sald/paper`, excluding
  `sald_version_2.tex`, found no paper definition of a scalar
  `remainderBound`, no `remainderBoundC`, and no quadratic bound definition
  of the form `C * z ^ 2`.

Callable local facts already available:

- `SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`
- `SALD.gaussianRealSelectedTestLineSecondOrderQuadraticBoundIntegrable`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero`

No external SLT declaration is callable and no SLT port is assigned for this
packet.

Lower assignment:

- `lower_1`: write the one-ticket route explaining why the proposed equality
  is not currently source-backed by the original SALD TeX. Keep the route tied
  to the anchors above and explicitly separate this source-contract gap from
  the already compiled Gaussian integrability bridge.
- `lower_2`: do not add a theorem that assumes the same equality under a new
  name. Either find an existing Lean definitional unfolding of
  `remainderBound` that proves the displayed equality by reduction, or record
  typed verifier feedback for the smaller source-cited gap:

```text
leaf=hNormalizedRemainderBoundDef
error_class=source_contract_gap_missing_remainder_bound_definition
needed_shape=remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
source_lines=appendix.tex:958-996; appendix.tex:1161-1170; appendix.tex:1358-1387; appendix.tex:1422-1434
blocked_by=no original-paper definition of remainderBound/remainderBoundC outside sald_version_2.tex
```

Reviewer should reject any lower output whose only effect is a new wrapper
from a renamed assumption to `hNormalizedRemainderBoundDef`, a broad route
audit, source-Hessian work, `testRegular` repackaging, VP score-Hessian
substitution, direct SLT dependency use, or another integrability transport.

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Cycle 197 normalized remainder bound-definition audit | Reject wrapper proof of `hNormalizedRemainderBoundDef`; classify the missing equality as a source-contract gap unless an existing Lean definition unfolds to `remainderBoundC * z ^ 2`. | cycle-196 compiled integrability bridge; local Gaussian quadratic integrability; TeX source audit excluding `sald_version_2.tex` | no new theorem unless definitional unfolding exists; otherwise typed ProofObligation with `leaf=hNormalizedRemainderBoundDef` | `appendix.tex:958-996`; `appendix.tex:1161-1170`; `appendix.tex:1358-1387`; `appendix.tex:1422-1434` | `hNormalizedRemainderBoundInt`; `hRemainderBoundInt`; Taylor-DCT package; weak-FP/KL/IBP backend | queued as source-contract gap / rejected wrapper churn |
