library(tidyverse)

### Make NA's Zero
Fantasy_Points <- Average_Fantasy_Projections
Fantasy_Points[is.na(Fantasy_Points)] <- 0


### Calculate Fantasy Points Based on Scoring Settings
if(Scoring == "PPR"){
Fantasy_Points$Average.Fantasy.Points <- (
  (Fantasy_Points$Passing.Yards*PPR[["pass"]][["Passing.Yards"]]) +
  (Fantasy_Points$Completions*PPR[["pass"]][["Completions"]]) +
  (Fantasy_Points$Passing.Touchdowns*PPR[["pass"]][["Passing.Touchdowns"]]) +
  (Fantasy_Points$Interceptions*PPR[["pass"]][["Interceptions"]]) +
  (Fantasy_Points$Pass.Attempts*PPR[["pass"]][["Pass.Attempts"]]) +
  (Fantasy_Points$Rushing.Yards*PPR[["rush"]][["Rushing.Yards"]])+
  (Fantasy_Points$Carries*PPR[["rush"]][["Carries"]])+
  (Fantasy_Points$Rushing.Touchdowns*PPR[["rush"]][["Rushing.Touchdowns"]])+
  (Fantasy_Points$Fumbles.Lost*PPR[["misc"]][["Fumbles.Lost"]])+
  (Fantasy_Points$Receptions*PPR[["rec"]][["Receptions"]])+
  (Fantasy_Points$Receiving.Yards*PPR[["rec"]][["Receiving.Yards"]])+
  (Fantasy_Points$Receiving.Touchdowns*PPR[["rec"]][["Receiving.Touchdowns"]])+
  (Fantasy_Points$FGM.1_39*PPR[["kick"]][["FGM.1_39"]])+
  (Fantasy_Points$FGM.40_49*PPR[["kick"]][["FGM.40_49"]])+
  (Fantasy_Points$FGM.50.*PPR[["kick"]][["FGM.50."]])+
  (Fantasy_Points$Field.Goals.Missed*PPR[["kick"]][["Field.Goals.Missed"]])+
  (Fantasy_Points$Extra.Points.Missed*PPR[["kick"]][["Extra.Points.Missed"]])+
  (Fantasy_Points$FGM.XP*PPR[["kick"]][["FGM.XP"]])+
  (Fantasy_Points$Return.Touchdowns*PPR[["ret"]][["Return.Touchdowns"]])+
  (Fantasy_Points$`2PT.Conversion`*PPR[["misc"]][["2PT.Conversion"]])+
  (Fantasy_Points$Sacks*PPR[["dst"]][["Sacks"]])+
  (Fantasy_Points$Defensive.Interceptions*PPR[["dst"]][["Defensive.Interceptions"]])+
  (Fantasy_Points$Fumbles.Recovered*PPR[["dst"]][["Fumbles.Recovered"]])+
  (Fantasy_Points$Defensive.Touchdowns*PPR[["dst"]][["Defensive.Touchdowns"]])+
  (Fantasy_Points$Points.Allowed*PPR[["dst"]][["Points.Allowed"]])+
  (Fantasy_Points$Yards.Allowed*PPR[["dst"]][["Yards.Allowed"]])+
  (Fantasy_Points$Safeties*PPR[["dst"]][["Safeties"]])
  )
}

