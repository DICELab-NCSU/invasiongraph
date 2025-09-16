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
  end.states <- vector(mode = "list")
  for(i in 1:length(dat$minus.i)) {
    who <- dat$minus.i[i][[1]]
    com <- dat$composition[[who]]  # TODO: fix to allow multiple invasions (-com in next line)
    if(max(dat$IS[who, -com]) < 0) {
      end.states[[i]] <- who
    }
  }
  end.states[sapply(end.states, is.null)] <- NULL
  out <- lapply(unique(end.states), function(x) dat$composition[[x]])
  return(out)
}
