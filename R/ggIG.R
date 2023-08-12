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
ggIG <- function(tbl, node_size = 18, node_stroke = 1,
                 node_color = c("grey", "black"),
                 node_fill = c(` TRUE` = "#BB5566", `invadable -i TRUE` = "#DDAA33",
                               `saturated -i TRUE` = "#004488",
                               ` FALSE` = "#FF9CAA", `invadable -i FALSE` = "#FFD180",
                               `saturated -i FALSE` = "#809CDC"),
                 edge_color = c("grey80", "grey40")) {
  out <- ggraph::ggraph(graph = tbl, layout = "manual", x = x, y = y)+
    ggraph::geom_edge_fan(ggplot2::aes(edge_color = invasion_type),
                          arrow = grid::arrow(length = grid::unit(3, 'mm'), type = "closed"),
                          start_cap = ggraph::circle(node_size / 2, 'mm'),
                          end_cap = ggraph::circle(node_size / 2, 'mm'))+
    ggraph::geom_node_point(ggplot2::aes(fill = paste(type, permanent),
                                         color = permanent),
                            shape = 21, stroke = node_stroke,
                            size = node_size)+
    ggraph::geom_node_text(mapping = ggplot2::aes(label = name), color = "white")+
    ggplot2::scale_fill_manual(values = node_fill)+
    ggplot2::scale_color_manual(name = "permanence", values = node_color)+
    ggraph::scale_edge_color_manual(name = "invasion type", values = edge_color)+
    # ggplot2::scale_alpha_manual(name = "permanence", values = node_alpha)+
    ggraph::theme_graph()
  return(out)
}
