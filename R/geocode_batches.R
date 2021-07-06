#' Geocode in batches
#'
#'
#' @param . data frame
#' @param batch_size size of each batch to geocode
#' @param wait_time in seconds between batches
#' Note:
#' default batch_size and wait_time were set to accomplish the geocoding task optimally within the constraints of geonames free access
#' @param n_results same as geocode
#' @param unwrap as in geocode
#' @param geonames_username as in geocode
#'
#' @return df geocoded
#' @export
#'
#' @examples
#' df <- tibble::tribble(
#'    ~value,  ~location_word,                    ~Country,
#'    "city of new york",      "new york",                       "USA",
#'    "mumbai region, district of seattle, sichuan province",  "mumbai","India",
#'    "mumbai region, district of seattle, sichuan province",  "seattle", "USA",
#'    "mumbai region, district of seattle, sichuan province", "sichuan",  "China, People's Republic"
#'    )
#'
#' geocode_batches(df, batch_size = 1, wait_time = 4, geonames_username = "rammkripa")
#'
#' @importFrom magrittr %>%
geocode_batches <- function(.,
                            batch_size = 990,
                            wait_time = 4800,
                            n_results = 1,
                            unwrap = FALSE,
                            geonames_username) {
  df <- .
  num_batches <- nrow(df) %/% batch_size
  listy <- list()
  for (batch_num in 1:num_batches) {
    print("batch number")
    print(batch_num)
    start.idx <- batch_num * batch_size
    end.idx <- min( c((batch_num + 1) * batch_size - 1, nrow(df)) )
    df_slice <- dplyr::slice(df, start.idx:end.idx)
    coded_slice <- df_slice %>%
      geocode(n_results, unwrap, geonames_username)
    listy[[batch_num]] = coded_slice
    print("waiting for ")
    print(wait_time)
    print("seconds")
    Sys.sleep(wait_time)
  }
  return(dplyr::bind_rows(listy))

}
