## code to prepare `prepare_values` dataset goes here



#### EVS
evs_data <- read_dta("C:/R_projects/wvsr_data/data-raw/ZA7503_v3-0-0.dta")  # Load the EVS dataset

# Adjust type and rename
evs_data <- evs_data %>%
  dplyr::mutate(
    doi = as.character(doi),
    S016a = as.character(S016a)
  ) %>%
  dplyr::rename(S002vs = s002vs,
                X026_01 = x026_01)

### Get EVS values
evs_values <- extract_values(evs_data) %>%
  rename(evs_question_label = question_label,  evs_value_label = value_label) %>%
  mutate(evs_value_label= trimws(evs_value_label))

### WVS
# Read in WVS
wvs_data <- haven::read_dta("C:/R_projects/wvsr_data/data-raw/WVS_Time_Series_1981-2022_stata_v5_0.dta")

# Identify shared and unique variables
common_vars <- intersect(names(wvs_data), names(evs_data))
wvs_only_vars <- setdiff(names(wvs_data), names(evs_data))
evs_only_vars <- setdiff(names(evs_data), names(wvs_data))


### Get WVS values
wvs_values <- extract_values(wvs_data) %>%
  rename(wvs_question_label = question_label,  wvs_value_label = value_label) %>%
  mutate(wvs_value_label= trimws(wvs_value_label))


### Merge IVS Values

ivs_values <- left_join(wvs_values, evs_values) %>%
  mutate(wvs_only = case_when(variable_name %in% wvs_only_vars ~ 1,
                              TRUE ~ 0),
         evs_only = case_when(variable_name %in% evs_only_vars ~ 1,
                              TRUE ~ 0),
         wvs_evs_value_conflict = case_when(wvs_value_label  != evs_value_label ~ 1,
                                            TRUE ~ 0))

# Save datasets for package use
usethis::use_data(evs_values, wvs_values, ivs_values, overwrite = TRUE)

