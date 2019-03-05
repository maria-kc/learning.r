source(here::here(R/package-loading))
source(here::here(R/package-loading.R))
source(here::here("R/package-loading.R"))

# 1 dimension plots (1 variable) -------------------------------------------------------

ggplot(NHANES, aes(x = BMI)) +
  geom_density()

ggplot(NHANES, aes(x = BMI)) +
  geom_histogram()

ggplot(NHANES, aes(x = Education)) +
  geom_bar() #i dette tilfælde giver det mening at bruge et bar-plot. Det giver mening, da der er tale om 'tal' med et naturligt nul
# Man skal dog passe på med bar-plot, da folk opfatter 'areal'.


# 2 dimension plots (2 variables) -------------------------------------------------------

#two numeric variables
two_nums <- ggplot(NHANES, aes(x = Age, y = BPSysAve
                               ))
two_nums +
  geom_point()

two_nums +
  geom_line()

two_nums +
  geom_hex()

two_nums +
  geom_smooth()

# two categorical variables
two_categ <- ggplot(NHANES, aes( x = Education,
                                 fill = Diabetes))
two_categ +
  geom_bar()

two_categ +
  geom_bar(position = position_dodge())

two_mixed <- ggplot(NHANES, aes(x = Diabetes,
                                y = TotChol))

two_mixed +
  geom_boxplot()

# Hvis man gerne vil fjene NA fra sin figur
NHANES %>%
  filter(!is.na(Diabetes)) %>%
  ggplot(aes(x = Diabetes, y = TotChol)) +
  geom_boxplot()

two_mixed +
  geom_jitter() #anbefales kun hvis man ikke har meget data
                #ved jitter kan man se, at der er mere end en prik per udfald



