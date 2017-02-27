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
