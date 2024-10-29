## Overview
PowerCHORD is an open source package for benchmarking and designing biological rhythm detection studies. It contains a lightweight R package for performing exact power analysis and MATLAB wrappers for performing power optimization. 

The main features of the package are summarized below

**Exact power analysis |**
R functions for evaluating the exact power of a cosinor-based hypothesis test. A Monte-Carlo based method is also included for comparison.

**Differential evolution |**
MATLAB implementation of differential evolution is useful for constructing an initial estimate of the gain in power due to irregular sampling.

**Exhaustive searches |**
C code for generating representatives of all rotational equivalence classes of experimental designs. This C code is obtained from J. Sawada's website and credit should be given appropriately.

**Semidefinite programming |**
While exhaustive searches are guaranteed to produce globally optimal designs, they scale poorly as the sample size increases. To overcome this, we also provide a semidefinite programming approach that performs well on sample sizes beyond the limits of exhaustive searches.

## Citation guidelines

Please cite the manuscript Silverthorne T. et al, 2024 which contains details concerning the analysis and optimization methods in this package.

## Dependencies and Installation


We suggest installing the package as a Git submodule. To do so, navigate to your project's base directory and run the following bash commands. 
```bash
 git submodule add https://github.com/t-silverthorne/PowerCHORD PowerCHORD
 git submodule init
 git submodule update
```


**Power analysis |** If you intend to use this package exclusively for power analysis, the only dependency is an up-to-date version of `R`. 

|**Dependency**|**Description**|**Version**|
| --- | --- | --- |
|[R](https://www.r-project.org)| required for power analysis and optimization | 4.4.0|

**Full package **|
The optimization methods included in PowerCHORD have additional dependencies because they rely upon lower level optimization routines. These additional dependencies are only necessary if you plan on running your own power optimization.

|**Dependency**|**Description**|**Version**|
| --- | --- | --- |
|[R](https://www.r-project.org)| required for power analysis and optimization | 4.4.0|
|[MATLAB](https://www.mathworks.com/products/matlab.html)| only required for optimization | 2024a|
|[gcc](https://gcc.gnu.org)| only required for exhaustive search optimization | 11.4.0 |
|[awk](https://invisible-island.net/mawk/) | only required for exhaustive search optimization | mawk 1.3.4 20200120|
|[yalmip](https://yalmip.github.io)| only required for semidefinite programming| R20230622 |
|[MOSEK](https://www.mosek.com)| only required for semidefinite programming |10.2|

To install the full package, start by loading PowerCHORD as a Git submodule. If you are on a Unix system, you likely already have `gcc` and `awk` installed. To confirm this, run the following.

```bash
which gcc
which awk
```

These commands should return the paths to your `gcc` and `awk` installations.  Provided that both of these are available, you can compile the `C` code necessary for exhaustive searches

```bash
cd c_src/
gcc -o necklaces_cmd necklaces_cmd.c
```

The only remaining dependencies are `yalmip` and `MOSEK`, see the following for detailed installation instructions. 

* [yalmip installation instructions](https://yalmip.github.io/tutorial/installation/)
* [MOSEK installation instrucitons](https://docs.mosek.com/latest/install/installation.html)

## Testing your installation

The `R` unit tests check that the power analysis functions are working correctly

```r
devtools:test()
```

More involved examples of power analysis and optimization can be found in the `examples/` and `MATLAB/examples` directories.

## Citations
TODO Yalmip, Sawada

