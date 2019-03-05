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

# 3 or more dimenstions (3 + variables) -----------------------------------

ggplot(NHANES, aes(x = BMI, y = BPSysAve,
                    colour = HomeOwn)) +
    geom_point()

ggplot(NHANES, aes(x = BMI, y = BPSysAve,
                   colour = HomeOwn)) +
    geom_smooth() +
    facet_grid(cols = vars(Gender))

ggplot(NHANES, aes(x = BMI, y = BPSysAve,
                   colour = HomeOwn)) +
  geom_smooth() +
  facet_grid(rows = vars(Gender))


colour_plot_nums <- NHANES %>%
    ggplot(aes(x = BMI, y = BPSysAve,
               colour = HomeOwn))
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


# Themes, titles, labels --------------------------------------------------

basic_scatterplot <- NHANES %>%
  ggplot(aes(x = Height, y = Weight,
             colour = Age)) +
  geom_point(alpha = 0.5) +
  facet_grid(cols = vars(Gender)) +
  scale_colour_viridis_c()

basic_scatterplot +
  theme_bw()

basic_scatterplot +
  theme_classic()

basic_scatterplot +
  theme_minimal()

basic_scatterplot +
  labs(title = "This is the plot",
       y = "Weight (kg)",
       x = "Height (cm)") +
  theme ()

basic_scatterplot +
  labs(title = "This is the plot",
       y = "Weight (kg)",
       x = "Height (cm)") +
  theme (panel.background = element_rect(fill = "pink"),
         strip.background = element_rect(fill = "purple"))

prettied_plot <- basic_scatterplot +
  labs(title = "This is the plot",
       y = "Weight (kg)",
       x = "Height (cm)") +
  theme (panel.background = element_rect(fill = "pink"),
         strip.background = element_rect(fill = "purple"),
         legend.text = element_text(size = 20,
                                    color = "magenta"))

ggsave(here::here("doc/prettied_plot.png"),
       prettied_plot)
