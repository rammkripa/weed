#' Locations In the Box
#' @description Creates a new column (in_box) that tells whether the lat/long is in a certain box or not.
#' @param . Data Frame that has been locationized. see ``weed::split_locations``
#' @param lat_column Name of column containing Latitude data
#' @param lng_column Name of column containing Longitude data
#' @param top_left_lat Latitude at top left corner of box
#' @param top_left_lng Longitude at top left corner of box
#' @param bottom_right_lat Latitude at bottom right corner of box
#' @param bottom_right_lng Longitude at bottom right corner of box
#'
#' @return A dataframe that contains the latlong box data
#' @export
#'
#' @examples
#' d <- tibble::tribble(
#' ~value,  ~location_word,                    ~Country,     ~lat,       ~lng,
#' "city of new york",      "new york",                       "USA", 40.71427,  -74.00597,
#' "kerala, chennai municipality, and san francisco",  "kerala", "India", 10.41667,       76.5,
#' "kerala, chennai municipality, and san francisco",  "chennai",  "India", 13.08784,   80.27847)
#' located_in_box(d, lat_column = "lat", lng_column = "lng", top_left_lat = 45, bottom_right_lat = 12, top_left_lng = -80, bottom_right_lng = 90)
#' @importFrom magrittr %>%
located_in_box <- function(.,
                           lat_column = "lat",
                           lng_column = "lng",
                           top_left_lat,
                           top_left_lng,
                           bottom_right_lat,
                           bottom_right_lng) {
  lng <- NA
  lat <-  NA
  df <- .
  new_df <- df %>%
    dplyr::rename("lat" = lat_column, "lng" = lng_column)
  inbox_df <- new_df %>%
    dplyr::mutate(in_box =
             (lat >= bottom_right_lat) &
             (lat <= top_left_lat) &
             (lng >= top_left_lng) &
             (lng <= bottom_right_lng))
  return (inbox_df)
}
