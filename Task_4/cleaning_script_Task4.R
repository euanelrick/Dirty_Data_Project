# Task 4 cleaning script


# Loading in packages -----------------------------------------------------
library(naniar)

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
  mutate(year = as.numeric(year)) %>% 
  mutate(age = as.numeric(age)) %>% 
  mutate(country = NA, .after = going_tot) %>% 
  filter(age <= 120) %>% 
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
  mutate(year = as.numeric(year)) %>% 
  mutate(age = as.numeric(age)) %>% 
  filter(age <= 120) %>% 
  relocate(age, .before = going_tot) %>% 
  pivot_longer(cols = "100_grand_bar":york_peppermint_patties,
               names_to = "candy_type",
               values_to = "opinion") %>% 
  filter(is.na(opinion) == FALSE) %>% 
  mutate(country = str_to_lower(country)) %>% 
  mutate(country = str_replace_all(country, "[[:punct:]]", ""))


# Cleaning country column for 2016 data -----------------------------------



candy_2016_trimmed <- 
candy_2016_trimmed %>% 
  mutate(country = case_when(
    country %in% c("usa", "us", "united states of america", "united states",
                    "murica", "america", "units states", "usa usa usa", 
                   "the best one  usa", "the yoo ess of aaayyyyyy", "eua",
                   "usa usa", "united sates", "merica", "united stetes",
                   "usa usa usa usa", "united  states of america",
                   "united state"
                   ) == TRUE ~ "US",
    
    country %in% c("uk", "england", "united kingdom", "united kindom" 
                   ) == TRUE ~ "UK",
    
    country %in% c("canada") == TRUE ~ "Canada",
    
    is.na(country) ~ as.character(NA),
    
    TRUE ~ "Other"
  ))


# Cleaning candy_2017 -----------------------------------------------------

candy_2017_trimmed <- candy_2017 %>% 
  mutate(year = 2017, .before = internal_id)%>% 
  mutate(year = as.numeric(year)) %>% 
  select(year:q6_york_peppermint_patties,
         -internal_id,
         -q2_gender,
         -q5_state_province_county_etc) %>% 
  rename(going_tot = q1_going_out,
         age = q3_age,
         country = q4_country) %>% 
  mutate(age = as.numeric(age)) %>% 
  filter(age <= 120) %>%
  relocate(age, .before = going_tot) %>% 
  pivot_longer(cols = q6_100_grand_bar:q6_york_peppermint_patties,
               names_to = "candy_type",
               values_to = "opinion") %>% 
  filter(is.na(opinion) == FALSE) %>% 
  mutate(candy_type = str_remove(candy_type, "^(q6_)")) 


# Cleaning country column in 2017 data ------------------------------------


candy_2017_trimmed$country <-  str_to_title(candy_2017_trimmed$country)

candy_2017_trimmed <- 
  candy_2017_trimmed %>% 
  mutate(country = case_when(
    country %in% c("Usa", "US", "Murica", "United States", "United Staes",
                   "United States Of America", "U.s.a", "Usausausa", "America",
                   "Us Of A", "Unites States", "The United States", "North Carolina",
                   "U S", "U.s.", "The United States Of America", 
                   "Usa? Hard To Tell Anymore..", "'Merica", "Pittsburgh",
                   "United State", "New York", "Trumpistan", "United Sates",
                   "California", 
                   "I Pretend To Be From Canada, But I Am Really From The United States.",
                   "New Jersey", "United Stated", "United Statss", "Murrika",
                   "N. America", "Ussa", "U S A", "United Statea", "Usa Usa Usa!!!!")
    == TRUE ~ "US",
    
    country %in% c("Canada", "Can", "Canada`") == TRUE ~ "Canada",
    
    country %in% c("Uk", "United Kingdom", "England", "Scotland") == TRUE ~ "UK",
    
    is.na(country)  ~ as.character(NA),
    
    TRUE ~ "Other"
    
  ))

  

# Binding tables  ---------------------------------------------------------

clean_candy <- bind_rows(candy_2015_trimmed, candy_2016_trimmed, candy_2017_trimmed)
  

clean_candy <- clean_candy %>%
  mutate(candy_type = recode(candy_type, "sweetums_a_friend_to_diabetes" = "sweetums",
         "sourpatch_kids_i_e_abominations_of_nature" = "sourpatch_kids",
         "licorice_not_black" = "licorice",
         "licorice_yes_black" = "licorice",
         "jolly_rancher_bad_flavor" = "jolly_rancher",
         "jolly_ranchers_good_flavor" = "jolly_rancher",
         "boxo_raisins" = "box_o_raisins",
         "anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes"
         = "anonymous_brown_globs_that_come_in_black_and_orange_wrappers",
         "bonkers_the_candy" = "bonkers",
         "third_party_m_ms" = "regular_m_ms",
         "green_party_m_ms" = "regular_m_ms",
         "independent_m_ms" = "regular_m_ms",
         "smarties_american" = "smarties",
         "smarties_commonwealth" = "smarties",
         "blue_m_ms" = "regular_m_ms",
         "m_ms" = "regular_m_ms",
         "red_m_ms" = "regular_m_ms",
         "tolberone_something_or_other" = "toblerone",
         "chick_o_sticks_we_don_t_know_what_that_is" = "chick_o_sticks",
         "sandwich_sized_bags_filled_with_boo_berry_crunch" = "boo_berry_crunch"
         )) 


clean_candy <- clean_candy %>% 
  filter(
    !candy_type %in% c("brach_products_not_including_candy_corn",
                       "vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein",
                       "cash_or_other_forms_of_legal_tender",
                       "dental_paraphenalia",
                       "generic_brand_acetaminophen",
                       "glow_sticks",
                       "broken_glow_stick",
                       "creepy_religious_comics_chick_tracts",
                       "healthy_fruit",
                       "hugs_actual_physical_hugs",
                       "lapel_pins",
                       "joy_joy_mit_iodine",
                       "pencils",
                       "peterson_brand_sidewalk_chalk",
                       "vicodin",
                       "white_bread",
                       "whole_wheat_anything",
                       "bonkers_the_board_game",
                       "chardonnay",
                       "person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes",
                       "abstained_from_m_ming",
                       "real_housewives_of_orange_county_season_9_blue_ray",
                       "minibags_of_chips"
                            ))
  


