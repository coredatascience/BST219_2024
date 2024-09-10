## Homework 1

Several of your friends live in Europe and are offered jobs at a US company with many locations all across the country. The job offers are great but news with headlines such as [**America is one of 6 countries that make up more than half of guns deaths worldwide**](https://www.vox.com/2018/8/29/17792776/us-gun-deaths-global) have them worried. Charts like this make them worry even more:

![US gun homicides chart](GunTrends_murders_per_1000.png) 

You want to convince your friends that the US is a large and diverse country with 50 very different states as well as the District of Columbia (DC). You want to recommend some states for each friend knowing that some like hiking, while others would like to be close to several large cosmopolitan cities. Use data from the [US murders data set](https://www.rdocumentation.org/packages/dslabs/versions/0.7.1/topics/murders):

```{r, message = FALSE, warning = FALSE}
library(tidyverse)
library(dslabs)
data(murders)
```


1. What is the state with the most murders? Would you say this is the 
most dangerous state? Hint: Make a plot showing the relationship between population size and number of murders.

```{r}
# Your code here
```


2. Add a column to the murder data table called `murder_rate` with each state's murder rate per 100,000 people.

```{r}
# Your code here
```


3. Describe the distribution of murder rates across states. How similar are states? How much do murder rates vary by geographical regions?

```{r}
# Your code here
```


4. Which states have murder rates lower than 2 per 100,000 people? 

```{r}
# Your code here
```


5. Write a function called `states_below_cutoff` that takes two arguments: the `murders` dataset and a numeric `cutoff`. This function should return a vector of the states whose murder rates are below the `cutoff` argument. 

As a sanity check to see if your function is behaving as expected, run `states_below_cutoff(murders, cutoff = 2)` and see if you get the same vector of states as in Question 4. Then, use your function to report the number of states that have murder rates below 3. 

```{r}
states_below_cutoff <- function(murders, cutoff){
  # Code to return states with murder rate below cutoff
}
```


6. Now, write a function called `states_below_cutoff_in_region`. Like `states_below_cutoff`, your new function should take the `murders` dataset and a numeric `cutoff` as arguments. However, `states_below_cutoff_in_region` should also take a third argument, `geo_region`, which is a character string indicating a geographical region (`"Northeast"`, `"South"`, `"North Central"`, or `"West"`) This function should return a vector of the states whose murder rates are below the `cutoff` argument AND are belong to the geographical region indicated by the `geo_region` argument. Hint: You may find it easier to first try writing some code to get the states with murder rates below a fixed cutoff (say, 2) and who belong to a certain geographical region (say, `"West"`). Once you have your specific example working, you can convert your code to the more general function. 

Use your function to report the number of states from the `"West"` with murder rates below 2 and the number of states from the `"South"` with murder rates below 2. 

```{r}
states_below_cutoff_in_region <- function(murders, cutoff, geo_region){
  # Code to return states with murder rate below cutoff and are within geo_region
}
```


7. Write a report for your friends reminding them that the US is a large and diverse country with 50 very different states as well as the District of Columbia (DC). Suppose one of your friends loves hiking, one wants to live in a warm climate, and another would like to be close to several large cosmopolitan cities. Recommend a desirable state for each friend. Answers should be a minimum of 1 paragraph and a maximum of 3 paragraphs. One possible approach would be to look at the murder rates for each state, identify a reasonable maximum cutoff, and then pick the state(s) that best fit each friend's criteria from the states with murder rates below the cutoff. 

*Your answer here (no code required)*
