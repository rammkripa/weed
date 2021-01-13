read_emdat <- function(path, file_data = TRUE){
  disaster_data <- readxl::read_excel(path = path,
                sheet = 1,
                skip = 6,
                col_names = TRUE)
  meta_data <- readxl::read_excel(path = path,
                          sheet = 1,
                          n_max = 6,
                          col_names = FALSE)
  return_list <- list()
  if(file_data) {
    return_list["file_data"] <- meta_data
  }
  return_list["disaster_data"] <- disaster_data
  return(return_list)
}
