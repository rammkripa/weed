#' Percent of Locations Successfully Geocoded
#' @description Tells us how successful the geocoding is.
#' @description How many of the locations in this data frame have non NA coordinates?
#' @param . Data Frame that has been locationized. see ``weed::split_locations``
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
#' percent_located_locations(d,
#' lat_column = "lat",
#' lng_column = "lng",
#' plot_result = FALSE)
#'
#' @importFrom magrittr %>%
percent_located_locations <- function(.,
                                      lat_column = "lat",
                                      lng_column = "lng",
                                      plot_result = TRUE) {
  df <- .
  # Global Variables
  lat <- lng <- coords_nonexistent <- count <- percent <- NULL
  new_df <- df %>%
    dplyr::rename("lat" = lat_column, "lng" = lng_column)
  perc_df <- new_df %>%
    dplyr::mutate(coords_nonexistent = is.na(lat) & is.na(lng)) %>%
    dplyr::group_by(coords_nonexistent) %>%
    dplyr::summarize(count = dplyr::n()) %>%
    dplyr::mutate(percent = 100*count/sum(count)) %>%
    dplyr::mutate(coords_nonexistent = forcats::as_factor(coords_nonexistent)) %>%
    dplyr::mutate(coords_nonexistent = forcats::fct_recode(coords_nonexistent, "Geocode Failed" = "TRUE", "Geocode Success"  = "FALSE"))

  if (plot_result){
    perc_df %>%
      ggplot2::ggplot(mapping = ggplot2::aes(x = coords_nonexistent, y = percent, fill = coords_nonexistent))+
      ggplot2::geom_col() +
      ggplot2::ylim(0,100) +
      ggplot2::xlab("Geocoding") +
      ggplot2::ylab("Percent of Locations") +
      ggplot2::ggtitle("Percent of Locations Geocoded") +
      ggplot2::coord_flip()+
      ggplot2::theme(legend.title = ggplot2::element_blank()) +
      ggplot2::scale_color_manual(aesthetics = 'fill', values = c('Geocode Failed' = 'red', 'Geocode Success' = 'blue'))
  }
  else {
    return(perc_df)
  }

}
