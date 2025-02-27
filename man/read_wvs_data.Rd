% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_wvs_data.R
\name{read_wvs_data}
\alias{read_wvs_data}
\title{Read WVS Dataset}
\usage{
read_wvs_data(file_path)
}
\arguments{
\item{file_path}{A string indicating the path to the WVS .dta file.}
}
\value{
A data frame containing the WVS data.
}
\description{
This function reads a World Values Survey (WVS) dataset from a .dta file.
}
\examples{
wvs_data <- read_wvs_data("path/to/wvs.dta")
}
