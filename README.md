# surface-generalized-Born

## To do

1. MATLAB codes

2. Geometries
   - GENERAL: all my dielectric boundaries are currently meshed as molecular (solvent-excluded) surfaces. I'll need to re-mesh these and create new `.srf` files for the van der Waals surfaces of interest (union of balls).
   - `born-ion`:
   - `spherical-protein`:
     - test `figureBpti.m`
   - `arg`:
     - needs a PQR file before this case can be run in MATLAB/Octave
   - `bpti`:
     - run updated VMD script (no longer using top_titr.inp) to create new PDB file.  Does the VMD script need to be run at all?  There are some disulfide bonds but those were probably already included in Radhakrishnan lab structure included here.
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

1. `.pdb` files: The `.pdb` file is a very commonly used format for
exchanging information about biological molecules.  There is a formal
specification of the file format, with different versions of the
specification having meaningfully different formats, and critically
there are also numerous "unofficial" variants used throughout
computational chemistry.  

2. `.pqr` files: A `.pqr` file is the basic input to the `APBS`
software developed by Nathan Baker et al.  Just as with `.pdb` files,
there are unfortunately a few different flavors of `.pqr` file.  These
are used as inputs to the `readpqr.m` function in solving
electrostatics BEM problems with `pointbem` or `panelbem`; if you
encounter errors running examples that seem to point to `readpqr`
please file an issue as it may mean that this repository has an
inconsistent or incompatible flavor of `.pqr` file.

3. `.srf` files: A `.srf` file is the output of running the
`meshmaker` program in our `fftsvd` BEM package.  It holds information
about (A) what kind of surface discretization is being used, flat
boundary elements or curved ones (curved ones have not been used in a
long time, consider deprecated); (B) whether the surface
discretization employs salt-exclusion (Stern) surfaces or not; and (C)
which surfaces are inside which other ones. This last component is
important because the dielectric boundaries are inside Stern surfaces
(if those are desired), and proteins and other molecules sometimes
have water-filled cavities.  See Altman and Bardhan JCC 2009.

4. `.xyzr` files: These are generated by our `meshmaker` program from
our `fftsvd` BEM package, see below.  Essentially these files are
`.pqr` files with all the chemical detail stripped out, keeping only
the details of the spheres themselves.

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
center. Due to symmetry, this case can hide certain kinds of
mathematical errors or numerical algorithm bugs.  This directory holds
files from our Bardhan and Knepley (2014) introduction of the SLIC
nonlinear boundary condition model.  There are three classes of files:

- `.srf` files: These are named `born_1A_X.srf` where `X` is the
  discretization parameter given to `meshmaker` (in our `fftsvd`
  package, not included in this repo for now but available at GitHub,
  see link elsewhere in this file).  This discretization parameter is
  in turn passed to Michael Sanner's `msms` package (put link here)
  which generates a triangular surface mesh with `X` vertices per
  square Angstrom.

- `.m` files: MATLAB scripts.  I haven't tested these since creating
  this repository so they will likely need paths edited, additional
  MATLAB functions may be needed, and certain calling semantics may be
  out of date due to changes in the `panelbem` and `pointbem` repos
  since these were originally written.

- `meshes/` subdirectory holds the `.vert` and `.face` files
  referenced by the `.srf` files.  Note that we use relative paths in
  these, so they can't just be moved around without care.

#### Spherical-protein

After the Born ion type of problem, the next more challenging set of
examples can be obtained by looking at a spherical molecule with
off-center charges.  This directory holds our example of a spherical
protein of 24 Angstrom in radius, with the charge distribution taken
from the protein BPTI (bovine pancreatic trypsin inhibitor).  This
example was used in Bardhan, Knepley, and Brune (BKB). Currently the
directory only holds three files:

- `bpti.pdb` is some prepared version of the BPTI structure. Details
  on the structure preparation should be in the BKB paper.

- `bpti.pqr` is the PQR version of the `.pdb` file.

- `figureBpti.m` is the MATLAB script used to generate the figure in
  BKB.  It has not been tested in a long time, and will surely need
  editing to run in the current repo, with up-to-date versions of the
  `bb-matlab-analytical-nonlocal` repo and others.



#### Arg

This comes from our earlier `testasymmetry` repo whose origin goes
back to Bardhan and Knepley (2014).  There are three kinds of files in
this directory currently.

- `arg.pdb` is the prepared molecular structure of an arginine
  residue, with neutral blocking (aka capping) groups at the N and C
  termini.  Details of the preparation process are in the paper.

- `arg_X_Y.srf` are the surface description files, where `X` denotes
  which `radii.siz` file was used and `Y` denotes the surface
  discretization level (again, in vertices per square Angstrom).

- `.vert` and `.face` files that describe the triangular meshes for
  each `.srf` file.

I need to add a PQR file for this to be usable in Matlab; have added a
note to that effect in the TO DO section.


#### BPTI (bovine pancreatic trypsin inhibitor)

This atomistic model of a protein comes from Molavi Tabrizi, Bardhan,
Cooper et al. (2017).   There are currently three files in this directory:

- `bpti_3btk_prepared_mona_take2.pdb`: Taken from Kreienkamp et al
  (2013).  Mala Radhakrishnan's lab prepared this structure for a
  separate paper and my lab used it for Molavi Tabrizi 2017.

- `build_bpti.vmd`: the VMD script to turn the above PDB into a PDB we
  can use for.  (This may be redundant?  I can check on that; the
  Molavi Tabrizi 2017 paper needed to mutate the titratable residues
  for a particular force field I had been using for SLIC, see Bardhan
  Knepley 2014.  However, the Radhakrishnan lab had prepared the
  structure for standard electrostatics, as the filename indicates.)
  Included for completeness.

- `top_all27_prot_lipid_more.rtf`: the topology file VMD will need, if
  one needs to run the `.vmd` script.


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
- M. D. Altman, J. P. Bardhan, J. K. White, B. Tidor. "Accurate Solution of Multi-Region Con-
tinuum Biomolecule Electrostatic Problems Using the Linearized Poisson{Boltzmann Equation
with Curved Boundary Elements," Journal of Computational Chemistry, v. 30(1), 132-153
(2009).
- A. B. Kreienkamp, L. Y. Liu, M. S. Minkara, M. G. Knepley, J. P. Bardhan, M. L. Radhakr-
ishnan. "Analysis of fast boundary-integral approximations for modeling electrostatic contri-
butions of molecular binding," Molecular Based Mathematical Biology, v. 1:124150 (2013).