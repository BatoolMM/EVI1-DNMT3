# EVI1-DNMT3
Molecular dynamics study for the interaction between EVI1-DNMT3

## Creating the DNMT3 Structure

We used AlphaFold for accuracy > 70

https://alphafold.ebi.ac.uk/entry/Q9Y6K1

Extracted residues 474-912

`select st, b > 70`

`select st, i. 474-912`

Saved it and manipulated in PyMOL as PDBx/mmCIF

- Write connect reords for all bonds

- Retain segment identifier and atoms ids

- Write HEADER for every object

## Force Field

We used CHARMM36 force field and changed all the setting in the `.mdp` files to mach the CHARMM36 settings

```
constraints = h-bonds
cutoff-scheme = Verlet
vdwtype = cutoff
vdw-modifier = force-switch
rlist = 1.2
rvdw = 1.2
rvdw-switch = 1.0
coulombtype = PME
rcoulomb = 1.2
DispCorr = no
```

Added SEP in `residuetype.dat` and changed `CAL` to `CL` in `ions.itp`
