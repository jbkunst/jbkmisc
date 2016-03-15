#' Blog setup
#' @export
blog_setup <- function() {
  set_knitr_opts()
  load_fonts()
  theme_set(theme_jbk())
  invisible()
}

#' Set knitr opts
#' @importFrom knitr opts_chunk
#' @export
set_knitr_opts <- function() {
  opts_chunk$set(message = FALSE,
                 warning = FALSE,
                 fig.showtext = TRUE,
                 dev = "CairoPNG")
}


#' Load fonts
#' @importFrom sysfonts font.add.google
#' @importFrom showtext showtext.auto
#' @export
load_fonts <- function() {
  font.add.google("Open Sans Condensed",  regular.wt = 300, bold.wt = 700)
  font.add.google("Lato")
  showtext.auto()
  invisible()
}

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
  base_family = "Lato",
  plot_title_family  = "Open Sans Condensed",
  plot_title_face    = "bold",
  striptext_family   = plot_title_family,
  striptext_face     = plot_title_face,
  strip_inverse = FALSE,
  base_size = 11
) {

  # init
  thm <- theme_minimal(
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
      strip.text = element_text(family = striptext_family, face = striptext_face, hjust = 0)
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
