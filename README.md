## Overview
PowerCHORD is an open source package for benchmarking and designing biological rhythm detection studies. It contains a lightweight R package for performing exact power analysis and MATLAB wrappers for performing power optimization. The main features and citation guidelines are described below. 


The main features of the package are summarized below

**Exact power analysis |**
R functions for evaluating the exact power of a cosinor-based hypothesis test. A Monte-Carlo based method is also included for comparison.

**Differential evolution |**
MATLAB implementation of differential evolution is useful for constructing an initial estimate of the gain in power due to irregular sampling.

**Exhaustive searches |**
C code for generating representatives of all rotational equivalence classes of experimental designs. This C code is obtained from J. Sawada's website and credit should be given appropriately.

**Semidefinite programming |**
While exhaustive searches are guaranteed to produce globally optimal designs, they scale poorly as the sample size increases. To overcome this, we also provide a semidefinite programming approach that performs well on sample sizes beyond the limits of exhaustive searches.

**Citing this package |**
Please cite the manuscript Silverthorne T. et al, 2024 which contains details concerning the analysis and optimization methods in this package.

## Dependencies

**Power analysis |** If you intend to use this package exclusively for power analysis, only the R dependency is necessary. 

|**Dependency**|**Description**|**Version**|
| --- | --- | --- |
|[R](https://www.r-project.org)| required for power analysis and optimization | 4.4.0|

**Full package **|
The optimization methods included in PowerCHORD have additional dependencies because they rely upon lower level optimization routines. To reiterate, these additional are only necessary if you plan on running your own power optimization.

|**Dependency**|**Description**|**Version**|
| --- | --- | --- |
|[R](https://www.r-project.org)| required for power analysis and optimization | 4.4.0|
|[MATLAB](https://www.mathworks.com/products/matlab.html)| only required for optimization | 2024a|
|[gcc](https://gcc.gnu.org)| only required for exhaustive search optimization | 11.4.0 |
|[awk](https://invisible-island.net/mawk/) | only required for exhaustive search optimization | mawk 1.3.4 20200120|
|[yalmip](https://yalmip.github.io)| only required for semidefinite programming| R20230622 |
|[MOSEK](https://www.mosek.com)| only required for semidefinite programming |10.2|

## Setup
devtools::install_github()

1. Run the R tests and look at the examples.
2. Compile the C code for exhaustive searches
3. Follow yalmip instructions and verify that MOSEK is accessible in backend
4. Look at matlab examples to see how optimization works.

## Hello world 


## Citations
TODO Yalmip, Sawada

