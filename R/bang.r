#' Flips a logical object.
#' 
#' A wrapper function to `!`.
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
#' # get correlation coefficient for systolic and diastolic
#' nhanes$smq020 |> is.na() |> bang()
bang<-function(x){ !x }