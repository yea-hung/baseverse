#' Fits linear models, with support for piping
#' 
#' A wrapper function to `lm()`, with the `data` argument listed first to support native piping.
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
#' # fit a model
#' mtcars |> plm(drat~wt+qsec) |> summary()
p_lm<-function(data,formula,...) {
  stats::lm(formula=formula,data=data,...)
}
