
<!-- README.md is generated from README.Rmd. Please edit that file -->

# WEED (Wrangler for Emergency Events Database)

<!-- badges: start -->

<!-- badges: end -->

The goal of weed is to make the analysis of EM-DAT and related datasets
easier, with most of the pre-processing abstracted away by functions in
this package\!

## Installation

You can install the released version of weed from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("weed")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("rammkripa/weed")
```

## Example

This is a basic example which shows you how to solve a common problem:

# Loading the Data

``` r
em <- read_emdat("/Users/ramkripa/Desktop/Tk2.xlsx", file_data = TRUE)
#> New names:
#> * `` -> ...1
#> * `` -> ...2
```

# Locationizing the Data

``` r
em$disaster_data %>%
  tail() %>%
  split_locations(column_name = "Location") %>%
  select(`Dis No`, Location,location_word) %>%
  head()
#> # A tibble: 6 x 3
#>   `Dis No`     Location                                           location_word 
#>   <chr>        <chr>                                              <chr>         
#> 1 2019-0515-T… Handeni district (Tanga Region)                    handeni       
#> 2 2019-0515-T… Handeni district (Tanga Region)                    tanga         
#> 3 2019-0562-T… Mwanza district                                    mwanza        
#> 4 2020-0164-K… West Pokot, Elgeyo Marakwet, Kisumu, Homabay, Tan… west pokot    
#> 5 2020-0164-K… West Pokot, Elgeyo Marakwet, Kisumu, Homabay, Tan… elgeyo marakw…
#> 6 2020-0164-K… West Pokot, Elgeyo Marakwet, Kisumu, Homabay, Tan… kisumu
```
