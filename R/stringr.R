#' Transform name colums to human readable strings
#' @param string String
#' @param sep Pattern to make spaces strings
#' @param fun Function to apply before the separation
#' @examples
#'
#' string <- c("name.with...points", "or_Under___scores")
#' string
#'
#' str_clean(string)
#' str_clean(string, fun = toupper)
#' str_clean(string, fun = stringr::str_to_title)
#'
#' @importFrom stringr str_replace_all
#' @export
str_clean <- function(string, sep = "_|\\.", fun = stringr::str_to_title) {

  stopifnot(is.character(string))
  stopifnot(is.character(sep))

  string <- string %>%
    str_replace_all(pattern = sep, replacement = " ") %>%
    str_replace_all(pattern = "\\s+", replacement = " ")

  if(!is.null(fun)) {
    string <- fun(string)
  }

  string

}
