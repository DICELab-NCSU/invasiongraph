# Compute the invasion scheme for a group of species

Compute the invasion scheme for a group of species

## Usage

``` r
inv_scheme(
  A,
  r,
  model = "LV",
  zero = 1e-14,
  tol_singular = 1e-08,
  tol_solve = .Machine$double.eps
)
```

## Arguments

- A:

  matrix containing the n x n interaction coefficients between all pairs
  of species.

- r:

  numeric vector containing the intrinsic growth rates for all n
  species.

- model:

  the underlying dynamic model describing changes in species abundance.
  Currently limited to "LV" for Lotka-Volterra.

- zero:

  numeric absolute value below which invasion scheme growth rates will
  be rounded down to zero. Setting equal to 0 will skip rounding.
  Defaults to 1e-14.

- tol_singular:

  numeric tolerance for the test for matrix singularity. Defaults to
  1e-08.

- tol_solve:

  numeric tolerance for detecting linear dependencies in the columns
  of A. The default is \`.Machine\$double.eps\`.

## Value

An n x n numeric matrix containing an invasion scheme, where rows
correspond to communities and columns correspond to species.

## Author

Sebastian Schreiber

## Examples

``` r
n <- 6  # set number of species
A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
r <- matrix(1, n, 1)
sch <- inv_scheme(A, r)
```
