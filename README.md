## Overview
PowerCHORD is an open source package for maximizing the statistical power of biological rhythm detection studies. The main features of the package are summarized below.

* **Exact power analysis |**
R functions for evaluating the exact power of cosinor-based hypothesis tests, including worst-case power analysis across unknown acrophases. Monte-Carlo methods are included for validation and comparison.

* **Exhaustive searches |**
R wrapper for generating all possible experimental designs under various timing constraints. The underlying C library for this feature was written by [J. Sawada](https://www.socs.uoguelph.ca/~sawada/) and made available through the [Combinatorial Object Server](http://combos.org/index). 

* **Semidefinite programming |**
MATLAB wrapper for [YALMIP](https://yalmip.github.io) optimization toolbox. Using [MOSEK](https://www.mosek.com) as a backend solver, this method can find globally optimal solutions for multi-frequency rhythm detection problems.

* **Differential evolution |**
MATLAB implementation of [differential evolution](https://en.wikipedia.org/wiki/Differential_evolution) is useful for constructing an initial estimate of the gain in power due to irregular sampling.

* **Permutation power estimation |**
MATLAB functions for estimating permutation test power in the free-period cosinor model.


Please cite the manuscript [Silverthorne et al, 2024](https://www.biorxiv.org/content/10.1101/2024.05.19.594858v1.abstract) which contains details concerning the analysis and optimization methods in this package.

**Manuscript figures |** The code for generating the figures in our manuscript is stored in a separate repository which includes PowerCHORD as a Git submodule. If you are interested in recreating the figures, please consult the [dedicated repository](https://github.com/t-silverthorne/PowerCHORDFigures).

## Installation of the PowerCHORD R package for power analysis

PowerCHORD can be installed in R with devtools:

```r
devtools::install_github("t-silverthorne/PowerCHORD")
```

Or if you are working inside this repository:
```{r}
devtools::install()
```

Once PowerCHORD is installed, the exact power of a design can then be evaluated, e.g. with `evalPower`:

```r
t=1:24 # Sampling every hour for 24 hours
evalPower(t,Amp=1,acro=0,freq=1/24)
```

```
[1] 0.8297932
```

See `examples/power_analysis.Rmd` for further power analysis usage.

## Power optimization using PowerCHORD

### Exhaustive searches using the R wrapper

The `exhaustiveSearch` `R` function has the following dependencies. 

|**Dependency**|**Description**|**Version**|
| --- | --- | --- |
|[gcc](https://gcc.gnu.org)| only required for exhaustive search optimization | 11.4.0 |
|[awk](https://invisible-island.net/mawk/) | only required for exhaustive search optimization | mawk 1.3.4 20200120|

If you are on a Unix system, you likely already have `gcc` and `awk` installed. To confirm this, run the following.
```bash
which gcc
which awk
```

The `exhaustiveSearch()` method must be executed within the PowerCHORD directory, 
therefore, we recommend cloning the repository for this usage:

```bash
git clone https://github.com/t-silverthorne/PowerCHORD
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

### Differential evolution and semidefinite programming using the MATLAB wrapper 

The differential evolution and semidefinite programming functions in `MATLAB` have the following dependencies. 

|**Dependency**|**Description**|**Version**|
| --- | --- | --- |
|[MATLAB](https://www.mathworks.com/products/matlab.html)| only required for optimization | 2024a|
|[yalmip](https://yalmip.github.io)| only required for semidefinite programming| R20230622 |
|[MOSEK](https://www.mosek.com)| only required for semidefinite programming |10.2|

Detailed installation instructions can be found at the following sites

* [MATLAB installation instructions](https://www.mathworks.com/?s_tid=gn_logo)
* [YALMIP installation instructions](https://yalmip.github.io/tutorial/installation/)
* [MOSEK installation instrucitons](https://docs.mosek.com/latest/install/installation.html)

Once you have confirmed that `yalmip` and `MOSEK` are installed and `MATLAB` can interface with both of these solvers, you should consult the `MATLAB/examples` directory to see how they are used in PowerCHORD. 


## Citations

* Ruskey, Frank, and Joe Sawada. ["An efficient algorithm for generating necklaces with fixed density."](https://epubs.siam.org/doi/abs/10.1137/S0097539798344112?casa_token=ko7rRR507vUAAAAA:4UT-zE9qX7b_AWCKkDg6bWwEgTnBCZ_83JEda2rdePbMXZQ_S7EnNl1y0iWfvNO22iBb9qMFg4oG) SIAM Journal on Computing 29.2 (1999): 671-684.]
* J. Lofberg. ["YALMIP : a toolbox for modeling and optimization in MATLAB."](https://ieeexplore.ieee.org/document/1393890) 2004 IEEE International Conference on Robotics and Automation (IEEE Cat. No.04CH37508), Taipei, Taiwan, 2004, pp. 284-289.

