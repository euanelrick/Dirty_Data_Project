
# Cleaning script for Task 6 ----------------------------------------------


# Loading in packages -----------------------------------------------------

library(naniar)

library(tidyverse)

library(janitor)

library(readr)

library(here)

library(stringr)

library(purrr)


# Reading in data ---------------------------------------------------------

dogs_survey <- read_csv("raw_data/dog_survey.csv")



# Cleaning data -----------------------------------------------------------

dogs_survey <- clean_names(dogs_survey) # Cleaning names

dogs_survey_trimmed <- dogs_survey %>% 
  select(-title,
         -x10,
         -x11)

dogs_survey_clean <- dogs_survey_trimmed %>% 
  unique()

dogs_survey_clean <- dogs_survey_clean %>% 
  mutate(food_spend = str_remove(amount_spent_on_dog_food, "^£")) %>% 
  mutate(food_spend = as.numeric(food_spend)) %>% 
  mutate(dog_age = as.numeric(dog_age)) %>% 
  select(-amount_spent_on_dog_food) %>% 
  mutate(dog_gender = case_when(
    str_detect(dog_gender, "^(?i)m+") == TRUE ~ "Male",
    str_detect(dog_gender, "^(?i)f+") == TRUE ~ "Female",
    TRUE ~ as.character(NA)
  )) %>% 
  mutate(dog_size = case_when(
    dog_size == "XS" ~ "XS",
    dog_size %in% c("Smallish", "S") ~ "S",
    dog_size %in% c("Medium sized", "M") ~ "M",
    dog_size %in% c("large", "L") ~ "L",
    dog_size == "XL" ~ "XL",
    TRUE ~ as.character(NA)
  )) 





# Writing as a .csv -------------------------------------------------------

write_csv(dogs_survey_clean, file = here("clean_data/dogs_survey_clean.csv"))
