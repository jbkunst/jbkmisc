#' Count the counts
#' @param data A data frame.
#' @param ... Variables to group by.
#' @examples
#' ccount(iris, Species)
#' ccount_(iris, "Species")
#' @importFrom dplyr count count_
#' @export
ccount <- function(data, ...) {

  count_(count(data, ...), "n")

}

#' @rdname ccount
#' @export
ccount_ <- function(data, ...) {

  count_(count_(data, ...), "n")

}
