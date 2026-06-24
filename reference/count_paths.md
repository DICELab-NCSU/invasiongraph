# Count invasion graph paths between nodes

Count invasion graph paths between nodes

## Usage

``` r
count_paths(IG, from = "EMPTY", to)
```

## Arguments

- IG:

  invasion graph, either raw or tidy

- from:

  name of the source vertex/node in the invasion graph

- to:

  name of the target vertex/node in the invasion graph

## Value

an integer count of the total paths between nodes

## Author

William K. Petry

## Examples

``` r
n <- 6  # set number of species
A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
r <- matrix(1, n, 1)
sch <- inv_scheme(A, r)
gra <- inv_graph(IS = sch)
tidy_gra <- tidy_inv_graph(gra)
count_paths(tidy_gra, from = "EMPTY", to = "345")
#> [1] 20
```
