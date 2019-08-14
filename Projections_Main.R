library(tidyverse)
library(dplyr)
library(stringr)
library(gtools)
library(mclust)
library(XML)
library(RCurl)
library(jsonlite)
library(data.table)
library(httr)

### Create the main function.
    # Week = 0 Implies the Preseason Draft Rankikngs
Fantasy_Football_Projections <- function(sources = c("CBS", "ESPN", "FantasySharks", "Sleeper", "Yahoo", "FantasyPros"), Week, Season, Scoring = c("PPR", "Standard", "Custom"), VOR = c("Standard", "Custom")) {
  
### Set Week and Season and Scoring Setting
  assign("Scoring", Scoring, envir = .GlobalEnv)
  assign("VOR", VOR, envir = .GlobalEnv)
  assign("week", Week, envir = .GlobalEnv)
  assign("season", Season, envir = .GlobalEnv)
  
### Source the Projection Files
  ifelse(sources == "CBS", source(paste0(getwd(), '/Scraping Scripts/CBS Projections v1.R'), echo=TRUE), print(sources))
  ifelse(sources == "ESPN", source(paste0(getwd(), '/Scraping Scripts/ESPN Projections v1.R'), echo=TRUE), print(sources))
  ifelse(sources == "FantasySharks", source(paste0(getwd(), '/Scraping Scripts/FantasySharks Projections v1.R'), echo=TRUE), print(sources))
  ifelse(sources == "Sleeper", source(paste0(getwd(), '/Scraping Scripts/Sleeper Projections v1.R'), echo=TRUE), print(sources))
  ifelse(sources == "Yahoo", source(paste0(getwd(), '/Scraping Scripts/Yahoo Projections v1.R'), echo=TRUE), print(sources))
  ifelse(sources == "FantasyPros", source(paste0(getwd(), '/Scraping Scripts/FantasyPros Projections v1.R'), echo=TRUE), print(sources))


### Load Settings
source(paste0(getwd(), '/Scoring Settings.R'), echo=TRUE)
source(paste0(getwd(), '/Value Over Replacement Settings.R'), echo=TRUE)
  
### Combine the Projections and Clean Combined Projections
source(paste0(getwd(), '/File Management/Clean Combined Projections.R'), echo=TRUE)

### Score Fantasy Points Based on League Settings
source(paste0(getwd(), '/Calculations/Invididual Fantasy Points.R'), echo=TRUE)


### Average the Statistics 
source(paste0(getwd(), '/Calculations/Average Projections.R'), echo=TRUE)

### Add Advanced Metrics to the Fantasy Projections
source(paste0(getwd(), '/Calculations/Average Fantasy Points.R'), echo=TRUE)
source(paste0(getwd(), '/Calculations/Risk.R'), echo=TRUE)
source(paste0(getwd(), '/Calculations/Value Over Replacement.R'), echo=TRUE)
source(paste0(getwd(), '/Calculations/Cost.R'), echo=TRUE)
source(paste0(getwd(), '/Calculations/Tiers.R'), echo=TRUE)

### Condense and Finish
source(paste0(getwd(), '/File Management/Finalize Projections.R'), echo=TRUE)

### Remove the Extras
source(paste0(getwd(), '/File Management/Remove Values.R'), echo=TRUE)
}
