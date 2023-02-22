
# Cleaning script for Task 1 ----------------------------------------------


# Loading in packages -----------------------------------------------------

library(naniar)

library(tidyverse)

library(janitor)

library(readr)

library(here)

library(stringr)



# Reading in raw data -----------------------------------------------------


decathlon <- read_rds("raw_data/decathlon.rds")


glimpse(decathlon)

# Cleaning column names ---------------------------------------------------

decathlon <- clean_names(decathlon)

colnames(decathlon) <- gsub("x", "", colnames(decathlon))

decathlon_clean <- decathlon %>% 
  rownames_to_column() %>% 
  rename("name" = rowname) %>% 
  relocate(competition, .after = name)

decathlon_clean$name <- str_to_title(decathlon_clean$name) 


# Writing clean data as .csv ----------------------------------------------

write_csv(decathlon_clean, file = "clean_data/decathlon_clean.csv")  
         
         


