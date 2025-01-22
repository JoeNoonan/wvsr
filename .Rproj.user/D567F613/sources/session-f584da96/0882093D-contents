# Intro

This is a small R package designed to help make working with the World Values Survey (WVS) a bit easier in R.

The main purpose currently is to easily organize metadata about the dataset, namely question variable names, value labels, and information about coverage. 

Having these dataframes can avoid some of the idiosyncratic issues that arise from using labled dataframes.

## Installation

You can install the package directly from GitHub using the `remotes` package:

```r
# Install remotes if not already installed
install.packages("remotes")

# Install the wvsr package from GitHub
remotes::install_github("JoeNoonan/wvsr")
```

## Examples

Below shows examples of the total functionality of the package so far. Note that the resulting tables produced below are filtered for clarity. 

```
### Reading the dataset, read_wvs_data() is just a wrapper for read_dta().
wvs_data <- read_wvs_data("data-raw/WVS_Time_Series_1981-2022_stata_v5_0.dta")

# Extract variable labels
variable_labels <- extract_wvs_labels(wvs_data)

# A tibble: 11 × 2
   variable_name question_label                                                   
   <chr>         <chr>                                                            
 1 A027          Important child qualities: Good manners                          
 2 A029          Important child qualities: independence                          
 3 A030          Important child qualities: Hard work                             
 4 A032          Important child qualities: feeling of responsibility             
 5 A034          Important child qualities: imagination                           
 6 A035          Important child qualities: tolerance and respect for other people
 7 A038          Important child qualities: thrift saving money and things        
 8 A039          Important child qualities: determination perseverance            
 9 A040          Important child qualities: religious faith                       
10 A041          Important child qualities: unselfishness                         
11 A042          Important child qualities: obedience 


# Extract value labels
value_labels <- extract_wvs_values(wvs_data)

# A tibble: 6 × 4
  variable_name question_label                          question_value value_label  
  <chr>         <chr>                                            <dbl> <chr>        
1 A027          Important child qualities: Good manners             -5 Missing      
2 A027          Important child qualities: Good manners             -4 Not asked    
3 A027          Important child qualities: Good manners             -2 No answer    
4 A027          Important child qualities: Good manners             -1 Don't know   
5 A027          Important child qualities: Good manners              0 Not mentioned
6 A027          Important child qualities: Good manners              1 Important  

# Make coverage dataset of coverage
coverage_data_long <- coverage_dataset_creator(wvs_data)

# A tibble: 5 × 7
  COUNTRY_ALPHA S002VS survey_year_n variable_name coverage_n percentage_coverage question_label                         
  <chr>          <dbl>         <dbl> <chr>              <dbl>               <dbl> <chr>                                  
1 USA                3          1542 A027                1542               1     Important child qualities: Good manners
2 USA                4          1200 A027                   0               0     Important child qualities: Good manners
3 USA                5          1249 A027                   0               0     Important child qualities: Good manners
4 USA                6          2232 A027                   0               0     Important child qualities: Good manners
5 USA                7          2596 A027                2592               0.998 Important child qualities: Good manners

# Make coverage crosstabs
check_variable_coverage(coverage_data_long, "A027", "A124_06") 

# A tibble: 5 × 5
  country  year  A027 A124_06 both_present
  <chr>   <dbl> <dbl>   <dbl>        <dbl>
1 USA         3  1542    1542            1
2 USA         4     0    1200            0
3 USA         5     0    1240            0
4 USA         6     0    2232            0
5 USA         7  2592    2435            1

```
