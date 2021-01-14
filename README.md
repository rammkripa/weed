
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
  select(`Dis No`, Location,location_word, Country) %>%
  head()
#> # A tibble: 6 x 4
#>   `Dis No`   Location                             location_word  Country        
#>   <chr>      <chr>                                <chr>          <chr>          
#> 1 2019-0515… Handeni district (Tanga Region)      handeni        Tanzania, Unit…
#> 2 2019-0515… Handeni district (Tanga Region)      tanga          Tanzania, Unit…
#> 3 2019-0562… Mwanza district                      mwanza         Tanzania, Unit…
#> 4 2020-0164… West Pokot, Elgeyo Marakwet, Kisumu… west pokot     Kenya          
#> 5 2020-0164… West Pokot, Elgeyo Marakwet, Kisumu… elgeyo marakw… Kenya          
#> 6 2020-0164… West Pokot, Elgeyo Marakwet, Kisumu… kisumu         Kenya
```

# Geocoding the Locationized Data

``` r
em$disaster_data %>%
  tail() %>%
  split_locations(column_name = "Location") %>%
  select(`Dis No`, Location,location_word, Country) %>%
  head() %>%
  geocode(geonames_username = "rammkripa")
#> # A tibble: 6 x 6
#>   `Dis No`   Location                    location_word Country         lat   lng
#>   <chr>      <chr>                       <chr>         <chr>         <dbl> <dbl>
#> 1 2019-0515… Handeni district (Tanga Re… handeni       Tanzania, U… -5.55   38.3
#> 2 2019-0515… Handeni district (Tanga Re… tanga         Tanzania, U… -5.07   39.1
#> 3 2019-0562… Mwanza district             mwanza        Tanzania, U… -2.52   32.9
#> 4 2020-0164… West Pokot, Elgeyo Marakwe… west pokot    Kenya         1.75   35.2
#> 5 2020-0164… West Pokot, Elgeyo Marakwe… elgeyo marak… Kenya         0.516  35.5
#> 6 2020-0164… West Pokot, Elgeyo Marakwe… kisumu        Kenya        -0.102  34.8
```
