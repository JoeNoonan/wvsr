#' Read WVS Dataset
#'
#' This function reads a World Values Survey (WVS) dataset from a .dta file.
#'
#' @param file_path A string indicating the path to the WVS .dta file.
#' @return A data frame containing the WVS data.
#' @importFrom haven read_dta
#' @examples
#' wvs_data <- read_wvs_data("path/to/wvs.dta")
#' @export
read_wvs_data <- function(file_path) {
  wvs_data <- haven::read_dta(file_path) %>%
    mutate(year = S020)
  return(wvs_data)
}
