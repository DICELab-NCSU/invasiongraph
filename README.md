
<!-- README.md is generated from README.Rmd. Please edit that file -->

# invasiongraph

<!-- badges: start -->

[![R-CMD-check](https://github.com/DICELab-NCSU/invasiongraph/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/DICELab-NCSU/invasiongraph/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of invasiongraph is to …

## Installation

You can install the development version of invasiongraph from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("DICELab-NCSU/invasiongraph")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(invasiongraph)

# simulate Lotka-Volterra system
n <- 6  # number of species
A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)  # interaction matrix
r <- matrix(1, n, 1)  # intrinsic growth rates

# compute the invastion scheme
sch <- inv_scheme(A, r)

# calculate the invasion graph
gra <- inv_graph(IS = sch)

# tidy invasion graph to prepare for plotting
tidy_gra <- tidy_inv_graph(gra)

# plot
ggIG(tidy_gra)
```

<img src="man/figures/README-example-1.png" width="100%" />
