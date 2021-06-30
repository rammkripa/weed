#' Geocode in batches
#'
#' @param . data frame
#' @param batch_size size of each batch to geocode
#' @param wait_time in seconds between batches
#' @param n_results same as geocode
#' @param unwrap as in geocode
#' @param geonames_username as in geocode
#'
#' @return df but geocoded in batches
#' @export
#'
#' @examples
#' Coming soon
geocode_batches <- function(.,
                            batch_size,
                            wait_time,
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
    df_slice <- slice(df, start.idx:end.idx)
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
