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


#-------------------------------------------------------------------------------

# 10/24/2024

# Using the gapminder dataset, create a new data frame with only the country, 
# year, life_expectancy, and fertility columns. Use the pivot_longer() function 
# to reshape the dataset so that the life_expectancy and fertility columns are 
# combined into a single value column called "value". The column names should be
# stored in a new column called "health_indicator".

# Load necessary libraries
library(dslabs)
library(tidyr)
library(dplyr)

# Load the gapminder dataset
data("gapminder")

# Select only a few columns for simplicity
gapminder_subset <- gapminder %>%
  select(country, year, life_expectancy, fertility)

# Use pivot_longer to reshape the dataset
gapminder_long <- gapminder_subset %>%
  pivot_longer(cols = c(life_expectancy, fertility), 
               names_to = "health_indicator", 
               values_to = "value")

# View the reshaped data
head(gapminder_long)

#-------------------------------------------------------------------------------

# 10/29/2024

# Using the murders dataset from the dslabs package and the state.x77 dataset
# that is built in to R, make a scatterplot with the total number of gun murders
# (total) on the y-axis and land area in square miles (Area) on the x-axis. You
# will need to use the left_join function to join the state.x77 dataset to the 
# murders dataset using the state column. 

# Bonus challenge: are there any NAs in the merged dataset? How are they created?

# Load necessary libraries
library(dplyr)
library(dslabs)
library(ggplot2)
library(tidyr)

# Load the state.x77 dataset and convert to a data frame
data("state")
state_data <- as.data.frame(state.x77)

# Add the state names to the state.x77 dataset
state_data$state <- rownames(state_data)

head(state_data)

# Load the murders dataset from the dslabs package
data("murders")

# Use the left_join function to join the datasets by the state column
merged_data <- left_join(murders, state_data, by = "state")

# Plot area on x-axis and total number of murders on y-axis
merged_data %>% ggplot(aes(x = Area, y = total)) +
  geom_point() +
  labs(x = "Land area in square miles",
       y = "Total number of gun murders",
       title = "Number of gun murders vs land area across the US states")

# Bonus challenge
# Are there any NAs in the merged data set?
sum(is.na(merged_data)) # Yes, there are 8 NAs in the dataset

# Locate the row with NAs
merged_data[!complete.cases(merged_data),]

# All of the NAs are in the District of Columbia row. All of the values from the
# state.x77 dataset are missing. This means that the state.x77 dataset did not
# contain a row for District of Columbia, which resulted in NA values when 
# joined to the murders dataset.

#-------------------------------------------------------------------------------

# 10/31/2024

# Using the gapminder dataset, first remove all rows with missing gdp data 
# (code included below). Then, create 2 separate data frames: one containing 
# data just from the year 1975 and one containing data just from the year 1995. 
# Then create one dataset containing data about countries that appear in both 
# the 1975 and 1995 datasets, and one dataset containing data from countries 
# that only appear in the 1995 dataset.

# Bonus challenge: Create a bar plot summarizing the number of countries on 
# each continent that are in the dataset containing data about countries that 
# only appear in the 1995 dataset.

library(dplyr)
library(dslabs)
library(ggplot2)
library(tidyr)

data("gapminder")

# Drop all rows with NA (missing data) for gdp
gapminder <- gapminder %>% drop_na(gdp)

# Create a dataset with data just from the year 1975
gapminder_1975 <- gapminder %>% filter(year == "1975")

# Create a dataset with data just from the year 1995
gapminder_1995 <- gapminder %>% filter(year == "1995")

# Check how many rows are in each dataset
dim(gapminder_1975)
dim(gapminder_1995)

# Use the inner_join function to keep data for countries common to both datasets
common_to_both <- inner_join(gapminder_1975, gapminder_1995, by = "country")
head(common_to_both)

# Use the anti_join function to keep data for countries that appear in the 1995
# dataset, but not the 1975 dataset
just_in_1995 <- anti_join(gapminder_1995, gapminder_1975, by = "country")
head(just_in_1995)

# Bonus challenge: Create a bar plot summarizing the number of countries on 
# each continent that are in the dataset we created using the anti_join function 

