theme_dubois <- function(bg = dubois_color("linen"),
                         minor = FALSE,
                         conditional = TRUE) {
  out <- theme_minimal() +
    theme(
      panel.background = element_rect(fill = bg,
                                      color = bg),
      panel.grid = element_line(color = "darkgray", linetype = "dotted"),
      plot.background = element_rect(fill = bg))

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
