# ChatGPT Pro Request: Remaining SALD Lean Proof Problems

Generated for ASTIS-SALD-001 after cycle 207.

This document is meant to be pasted into ChatGPT Pro for a deep one-shot
analysis.  The goal is not to re-explain the ASTIS system.  The goal is to get
mathematically correct Lean 4 proof plans, theorem statements, and ideally
compilable Lean code for the remaining source-cited analysis gaps in the
faithful Lean reproduction of the VA-SALD paper
([arXiv:2605.07950](https://arxiv.org/abs/2605.07950)).

## Current State

ASTIS has already built a large Lean skeleton for the SALD paper:

- Lean gate: `python3 tools/astis.py check` passes.
- Lean theorem count: 489.
- Lean def count: 1109.
- Forbidden proof hits: 0.
- Main file: `AutoSamplingTheory/SALD.lean`.
- Reusable technical lemmas: `AutoSamplingTheory/TechnicalLemmas/*`.
- Current minimal reviewer-selected blocker:
  `emInterpolationConditionalWeakFp`.

The latest reviewer narrowed the next target to:

```text
sald.general_moving_target_discrete.em_interpolation_fp
  -> emInterpolationConditionalWeakFp
```

Source anchors:

- `appendix.tex:1358-1365`: KL derivative starting identity.
- `appendix.tex:1368-1377`: conditional frozen drift
  `bar b_{k,s}(x) = E[dot t_k c_{t_k}(X_k^eta)
  + (sigma_eta^2 / 2) grad log pi_{t_k}(X_k^eta) | hat X_s = x]`.
- `appendix.tex:1379-1387`: weak Fokker--Planck equation for the frozen
  interpolation law `hat rho_s = Law(hat X_s)`.
- `appendix.tex:1402-1434`: divergence rewrite, FI term, and integration by
  parts.
- `appendix.tex:983-996`: frozen Euler--Maruyama interpolation
  `hat X_s = X_k^eta + (s-s_k)b_k(X_k^eta) + sigma_eta(W_s-W_{s_k})`.

## Hard Rules

Please do not solve these by adding fake assumptions or wrapper theorems.

Do not use:

- `sorry`
- `admit`
- `axiom`
- `Prop := True`
- `:= trivial` to close mathematical content

Preferred output:

1. A precise mathematical theorem statement.
2. A Lean 4 theorem statement that could fit in `AutoSamplingTheory/SALD.lean`
   or `AutoSamplingTheory/TechnicalLemmas/*.lean`.
3. A proof script if feasible.
4. If the theorem cannot be proved from current assumptions, identify the
   exact missing source-facing assumption and its minimal Lean shape.

Do not return a broad essay only.  Return Lean-facing deliverables.

## P0: Prove the Conditional-Law Weak Fokker--Planck Leaf

This is the main target.

### Human Mathematical Statement

For the frozen interpolation on a single EM interval,

```text
hat X_s = X_k^eta + (s-s_k) b_k(X_k^eta)
          + sigma_eta (W_s - W_{s_k}),
```

where

```text
b_k(X_k^eta)
  = dot t_k c_{t_k}(X_k^eta)
    + (sigma_eta^2 / 2) grad log pi_{t_k}(X_k^eta),
```

and `hat rho_s = Law(hat X_s)`, define

```text
bar b_{k,s}(x) = E[b_k(X_k^eta) | hat X_s = x].
```

For a sufficiently regular test function `phi`, the weak form should be:

```text
d/ds ∫ phi(x) d hat rho_s(x)
 =
∫ <grad phi(x), bar b_{k,s}(x)> d hat rho_s(x)
 + (sigma_eta^2 / 2) ∫ Delta phi(x) d hat rho_s(x).
```

Equivalently, at density level this is:

```text
partial_s hat rho_s
 =
- div(hat rho_s bar b_{k,s})
 + (sigma_eta^2 / 2) Delta hat rho_s.
```

### Existing Lean Context

ASTIS already has many handoff theorems around this boundary.  The most relevant
ones are:

- `generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorHandoff`
  around `AutoSamplingTheory/SALD.lean:5523`.
- `generalMovingTargetDiscreteWeakConditionalFpLawDerivativeOfSampleSplitGeneratorHandoff`
  around `AutoSamplingTheory/SALD.lean:5593`.
- `generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfSampleSplitGeneratorHandoff`
  around `AutoSamplingTheory/SALD.lean:5671`.
- `generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfDominatedSplitGeneratorHandoff`
  around `AutoSamplingTheory/SALD.lean:5751`.
- `generalMovingTargetDiscreteCanonicalBarBWeakConditionalFpNamedLawDerivativeOfDominated`
  around `AutoSamplingTheory/SALD.lean:6614`.
- `generalMovingTargetDiscreteCanonicalBarBWeakConditionalFpNamedLawDerivativeOfEmIntervalDominated`
  around `AutoSamplingTheory/SALD.lean:6794`.
- `generalMovingTargetDiscreteCanonicalBarBWeakConditionalFpNamedLawDerivativeOfEmIntervalMeasDominated`
  around `AutoSamplingTheory/SALD.lean:6943`.

Useful existing technical lemmas:

- `AutoSamplingTheory.lawMapIntegralHasDerivAtOfDominated`
  in `AutoSamplingTheory/Probability.lean:120`.
- `AutoSamplingTheory.lawIntegralHasDerivAtOfMeasureMapEqAndDominated`
  in `AutoSamplingTheory/Probability.lean:161`.
- `AutoSamplingTheory.condDistribIntegralNamedLawIntegral`
  in `AutoSamplingTheory/Probability.lean:445`.

### What We Need from ChatGPT Pro

Please provide one of the following.

Option A, preferred: a new Lean theorem that closes or sharply narrows
`emInterpolationConditionalWeakFp` by proving the weak conditional FP formula
from:

- named law equality `hatRhoS s = Measure.map (hatX s) P`;
- regular conditional law / `condDistrib` representation;
- dominated differentiation under the integral;
- pointwise derivative of `testEval phi (hatX s omega)`;
- source action identities for drift and diffusion.

Option B: if full proof is too large, provide the smallest non-wrapper theorem
that should be added next.  It must discharge one real mathematical step, for
example:

```lean
-- schematic, adapt names/types
theorem emInterpolationConditionalWeakFp_from_pathwise_generator
    ... :
    HasDerivAt
      (fun s => ∫ x, testEval phi x ∂hatRhoS s)
      (∫ x, inner Real (testGrad phi x) (barB x) ∂hatRhoS s0
        + (sigmaEta ^ 2 / 2) * ∫ x, laplacianTest phi x ∂hatRhoS s0)
      s0 := by
  ...
```

Option C: if Lean cannot prove this without stronger source assumptions, list
the minimal assumptions exactly, for example:

```lean
hhatX_path_deriv :
  ∀ᵐ omega ∂P, ∀ s ∈ Set.Ioo sLeft sRight,
    HasDerivAt (fun t => testEval phi (hatX t omega))
      (inner Real (testGrad phi (hatX s omega)) (drift omega)
       + (sigmaEta ^ 2 / 2) * laplacianTest phi (hatX s omega)) s

hbarB_cond :
  ∫ omega, inner Real (testGrad phi (hatX s0 omega)) (drift omega) ∂P
    =
  ∫ x, inner Real (testGrad phi x) (barB x) ∂hatRhoS s0
```

Then explain how these assumptions connect to existing ASTIS lemmas.

### Critical Pitfall

Do not simply produce a theorem of the form:

```lean
(hweakFp : desired_statement) -> desired_statement
```

ASTIS already has enough wrapper theorems.  The next theorem must either use
Mathlib / local technical lemmas to prove a real step, or state a strictly
smaller missing source assumption.

## P1: Connect Weak FP to the KL Derivative Start

Source lines:

- `appendix.tex:1358-1365`.

Paper statement, paraphrased:

```text
d/ds KL(hat rho_s || tilde pi_s)
 =
∫ partial_s hat rho_s log(hat rho_s / tilde pi_s) dx
 -
∫ (hat rho_s / tilde pi_s) partial_s tilde pi_s dx,
```

using mass conservation `∫ partial_s hat rho_s dx = 0`.

### What We Need

A Lean-facing theorem that states this as a usable interface.  It can stay
abstract over density fields, but should not hide the real assumptions:

- absolute continuity / density representatives;
- differentiability in `s`;
- integrability of the log-ratio test;
- mass conservation;
- ability to differentiate under the integral.

Expected output from Pro:

1. A minimal theorem statement.
2. The proof route in Lean terms.
3. Which parts are already in Mathlib, if known.
4. Which parts should remain source-cited assumptions if Mathlib support is too
   heavy.

## P2: Divergence Rewrite, Fisher Information, and IBP

Source lines:

- `appendix.tex:1402-1434`.

Paper statement, paraphrased:

Starting from the weak FP equation, rewrite:

```text
partial_s hat rho_s
 =
 (sigma_eta^2 / 2) div(hat rho_s A_s)
 + div(hat rho_s ((sigma_eta^2 / 2) grad log tilde pi_s - bar b_{k,s}))
```

where

```text
A_s = grad log(hat rho_s / tilde pi_s).
```

Then integrate against `log(hat rho_s / tilde pi_s)` and integrate by parts to
get:

```text
∫ partial_s hat rho_s log(hat rho_s / tilde pi_s)
 =
 - (sigma_eta^2 / 2) FI(hat rho_s || tilde pi_s)
 - ∫ hat rho_s <(sigma_eta^2 / 2) grad log tilde pi_s - bar b_{k,s}, A_s>.
```

### Existing Lean Context

Relevant existing compiled handoffs include:

- `discreteForwardKlConditionalFpDivergenceDriftSplit`
  around `AutoSamplingTheory/SALD.lean:4694`.
- `discreteForwardKlConditionalFpLaplacianSplitHandoff`
  around `AutoSamplingTheory/SALD.lean:4712`.
- `generalMovingTargetDiscreteWeakConditionalFpLaplacianIbPOfGreenIdentity`
  around `AutoSamplingTheory/SALD.lean:5023`.
- `generalMovingTargetDiscreteWeakConditionalFpDiffusionSourceOfGreenLaplacianIbP`
  around `AutoSamplingTheory/SALD.lean:5069`.
- `generalMovingTargetDiscreteWeakConditionalFpDiffusionSourceOfFirstGreenNoBoundaryFlux`
  around `AutoSamplingTheory/SALD.lean:5132`.

### What We Need

A non-wrapper theorem that proves one real step:

- either the algebraic divergence regrouping in a more usable vector-field form;
- or the first Green identity;
- or the second Green identity;
- or the conversion to Fisher information.

If full Euclidean-space IBP is too large for Lean/Mathlib, return a precise
source-cited assumption shape:

```lean
hNoBoundaryIBP :
  ∀ phi, Admissible phi ->
    ∫ x, divField x * logRatio x ∂mu
      =
    - ∫ x, inner Real (field x) (gradLogRatio x) ∂mu
```

and explain which exact theorem in Mathlib would be needed to prove it.

## P3: Brownian/Ito Frozen EM Generator and Taylor/DCT Backend

Source lines:

- `appendix.tex:983-996`: frozen interpolation.
- `appendix.tex:1379-1387`: weak FP consumer.

This is not the current first priority, but it may be required if P0 tries to
expand the Brownian generator concretely.

### Existing Formalized Local Lemmas

Available compiled local lemmas include:

- `AutoSamplingTheory.TechnicalLemmas.Gaussian.map_eval_stdGaussianPi`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_eval_stdGaussianPi`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_sq_eval_stdGaussianPi`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.integral_eval_stdGaussianPi`
- `AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero`
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw`
- `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound`

### Source-Contract Gaps Already Identified

These are currently not reducible local definitions.  If Pro can solve one,
please return the minimal theorem or explain why it must remain a source
assumption.

1. `hFrozenScalarBrownianItoEventFieldCoordinateSum`

   Needed shape:

   ```lean
   testRegular ->
     forall phi x,
       emGeneratorLaplacianEventField phi x
         =
       Finset.univ.sum
         (fun i : Fin (Module.finrank Real E) =>
           brownianCoordinateGenerator phi x i)
   ```

   Current blocker:
   `emGeneratorLaplacianEventField` is abstract; no local definition connects it
   to the coordinate sum.

2. `hSelectedTestLaplacianContinuous` / `hSelectedTestLaplacianMeasurable`

   Needed shape:

   ```lean
   testRegular ->
     forall phi, Continuous (Laplacian.laplacian (selectedTest phi))
   ```

   or at least measurability / a.e. strong measurability of the test Laplacian.

3. `hSelectedEndpointCoordinateLineDef`

   Needed shape:

   ```lean
   testRegular ->
     forall phi x i z,
       sourceSelectedEndpoint phi x i z
         =
       x + z • stdOrthonormalBasis Real E i
   ```

4. `hSelectedIncrementEndpointDef`

   Needed shape:

   ```lean
   testRegular ->
     forall phi x i z,
       sourceSelectedLineIncrement phi x i z
         =
       selectedTest phi (sourceSelectedEndpoint phi x i z) - selectedTest phi x
   ```

5. `hSourceTaylorIntegrandSelectedIncrementDef`

   Needed shape:

   ```lean
   testRegular ->
     forall phi x i z,
       sourceTaylorIntegrand phi x i z
         =
       sourceSelectedLineIncrement phi x i z
   ```

6. `hSelectedLineTaylorRawSplitDef`

   Needed shape:

   ```lean
   testRegular ->
     forall phi x i z,
       selectedTest phi (x + z • stdOrthonormalBasis Real E i) - selectedTest phi x
         =
       deriv (fun q => selectedTest phi (x + q • stdOrthonormalBasis Real E i)) 0 * z
       + ((2 : Real) *
           taylorCoeffWithin
             (fun q => selectedTest phi (x + q • stdOrthonormalBasis Real E i))
             2 Set.univ 0) * z ^ 2
       + normalizedRemainder phi x i z
   ```

   Current blocker:
   `normalizedRemainder` is abstract.  If it is meant to be defined as this
   residual, Pro should propose the exact definition and theorem shape.

7. `hRemainderPullbackDef`

   Needed shape:

   ```lean
   testRegular ->
     forall phi x i,
       remainderGeneratorLimit phi x i
         =
       ∫ omega, normalizedRemainder phi x i
           (scalarBrownianCoordinate phi x i omega) ∂P
   ```

   Current blocker:
   `remainderGeneratorLimit`, `normalizedRemainder`, and
   `scalarBrownianCoordinate` are abstract in the compiled bridge.

8. `hNormalizedRemainderBoundDef`

   Needed shape:

   ```lean
   testRegular ->
     forall phi x i z,
       abs (normalizedRemainder phi x i z) <= C phi x i * z ^ 2
   ```

   or the exact bound needed to feed the already-compiled integrability lemma.

## P4: Main Theorem Closure After Analytic Backends

The following paper-level theorem contracts should not be mutated.  They should
only be promoted after P0--P3 style analytic backends are closed or recorded as
precise source-cited obligations:

- `thm:forward-KL-discrete`
  source `main_body.tex:301-326`.
- `thm:unified-forward-KL`
  source `main_body.tex:372-392`.
- `thm:general-moving-target-SALD-discrete`
  source around `appendix.tex:1313-1349` and proof starting at
  `appendix.tex:1351`.

Please do not solve P4 by adding assumptions to these theorem statements.

## Recommended Answer Format for ChatGPT Pro

Please answer in this format:

```text
Section 1: P0 mathematical proof
- State the weak FP theorem precisely.
- Identify the minimal regularity assumptions.
- Explain the conditional drift identity using condDistrib.
- Explain the diffusion term.

Section 2: P0 Lean code candidate
- Provide theorem statement(s).
- Provide proof script if possible.
- Specify target file: SALD.lean or TechnicalLemmas/*.lean.

Section 3: If P0 cannot fully close
- Give exact missing hypotheses.
- Give their Lean shapes.
- Say whether each is a source assumption, Mathlib theorem, or new local
  technical lemma.

Section 4: P1/P2/P3 follow-up theorem candidates
- Give at least one non-wrapper theorem for each priority where feasible.
- Explain which existing ASTIS theorem it plugs into.
```

## Minimal Local Commands for ASTIS After Receiving Your Answer

Once we paste Pro's result back into ASTIS, we will test with:

```bash
cd /home/nitanda_sub/mark/repos/Auto-Sampling-Theory-In-Sleep
python3 -m py_compile tools/astis.py
python3 tools/astis.py check
```

The answer is useful only if it can be converted into ASTIS-owned Lean code or a
strictly smaller `ProofObligation`.
