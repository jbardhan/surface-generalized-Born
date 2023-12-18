# surface-generalized-Born

## To do

1. MATLAB codes

2. Geometries
   - `born-ion`:
   - `arg`:
   - `spherical-protein`:
     - foo
   - `bpti`:
     - run updated VMD script (no longer using top_titr.inp) to create new PDB file
     - use `molman` scripts to generate PQR for others to see radii
     - use `FFTSVD/meshmaker` to generate a mesh

3. Documentation


## Introduction

This is a curated set of MATLAB codes and data files from papers
related to FFTSVD, BIBEE, and SLIC. Key references are given below.
The MATLAB codes are included as Git submodules, and the geometries
are included here explicitly

## Installation and Quick start

You can obtain both the codes and the geometries by running
```
git clone --recurse-submodules git@github.com:jbardhan/surface-generalized-Born.git 
```

Then open Octave, change directory into the `surface-generalized-Born` repository, and then
```
runSampleSurfaceIntegration
```

I have not tested this code in Matlab recently and don't know when I'll have the opportunity.


## Details

### MATLAB codes

#### The `pointbem` Repository

This provides a very, very simple implementation of the
boundary-element method that represents the molecular surface with 

#### The `panelbem` Repository

This repository has most of the significant functions for performing
the surface integrations and reference BEM calculations.  It
implements a BEM that uses planar triangles to discretize the
molecular surface, piecewise constant basis functions on each
triangle, and centroid collocation.

##### The `bb-matlab-analytical-nonlocal` Repository

This repository comes from our work developing a series solution to
Hildebrandt's boundary-integral formulation of a simple nonlocal
continuum model for solvation electrostatics (Bardhan, Knepley, Brune).


### Geometries

#### File types

This list is not necessarily exhaustive of what's in the
repository. Please file issues if you spot missing descriptions or if
you have questions!

1. `.pdb` files:

2. `.pqr` files:

3. `.srf` files:

4. `.xyzr` files:

5. `.vert` and `.face` files: We generate surface meshes of molecular
(solvent-excluded) surfaces, solvent-accessible surfaces, and van der
Waals surfaces using the `msms` software package and the `meshmaker`
program from our `fftsvd` package for full BEM simulation of large
molecules ([GitHub link](https://github.com/jbardhan/fftsvd))

6. `.siz` files: These are files that hold the atomic radii for the
named force field.  There are many different force field variants,
hence the number of radii.siz files.  Included for completeness.

7. `.vmd` files: These are scripts for the VMD software, used to
prepare structures for calculation or visualization.  Included for
completeness.

8. `.rtf` files: These "topology" files used by molecular dynamics
software such as CHARMM and NAMD describe the chemical connectivity of
different molecules, the types of atoms in them, and so forth.  (The
complete physics description requires a set of parameters defining
chemical interactions between molecules, such as the "effective spring
constants" between atoms of different types; such parameters are given
in a separate file, not included here.)



#### Born-ion

The simplest possible case of solvation electrostatics is the Born
ion, an atom-sized sphere with a single point charge inside at the
center.  

#### Spherical-protein

#### Arg

This comes from our earlier `testasymmetry` repo whose origin goes
back to Bardhan and Knepley (2014).


#### BPTI (bovine pancreatic trypsin inhibitor)

This atomistic model of a protein comes from Molavi Tabrizi, Bardhan,
Cooper et al. (2017).  

## References

- J. P. Bardhan, M. D. Altman, S. M. Lippow, B. Tidor, J. K. White, "A Curved Panel Inte-
gration Technique for Molecular Surfaces", Nanotech 2005.
- J. P. Bardhan, M. D. Altman, D. J. Willis, S. M. Lippow, B. Tidor, J. K. White. "Numerical
Integration Techniques for Curved-Element Discretizations of Molecule-Solvent Interfaces,"
Journal of Chemical Physics v.127, 014701 (2007).
- J. P. Bardhan, "Interpreting the Coulomb-Field Approximation for Generalized-Born Elec-
trostatics Using Boundary-Integral Equation Theory," Journal of Chemical Physics v. 129,
144105 (2008).
- J. P. Bardhan, M. Knepley, M. Anitescu. "Bounding the Electrostatic Free Energies Associated
with Linear Continuum Models of Molecular Solvation," Journal of Chemical Physics, v.130,
104108 (2009).
- J. P. Bardhan, "Numerical Discretization of Boundary Integral Equations for Molecular Elec-
trostatics," Journal of Chemical Physics, v.130, 094102 (2009).
- J. P. Bardhan, M. G. Knepley. "Modeling charge-sign asymmetric solvation free energies using
nonlinear boundary conditions," Journal of Chemical Physics (Communication), v. 141:131103
(2014).
- A. Molavi Tabrizi, A. Mehdizadeh Rahimi, S. Goossens, C. D. Cooper, M. G. Knepley, and
J. P. Bardhan. "Extending the solvation-layer interface condition (SLIC) continuum elec-
trostatic model to linearized Poisson{Boltzmann solvent," Journal of Chemical Theory and
Computation (2017).
- J. P. Bardhan. "Nonlocal Continuum Electrostatic Theory Predicts Surprisingly Small En-
ergetic Penalties for Charge Burial in Proteins," Journal of Chemical Physics, v. 135:104113
(2011).
- J. P. Bardhan, M. G. Knepley, P. Brune. "Nonlocal Electrostatics in Spherical Geometries
Using Eigenfunction Expansions of Boundary-Integral Operators," Molecular Based Mathe-
matical Biology, v. 3 (2015).
- A. Hildebrandt, PhD Thesis.
