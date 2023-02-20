# Task 4 cleaning script


# Loading in packages -----------------------------------------------------

library(tidyverse)

library(janitor)

library(readxl)

library(here)

library(stringr)


# Loading in data ---------------------------------------------------------

candy_2015 <- read_xlsx("raw_data/boing-boing-candy-2015.xlsx")

candy_2016 <- read_xlsx("raw_data/boing-boing-candy-2016.xlsx")
  
candy_2017 <- read_xlsx("raw_data/boing-boing-candy-2017.xlsx")



# Looking at data ---------------------------------------------------------

glimpse(candy_2015)

glimpse(candy_2016)

glimpse(candy_2017)



# Cleaning columns in each dataset ----------------------------------------

candy_2015 <- clean_names(candy_2015)

candy_2016 <- clean_names(candy_2016)
  
candy_2017 <- clean_names(candy_2017)



# Cleaning candy_2015 -----------------------------------------------------

names(candy_2015)

candy_2015_trimmed <- candy_2015 %>% 
  select(timestamp:york_peppermint_patties) %>% 
  rename(age = how_old_are_you,
         going_tot = are_you_going_actually_going_trick_or_treating_yourself,
         year = timestamp,
         "100_grand_bar" = x100_grand_bar
         ) %>% 
  mutate(year = substr(year, 1, 4)) %>% 
  mutate(age = as.numeric(age)) %>% 
  mutate(country = NA, .after = going_tot) %>% 
  filter(age <= 90) %>% 
  pivot_longer(cols = butterfinger:york_peppermint_patties,
               names_to = "candy_type",
               values_to = "opinion") %>% 
  filter(is.na(opinion) == FALSE)
  
  


# Cleaning candy_2016 -----------------------------------------------------

candy_2016_trimmed <- candy_2016 %>% 
  select(timestamp:york_peppermint_patties,
         -your_gender,
         -which_state_province_county_do_you_live_in) %>% 
  rename(age = how_old_are_you,
         going_tot = are_you_going_actually_going_trick_or_treating_yourself,
         year = timestamp,
         country = which_country_do_you_live_in,
         "100_grand_bar" = x100_grand_bar
  ) %>% 
  mutate(year = substr(year, 1, 4)) %>% 
  mutate(age = as.numeric(age)) %>% 
  filter(age <= 90) %>% 
  relocate(age, .before = going_tot) %>% 
  pivot_longer(cols = "100_grand_bar":york_peppermint_patties,
               names_to = "candy_type",
               values_to = "opinion") %>% 
  filter(is.na(opinion) == FALSE)




# Cleaning candy_2017 -----------------------------------------------------

candy_2017_trimmed <- candy_2017 %>% 
  mutate(year = 2017, .before = internal_id) %>% 
  select(year:q6_york_peppermint_patties,
         -internal_id,
         -q2_gender,
         -q5_state_province_county_etc) %>% 
  rename(going_tot = q1_going_out,
         age = q3_age,
         country = q4_country) %>% 
  mutate(age = as.numeric(age)) %>% 
  filter(age <= 90) %>%
  relocate(age, .before = going_tot) %>% 
  pivot_longer(cols = q6_100_grand_bar:q6_york_peppermint_patties,
               names_to = "candy_type",
               values_to = "opinion") %>% 
  filter(is.na(opinion) == FALSE)
  



