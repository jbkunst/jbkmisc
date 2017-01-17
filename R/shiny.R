#' Get local IP
#'
#' @export
get_my_local_ip <- function(){

  x <- system("ipconfig", intern=TRUE)
  z <- x[grep("IPv4", x)]
  ip <- gsub(".*? ([[:digit:]])", "\\1", z)

  ip

}
