library(tidytuesdayR)
library(tidyverse)
library(lubridate)

# Import data ------------------

ttdata <- tt_load("2021-03-23")
unvotes <- ttdata$unvotes
rollcalls <- ttdata$roll_calls
issues <- ttdata$issues


# filter data ------------------
joined <- unvotes %>%
  inner_join(rollcalls, by = "rcid") %>%
  inner_join(issues, by = "rcid")

asean <- c("Brunei", "Cambodia", "Indonesia", "Laos", "Malaysia", "Myanmar (Burma)", "Philippines", "Singapore", "Thailand", "Vietnam")

temp <- joined %>%
  filter(country %in% asean | country == "China",
         short_name == "hr") %>%
  group_by(country, year = year(date)) %>%
  select(rcid, country, year, vote:descr) %>%
  summarise(votes = n(),
            percent_yes = mean(vote == "yes"),
            percent_abstain = mean(vote == "abstain")) %>%
  filter(year >= 2000, votes > 5)

# graph --------------------
ggplot(temp, aes(year, percent_yes)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  facet_wrap(~ country)
