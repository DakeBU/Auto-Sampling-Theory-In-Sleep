# ASTIS multi-source foundation policy

## One theorem spine, several foundation sources

ASTIS keeps Sinho Chewi's textbook as the **primary theorem spine** for the textbook program.  A Chewi definition, display, proposition, theorem, or proof step is complete only when the corresponding Chewi source item has an audited source-to-Lean route and the required Lean declaration/tests compile.

Classical stochastic-analysis books are **supplementary foundation sources**.  They may explain, motivate, or supply the missing infrastructure behind a Chewi step, but they never silently replace Chewi's statement and never by themselves promote a Chewi source item to complete.

This distinction is deliberate:

1. **Source fidelity:** Chewi determines what theorem the project is claiming to formalize.
2. **Mathematical completeness:** foundation sources make omitted hypotheses, version choices, stopping/localization arguments, and completion steps explicit.
3. **Pedagogy:** the public textbook should explain why each hidden lemma is needed before exposing Lean details.
4. **Reuse:** once a hidden lemma is formalized, it should live as ASTIS-owned reusable stochastic-analysis infrastructure rather than being reproved inside one Chewi theorem.

## Reference stack and assigned roles

### Tier A — rigorous stochastic-calculus backbone

**Ioannis Karatzas and Steven E. Shreve, _Brownian Motion and Stochastic Calculus_, 2nd ed.**  
Springer: https://link.springer.com/book/10.1007/978-1-4612-0949-2

Use as the default rigorous reference for:

- martingales, filtrations, stopping times, and usual-condition issues;
- Brownian motion;
- construction and uniqueness of stochastic integrals;
- continuous modifications/versions and Itô calculus;
- existence/uniqueness and basic properties of SDE solutions.

This is the preferred reference when ASTIS must decide the exact measurable/integrable hypotheses of a missing Chewi step.

### Tier B — stochastic integration, localization, and semimartingale infrastructure

**Philip E. Protter, _Stochastic Integration and Differential Equations_, 2nd ed.**  
Springer: https://link.springer.com/book/10.1007/978-3-662-10061-5

Use especially for:

- semimartingales and stochastic integrals;
- local martingales and localization;
- stopping stochastic integrals;
- process-level convergence and general stochastic-integration machinery.

Caution: a classical source is still only a source.  ASTIS must audit the exact statement before porting it.  In particular, later literature corrected a minor mistake in Protter's Chapter V ucp characterization; therefore the project must cite the exact local statement actually used and Lean-check it rather than importing a textbook theorem by reputation.

### Tier C — reader-facing intuition and examples

**Steven E. Shreve, _Stochastic Calculus for Finance II: Continuous-Time Models_.**  
Springer: https://link.springer.com/book/9780387401010

Use for intuitive explanations of Brownian motion, martingales, stochastic integrals, Itô formula, and SDEs.  Shreve II is a pedagogical companion, not the authority for weakening a rigorous hypothesis.

**Bernt Øksendal, _Stochastic Differential Equations: An Introduction with Applications_, 6th ed.**  
Springer: https://link.springer.com/book/10.1007/978-3-642-14394-6

Use when a short concrete calculation or low-prerequisite explanation makes a definition or Itô/SDE identity easier for a first-time reader.

### Tier D — deeper continuous-martingale reference

**Daniel Revuz and Marc Yor, _Continuous Martingales and Brownian Motion_, 3rd ed.**  
Springer: https://link.springer.com/book/10.1007/978-3-662-06400-9

Use when Chewi depends on finer continuous-martingale technology, local times, representation results, or a pathwise/version argument that is awkward to reconstruct from shorter texts.

### Tier E — functional inequalities and Langevin convergence

**Dominique Bakry, Ivan Gentil, Michel Ledoux, _Analysis and Geometry of Markov Diffusion Operators_.**  
Springer: https://link.springer.com/book/10.1007/978-3-319-00227-9

Use for the reusable analytic backbone of Poincaré, logarithmic Sobolev, entropy/Fisher-information dissipation, diffusion semigroups, and convergence to equilibrium.

**Santosh S. Vempala and Andre Wibisono, _Rapid Convergence of the Unadjusted Langevin Algorithm: Isoperimetry Suffices_.**  
https://arxiv.org/abs/1903.08568

**Sinho Chewi, Murat A. Erdogdu, Mufan Bill Li, Ruoqi Shen, Matthew Zhang, _Analysis of Langevin Monte Carlo from Poincaré to Log-Sobolev_.**  
https://arxiv.org/abs/2112.12662

Use these two papers after the continuous-time SDE/functional-inequality layer is stable, to connect the formalized diffusion facts to discretized Langevin convergence under LSI/PI-type assumptions.

## Required source packet for every hidden prerequisite

When a Chewi proof omits a nontrivial stochastic-analysis step, record the following before attempting a large Lean proof:

1. **Chewi consumer:** exact source item(s) that need the fact.
2. **Hidden fact:** a source-independent mathematical statement with every hypothesis written out.
3. **Primary foundation reference:** the best rigorous source and chapter/topic.
4. **Pedagogical companion:** optional source used for intuition/examples.
5. **Lean ownership:** Mathlib declaration if exact, otherwise an ASTIS-owned target under `AutoSamplingTheory/TechnicalLemmas/`.
6. **Version policy:** whether equality is pointwise, a.e. at each deterministic time, indistinguishability/pathwise a.e., equality in `L²`, or equality of stopped processes.
7. **Failure diagnosis:** if Lean resists the statement twice in the same shape, audit the mathematical statement/hypotheses before adding wrappers.

The website's implicit-prerequisite cards should expose items 1–4 and the exact Lean declaration from item 5.  Version policy should be visible whenever it matters mathematically.

## Chapter 1 foundation DAG

For the current Chapter 1 stochastic-calculus route, use this order instead of rediscovering infrastructure theorem-by-theorem:

1. filtered probability spaces, adapted/progressive processes, stopping times;
2. elementary adapted stochastic integrals and Itô isometry;
3. product-space `L²` completion and restriction in time;
4. construction of one adapted continuous Itô-process version;
5. uniqueness/congruence of continuous versions from deterministic-time `L²` identities;
6. stopping progressive `L²` integrands and stochastic-integral stopping consistency;
7. canonical energy localizers and nested stopped-integrand equality;
8. pathwise overlap on one common full-measure event;
9. gluing a coherent localization ladder into a global continuous local martingale;
10. only then the source-facing Chewi Proposition 1.1.16 wrapper and its teaching/evidence closure.

The current `ItoIntegralProcessCongruence.itoIntegralProcess_congr_toLp_pathwise_ae` is a model example of step 5: it does **not** intersect uncountably many deterministic-time null sets.  Instead one continuous Itô process is used as a candidate continuous version for the other `L²` integrand and `itoIntegralProcess_unique` gives equality for all `t ∈ [0,T]` on one full-measure event.

## Website presentation rule

For every Chewi result whose published proof suppresses a real foundation step, the public reader should see, in this order:

1. the original Chewi statement and why it appears in the sampling argument;
2. the original proof route, with each suppressed transition expanded;
3. ASTIS implicit-prerequisite cards for the expanded transitions;
4. a short **Foundation references** block saying which classical source explains which transition;
5. optional Lean links showing the exact formal declarations.

The page must never make the reader infer that a supplementary theorem is a numbered Chewi result.  Conversely, the Lean view must never hide a mathematical assumption merely because a classical text treats it as standard.
