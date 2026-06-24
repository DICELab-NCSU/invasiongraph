# Flatten a matrix into a vector

Flatten a matrix into a vector

## Usage

``` r
flatten_matrix(x, by = c("col", "row"), name_sep = "->")
```

## Arguments

- x:

  a matrix, typically with row and column names

- by:

  whether to flatten the matrix into a vector column-wise or row-wise

- name_sep:

  character(s) deliminator used between row and column names in
  flattened output

## Value

a named vector

## Examples

``` r
mat <- matrix(runif(9), nrow = 3, dimnames = list(LETTERS[1:3], letters[1:3]))
flatten_matrix(mat)
#>       A->a       B->a       C->a       A->b       B->b       C->b       A->c 
#> 0.74465008 0.45553383 0.66539986 0.70399537 0.74710558 0.93702890 0.77403403 
#>       B->c       C->c 
#> 0.07145497 0.32709825 
flatten_matrix(mat, by = "row", name_sep = "_")
#>        A_a        A_b        A_c        B_a        B_b        B_c        C_a 
#> 0.74465008 0.70399537 0.77403403 0.45553383 0.74710558 0.07145497 0.66539986 
#>        C_b        C_c 
#> 0.93702890 0.32709825 
```
