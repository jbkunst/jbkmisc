#' My ggplot2 go-to theme inspired by \code{hrbrmisc}
#' @param ... Parameters
#' @importFrom ggplot2 theme_set theme element_line
#' @importFrom hrbrthemes theme_ipsum
#' @importFrom grDevices windowsFonts
#' @examples
#'
#' require(ggplot2)
#' require(hrbrthemes)
#' require(extrafont)
#' loadfonts(device = "win")
#'
#' ggplot(mtcars) +
#'   geom_point(aes(mpg, hp, color = factor(carb))) +
#'   scale_color_ipsum() +
#'   labs(x="Fuel effiiency (mpg)", y="Weight (tons)",
#'        title="Seminal ggplot2 scatterplot example",
#'        subtitle="A plot that is only useful for demonstration purposes",
#'        caption="Brought to you by the letter 'g'") +
#'  theme_jbk()
#'
#' @export
theme_jbk <- function(...) {

  theme_ipsum(base_family = "Calibri Light") +
    theme(
      panel.grid.major = element_line(colour = "grey80"),
      panel.grid.minor = element_line(colour = "grey90"),
      ...
      )

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


