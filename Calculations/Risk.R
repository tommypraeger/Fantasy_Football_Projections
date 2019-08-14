library(tidyverse)

### Get the Risk via standard deviation
Risk <- Combined_Projections %>%
  group_by(Player) %>%
  group_by(Team, add = TRUE) %>%
  group_by(Position, add = TRUE) %>%
  summarise(Risk = sd(Individual.Fantasy.Points, na.rm = TRUE),
            Average.Fantasy.Points = mean(Individual.Fantasy.Points, na.rm = TRUE),
            Ceiling.Fantasy.Points = (Average.Fantasy.Points+(Risk*2)),
            Floor.Fantasy.Points = (Average.Fantasy.Points-(Risk*2))) 

### Scale the Risk to Something more understandable
Risk$Risk <- scale(Risk$Risk)
Risk$Risk <- ((Risk$Risk*2)/sd(Risk$Risk, na.rm = TRUE)) + (5-mean(Risk$Risk, na.rm = TRUE))

### Separate to Cbind
Ceiling.Fantasy.Points <- Risk$Ceiling.Fantasy.Points
Floor.Fantasy.Points <- Risk$Floor.Fantasy.Points
Risk <- Risk$Risk

### Merge Back Together
Average_Fantasy_Projections <- cbind.data.frame(Average_Fantasy_Projections, Ceiling.Fantasy.Points)
Average_Fantasy_Projections <- cbind.data.frame(Average_Fantasy_Projections, Floor.Fantasy.Points)
Average_Fantasy_Projections <- cbind.data.frame(Average_Fantasy_Projections, Risk)

### Remove Uneeded Items
rm(Risk, High.Fantasy.Points, Low.Fantasy.Points, Ceiling.Fantasy.Points, Floor.Fantasy.Points)
