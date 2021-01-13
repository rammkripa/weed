#' Reads Excel Files obtained from EM-DAT Database
#' @description EMDAT Database link [here](https://public.emdat.be/)
#' @param path_to_file A String, the Path to the file downloaded.
#' @param file_data A Boolean, Do you want information about the file and how it was created?
#'
#' @return Returns a list containing one or two tibbles, one for the Disaster Data, and one for File Metadata.
#' @export
#'
#' @examples
#' read_emdat(path_to_file = here("Tanzania_Kenya2.xlsx"), file_data = TRUE)
#' @importFrom magrittr %>%
read_emdat <- function(path_to_file, file_data = TRUE){
  disaster_data <- readxl::read_excel(path = path_to_file,
                skip = 6,
                col_names = TRUE)
  meta_data <- readxl::read_excel(path = path_to_file,
                          n_max = 6,
                          col_names = FALSE) %>%
              dplyr::rename("Q" = "...1", "A" = "...2")
  return_list <- list()
  if(file_data) {
    return_list[["file_data"]] <- meta_data
  }
  return_list[["disaster_data"]] <- disaster_data
  return(return_list)
}
