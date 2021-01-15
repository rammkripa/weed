
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

# Example

This is a basic example which shows a common `weed` workflow:

# Loading the Data

``` r
em <- read_emdat("/Users/ramkripa/Desktop/Tk2.xlsx", file_data = TRUE)
#> New names:
#> * `` -> ...1
#> * `` -> ...2
```

# Locationizing the Data

``` r
locationized_data <- em$disaster_data %>%
  tail() %>%
  split_locations(column_name = "Location") %>%
  head()
locationized_data %>%
  select(`Dis No`, Location,location_word, Latitude, Longitude)
#> # A tibble: 6 x 5
#>   `Dis No`   Location                           location_word Latitude Longitude
#>   <chr>      <chr>                              <chr>         <chr>    <chr>    
#> 1 2019-0515… Handeni district (Tanga Region)    handeni       <NA>     <NA>     
#> 2 2019-0515… Handeni district (Tanga Region)    tanga         <NA>     <NA>     
#> 3 2019-0562… Mwanza district                    mwanza        <NA>     <NA>     
#> 4 2020-0164… West Pokot, Elgeyo Marakwet, Kisu… west pokot    116.343  365.935  
#> 5 2020-0164… West Pokot, Elgeyo Marakwet, Kisu… elgeyo marak… 116.343  365.935  
#> 6 2020-0164… West Pokot, Elgeyo Marakwet, Kisu… kisumu        116.343  365.935
```

There are two problems with the Dataset as it exists here. 1. Half of
our observations, even in this toy dataset, don’t have Lat/Long data 2.
The Lat/Long here is blatantly wrong. Lat \> 90? Long \> 360? How is
this possible?

So, we must recode this Lat/Long data

# Solving Problem 1: Our locations have very little Lat/Long data

``` r
locationized_data %>%
  percent_located_locations(lat_column = "Latitude",
                            lng_column = "Longitude")
```

<img src="man/figures/README-ex4-1.png" width="100%" />

# Solving Problem 2: Geocoding the Locationized Data

``` r
geocoded_data <- locationized_data %>%
  geocode(geonames_username = "rammkripa")
geocoded_data %>%
  select(`Dis No`, Location,location_word, lat, lng)
#> # A tibble: 6 x 5
#>   `Dis No`    Location                                location_word    lat   lng
#>   <chr>       <chr>                                   <chr>          <dbl> <dbl>
#> 1 2019-0515-… Handeni district (Tanga Region)         handeni       -5.55   38.3
#> 2 2019-0515-… Handeni district (Tanga Region)         tanga         -5.07   39.1
#> 3 2019-0562-… Mwanza district                         mwanza        -2.52   32.9
#> 4 2020-0164-… West Pokot, Elgeyo Marakwet, Kisumu, H… west pokot     1.75   35.2
#> 5 2020-0164-… West Pokot, Elgeyo Marakwet, Kisumu, H… elgeyo marak…  0.516  35.5
#> 6 2020-0164-… West Pokot, Elgeyo Marakwet, Kisumu, H… kisumu        -0.102  34.8
```

Side note: These Lat/Long data look much better than before, given that
Kenya is close to the equator\!

# How effective was our geocoding?

``` r
geocoded_data %>%
  percent_located_locations()
```

<img src="man/figures/README-ex6-1.png" width="100%" />

# Want to re-nest the location data?

``` r
geocoded_data %>%
  nest_locations() %>%
  select(`Dis No`, location_data)
#> # A tibble: 6 x 2
#>   `Dis No`           location_data
#>   <chr>         <list<tbl_df[,4]>>
#> 1 2019-0515-TZA            [2 × 4]
#> 2 2019-0515-TZA            [2 × 4]
#> 3 2019-0562-TZA            [1 × 4]
#> 4 2020-0164-KEN            [3 × 4]
#> 5 2020-0164-KEN            [3 × 4]
#> 6 2020-0164-KEN            [3 × 4]
```
