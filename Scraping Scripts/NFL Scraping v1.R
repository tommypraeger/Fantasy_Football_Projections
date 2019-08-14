library(tidyverse)
library(XML)
library(RCurl)
library(gtools)
library(stringr)
library(httr)

### Set up the Original Table
nfl_proj_url <- GET(paste0("https://fantasy.nfl.com/research/projections#researchProjections=researchProjections%2C%2Fresearch%2Fprojections%253Foffset%253D1%2526position%253DO%2526sort%253DprojectedPts%2526statCategory%253DprojectedStats%2526statSeason%253D", season, "%2526statType%253DseasonProjectedStats%2526statWeek%253D1%2Creplace"))
nfl_proj <- readHTMLTable(htmlParse(nfl_proj_url), stringsAsFactors = FALSE)$`NULL`

### Scrape the rest and add it
pages <- c(26, 51, 76, 101, 126, 151, 176, 201, 226, 251, 276, 301, 326, 351, 376, 401, 426, 451, 476, 501, 526, 551, 576, 601, 626, 651, 676, 701, 726, 751, 776)
for(pages in pages){
nfl_proj_url <- getURL(paste0("https://fantasy.nfl.com/research/projections#researchProjections=researchProjections%2C%2Fresearch%2Fprojections%253Foffset%253D", pages, "%2526position%253DO%2526sort%253DprojectedPts%2526statCategory%253DprojectedStats%2526statSeason%253D", season, "%2526statType%253DseasonProjectedStats%2526statWeek%253D1%2Creplace"))
nfl_proj_placeholder <- readHTMLTable(nfl_proj_url, stringsAsFactors = FALSE)$`NULL`
nfl_proj <- smartbind(nfl_proj, nfl_proj_placeholder)
}