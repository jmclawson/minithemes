#' Display Viridis palettes
#'
#' @param palettes Choice of palettes, corresponding to one of the 8 palettes included with Viridis
#' @param colors The number of colors to generate for each palette
#'
#' @returns ggplot2 object
#' @export
#'
#' @examples
#' viridis_palettes()
viridis_palettes <- function(palettes = 1:8, colors = 9) {
  viridis_palette_df <- function(pal_num, number = 9) {
    theme_letters <- LETTERS[1:8]
    theme_names <- c("magma", "inferno", "plasma", "viridis", "cividis", "rocket", "mako", "turbo")

    theme_letter <- theme_letters[pal_num]
    theme_name <- theme_names[pal_num]
    root <- ceiling(sqrt(number))

    viridis::viridis_pal(option = theme_letter)(number) |>
      data.frame() |>
      setNames("hex") |>
      dplyr::mutate(
        x = rep(1:root, times = root)[1:number],
        y = rep(1:root, each = root)[1:number],
        letter = theme_letter,
        name = theme_name,
        label = paste0(
          "\u201C", theme_letter,
          "\u201D or ",
          "\u201C", theme_name,
          "\u201D"
        )
      )
  }

  palettes |>
    purrr::map(viridis_palette_df, number = colors) |>
    dplyr::bind_rows() |>
    ggplot2::ggplot(aes(x, -y, fill = hex)) +
    ggplot2::geom_tile() +
    ggplot2::scale_fill_identity() +
    ggplot2::theme_void() +
    ggplot2::facet_wrap(~label) +
    ggplot2::coord_equal() +
    ggplot2::theme(
      strip.text.x = ggplot2::element_text(margin = ggplot2::margin(b = 1.1)))
}
