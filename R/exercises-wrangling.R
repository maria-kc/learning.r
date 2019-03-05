#load packages from the 'package-loading.R script'
source(here::here("R/package-loading.R"))

# Load the packages
library(tidyverse)
library(NHANES)



# Exercise: Piping transoforming and adding -------------------------------

# Create a new variable called “UrineVolAverage” by calculating the average urine volumne (from “UrineVol1” and “UrineVol2”).
#See above

# Modify/replace the “Pulse” variable to beats per second (currently is beats per minute).
NHANES_changed <- NHANES_changed %>%
  mutate(new_column = "only one variable",
         Height = Height/100,
         UrineVolAverage = (UrineVol1 + UrineVol2)/2,
         Pulse_sec = Pulse/60)

# Create a new variable called “YoungChild” when age is less than 6 years.
NHANES_modified <- NHANES %>%
  mutate(new_column = "only one variable",
         Height = Height/100,
         UrineVolAverage = (UrineVol1 + UrineVol2)/2,
         Pulse_sec = Pulse/60,
         YoungChild = if_else(Age < 6, TRUE, FALSE)
  )


# Exercise: Filtering and logic, arranging and selecting ------------------


# Filter so only those with BMI more than 20 and less than 40 and keep only those with diabetes.
NHANES %>%
 filter(BMI > 20 & BMI < 40  & Diabetes == "Yes")

#Filter to keep those who are working (“Work”) or those who are renting (“HomeOwn”) and those who do not have diabetes. Select the variables age, gender, work status, home ownership, and diabetes status.
NHANES %>%
 filter(Work == "Yes" | HomeOwn =="Yes" & Diabetes == "No")


# Using sorting and selecting, find out who has had the most number of babies and how old they are.
NHANES %>%
  arrange(Measure, Gender, SurveyYr) %>%
  spread(SurveyYr, Mean)


