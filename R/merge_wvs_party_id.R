#' Merge WVS Party ID Data
#'
#' This function merges World Values Survey (WVS) vote choices with party IDs. It appends three variables to the dataset. first_vote_partyfacts_id, second_vote_partyfacts_id, never_vote_partyfacts_id
#'
#' @param wvs A dataframe containing WVS data with columns `E179WVS`, `E180WVS`, `E182`.
#' @return A dataframe with merged party facts IDs.
#' @examples
#' wvs_test <- data.frame(E179WVS = c(101, 102), E180WVS = c(103, 104), E182 = c(105, 106))
#' merged_data <- merge_wvs_party_id(wvs_test)
#' head(merged_data)
#' @export
#'
merge_wvs_party_id <- function(wvs) {
  # Ensure the dataset is available in the package
  if (!exists("wvs_partyfacts_id")) {
    stop("Dataset 'wvs_partyfacts_id' not found. Make sure it is included in the package data.")
  }

  # Create transformations for first, second, and never vote choices
  wvs_party_id_data_first <- wvs_partyfacts_id %>%
    dplyr::transmute(
      E179WVS = dataset_party_id,
      first_vote_partyfacts_id = partyfacts_id
    )

  wvs_party_id_data_second <- wvs_partyfacts_id %>%
    dplyr::transmute(
      E180WVS = dataset_party_id,
      second_vote_partyfacts_id = partyfacts_id
    )

  wvs_party_id_data_never <- wvs_partyfacts_id %>%
    dplyr::transmute(
      E182 = dataset_party_id,
      never_vote_partyfacts_id = partyfacts_id
    )

  # Merge datasets to wvs_test
  wvs <- wvs %>%
    dplyr::left_join(wvs_party_id_data_first, by = "E179WVS", na_matches = "never") %>%
    dplyr::left_join(wvs_party_id_data_second, by = "E180WVS", na_matches = "never") %>%
    dplyr::left_join(wvs_party_id_data_never, by = "E182", na_matches = "never")

  return(wvs)
}