if(Scoring == "Standard"){
  Fantasy_Points$Average.Fantasy.Points <- (
    (Fantasy_Points$Passing.Yards*Standard[["pass"]][["Passing.Yards"]]) +
      (Fantasy_Points$Completions*Standard[["pass"]][["Completions"]]) +
      (Fantasy_Points$Passing.Touchdowns*Standard[["pass"]][["Passing.Touchdowns"]]) +
      (Fantasy_Points$Interceptions*Standard[["pass"]][["Interceptions"]]) +
      (Fantasy_Points$Pass.Attempts*Standard[["pass"]][["Pass.Attempts"]]) +
      (Fantasy_Points$Rushing.Yards*Standard[["rush"]][["Rushing.Yards"]])+
      (Fantasy_Points$Carries*Standard[["rush"]][["Carries"]])+
      (Fantasy_Points$Rushing.Touchdowns*Standard[["rush"]][["Rushing.Touchdowns"]])+
      (Fantasy_Points$Fumbles.Lost*Standard[["misc"]][["Fumbles.Lost"]])+
      (Fantasy_Points$Receptions*Standard[["rec"]][["Receptions"]])+
      (Fantasy_Points$Receiving.Yards*Standard[["rec"]][["Receiving.Yards"]])+
      (Fantasy_Points$Receiving.Touchdowns*Standard[["rec"]][["Receiving.Touchdowns"]])+
      (Fantasy_Points$FGM.1_39*Standard[["kick"]][["FGM.1_39"]])+
      (Fantasy_Points$FGM.40_49*Standard[["kick"]][["FGM.40_49"]])+
      (Fantasy_Points$FGM.50.*Standard[["kick"]][["FGM.50."]])+
      (Fantasy_Points$Field.Goals.Missed*Standard[["kick"]][["Field.Goals.Missed"]])+
      (Fantasy_Points$Extra.Points.Missed*Standard[["kick"]][["Extra.Points.Missed"]])+
      (Fantasy_Points$FGM.XP*Standard[["kick"]][["FGM.XP"]])+
      (Fantasy_Points$Return.Touchdowns*Standard[["ret"]][["Return.Touchdowns"]])+
      (Fantasy_Points$`2PT.Conversion`*Standard[["misc"]][["2PT.Conversion"]])+
      (Fantasy_Points$Sacks*Standard[["dst"]][["Sacks"]])+
      (Fantasy_Points$Defensive.Interceptions*Standard[["dst"]][["Defensive.Interceptions"]])+
      (Fantasy_Points$Fumbles.Recovered*Standard[["dst"]][["Fumbles.Recovered"]])+
      (Fantasy_Points$Defensive.Touchdowns*Standard[["dst"]][["Defensive.Touchdowns"]])+
      (Fantasy_Points$Points.Allowed*Standard[["dst"]][["Points.Allowed"]])+
      (Fantasy_Points$Yards.Allowed*Standard[["dst"]][["Yards.Allowed"]])+
      (Fantasy_Points$Safeties*Standard[["dst"]][["Safeties"]])
  )
}

if(Scoring == "Custom"){
  Fantasy_Points$Average.Fantasy.Points <- (
    (Fantasy_Points$Passing.Yards*Custom[["pass"]][["Passing.Yards"]]) +
      (Fantasy_Points$Completions*Custom[["pass"]][["Completions"]]) +
      (Fantasy_Points$Passing.Touchdowns*Custom[["pass"]][["Passing.Touchdowns"]]) +
      (Fantasy_Points$Interceptions*Custom[["pass"]][["Interceptions"]]) +
      (Fantasy_Points$Pass.Attempts*Custom[["pass"]][["Pass.Attempts"]]) +
      (Fantasy_Points$Rushing.Yards*Custom[["rush"]][["Rushing.Yards"]])+
      (Fantasy_Points$Carries*Custom[["rush"]][["Carries"]])+
      (Fantasy_Points$Rushing.Touchdowns*Custom[["rush"]][["Rushing.Touchdowns"]])+
      (Fantasy_Points$Fumbles.Lost*Custom[["misc"]][["Fumbles.Lost"]])+
      (Fantasy_Points$Receptions*Custom[["rec"]][["Receptions"]])+
      (Fantasy_Points$Receiving.Yards*Custom[["rec"]][["Receiving.Yards"]])+
      (Fantasy_Points$Receiving.Touchdowns*Custom[["rec"]][["Receiving.Touchdowns"]])+
      (Fantasy_Points$FGM.1_39*Custom[["kick"]][["FGM.1_39"]])+
      (Fantasy_Points$FGM.40_49*Custom[["kick"]][["FGM.40_49"]])+
      (Fantasy_Points$FGM.50.*Custom[["kick"]][["FGM.50."]])+
      (Fantasy_Points$Field.Goals.Missed*Custom[["kick"]][["Field.Goals.Missed"]])+
      (Fantasy_Points$Extra.Points.Missed*Custom[["kick"]][["Extra.Points.Missed"]])+
      (Fantasy_Points$FGM.XP*Custom[["kick"]][["FGM.XP"]])+
      (Fantasy_Points$Return.Touchdowns*Custom[["ret"]][["Return.Touchdowns"]])+
      (Fantasy_Points$`2PT.Conversion`*Custom[["misc"]][["2PT.Conversion"]])+
      (Fantasy_Points$Sacks*Custom[["dst"]][["Sacks"]])+
      (Fantasy_Points$Defensive.Interceptions*Custom[["dst"]][["Defensive.Interceptions"]])+
      (Fantasy_Points$Fumbles.Recovered*Custom[["dst"]][["Fumbles.Recovered"]])+
      (Fantasy_Points$Defensive.Touchdowns*Custom[["dst"]][["Defensive.Touchdowns"]])+
      (Fantasy_Points$Points.Allowed*Custom[["dst"]][["Points.Allowed"]])+
      (Fantasy_Points$Yards.Allowed*Custom[["dst"]][["Yards.Allowed"]])+
      (Fantasy_Points$Safeties*Custom[["dst"]][["Safeties"]])
  )
}

### Bind Scoring to Combined Projections
Average_Fantasy_Projections$Average.Fantasy.Points <- Fantasy_Points$Average.Fantasy.Points
rm(Fantasy_Points)