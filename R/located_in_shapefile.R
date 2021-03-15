#' Locations In the Shapefile
#' @description Creates a new column (in_shape) that tells whether the lat/long is in a certain shapefile.
#' @param . Data Frame that has been locationized. see ``weed::split_locations``
#' @param lat_column Name of column containing Latitude data
#' @param lng_column Name of column containing Longitude data
#' @param shapefile_name FileName/Path to shapefile (either shapefile or shapefile_name must be provided)
#' @param shapefile The shapefile itself (either shapefile or shapefile_name must be provided)
#'
#' @return Data Frame with the shapefile data as well as the previous data
#' @export
#'
#' @examples
#' d <- tibble::tribble(
#' ~value,  ~location_word,                    ~Country,     ~lat,       ~lng,
#' "city of new york",      "new york",                       "USA", 40.71427,  -74.00597,
#' "kerala, chennai municipality, and san francisco",  "kerala", "India", 10.41667,       76.5,
#' "kerala, chennai municipality, and san francisco",  "chennai",  "India", 13.08784,   80.27847)
#' located_in_shapefile(d, lat_column = "lat", lng_column = "lng", shapefile_name = "~/Desktop/Projects/emdat_proj/shape_data/NH_mask.shp")
#' @importFrom magrittr %>%
located_in_shapefile <- function(.,
                           lat_column = "lat",
                           lng_column = "lng",
                           shapefile = NA,
                           shapefile_name = NA) {
  lng <- NA
  lat <-  NA
  s_file <- NA
  if (is.na(shapefile)) {
    if (is.na(shapefile_name)) {
      print("ERROR : Must provide either shapefile or shapefile_name")
      return(NA)
    }
    else {
      s_name <- shapefile_name
      s_file <- sf::st_read(s_name)
    }
  }
  else {
    s_file <- shapefile
  }
  df <- .
  new_df <- df %>%
    dplyr::rename_("lat" = lat_column, "lng" = lng_column)
  lat_long_key_df <- new_df %>%
    dplyr::select(lat, lng) %>%
    sf::st_as_sf(coords = c("lng", "lat"),
             crs = sf::st_crs(s_file))
  inshape_key_df <- sf::st_contains(y = lat_long_key_df,
                                x = s_file,
                                sparse = FALSE)
  inshape_key_vec <- inshape_key_df[1, ]
  new_df %>%
    dplyr::mutate(in_shape = inshape_key_vec) %>%
    return()
}
