#Remix of Nick's one
Data_Collating <- function(Datroot){
  
  library(tidyverse)
  
  # let's create a silent read function first (as it prints a load of nonsense if you use read_csv directly):
  silentread <- function(x){
    hushread <- purrr::quietly(read_csv)
    df <- hushread(x)
    df$result
  }

datcolat <-
  list.files("Data/Happy",pattern="*.csv", full.names = T, recursive = T) %>%
  map(~silentread(.)) %>% bind_rows() 

datcolat
}







Data_load<-function(Datsource){
  
read_func<-function(x){
  library(readr)
  library(purrr)
  library(dplyr)
  read_func<-purrr::quietly(read_csv(x,T))
 read_func
}
data_in <- list.files(Datsource, pattern="*.csv",full.names = T) %>% 
    walk(read_func) %>% 
    as.data.frame.list() %>% 
    bind_rows()
  data_in
}

Data_load("Data/Happy")

Data_l<-function(Datsource){
  library(readr)
  library(purrr)
  library(dplyr)
  read_func<-function(...){
    lapply(...,read_csv) %>% 
      purrr::quietly()
  }
  
  dat <- list.files(path=Datsource, pattern="*.csv",full.names = T,recursive = T) %>% 
    walk(read_func) %>% 
    bind_rows()

  dat
}

Data_l("Data/Happy")

data_list <- list.files("Data/Happy", pattern="*.csv") 
     
data<-walk(read_func(data_list)) %>% 
     bind_rows()

# After giving up I am just loading data in as is

Happy_data<- list.files("Data",pattern="*.csv") %>% 
  read_csv() %>% 
  walk() %>% 
  bind_rows()


datcolat <-
  list.files("Data/Happy",pattern="*.csv", full.names = T, recursive = T) %>%
  map(~silentread(.)) %>% bind_rows() 
