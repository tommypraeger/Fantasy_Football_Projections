library(jsonlite)
library(data.table)
library(tidyverse)
library(gtools)
library(stringr)

Sleeper_JSON <- list(fromJSON("https://api.sleeper.app/projections/nfl/2019?season_type=regular&position[]=QB&position[]=RB&position[]=WR&position[]=TE&position[]=K&position[]=DEF&order_by=adp_std"))


Sleeper_Projections <- data.frame(
  "Platform" = c("Sleeper"),
  "Player" = paste(Sleeper_JSON[[1]][["player"]][["first_name"]], Sleeper_JSON[[1]][["player"]][["last_name"]]),
  "Team" = Sleeper_JSON[[1]][["player"]][["team"]],
  "Position" = Sleeper_JSON[[1]][["player"]][["position"]],
  "Pass Attempts" = Sleeper_JSON[[1]][["stats"]][["pass_att"]],
  "Completions" = Sleeper_JSON[[1]][["stats"]][["pass_cmp"]],
  "Passing Yards" = Sleeper_JSON[[1]][["stats"]][["pass_yd"]],
  "Passing Touchdowns" = Sleeper_JSON[[1]][["stats"]][["pass_td"]],
  "Interceptions" = Sleeper_JSON[[1]][["stats"]][["pass_int"]],
  "Carries" = Sleeper_JSON[[1]][["stats"]][["rush_att"]],
  "Rushing Yards" = Sleeper_JSON[[1]][["stats"]][["rush_yd"]],
  "Rushing Touchdowns" = Sleeper_JSON[[1]][["stats"]][["rush_td"]],
  "Targets" = Sleeper_JSON[[1]][["stats"]][["rec_tgt"]],
  "Receptions" = Sleeper_JSON[[1]][["stats"]][["rec"]],
  "Receiving Yards" = Sleeper_JSON[[1]][["stats"]][["rec_yd"]],
  "Receiving Touchdowns" = Sleeper_JSON[[1]][["stats"]][["rec_td"]],
  "Fumbles Lost" = Sleeper_JSON[[1]][["stats"]][["fum_lost"]],
  "FGM XP" = Sleeper_JSON[[1]][["stats"]][["xpm"]],
  "FGM 1_39" = NA,
  "FGM 40_49" = NA,
  "FGM 50+" = NA,
  "Field Goals Missed" = (Sleeper_JSON[[1]][["stats"]][["fga"]] - Sleeper_JSON[[1]][["stats"]][["fgm"]]),
  "Extra Points Missed" = (Sleeper_JSON[[1]][["stats"]][["xpa"]] - Sleeper_JSON[[1]][["stats"]][["xpm"]]),
  "Sacks" = Sleeper_JSON[[1]][["stats"]][["sack"]],
  "Safeties" = Sleeper_JSON[[1]][["stats"]][["safe"]],
  "Defensive Interceptions" = Sleeper_JSON[[1]][["stats"]][["int"]],
  "Force Fumbles" = Sleeper_JSON[[1]][["stats"]][["ff"]],
  "Fumbles Recovered" = Sleeper_JSON[[1]][["stats"]][["fum_rec"]],
  "Defensive Touchdowns" = Sleeper_JSON[[1]][["stats"]][["def_td"]],
  "Points Allowed" = Sleeper_JSON[[1]][["stats"]][["pts_allow"]],
  "Yards Allowed" = Sleeper_JSON[[1]][["stats"]][["yds_allow"]]
)

### Make Characters
Sleeper_Projections$Platform <- as.character(Sleeper_Projections$Platform)
Sleeper_Projections$Player <- as.character(Sleeper_Projections$Player)
Sleeper_Projections$Team <- as.character(Sleeper_Projections$Team)
Sleeper_Projections$Position <- as.character(Sleeper_Projections$Position)

### Make Some Changes
Sleeper_Projections <- Sleeper_Projections %>%
  filter(Position != "DEF")
Sleeper_Projections$Team[is.na(Sleeper_Projections$Team)] <- "FA"
Sleeper_Projections <- Sleeper_Projections %>%
  filter(Team != "FA")
Sleeper_Projections$Team[Sleeper_Projections$Team == "JAX"] <- "JAC"

### Remove JSON
rm(Sleeper_JSON)
