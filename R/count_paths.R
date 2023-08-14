#' Count invasion graph paths between nodes
#'
#' @param IG invasion graph, either raw or tidy
#' @param from name of the source vertex/node in the invasion graph
#' @param to name of the target vertex/node in the invasion graph
#'
#' @return an integer count of the total paths between nodes
#' @export
#' @importFrom igraph V
#' @importFrom igraph is.dag
#' @importFrom igraph as.igraph
#' @importFrom igraph all_simple_paths
#' @importFrom tidygraph is.tbl_graph
#'
#' @examples
#' n <- 6  # set number of species
#' A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
#' r <- matrix(1, n, 1)
#' sch <- inv_scheme(A, r)
#' gra <- inv_graph(IS = sch)
#' tidy_gra <- tidy_inv_graph(gra)
#' count_paths(tidy_gra, from = "EMPTY", to = "345")
#'
count_paths <- function(IG, from = "EMPTY", to){
  if(!tidygraph::is.tbl_graph(IG)) IG <- tidy_inv_graph(IG)
  if(!igraph::is.dag(IG)) message("Invasion graph is cyclic, but paths via cycles are ignored!")
  if(!from %in% names(igraph::V(IG))) stop("'from' node name not found.")
  if(!to %in% names(igraph::V(IG))) stop("'to' node name not found.")
  out <- length(igraph::all_simple_paths(igraph::as.igraph(IG),
                                         from = from, to = to))
  return(out)
}

