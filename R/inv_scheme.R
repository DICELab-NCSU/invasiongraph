#' Compute the invasion scheme for a group of species
#'
#' @param A matrix containing the n x n interaction coefficients between all pairs of
#'     species.
#' @param r numeric vector containing the intrinsic growth rates for all n species.
#' @param model the underlying dynamic model describing changes in species abundance.
#'     Currently limited to "LV" for Lotka-Volterra.
#' @param tol numeric value below which values will be rounded down to zero.
#'
#' @return An n x n numeric matrix containing an invasion scheme, where rows correspond to
#'     communities and columns correspond to species.
#' @author Sebastian Schreiber
#' @importFrom matrixcalc is.singular.matrix
#' @importFrom utils combn
#' @export
#'
#' @examples
#' n <- 6  # set number of species
#' A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
#' r <- matrix(1, n, 1)
#' sch <- inv_scheme(A, r)
#'
inv_scheme <- function(A, r, model = "LV", tol = 1e-14) {
  if(!is.square(A)) stop("A must be a square matrix.")
  if(!dim(A)[1] == length(r)) stop("Dimensions of A and r imply different numbers of species.")
  if(matrixcalc::is.singular.matrix(A)) stop("A must be invertible.")

  n <- dim(A)[1]
  C <- list() # communities (as equilibria)
  C[[1]] <- rep(0, n)
  no.C <- 1
  for(i in 1:n){  # find all subcommunities
    temp <- utils::combn(1:n, i)
    k2 <- dim(temp)[2]
    for(j in 1:k2){
      I <- temp[, j]
      xtemp <- solve(a = A[I, I], b = -r[I])
      if(min(xtemp) > 0){
        no.C <- no.C + 1
        xtemp2 <- C[[1]]
        xtemp2[I] <- xtemp
        C[[no.C]] <- xtemp2
      }
    }
  }
  # create the invasion scheme matrix
  IS <- matrix(NA, length(C), n)
  for(i in 1:length(C)){
    IS[i, ] <- A %*% C[[i]] + r
  }
  IS[which(abs(IS) < tol)] <- 0
  return(IS)
}
