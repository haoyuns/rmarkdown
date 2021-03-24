library(dplyr)
library(ggplot2)
library(ggthemes)
library(lubridate)
library(tidytuesdayR)

# Import data ------------------

ttdata <- tt_load("2021-03-23")
unvotes <- ttdata$unvotes
rollcalls <- ttdata$roll_calls
issues <- ttdata$issues


# join and filter data ------------------

joined <- unvotes %>%
  inner_join(rollcalls, by = "rcid") %>%
  inner_join(issues, by = "rcid")

asean <- c("Brunei", "Cambodia", "Indonesia", "Laos", "Malaysia", "Myanmar (Burma)", "Philippines", "Singapore", "Thailand", "Vietnam")

temp <- joined %>%
  filter(country %in% asean) %>%
  group_by(issue, country, year = year(date)) %>%
  summarise(votes = n(),
            percent_yes = mean(vote == "yes")) %>%
  filter(year >= 2000, votes > 5)


# graph --------------------
# ggthemes examples: https://github.com/BTJ01/ggthemes

ggplot(temp, aes(year, percent_yes, color = issue)) +
  geom_smooth(se = FALSE) +
  facet_wrap(~ country, nrow = 2) +
  labs(title = "How ASEAN countries vote in the UN",
       #caption = "Data source: github.com/dgrtwo/unvotes",
       x = "Year",
       y = "Percent of 'Yes' votes",
       color = "Issues"
       ) +
  scale_x_continuous(breaks = seq(2000, 2020, by = 10)) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  #scale_color_fivethirtyeight() + theme_fivethirtyeight()
  #scale_colour_wsj("colors6", "") + theme_wsj()
  scale_color_ptol("issue") + theme_minimal()
  
  
