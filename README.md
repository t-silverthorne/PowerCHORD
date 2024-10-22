## Overview
This package contains the power analysis and optimisation functions supporting the manuscript Silverthorne T. et al, 2024. 

## Dependencies
|**Dependency**|**Description**|**Version**|
| --- | --- | --- |
|[R](https://www.r-project.org)| required for power analysis and optimisation | 4.4.0|
|[MATLAB](https://www.mathworks.com/products/matlab.html)| only required for optimisation | 2024a|
|[gcc](https://gcc.gnu.org)| only required for exhaustive search optimisation | 11.4.0 |
|[awk](https://invisible-island.net/mawk/) | only required for exhaustive search optimisation | mawk 1.3.4 20200120|
|[yalmip](https://yalmip.github.io)| only required for semidefinite programming| R20230622 |
|[MOSEK](https://www.mosek.com)| only required for semidefinite programming |10.2|

## Setup
1. Run the R tests and look at the examples.
2. Compile the C code for exhaustive searches
3. Follow yalmip instructions and verify that MOSEK is accessible in backend
4. Look at matlab examples to see how optimization works.

## Citations
TODO Yalmip, Sawada

