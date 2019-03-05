# Exercise: Create plots with one or two variables


# 1 continuous variable.
# 1 discrete variable.
# 2 continuous variables.
# 2 discrete variables.
# 1 continuous and 1 discrete variable.

# See the variables available
names(NHANES)

# 1 continuous
ggplot(NHANES, aes(x = Weight)) +
  geom_density()

# 1 discrete
ggplot(NHANES, aes(x = SmokeNow)) +
  geom_bar()

# 2 continuous
ggplot(NHANES, aes(x = Weight, y = Height)) +
  geom_point()

# 2 discrete
ggplot(NHANES, aes(x = SmokeNow, fill = SexOrientation)) +
  geom_bar(position = position_dodge())

# 1 continous and 1 discrete
ggplot(NHANES, aes(x = SmokeNow, y = Weight)) +
  geom_boxplot()
