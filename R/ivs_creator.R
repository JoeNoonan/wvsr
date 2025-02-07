#' Create Integrated Values Study Dataset
#'
#' This function reads and processes World Values Survey (WVS) and European Values Study (EVS) data,
#' harmonizing common variables and merging unique ones.
#'
#' @param wvs_path Path to the WVS .dta file.
#' @param evs_path Path to the EVS .dta file.
#'
#' @return A merged tibble containing harmonized data from WVS and EVS.
#' @importFrom haven read_dta
#' @importFrom dplyr mutate rename select all_of intersect setdiff bind_rows left_join
#' @export
#' Create Integrated Values Study Dataset
#'
#' This function reads and processes World Values Survey (WVS) and European Values Study (EVS) data,
#' harmonizing common variables and merging unique ones.
#'
#' @param wvs_path Path to the WVS .dta file.
#' @param evs_path Path to the EVS .dta file.
#'
#' @return A merged tibble containing harmonized data from WVS and EVS.
#' @importFrom haven read_dta
#' @importFrom dplyr mutate rename select all_of intersect setdiff bind_rows left_join
#' @export
ivs_creator <- function(wvs_path, evs_path) {

  start_time <- Sys.time()
  message("Starting IVS creation at: ", start_time)

  # Read in EVS
  message("Reading EVS dataset...")
  evs_data <- haven::read_dta(evs_path)
  message("Finished reading EVS at: ", Sys.time(), " (Elapsed: ", round(difftime(Sys.time(), start_time, units = "secs")), " secs)")

  # Prep EVS
  message("Processing EVS dataset...")
  evs_data <- evs_data %>%
    dplyr::mutate(
      doi = as.character(doi),
      S016a = as.character(S016a)
    ) %>%
    dplyr::rename(S002vs = s002vs,
                  X026_01 = x026_01)
  message("Finished processing EVS at: ", Sys.time())

  # Read in WVS
  message("Reading WVS dataset...")
  wvs_data <- haven::read_dta(wvs_path)
  message("Finished reading WVS at: ", Sys.time())

  # Identify shared and unique variables
  message("Identifying variable intersections...")
  common_vars <- intersect(names(wvs_data), names(evs_data))
  wvs_only_vars <- setdiff(names(wvs_data), names(evs_data))
  evs_only_vars <- setdiff(names(evs_data), names(wvs_data))
  message("Variable identification completed.")

  # Select shared variables
  message("Selecting shared variables...")
  shared_data_wvs <- wvs_data %>% dplyr::select(dplyr::all_of(common_vars))
  shared_data_evs <- evs_data %>% dplyr::select(dplyr::all_of(common_vars))

  # Select unique vars along with identifier
  message("Selecting unique WVS variables...")
  unique_data_wvs <- wvs_data %>% dplyr::select(S007, dplyr::all_of(wvs_only_vars))

  message("Selecting unique EVS variables...")
  unique_data_evs <- evs_data %>% dplyr::select(S007, dplyr::all_of(evs_only_vars))

  # Merge the data
  message("Merging datasets...")
  merged_data <- dplyr::bind_rows(shared_data_wvs, shared_data_evs) %>%
    dplyr::left_join(unique_data_wvs, by = "S007") %>%
    dplyr::left_join(unique_data_evs, by = "S007")

  end_time <- Sys.time()
  message("IVS creation completed at: ", end_time, " (Total elapsed time: ", round(difftime(end_time, start_time, units = "secs")), " secs)")

  return(merged_data)
}

