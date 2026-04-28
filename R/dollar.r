#' Selects a portion of a data object using dollar-sign selection
#'
#' A wrapper function for dollar-sign notation.
#' @param data_object the data object
#' @param variable_name the variable name or element name
#'
#' @returns a portion of the data object
#' @export
#'
#' @examples
#' # load data
#' data(nhanes)
#' 
#' # summarize lbxtc
#' nhanes |> dollar(lbxtc) |> summary()
dollar<-function(data_object,variable_name){

  variable_string<-deparse(substitute(variable_name))
  if(is.null(dim(data_object))){
    data_object |> (\(x) x[[variable_string]])()
  } else {
    if(length(dim(data_object))==1){
      data_object |> (\(x) x[variable_string])()  
    }
    if(length(dim(data_object))==2){
      data_object |> (\(x) x[,variable_string])()  
    }
  }

}
