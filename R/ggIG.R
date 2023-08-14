#' Plot invasion graph using grammar of graphics
#'
#' @param tbl list containing an invasion graph and associated metadata
#' @param node_size numeric, size of the graph nodes/vertices
#' @param node_stroke numeric, size of the graph nodes/vertices outline
#' @param node_color colors of the graph nodes/vertices outline
#' @param node_fill colors of the the graph nodes/vertices fill
#' @param edge_color colors of the graph edge
#' @param edge_width numeric vector of line widths to use for multiple and single invasions
#' @param text_color color of the text labeling each node; may use named R colors or hex code
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
ggIG <- function(tbl, node_size = 12, node_stroke = 0.75,
                 node_color = c("grey", "black"),
                 node_fill = c(` TRUE` = "#FFFFFF", `invadable -i TRUE` = "#DDAA33",
                               `saturated -i TRUE` = "#2B5596",
                               ` FALSE` = "#EEEEEE", `invadable -i FALSE` = "#FFD180",
                               `saturated -i FALSE` = "#809CDC"),
                 edge_color = c(multiple = "grey70", single = "grey40", `leaving -i` = "#DDAA33"),
                 edge_width = c(single = 0.5, multiple = 0.15),
                 text_color = "black") {
  out <- ggraph::ggraph(graph = tbl, layout = "manual", x = x, y = y)+
    ggraph::geom_edge_fan(ggplot2::aes(edge_color = invasion_type, edge_width = invasion_type),
                          arrow = grid::arrow(angle = 20, length = grid::unit(3, 'mm'), type = "closed"),
                          start_cap = ggraph::circle(node_size / 2, 'mm'),
                          end_cap = ggraph::circle(node_size / 2, 'mm'))+
    ggraph::geom_node_point(ggplot2::aes(fill = paste(type, permanent),
                                         color = permanent),
                            shape = 21, stroke = node_stroke,
                            size = node_size)+
    ggraph::geom_node_text(mapping = ggplot2::aes(label = name), color = text_color,
                           size = 3.88 * node_size / 16)+
    ggplot2::scale_fill_manual(values = node_fill)+
    ggplot2::scale_color_manual(name = "permanence", values = node_color)+
    ggraph::scale_edge_color_manual(name = "invasion type", values = edge_color)+
    ggraph::scale_edge_width_manual(name = "invasion type", values = edge_width)+
    # ggplot2::scale_alpha_manual(name = "permanence", values = node_alpha)+
    ggraph::theme_graph()
  return(out)
}
