#' My ggplot2 go-to theme inspired by \code{hrbrthemes}
#' @param base_family base_family
#' @param plot_title_face plot_title_face
#' @param plot_title_size plot_title_size
#' @param ... Parameters for \code{hrbrthemes::theme_ipsum}
#' @importFrom ggplot2 theme_set theme element_line element_blank element_rect margin
#'   element_text
#' @importFrom hrbrthemes theme_ipsum
#' @examples
#'
#'
#' \dontrun{
#' require(ggplot2)
#' require(hrbrthemes)
#' require(extrafont)
#' loadfonts()
#'
#' ggplot(mtcars) +
#'   geom_point(aes(mpg, hp, color = factor(carb))) +
#'   scale_color_ipsum() +
#'   labs(x="Fuel effiiency (mpg)", y="Weight (tons)",
#'        title="Seminal ggplot2 scatterplot example",
#'        subtitle="A plot that is only useful for demonstration purposes",
#'        caption="Brought to you by the letter 'g'") +
#'  theme_jbk()
#' }
#'
#' @export
theme_jbk <- function(
  base_family = "",
  plot_title_face = "plain",
  plot_title_size = 14,
  ...) {

  theme_ipsum(
    base_family = base_family,
    plot_title_face = plot_title_face,
    plot_title_size = plot_title_size,
    plot_margin = margin(15, 15, 15, 15), ...) +
    theme(
      title = element_text(colour = "#444444"),
      panel.grid.major = element_line(colour = "grey90"),
      panel.grid.minor = element_line(colour = "grey90"),
      legend.position = "bottom"
      )

}

#' My ggplot2 null theme
#' @param ... Parameters
#' @export
theme_null <- function(...) {
  theme(...,
        axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position = "none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank())
}

#' @rdname theme_null
tomorrow_night <- function(...) {
  bgrcol <- "#1D1F21"
  txtcol <- "#C5C8C6"
  grlcol <- "#666666"

  theme(...,
        rect = element_rect(fill = bgrcol, linetype = NULL),
        panel.background = element_blank(),
        text = element_text(colour = txtcol),
        panel.grid.major = element_line(colour = grlcol),
        panel.grid.minor = element_line(colour = grlcol),
        legend.position = "bottom")
}



#' Auxiliar function to generate a filename following a pattern
#' @param folder .
#' @param pattern .
#' @param ext .
#' @param npad .
#' @importFrom stringr str_pad str_c
#' @export
filename_gen <- function(folder = "plots", pattern = "plot", ext = "jpg", npad = 2) {
  n <- length(dir(folder, pattern = pattern))
  n <- n + 1
  n <- str_pad(n, npad, pad = "0")
  file.path(folder, str_c(pattern, "_", n, ".", ext))
}

#' Function to save the last_plot using filename_gen
#' @param folder .
#' @param pattern .
#' @param ext .
#' @param npad .
#' @param width .
#' @param height .
#' @param scale .
#' @importFrom ggplot2 ggsave
#' @export
ggsav <- function(folder = "plots", pattern = "plot", ext = "jpg", npad = 2,
                  width = 16, height = 9, scale = 0.75) {
  fn <- filename_gen(folder, pattern = pattern, ext = ext)
  message("saving: ", fn)
  ggsave(fn, width = width, height = height, scale = scale)
}


#' Update geoms colour
#' @param figs_color figs_color
#' @param text_color text_color
#' @importFrom ggplot2 update_geom_defaults
#' @examples
#'
#' update_some_geom_defaults_color()
#'
#' ggplot(mtcars) +
#'   geom_point(aes(mpg, hp))
#'
#' @export
update_some_geom_defaults <- function(
  figs_color = "#008441",
  text_color = "gray40"
  ){

  lapply(
    c("line", "point"),
    function(x){
      update_geom_defaults(x, list(colour = figs_color))
    })

  lapply(
    c("bar"),
    function(x){
      update_geom_defaults(x, list(fill = figs_color))
    })


  lapply(
    c("text", "label"),
    function(x){
      update_geom_defaults(x, list(colour = text_color))
    })

  invisible(TRUE)

}
