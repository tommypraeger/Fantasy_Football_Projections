### Add Cost Multiplier
#Apply 10% price premium to 33 players with highest projected points, apply 10% price deflation for players lower than rank 66
Average_Fantasy_Projections$Cost <- 0
Average_Fantasy_Projections <- as.data.table(Average_Fantasy_Projections)
Average_Fantasy_Projections[which(Position.Rank <= 33), Cost := Average.Auction.Value * 1.1]
Average_Fantasy_Projections[which(Position.Rank >= 34 & Average_Fantasy_Projections$Position.Rank <= 66), Cost := Average.Auction.Value]
Average_Fantasy_Projections[which(Position.Rank >= 67), Cost := Average.Auction.Value * 0.9]
Average_Fantasy_Projections <- as.data.table(Average_Fantasy_Projections)
Average_Fantasy_Projections[which(Average_Fantasy_Projections$Cost == 0), Cost := 1]
Average_Fantasy_Projections$Cost <- ceiling(Average_Fantasy_Projections$Cost)
