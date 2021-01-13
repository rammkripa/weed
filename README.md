
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

``` r
library(weed)
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
#> ✓ tibble  3.0.4     ✓ dplyr   1.0.2
#> ✓ tidyr   1.1.2     ✓ stringr 1.4.0
#> ✓ readr   1.4.0     ✓ forcats 0.5.0
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
em <- read_emdat("/Users/ramkripa/Desktop/Tk2.xlsx", file_data = TRUE)
#> New names:
#> * `` -> ...1
#> * `` -> ...2
em$disaster_data %>%
  head() %>%
  knitr::kable()
```

| Dis No        | Year | Seq  | Disaster Group | Disaster Subgroup | Disaster Type | Disaster Subtype | Disaster Subsubtype | Event Name | Entry Criteria | Country                      | ISO | Region         | Continent | Location                | Origin | Associated Dis | Associated Dis2 | OFDA Response | Appeal | Declaration | Aid Contribution | Dis Mag Value | Dis Mag Scale | Latitude | Longitude | Local Time | River Basin | Start Year | Start Month | Start Day | End Year | End Month | End Day | Total Deaths | No Injured | No Affected | No Homeless | Total Affected | Reconstruction Costs (’000 US\()| Insured Damages ('000 US\)) | Total Damages (’000 US$) | CPI |          |
| :------------ | :--- | :--- | :------------- | :---------------- | :------------ | :--------------- | :------------------ | :--------- | :------------- | :--------------------------- | :-- | :------------- | :-------- | :---------------------- | :----- | :------------- | :-------------- | :------------ | :----- | :---------- | ---------------: | ------------: | :------------ | :------- | :-------- | :--------- | :---------- | ---------: | ----------: | --------: | -------: | --------: | ------: | -----------: | ---------: | ----------: | ----------: | -------------: | ------------------------------------------------------------: | -----------------------: | --: | -------: |
| 1964-0025-KEN | 1964 | 0025 | Natural        | Hydrological      | Flood         | NA               | NA                  | NA         | Affect         | Kenya                        | KEN | Eastern Africa | Africa    | Nyanza, Western Regions | NA     | NA             | NA              | Yes           | NA     | NA          |               NA |            NA | Km2           | NA       | NA        | NA         | NA          |       1964 |           5 |        NA |     1964 |         5 |      NA |           NA |         NA |       15000 |          NA |          15000 |                                                            NA |                       NA |  NA | 12.13212 |
| 1964-0027-TZA | 1964 | 0027 | Natural        | Geophysical       | Earthquake    | Ground movement  | NA                  | NA         | Affect         | Tanzania, United Republic of | TZA | Eastern Africa | Africa    | Northern                | NA     | NA             | NA              | Yes           | NA     | NA          |               NA |            NA | Richter       | 2.31 S   | 32.56 E   | NA         | NA          |       1964 |           5 |         7 |     1964 |         5 |       7 |            4 |         NA |         500 |          NA |            500 |                                                            NA |                       NA |  NA | 12.13212 |
| 1964-0026-TZA | 1964 | 0026 | Natural        | Hydrological      | Flood         | Riverine flood   | NA                  | NA         | Affect         | Tanzania, United Republic of | TZA | Eastern Africa | Africa    | Pangani river basin     | NA     | NA             | NA              | Yes           | NA     | NA          |               NA |            NA | Km2           | NA       | NA        | NA         | NA          |       1964 |           5 |        NA |     1964 |         5 |      NA |           NA |         NA |       10000 |        3900 |          13900 |                                                            NA |                       NA |  NA | 12.13212 |
| 1965-9038-KEN | 1965 | 9038 | Natural        | Climatological    | Drought       | Drought          | NA                  | NA         | NA             | Kenya                        | KEN | Eastern Africa | Africa    | NA                      | NA     | NA             | NA              | Yes           | NA     | NA          |               NA |            NA | Km2           | NA       | NA        | NA         | NA          |       1965 |           7 |        NA |     1965 |        NA |      NA |           NA |         NA |      260000 |          NA |         260000 |                                                            NA |                       NA |  NA | 12.32443 |
| 1967-9005-TZA | 1967 | 9005 | Natural        | Climatological    | Drought       | Drought          | NA                  | NA         | NA             | Tanzania, United Republic of | TZA | Eastern Africa | Africa    | Nationwide, Kilwa       | NA     | NA             | NA              | Yes           | No     | No          |               NA |            NA | Km2           | NA       | NA        | NA         | NA          |       1967 |           5 |        NA |     1967 |        NA |      NA |           NA |         NA |       53483 |          NA |          53483 |                                                            NA |                       NA |  NA | 13.04806 |
| 1968-0043-KEN | 1968 | 0043 | Natural        | Hydrological      | Flood         | NA               | NA                  | NA         | OFDA           | Kenya                        | KEN | Eastern Africa | Africa    | Nyanza, West provinces  | NA     | NA             | NA              | Yes           | NA     | NA          |               NA |            NA | Km2           | NA       | NA        | NA         | NA          |       1968 |           5 |        NA |     1968 |         5 |      NA |           NA |         NA |          NA |          NA |             NA |                                                            NA |                       NA |  50 | 13.60545 |
