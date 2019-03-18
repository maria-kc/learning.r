# load package
source(here::here("R/package-loading.R"))


# Summary Statistics ------------------------------------------------------


# Check column names
colnames(NHANES)

# Select the following variables: Sleep hours, alcohol consumption, Hard drugs, drugs smoking, marijuana
# and sexual partners

NHANES_assign <- NHANES %>%
  select(Age, SleepHrsNight, SmokeNow, Marijuana, SexNumPartYear, SexNumPartnLife, HardDrugs)


# To see values of categorical data
summary(NHANES_assign)




# Filter out rows with one or more missing values -------------------------


# List of rows with no missing values
which(complete.cases(NHANES_assign))

# List of rows with missing values
which(!complete.cases(NHANES_assign))

# Creating a vector with the rows with missing values
na_vec <- which(!complete.cases(NHANES_assign))

na_vec

# Creating a new dataset without rows with missing values
NHANES_assign_no_na <- NHANES_assign[-na_vec,]
NHANES_assign_no_na

# calculate mean of continuous variables

summary(NHANES_assign_no_na)

NHANES_assign_no_na %>%
  summarise(MeanSleep= mean(SleepHrsNight, na.rm = TRUE),
            MeanSexPartnersYear= mean(SexNumPartYear, na.rm = TRUE),
            MeanSexPartnersLife= mean(SexNumPartnLife, na.rm = TRUE))

# calculate mean of continuous variables by smoking, marijuana and hard drugs status

NHANES_assign_no_na %>%
  group_by(SmokeNow) %>%
  summarise(MeanSleep= mean(SleepHrsNight, na.rm = TRUE),
            MeanSexPartnersYear= mean(SexNumPartYear, na.rm = TRUE),
            MeanSexPartnersLife= mean(SexNumPartnLife, na.rm = TRUE))

NHANES_assign_no_na %>%
  group_by(Marijuana) %>%
  summarise(MeanSleep= mean(SleepHrsNight, na.rm = TRUE),
            MeanSexPartnersYear= mean(SexNumPartYear, na.rm = TRUE),
            MeanSexPartnersLife= mean(SexNumPartnLife, na.rm = TRUE))

NHANES_assign_no_na %>%
  group_by(HardDrugs) %>%
  summarise(MeanSleep= mean(SleepHrsNight, na.rm = TRUE),
            MeanSexPartnersYear= mean(SexNumPartYear, na.rm = TRUE),
            MeanSexPartnersLife= mean(SexNumPartnLife, na.rm = TRUE))


# Figures -----------------------------------------------------------------
ggplot(NHANES_assign_no_na, aes(x = Age, y = SleepHrsNight, title("Smoke, sleep and age")
                   colour = SmokeNow)) +
                    geom_point()


smoke_sleep_plot <- ggplot(NHANES_assign_no_na, aes(x = Age, y = SleepHrsNight)) +
  geom_smooth() +
  facet_grid(rows = vars(SmokeNow))

print(smoke_sleep_plot + ggtitle("Sleep by age and smoke status") +labs(y= "Sleep per nigh (hours)", x = "Age (years)"))

mar_sleep_plot <- ggplot(NHANES_assign_no_na, aes(x = Age, y = SleepHrsNight)) +
  geom_smooth() +
  facet_grid(rows = vars(Marijuana))

print(mar_sleep_plot + ggtitle("Sleep by age and marijuana status") +labs(y= "Sleep per nigh (hours)", x = "Age (years)"))








colour_plot_nums <- NHANES_assign_no_na %>%
  ggplot(aes(x = Age, y = Marijuana,
             colour = SleepHrsNight))
            colour_plot_nums +
            geom_point()

colour_plot_mixed <- NHANES %>%
  ggplot(aes(x = Gender, y = BPSysAve,
             colour = HomeOwn))
colour_plot_mixed +
  geom_boxplot()


colour_plot_nums +              #adding colour
  geom_point(aes(alpha = Age))

colour_plot_nums +              #adding size
  geom_point(aes(size = Age))

colour_plot_mixed +
  geom_boxplot() +
  facet_grid(cols = vars(SurveyYr),
             rows = vars(PhysActive))

#colour blind friendly colour palets
base_boxplot <- NHANES %>%
  ggplot(aes(x = HomeOwn, fill = Education)) +
  geom_bar(position = position_dodge())

base_boxplot +
  scale_fill_viridis_d()

base_boxplot +
  scale_fill_viridis_d(option = "A")

base_boxplot +
  scale_fill_brewer(type = "qual")



# Save the dataset


