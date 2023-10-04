#' Homogenize the dimensions of a set of invasion graph adjacency matrices
#'
#' @param iglist A list of objects returned by `inv_graph`
#'
#' @return a list of adjacency matrices with identical vertices
#' @export
#'
#' @examples
#' set.seed(9823)
#' n <- 3  # set number of species
#' As <- replicate(5, -diag(n) - 1.5 * matrix(runif(n^2), n, n), simplify = FALSE)
#' r <- matrix(1, n, 1)
#' schs <- lapply(As, inv_scheme, r)
#' gras <- lapply(schs, inv_graph)
#' (pgras <- pad_adj_mats(gras))
#'
#' sapply(gras, function(x) nrow(x$IG))  # variable number of communities in original IGs
#' sapply(pgras, function(x) nrow(x))  # identical number of communities in padded IGs
#'
pad_adj_mats <- function(iglist){
  adjs <- lapply(iglist, function(y) y$IG)
  comps <- lapply(iglist, function(y) c("null", unlist(lapply(y$composition[-1],
                                                         function(z) paste(z, collapse = ",")))))
  for (i in 1:length(adjs)) {
    dimnames(adjs[[i]]) <- list(comps[[i]], comps[[i]])
  }
  ucomps <- unique(unlist(comps))
  out <- vector(mode = "list", length = length(adjs))
  for (j in 1:length(adjs)) {
    temp <- matrix(0L, nrow = length(ucomps), ncol = length(ucomps),
                   dimnames = list(ucomps, ucomps))
    nm <- rownames(adjs[[j]])
    temp[nm, nm] <- adjs[[j]]
    colnames(temp)[1] <- rownames(temp)[1] <- ""
    out[[j]] <- temp
  }
  return(out)
}
