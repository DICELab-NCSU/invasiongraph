# Homogenize the dimensions of a set of invasion graph adjacency matrices

Homogenize the dimensions of a set of invasion graph adjacency matrices

## Usage

``` r
pad_adj_mats(iglist)
```

## Arguments

- iglist:

  A list of objects returned by \`inv_graph\`

## Value

a list of adjacency matrices with identical vertices

## Examples

``` r
set.seed(9823)
n <- 3  # set number of species
As <- replicate(5, -diag(n) - 1.5 * matrix(runif(n^2), n, n), simplify = FALSE)
r <- matrix(1, n, 1)
schs <- lapply(As, inv_scheme, r)
gras <- lapply(schs, inv_graph)
(pgras <- pad_adj_mats(gras))
#> [[1]]
#>         1 2 3 1,2 2,3 1,3 1,2,3
#>       0 1 1 1   1   1   0     0
#> 1     0 0 0 1   1   1   0     0
#> 2     0 0 0 0   1   1   0     0
#> 3     0 0 0 0   0   1   0     0
#> 1,2   0 0 0 0   0   1   0     0
#> 2,3   0 0 0 0   0   0   0     0
#> 1,3   0 0 0 0   0   0   0     0
#> 1,2,3 0 0 0 0   0   0   0     0
#> 
#> [[2]]
#>         1 2 3 1,2 2,3 1,3 1,2,3
#>       0 1 1 1   0   1   1     0
#> 1     0 0 0 0   0   0   1     0
#> 2     0 1 0 0   0   1   1     0
#> 3     0 0 0 0   0   1   1     0
#> 1,2   0 0 0 0   0   0   0     0
#> 2,3   0 0 0 0   0   0   1     0
#> 1,3   0 0 0 0   0   0   0     0
#> 1,2,3 0 0 0 0   0   0   0     0
#> 
#> [[3]]
#>         1 2 3 1,2 2,3 1,3 1,2,3
#>       0 1 1 1   1   1   1     1
#> 1     0 0 0 0   1   0   1     1
#> 2     0 0 0 0   1   1   0     1
#> 3     0 0 0 0   0   1   1     1
#> 1,2   0 0 0 0   0   0   0     1
#> 2,3   0 0 0 0   0   0   0     1
#> 1,3   0 0 0 0   0   0   0     1
#> 1,2,3 0 0 0 0   0   0   0     0
#> 
#> [[4]]
#>         1 2 3 1,2 2,3 1,3 1,2,3
#>       0 1 1 1   1   1   1     1
#> 1     0 0 0 0   1   0   1     1
#> 2     0 0 0 0   1   1   0     1
#> 3     0 0 0 0   0   1   1     1
#> 1,2   0 0 0 0   0   0   0     1
#> 2,3   0 0 0 0   0   0   0     1
#> 1,3   0 0 0 0   0   0   0     1
#> 1,2,3 0 0 0 0   0   0   0     0
#> 
#> [[5]]
#>         1 2 3 1,2 2,3 1,3 1,2,3
#>       0 1 1 1   1   1   1     0
#> 1     0 0 0 0   1   0   1     0
#> 2     0 0 0 0   1   1   0     0
#> 3     0 0 0 0   1   1   1     0
#> 1,2   0 0 0 0   0   0   0     0
#> 2,3   0 0 0 0   1   0   0     0
#> 1,3   0 0 0 0   1   0   0     0
#> 1,2,3 0 0 0 0   0   0   0     0
#> 

sapply(gras, function(x) nrow(x$IG))  # variable number of communities in original IGs
#> [1] 6 6 8 8 7
sapply(pgras, function(x) nrow(x))  # identical number of communities in padded IGs
#> [1] 8 8 8 8 8
```
