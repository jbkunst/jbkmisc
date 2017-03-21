#' RODBC::sqlQuery wrapper
#' Just return a tibble instead of a data.frame object.
#' @param channel Connection handle as returned by odbcConnect.
#' @param query Any valid SQL statement.
#' @importFrom dplyr tbl_df
#' @export
sqlQuery2 <- function(channel, query) {

  res <- RODBC::sqlQuery(channel, query)

  if(is.data.frame(res)){
    res <- tbl_df(res)
  }

  res
}

#' RODBC::sqlFetch wrapper
#' Just return a tibble instead of a data.frame object and fixes the
#' \code{ambigous format} casting to character the datetime values
#' @param channel Connection handle returned by odbcConnect.
#' @param sqtable	A database table name accessible from the connected DSN
#' @importFrom purrr map_lgl map dmap_if
#' @importFrom RODBC sqlQuery sqlFetch
#' @export
sqlFetch2 <- function(channel, sqtable) {

  daux <- sqlQuery(channel, sprintf("select top 10 * from %s", sqtable))

  if(any(map_lgl(daux, lubridate::is.POSIXct))) {
    message("casting to char", paste(names(daux)[map_lgl(daux, lubridate::is.POSIXct)], collapse = ", "))

    dt <- as.logical(map(map(daux, class), length) == 2)
    vars <- tolower(names(daux))
    vars <- ifelse(dt, sprintf("cast(%s as char) %s", vars, vars), vars)

    dres <- sqlQuery(channel, sprintf("select %s from %s", paste(vars, collapse = ","), sqtable))

  } else {
    dres <- sqlFetch(channel, sqtable)
  }

  if(any(map_lgl(dres, is.factor))) {
    dres <- dmap_if(dres, is.factor, as.character)
  }

  dres <- tbl_df(dres)

  dres
}


#' Execute a query given fields
#' @param chn chn
#' @param table A table name
#' @param fields fields
#' @importFrom whisker whisker.render
#' @importFrom stringr str_detect str_replace
#' @export
sqlquery2 <- function(chn, table = "atable", fields = c("var1", "sum(var2)")) {

  # fields <- c("id_mes", "grupo_producto", "id_producto", "sum(saldo_credito)", "count(1)")
  # table <- "dbo.fa_modelo_riesgo_ec"

  is_op <- str_detect(
    fields,
    paste0("^", c("count", "sum", "max"), "\\(", collapse = "|")
  )

  names <- fields %>%
    str_replace("\\(", "_of_") %>%
    str_replace("\\)", "")

  names <- paste(fields, "as", names)

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

  if(getOption("jbkmisc.verbose")) message("exec:\n", q)

  sqlQuery2(chn, q)

}
