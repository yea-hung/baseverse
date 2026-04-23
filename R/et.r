#' Tables variables
#'
#' Creates a table for a variable, mimicking `count()` (from 'dplyr'). ET stands for exploratory table.
#' @param data_frame the data.frame
#' @param variable_name the variable name
#'
#' @returns a data frame
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
#' 
#' # examine variable, with native piping
#' nhanes |> et(country)
#' 
#' # examine variable, with dollar-sign notation
#' et(nhanes$country)
et<-function(data_frame,variable_name){

  # define the table
  if(is.data.frame(data_frame)){
    variable_string<-deparse(substitute(variable_name))
    tt<-table(data_frame[,variable_string],useNA='always')
  } else {
    tt<-table(data_frame,useNA='always')
    variable_string<-gsub('^.+\\$','',deparse(substitute(data_frame)))
  }

  # put table in a data frame
  tt<-data.frame(value=names(tt),n=as.numeric(tt))

  # rename first column
  names(tt)[1]<-variable_string

  # output table
  tt

}
