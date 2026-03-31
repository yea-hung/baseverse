#' `base_match()`
#'
#' A base-R approximation of *dplyr*'s `case_match()`. Unlike `case_match()`, `base_when()` returns a factor. The levels will be ordered according to the order included in `codebook`.
#' @param original_variable the original variable
#' @param ... the codebook, specified as a named vector, with each element in `'label'=level` format, with the levels listed in the desired order
#' @param as_factor logical, controlling whether the function should return a factor
#' @param string_for_na string value that will be converted to NA
#'
#' @returns a factor
#' @export
#'
#' @examples
#' # load data
#' data(nhanes)
#' 
#' # define country
#' nhanes<-nhanes |> transform(
#'   country=base_match(nhanes$dmdborn4,'USA'=1,'Other'=2)
#' )
base_match<-function(original_variable,...,as_factor=TRUE,string_for_na=''){

  # define the codebook
  codebook<-list(...)
  codebook<-unlist(codebook)

  # define the new variable
  new_variable<-factor(original_variable,codebook,names(codebook))
  
  # convert the variable to a character object (not default behavior)
  if(!as_factor){
    new_variable<-as.character(new_variable)
    new_variable[is.na(new_variable)]<-string_for_na
  }

  # return the object
  new_variable

}
