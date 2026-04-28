#' Subsets a data using bracket notation
#' 
#' A wrapper function for bracket notation. The function only allows one index; for two-dimensional objects, the index is used on the columns.
#'
#' @param data_object a data object
#' @param index a character, logical, or numeric vector
#'
#' @returns a subset of the data
#' @export
#'
#' @examples
#' # load package
#' data(nhanes)
#' 
#' # look at the first few values of dmdborn4
#' nhanes |> bracket('dmdborn4') |> head()
bracket<-function(data_object,index){
  
  if(length(dim(data_object))==1){
    data_object[index]
  }
  if(length(dim(data_object))==2){
    data_object[,index]
  }
  
}