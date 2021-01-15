#' Percent of Disasters Successfully Geocoded
#' @description Tells us how successful the geocoding is.
#' @description How many of the disasters in this data frame have non NA coordinates?
#' @param . Data Frame that has been locationized. see ``weed::split_locations``
#' @param how takes in a function, "any", or "all" to determine how to count the disaster as being geocoded
#' if any, at least one location must be coded, if all, all locations must have lat/lng
#' if a function, it must take in a logical vector and return a single logical
#' @param lat_column Name of column containing Latitude data
#' @param lng_column Name of column containing Longitude data
#' @param plot_result Determines output type (Plot or Summarized Data Frame)
#'
#' @return The percent and number of Locations that have been geocoded (see ``plot_result`` for type of output)
#' @export
#'
#' @examples
#' d <- tibble::tribble(
#' ~value,  ~location_word,                    ~Country,     ~lat,       ~lng,
#' "city of new york",      "new york",                       "USA", 40.71427,  -74.00597,
#' "kerala, chennai municipality, and san francisco",  "kerala", "India", 10.41667,       76.5,
#' "kerala, chennai municipality, and san francisco",  "chennai",  "India", 13.08784,   80.27847)
#' percent_located_disasters(d, how = "any", lat_column = "lat", lng_column = "lng", plot_result = FALSE)
#'
#' @importFrom magrittr %>%
percent_located_disasters <- function(.,
                                      how = "any",
                                      lat_column = "lat",
                                      lng_column = "lng",
                                      plot_result = TRUE) {
  df <- .
  # Global Variables
  lat <- lng <- coords_existent <- count <- percent <- uptown_func <- NULL

  if (how == "any") {
    uptown_func <- any
  }
  else if (how == "all") {
    uptown_func <- all
  }
  else {
    uptown_func <- how
  }
  new_df <- df %>%
    dplyr::rename("lat" = lat_column, "lng" = lng_column)
  perc_df <- new_df %>%
    dplyr::mutate(coords_existent = !(is.na(lat) & is.na(lng))) %>%
    dplyr::group_by(`Dis No`) %>%
    dplyr::summarize(coords_existent = uptown_func(coords_existent)) %>%
    dplyr::group_by(coords_existent) %>%
    dplyr::summarize(count = dplyr::n()) %>%
    dplyr::mutate(percent = 100*count/sum(count)) %>%
    dplyr::mutate(coords_existent = forcats::as_factor(coords_existent)) %>%
    dplyr::mutate(coords_existent = forcats::fct_recode(coords_existent, "Geocode Failed" = "FALSE", "Geocode Success"  = "TRUE"))
  if (plot_result){
    perc_df %>%
      ggplot2::ggplot(mapping = ggplot2::aes(x = coords_existent, y = percent, fill = coords_existent))+
      ggplot2::geom_col() +
      ggplot2::ylim(0,100) +
      ggplot2::xlab("Geocoding") +
      ggplot2::ylab("Percent of Locations") +
      ggplot2::ggtitle("Percent of Locations Geocoded") +
      ggplot2::coord_flip()
  }
  else {
    return(perc_df)
  }

}
