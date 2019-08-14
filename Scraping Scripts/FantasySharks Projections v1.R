library(jsonlite)
library(data.table)
library(tidyverse)
library(gtools)
library(stringr)
library(reshape2)

if(week == 0){week_no <- paste0("Season")}
if(week > 0){week_no <- paste0("Weekly")}

### Scrape The Projections (Easy Peasy)
projections_FantasySharks <- fromJSON(paste0("https://www.fantasysharks.com/apps/Projections/",week_no ,"Projections.php?pos=ALL&format=json&l=2"))
projections_FantasySharks <- smartbind(projections_FantasySharks, fromJSON(paste0("https://www.fantasysharks.com/apps/Projections/",week_no ,"Projections.php?pos=PK&format=json&l=2")))

### Fix the Player Name
name <- str_split(projections_FantasySharks$Name, ",")
name <- rbindlist(list(name))
name <- transpose(name)
projections_FantasySharks$Name <- paste(name$V2, name$V1)
projections_FantasySharks$Name <- trimws(projections_FantasySharks$Name)
projections_FantasySharks$Name <- sub("^\\s*(\\S+\\s+\\S+).*", "\\1", projections_FantasySharks$Name) ## Clear everything after the second space

### Change Column Names
colnames(projections_FantasySharks) <- c("Projected.Rank", "Average.Draft.Position", "FantasySharks.ID", "Player", "Position", "Team", "Bye", "Completions", "Passing.Yards", "Passing.Touchdowns", "Interceptions", "Carries", 
                                         "Rushing.Yards", "Rushing.Touchdowns", "Fumbles.Lost", "Receptions", "Receiving.Yards", "Receiving.Touchdowns", "Fantasy.Points", "Average.Auction.Value", "FGM.XP", "Field.Goals.Made", "Field.Goals.Missed")

### Add Columns and Rearrange
projections_FantasySharks$Platform <- "FantasySharks"
projections_FantasySharks <- projections_FantasySharks %>%
  select(Platform, Player, Team, Position, everything())

### Fix the Team Names
projections_FantasySharks$Team <- str_replace_all(projections_FantasySharks$Team, "KCC", "KC")
projections_FantasySharks$Team <- str_replace_all(projections_FantasySharks$Team, "NEP", "NE")
projections_FantasySharks$Team <- str_replace_all(projections_FantasySharks$Team, "SFO", "SF")
projections_FantasySharks$Team <- str_replace_all(projections_FantasySharks$Team, "GBP", "GB")
projections_FantasySharks$Team <- str_replace_all(projections_FantasySharks$Team, "NOS", "NO")
projections_FantasySharks$Team <- str_replace_all(projections_FantasySharks$Team, "KCC", "KC")
projections_FantasySharks$Team <- str_replace_all(projections_FantasySharks$Team, "TBB", "TB")

### Add Kicker Positions
projections_FantasySharks$Position[is.na(projections_FantasySharks$Position)] <- "K"

### Remove Uneeded Stats
projections_FantasySharks <- projections_FantasySharks %>%
  select(-Projected.Rank, -Average.Draft.Position, - Average.Auction.Value, -FantasySharks.ID, -Fantasy.Points, -Bye)

### Change to Numerics
projections_FantasySharks[,5:18] <- as.numeric(unlist(projections_FantasySharks[,5:18]))

### Save
assign(paste0("FantasySharks_Projections"), projections_FantasySharks)
rm(projections_FantasySharks, projections_FantasySharks_placeholder, name)