just_in_1995 %>% ggplot(aes(x = fct_infreq(continent), fill = continent)) + # The fct_infreq function acts like the reorder function and reorders according to how many countries are on each continent
  geom_bar(color = "black") +
  labs(x = "", y = "Number of countries") +
  coord_flip() + # Flip the x and y axes so the continent names are on the y axis and easier to read
  guides(fill = "none") + # Remove the legend since it isn't needed
  geom_text(aes(label = after_stat(count)), stat = "count", hjust = 1.5) # add number of countries at the end of each bar for easier/faster interpretation


#-------------------------------------------------------------------------------

# 11/5/2024

# A link to a dataset available on GitHub was sent out in a Canvas announcement.
# The data comes from the Johns Hopkins University COVID-19 data repository. 
# This particular dataset is called "who_covid_19_sit_rep_time_series.csv" and 
# contains reported COVID-19 case counts from countries around the globe from 
# January 22, 2020 to March 23, 2020. 

# Read in the data using the code provided in the Canvas announcement.
# This dataset is currently in wide format. Convert the data frame to long format,
# with a column named date and a column named cases. Then, make the date column
# values into date objects. 

# Bonus challenge: rename the Country/Region column country. Create a new data
# frame with country name, date, and the total number of cases in the country on 
# each day.

library(readr)
library(dplyr)
library(tidyr)
library(lubridate)

data <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/refs/heads/master/archived_data/archived_time_series/time_series_19-covid-Recovered_archived_0325.csv")
head(data)

data_long <- data %>% 
  pivot_longer("1/22/20":"3/23/20", names_to = "date", values_to = "cases") %>%
  mutate(date = mdy(date))

data_long_country <- data_long %>% 
  rename(country = "Country/Region") %>% 
  group_by(country, date) %>%
  summarize(cases = sum(cases))

#-------------------------------------------------------------------------------

# 11/7/2024

# The data frame we created on Tuesday (11/5) contains a column called cases. 
# The values of this column are the cumulative number of reported cases in a
# particular country on a particular day. Use the lag function to add a new 
# column to the data frame that is the number of new cases for each day. For 
# example, if there were 10 reported cases on January 22nd and 15 reported cases 
# on January 23rd, the number of new cases would be 5 (15-10). Name this column 
# new_cases.

# Bonus challenge: create a new column that contains the seven-day rolling 
# average of new cases. Name this column new_cases_7dayavg. I would suggest
# using the rollmean function from the zoo package. 

# This code is from the 11/5 coding question of the day --------
library(readr)
library(dplyr)
library(tidyr)
library(lubridate)

data <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/refs/heads/master/archived_data/archived_time_series/time_series_19-covid-Recovered_archived_0325.csv")
head(data)

data_long <- data %>% 
  pivot_longer("1/22/20":"3/23/20", names_to = "date", values_to = "cases") %>%
  mutate(date = mdy(date))

data_long_country <- data_long %>% 
  rename(country = "Country/Region") %>% 
  group_by(country, date) %>%
  summarize(cases = sum(cases))

# This is new code for today's coding question --------
library(zoo)

# Calculate new cases
data_long_country <- data_long_country %>% 
  group_by(country) %>%
  arrange(date) %>% # Put rows in chronological order
  mutate(new_cases = cases - lag(cases)) %>%
  ungroup()

# Calculate 7-day rolling average of new cases
data_long_country <- data_long_country %>% 
  group_by(country) %>%
  arrange(date, .by_group=TRUE) %>%  # Put rows in chronological order
  mutate(new_cases_7dayavg = rollmean(new_cases, k = 7, fill = NA)) %>%
  ungroup()


#-------------------------------------------------------------------------------

# 11/12/2024

# Using the gapminder dataset and the world map data frame in the maps package, 
# plot the 2016 life expectancy across countries. Note that you will need to 
# join the two data frames, and that the region column in the world map data
# corresponds to the country column in the gapminder data.

# Bonus challenge: why are some of the countries gray? Give 2 reasons.

library(dplyr)
library(ggplot2)
library(tidyr)
library(dslabs)
library(maps)

# Read in gapminder data and save world map data as a data frame
data("gapminder")
world_map <- map_data("world")

# Filter to only include data from the year 2016
gapminder_life <- gapminder %>% filter(year == "2016") %>%
  select(country, life_expectancy) # Optional: I do this to keep only the columns I need

# Join the two data frames
full_df <- left_join(world_map, gapminder_life, by = c("region" = "country"))

