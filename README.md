## Overview
PowerCHORD is an open source package for maximizing the statistical power of biological rhythm detection studies. The main features of the package are summarized below.

* **Exact power analysis |**
R functions for evaluating the exact power of a cosinor-based hypothesis test. A Monte-Carlo based method is also included for comparison.

* **Differential evolution |**
MATLAB implementation of differential evolution is useful for constructing an initial estimate of the gain in power due to irregular sampling.

* **Exhaustive searches |**
R wrapper for generating databases of all possible experimental designs under various timing constraints. This code relies upon a C library written by [J. Sawada](https://www.socs.uoguelph.ca/~sawada/). Credit should be given appropriately. 

* **Semidefinite programming |**
MATLAB wrapper for yalmip and MOSEK code that solves a semidefinite programming problem to maximize power.

Please cite the manuscript [Silverthorne et al, 2024](https://www.biorxiv.org/content/10.1101/2024.05.19.594858v1.abstract) which contains details concerning the analysis and optimization methods in this package.

## Installation of the PowerCHORD R package for power analysis

We suggest installing PowerCHORD as a Git submodule. To do so, navigate to your project's base directory and run the following bash commands. 
```bash
 git submodule add https://github.com/t-silverthorne/PowerCHORD PowerCHORD
 git submodule init
 git submodule update
PowerCHORD can be installed in R with devtools:

```r
devtools::install_github("t-silverthorne/PowerCHORD")
```

Exact power of a design can then be evaluated, e.g. with `evalExactPower`:

```r
t=1:24 # Sampling every hour for 24 hours
param=list(Amp=1,acro=0,freq=1/24) # Oscillation parameters
evalExactPower(t,param)
```

```
[1] 0.8297932
```

See `examples/power_analysis.Rmd` for further power analysis usage.


### R components of PowerCHORD 

The power analysis and exhaustive search functions in `R` have the following dependencies. 

|**Dependency**|**Description**|**Version**|
| --- | --- | --- |
|[gcc](https://gcc.gnu.org)| only required for exhaustive search optimization | 11.4.0 |
|[awk](https://invisible-island.net/mawk/) | only required for exhaustive search optimization | mawk 1.3.4 20200120|


Once you have loaded PowerCHORD as a Git submodule, you should check that `gcc` and `awk` are installed. If you are on a Unix system, you likely already have `gcc` and `awk` installed. To confirm this, run the following.
```bash
which gcc
which awk
```

These commands should return the paths to your `gcc` and `awk` installations.  Provided that both of these are available, you can compile the `C` code necessary for exhaustive searches
```bash
cd c_src/
gcc -o necklaces_cmd necklaces_cmd.c
```

To check that the `R` power analysis and exhaustive search functions (which rely on `awk` and `C`) are working correctly, open an `R` session and run the built-in unit tests.

```r
devtools::test()
```

More involved examples of power analysis and optimization can be found in the `examples/`  directory.

### MATLAB components of PowerCHORD

The differential evolution and semidefinite programming functions in `MATLAB` have the following dependencies. 

|**Dependency**|**Description**|**Version**|
| --- | --- | --- |
|[MATLAB](https://www.mathworks.com/products/matlab.html)| only required for optimization | 2024a|
|[yalmip](https://yalmip.github.io)| only required for semidefinite programming| R20230622 |
|[MOSEK](https://www.mosek.com)| only required for semidefinite programming |10.2|

Detailed installation instructions can be found at the following sites
* [yalmip installation instructions](https://yalmip.github.io/tutorial/installation/)
* [MOSEK installation instrucitons](https://docs.mosek.com/latest/install/installation.html)

Once you have confirmed that `yalmip` and `MOSEK` are installed and that `MATLAB` can interface with both of these solvers, you should consult the `MATLAB/examples` directory to see how they are used in PowerCHORD. 


## Citations
[Ruskey, Frank, and Joe Sawada. "An efficient algorithm for generating necklaces with fixed density." SIAM Journal on Computing 29.2 (1999): 671-684.](https://epubs.siam.org/doi/abs/10.1137/S0097539798344112?casa_token=ko7rRR507vUAAAAA:4UT-zE9qX7b_AWCKkDg6bWwEgTnBCZ_83JEda2rdePbMXZQ_S7EnNl1y0iWfvNO22iBb9qMFg4oG)

