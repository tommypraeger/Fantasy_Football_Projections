library(tidyverse)
library(data.table)

### Get Positional Ranks
Average_Fantasy_Projections <- Average_Fantasy_Projections %>%
  group_by(Position) %>%
  mutate(Position.Rank = order(order(Average.Fantasy.Points, decreasing=TRUE)))

### Get Pint Ranks
Average_Fantasy_Projections <- Average_Fantasy_Projections %>%
  mutate(Points.Rank = order(order(Average.Fantasy.Points, decreasing=TRUE)))

### Get the Value of the Replacement
qbValueOfReplacement <- mean(c(Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "QB" & Average_Fantasy_Projections$Position.Rank == qbReplacements)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "QB" & Average_Fantasy_Projections$Position.Rank == qbReplacements-1)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "QB" & Average_Fantasy_Projections$Position.Rank == qbReplacements+1)]))
rbValueOfReplacement <- mean(c(Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "RB" & Average_Fantasy_Projections$Position.Rank == rbReplacements)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "RB" & Average_Fantasy_Projections$Position.Rank == rbReplacements-1)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "RB" & Average_Fantasy_Projections$Position.Rank == rbReplacements+1)]))
wrValueOfReplacement <- mean(c(Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "WR" & Average_Fantasy_Projections$Position.Rank == wrReplacements)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "WR" & Average_Fantasy_Projections$Position.Rank == wrReplacements-1)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "WR" & Average_Fantasy_Projections$Position.Rank == wrReplacements+1)]))
teValueOfReplacement <- mean(c(Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "TE" & Average_Fantasy_Projections$Position.Rank == teReplacements)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "TE" & Average_Fantasy_Projections$Position.Rank == teReplacements-1)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "TE" & Average_Fantasy_Projections$Position.Rank == teReplacements+1)]))
kValueOfReplacement <- mean(c(Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "K" & Average_Fantasy_Projections$Position.Rank == kReplacements)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "K" & Average_Fantasy_Projections$Position.Rank == kReplacements-1)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "K" & Average_Fantasy_Projections$Position.Rank == kReplacements+1)]))
dstValueOfReplacement <- mean(c(Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "DST" & Average_Fantasy_Projections$Position.Rank == dstReplacements)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "DST" & Average_Fantasy_Projections$Position.Rank == dstReplacements-1)], Average_Fantasy_Projections$Average.Fantasy.Points[which(Average_Fantasy_Projections$Position == "DST" & Average_Fantasy_Projections$Position.Rank == dstReplacements+1)]))

### Get each player's VOR
Average_Fantasy_Projections$VoR <- 0
Average_Fantasy_Projections <- as.data.table(Average_Fantasy_Projections)
Average_Fantasy_Projections[which(Position == "QB"), VoR := Average.Fantasy.Points - qbValueOfReplacement]
Average_Fantasy_Projections[which(Position == "RB"), VoR := Average.Fantasy.Points - rbValueOfReplacement]
Average_Fantasy_Projections[which(Position == "WR"), VoR := Average.Fantasy.Points - wrValueOfReplacement]
Average_Fantasy_Projections[which(Position == "TE"), VoR := Average.Fantasy.Points - teValueOfReplacement]
Average_Fantasy_Projections[which(Position == "K"), VoR := Average.Fantasy.Points - teValueOfReplacement]
Average_Fantasy_Projections[which(Position == "DST"), VoR := Average.Fantasy.Points - dstValueOfReplacement]

### Get Ceiling VoR
Average_Fantasy_Projections$Ceiling.VoR <- 0
Average_Fantasy_Projections <- as.data.table(Average_Fantasy_Projections)
Average_Fantasy_Projections[which(Position == "QB"), Ceiling.VoR := Ceiling.Fantasy.Points - qbValueOfReplacement]
Average_Fantasy_Projections[which(Position == "RB"), Ceiling.VoR := Ceiling.Fantasy.Points - rbValueOfReplacement]
Average_Fantasy_Projections[which(Position == "WR"), Ceiling.VoR := Ceiling.Fantasy.Points - wrValueOfReplacement]
Average_Fantasy_Projections[which(Position == "TE"), Ceiling.VoR := Ceiling.Fantasy.Points - teValueOfReplacement]
Average_Fantasy_Projections[which(Position == "K"), Ceiling.VoR := Ceiling.Fantasy.Points - teValueOfReplacement]
Average_Fantasy_Projections[which(Position == "DST"), Ceiling.VoR := Ceiling.Fantasy.Points - dstValueOfReplacement]

### Get Floor VoR
Average_Fantasy_Projections$Floor.VoR <- 0
Average_Fantasy_Projections <- as.data.table(Average_Fantasy_Projections)
Average_Fantasy_Projections[which(Position == "QB"), Floor.VoR := Floor.Fantasy.Points - qbValueOfReplacement]
Average_Fantasy_Projections[which(Position == "RB"), Floor.VoR := Floor.Fantasy.Points - rbValueOfReplacement]
Average_Fantasy_Projections[which(Position == "WR"), Floor.VoR := Floor.Fantasy.Points - wrValueOfReplacement]
Average_Fantasy_Projections[which(Position == "TE"), Floor.VoR := Floor.Fantasy.Points - teValueOfReplacement]
Average_Fantasy_Projections[which(Position == "K"), Floor.VoR := Floor.Fantasy.Points - teValueOfReplacement]
Average_Fantasy_Projections[which(Position == "DST"), Floor.VoR := Floor.Fantasy.Points - dstValueOfReplacement]

### Get Value Over Replacement Ranks
Average_Fantasy_Projections <- Average_Fantasy_Projections %>%
  mutate(Value.Rank = order(order(VoR, decreasing=TRUE)))

### Remove Extras
rm(test, dstReplacements, dstValueOfReplacement, kReplacements, kValueOfReplacement, qbReplacements, qbValueOfReplacement, rbReplacements, rbValueOfReplacement, teReplacements, teValueOfReplacement, wrReplacements, wrValueOfReplacement)
