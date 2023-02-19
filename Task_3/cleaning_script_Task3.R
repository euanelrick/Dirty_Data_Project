# Cleaning script


# Loading packages --------------------------------------------------------

# install.packages("here")

library(tidyverse)

library(janitor)

library(readxl)

library(here)

# Reading in seabirds data ------------------------------------------------

here()

seabirds_ships_data <- read_xls("raw_data/seabirds.xls", sheet = 1)

seabirds_birds_data <- read_xls("raw_data/seabirds.xls", sheet = 2)



