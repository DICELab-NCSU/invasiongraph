#' Flatten a list of adjacency matrices into a character matrix
#'
#' @param matlist a list of adjacency matrices
#' @param adj_prefix prefix to add to the output row names
#' @param ... arguments passed to the matrix flattening utility function
#'
#' @return a binary character matrix indicating the presence (1) or absence (0) of a link
#' between vertices
#' @details
#' Assumes that the adjacency matrix has head and tail vertices in the columns and rows,
#' respectively.
#' @export
#' @examples
#' set.seed(9823)
#' n <- 3  # set number of species
#' As <- replicate(5, -diag(n) - 1.5 * matrix(runif(n^2), n, n), simplify = FALSE)
#' r <- matrix(1, n, 1)
#' schs <- lapply(As, inv_scheme, r)
#' gras <- lapply(schs, inv_graph)
#' pgras <- pad_adj_mats(gras)
#' adj2char(pgras)

adj2char <- function(matlist, adj_prefix = "IG", ...) {
  out <- t(sapply(matlist, flatten_matrix, simplify = "array"))
  rownames(out) <- paste0(adj_prefix, 1:nrow(out))
  return(out)
}
