library(tidyverse)
Average_Fantasy_Projections <- Combined_Projections %>%
  group_by(Player) %>%
  group_by(Team, add = TRUE) %>%
  group_by(Position, add = TRUE) %>%
  select(-Individual.Fantasy.Points) %>%
  summarise_all(mean, na.rm = TRUE)
