#' Uses the logical not
#' 
#' A wrapper function for `!`.
#'
#' @param x a logical object
#'
#' @returns a logical object
#' @export
#'
#' @examples
#' # load the data
#' data(nhanes)
#' 
#' # check whether values of smq020 are not missing
#' nhanes$smq020 |> is.na() |> bang()
#' 
#' # check whether values of smq020 are not missing
#' nhanes |> dollar(smq020) |> is.na() |> bang()
bang<-function(x){ !x }