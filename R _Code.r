Examine the relationship between total calories and total steps:

install.packages("tidyverse")
install.packages("skimr")
install.packages("ggplot2")
install.packages("janitor")
library(tidyverse)
library(skimr)
library(janitor)
library(ggplot2)
library(readr)

# Import the dataset into R
dailyActivity_merged <- read_csv("Business analysis course/Google data analytics/Course 8/archive (3)/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv")
View(dailyActivity_merged)

## Examine the relationship between TotalSteps and Calories

ggplot(data = dailyActivity_merged) +
  geom_point(mapping = aes(x = TotalSteps, y = Calories)) +
  geom_smooth(mapping = aes(x = TotalSteps, y = Calories))

  4) Examine the question if higher sedentary time will lead to lower number of steps

  ggplot(data = dailyActivity_merged) +
  geom_point(mapping = aes(x = SedentaryMinutes, y = TotalSteps)) +
  geom_smooth(mapping = aes(x = SedentaryMinutes, y = TotalSteps))