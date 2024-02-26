#' Colors used by Dubois
#'
#' @param ... Color choice or choices
#'
#' @returns Vector of colors
#' @export
#'
#' @examples
#' dubois_color("crimson")
#' dubois_color("brown", "blue", "pink")
dubois_color <- function(...) {

  # from https://github.com/ajstarks/dubois-data-portraits/
  dubois_colors <- c(
    `crimson` = "#dc143c",
    `gold`    = "#ffd700",
    `brown`   = "#654321",
    `blue`    = "#4682b4",
    `pink`    = "#ffc0cb",
    `green`   = "#00aa00",
    `tan`     = "#d2b48c",
    `purple`  = "#7e6583",
    `black`   = "#000000",
    `linen`   = "#faf0e6"
  )

  cols <- c(...)

  if (is.null(cols))
    return (dubois_colors)

  dubois_colors[cols]
}

#' Palettes of Dubois's colors
#'
#' @param palette Choice of palette: "all", "main", "alt", "seq", "seq2", "seq3", "seq4", "div", "div2", "div3", "highlight", "highlight2", highlight3"
#'
#' @returns list of colors
#' @export
#'
#' @examples
#' dubois_palette()
#' dubois_palette("alt")
dubois_palette <- function(palette = "main") {

  dubois_palettes <- list(
    `all` = dubois_color()[1:9],
    `main` = dubois_color("crimson", "gold", "brown", "blue", "green"),
    `alt` = dubois_color("black", "crimson", "gold", "green", "brown"),

    `seq` = rev(dubois_color("black", "brown", "tan", "gold")),
    `seq2` = rev(dubois_color("black", "green")),
    `seq3` = rev(dubois_color("black", "crimson", "pink")),
    `seq4` = rev(dubois_color("black", "pink")),

    `div` = rev(dubois_color("brown", "linen", "gold")),
    `div2` = rev(dubois_color("black", "linen", "green")),
    `div3` = rev(dubois_color("crimson", "linen", "blue")),

    `highlight` = dubois_color("crimson", "gold"),
    `highlight2` = dubois_color("crimson", "pink"),
    `highlight3` = dubois_color("brown", "tan")
  )

  dubois_palettes[[palette]]

}

palette_gen <- function(palette = "main", direction = 1, order = NULL) {

  function(n) {

    if (is.null(order)) {order <- 1:n}

    if (n > length(dubois_palette(palette)) & palette != "all") {
      palette <- "all"
    }

    if (n > length(dubois_palette(palette))) {
      warning("Not enough colors in this palette.")
    } else {

      all_colors <- dubois_palette(palette)

      all_colors <- unname(unlist(all_colors))

      all_colors <- if (direction >= 0) all_colors else rev(all_colors)

      color_list <- all_colors[order]

    }
  }
}

palette_gen_c <- function(palette = "seq", direction = 1, ...) {

  pal <- dubois_palette(palette)

  pal <- if (direction >= 0) pal else rev(pal)

  colorRampPalette(pal, ...)

}

#' Fill palette of Dubois colors
#'
#' @param palette Choice of palette name or number
#' @param direction Direction of color choices
#' @param order Order of color choices
#' @param ... Additional parameters passed internally
#'
#' @returns ggplot object with colors applied
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
scale_fill_dubois <- function(palette = "main", direction = 1, order = NULL, ...) {

  the_palette <- palette
  if (is.numeric(the_palette)) {
    palette <- c("main", "alt", "seq", "highlight", "highlight2", "highlight3")[the_palette]
  }

  ggplot2::discrete_scale(
    "fill", "dubois",
    palette_gen(palette, direction, order),
    ...
  )
}

scale_color_dubois <- function(palette = "main", direction = 1, order = NULL, ...) {

  the_palette <- palette
  if (is.numeric(the_palette)) {
    palette <- c("main", "alt", "seq", "highlight", "highlight2", "highlight3")[the_palette]
  }

  ggplot2::discrete_scale(
    "color", "dubois",
    palette_gen(palette, direction, order),
    ...
  )
}

scale_color_dubois_c <- function(palette = "seq", direction = 1, ...) {

  the_palette <- palette
  if (is.numeric(the_palette)) {
    palette <- c("seq", "seq2", "seq3", "seq4", "div", "div2", "div3")[the_palette]
  }

  pal <- palette_gen_c(palette = palette, direction = direction)

  scale_color_gradientn(colors = pal(256), ...)

}

scale_fill_dubois_c <- function(palette = "seq", direction = 1, ...) {

  the_palette <- palette
  if (is.numeric(the_palette)) {
    palette <- c("seq", "seq2", "seq3", "seq4", "div", "div2", "div3")[the_palette]
  }

  pal <- palette_gen_c(palette = palette, direction = direction)

  scale_fill_gradientn(colors = pal(256), ...)

}
