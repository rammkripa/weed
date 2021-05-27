#' Splits string of manually entered locations into one row for each location
#' @description Changes the unit of analysis from a disaster, to a disaster-location. This is useful as preprocessing before geocoding each disaster-location pair.
#' @description Can be used in piped operations, making it tidy!
#' @param . data frame of disaster data
#' @param column_name name of the column containing the locations
#' @param dummy_words a vector of words that we don't want in our final output.
#' @param joiner_regex a regex that tells us how to split the locations
#'
#' @return same data frame with the location_word column added as well as a column called uncertain_location_specificity where the same location could be referred to in varying levels of specificity
#' @export
#'
#' @examples
#' locs <- c("city of new york", "kerala, chennai municipality, and san francisco",
#' "mumbai region, district of seattle, sichuan province")
#' d <- tibble::as_tibble(locs)
#' split_locations(d, column_name = "value")
#'
#' @importFrom magrittr %>%
split_locations <- function(.,
                            column_name = "locations",
                            dummy_words = c("cities","states","provinces","districts","municipalities","regions", "villages",
                              "city","state","province","district","municipality","region", "township", "village",
                              "near", "department"),
                            joiner_regex = ",|\\(|\\)|;|\\+|( and )|( of )"
) {
  location_string <- location_word <- NULL
  df <- .
  dummy_words_regex <- stringr::str_c("(",stringr::str_c(dummy_words,collapse=")|("),")")
  new_df <- df %>%
    #dplyr::mutate(uncertain_location_specificity = stringr::str_detect(string = location_string, "\\(")) %>%
    tidytext::unnest_tokens(output = "location_word",
                  input = column_name,
                  token = stringr::str_split,
                  pattern = joiner_regex) %>%
    dplyr::mutate(location_word = stringr::str_remove(
      string = location_word,
      pattern = dummy_words_regex)) %>%
    dplyr::mutate(location_word = stringr::str_trim(location_word)) %>%
    dplyr::filter(!stringr::str_detect(location_word, "^[0-9 ]+$")) %>%
    dplyr::filter(!stringr::str_detect(location_word, "^ +$")) %>%
    dplyr::filter(location_word!="")
  vec <- new_df[[column_name]]
  new_df <- new_df %>%
    dplyr::mutate(uncertain_location_specificity = stringr::str_detect(string = vec, "\\("))
  return(new_df)
}
