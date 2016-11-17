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

#' Execute a query given fields
#'
#'
#'
#' @importFrom whisker whisker.render
#' @importFrom stringr str_detect
#' @export
sqlquery2 <- function(chn, table = "atable", fields = c("var1", "sum(var2)")) {

  # fields <- c("id_mes", "grupo_producto", "id_producto", "sum(saldo_credito)", "count(1)")
  # table <- "dbo.fa_modelo_riesgo_ec"

  is_op <- str_detect(
    fields,
    paste0("^", c("count", "sum", "max"), "\\(", collapse = "|")
  )

  names <- fields %>%
    gsub("\\(", "_of_", .) %>%
    gsub("\\)", "", .) %>%
    paste(fields, "as", .)

  names <- ifelse(is_op, names, fields)

  q <- whisker.render(
    "select {{ fields }} from {{ table }}",
    data = list(
      fields = paste(names, collapse = ", "),
      table = table
    )
  )

  if(any(is_op)) {
    q <- whisker.render(
      paste(q, "group by {{ group }}"),
      data = list(
        group = paste(fields[!is_op], collapse = ", ")
      )
    )
  }

  message("exec:\n", q)

  sqlquery(chn, q)

}

#' Pers to date
#' @importFrom lubridate ymd
#' @export
per_to_date <- function(pers = c(200902, 201912)){
  lubridate::ymd(paste0(pers, "01"))
}
