#' sanitize data
#' This is a wrapper of janitor package
#' @param data A data frame.
#' @importFrom janitor clean_names remove_empty_cols
#' @export
sanitize_data <- function(data) {
  data %>%
    clean_names() %>%
    tbl_df() %>%
    remove_empty_cols()
}

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
#' @param sort same sort argument.
#' @param add_pcum Add or not cumulative percent column.
#' @param ungroup Remove the group before calculate the percents.
#' @examples
#' countp(mtcars, cyl)
#' countp(mtcars, cyl, am)
#' countp(mtcars, cyl, am, ungroup = FALSE)
#' countp(iris, "Species")
#' @importFrom dplyr ungroup mutate_
#' @export
countp <- function(data, ..., sort = FALSE, add_pcum = TRUE, ungroup = TRUE) {

  dc <- count(data, ..., sort = sort)
  if(ungroup) dc <- ungroup(dc)

  dc <- mutate_(dc, "p" = "n/sum(n)")

  if(add_pcum) dc <- mutate_(dc, "pcum" = "cumsum(p)")

  dc

}
