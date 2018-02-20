#' Generate structure
#'
#' @param dir Directory
#' @param folders Folders to create in the dir directory
#' @export
wf_create_folders <- function(dir = ".", folders = c("R", "data", "outputs")) {

  lapply(folders, function(x) file.path(dir, x))

}
