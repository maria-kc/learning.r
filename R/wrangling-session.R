#load packages from the 'package-loading.R script'
source(here::here("R/package-loading.R"))

# TO get a glimpse of the dataset
glimpse(NHANES)

# An easier way to refer to the dataset duing analysis
NHANES <- NHANES
# To open the dataset in a new fane
view(NHANES)


# Become familar with the dataset -----------------------------------------
# Check column names
colnames(NHANES)

# Look at contents

str(NHANES)
glimpse(NHANES)


# See summary
summary(NHANES)

# Look over the dataset documentation
?NHANES


# Pipe operator -----------------------------------------------------------

#these two are the same
colnames(NHANES)
NHANES %>% colnames() #use of pipe operator

#standard R way if "chaining" functions together

glimpse(head(NHANES))

NHANES %>%
  head() %>%
  glimpse()


# mutate() function ---------------------------------------------------------

NHANES_changed <- NHANES %>%
  mutate(Height_meters = Height/100)

#create a new variable based on a condition
NHANES_changed <- NHANES_changed %>%
  mutate(Highly_Active = if_else(PhysActiveDays >= 5, "yes", "no"))

#create  or replace multiple variables by using ","
NHANES_changed <- NHANES_changed %>%
  mutate(new_column = "only one variable",
         Height = Height/100,
         UrineVolAverage = (UrineVol1 + UrineVol2)/2)


# select(): Select specific data by the variable--------------------------------------------------------
# Select columns/variables by name, without quotes
NHANES_characteristics <- NHANES %>%
  select(Age, Gender, BMI)

#To not select a variable, use minus (-)
NHANES %>%
  select(-HeadCirc)

#To select similar names, use "matching" functions
NHANES %>%
  select(starts_with("BP"),contains("Vol"))

?select_helpers


# rename(): Rename specific columns ---------------------------------------

#rename using the form: "newname = oldname"
NHANES %>%
  rename(NumberBabies = nBabies)


# filter(): Filtering/subsetting the data by row --------------------------

# when gender is equal to
NHANES %>%
  filter(Gender =="female")

# when gender is unequal to
NHANES %>%
  filter(Gender != "female")

# when BMI is equal to 25
NHANES %>%
  filter(BMI == 25)

# when BMI is < 25
NHANES %>%
  filter(BMI >= 25)

# when BMI is 25 and gender is female
NHANES %>%
  filter(BMI == 25 & Gender == "female")

# when BMI is 25 or gender is female
NHANES %>%
  filter(BMI == 25 | Gender == "female")



# arranging(): Sort/rearrange your data by columns ------------------------

# ascending order order
NHANES %>%
  arrange(Age) %>%
  select(Age)

# order descending
NHANES %>%
  arrange(desc(Age)) %>%
  select(Age)

# order by age and gender
NHANES %>%
  arrange(Age, Gender) %>%
  select(Age, Gender)


# group_by(), summarise(): Create summary of the data, alone or by a group(s) ----------------------

# summarise () by itself
NHANES %>%
  summarise(MaxAge = max(Age, na.rm = TRUE),
            MeanBMI = mean(BMI, na.rm = TRUE))

# combine with group_by()
NHANES %>%
    group_by(Gender, Diabetes) %>%
    summarise(MaxAge = max(Age, na.rm = TRUE),
              meanBMI = mean(BMI, na.rm = TRUE))


# gather(): Converting from wide to long form -----------------------------

table4b
table4b %>%
  gather(key = year, value = population, -country)

table4b %>%
  gather(key = year, value = population, '1999', '2000')

# keep only varaibles of interest
nhanes_char <- NHANES %>%
  select (SurveyYr, Gender, Age, Weight, Height, BMI, BPSysAve)

nhanes_char


#convert to long form, excluding year gender
nhanes_long <- nhanes_char %>%
  gather(Measure, Value, -SurveyYr, -Gender)
nhanes_long

# calculate mean on each measure, by gender and year
nhanes_long %>%
  group_by(SurveyYr, Gender, Measure) %>%
  summarise(MeanValues = mean(Value, na.rm = TRUE))

