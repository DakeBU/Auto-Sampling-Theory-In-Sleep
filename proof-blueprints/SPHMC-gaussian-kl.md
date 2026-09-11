# Gaussian KL reverse transport

For probability P,Q on finite-dimensional real inner-product Borel E, r>=0 and tau>0, actual infimum squared-displacement transportCost(P,Q)<=ofReal(r^2) implies InformationTheory.klDiv(GaussianSmoothing P sqrt(tau),GaussianSmoothing Q sqrt(tau))<=ofReal(r^2/(2tau)). The actual ENNReal KL is used; derive all needed joint-law RN and LLR integrability from the displacement budget.

Raw infimum-cost formulation explicitly generalizes source marginal P2/W2 presentation; no marginal moments or full W2 API identity inferred. Actual optimal coupling, joint translated Gaussian laws, LLR integrability and KL data processing must be proved. No assumed Gaussian KL, conditional entropy identity or optimizer. Do not pass q>1 power bounds to q=1 using unjustified exponential displacement moments. Recursive kernels, measurable proxy choice, warmness and sampler/error/query costs remain separate.

Attain the actual cost. Form two joint Gaussian laws on ((x,y),z) with common coupling marginal and means x,y. Prove their actual withDensity/RN equality. Under the first law parameterized z=x+sqrt(tau)Z, the LLR is norm(x-y)^2/(2tau)+inner(x-y,Z)/sqrt(tau). Derive absolute integrability from quadratic displacement and Gaussian moments, prove cross mean zero, then project by the actual z map using KL data processing.

Root sole writer. Emit bounded publication packet before any Lean development.

Development checkpoint: quadratic-displacement control gives integrability and zero mean of the independent Gaussian cross inner product (scratch compiled). A joint product-map/volume-density identity also compiled, but the shorter selected route now obtains the actual joint withDensity equality directly by integral extensionality, expanding the product integral, and the existing GaussianLikelihood measure equality at each retained coupling parameter. This avoids repeating Gaussian density arithmetic and avoids parameter-dependent null-set promotion. The direct joint-likelihood and A-parameterized LLR algebra are being compiled; no production KL theorem is claimed.

Production focused and independent replay PASS3739, standard three axioms, no new lint. The actual joint KL formula, output laws and infimum-budget consumer are complete in the single production declaration. PROVED_LOCAL only; anonymous/source/fixed-commit admission and integration remain separate.

Independent fixed-commit VERIFIED at 5ac734cf9d3206add1609738315b53d6eb242826. Root now sole STABILIZING owner; aggregate and original reader/graph delivery pending. Full paper Goal remains active.
