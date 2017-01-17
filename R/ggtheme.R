#' My ggplot2 go-to theme inspired by \code{hrbrmisc}
#' @param base_family base_family
#' @param plot_title_family plot_title_family
#' @param plot_title_face plot_title_face
#' @param striptext_family striptext_family
#' @param striptext_face striptext_face
#' @param strip_inverse strip_inverse
#' @param base_size base_size
#' @import ggplot2
#' @export
theme_jbk <- function(
  base_family        = "Calibri Ligth", #"Roboto",
  plot_title_family  = "Arial Narrow", # "Roboto Condensed",
  plot_title_face    = "plain",
  striptext_family   = plot_title_family,
  striptext_face     = plot_title_face,
  strip_inverse      = FALSE,
  base_size          = 11
) {

  # init
  thm <- ggplot2::theme_minimal(
    base_size = base_size,
    base_family = base_family
    )

  # general
  thm <- thm +
    theme(
      legend.background = element_blank(),
      legend.key = element_blank()
    )

  # font
  thm <- thm +
    theme(
      plot.title = element_text(family = plot_title_family, face = plot_title_face, hjust = 0),
      strip.text = element_text(family = striptext_family, face = striptext_face, hjust = 0, size = base_size)
    )

  # legend
  hm <- thm +
    theme(
      legend.position = "bottom"
    )

  if (strip_inverse) {
    thm <- thm +
      theme(
        strip.background = element_rect(fill = "#858585", color = NA),
        strip.text = element_text(color = "white")
      )
    }

  thm

}
