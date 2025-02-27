% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coverage_two_variables.R
\name{check_variable_coverage}
\alias{check_variable_coverage}
\title{Check Coverage of Two Variables in WVS Dataset}
\usage{
check_variable_coverage(coverage_data_long, var1, var2)
}
\arguments{
\item{coverage_data_long}{A tibble containing WVS coverage data with columns:
`COUNTRY_ALPHA`, `S002VS`, `variable_name`, and `coverage_n`.}

\item{var1}{The first variable name as a string.}

\item{var2}{The second variable name as a string.}
}
\value{
A tibble with columns: `country`, `year`, `var1`, `var2`, and `both_present` (1 = available, 0 = missing).
}
\description{
This function checks whether two specified variables are available in the same
country-year combination within the World Values Survey (WVS) dataset.
}
\examples{
# Example usage with a dataset named `coverage_data_long`
check_variable_coverage(coverage_data_long, "A001", "A002")
}
