#' Check Coverage of Two Variables in WVS Dataset
#'
#' This function checks whether two specified variables are available in the same
#' country-year combination within the World Values Survey (WVS) dataset.
#'
#' @param coverage_data_long A tibble containing WVS coverage data with columns:
#' `COUNTRY_ALPHA`, `S002VS`, `variable_name`, and `coverage_n`.
#' @param var1 The first variable name as a string.
#' @param var2 The second variable name as a string.
#' @return A tibble with columns: `country`, `year`, `var1`, `var2`, and `both_present` (1 = available, 0 = missing).
#' @importFrom dplyr filter select mutate rename
#' @importFrom tidyr pivot_wider
#' @examples
#' # Example usage with a dataset named `coverage_data_long`
#' check_variable_coverage(coverage_data_long, "A001", "A002")
#' @export
check_variable_coverage <- function(coverage_data_long, var1, var2) {
  # Ensure input is a data frame
  if (!is.data.frame(coverage_data_long)) {
    stop("Error: coverage_data_long must be a data frame.")
  }

  # Filter the dataset for the selected variables
  filtered_data <- coverage_data_long %>%
    dplyr::filter(variable_name %in% c(var1, var2)) %>%
    dplyr::select(COUNTRY_ALPHA, S002VS, variable_name, coverage_n) %>%
    tidyr::pivot_wider(names_from = variable_name, values_from = coverage_n, values_fill = 0) %>%
    dplyr::mutate(
      both_present = ifelse(.data[[var1]] > 0 & .data[[var2]] > 0, 1, 0)
    ) %>%
    dplyr::rename(country = COUNTRY_ALPHA, year = S002VS)

  return(filtered_data)
}
