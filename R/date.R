#' Year month string to date
#' @param ym ym
#' @param day day
#' @importFrom lubridate ymd
#' @importFrom stringr str_pad
#' @export
ym_to_date <- function(ym = c(200902, 201912), day = 1){
  ymd(paste0(ym, str_pad(day, 2, pad = "0")))
}

#' Year month string to date
#' http://stackoverflow.com/questions/1995933/number-of-months-between-two-dates/26640698#26640698
#' @param ym ym
#' @param ym2 ym2
#' @importFrom lubridate year month
#' @export
ym_diff <- function(ym = c(200902, 201912), ym2 = c(200901, 201712)) {

  ed <- ym_to_date(ym)
  sd <- ym_to_date(ym2)

  12 * (year(ed) - year(sd)) + (month(ed) - month(sd))

}

