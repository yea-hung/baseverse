#' Uses the logical not
#' 
#' A wrapper function for `!`. This is the same thing as `bang()`.
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
#' nhanes$smq020 |> is.na() |> not()
#' 
#' # check whether values of smq020 are not missing
#' nhanes |> dollar(smq020) |> is.na() |> not()
not<-function(x){ !x }