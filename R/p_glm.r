#' Fits generalized linear models, with support for piping
#' 
#' A wrapper function to `glm()`, with the `data` argument listed first to support piping.
#'
#' @param data the data
#' @param formula the formula
#' @param ... additional arguments passed to [stats::glm()].
#'
#' @returns a `glm` object
#' @export
#'
#' @examples
#' # load the data
#' data(mtcars)
#' 
#' # fit a model
#' mtcars |> pglm(am~wt+qsec) |> summary()
p_glm<-function(data,formula,...) {
  stats::glm(formula=formula,data=data,...)
}
