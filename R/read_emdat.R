read_emdat <- function(path_to_file, file_data = TRUE){
  disaster_data <- readxl::read_excel(path = path_to_file,
                skip = 6,
                col_names = TRUE)
  meta_data <- readxl::read_excel(path = path_to_file,
                          n_max = 6,
                          col_names = FALSE) %>%
              rename("Q" = "...1", "A" = "...2")
  return_list <- list()
  if(file_data) {
    return_list[["file_data"]] <- meta_data
  }
  return_list[["disaster_data"]] <- disaster_data
  return(return_list)
}
