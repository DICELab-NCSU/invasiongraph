#' Flatten a matrix into a vector
#' @param x a matrix, typically with row and column names
#' @param by whether to flatten the matrix into a vector column-wise or row-wise
#' @param name_sep character(s) deliminator used between row and column names in flattened output
#'
#' @return a named vector
#' @export
#' @examples
#' mat <- matrix(runif(9), nrow = 3, dimnames = list(LETTERS[1:3], letters[1:3]))
#' flatten_matrix(mat)
#' flatten_matrix(mat, by = "row", name_sep = "_")
#'
flatten_matrix <- function(x, by = c("col", "row"), name_sep = "->") {
  by <- match.arg(by)
  if (is.null(rownames(x))) {
    message("Matrix is missing row names; using indices")
    rownames(x) <- 1:nrow(x)
  }
  if (is.null(colnames(x))) {
    message("Matrix is missing column names; using indices")
    colnames(x) <- 1:ncol(x)
  }
  if (by == "col") {
    out <- vector(length = ncol(x) * nrow(x))
    nm <- vector(mode = "character", length = ncol(x) * nrow(x))
    for (i in (1:ncol(x))) {
      out[nrow(x)*(i-1)+1:nrow(x)] <- x[, i]
      nm[nrow(x)*(i-1)+1:nrow(x)] <- paste(rownames(x), colnames(x)[i], sep = name_sep)
    }
    names(out) <- nm
  }
  else {
    out <- vector(length = ncol(x) * nrow(x))
    nm <- vector(mode = "character", length = ncol(x) * nrow(x))
    for (j in (1:nrow(x))) {
      out[ncol(x)*(j-1)+1:ncol(x)] <- x[j, ]
      nm[ncol(x)*(j-1)+1:ncol(x)] <- paste(rownames(x)[j], colnames(x), sep = name_sep)
    }
    names(out) <- nm
  }
  return(out)
}
