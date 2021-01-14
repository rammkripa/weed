split_locations <- function(locations_vector,
                            dummy_words = c("cities","states","provinces","districts","municipalities","regions", "villages",
                              "city","state","province","district","municipality","region", "township", "village",
                              "near", "department"),
                            joiner_regex = ",|\\(|\\)|;|\\+|(and)|(of)"
) {
  dummy_words_regex <- stringr::str_c("(",stringr::str_c(dummy_words,collapse=")|("),")")
  new_df <- dplyr::tibble(locations_vector) %>%
    tidytext::unnest_tokens(output = "location_word",
                  input = locations_vector,
                  token = stringr::str_split,
                  pattern = joiner_regex) %>%
    dplyr::mutate(location_word = stringr::str_remove(
      string = location_word,
      pattern = dummy_words_regex)) %>%
    dplyr::mutate(location_word = stringr::str_trim(location_word)) %>%
    dplyr::filter(!stringr::str_detect(location_word, "^[0-9 ]+$")) %>%
    dplyr::filter(!stringr::str_detect(location_word, "^ +$")) %>%
    dplyr::filter(location_word!="")
  return(new_df$location_word)
}
