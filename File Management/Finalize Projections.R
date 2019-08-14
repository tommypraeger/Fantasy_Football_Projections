### Change 0 ADP
Average_Fantasy_Projections <- as.data.table(Average_Fantasy_Projections)
Average_Fantasy_Projections[which(Average_Fantasy_Projections$Average.Draft.Position == 0), Average.Draft.Position := 170]

### Drop Unimportant Columns and Add Some Other Better Metrics
Fantasy_Projections <- Average_Fantasy_Projections
Fantasy_Projections[is.na(Fantasy_Projections)] <- 0
Fantasy_Projections <- as.data.table(Fantasy_Projections)
Fantasy_Projections <- Fantasy_Projections %>%
  mutate(Opportunities = (Pass.Attempts + Carries + Receptions), 
         Value.Per.Opportunity = (VoR/Opportunities), 
         Fantasy.Points = Average.Fantasy.Points) %>%
  select(id, Player, Team, Position, Bye, Average.Auction.Value, Cost, Average.Draft.Position, Games.Played, Opportunities, Tier, Value.Rank, VoR, Ceiling.VoR, Floor.VoR,
         Risk, Points.Rank, Fantasy.Points, Ceiling.Fantasy.Points, Floor.Fantasy.Points)

### Round Everything
Average_Fantasy_Projections[,5:56] <- round(Average_Fantasy_Projections[,5:56], 2)
Fantasy_Projections[,5:20] <- round(Fantasy_Projections[,5:20], 2)
