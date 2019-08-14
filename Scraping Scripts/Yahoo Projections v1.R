library(tidyverse)
library(XML)
library(RCurl)
library(gtools)
library(stringr)

### Set Up The Conditionals for the Large Scrape
if(week == 0){week_no <- paste0("S_", season)}
if(week > 0){week_no <- paste0("w_", week)}

### Get the First Table and Clean it UP
pages <- 0
yahoo_url <- getURL(paste0("https://football.fantasysports.yahoo.com/f1/39345/players?status=A&pos=O&cut_type=9&stat1=S_P", week_no, "&myteam=0&sort=PR&sdir=1&count=", pages))
projections_yahoo <- readHTMLTable((yahoo_url), stringsAsFactors = FALSE)[2]$'NULL'
projections_yahoo <-  projections_yahoo[,-4]
colnames(projections_yahoo) <- c("blank1", "Player", "blank2", "Owner", "Games.Played", "Bye", "Fantasy.Points", "Perc.Owned",
                          "Projected.Rank", "Actual.Rank", "Passing.Yards", "Passing.Touchdowns", "Interceptions",
                          "Carries", "Rushing.Yards", "Rushing.Touchdowns", "Targets", "Receptions", "Receiving.Yards",
                          "Receiving.Touchdowns", "Return.Touchdowns", "2PT.Conversion", "Fumbles.Lost", "blank3")

### Get the Loop
pages <- c(25, 50, 75, 100, 125, 150, 175, 200, 225, 250, 275, 300, 325, 350, 375, 400, 425, 450, 475, 500, 525, 550, 575, 600, 625, 650, 675, 750, 725, 750, 775)
for(pages in pages){
  yahoo_url <- getURL(paste0("https://football.fantasysports.yahoo.com/f1/39345/players?status=A&pos=O&cut_type=9&stat1=S_P", week_no, "&myteam=0&sort=PR&sdir=1&count=", pages))
  projections_yahoo_placeholder <- readHTMLTable((yahoo_url), stringsAsFactors = FALSE)[2]$'NULL'
  if(pages<174) {projections_yahoo_placeholder <- projections_yahoo_placeholder[,-4]
    colnames(projections_yahoo_placeholder) <- c("blank1", "Player", "blank2", "Owner", "Games.Played", "Bye", "Fantasy.Points", "Perc.Owned",
                            "Projected.Rank", "Actual.Rank", "Passing.Yards", "Passing.Touchdowns", "Interceptions",
                            "Carries", "Rushing.Yards", "Rushing.Touchdowns", "Targets", "Receptions", "Receiving.Yards",
                            "Receiving.Touchdowns", "Return.Touchdowns", "2PT.Conversion", "Fumbles.Lost", "blank3")}
  if(pages>174) {projections_yahoo_placeholder <- projections_yahoo_placeholder[,-4]
  colnames(projections_yahoo_placeholder) <- c("blank1", "Player", "blank2", "Owner", "Games.Played", "Bye", "Fantasy.Points", "Perc.Owned",
                                        "Projected.Rank", "Actual.Rank", "Passing.Yards", "Passing.Touchdowns", "Interceptions",
                                        "Carries", "Rushing.Yards", "Rushing.Touchdowns", "Targets", "Receptions", "Receiving.Yards",
                                        "Receiving.Touchdowns", "Return.Touchdowns", "2PT.Conversion", "Fumbles.Lost", "blank3")}
  projections_yahoo <- smartbind(projections_yahoo, projections_yahoo_placeholder)
}

### Add Kickers 
pages <- c(1, 25)
for(pages in pages){
  yahoo_url <- getURL(paste0("https://football.fantasysports.yahoo.com/f1/39345/players?status=A&pos=K&cut_type=9&stat1=S_P", week_no, "&myteam=0&sort=PR&sdir=1&count=", pages))
  projections_yahoo_placeholder <- readHTMLTable((yahoo_url), stringsAsFactors = FALSE)[2]$'NULL'
  if(pages<24) {colnames(projections_yahoo_placeholder) <- c("blank1", "Player", "blank2", "Owner", "Games.Played", "Bye", "Fantasy.Points", "Perc.Owned",
                                                              "Projected.Rank", "Actual.Rank", "FGM.1_19", "FGM.20_29", "FGM.30_39", "FGM.40_49", "FGM.50.", "Field.Goals.Made", "blank3")}
  if(pages>24) {colnames(projections_yahoo_placeholder) <- c("blank1", "Player", "blank2", "Owner", "Games.Played", "Bye", "Fantasy.Points", "Perc.Owned",
                                               "Projected.Rank", "Actual.Rank", "FGM.1_19", "FGM.20_29", "FGM.30_39", "FGM.40_49", "FGM.50.", "FGM.XP", "blank3")}
  projections_yahoo <- smartbind(projections_yahoo, projections_yahoo_placeholder)
}

### Remove Funky Characters
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "III ", "")
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "II ", "")
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "Jr.", "")
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "Sr.", "")
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "IV ", " ")
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "V ", " ")

### Clean up the Player Name
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "\n", "")
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "No new player Notes", "")
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "player Notes", "")
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "Player Notes", "")
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "Player Note", "")
projections_yahoo$Player <- str_replace_all(projections_yahoo$Player, "New ", "")

### Extract Position
projections_yahoo$Player <- sub("^\\s*(\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+).*", "\\1", projections_yahoo$Player) ## Clear everything after the Fifth space 
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
projections_yahoo$Position <- str_trim(substrRight(projections_yahoo$Player, 2))

### Extract Team Name
projections_yahoo$Player <- sub("^\\s*(\\S+\\s+\\S+\\s+\\S+).*", "\\1", projections_yahoo$Player) ## Clear everything after the Third space 
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
projections_yahoo$Team <- str_trim(substrRight(projections_yahoo$Player, 3))

### Clean Player Names one last time
projections_yahoo$Player <- sub("^\\s*(\\S+\\s+\\S+).*", "\\1", projections_yahoo$Player) ## Clear everything after the second space 

### Rearrange the Columns
projections_yahoo$Platform <- "Yahoo"
projections_yahoo <- projections_yahoo %>%
  select(-blank1, -blank2, -blank3, -Owner, -Fantasy.Points, -Perc.Owned, -Projected.Rank, -Actual.Rank) %>%
  select(Platform, Player, Team, Position, everything())

### Make Numeric
projections_yahoo[5:25] <- as.numeric(unlist(projections_yahoo[5:25]))

### Combine Kicker Columns
projections_yahoo <- projections_yahoo %>%
  mutate(`FGM.1_39` = (`FGM.1_19`+`FGM.20_29`+`FGM.30_39`)) %>%
  select(-FGM.1_19, -FGM.20_29, -FGM.30_39)  

### Change Jacksonville Team Name
projections_yahoo$Team[projections_yahoo$Team == "Jax"] <- "JAC"

### Clean, Save, and Call it a Day
if(week == 0){week_no <- paste0("Draft")}
if(week > 0){week_no <- paste0(week)}
assign(paste0("Yahoo_Projections"), projections_yahoo)
rm(projections_yahoo, projections_yahoo_placeholder)
