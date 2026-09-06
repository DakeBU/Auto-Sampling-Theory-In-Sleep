# Index and validate current RMFLD exploratory proof routes

Task id: `ASTIS-RMFLD-001`
Kind: `exploratoryProof`
Mode: `exploratoryProof`
Status: `planned`

## Goal

Index `/home/nitanda_sub/mark/repos/RMFLD/RMFLD_paper` and create proof-route
memory for active RMFLD theory without attempting broad theorem proving in the
first pass.

## Initial Targets

- `thm:general_RMFLD_finite_particle_convergence`
- `thm:SIM_main`
- `thm:finite_particle_postwarmup_convergence`
- `thm:main_theorem_ABCD`
- `thm:actual_expem_one_step_recursion_new`

## Acceptance Gate

```bash
python3 tools/astis.py source-index ASTIS-RMFLD-001
python3 tools/astis.py check
```
