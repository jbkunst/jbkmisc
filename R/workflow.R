#' Generate structure
#'
#' @param dir Directory
#' @export
wf_create_folders <- function(dir = ".") {

  dir.create(file.path(dir, "code"))
  dir.create(file.path(dir, "data"))
  dir.create(file.path(dir, "output"))

}
