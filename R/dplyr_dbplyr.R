#' clean data
#' This is a wrapper of some functions from janitor package
#' @param data A data frame.
#' @param integer64_to_num Logical to transform integer64 to numeric
#' @param factor_to_char Logical to transform factor to characters
#' @examples
#'
#' clean(head(iris, 3))
#'
#' @importFrom janitor clean_names remove_empty_cols
#' @importFrom dplyr mutate_if tbl_df
#' @export
clean <- function(data, integer64_to_num = TRUE, factor_to_char = TRUE) {

  stopifnot(is.data.frame(data))

  # clean_names dont remove especial characters
  names(data) <- stringi::stri_trans_general(names(data), "Latin-ASCII")

  data <- data %>%
    clean_names() %>%
    tbl_df() %>%
    remove_empty_cols()

  if(integer64_to_num) {
    if(getOption("jbkmisc.verbose")) message("Converting integer64 columns to numeric")
    data <- mutate_if(data, function(x){ "integer64" %in% class(x) }, as.numeric)
  }

  if(factor_to_char) {
    if(getOption("jbkmisc.verbose")) message("Converting factor columns to character")
    data <- mutate_if(data, is.factor, as.character)
  }

  data

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
countp <- function(data, ..., sort = FALSE, add_pcum = TRUE, ungroup = FALSE) {

  dc <- count(data, ..., sort = sort)
  if(ungroup) dc <- ungroup(dc)

  dc <- mutate_(dc, "p" = "n/sum(n)")

  if(add_pcum) dc <- mutate_(dc, "pcum" = "cumsum(p)")

  dc

}


#' Force computation of a tbl_lazy in the database
#' Compute doesnt work well with T-SQL so this is a custom function to do the job
#' @param x A tbl_lazy.
#' @param name Name of temporary table on database.
#' @param overwrite A logical value indicating if remove the previous table with same name.
#' @importFrom dplyr tbl
#' @importFrom dbplyr db_sql_render
#' @importFrom DBI dbSendQuery
#' @importFrom stringr str_replace
#' @export
compute2 <- function(x, name, overwrite = FALSE) {

  stopifnot("tbl_lazy" %in% class(x))
  stopifnot(is.character(name))
  stopifnot(is.logical(overwrite))

  if(overwrite) dbRemoveTableIfExists(x$src$con, name)

  qs <- db_sql_render(x$src$con, x) %>%
    as.character() %>%
    str_replace("FROM", sprintf("INTO %s FROM", name))

  if(getOption("jbkmisc.verbose")) message("Computing ", name)

  dbSendQuery(x$src$con, qs)

  xcomp <- tbl(x$src$con, name)

  xcomp

}

#' Remove table if exists
#' @param con A connection object.
#' @param name A character string specifying a table name.
#' @importFrom odbc dbExistsTable dbRemoveTable
#' @export
dbRemoveTableIfExists <- function(con, name) {

  if(dbExistsTable(conn = con, name = name)) {
    if(getOption("jbkmisc.verbose")) message("Removing ", name, " table")
    dbRemoveTable(conn = con, name = name)
  }

}


