---
title: "Homework 2"
date: "Due October 25, 2024 by 11:59pm EST"
output: html_document
---


Vaccines have helped save millions of lives. In the 19th century, before herd immunization was achieved through vaccination programs, deaths from infectious diseases, like smallpox and polio, were common. However, today, despite all the scientific evidence for their importance, vaccination programs have become somewhat controversial.

The controversy started with a [paper](http://www.thelancet.com/journals/lancet/article/PIIS0140-6736(97)11096-0/abstract) published in 1988 and lead by [Andrew Wakefield](https://en.wikipedia.org/wiki/Andrew_Wakefield) claiming 
there was a link between the administration of the measles, mumps and rubella (MMR) vaccine, and the appearance of autism and bowel disease. 
Despite much science contradicting this finding, sensationalist media reports and fear mongering from conspiracy theorists, led parts of the public to believe that vaccines were harmful. Some parents stopped vaccinating their children. This dangerous practice can be potentially disastrous given that the Center for Disease Control and Prevention (CDC) estimates that vaccinations will prevent more than 32 million hospitalizations and 1,129,000 deaths among children born in the last 30 years (see [Benefits from Immunization during the Vaccines for Children Program Era — United States, 1994-2023, MMWR](https://www.cdc.gov/mmwr/volumes/73/wr/mm7331a2.htm#:~:text=Among%20approximately%20117%20million%20children,%242.7%20trillion%20in%20societal%20costs.)). 

Effective communication of data is a strong antidote to misinformation and fear mongering. In this homework you are going to prepare a report to have ready in case you need to help a family member, friend or acquaintance that is not aware of the positive impact vaccines have had for public health.

The data used for these plots were collected, organized and distributed by the [Tycho Project](http://www.tycho.pitt.edu/). They include weekly reported counts data for seven diseases from 1928 to 2011, from all fifty states. We include the yearly totals in the `dslabs` package:

```{r}
library(dslabs)
data(us_contagious_diseases)
```

1. Use the `us_contagious_disease` dataset and `dplyr` tools to create an object called `data` that stores only the Measles data, includes a cases per 100,000 people rate, and removes Alaska and Hawaii since they only became states in the late 1950s. Note that there is a `weeks_reporting` column. Take that into account when computing the rate.

```{r}
## Your code here
```

2. Note these rates start off as counts. For larger counts we can expect more variability. There are statistical explanations for this which we don't discuss here, but transforming the data might help stabilize the variability such that it is closer across levels. 

For 1950, 1960, and 1970, first plot histograms of the disease rates across states **without** the square root transformation of the x-axis. (You should have 3 histograms, one for each year). 

Then, in a separate plot, plot histograms of the disease rates **with** the square root transformation of the x-axis. 
Which set of plots seems to have more similar variability across years? Make sure to pick binwidths that result in informative plots, i.e., don't make the histograms bars too wide or too narrow.

Note: you should be using `ggplot2` for all plotting in this homework and all future assignments.

```{r}
## Your code here
```


3. Plot the Measles disease rate per year for California. Find out when the Measles vaccine was introduced and add a vertical line to the plot to show this year. 

```{r}
## Your code here
```


4. Plot the Measles disease rate per year for California again, but now with the square root transformation of the y-axis. Make sure that the numbers $4,16,36, \dots, 100$ appear on the y-axis. Include a vertical line indicating the year the Measles vaccine was introduced. What is now easier to see with this plot compared to the plot in Question 3?

```{r}
## Your code here
```

5. Now, this is just California. Does the pattern hold for other states? Use boxplots to get an idea of the distribution of rates for each year, and see if the pattern holds across states. Keep the square root transformation of the y-axis. Does the pattern hold across states?

```{r}
## Your code here
```

6. One problem with the boxplots is that they don't let us see state-specific trends. Make a plot showing the trends for all states. Add the US average to the plot. Hint: Note there are missing values in the data. Tip: experiment with `color` and `alpha` to make the US average more apparent in your graph. 

```{r}
## Your code here
```

7. One problem with the plot above is that we can't distinguish states from each other. There are just too many. We have three variables to show: year, state, and rate. If we use the two dimensions to show year and state then we need something other than vertical or horizontal position to show the rates. Try using color. Hint: Use the the geometry `geom_tile` to tile the plot with colors representing disease rates. 

```{r}
## Your code here
```

8. The plots above provide strong evidence showing the benefits of vaccines: as vaccines were introduced, disease rates were reduced. But did autism increase? In the `autism_prevalence_CA.rData` file, you will find a data frame with yearly autism rates reported by the California Department of Developmental Services. The data was pulled from Figure 1 in the article “California Autism Prevalence Trends from 1931 to 2014 and Comparison to National ASD Data from IDEA and ADDM” (Nevison C, Blaxill M, and Zahorodny W., 2018) [(link)](https://link.springer.com/content/pdf/10.1007/s10803-018-3670-2.pdf). Make a plot to show if California autism rates have increased and if the increase coincides with the introduction of vaccines. In a few sentences, describe any conclusions that you can draw from your plot.

```{r}
# Load the data and look at the first few lines
load("autism_prevalence_CA.rData")
head(autism_prevalence_CA)
```

```{r}
## Your code here
```


9. Use data exploration to determine if another disease (besides Measles) has enough data to explore the effects of a vaccine. Prepare a report (minimum 1 paragraph, maximum 3 paragraphs) with as many plots as you think are necessary to provide a case for the benefit of vaccines. Note that there was a data entry mistake and the data for Polio and Pertussis are exactly the same. 

```{r}
## Your code here
```
