data_all <- list.files(path = (Datsource), pattern = "*.csv", full.names = TRUE) %>% 
  walk(read_csv) %>%                                            # Store all files in list
  bind_rows                                                       # Combine data sets into one data set 
data_all
Happiness_Data<-list.files(path=)


dat <- list.files(path= "mocktest/Data/Happy", pattern="*.csv",full.names=T) 

datpull<-function(x){
  library(tidyverse)
  library(readr)
  library(purrr)
    list.files(path = (x), pattern = "*.csv",full.names=T) %>% 
    purrr::quietly(walk(read_csv)) %>%                                            
    bind_rows()  
    
  df<-data_all
}

Data_Collating <- function(Datroot){
  
  library(tidyverse)
  
  # let's create a silent read function first (as it prints a load of nonsense if you use read_csv directly):
  silentread <- function(x){
    hushread <- purrr::quietly(read_csv)
    df <- hushread(x)
    df$result
  }
  
  datcolat <-
    list.files(Datroot, full.names = T, recursive = T) %>%
    # Ensure you only load the csv's, not the README.txt.
    .[!grepl(".txt", .)] %>%
    as.list() %>%
    map(~silentread(.)) %>% bind_rows()
  # equivalent to using map_df
  
  datcolat
  
}




Data_col<- function(Datsource){
  library(purrr)
  library(dplyr)
  library(readr)
  silentread<-function(x){purrr::quietly(read_csv(x))}
  dat<-list.files(Datsource,pattern="*.csv") %>% 
    map(silentread()) %>% 
    bind_rows()
   
  dat 
}




# ----------------Real Deal-----------------
quiet_read<-function(x){
  df %>% 
    quietly(read_csv(x))
}


data_all <- function(datsource){
  data_all %>% 
    list.files(path = datsource, pattern = "*.csv", full.names = TRUE) %>% 
    lapply(quiet_read()) %>%  
    bind_rows 
  
data_all<- return(data_all) 
}  

data_all("Data/Happy")















