#' Generate structure
#'
#' @param dir Directory
#' @export
create_skeleton_folders <- function(dir = ".") {

  dir.create(file.path(dir, "code"))
  dir.create(file.path(dir, "data"))
  dir.create(file.path(dir, "output"))

}
