#' Plot invasion graph using grammar of graphics
#'
#' @param tbl list containing an invasion graph and associated metadata
#'
#' @return a ggplot
#' @author William K. Petry
#' @export
#'
#' @examples
#' \dontrun{
#' n <- 6  # set number of species
#' A <- -diag(n) - 1.5 * matrix(runif(n^2), n, n)
#' r <- matrix(1, n, 1)
#' sch <- inv_scheme(A, r)
#' gra <- inv_graph(IS = sch)
#' tidy_gra <- tidy_inv_graph(gra)
#' ggIG(tidy_gra)
#' }
#'
ggIG <- function(tbl) {
  out <- ggraph::ggraph(tbl, layout = "manual", x = x, y = y)+
    ggraph::geom_edge_fan(arrow = grid::arrow(length = grid::unit(3, 'mm'),
                                              type = "closed"),
                          end_cap = ggraph::circle(5, 'mm'))+
    ggraph::geom_node_point(ggplot2::aes(fill = type, color = permanent),
                            shape = 21, stroke = 1,
                            size = 10)+
    ggraph::geom_node_text(mapping = ggplot2::aes(label = name), color = "white")+
    ggplot2::scale_fill_manual(values = c("#BB5566", "#DDAA33", "#004488"))+
    ggplot2::scale_color_manual(values = c("black", "transparent"))+
    ggraph::theme_graph()
  return(out)
}
