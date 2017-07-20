#' Blog setup
#' @importFrom knitr opts_chunk
#' @param message = FALSE,
#' @param warning = FALSE,
#' @param fig.showtext = TRUE,
#' @param dev = "CairoPNG",
#' @param fig.width = 16,
#' @param fig.height = 9,
#' @param dpi = 72
#' @export
blog_set_chunk <- function(
  message = FALSE,
  warning = FALSE,
  fig.showtext = TRUE,
  dev = "CairoPNG",
  fig.width = 11,
  fig.height = 7,
  dpi = 72) {

  opts_chunk$set(
    message = message,
    warning = warning,
    fig.showtext = fig.showtext,
    dev = dev,
    fig.width = fig.width,
    fig.height = fig.height,
    dpi = dpi
  )

  theme_set(theme_jbk())
  # if (is.null(knitr::opts_knit$get("rmarkdown.pandoc.to"))) {
  #
  # } else {
  #   theme_set(theme_jbk(base_size = base_size_html))
  # }

  invisible()
}

#' Spin to md jekyll post
#'
#' @param r_script r_script
#'
#' @importFrom knitr opts_chunk opts_knit asis_output knit2html spin
#' @export
spin_jekyll_post <- function(r_script){
  `<<-` <- NULL
  knit_print.htmlwidget <- NULL
  #### pars ####
  t0 <- Sys.time()
  folder_name <- gsub("^\\d{4}-\\d{2}-\\d{2}-|\\.R$", "", basename(r_script))
  image_folder <- sprintf("images/%s/", folder_name)

  #### options ####
  options(digits = 3, knitr.table.format = "markdown",
          encoding = "UTF-8", stringsAsFactors = FALSE)

  opts_chunk$set(fig.path = image_folder,
                 fig.align = "center",
                 screenshot.force = FALSE,
                 warning = FALSE,
                 message = FALSE)

  opts_knit$set(root.dir  = normalizePath("."))

  knit_print.htmlwidget <<- function(x, ..., options = NULL){

    options(pandoc.stack.size = "2048m")

    wdgtclass <- setdiff(class(x), "htmlwidget")[1]
    wdgtrndnm <- paste0(sample(letters, size = 7), collapse = "")
    wdgtfname <- sprintf("htmlwidgets/%s/%s_%s.html", folder_name, wdgtclass, wdgtrndnm)

    suppressWarnings(try(dir.create(sprintf(sprintf("htmlwidgets/%s", folder_name)))))

    try(htmlwidgets::saveWidget(x, file = "wdgettemp.html", selfcontained = TRUE))

    file.copy("wdgettemp.html", wdgtfname, overwrite = TRUE)
    file.remove("wdgettemp.html")

    iframetxt <- sprintf("<iframe src=\"/%s\"></iframe>", wdgtfname)

    linktxt <- sprintf("<a href=\"/%s\" target=\"_blank\">open</a>", wdgtfname)

    out <- paste(iframetxt, linktxt, collapse = "\n")

    return(asis_output(out))

  }


  #### removing widgets if exists ####
  if ( length(dir(sprintf("htmlwidgets/%s", folder_name), full.names = TRUE)) > 0) {
    fs <- dir(sprintf("htmlwidgets/%s", folder_name), full.names = TRUE)
    lapply(fs, file.remove)
  }

  #### knitting ####
  message(sprintf("knitting %s", basename(r_script)))

  #spin(r_script, envir = new.env())
  knit2html(spin(r_script, knit = FALSE), force_v1 = TRUE, envir = new.env())

  r_md <- sub(".R$", ".md", basename(r_script))
  r_rmd <- sub(".R$", ".Rmd", basename(r_script))
  r_html <- sub(".R$", ".html", basename(r_script))

  #### changing images' url ####
  message("changing url path of images")
  r_md_txt <- readLines(r_md)
  r_md_txt <- gsub("<img src=\"images/", "<img src=\"/images/", r_md_txt)

  #### moving files ####
  message("moving md file to _posts/ folder")
  writeLines(r_md_txt, sprintf("_posts/%s", r_md))

  ##### removing temp files ####
  message("removing temporal files")
  file.remove(r_md)
  file.remove(r_html)
  file.remove(file.path("_rposts", r_rmd))

  if (file.exists(sprintf("_rposts/%s", r_html))) {
    file.remove(sprintf("_rposts/%s", r_html))
  }

  #### finished ####
  message(sprintf("ready: %s", sprintf("_posts/%s", r_md)))
  diff <- Sys.time() - t0
  message(sprintf("time to spin: %s %s", round(diff, 2), attr(diff, "units")))
  invisible()

}

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

#' Creating FA ico given name and color
#'
#' @param x Name of icon
#' @param color A color
#' @importFrom htmltools tags
#' @importFrom shiny icon
#' @export
ico <- function(x = "tv", color = NULL) {
  # color <- "red"
  as.character(tags$span(icon(x), style = sprintf("color:%s", color)))
}

#' Creating a R blue letter
#'
#' @export
R <- function() {
  as.character(tags$span("R", style = "color:#2066B9;font-weight:500"))
}

#' Save widget for presentations which share same folder
#'
#' @param w Widget.
#' @param f File name.
#' @importFrom htmlwidgets saveWidget
#' @export
sw <- function(w, f) {
  saveWidget(widget = w, file = f, libdir = "index_files/", selfcontained = FALSE, background = "transparent")
}
