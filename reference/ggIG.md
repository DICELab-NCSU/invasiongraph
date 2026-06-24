# Plot invasion graph using grammar of graphics

Plot invasion graph using grammar of graphics

## Usage

``` r
ggIG(
  tbl,
  node_size = 12,
  node_stroke = 0.75,
  node_color = c("grey", "black"),
  node_fill = c(` TRUE` = "#FFFFFF", `invadable -i TRUE` = "#DDAA33", `saturated -i TRUE`
    = "#2B5596", ` FALSE` = "#EEEEEE", `invadable -i FALSE` = "#FFD180",
    `saturated -i FALSE` = "#809CDC"),
  edge_color = c(multiple = "grey70", single = "grey40", `leaving -i` = "#DDAA33"),
  edge_width = c(single = 0.5, multiple = 0.15),
  text_color = "black"
)
```

## Arguments

- tbl:

  list containing an invasion graph and associated metadata

- node_size:

  numeric, size of the graph nodes/vertices

- node_stroke:

  numeric, size of the graph nodes/vertices outline

- node_color:

  colors of the graph nodes/vertices outline

- node_fill:

  colors of the the graph nodes/vertices fill

- edge_color:

  colors of the graph edge

- edge_width:

  numeric vector of line widths to use for multiple and single invasions

- text_color:

  color of the text labeling each node; may use named R colors or hex
  code

## Value

a ggplot

## Author

William K. Petry

## Examples

``` r
if (FALSE) { # \dontrun{
n <- 6  # set number of species
A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
r <- matrix(1, n, 1)
sch <- inv_scheme(A, r)
gra <- inv_graph(IS = sch)
tidy_gra <- tidy_inv_graph(gra)
ggIG(tidy_gra)
} # }
```
