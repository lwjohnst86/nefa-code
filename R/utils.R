
# Misc --------------------------------------------------------------------

#' Round a number to precisely the digit indicated (e.g. "1.0", not "1").
#'
#' @param x numeric vector
#' @param digits digits to round to
#'
precise_rounding <- function(x, digits = 1) {
    trimws(format(round(x, digits = digits), nsmall = digits))
}

graph_theme <- function(base.plot, ticks = TRUE, minor.grid.lines = FALSE, legend.pos = 'bottom') {
    graph.theme <-
        ggplot2::"%+replace%"(
            ggthemes::theme_tufte(base_size = 11, base_family = 'Arial'),
            ggplot2::theme(
                axis.line = ggplot2::element_line('black', size = 0.75),
                axis.line.x = ggplot2::element_line('black', size = 0.75),
                axis.line.y = ggplot2::element_line('black', size = 0.75),
                legend.key.width = grid::unit(0.7, "line"),
                legend.key.height = grid::unit(0.7, "line"),
                strip.background = ggplot2::element_blank(),
                plot.margin = grid::unit(c(0.5, 0, 0, 0), "cm"),
                legend.position = legend.pos
            )
        )

    if (!ticks) {
        graph.theme <- ggplot2::"%+replace%"(graph.theme,
                                            ggplot2::theme(axis.ticks.y = ggplot2::element_blank()))
    }

    if (minor.grid.lines) {
        graph.theme <- ggplot2::"%+replace%"(
            graph.theme,
            ggplot2::theme(
                panel.grid = ggplot2::element_line(),
                panel.grid.minor = ggplot2::element_blank()
            )
        )
    }

    return(graph.theme)
}

format_p <- function(x) {
   format.pval(x, digits = 2, eps = 0.001)
}
