# Construct the invasion graph corresponding to an invasion scheme

Construct the invasion graph corresponding to an invasion scheme

## Usage

``` r
inv_graph(IS, skip_minus_i = FALSE)
```

## Arguments

- IS:

  matrix containing an invasion scheme with rows representing
  communities and columns representing species.

- skip_minus_i:

  logical, when TRUE the -i communities will be skipped, speeding up the
  calculation

## Value

list containing an invasion graph and corresponding metadata. See
Details for description of list elements.

## Details

The returned list includes the following named elements:

- IG:

  matrix containing the invasion graph

- acyclic:

  logical, whether the invasion graph is acyclic

- permanent:

  logical matrix indicating the permanence of each community

- minus.i:

  list containing the indices of each community that is a -i community

- number.species:

  integer vector of the number of species in each community

- composition:

  list containing vectors with the species ids in each community

- IS:

  matrix containing the originally supplied invasion scheme

## Author

Sebastian Schreiber

## Examples

``` r
n <- 6  # set number of species
A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
r <- matrix(1, n, 1)
sch <- inv_scheme(A, r)
gra <- inv_graph(IS = sch)
gra2 <- inv_graph(IS = sch, skip_minus_i = TRUE)
```
