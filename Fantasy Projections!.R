###
# By Jonathan Goldberg (Gberg1303)
# Use the VOR and League Scoring Documents to set up the information for your league! 
###


### Load the Functions
source(paste0(getwd(), '/Projections_Main.R'))


### Run the Function: Fantasy_Football_Projections(): Week = 0 implies the draft
Fantasy_Football_Projections(sources = c("CBS", "ESPN", "FantasySharks", "Sleeper", "Yahoo", "FantasyPros"), Week = 0, Season = 2019, Scoring = "PPR", VOR = "Standard")
