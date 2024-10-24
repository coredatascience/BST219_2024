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

data <- us_contagious_diseases %>%
  filter(!state %in% c("Hawaii","Alaska"),
         disease == "Measles") %>%
  mutate(rate = (count / weeks_reporting) * 52 / (population / 100000))


#-------------------------------------------------------------------------------------------


# 10/10/2024
# Using the gapminder dataset, create a line graph of life_expectancy over time 
# for the country Haiti. Make sure to include informative axis labels and a title.
# There is a substantial decrease in life expectancy one year - look up the reason 
# for this if you don't know it already. Add text to your plot with geom_text 
# indicating the event that happened that year that had such a drastic impact on 
# life expectancy.

library(dslabs)
library(dplyr)
data("gapminder")

gapminder %>% filter(country == "Haiti") %>%
  ggplot(aes(year, life_expectancy)) +
  geom_line() +
  geom_vline(xintercept = 2010, lty = 2, color = "blue") +
  geom_text(aes(x = 2003, y = 34, label = "2010 Earthquake"), color = "blue") +
  xlab("Year") +
  ylab("Life Expectancy (Years)") +
  ggtitle("Life expectancy in Haiti")


#-------------------------------------------------------------------------------------------


# 10/15/2024

# Using the murders dataset, create a plot of murder rates per 100,000 with 4 boxplots next 
# to each other - one boxplot for each region. Order the boxplots by median rate
# (you will need the reorder function for this). Make sure the boxplots are
# different colors, the axes are informative, and you add a title. Remove the 
# legend by adding this layer to your plot: guides(fill = "none")

library(dslabs)
library(dplyr)
library(ggplot2)
data("murders")

murders %>% mutate(rate = total / population * 100000,
                   region = reorder(region, rate, FUN = median)) %>%
  ggplot(aes(x = region, y = rate, fill = region)) +
  geom_boxplot() +
  scale_x_discrete(aes(name = region)) +
  xlab("Region") +
  ylab("Murder rate per 100,000 persons") +
  ggtitle("2010 Gun Murder Rates Across US Regions") +
  guides(fill = "none") # removes legend since not needed here

  

#-------------------------------------------------------------------------------------------


# 10/17/2024

# Using the gapminder dataset, make a line graph of life expectancy over time.
# Include one line per country, and another line with the global average life
# expectancy. Be sure to label the global average line and to make it stick out
# among the country-specific lines. Use the code below to calculate the global
# average for each year.

# Hints: 
# 1. Use alpha to help make the global average line stick out.
# 2. Use 2 geom_line layers. 

library(dslabs)
library(dplyr)
library(ggplot2)
data("gapminder")

avg <- gapminder %>%
  group_by(year) %>%
  summarize(global_avg = mean(life_expectancy))

gapminder %>% 
  ggplot() +
  geom_line(aes(x = year, y = life_expectancy, group = country), color = 'darkgrey', alpha = 0.4) +
  geom_line(data = avg, mapping = aes(x = year, y = global_avg), linewidth = 1) +
  xlab("Year") +
  ylab("Life expectancy (Years)") +
  ggtitle("Life expectancy across countries") +
  annotate(geom = "text", x = 1970, y = 56, label = "Global average", fontface = "bold")
  #geom_text(x = 1980, y = 55, label = "Global Average")


# Heather was just curious :)
gapminder_94 <- gapminder %>% filter(year == "1994")
gapminder_94[which.min(gapminder_94$life_expectancy),] # Rwandan genocide

gapminder_77 <- gapminder %>% filter(year == "1977")
gapminder_77[which.min(gapminder_77$life_expectancy),] # Cambodian genocide



#-------------------------------------------------------------------------------

# 10/22/2024

# Using the gapminder dataset, create a categorical life expectancy variable
# and add it to the gapminder dataset. Call this variable life_expectancy_category
# and use the case_when function to create it. Life expectancy below 50 should be 
# labeled "Low", life expectancy greater than or equal to 50 and less than 75 
# should be labeled "Medium", and life expectancy greater than or equal to 75 
# should be labeled "High".

# Now, filter the dataset to only include observations from the year 1999, and 
# create a bar chart of the 3 life expectancy categories. 

# Bonus challenge: Reorder the bars so that they are in the order Low, Medium, High.
# You can use whatever function you prefer or find online that works. 


# Load necessary libraries
library(dplyr)
library(dslabs)
library(ggplot2)

# Load the gapminder dataset
data("gapminder")

# Use case_when to create a new variable 'life_expectancy_category'
gapminder <- gapminder %>%
  mutate(life_expectancy_category = case_when(
    life_expectancy < 50 ~ "Low",
    life_expectancy >= 50 & life_expectancy < 75 ~ "Medium",
    life_expectancy >= 75 ~ "High"
  ))

# View the first few rows of the dataset
head(gapminder)

# Filter the dataset to the year 2015 and create a bar chart of life expectancy
# (Here I'm using another way to set the x and y axis labels and the plot title)

gapminder %>% filter(year == 1999) %>%
  ggplot(aes(x = life_expectancy_category)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Distribution of Life Expectancy Categories in 1999",
       x = "Life Expectancy Category",
       y = "Number of Countries")


# Bonus challenge: Reorder the bars so that they are in the order Low, Medium, High.
# I'm using the fct_relevel function from the forcats package. Install the package
# if you haven't already before loading it. 

# install.packages("forcats")
library(forcats)

gapminder %>% filter(year == 1999) %>%
  mutate(life_expectancy_category = factor(life_expectancy_category, levels = c("Low", "Medium", "High"))) %>% # another way to do it
  #mutate(life_expectancy_category = fct_relevel(life_expectancy_category, "Low", "Medium", "High")) %>%
  ggplot(aes(x = life_expectancy_category)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Distribution of Life Expectancy Categories in 1999",
       x = "Life Expectancy Category",
       y = "Number of Countries")





