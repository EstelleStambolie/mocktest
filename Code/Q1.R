Data_load<-function(Datsource){
  
read_func<-function(x){
  library(readr)
  library(purrr)
  library(dplyr)
  read_func<-purrr::quietly(read_csv(x,T))
 read_func
}

data_in <- list.files(Datsource, pattern="*.csv") %>% 
    walk(read_func(data_in)) %>% 
    bind_rows()
 
  data_in
}

Data_load("Data/Happy/Happy_EastAsia")

Data_l<-function(Datsource){
  
  read_func<-function(x){
    library(readr)
    library(purrr)
    library(dplyr)
    read_func<-purrr::quietly(read_csv(x))
    read_func
  }
  
  data_list <- list.files("Data/Happy", pattern="*.csv") %>% 
    walk(read_func) %>% 
    bind_rows()

  dat
}

Data_l("Data/Happy")

data_list <- list.files("Data/Happy", pattern="*.csv") 
     
data<-walk(read_func(data_list)) %>% 
     bind_rows()