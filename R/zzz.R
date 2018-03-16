.onAttach <- function(libname = find.package("jbkmisc"), pkgname = "jbkmisc") {

  packageStartupMessage(
    "Setting verbose = TRUE. You can remove functions messages with `options(jbkmisc.verbose = FALSE)`"
  )

  options(jbkmisc.verbose = TRUE)
  # library(extrafont)
  # extrafont::font_import(pattern = "")
  # extrafont::fonts()
  # extrafont::loadfonts(quiet = TRUE)
}
