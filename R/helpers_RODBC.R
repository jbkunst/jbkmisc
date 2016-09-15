#' My ggplot2 go-to theme inspired by \code{hrbrmisc}
#'
#' Just return a tibble instead of a data.frame object.
#'
#' @param ... Same arguments as \code{RODBC::sqlQuery}
#' @export
sqlquery <- function(...) {
  res <- RODBC::sqlQuery(...)
  if(is.data.frame(res)){
    res <- dplyr::tbl_df(res) %>%
      purrr::map_if(is.factor, as.character) %>%
      dplyr::as_data_frame()
  }
  res
}

#' Pers to date
#' @importFrom lubridate ymd
#' @export
per_to_date <- function(pers = c(200902, 201912)){
  lubridate::ymd(paste0(pers, "01"))
}
