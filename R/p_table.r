#' Tables variables, with support for piping
#' 
#' A wrapper function to `table()`, with support for piping.
#'
#' @param data the data
#' @param x one variable
#' @param y another variable
#' @param ... additional arguments passed to [table()].
#'
#' @returns a `table` object
#' @export
#'
#' @examples
#' # load the data
#' data(nhanes)
#' 
#' # define smoking
#' nhanes<-nhanes |> transform(
#'   smoking=base_match(smq020,'No'=2,'History of smoking'=1)
#' )
#' 
#' # define asthma
#' nhanes<-nhanes |> transform(
#'   asthma=base_match(mcq010,'Asthma'=1,'No'=2)
#' )
#' 
#' # table smoking
#' nhanes |> p_table(smoking)
#' 
#' # table smoking and asthma
#' nhanes |> p_table(smoking,asthma)
p_table<-function(data,x,y=NULL,...){
  x_string<-deparse(substitute(x))
  y_string<-deparse(substitute(y))
  if(y_string=='NULL'){
    table(data[,x_string],...)
  } else {
    table(data[,x_string],data[,y_string],...)
  }
}