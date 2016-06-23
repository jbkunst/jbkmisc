#' Creating a md image and link source from a giphy url
#'
#' @param id id
#' @param txt_ttl title
#' @param addsource addsource
#'
#' @importFrom xml2 read_html
#' @importFrom rvest html_node html_attr
#' @importFrom magrittr %>%
#' @export
giphy <- function(id = "RgfGmnVvt8Pfy", txt_ttl =  "giphy gif", addsource = TRUE) {

  html_gif <- read_html(file.path("http://giphy.com/gifs/", id))

  url_src <- html_gif %>%
    html_node(".gif-figure a") %>%
    html_attr("href")

  url_img <- html_gif %>%
    html_node(".gif-figure img") %>%
    html_attr("src")

  md_img <- sprintf("![%s](%s)", txt_ttl, url_img)

  if (addsource) {
    md_src <- sprintf("[%s](%s)", "source", url_src)
  } else {
    md_src <- ""
  }

  md <- paste(md_img, md_src, collapse = "\n")

  asis_output(md)

}
