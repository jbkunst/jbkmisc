#' Format table to report
#' @param data data frame
#' @param digits Same argument as round
#' @param NA_symbol NA_symbol
#' @param fun_title fun_title
#' @examples
#'
#' data <- data.frame(
#'   a_value_e = c(NA, runif(3)),
#'   `another vAl` = c(NA, runif(3)) * 10000
#'   )
#'
#' data
#' format_tbl(data)
#' format_tbl(data, digits = 0, NA_symbol = "***", fun_title = toupper)
#'
#' @importFrom scales percent comma
#' @importFrom stringr str_detect
#' @importFrom purrr set_names
#' @export
format_tbl <- function(data, digits = 2, NA_symbol = "-", fun_title = NULL) {

  stopifnot(is.data.frame(data))
  stopifnot(is.numeric(digits))
  stopifnot(is.character(NA_symbol) & is.atomic(NA_symbol))

  is_0_1 <- function(x) {

    min(x, na.rm = TRUE) >= 0 & max(x, na.rm = TRUE) <= 1

  }

  format_0_1 <- function(x, NA_symbol = "-") {

    x <- scales::percent(x)
    x <- ifelse(str_detect(x, "NA%"), NA_symbol, x)
    x

  }

  format_number <- function(x, digits = digits, NA_symbol = "-") {

    x <- round(x, digits)
    x <- scales::comma(x)
    x <- ifelse(str_detect(x, "NA"), NA_symbol, x)
    x
  }

  data <- data %>%
    mutate_if(is_0_1, format_0_1,  NA_symbol) %>%
    mutate_if(is.numeric, format_number,  digits, NA_symbol)

  if(!is.null(fun_title)) {
    data <- set_names(data, fun_title)
  }

  data

}
