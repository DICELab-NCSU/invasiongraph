#' Find the end state or states of an invasion graph.
#'
#' @param dat list containing species composition(s) of end state(s) and their corresponding
#' -i subcommunities
#'
#' @return list containing the compositions of the end states of community assembly
#' @author Sebastian Schreiber
#' @author William K. Petry
#' @export
#'
#' @examples
#' n <- 6  # set number of species
#' A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
#' r <- matrix(1, n, 1)
#' sch <- inv_scheme(A, r)
#' gra <- inv_graph(IS = sch)
#' end_states(gra)
#'
end_states <- function(dat) {
  if(!dat$acyclic) stop("Invasion graph must be acyclic.")
  idx <- which(rowSums(dat$IG) == 0L)
  out <- dat$composition[idx]
  return(out)
}
