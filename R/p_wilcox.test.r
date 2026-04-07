#' Conducts Wilcoxon rank-sum tests, with support for piping
#' 
#' A wrapper function to `wilcox.test()`, with the `data` argument listed first to support piping.
#'
#' @param data the data
#' @param x one of two variables
#' @param y one of two variables
#' @param formula a formula
#' @param ... additional arguments passed to [stats::wilcox.test()].
#'
#' @returns an `htest` object
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
#' # conduct a one-sample wilcoxon test
#' nhanes |> p_wilcox.test(bpxosy1)
#' 
#' # conduct a two-sample wilcoxon test, using formula notation
#' nhanes |> p_wilcox.test(bpxosy1~smoking)
#' 
#' # conduct a two-sample wilcoxon test, using formula notation
#' nhanes |> p_wilcox.test(formula=bpxosy1~smoking)
#'
#' # conduct a paired wilcoxon test, using x and y
#' nhanes |> p_wilcox.test(bpxosy1,bpxosy2,paired=TRUE)
p_wilcox.test<-function(data,x=NULL,y=NULL,formula=NULL,...) {
  x_string<-deparse(substitute(x))
  y_string<-deparse(substitute(y))
  formula_string<-deparse(substitute(formula))
  if(grepl('~',x_string)&(y_string=='NULL')&(formula_string=='NULL')){
    wilcox_test<-stats::wilcox.test(formula=x,data=data,...)
  } 
  if(!grepl('~',x_string)&(y_string=='NULL')&(formula_string=='NULL')){
    wilcox_test<-stats::wilcox.test(data[,x_string],...)
    wilcox_test$data.name<-x_string
  }
  if(!grepl('~',x_string)&(y_string!='NULL')&(formula_string=='NULL')){
    wilcox_test<-stats::wilcox.test(data[,x_string],data[,y_string],...)
    wilcox_test$data.name<-paste(x_string,'and',y_string)
  }
  if(formula_string!='NULL'){
    wilcox_test<-stats::wilcox.test(formula=formula,data=data,...)
  }
  wilcox_test
}