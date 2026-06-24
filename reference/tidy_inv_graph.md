# Tidy invasion graph

Tidy invasion graph

## Usage

``` r
tidy_inv_graph(dat, omit = c(), bend = 0.75)
```

## Arguments

- dat:

  list containing an invasion graph and corresponding metadata

- omit:

  character vector of communities to omit from the plot

- bend:

  numeric, degree to bend nodes of the same diversity (0 is linear, 1 is
  maximum)

## Value

a tibble representation of the invasion graph, with added metadata

## Author

William K. Petry

## Examples

``` r
n <- 6  # set number of species
A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
r <- matrix(1, n, 1)
sch <- inv_scheme(A, r)
gra <- inv_graph(IS = sch)
tidy_inv_graph(gra)
#> # A tbl_graph: 39 nodes and 285 edges
#> #
#> # A directed acyclic simple graph with 1 component
#> #
#> # Edge Data: 285 × 3 (active)
#>     from    to invasion_type
#>    <int> <int> <chr>        
#>  1     1     8 multiple     
#>  2     1     9 multiple     
#>  3     1    10 multiple     
#>  4     1    11 multiple     
#>  5     1    12 multiple     
#>  6     1    13 multiple     
#>  7     1    14 multiple     
#>  8     1    15 multiple     
#>  9     1    16 multiple     
#> 10     1    17 multiple     
#> # ℹ 275 more rows
#> #
#> # Node Data: 39 × 5
#>       x      y name  type  permanent
#>   <dbl>  <dbl> <chr> <chr> <lgl>    
#> 1   7.5 -0.746 EMPTY ""    TRUE     
#> 2   5    0.311 1     ""    TRUE     
#> 3   6    0.265 2     ""    TRUE     
#> # ℹ 36 more rows
```
