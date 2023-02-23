# Cleaning script for Task 2


# Loading packages --------------------------------------------------------

library(naniar)

library(tidyverse)

library(janitor)

library(readr)

library(here)

library(stringr)


# Loading in data ---------------------------------------------------------

cake_ingredients <- read_csv(here("raw_data/cake/cake-ingredients-1961.csv"))


cake_code <- read_csv(here("raw_data/cake/cake_ingredient_code.csv"))


# Cleaning ingredients table ----------------------------------------------

cake_ingredients_longer <- cake_ingredients %>% 
  pivot_longer(!Cake,
               names_to = "ingredient",
               values_to = "amount")  # Pivoting longer to trim data
 

 cake_ingredients_longer <-  clean_names(cake_ingredients_longer) # cleaning names

 
 cake_ingredients_combined <- cake_ingredients_longer %>% 
   full_join(cake_code, by = c("ingredient" = "code")) # joining both tables

cake_clean <- cake_ingredients_combined %>% 
  select(cake, ingredient.y, amount, measure) %>% 
  rename("ingredient" = ingredient.y) %>% 
  drop_na() #Selecting columns i need, renaming ingredient.y, getting rid of 
              # columns where the cake didnt use that ingredient

cake_clean$cake <- cake_clean$cake %>% 
  str_to_lower() # making lowercase

cake_clean$ingredient <- cake_clean$ingredient %>% 
  str_to_lower() #making lowercase



# Writing cake_clean as a .csv file ---------------------------------------

write_csv(cake_clean, file = "clean_data/cake_clean.csv")






