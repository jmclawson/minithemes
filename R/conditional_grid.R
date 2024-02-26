#' crafts conditional grid
#' @export
ggplot_add.conditional_grid <- function(object, plot, object_name) {
  # if (!inherits(plot$facet, "FacetNull")) {
  #   object <- object + theme(panel.border = element_rect(colour = "grey50", fill = NA))
  # }

  check_mapping <- function(plot, variable) {
    if (!is.null(plot$mapping[[variable]])) {
      internal_var <- rlang::quo_get_expr(plot$mapping[[variable]])
      if ("call" %in% class(internal_var)) {
        check_character_var <- TRUE
      } else {
        check_character_var <- any(class(plot$data[[rlang::as_string(internal_var)]]) %in% c("factor", "character"))
      }
    } else {
      check_character_var_vec <- c()
      for(i in seq_along(plot$layers)) {
        internal_var <- rlang::quo_get_expr(plot$layers[[i]]$mapping[[variable]])
        if ("call" %in% class(internal_var)) {
          check_character_var_vec <- c(check_character_var_vec, TRUE)
        } else {
          check_character_var_vec <- c(check_character_var_vec, class(plot$data[[rlang::as_string(internal_var)]]) %in% c("factor", "character"))
        }
      }
      check_character_var <- any(check_character_var_vec)
    }
    return(check_character_var)
  }

  check_character_x <- check_mapping(plot, "x")
  check_character_y <- check_mapping(plot, "y")

  if (check_character_x) {
    object <- object +
      theme(panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank())
  }

  if (check_character_y) {
    object <- object +
      theme(panel.grid.major.y = element_blank(),
            panel.grid.minor.y = element_blank())
  }

  plot$theme <- add_theme(plot$theme, object)
  plot
}

add_theme <- utils::getFromNamespace("add_theme", "ggplot2")
