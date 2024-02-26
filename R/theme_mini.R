#' Simple, minimal theme, with easy customizations
#'
#' @param bg Background color
#' @param text Not used
#' @param minor Minor gridlines
#' @param conditional Conditional gridlines
#'
#' @returns ggplot object
#' @export
#'
#' @examples
#'  library(dplyr)
#'  library(ggplot2)
#'  mtcars |>
#'    mutate(cyl = factor(cyl)) |>
#'    ggplot(aes(mpg, cyl, fill = cyl)) +
#'    geom_boxplot(key_glyph = "dubois") +
#'    theme_mini(conditional = TRUE) +
#'    scale_fill_dubois()
theme_mini <- function(bg = "white",
                       text = "black", # not yet supported
                       minor = FALSE,
                       conditional = TRUE) {

  out <- theme_minimal() +
    theme(
      panel.background = element_rect(fill = bg,
                                      color = bg),
      plot.background = element_rect(fill = bg)
    )
  if (!minor) {
    out <- out +
      theme(
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank()
      )
  }
  if (conditional) {
    class(out) <- c("conditional_grid", class(out))
  }

  out
}
