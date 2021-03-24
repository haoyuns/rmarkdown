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

aseanvotes <- joined %>%
  filter(country %in% asean) %>%
  mutate(country = if_else(country == "Myanmar (Burma)", "Myanmar", country)) %>%
  group_by(issue, country, year = year(date)) %>%
  summarise(votes = n(),
            percent_yes = mean(vote == "yes")) %>%
  filter(votes > 5)


# graph --------------------
# ggthemes examples: https://github.com/BTJ01/ggthemes, https://ggplot2.tidyverse.org/reference/element.html

ggplot(aseanvotes, aes(year, percent_yes, color = issue)) +
  geom_smooth(se = FALSE) +
  facet_wrap(~ country, nrow = 2) +
  labs(title = "How ASEAN countries vote in UNGA",
       subtitle = "Percent of 'Yes' votes on six issues",
       x = NULL,
       y = NULL
       ) +
  #scale_x_continuous(breaks = seq(2000, 2020, by = 10)) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  scale_color_ptol("Issues") + theme_minimal() +
  theme(plot.margin = margin(1, 1.5, 1, 1, "cm"),
        plot.title = element_text(hjust = 0.5, size = 18, family = "Times", face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 11),
        legend.position = "top",
        legend.title = element_blank(),
        legend.text = element_text(size = 8),
        axis.text = element_text(size = 7),
        strip.text = element_text(size = 9))

ggsave("unvotes.jpeg", width = 8, height = 5, dpi = 640)
  
  
