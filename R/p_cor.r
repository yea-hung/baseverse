#' Finds correlation coefficients, with support for piping
#' 
#' A wrapper function to `cor()`, with support for piping.
#'
#' @param data the data
#' @param x one of the two variables
#' @param y one of the two variables
#' @param ... additional arguments passed to [stats::cor()].
#'
#' @returns a numeric object
#' @export
#'
#' @examples
#' # load the data
#' data(nhanes)
#' 
#' # get correlation coefficient for systolic and diastolic
#' nhanes |> p_cor(bpxosy1,bpxodi1,use='complete.obs')
p_cor<-function(data,x,y,...){
  x_string<-deparse(substitute(x))
  y_string<-deparse(substitute(y))
  stats::cor(data[,x_string],data[,y_string],...)
}