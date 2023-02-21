---
editor_options: 
  markdown: 
    wrap: 72
---

# Dirty_Data_Project

## Task 3

### cleaning_script_task_3.R

This file is an R script designed to read in the raw data about ships
and bird observations, and then clean the data so it can be analysed.

The raw data consisted of four sheets in an .xls file. The first sheet
gave information about an individual ships location, speed, date, time,
activity and weather. The second sheet gave information about the
species of bird, age, gender, number spotted, plumage, and how they were
spotted (flying, floating etc). The other two sheets contained text
descriptions of the abbreviations used in the columns of the first two
sheets.

From this raw data, I standardised names into snakecase style, and
selected columns I felt would be useful in analysis. From the bird data
I selected: record, record id, species name, species abbreviation, and
the count. From the ship data I selected: record id, latitude, and
longitude. I then joined these two tables by the record id.

My analysis was focussed on count of birds so I removed rows where the
count was 0 or NA.

Some of the species abbreviations had a small abbreviation to signify
the age of the bird which I also removed as I was interested in species
as a whole.

I then wrote the clean data as a .csv file to use in analysis.


### analysis_task_3.Rmd

This file is an R notebook in which I performed various analysis on the 
previously cleaned data.

After the clean data was loaded in and assigned to a dataframe I began analysis.

My first question was looking at which species had been sighted on the most 
individual occasions. From my analysis I found that the wandering albatross
was the bird that had the most individual sightings, with a count of 5632.

My next question was looking at which bird had the highest total count over all 
of its sightings. From the data I found that the Short-Tailed Shearwater had
the highest total count of 982553. Initially I felt this data could be 
suspicious, however, looking online at information on the species it is highly 
plausible this is accurate, it would maybe be worth contacting the provider of
this data for more information

I then looked at the highest count when the latitude was above -30. This lead
to the Wedge-Tailed Shearwater being the highest counted species at only 855
total counts. This is interesting as when compared to the previous question it 
highlights perhaps a focus on one area of the globe in the data, which was maybe 
timed with a mass migration of Short-Tailed Shearwater

I looked at birds which were only ever seen in groups of one and found that 
there were 23 distinct species that were only spotted alone, out of 152 distinct
species across the data.

I then looked at the amount of penguins observed in the data and found that 158
penguins were observed.





## Task 4

### cleaning _script_task_4.R

This file is an R script for cleaning the three different datasets in the 
raw_data folder and bind them into one dataset to be used in analysis

Each data set was very messy and required a lot of cleaning as seen in the 
script. I had to make the columns uniform in all of them so they could be 
binded correctly. And i removed any rows where an opinion hadnt been given to a 
candy. There was some particularly messy values in the countries
column which required 'hard-coding'. When the tables were binded I removed all 
the values in the candy_type column that weren't actually candy, and i combined
certain candy types if they had been written differently across the three 
years.



### analysis_task_4.Rmd

My first question was to look at how many candy ratings had been given out over 
the three years. As I had already removed any NAs from the opinion column I 
was able to simply add up how many rows were in that column and got an answer
of 589655 ratings given

I then looked at the average age of people who went trick or treating and found
a median age of 38 and a median age of 35.4.

For those who didn't go trick or treating the median age was also 38, but the 
average age was 39.3

For the opinion the distinct values in the column were "Joy", "Meh", and 
"Despair", depending on how the person filling out the table felt about each
respective candy. I looked to see which candies received the most of each of 
these ratings. For "joy" and "meh"it was regular m&ms which received the most,
and for "despair" it was jolly ranchers which received the most.

I looked at breaking down how many of each distinct opinion had been given for
Starburst candy, and found that 4849 people put "joy", 1046 people put "meh",
and 1867 people put "despair".

After this I created a new table which was designed to rank the candies with a 
numeric system based on the previous word ranking system.

I used this system to find out how candy had been rated across the various 
genders in the table. I found that for all genders regular m&ms were the most 
popular candy

I then used the system to see which were the most popular candies across each of
the three years in the table and found that in 2015 the most popular candy was
"any full sized candy bar", and in 2016. and 2017 the most popular candy was 
regular m&ms

Finally I broke the table down by country and found the most popular candy in
the US, the UK, Canada, and all the other countries combined was regular m&ms








