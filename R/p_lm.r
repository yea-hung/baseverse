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
#' data(nhanes)
#'
#' # define country
#' nhanes<-nhanes |> transform(
#'   country=base_match(dmdborn4,'USA'=1,'Other'=2)
#' )
#'
#' # fit a model
#' mymodel<-nhanes |> p_lm(bpxosy1~country)
#' 
#' # obtain model details
#' mymodel |> summary()
#' 
#' # obtain confidence interval
#' mymodel |> confint()
p_lm<-function(data,formula,...) {
  stats::lm(formula=formula,data=data,...)
}
