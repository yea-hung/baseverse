#' A base-R approximation of *dplyr*'s `case_when()`
#'
#' A base-R approximation of *dplyr*'s `case_when()`. Unlike `case_when()`, `base_when()` returns a factor. The levels will be ordered according to the order included in `...`.
#' @param ... conditions for defining the replacement values, specified as a named list, with each element in `'label'=logical_vector` format, with the levels listed in the desired order
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
#' nhanes<-nhanes |>
#'   transform(
#'     cholesterol=base_when(
#'       'Desirable' = (lbxtc<200),
#'       'Borderline high' = (lbxtc>=200)&(lbxtc<240),
#'       'High' = (lbxtc>=240)
#'     )
#'   )
base_when<-function(...,as_factor=TRUE,string_for_na=''){

  # define the conditions
  conditions<-list(...)

  # define the new variable
  new_variable<-rep(string_for_na,length(conditions[[1]]))

  # define the variable's groups
  for(position in 1:length(conditions)){
    new_variable[conditions[[position]]]<-names(conditions)[position]
  }
  
  # convert the variable to a factor (default behavior)
  if(as_factor){
    new_variable<-factor(new_variable,levels=unique(names(conditions)))  
  }

  # return the object
  new_variable

}
