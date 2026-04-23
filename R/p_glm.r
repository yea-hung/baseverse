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
#' data(nhanes)
#'
#' # define asthma
#' nhanes<-nhanes |> transform(
#'   asthma=base_match(mcq010,'No'=2,'History of asthma'=1)
#' )
#'
#' # define smoking
#' nhanes<-nhanes |> transform(
#'   smoking=base_match(smq020,'No'=2,'History of smoking'=1)
#' )
#' 
#' # fit a model
#' mymodel<-nhanes |> p_glm(asthma~smoking,family=binomial(link='logit'))
#' 
#' # obtain model details
#' mymodel |> summary()
#' 
#' # obtain confidence interval
#' mymodel |> confint() |> exp()
p_glm<-function(data,formula,...) {
  stats::glm(formula=formula,data=data,...)
}
