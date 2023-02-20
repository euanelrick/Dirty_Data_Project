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








