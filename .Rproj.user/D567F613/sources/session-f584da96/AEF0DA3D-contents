#' Extract WVS Variable Labels
#'
#' This function reads a World Values Survey (WVS) dataset in .dta format and extracts
#' variable names along with their associated question labels.
#'
#' @param file_path A string indicating the path to the WVS .dta file.
#' @return A tibble with two columns: `variable_name` (variable identifier) and `question_label` (description).
#' @importFrom haven read_dta
#' @importFrom purrr map_df
#' @importFrom tibble tibble
#' @examples
#' @export
extract_wvs_labels <- function(wvs_data) {

  variables_info <- purrr::map_df(
    names(wvs_data),
    ~ tibble::tibble(
      variable_name = .x,
      question_label = attr(wvs_data[[.x]], "label")
    )
  )

  return(variables_info)
}
