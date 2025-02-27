% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract_labels.R
\name{extract_labels}
\alias{extract_labels}
\title{Extract Variable Labels}
\usage{
extract_labels(data)
}
\arguments{
\item{file_path}{A string indicating the path to the WVS .dta file.}
}
\value{
A tibble with two columns: `variable_name` (variable identifier) and `question_label` (description).
}
\description{
This function reads a World Values Survey (WVS) dataset in .dta format and extracts
variable names along with their associated question labels.
}
