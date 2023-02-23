# Cleaning script


# Loading packages --------------------------------------------------------

# install.packages("here")

library(tidyverse)

library(janitor)

library(readxl)

library(here)

library(stringr)

# Reading in seabirds data ------------------------------------------------

here()

seabirds_ships_data <- read_xls("raw_data/seabirds.xls", sheet = 1)

seabirds_birds_data <- read_xls("raw_data/seabirds.xls", sheet = 2)



# Getting a quick summary of data -----------------------------------------

glimpse(seabirds_birds_data) # 26 columns, 49019 observations. Lots to trim

glimpse(seabirds_ships_data) # 27 columns, 12310 observations. Lots to trim

colSums(is.na(seabirds_birds_data)) # Lots of NAs, most in columns i wont need

colSums(is.na(seabirds_ships_data)) # Lots of NAs, most in columns i wont need


# Cleaning names ----------------------------------------------------------

seabirds_birds_data <-  clean_names(seabirds_birds_data)

seabirds_ships_data <- clean_names(seabirds_ships_data)

# Trimming data -----------------------------------------------------------

birds_trimmed <- seabirds_birds_data %>%  # Keeping 'useful' columns for analysis
  select(record, 
         record_id, 
         species_common_name_taxon_age_sex_plumage_phase,
         species_abbreviation, 
         count)

ships_trimmed <- seabirds_ships_data %>% # Keeping useful data, removing 
                                          # duplicate of record id
  
  select(record_id, lat, long)
  

# Joining data together ---------------------------------------------------

ships_birds <- birds_trimmed %>% 
  left_join(ships_trimmed, by = "record_id") # joining ships data to birds data



# Removing rows where count = 0 or NA -------------------------------------


ships_birds <- ships_birds %>% 
  filter(count != 0) %>% 
  filter(is.na(count) == FALSE)



# Removing age abbreviation from species abbreviation ---------------------

ships_birds_clean <-  ships_birds %>% 
  mutate(species_abbreviation = str_extract(species_abbreviation, "(\\w+)"))


# Writing clean data as a .csv file ---------------------------------------




write_csv(ships_birds_clean, file = here("clean_data/ships_birds_clean.csv" ))



