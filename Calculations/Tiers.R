library(mclust)

### Set Thresholds and Tier Groups
scoreThreshold <- c(QB = 10, RB = 10, WR = 10, TE = 7, K = 7, DST = 5, DL = 10, LB = 10, DB = 10)
#tierGroups <- c(QB = 10, RB = 10, WR = 10, TE = 7, K = 7, DST = 5, DL = 10, LB = 10, DB =10)

### Create Functions
setTier <- function(points, position){
  threshold <- scoreThreshold[position]
  if(is.na(threshold))
    threshold <- 20
  tiers <- rep(as.numeric(NA), length(points))
  tierNum <- 1
  points.order <- order(-points)
  points <- points[points.order]
  repeat{
    tiers[points >= floor(max(points[is.na(tiers)]) - threshold) & is.na(tiers)] <- tierNum
    
    if(all(!is.na(tiers)))
      break
    tierNum <- tierNum + 1
  }
  tiers[points.order] <- tiers
  return(tiers)
}


### Set the Initial Tiers
Average_Fantasy_Projections$Tier <- 0
Average_Fantasy_Projections <- as.data.table(Average_Fantasy_Projections)
Average_Fantasy_Projections[which(Position == "QB"), Tier := setTier(Average.Fantasy.Points, "QB")]
Average_Fantasy_Projections[which(Position == "RB"), Tier := setTier(Average.Fantasy.Points, "RB")]
Average_Fantasy_Projections[which(Position == "WR"), Tier := setTier(Average.Fantasy.Points, "WR")]
Average_Fantasy_Projections[which(Position == "TE"), Tier := setTier(Average.Fantasy.Points, "TE")]
Average_Fantasy_Projections[which(Position == "K"), Tier := setTier(Average.Fantasy.Points, "K")]
Average_Fantasy_Projections[which(Position == "DST"), Tier := setTier(Average.Fantasy.Points, "DST")]

### Remove
rm(scoreThreshold, clusterTier, simpleCap)