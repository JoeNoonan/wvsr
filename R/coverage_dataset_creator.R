#' Create Coverage Dataset from WVS Data
#'
#' This function processes a World Values Survey (WVS) dataset to generate a coverage dataset
#' that indicates the presence of survey questions by country and year.
#'
#' @param wvs_data A data frame containing the WVS data loaded using `read_wvs_data()`.
#' @return A tibble with columns: `COUNTRY_ALPHA`, `S002VS`, `survey_year_n`, `variable_name`,
#' `coverage_n`, `percentage_coverage`, and `question_label`.
#' @importFrom haven zap_labels
#' @importFrom dplyr mutate across group_by summarise select arrange left_join all_of
#' @importFrom tidyr pivot_longer
#' @importFrom magrittr %>%
#' @examples
#' # Load WVS dataset
#' wvs_data <- read_wvs_data("path/to/wvs.dta")
#'
#' # Generate coverage dataset
#' coverage_data <- coverage_dataset_creator(wvs_data)
#'
#' # View first rows of the coverage dataset
#' head(coverage_data)
#' @export
coverage_dataset_creator <- function(wvs_data) {
  # Remove labels from all variables to prevent errors
  wvs_data_int <- haven::zap_labels(wvs_data)

  # Select key identifying columns
  key_columns <- c("COUNTRY_ALPHA", "S002VS")

  # Identify question columns (excluding key columns)
  question_columns <- setdiff(names(wvs_data_int), key_columns)

  # Convert values to binary indicators (1 = present, 0 = missing)
  # This is at the survey response level.
  coverage_data_long <- wvs_data_int %>%
    dplyr::mutate(
      dplyr::across(
        all_of(question_columns),
        ~ ifelse(. >= 0, 1, 0)
      )
    ) %>%
    dplyr::group_by(COUNTRY_ALPHA, S002VS) %>%
    dplyr::summarise(dplyr::across(all_of(question_columns), ~ sum(., na.rm = TRUE), .names = "{.col}"), .groups = "drop") %>%

    # Getting total counts based on the 'version' column
    dplyr::mutate(survey_year_n = version) %>%

    # Reshape the data to long format to check coverage
    dplyr::select(all_of(c(key_columns, "survey_year_n", question_columns))) %>%
    tidyr::pivot_longer(cols = all_of(question_columns),
                        names_to = "variable_name",
                        values_to = "coverage_n") %>%
    dplyr::arrange(COUNTRY_ALPHA, S002VS, variable_name) %>%
    dplyr::mutate(percentage_coverage = coverage_n / survey_year_n) %>%
    dplyr::left_join(variable_labels, by = "variable_name")

  return(coverage_data_long)
}

