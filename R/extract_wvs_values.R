#' Extract Value Labels from WVS Variables
#'
#' This function extracts variable names, question labels, and value labels from a World Values Survey (WVS) dataset.
#'
#' @param file_path A string indicating the path to the WVS .dta file.
#' @return A tibble with columns: `variable_name`, `question_label`, and `question_value` (value labels).
#' @importFrom tibble tibble as_tibble
#' @importFrom dplyr left_join
#' @importFrom purrr map_df
#' @importFrom haven read_dta
#' @examples
#' @export
extract_wvs_values <- function(wvs_data) {

  variables_info <- purrr::map_df(
    names(wvs_data),
    ~ tibble::tibble(
      variable_name = .x,
      question_label = attr(wvs_data[[.x]], "label")
    )
  )

  value_info <-  purrr::map_df(
    names(wvs_data),
    ~ tibble::tibble(
      variable_name = .x,
      question_value = attr(wvs_data[[.x]], "labels"),
      value_label = names(attr(wvs_data[[.x]], "labels"))
    ))

  value_info <- dplyr::left_join(variables_info, value_info)

  return(value_info)
}
