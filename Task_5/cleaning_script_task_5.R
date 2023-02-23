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
         -religion:-married,
         -major) %>% 
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
  10 - question
  
}
      

rwa_reverse_scored <- rwa_trimmed %>% 
  select(q4, q6, q8, q9, q11, q13, q15, q18, q20, q21)

  
rwa_reverse_scored_fixed <- as.data.frame(
  apply(rwa_reverse_scored, MARGIN = 2, FUN = fix_reverse_score))


rwa_trimmed <- rwa_trimmed %>% 
  select(-q4, -q6, -q8, -q9, -q11, -q13, -q15, -q18, -q20, -q21)

  
rwa_fixed <- rwa_reverse_scored_fixed %>% 
  merge(rwa_trimmed, by = "row.names", all.x = TRUE) %>% 
  select(-Row.names)

questions <- rwa_fixed %>% 
  select(q4:q22)

rwa_fixed <- rwa_fixed %>% 
 mutate(rwa_score <- rowMeans(questions))


rwa_clean <- rwa_fixed %>% 
  select(
         -q4:-q22)




rwa_clean <- rwa_clean %>% 
  rename(rwa_score = `rwa_score <- rowMeans(questions)`) %>% 
  relocate(rwa_score, .before = testelapse)



# Write as .csv file ------------------------------------------------------

write_csv(rwa_clean, "clean_data/rwa_clean.csv")
