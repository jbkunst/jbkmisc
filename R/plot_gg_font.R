#' Blog setup
#' @importFrom knitr opts_chunk
#' @param message = FALSE,
#' @param warning = FALSE,
#' @param fig.showtext = TRUE,
#' @param dev = "CairoPNG",
#' @param fig.width = 16,
#' @param fig.height = 9,
#' @param dpi = 72
#' @export
blog_setup <- function(
  message = FALSE,
  warning = FALSE,
  fig.showtext = TRUE,
  dev = "CairoPNG",
  fig.width = 11,
  fig.height = 7,
  dpi = 72) {

  load_fonts()

  opts_chunk$set(
    message = message,
    warning = warning,
    fig.showtext = fig.showtext,
    dev = dev,
    fig.width = fig.width,
    fig.height = fig.height,
    dpi = dpi
    )

  theme_set(theme_jbk())
  # if (is.null(knitr::opts_knit$get("rmarkdown.pandoc.to"))) {
  #
  # } else {
  #   theme_set(theme_jbk(base_size = base_size_html))
  # }

  invisible()
}

#' Load fonts
#' @importFrom sysfonts font.add.google
#' @importFrom showtext showtext.auto
#' @export
load_fonts <- function() {
  font.add.google("Open Sans Condensed",  regular.wt = 300, bold.wt = 700)
  font.add.google("PT Sans Narrow")
  font.add.google("Lato")
  font.add.google("Roboto")
  font.add.google("Roboto Condensed")
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
  base_family        = "Roboto",
  plot_title_family  = "Roboto Condensed",
  plot_title_face    = "bold",
  striptext_family   = plot_title_family,
  striptext_face     = plot_title_face,
  strip_inverse      = FALSE,
  base_size          = 11
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
