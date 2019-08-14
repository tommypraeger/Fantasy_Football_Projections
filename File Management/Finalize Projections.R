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
