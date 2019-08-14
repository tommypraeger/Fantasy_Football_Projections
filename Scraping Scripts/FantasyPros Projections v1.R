library(tidyverse)
library(XML)
library(RCurl)
library(gtools)
library(stringr)

if(week == 0){week_no <- paste0("draft")}
if(week > 0){week_no <- paste0(week)}

### Pull the Tables
qb_fp <- getURL(paste0("https://www.fantasypros.com/nfl/projections/qb.php?week=", week_no))
qb_fp <- readHTMLTable(qb_fp, stringsAsFactors = FALSE)$data
rb_fp <- getURL(paste0("https://www.fantasypros.com/nfl/projections/rb.php?week=", week_no))
rb_fp <- readHTMLTable(rb_fp, stringsAsFactors = FALSE)$data
wr_fp <- getURL(paste0("https://www.fantasypros.com/nfl/projections/wr.php?week=", week_no))
wr_fp <- readHTMLTable(wr_fp, stringsAsFactors = FALSE)$data
te_fp <- getURL(paste0("https://www.fantasypros.com/nfl/projections/te.php?week=", week_no))
te_fp <- readHTMLTable(te_fp, stringsAsFactors = FALSE)$data
k_fp <- getURL(paste0("https://www.fantasypros.com/nfl/projections/k.php?week=", week_no))
k_fp <- readHTMLTable(k_fp, stringsAsFactors = FALSE)$data
#dst_fp <- getURL(paste0("https://www.fantasypros.com/nfl/projections/dst.php?week=", week))
#dst_fp <- readHTMLTable(dst_fp, stringsAsFactors = FALSE)$data

### Extract important information out of Kicker table
k_fp <- k_fp %>%
  mutate(Field.Goals.Missed = as.numeric(as.character(FGA))-as.numeric(as.character(FG)),
         FGM.XP = as.numeric(as.character(XPT))) %>%
  select(Player, Field.Goals.Missed, FGM.XP)

### Change the Column Name
colnames(qb_fp) <- c("Player", "Pass.Attempts", "Completions", "Passing.Yards", "Passing.Touchdowns", "Interceptions", "Carries", "Rushing.Yards", "Rushing.Touchdowns", "Fumbles.Lost", "Fantasy.Points")
colnames(rb_fp) <- c("Player", "Carries", "Rushing.Yards", "Rushing.Touchdowns", "Receptions", "Receiving.Yards", "Receiving.Touchdowns", "Fumbles.Lost", "Fantasy.Points")
colnames(wr_fp) <- c("Player", "Receptions", "Receiving.Yards", "Receiving.Touchdowns", "Carries", "Rushing.Yards", "Rushing.Touchdowns", "Fumbles.Lost", "Fantasy.Points")
colnames(te_fp) <- c("Player", "Receptions", "Receiving.Yards", "Receiving.Touchdowns", "Fumbles.Lost", "Fantasy.Points")
#colnames(dst_fp) <- c("Player", "Sacks", "Defensive.Interceptions", "Fumbles.Recovered", "Forced.Fumbles", "Defensive.Touchdowns", "Safeties", "Points.Allowed", "Yards.Allowed", "Fantasy.Points")

### Add Position Column 
qb_fp$Position <- as.character("QB")
rb_fp$Position <- as.character("RB")
wr_fp$Position <- as.character("WR")
te_fp$Position <- as.character("TE")
k_fp$Position <- as.character("K")
#dst_fp$Position <- as.character("DST")

### Merge Players Across Positions
projections_fp <- smartbind(qb_fp, rb_fp, wr_fp, te_fp, k_fp)
projections_fp <- projections_fp %>%
  select(Player, Position, everything())

### Remove special characters
projections_fp[3:17] <- apply(projections_fp[3:17], 2, function(x) gsub("\\,", "", x))

### Make Statistics Numeric
projections_fp[3:17] <- as.numeric(unlist(projections_fp[3:17]))

### Get Team Name from Player Names. Clean up the Rest of the Player Names
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
projections_fp$Team <- str_trim(substrRight(projections_fp$Player, 3))
projections_fp$Player <- sub("^\\s*(\\S+\\s+\\S+).*", "\\1", projections_fp$Player) ## Clear everything after the second space

### Clean up and Finalize
projections_fp$Platform <- "FantasyPros"
projections_fp <- projections_fp %>%
  select(-Fantasy.Points) %>%
  select(Platform, Player, Team, Position, everything())
assign(paste0("FantasyPros_Projections"), projections_fp)
rm(qb_fp, rb_fp, wr_fp, te_fp, k_fp, dst_fp, projections_fp)