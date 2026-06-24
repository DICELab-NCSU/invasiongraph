# Find the end state or states of an invasion graph.

Find the end state or states of an invasion graph.

## Usage

``` r
end_states(dat)
```

## Arguments

- dat:

  list containing species composition(s) of end state(s) and their
  corresponding -i subcommunities

## Value

list containing the compositions of the end states of community assembly

## Author

Sebastian Schreiber

William K. Petry

## Examples

``` r
n <- 6  # set number of species
A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
r <- matrix(1, n, 1)
sch <- inv_scheme(A, r)
gra <- inv_graph(IS = sch)
end_states(gra)
#> [[1]]
#> [1] 2 3 4 6
#> 
```
