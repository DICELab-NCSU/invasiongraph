#' @noRd
is.square <- function(x) {
  dx <- dim(x)
  return(length(dx) == 2L & dx[1] == dx[2])
}
