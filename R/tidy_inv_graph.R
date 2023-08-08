#' Tidy invasion graph
#'
#' @param dat llist containing an invasion graph and corresponding metadata
#' @param omit character vector of communities to omit from the plot
#' @param bend numeric, degree to bend nodes of the same diversity (0 is linear, 1 is maximum)
#'
#' @return a tibble representation of the invasion graph, with added metadata
#' @importFrom igraph graph_from_adjacency_matrix
#' @importFrom igraph E
#' @importFrom igraph V
#' @importFrom tidygraph as_tbl_graph
#' @export
#'
#' @examples
#' n <- 6  # set number of species
#' A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
#' r <- matrix(1, n, 1)
#' sch <- inv_scheme(A, r)
#' gra <- inv_graph(IS = sch)
#' tidy_inv_graph(gra)
#'
tidy_inv_graph <- function(dat, omit = c(), bend = 0.75) {
  IG <- dat$IG
  IS <- dat$IS
  number.species <- dat$number.species
  minus.i <- dat$minus.i
  permanent <- dat$permanent
  composition <- dat$composition
  not.permanent <- which(!dat$permanent)
  # create graph
  g <- igraph::graph_from_adjacency_matrix(IG)
  k <- length(number.species) # number of communities
  # set vertex coordinates
  xvals <- numeric(k)
  yvals <- numeric(k)
  lengths <- numeric(max(number.species) + 1)
  for(ii in 0:max(number.species)){
    lengths[ii + 1] <- length(which(number.species == ii))
  }
  counter <- 1
  for(i in 0:max(number.species)) {
    for(j in 1:lengths[i + 1]) {
      xvals[counter] <- j + (max(lengths) - lengths[i + 1]) / 2
      x.temp <- 2 * xvals[counter] / max(lengths) - 1
      yvals[counter] <- i - (1 - (x.temp)^2) * bend
      counter <- counter + 1
    }
  }
  igraph::V(g)$x <- xvals
  igraph::V(g)$y <- yvals
  # set vertex names
  v.name <- "∅"
  for(i in 2:k){
    temp <- composition[[i]]
    v.name <- c(v.name, paste(unlist(temp), collapse=""))
  }
  for(i in omit) v.name[i] <- ""
  igraph::V(g)$name <- v.name
  # set vertex types
  vcols <- rep("", k)
  for(i in 1:dim(IS)[2]){
    for(j in minus.i[[i]]) {
      if(IS[j, i] > 0) {
        vcols[j] <- "invasible -i"
        # for(jj in which(edges_data_frame$from == j)) {
        #   SS <- composition[j]
        #   TT <- composition[edges_data_frame$to[jj]]
        #   if(length(setdiff(SS, TT)) < 2) {
        #     igraph::E(g)$weight[jj] <- 2
        #     igraph::E(g)$type[jj] <- "leaving -i"
        #   }
        # }
      } else {
        vcols[j] <- "non-invasible -i"
      }
    }
  }
  vertex.frame.cols <- rep("", k)
  vertex.label.cols <- rep("", k)
  for(i in omit){
    vcols[i] <- NA
    vertex.frame.cols[i] <- NA
    vertex.label.cols[i] <- ""
    for(j in which(edges_data_frame$to == i)) {
      igraph::E(g)$type[j] <- NA
    }
  }
  igraph::V(g)$type <- vcols
  # permanence
  igraph::V(g)$permanent <- dat$permanent[, 1]
  # tidy
  out <- tidygraph::as_tbl_graph(g)
  return(out)
}
