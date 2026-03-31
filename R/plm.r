#' `plm.r()`
#' 
#' A wrapper function to `lm()`, with the `data` argument listed first to enable piping.
#'
#' @param data the data
#' @param formula the formula
#' @param ... additional arguments passed to [stats::lm()].
#'
#' @returns an `lm` object
#' @export
#'
#' @examples
#' # load the data
#' data(mtcars)
#' 
#' # fit a mod
#' mtcars |> plm(drat~wt+qsec) |> summary()
plm<-function(data,formula,...) {
  stats::lm(formula=formula,data=data,...)
}