# Create a world map plot with countries filled in based on their life expectancy
full_df %>% ggplot(aes(x = long, y = lat, group = group, fill = life_expectancy)) +
  geom_polygon(color = "white") +
  theme(panel.grid.major = element_blank(), # Remove gray background and grid and axis lines
        panel.background = element_blank(),
        axis.title = element_blank(), 
        axis.text = element_blank(),
        axis.ticks = element_blank()) + 
  scale_fill_viridis_c(name = "Life Exp. \n(years)", option = "inferno") + # Another option for color scale
  labs(title = "Global Life Expectancy in 2016") +
  coord_fixed(1.3)


# Some of the countries are gray because we either don't have data in the gapminder 
# dataset for those countries, or because the names of those countries don't 
# match for the maps data and gapminder data, or both. For example, in the gapminder 
# dataset, the United States is labeled as "United States", but in the maps 
# dataset it is labeled as "US". 

# The countries that are missing life expectancy data in the gapminder dataset
# include Somalia, Congo, Western Sahara, Afghanistan, Kyrgyzstan, Myanmar (Burma),
# North Korea, and French Guiana.

# To fix the problem with mismatching country names, we can use the case_when() 
# function. Here we use it to rename the countries in the gapminder dataset so
# they match the names of the countries in the world map data frame.

gapminder_life <- gapminder %>% 
  filter(year == "2016") %>%
  mutate(country = case_when(country == "United States" ~ "USA",
                             country == "United Kingdom" ~ "UK",
                             country == "Lao" ~ "Laos",
                             country == "Congo, Dem. Rep." ~ "Democratic Republic of the Congo",
                             country == "Cote d'Ivoire" ~ "Ivory Coast",
                             TRUE ~ country))

full_df <- left_join(world_map, gapminder_life, by = c("region" = "country"))

full_df %>% ggplot(aes(x = long, y = lat, group = group, fill = life_expectancy)) +
  geom_polygon(color = "white") +
  theme(panel.grid.major = element_blank(), 
        panel.background = element_blank(),
        axis.title = element_blank(), 
        axis.text = element_blank(),
        axis.ticks = element_blank()) + 
  scale_fill_viridis_c(name = "Life Exp. \n(years)", 
                       option = "inferno") + 
  labs(title = "Global Life Expectancy in 2016") +
  coord_fixed(1.3)

#-------------------------------------------------------------------------------
# 12/3/2024

# Using the gapminder dataset, fit a logistic regression ML model that predicts 
# fertility (low vs high) using life expectancy as a predictor and data from the 
# year 1970 only. Print the confusion matrix and report the overall accuracy, 
# sensitivity, and specificity. 

# The code that categorizes fertility into low (fertility <= 4) and high 
# (fertility > 4) groups, with 0 indicating low fertility and 1 high fertility, 
# has been provided. The training and test sets using 70% of the data for the 
# training set and 30% for the test set have also been coded for you.

library(dplyr)
library(ggplot2)
library(caret)
library(dslabs)

data(gapminder)
set.seed(9)

gapminder_1970 <- gapminder %>% 
  filter(year == 1970) %>%
  mutate(fertility_cat = ifelse(fertility <= 4, 0, 1))

y <- gapminder_1970$fertility_cat

train_index <- createDataPartition(y, times = 1, p = 0.7, list = FALSE) # Partition data 

train_set <- gapminder_1970[train_index, ] # Create training set
test_set <- gapminder_1970[-train_index, ] # Create test set
  
# Fit logistic regression model
glm_fit <- glm(fertility_cat ~ life_expectancy, data = train_set, family = "binomial")

# Calculate predicted probabilities
p_hat_logit <- predict(glm_fit, newdata = test_set, type="response")

# Create predictions of "low" or "high" fertility using 0.5 probability cutoff
# (if predicted probability is > 0.5, predict "high")
y_hat_logit <- ifelse(p_hat_logit > 0.5, 1, 0)

# Print confusion matrix to view evaluation metrics
confusionMatrix(data = as.factor(y_hat_logit), 
                reference = as.factor(test_set$fertility_cat), positive = '1')

# Confusion Matrix and Statistics

# Reference
# Prediction  0  1
#  0          17 2
#  1          3 33

# Accuracy : 0.9091          
# Sensitivity : 0.9429          
# Specificity : 0.8500 



