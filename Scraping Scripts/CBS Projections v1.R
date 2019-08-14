library(tidyverse)
library(XML)
library(RCurl)
library(gtools)
library(stringr)


### Get the Tables
qb_cbs <- getURL(paste0("https://www.cbssports.com/fantasy/football/stats/QB/2019/season/projections/ppr/"))
qb_cbs <- readHTMLTable(qb_cbs, stringsAsFactors = FALSE)$`NULL`
 #qb_cbs[2:16] <- as.numeric(unlist(qb_cbs[2:16]))
rb_cbs <- getURL(paste0("https://www.cbssports.com/fantasy/football/stats/RB/2019/season/projections/ppr/"))
rb_cbs <- readHTMLTable(rb_cbs, stringsAsFactors = FALSE)$`NULL`
 #rb_cbs <- unlist(rb_cbs)
wr_cbs <- getURL(paste0("https://www.cbssports.com/fantasy/football/stats/WR/2019/season/projections/ppr/"))
wr_cbs <- readHTMLTable(wr_cbs, stringsAsFactors = FALSE)$`NULL`
 #wr_cbs <- unlist(wr_cbs)
te_cbs <- getURL(paste0("https://www.cbssports.com/fantasy/football/stats/TE/2019/season/projections/ppr/"))
te_cbs <- readHTMLTable(te_cbs, stringsAsFactors = FALSE)$`NULL`
 #te_cbs <- unlist(te_cbs)
k_cbs <- getURL(paste0("https://www.cbssports.com/fantasy/football/stats/K/2019/season/projections/ppr/"))
k_cbs <- readHTMLTable(k_cbs, stringsAsFactors = FALSE)$`NULL`

### Change the Column Name
colnames(qb_cbs) <- c("Player", "Games.Played", "Pass.Attempts", "Completions", "Passing.Yards", "Passing.Yards.Per.Game", "Passing.Touchdowns", "Interceptions", "Passer.Rating", "Carries", "Rushing.Yards", "Average.Yards.Per.Rush", "Rushing.Touchdowns", "Fumbles.Lost", "Fantasy.Points", "Fantasy.Points.Per.Game")
colnames(rb_cbs) <- c("Player", "Games.Played", "Carries", "Rushing.Yards", "Average.Yards.Per.Rush", "Rushing.Touchdowns", "Targets", "Receptions", "Receiving.Yards", "Yards.Per.Game", "Average.Yards.Per.Receptions", "Receiving.Touchdowns", "Fumbles.Lost", "Fantasy.Points", "Fantasy.Points.Per.Game")
colnames(wr_cbs) <- c("Player", "Games.Played", "Targets", "Receptions", "Receiving.Yards", "Yards.Per.Game", "Average.Yards.Per.Receptions", "Receiving.Touchdowns", "Carries", "Rushing.Yards", "Average.Yards.Per.Rush", "Rushing.Touchdowns", "Fumbles.Lost", "Fantasy.Points", "Fantasy.Points.Per.Game")
colnames(te_cbs) <- c("Player", "Games.Played", "Targets", "Receptions", "Receiving.Yards", "Yards.Per.Game", "Average.Yards.Per.Receptions", "Receiving.Touchdowns", "Fumbles.Lost", "Fantasy.Points", "Fantasy.Points.Per.Game")
colnames(k_cbs) <- c("Player", "Games.Played", "Field.Goals.Made", "Field.Goal.Attempts", "Longest.Field.Goal", "FGM.1_19", "FGA.1_19", "FGM.20_29", "FGA.20_29", "FGM.30_39", "FGA.30_39", "FGM.40_49", "FGA.40_49", "FGM.50.", "FGA.50.", "FGM.XP", "FGA.XP", "Fantasy.Points", "Fantasy.Points.Per.Game")


### Change and Adapt the Kickers that matter
k_cbs[2:19] <- as.numeric(unlist(k_cbs[2:19]))
k_cbs <- k_cbs %>%
  select(-Longest.Field.Goal) %>%
  mutate(`FGM.1_39` = (`FGM.1_19`+`FGM.20_29`+`FGM.30_39`),
         Field.Goals.Missed = (Field.Goal.Attempts-Field.Goals.Made),
         Extra.Points.Missed = (FGA.XP-FGM.XP)) %>%
  select(`Player`, `FGM.1_39`, `FGM.40_49`, `FGM.50.`, FGM.XP, Field.Goals.Missed, Extra.Points.Missed)


### Add Position Column 
qb_cbs$Position <- as.character("QB")
rb_cbs$Position <- as.character("RB")
wr_cbs$Position <- as.character("WR")
te_cbs$Position <- as.character("TE")
k_cbs$Position <- as.character("K")

### Merge across Positions
projections_cbs <- smartbind(qb_cbs, rb_cbs, wr_cbs, te_cbs, k_cbs)
projections_cbs <- projections_cbs %>%
  select(Player, Position, everything())

### Remove Funky Characters
projections_cbs$Player <- str_replace_all(projections_cbs$Player, "Jr.", "")
projections_cbs$Player <- str_replace_all(projections_cbs$Player, "Sr.", "")
projections_cbs$Player <- str_replace_all(projections_cbs$Player, " IV ", " ")
projections_cbs$Player <- str_replace_all(projections_cbs$Player, " V ", " ")
projections_cbs$Player <- str_replace_all(projections_cbs$Player, "III ", "")
projections_cbs$Player <- str_replace_all(projections_cbs$Player, "II ", "")

### Make Statistics Numeric and Characters if needed
projections_cbs[3:29] <- as.numeric(unlist(projections_cbs[3:29]))
projections_cbs$Player <- as.character((unlist(projections_cbs$Player)))

### Get Team Name from Player Names. Clean up the Rest of the Player Names
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
projections_cbs$Team <- str_trim(substrRight(projections_cbs$Player, 3))
projections_cbs$Player <- gsub("\n", "", projections_cbs$Player)
projections_cbs$Player <- str_replace_all(projections_cbs$Player, paste0(" ", projections_cbs$Team, " "), "")
projections_cbs$Player <- str_replace_all(projections_cbs$Player, paste0("", projections_cbs$Team, ""), "")
projections_cbs$Player <- str_replace_all(projections_cbs$Player, paste0(" ", projections_cbs$Position, " "), "")
projections_cbs$Player <- sub(".*? (.+)", "\\1", projections_cbs$Player) # Remove everthing before first space
projections_cbs$Player <- sub(".*? (.+)", "\\1", projections_cbs$Player) # Remove everthing before second space
projections_cbs$Player <- gsub(" P ", "", projections_cbs$Player)
projections_cbs$Player <- gsub(" FB ", "", projections_cbs$Player)
projections_cbs$Player <- sub("^\\s*(\\S+\\s+\\S+\\s+\\S+\\s+\\S+).*", "\\1", projections_cbs$Player) ## Clear everything after the second space 



### Clean up and Finalize
projections_cbs$Platform <- "CBS"
projections_cbs <- projections_cbs %>%
  select(-Fantasy.Points, -Fantasy.Points.Per.Game) %>%
  select(Platform, Player, Team, Position, everything())
if(week == 0){week_no <- paste0("Draft")}
if(week > 0){week_no <- paste0(week)}
assign(paste0("CBS_Projections"), projections_cbs)
rm(qb_cbs, rb_cbs, wr_cbs, te_cbs, k_cbs, dst_cbs, projections_cbs)
