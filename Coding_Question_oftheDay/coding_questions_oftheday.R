# Coding Question of the Day
# 9/26/2024
# Using the gapminder dataset, calculate the mean fertility rate by region for 
# the year 2015. Which 10 regions had the largest fertility rates that year?
# Assume there is no missing data. The following steps may be helpful.
# 1. Filter the data to only include the year 2015
# 2. Group by region
# 3. Calculate the average fertility rate for each region
# 4. Display the top 10 fertility rates (i.e., the 10 largest fertility rates)

library(dslabs)
library(dplyr)
data(gapminder)

region_fertility_rates <- gapminder %>%
  filter(year == 2015) %>%
  group_by(region) %>%
  summarise(avg_fertility_rate = mean(fertility)) %>%
  arrange(desc(avg_fertility_rate)) %>%
  top_n(10)

region_fertility_rates

# 10/01/2024
# Using the gapminder dataset, for the year 2000, add a column to the dataset 
# called `high_life_exp` that is equal to 1 if the life expectancy is above 
# 70 years of age and 0 otherwise. How many countries had a life expectancy 
# above 70 years in 2000? What percentage of countries included in the dataset 
# is this? Hint: it might be useful to use the ifelse function

library(dslabs)
library(dplyr)
data(gapminder)

gapminder_2000 <- gapminder %>%
  filter(year == 2000) %>%
  mutate(high_life_exp = ifelse(life_expectancy > 70, 1, 0))

# Sum the number of countries with life expectancy above 70
sum(gapminder_2000$high_life_exp)

# Percentage calculation
dim(gapminder_2000) # Show the number of countries in the dataset to get denominator

100/185 # 54%

# Another way to do the calculation
sum(gapminder_2000$high_life_exp) / length(gapminder_2000$high_life_exp)

#-------------------------------------------------------------------------------------------
# 10/03/2024
# Using the gapminder dataset and ggplot, for the year 1986, plot fertility on 
# the x-axis and life_expectancy on the y-axis. Color the points according to 
# continent, and make the size of the points correspond to the population of the 
# country. Update the x and y axis labels to be more informative. The arguments 
# color and size will be useful inside of ggplot. Note: you will most likely
# get ugly legends - don't worry about that right now. 

library(dslabs)
library(dplyr)
library(ggplot2)
data(gapminder)

gapminder %>% filter(year == 1986) %>%
  ggplot(aes(x = fertility, y = life_expectancy, color = continent, size = population)) +
  geom_point() +
  xlab("Fertility (Average number of children per woman)") +
  ylab("Life expectancy (Years)")


#-------------------------------------------------------------------------------------------
# 10/08/2024
# The dslabs package contains the us_contagious_disease dataset. This dataset 
# includes weekly reported counts data (cases) for seven diseases from 1928 to 
# 2011 for all 50 US states. Use this dataset and dplyr tools to create an 
# object called data that stores only the Measles data, includes a per 100,000 
# people rate, and removes Alaska and Hawaii since they only became states in 
# the late 1950s. Note there is a weeks_reporting column - take this into 
# account when calculating the rate. There are 52 weeks in a year.

library(dslabs)
library(dplyr)
data("us_contagious_diseases")


