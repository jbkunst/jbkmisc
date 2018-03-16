#' Tic Toe Wrappers
#' @param msg msg
#' @param quiet quiet
#' @param func.tic func.tic
#' @param func.toc func.toc
#' @param log log
#' @param tic tic
#' @param toc toc
#' @param info info
#' @examples
#'
#' jbk_tictoc_clear()
#'
#' jbk_tic(msg = "Go to sleep")
#'
#' Sys.sleep(2)
#'
#' jbk_toc()
#'
#' jbk_tic(msg = "Go to sleep again!")
#'
#' Sys.sleep(1)
#'
#' jbk_toc()
#'
#' jbk_tictoc_log()
#'
#' @importFrom tictoc tic toc tic.clear tic.log
#' @importFrom purrr map reduce
#' @importFrom dplyr as_data_frame bind_rows
#' @export
jbk_tic <- function(msg = NULL, quiet = FALSE, func.tic = jbk_tic_msg) {
  tictoc::tic(msg = msg, quiet = quiet, func.tic = func.tic)
}

#' @rdname jbk_tic
#' @export
jbk_toc <- function(log = TRUE, func.toc = jbk_toc_msg) {
  tictoc::toc(log = TRUE, func.toc = jbk_toc_msg)
}

#' @rdname jbk_tic
#' @export
jbk_tictoc_clear <- function() {
  tictoc::tic.clear()
}

#' @rdname jbk_tic
#' @export
jbk_tic_msg <- function(tic, msg = NULL) {
  outmsg <- paste("\n", msg, " - starting at: ", format(Sys.time(), "%X"), sep = "")
  outmsg
}

#' @rdname jbk_tic
#' @export
jbk_toc_msg <- function(tic, toc, msg, info) {

  t <- fmt_sec(round(toc - tic, 3))
  outmsg <- paste(msg, " - finished in: ", t,  sep = "")
  outmsg

}

fmt_sec <- function(delta){
  s_lt_60 <- delta < 60
  num <- ifelse(s_lt_60, delta, delta/60)
  num <- round(num, 2)
  txt <- ifelse(s_lt_60, "seconds", "minutes")
  sprintf("%s %s", num, txt)
}

#' @rdname jbk_tic
#' @export
jbk_tictoc_log <- function() {
  tictoc::tic.log(format = FALSE) %>%
    map(as_data_frame) %>%
    reduce(bind_rows) %>%
    # mutate(time_minutes = (toc - tic) / 60)
    mutate_("time_minutes" = "(toc - tic) / 60")
}
