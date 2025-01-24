#' Merge WVS Data with WhoGov Party IDs
#'
#' This function merges WVS vote choices with Partyfacts and WhoGov IDs.
#' It assumes that the `merge_wvs_party()` function has been run beforehand.
#'
#' @param wvs A dataframe containing WVS data with columns `first_vote_partyfacts_id`,
#'        `second_vote_partyfacts_id`, and `never_vote_partyfacts_id`.
#' @return A dataframe with merged WhoGov IDs.
#' @export
merge_whogov <- function(wvs) {

  # Ensure the dataset is available in the package
  if (!exists("partyfacts_whogov")) {
    stop("Dataset 'partyfacts_whogov' not found. Ensure it is loaded in the package.")
  }

  # Transformations for first, second, and never vote choices
  party_id_whogov_data_first <- partyfacts_whogov %>%
    dplyr::transmute(
      first_vote_whogov_id = whogov_id ,
      first_vote_partyfacts_id = partyfacts_id
    )

  party_id_whogov_data_second <- partyfacts_whogov %>%
    dplyr::transmute(
      second_vote_whogov_id  = whogov_id ,
      second_vote_partyfacts_id = partyfacts_id
    )

  party_id_whogov_id_data_never <- partyfacts_whogov %>%
    dplyr::transmute(
      never_vote_whogov_id  = whogov_id ,
      never_vote_partyfacts_id = partyfacts_id
    )

  # Merge datasets to wvs (assuming merge_wvs_party() has been run)
  wvs <- wvs %>%
    dplyr::left_join(party_id_whogov_data_first, by = "first_vote_partyfacts_id", na_matches = "never") %>%
    dplyr::left_join(party_id_whogov_data_second, by = "second_vote_partyfacts_id", na_matches = "never") %>%
    dplyr::left_join(party_id_whogov_id_data_never, by = "never_vote_partyfacts_id", na_matches = "never")

  return(wvs)
}
