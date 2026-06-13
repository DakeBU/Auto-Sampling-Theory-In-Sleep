# Self-Contained ChatGPT Pro Prompt: VA-SALD Remaining Lean Formalization Problems

Copy everything below into ChatGPT Pro.  It assumes ChatGPT Pro can read the
VA-SALD arXiv paper, but does not assume it knows any local ASTIS files,
declarations, proof logs, or folder structure.

```text
I will give you the VA-SALD paper:

  https://arxiv.org/abs/2605.07950

Please read it as the mathematical source.  I am trying to formalize the proof
in Lean 4/mathlib.  I need help with the remaining analytic proof steps in the
discrete-time VA-SALD proof, especially the weak Fokker--Planck / conditional
drift / KL derivative / integration-by-parts part.

Please answer as a Lean/mathlib formalization assistant, not only as a
probability theorist.  I need theorem statements and proof routes that can be
translated into Lean 4.  If full Lean code is too hard, give the smallest
precise theorem statements and the minimal assumptions needed.

Important: do not use fake proof closures such as `sorry`, `admit`, `axiom`,
`Prop := True`, or a theorem that just assumes the conclusion.  If a step is a
standard theorem but too large to prove directly, identify the exact theorem and
the exact assumptions needed.

The main part I need help with is the proof of the discrete-time general
VA-SALD theorem in the appendix.  The paper defines the Euler--Maruyama step

  X_{k+1}^eta
  =
  X_k^eta
  + eta * (
      dot t_k c_{t_k}(X_k^eta)
      + (sigma_{t_k}^2 / 2) grad log pi_{t_k}(X_k^eta)
    )
  + sigma_{t_k} sqrt(eta) xi_k.

On one interval s in [s_k, s_{k+1}], the paper defines the continuous frozen
interpolation

  hat X_s
  =
  X_k^eta
  + (s-s_k) * (
      dot t_k c_{t_k}(X_k^eta)
      + (sigma_eta^2 / 2) grad log pi_{t_k}(X_k^eta)
    )
  + sigma_eta (W_s - W_{s_k}).

Let

  hat rho_s = Law(hat X_s).

The paper defines the frozen conditional drift

  bar b_{k,s}(x)
  :=
  E[
    dot t_k c_{t_k}(X_k^eta)
    + (sigma_eta^2 / 2) grad log pi_{t_k}(X_k^eta)
    | hat X_s = x
  ].

The paper then says that by the Fokker--Planck equation associated with the
frozen interpolation,

  partial_s hat rho_s
  =
  - div(hat rho_s bar b_{k,s})
  + (sigma_eta^2 / 2) Delta hat rho_s.

In weak form, for a smooth compactly supported or otherwise admissible test
function phi, this should mean

  d/ds int phi(x) d hat rho_s(x)
  =
  int <grad phi(x), bar b_{k,s}(x)> d hat rho_s(x)
  + (sigma_eta^2 / 2) int Delta phi(x) d hat rho_s(x).

This is my highest-priority target.

Please do the following.

Section 1. Mathematical proof of the weak conditional Fokker--Planck identity
----------------------------------------------------------------------------

Give a careful proof of the weak identity above.  I expect the route to be:

1. Use Ito's formula on phi(hat X_s):

     d phi(hat X_s)
     =
     <grad phi(hat X_s), b_k(X_k^eta)> ds
     + (sigma_eta^2 / 2) Delta phi(hat X_s) ds
     + martingale term.

2. Take expectations:

     d/ds E[phi(hat X_s)]
     =
     E[<grad phi(hat X_s), b_k(X_k^eta)>]
     + (sigma_eta^2 / 2) E[Delta phi(hat X_s)].

3. Use the regular conditional expectation / conditional distribution identity:

     E[<grad phi(hat X_s), b_k(X_k^eta)>]
     =
     int <grad phi(x), bar b_{k,s}(x)> d hat rho_s(x).

4. Rewrite E[phi(hat X_s)] and E[Delta phi(hat X_s)] as integrals against
   hat rho_s.

Please state the minimal assumptions carefully: finite-dimensional Euclidean
state space, Brownian increment assumptions, regularity and boundedness of phi,
integrability of the drift, existence of regular conditional distributions, and
whatever is needed to justify differentiating under expectation.

Section 2. Lean 4 theorem statements for the weak FP identity
------------------------------------------------------------

Give Lean 4/mathlib theorem statements that are realistic.  You do not know my
local declarations, so use self-contained names and standard Lean/mathlib
style.  It is fine to make the state type abstract but finite-dimensional, e.g.
an inner product space over Real, or to specialize to `EuclideanSpace Real (Fin d)`
if that is more realistic.

Please propose theorem statements for at least these two lemmas:

Lemma A: conditional-drift pairing identity.

Mathematical content:

  If barB(x) is a version of E[B | X = x], then for any integrable test vector
  field G,

    int <G x, barB x> d Law(X)(x)
    =
    E[<G(X), B>].

Lean-facing content:

  Use `Measure.map`, `ProbabilityTheory.condDistrib`, Bochner integrals, and
  inner products.  If the exact mathlib API is uncertain, still give a precise
  theorem shape and say which API theorem is needed.

Lemma B: weak FP from pathwise Ito generator.

Mathematical content:

  Assume for every admissible test phi,

    HasDerivAt
      (fun s => E[phi(hatX s)])
      (E[<grad phi(hatX s0), B>]
       + (sigma^2 / 2) * E[Delta phi(hatX s0)])
      s0.

  Then, using the law identity hatRho_s = Law(hatX_s) and Lemma A, prove

    HasDerivAt
      (fun s => int phi(x) d hatRho_s(x))
      (int <grad phi(x), barB x> d hatRho_s0(x)
       + (sigma^2 / 2) * int Delta phi(x) d hatRho_s0(x))
      s0.

Please provide Lean code or Lean-like code for these lemmas.

Section 3. KL derivative formula
--------------------------------

The paper then differentiates

  KL(hat rho_s || tilde pi_s).

It writes

  d/ds KL(hat rho_s || tilde pi_s)
  =
  int partial_s hat rho_s log(hat rho_s / tilde pi_s) dx
  -
  int (hat rho_s / tilde pi_s) partial_s tilde pi_s dx,

using mass conservation int partial_s hat rho_s dx = 0.

Please give:

1. A clean mathematical theorem statement for this derivative formula in terms
   of densities q_s and p_s with respect to Lebesgue measure.
2. The minimal assumptions: positivity, differentiability in s, integrability,
   differentiation under the integral, mass conservation.
3. A Lean-facing theorem statement.  It can be abstract over a base measure mu,
   with q : Real -> E -> Real and p : Real -> E -> Real.
4. If mathlib currently lacks convenient KL/density derivative infrastructure,
   say which parts should be source-cited assumptions and which small algebraic
   lemma can still be formalized.

Section 4. Divergence rewrite, Fisher information, and integration by parts
----------------------------------------------------------------------------

The paper rewrites the weak FP equation using

  A_s = grad log(hat rho_s / tilde pi_s)

and obtains

  partial_s hat rho_s
  =
  (sigma_eta^2 / 2) div(hat rho_s A_s)
  + div(hat rho_s ((sigma_eta^2 / 2) grad log tilde pi_s - bar b_{k,s})).

Then it integrates against log(hat rho_s / tilde pi_s) and gets

  int partial_s hat rho_s log(hat rho_s / tilde pi_s)
  =
  - (sigma_eta^2 / 2) FI(hat rho_s || tilde pi_s)
  - int hat rho_s
      <(sigma_eta^2 / 2) grad log tilde pi_s - bar b_{k,s}, A_s>.

Please give:

1. The clean mathematical proof.
2. The exact no-boundary / decay / compact support assumptions needed.
3. A Lean-facing theorem statement for the integration-by-parts step.  It may
   be stated abstractly as an assumption if full Euclidean divergence theorem
   formalization is too heavy.
4. A smaller algebraic theorem that can be proved in Lean even if the analytic
   IBP theorem remains source-cited.

Section 5. Brownian/Ito generator and Taylor remainder details
--------------------------------------------------------------

If the weak FP proof needs a concrete Brownian generator calculation, please
also explain how to formalize this local generator identity:

For smooth phi and

  hat X_s = x + (s-s_k) b + sigma (W_s-W_{s_k}),

the generator contribution is

  <grad phi(x), b> + (sigma^2/2) Delta phi(x).

The remaining low-level formalization issues are:

1. turning the finite-dimensional Brownian covariance into the Laplacian;
2. writing the coordinate sum over an orthonormal basis;
3. proving measurability/integrability of Delta phi;
4. bounding the Taylor remainder by C |z|^2 or C |z|^3 depending on the exact
   Taylor expansion used.

Please propose Lean theorem statements for these pieces, preferably in a way
that avoids over-formalizing Brownian motion if the weak FP can be source-cited
as a standard Ito theorem.

Section 6. Output requirements
------------------------------

Please format the answer like this:

A. Main mathematical proof of weak conditional FP.
B. Lean theorem statements for conditional pairing and weak FP.
C. KL derivative theorem statement and proof route.
D. IBP / Fisher information theorem statement and proof route.
E. Brownian generator / Taylor remainder theorem candidates.
F. A final list of "minimal assumptions that must be added to the Lean
   formalization" versus "lemmas that should be directly provable in Lean".

Please be concrete.  I need to paste your answer into my Lean project and
translate it into code.  Avoid high-level advice that does not become theorem
statements.
```
