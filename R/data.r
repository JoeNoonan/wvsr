#' EVS Values
#'
#' This dataset contains extracted values from the European Values Study (EVS).
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{variable_name}{The variable name from EVS}
#'   \item{evs_question_label}{Question text from EVS}
#'   \item{evs_value_label}{Label for the value in EVS}
#' }
#' @usage data(evs_values)
#' @examples
#' data(evs_values)
#' head(evs_values)
"evs_values"

#' WVS Values
#'
#' Extracted values from the World Values Survey (WVS).
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{variable_name}{The variable name from WVS}
#'   \item{wvs_question_label}{Question text from WVS}
#'   \item{wvs_value_label}{Label for the value in WVS}
#' }
#' @usage data(wvs_values)
#' @examples
#' data(wvs_values)
#' head(wvs_values)
"wvs_values"

#' IVS Values Comparison
#'
#' Merged dataset comparing WVS and EVS values.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{variable_name}{The variable name}
#'   \item{wvs_question_label}{Question text from WVS}
#'   \item{evs_question_label}{Question text from EVS}
#'   \item{wvs_value_label}{Label for the value in WVS}
#'   \item{evs_value_label}{Label for the value in EVS}
#'   \item{wvs_only}{1 if only in WVS, else 0}
#'   \item{evs_only}{1 if only in EVS, else 0}
#'   \item{wvs_evs_value_conflict}{1 if WVS & EVS values conflict, else 0}
#' }
#' @usage data(ivs_values)
#' @examples
#' data(ivs_values)
#' head(ivs_values)
"ivs_values"
