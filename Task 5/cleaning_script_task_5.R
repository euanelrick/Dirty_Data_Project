# Cleaning script for Task 5


# Loading in packages -----------------------------------------------------

library(naniar)

library(tidyverse)

library(janitor)

library(readr)

library(here)

library(stringr)

library(purrr)

# Reading in raw data -----------------------------------------------------

raw_rwa <- read_csv(here("raw_data/rwa.csv"))



# Cleaning data -----------------------------------------------------------

rwa_trimmed <- raw_rwa %>% 
  clean_names() %>% 
  select(-q1:-q2,
         -e1:-e22,
         -tipi1:-vcl16,
         -surveyaccurate,
         -introelapse,
         -surveyelapse,
         -screenw:-screenh,
         -engnat,
         -ip_country,
         -religion:-married) %>% 
  mutate(
    gender = case_when(
    gender == 1 ~ "Male",
    gender == 2 ~ "Female",
    gender == 3 ~ "Other"
    
  )
  ) %>% 
   mutate(
     education = case_when(
       education == 1 ~ "Less than high school",
       education == 2 ~ "High school",
       education == 3 ~ "University degree",
       education == 4 ~ "Graduate degree"
     )
     
   ) %>% 
  mutate(
    urban = case_when(
      urban == 1 ~ "Rural",
      urban == 2 ~ "Suburban",
      urban == 3 ~ "Urban"
    )
  )  %>% 
  mutate(
    hand = case_when(
      hand == 1 ~ "Right",
      hand == 2 ~ "Left",
      hand == 3 ~ "Both"
    )
  ) 



# Function to fix reverse scores ------------------------------------------

fix_reverse_score <- function(question) {
  fixed_score <- (10 - question) %>% 
  paste(fixed_score)
  
}
      
      
   

rwa_corrected <- rwa_corrected %>% 
  apply(MARGIN = 2, FUN = fix_reverse_score("q4"))

  


