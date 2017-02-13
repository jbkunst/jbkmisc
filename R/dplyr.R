#' Count the counts
#' @param data A data frame.
#' @param ... Variables to group by, \code{count} arguments.
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

#' Add percent to \code{count}
#' @param data A data frame.
#' @param ... Variables to group by, \code{count} arguments.
#' @param ungroup Remove the group before calculate the percents.
#' @examples
#' countp(mtcars, cyl)
#' countp(mtcars, cyl, am)
#' countp(mtcars, cyl, am, ungroup = FALSE)
#' countp(iris, "Species")
#' @importFrom dplyr ungroup mutate
#' @export
countp <- function(data, ..., ungroup = TRUE) {


  dc <- count(data, ...)
  if(ungroup) dc <- ungroup(dc)

  mutate(dc, p = n/sum(n))

}
