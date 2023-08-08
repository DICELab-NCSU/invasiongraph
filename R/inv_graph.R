#' Construct the invasion graph corresponding to an invasion scheme
#'
#' @param IS matrix containing an invasion scheme with rows representing communities and
#'     columns representing species.
#' @param skip_minus_i logical, when TRUE the -i communities will be skipped, speeding up
#'     the calculation
#' @return list containing an invasion graph and corresponding metadata. See Details for
#'     description of list elements.
#' @details
#' The returned list includes the following named elements:
#' \describe{
#'   \item{IG}{matrix containing the invasion graph}
#'   \item{acyclic}{logical, whether the invasion graph is acyclic}
#'   \item{permanent}{logical matrix indicating the permanence of each community}
#'   \item{minus.i}{list containing the indices of each community that is a -i community}
#'   \item{number.species}{integer vector of the number of species in each community}
#'   \item{composition}{list containing vectors with the species ids in each community}
#'   \item{IS}{matrix containing the originally supplied invasion scheme}
#' }
#'
#' @importFrom igraph graph_from_adjacency_matrix
#' @importFrom igraph is_dag
#' @export
#'
#' @examples
#' n <- 6  # set number of species
#' A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
#' r <- matrix(1, n, 1)
#' sch <- inv_scheme(A, r)
#' gra <- inv_graph(IS = sch)
#' gra2 <- inv_graph(IS = sch, skip_minus_i = TRUE)
#'
inv_graph <- function(IS, skip_minus_i = FALSE){
  if(!is.matrix(IS)) stop("IS must be an invasion scheme matrix")
  k <- dim(IS)[1] # number of communities
  n <- dim(IS)[2] # number of species
  if(k > sum(choose(n, 1:n))) stop("IS has more rows than possible communities.")
  composition <- vector(k, mode = "list") # a list to hold the composition of the communities
  for(i in 1:k) composition[[i]] <- which(IS[i, ] == 0)
  # compute the invasion graph
  IG <- matrix(0, k, k)
  for(i in 1:k){
    for(j in 1:k){
      if(i != j){
        b <- composition[[j]]
        a <- composition[[i]]
        c <- setdiff(b, a)
        condition.1 <- 1
        if(length(c) > 0) condition.1 <- min(IS[i, c])
        c2 <- setdiff(a, b)
        condition.2 <- -1
        if(length(c2) > 0) condition.2 <- max(IS[j, c2])
        if((condition.1 > 0) & (condition.2 < 0)) IG[i, j] <- 1
      }
    }}
  # computing the graph to determine whether acyclic
  g <- igraph::graph_from_adjacency_matrix(IG)

  if (skip_minus_i) {
    # determine which communities are permanent
    # only sensible if the graph is acyclic
    permanent <- TRUE
    for(j in 1:k){
      if((max(IS[j, ]) <= 0) && (length(composition[[j]]) < n)) permanent <- FALSE
    }
    out <- list(IG = IG,
                acyclic = igraph::is_dag(g),
                permanent = permanent,
                minus.i = NULL,
                number.species = NULL,
                composition = NULL,
                IS = IS)
  } else {
    # determine which communities are permanent
    # only sensible if the graph is acyclic
    permanent <- matrix(TRUE, k, 1)
    for(i in 1:k){
      for(j in 1:k){
        if((j != i) && all(composition[[j]] %in% composition[[i]])) {
          if((max(IS[j, composition[[i]]]) <= 0)){
            permanent[i] <- FALSE
          }
        }
      }
    }
    # identify the minus i communities
    minus.i <- list()
    for(i in 1:n){
      temp <- c()
      for(j in 1:k){
        if((!is.element(i, composition[[j]])) && (max(IS[j, -i]) <= 0)) temp <- c(temp, j)
      }
      minus.i[[i]] <- temp
    }
    # count the number of species in each community
    # numbers of spp
    nums <- numeric(k)
    for(i in 1:k) nums[i] <- length(which(IS[i, ] == 0))
    out <- list(IG = IG,
                acyclic = igraph::is_dag(g),
                permanent = permanent,
                minus.i = minus.i,
                number.species = nums,
                composition = composition,
                IS = IS)
  }
  return(out)
}
