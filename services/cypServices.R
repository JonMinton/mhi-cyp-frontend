SERVER_PATH = "http://127.0.0.1:8000"
library(httr)
library(glue)

get_all_data <- function(){
  res <- GET(glue("{SERVER_PATH}/"))
  
  if (res$status_code != 200) {
    stop("Invalid status code")
  }
  
  content(res)
}

get_number_of_indicators <- function() {
  res <- GET(glue("{SERVER_PATH}/n_indicators"))
  if (res$status_code != 200) {
    stop("Invalid status code")
  }
  
  content(res)[[1]]
}

get_number_of_dataless_indicators <- function() {
  res <- GET(glue("{SERVER_PATH}/n_indicators/true"))
  if (res$status_code != 200){
    stop("Invalid status code")
  }
  content(res)[[1]]
}

get_number_of_data_indicators <- function() {
  res <- GET(glue("{SERVER_PATH}/n_indicators/false"))
  if (res$status_code != 200){
    stop("Invalid status code")
  }
  content(res)[[1]]
}


get_all_metadata <- function() {
  res <- GET(glue("{SERVER_PATH}/metadata"))
  if (res$status_code != 200){
    stop("Invalid status code")
  }

  content <- content(res)
  
  df <- lapply(
    content, 
    function(y) sapply(y, function(x) x[[1]]) |> t() |> as.data.frame()
  ) |> bind_rows()
  df 
}




  
  