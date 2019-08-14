library(jsonlite)
library(data.table)
library(tidyverse)
library(gtools)
library(stringr)

### Get Player
ESPN_JSON <- fromJSON("https://fantasy.espn.com/apis/v3/games/ffl/seasons/2019/segments/0/leaguedefaults/1?view=kona_player_info")




### Separate the projections
espn_stat_projections <- ESPN_JSON[["players"]][["player"]][["stats"]]
#espn_stat_projections <- espn_stat_projections[!sapply(espn_stat_projections, is.null)]
espn_stat_projections_placeholder <- data.frame(espn_stat_projections[[1]])
espn_stat_projections_placeholder_placeholder <- espn_stat_projections_placeholder
espn_stat_projections_placeholder <- cbind(espn_stat_projections_placeholder, espn_stat_projections_placeholder$stats)
espn_stat_projections_placeholder <- espn_stat_projections_placeholder %>% select(-c(stats))
espn_stat_projections_player <- espn_stat_projections_placeholder %>%
  filter(id == "102019")

# Loop through to get the projections into one dataset
players <- as.numeric(length(espn_stat_projections))
for(i in 2:players) { 
  espn_stat_projections_placeholder <- data.frame(espn_stat_projections[[i]])
  if(is_empty(espn_stat_projections_placeholder) == TRUE){espn_stat_projections_placeholder <- data.frame(matrix(ncol = 10, nrow = 1))
  colnames(espn_stat_projections_placeholder) <- colnames(espn_stat_projections_placeholder_placeholder)
  espn_stat_projections_placeholder$id <- "102019"}
  espn_stat_projections_placeholder <- cbind(espn_stat_projections_placeholder, espn_stat_projections_placeholder$stats)
  espn_stat_projections_placeholder <- espn_stat_projections_placeholder %>% select(-c(stats))
  espn_stat_projections_placeholder <-  espn_stat_projections_placeholder %>%
    filter(id == "102019")
  espn_stat_projections_player <- smartbind(espn_stat_projections_player, espn_stat_projections_placeholder)
                                      }


### Put Important Information Together
ESPN_Projections <- data.frame(
  "Platform" = c("ESPN"),
  "id" = ESPN_JSON[["players"]][["id"]],
  "Player" = ESPN_JSON[["players"]][["player"]][["fullName"]],
  "Team ID" = ESPN_JSON[["players"]][["player"]][["proTeamId"]],
  "Position ID" = ESPN_JSON[["players"]][["player"]][["defaultPositionId"]],
  "Average Auction Value" = round(ESPN_JSON[["players"]][["player"]][["ownership"]][["auctionValueAverage"]], 2),
  "Average Draft Position" = ESPN_JSON[["players"]][["player"]][["ownership"]][["averageDraftPosition"]]
)
ESPN_Projections <- na.omit(ESPN_Projections)
espn_stat_projections <- data.frame(
  "Pass Attempts" = espn_stat_projections_player$`0`,
  "Completions" = espn_stat_projections_player$`1`,
  "Passing Yards" = espn_stat_projections_player$`3`,
  "Passing Touchdowns" = espn_stat_projections_player$`4`,
  "Interceptions" = espn_stat_projections_player$`20`,
  "Carries" = espn_stat_projections_player$`23`,
  "Rushing Yards" = espn_stat_projections_player$`24`,
  "Rushing Touchdowns" = espn_stat_projections_player$`25`,
  "Targets" = espn_stat_projections_player$`58`,
  "Receptions" = espn_stat_projections_player$`53`,
  "Receiving Yards" = espn_stat_projections_player$`42`,
  "Receiving Touchdowns" = espn_stat_projections_player$`43`,
  "FGM XP" = espn_stat_projections_player$`86`,
  "FGM 1_39" = espn_stat_projections_player$`80`,
  "FGM 40_49" = espn_stat_projections_player$`77`,
  "FGM 50+" = espn_stat_projections_player$`74`,
  "Field Goals Missed" = (espn_stat_projections_player$`84` - espn_stat_projections_player$`83`),
  "Extra Points Missed" = (espn_stat_projections_player$`87` - espn_stat_projections_player$`86`),
  "Sacks" = espn_stat_projections_player$`99`,
  "Defensive Interceptions" = espn_stat_projections_player$`95`,
  "Fumbles Recovered" = espn_stat_projections_player$`96`,
  "Defensive Touchdowns" = espn_stat_projections_player$`105`,
  "Points Allowed" = espn_stat_projections_player$`120`,
  "Yards Allowed" = espn_stat_projections_player$`127`
                         )
ESPN_Projections <- cbind(ESPN_Projections, espn_stat_projections)


### Change Team ID to Team
espn_teamid_key <- data.frame(
  "Team ID" = 0:34,
  "Team" = c("FA", "ATL", "BUF", "CHI", "CIN", "CLE",
             "DAL", "DEN", "DET", "GB", "TEN",
             "IND", "KC", "OAK", "LAR", "MIA",
             "MIN", "NE", "NO", "NYG", "NYJ",
             "PHI", "ARI", "PIT", "LAC", "SF",
             "SEA", "TB", "WAS", "CAR", "JAC",
             NA, NA, "BAL", "HOU"))
espn_positionid_key <- data.frame(
  "Position ID" = c(1:5, 16),
  "Position" = c("QB", "RB", "WR", "TE", "K", "DST")
)
ESPN_Projections <- merge(espn_teamid_key, ESPN_Projections,  by = c("Team.ID"))
ESPN_Projections <- merge(espn_positionid_key, ESPN_Projections, by = c("Position.ID"), all = TRUE)
ESPN_Projections <- ESPN_Projections %>%
  select(-c("Position.ID", "Team.ID")) %>%
  select(id, Player, Team, Position, everything())

### Clean and Save
if(week == 0){week_no <- paste0("Draft")}
if(week > 0){week_no <- paste0(week)}
assign(paste0("ESPN_Projections"), ESPN_Projections)
rm(espn_stat_projections, espn_stat_projections_placeholder, espn_stat_projections_player, ESPN_JSON, espn_teamid_key, espn_positionid_key, espn_stat_projections_placeholder_placeholder)


