### Bind all the projections together
Combined_Projections <- smartbind(CBS_Projections, ESPN_Projections, Sleeper_Projections, FantasySharks_Projections, Yahoo_Projections, FantasyPros_Projections)

### Remove Funky Characters
Combined_Projections$Player <- str_replace_all(Combined_Projections$Player, "III ", "")
Combined_Projections$Player <- str_replace_all(Combined_Projections$Player, "II ", "")
Combined_Projections$Player <- str_replace_all(Combined_Projections$Player, "Jr.", "")
Combined_Projections$Player <- str_replace_all(Combined_Projections$Player, "Sr.", "")
Combined_Projections$Player <- str_replace_all(Combined_Projections$Player, "IV ", " ")
Combined_Projections$Player <- str_replace_all(Combined_Projections$Player, "V ", " ")

### Trim White Space One Last Time
Combined_Projections$Player <- sub("^\\s*(\\S+\\s+\\S+).*", "\\1", Combined_Projections$Player) ## Clear everything after the second space 
Combined_Projections$Team <- sub("^\\s*(\\S+\\s+\\S+).*", "\\1", Combined_Projections$Team) ## Clear everything after the second space 
Combined_Projections$Position <- sub("^\\s*(\\S+\\s+\\S+).*", "\\1", Combined_Projections$Position) ## Clear everything after the second space 
Combined_Projections$Player <- gsub("[.]","",Combined_Projections$Player) 
Combined_Projections$Team <- gsub(" ","",Combined_Projections$Team) 
Combined_Projections$Team <- toupper(Combined_Projections$Team)
Combined_Projections$Position <- gsub(" ","",Combined_Projections$Position) 
Combined_Projections$Position <- trimws(Combined_Projections$Position)

### Fix Capitalization in Names
simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}
Combined_Projections$Player <- sapply(Combined_Projections$Player, simpleCap)

### Change Some Positions
Combined_Projections$Position <- gsub("FB","RB",Combined_Projections$Position) 
Combined_Projections$Position <- gsub("OT","TE",Combined_Projections$Position) 

### Change to Numeric
Combined_Projections$FGM.XP <- as.numeric(Combined_Projections$FGM.XP)
Combined_Projections$FGM.1_39 <- as.numeric(Combined_Projections$FGM.1_39)
Combined_Projections$FGM.40_49 <- as.numeric(Combined_Projections$FGM.40_49)
Combined_Projections$FGM.50. <- as.numeric(Combined_Projections$FGM.50.)

### Change Mitchell Trubisky
Combined_Projections <- as.data.table(Combined_Projections)
Combined_Projections[which(Combined_Projections$Player == "Mitch Trubisky"), Player := "Mitchell Trubisky"]