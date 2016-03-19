#' Creating a md image and link source from a giphy url
#'
#' @param url url
#' @param txt_ttl title
#' @param txt_src txt_src
#'
#' @importFrom xml2 read_html
#' @importFrom rvest html_node html_attr
#' @importFrom magrittr %>%
#' @export
giphy <- function(url = "http://giphy.com/gifs/art-tech-algorithm-J7NAxMWW5Q6cg", txt_ttl =  "giphy gif", txt_src = "source") {

  html_gif <- read_html(url)

  url_src <- html_gif %>%
    html_node(".gif-figure a") %>%
    html_attr("href")

  url_img <- html_gif %>%
    html_node(".gif-figure img") %>%
    html_attr("src")

  md_img <- sprintf("![%s](%s)", txt_ttl, url_img)
  md_src <- sprintf("[%s](%s)", txt_src, url_src)

  md <- paste(md_img, md_src, collapse = "\n")

  asis_output(md)

}
