# Actual enhanced-state one-step KL recurrence

SPHMC arXiv:2609.06906v1 Algorithm3.3 and Section6.3 after(6.5),actual conditional output KL recurrence

For the actual enhanced-state absorbed transition and real Gibbs base muV=volume.tilted(-V), construct target T,ideal Gaussian observation H and posterior K. Prove one-step KL((R composed P)s||Ts)<=active observation KL(Qs||Hs)+integral KL(Rt||Tt)dPs for every actual Markov R, with derived error measurability and all infinite/non-AC cases. Derive posterior recovery and conditional-reference target alignment rather than assume them.

Positive dimension,genuine C2 Hessian bounds and arbitrary positive measurable eta,tau. Actual M,R carry no approximation guarantees. Conditional reference support only under actualQ,never transferred to idealH. Actual Gibbs base is not arbitrary unrelated mu. No stage error allocation,finite-depth/global output theorem,M construction or query cost. Nested muV tilt need not be rewritten as volume tilt without required exponential integrability.

# Next source consumer: actual enhanced-state one-step KL recurrence

Planning only. ObservationConditionalKernel remains the current publication/integration packet.

Independent log_depth_source_review checked SPHMC arXiv2609.06906v1 Algorithm3.3 and Section6.3 after(6.5) and selected this dependency-ready route.

Use exactly the actual J,Q=J.fst,C=J.condKernel and absorbed P from ObservationConditionalKernel, including its pre-noise first-hit reference. Construct muV=volume.tilted(-V), actual T_s=muV.tilted(-b_s/2*norm(x-u_s)^2), and ideal H_s=GaussianSmoothing(T_s,sqrt(v_s)) with v=(eta+tau)/(beta+b). Prove for all actual Markov remaining-output kernels R:

KL((R composed P)_s || T_s) <= e(s) + integral KL(R_t || T_t) dP_s(t),

where e(s)=KL(Q_s||H_s) on b<threshold and zero otherwise. Use ENNReal, include infinite/non-AC cases, and derive required error measurability rather than assume it. No actual M accuracy or stage budgets concluded.

Ready exact dependencies:
- TechnicalLemmas.Analysis.GibbsGradientMoment.gibbs_gradient_moment returns IsProbabilityMeasure(muV) under genuine C2 positive lower Hessian bound. Use actual muV, not an unrelated arbitrary base measure. It also returns moments but they need not be used for this KL step.
- StateDependentRGO.state_dependent_recovery works on any measurable full state S, not just the old reference-deleted state. It constructs T,H,B and both posterior formulas plus ideal joint recovery. Project B to actual posterior K(s,y), use the Dirac input state recovery to get H_s K_s=T_s.
- ObservationConditionalKernel supplies actual Q observation scale sqrt(tau/(beta+b)), not sqrt(v), full conditional reference C, nested AE precision/center and active output factorization.
- FiniteRGOKLError contains local proof methods measurable_fiber_kl,conditional_kl_integral,composed_kl_bound. They are local haves, not public callable declarations. Its old-state theorem cannot replace the enhanced update. Reuse actual proof methods privately with actual new consumer, no standalone generic wrapper or duplicated public theorem.

From current support obtain Q_s-a.e.y,C(s,y)-a.e.t:T_t=K(s,y), since T depends only on precision/center. The reference remains random. Define conditional remaining kernel R composed C. Same-base KL mixture inequality bounds it against K(s,y) by conditional average KL(Rt,Tt). Chain actual Q versus ideal H, then collapse the conditional error integral via J and actual update to P_s. The stopped branch P_s=dirac(s) is direct.

CRITICAL: Never transfer C support from actualQ-a.e. to idealH-a.e. The chain error integral is under Q, which is exactly sufficient. Ideal recovery uses separately constructed K, not C integrated under H. No Q<<H premise is needed; allow KL=infinity.

Do not casually rewrite actual muV-tilt as a single volume tilt using tilted_tilted without supplying its exp(-V) integrability premise. The nested actual Gibbs definition already suffices here; additional canonical volume identity is separate unless obtained from existing exact API.

Root targeted inspection confirmed StateDependentRGO generic S and exact formulas, plus its existing internal pointwise recovery from RGOBackward. FiniteRGOKLError local methods cover non-AC/infinite branches. No next SAU/proof has yet been created.
