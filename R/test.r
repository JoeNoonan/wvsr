
# Load the dataset
wvs_data <- read_wvs_data("data-raw/WVS_Time_Series_1981-2022_stata_v5_0.dta")

# Extract variable labels
variable_labels <- extract_wvs_labels(wvs_data)

# Extract value labels
value_labels <- extract_wvs_values(wvs_data)

# Make coverage dataset of coverage
coverage_data_long <- coverage_dataset_creator(wvs_data)

# Make coverage crosstabs
check_variable_coverage(coverage_data_long, "A027", "A124_06")
