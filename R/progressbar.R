#' TXTProgressBar Class
#'
#' A new progresss bar with text messages
#'
#' set.seed(123)
#' x <- sample(fruit, 6)
#' mpb <- TXTProgressBar$new(x)
#' for(y in x){
#'
#' Sys.sleep(0.5)
#' mpb$update(y)
#' }
#'
#' @export
TXTProgressBar <- R6::R6Class(
  "TXTProgressBar",
  public = list(
    actual = NULL,
    x = NULL,
    steps = NULL,
    maxwidth = NULL,
    pb = NULL,
    initialize = function(x = sample(fruit, 6), verbose = TRUE) {
      self$actual <- 1
      self$x <- x
      self$steps <- length(x)
      self$maxwidth <- max(nchar(x))
      self$pb <- txtProgressBar(1, self$steps, width = getOption("width") - 15 - self$maxwidth, style = 3)
    },
    update = function(m = NULL) { # m <- sample(self$x, 1)
      stopifnot(self$actual <= self$steps)
      stopifnot(m %in% self$x)

      if(!is.null(m)){
        cat(str_pad(m, self$maxwidth + 1, pad = " ", side = "left"))
      }

      setTxtProgressBar(self$pb, value = self$actual)

      self$actual <- self$actual + 1
    }
  )
)


