#' Change legend symbols to filled circles
#'
#' @param data A single row data frame containing the scaled aesthetics to display in this key.
#' @param params A list of additional parameters supplied to the geom.
#' @param size Scaled size of key circle
#'
#' @returns A grid grob.
#' @export
#'
#' @examples
#' library(ggplot2)
#' p <- ggplot(economics, aes(date, psavert, fill = "savings rate"))
#' # key glyphs can be specified by their name
#' p +
#'   geom_point(
#'     shape = 21,
#'     key_glyph = "dubois")
#'
#' # key glyphs can be specified via their drawing function
#' p +
#'   geom_point(
#'     shape = 21,
#'     key_glyph = draw_key_dubois)
draw_key_dubois <- function(data, params, size) {
  stroke_size <- data$stroke %||% 0.5
  stroke_size[is.na(stroke_size)] <- 0
  if(!is.null(data$size)){
    data$size <- data$size * 6
  }
  grid::pointsGrob(
    0.5, 0.5,
    pch = 21,
    gp = grid::gpar(
      col = alpha(data$colour %||% "black", data$alpha),
      fill = alpha(data$fill %||% "black", data$alpha),
      fontsize = (data$size %||% 6) * .pt + stroke_size * .stroke / 2,
      lwd = stroke_size * .stroke / 2))
}

`%||%` <- function(a, b)
{
  if (!is.null(a))
    a
  else b
}

