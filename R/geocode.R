#' GeoCodes text locations using the GeoNames API
#' @description Uses the ``location_word`` and ``Country`` columns of the data frame to make queries
#' to the geonames API and geocode the locations in the dataset.
#'
#' Note:
#' 1) The Geonames API (for free accounts) limits you to 1000 queries an hour
#' 2) You need a geonames username to make queries. You can learn more about that [here](https://www.geonames.org/manual.html)
#'
#' @param . a data frame which has been locationized (see ``weed::split_locations``)
#' @param n_results number of lat/longs to get
#' @param unwrap if true, returns lat1, lat2, lng1, lng2 etc. as different columns, otherwise one lat column and 1 lng column
#' @param geonames_username Username for geonames API. More about getting one is in the note above.
#'
#' @return the same data frame with a lat column/columns and lng column/columns
#' @export
#'
#'
#' @examples
#' df <- tibble::tribble(
#'    ~value,  ~location_word,                    ~Country,
#'    "city of new york",      "new york",                       "USA",
#'    "mumbai region, district of seattle, sichuan province",  "mumbai","India",
#'    "mumbai region, district of seattle, sichuan province",  "seattle", "USA",
#'    "mumbai region, district of seattle, sichuan province", "sichuan",  "China, People's Republic"
#'    )
#' geocode(df, n_results = 1, unwrap = TRUE, geonames_username = "rammkripa")
#'
#'
#' @importFrom magrittr %>%
geocode <- function(.,
                    n_results = 1,
                    unwrap = FALSE,
                    geonames_username) {
  options(geonamesUsername = geonames_username)
  location_word <- Country <- location_data <- lat <- lng <- NULL
  df <- .
  new_df <- df %>%
    dplyr::mutate(location_data = purrr::pmap(list(location_word, Country, n_results), get_lat_long)) %>%
    tidyr::unnest_wider(col = location_data)
  if (unwrap) {
    new_df <- new_df %>%
      tidyr::unnest_wider(col = lat, names_sep = '') %>%
      tidyr::unnest_wider(col = lng, names_sep = '')
  }
  return(new_df)
}
cache_list <- list()
get_lat_long <- function(location_name,country_name, n_result){
  if (location_name %in% names(cache_list)){
    return(cache_list[[location_name]])
  }
  country_code <- countrycode::countrycode(sourcevar = country_name,
                              origin = "country.name",
                              destination = "iso2c")
  return_list <- geonames::GNsearch(q = location_name,
                          country = country_code,
                          type = "json"
  )
  return_val <- tryCatch(
    expr = {
      toponymName <- lat <- lng <- NULL
      return_df <- return_list %>%
        dplyr::select(toponymName,lat,lng) %>%
        utils::head(n = n_result) %>%
        dplyr::mutate(lat = as.numeric(lat),lng = as.numeric(lng))
      list("lat" = return_df$lat,"lng" = return_df$lng)
    },
    error = function(e)
    {
      print(e)
      list("lat" = NA,
           "lng" = NA)
    }
  )
  cache_list[[location_name]] <- return_val
  return(return_val)
}
