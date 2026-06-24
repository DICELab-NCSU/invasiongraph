# Flatten a list of adjacency matrices into a character matrix

Flatten a list of adjacency matrices into a character matrix

## Usage

``` r
adj2char(matlist, adj_prefix = "IG", ...)
```

## Arguments

- matlist:

  a list of adjacency matrices

- adj_prefix:

  prefix to add to the output row names

- ...:

  arguments passed to the matrix flattening utility function

## Value

a binary character matrix indicating the presence (1) or absence (0) of
a link between vertices

## Details

Assumes that the adjacency matrix has head and tail vertices in the
columns and rows, respectively.

## Examples

``` r
set.seed(9823)
n <- 3  # set number of species
As <- replicate(5, -diag(n) - 1.5 * matrix(runif(n^2), n, n), simplify = FALSE)
r <- matrix(1, n, 1)
schs <- lapply(As, inv_scheme, r)
gras <- lapply(schs, inv_graph)
pgras <- pad_adj_mats(gras)
adj2char(pgras)
#>     -> 1-> 2-> 3-> 1,2-> 2,3-> 1,3-> 1,2,3-> ->1 1->1 2->1 3->1 1,2->1 2,3->1
#> IG1  0   0   0   0     0     0     0       0   1    0    0    0      0      0
#> IG2  0   0   0   0     0     0     0       0   1    0    1    0      0      0
#> IG3  0   0   0   0     0     0     0       0   1    0    0    0      0      0
#> IG4  0   0   0   0     0     0     0       0   1    0    0    0      0      0
#> IG5  0   0   0   0     0     0     0       0   1    0    0    0      0      0
#>     1,3->1 1,2,3->1 ->2 1->2 2->2 3->2 1,2->2 2,3->2 1,3->2 1,2,3->2 ->3 1->3
#> IG1      0        0   1    0    0    0      0      0      0        0   1    1
#> IG2      0        0   1    0    0    0      0      0      0        0   1    0
#> IG3      0        0   1    0    0    0      0      0      0        0   1    0
#> IG4      0        0   1    0    0    0      0      0      0        0   1    0
#> IG5      0        0   1    0    0    0      0      0      0        0   1    0
#>     2->3 3->3 1,2->3 2,3->3 1,3->3 1,2,3->3 ->1,2 1->1,2 2->1,2 3->1,2 1,2->1,2
#> IG1    0    0      0      0      0        0     1      1      1      0        0
#> IG2    0    0      0      0      0        0     0      0      0      0        0
#> IG3    0    0      0      0      0        0     1      1      1      0        0
#> IG4    0    0      0      0      0        0     1      1      1      0        0
#> IG5    0    0      0      0      0        0     1      1      1      1        0
#>     2,3->1,2 1,3->1,2 1,2,3->1,2 ->2,3 1->2,3 2->2,3 3->2,3 1,2->2,3 2,3->2,3
#> IG1        0        0          0     1      1      1      1        1        0
#> IG2        0        0          0     1      0      1      1        0        0
#> IG3        0        0          0     1      0      1      1        0        0
#> IG4        0        0          0     1      0      1      1        0        0
#> IG5        1        1          0     1      0      1      1        0        0
#>     1,3->2,3 1,2,3->2,3 ->1,3 1->1,3 2->1,3 3->1,3 1,2->1,3 2,3->1,3 1,3->1,3
#> IG1        0          0     0      0      0      0        0        0        0
#> IG2        0          0     1      1      1      1        0        1        0
#> IG3        0          0     1      1      0      1        0        0        0
#> IG4        0          0     1      1      0      1        0        0        0
#> IG5        0          0     1      1      0      1        0        0        0
#>     1,2,3->1,3 ->1,2,3 1->1,2,3 2->1,2,3 3->1,2,3 1,2->1,2,3 2,3->1,2,3
#> IG1          0       0        0        0        0          0          0
#> IG2          0       0        0        0        0          0          0
#> IG3          0       1        1        1        1          1          1
#> IG4          0       1        1        1        1          1          1
#> IG5          0       0        0        0        0          0          0
#>     1,3->1,2,3 1,2,3->1,2,3
#> IG1          0            0
#> IG2          0            0
#> IG3          1            0
#> IG4          1            0
#> IG5          0            0
```
