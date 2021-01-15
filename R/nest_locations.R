#' Nest Location Data into a column of Tibbles
#'
#' @param . Locationized data frame (see ``weed::split_locations``)
#' @param key_column Column name for Column that uniquely IDs each observation
#' @param columns_to_nest Column names for Columns to nest inside the mini-dataframes
#' @param keep_nested_cols Boolean to Keep the nested columns externally or not.
#'
#' @return Data Frame with A column of data frames
#' @export
#'
#' @examples
#' d <- tibble::tribble(
#' ~value,  ~location_word,                    ~Country,                  ~lat,                      ~lng,
#' "city of new york",      "new york",             "USA",  c(40.71427, 40.6501),   c(-74.00597, -73.94958),
#' "kerala, chennai municipality, and san francisco",    "kerala",    "India",   c(10.41667, 8.4855),         c(76.5, 76.94924),
#' "kerala, chennai municipality, and san francisco",   "chennai",   "India", c(13.08784, 12.98833),     c(80.27847, 80.16578),
#' "kerala, chennai municipality, and san francisco", "san francisco",    "USA", c(37.77493, 37.33939), c(-122.41942, -121.89496))
#' nest_locations(d, key_column = "value")
#' @importFrom magrittr %>%
nest_locations <- function(.,
                           key_column = "Dis No",
                           columns_to_nest = c("location_word","lat","lng"),
                           keep_nested_cols = FALSE) {
  df <- .

  naming_func <- function(argument) {
    return(key_column)
  }

  bud <- df %>%
    dplyr::select(c(columns_to_nest,key_column)) %>%
    dplyr::group_nest(get(key_column)) %>%
    dplyr::rename_with(.fn = naming_func, .cols = "get(key_column)")
  joint <- df %>%
    dplyr::left_join(y = bud, by = key_column) %>%
    dplyr::rename("location_data" = "data")
  if (keep_nested_cols) {
    return(joint)
  }
  else {
    joint %>%
      dplyr::select(!columns_to_nest) %>%
      return()
  }
}
