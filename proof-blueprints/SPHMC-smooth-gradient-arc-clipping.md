# Actual smooth gradient-arc clipping excess

For finite-dimensional real Hilbert E with d>0, eta,beta,B>0, ell>=2, differentiable f with actual beta-Lipschitz gradient and norm(h-xp)<=sqrt(d eta), suppose 1/eta^2>=64 beta^2(ell*d/B+ell^2). For the actual same independent Gaussian input and gradient arc estimator W_r, tau_B(w)=max(abs(w)-B,0), prove measurability and integrability of exp(2ell*tau_B(W_r))-1 and its expectation<=2 exp(-min(B^2/(40 beta^2 d eta^2),B/(8 beta eta))). All real r is a disclosed extension of source [0,1].

Actual smooth estimator clipping-excess moment only. Actual source center construction, target log-weight mean, normalized Renyi error, initialization and terminal query cost remain separate. No assumed MGF, surrogate estimator or full sampler completion.

Independent route review: write A=beta^2*d*eta^2 and lambda=min(1/(4 beta eta),B/(20 A)). Source condition yields2ell<=lambda; its first cap implies12beta^2eta^2lambda^2<=3/4<=1. The second cap gives10A lambda^2-B lambda<=-B lambda/2, and B lambda/2 is the displayed minimum. Pointwise split abs(w)<=B versus B<abs(w) proves0<=exp(2ell max(abs(w)-B,0))-1<=exp(-lambda B)*exp(lambda abs(w)). Apply the actual parent MGF as a proved integrable majorant before comparing integrals. No repeated Gaussian integration or Fubini.
