PPR = list(
  pass = list(
    Pass.Attempts = 0, Completions = 0, Incompletions = 0, Passing.Yards = 0.04, Passing.Touchdowns = 4,
    Interceptions = -2, Forty.Yard.Passes = 0,  Passing.Game.300.Yards = 0, Passing.Game.350.Yards = 0,
    Passing.Game.400.Yards = 0
  ),
  rush = list(
    all_pos = TRUE,
    Rushing.Yards = 0.1,  Carries = 0, Forty.Yard.Rushes = 0, Rushing.Touchdowns = 6,
    Rushing.Game.100.Yards = 0, Rushing.Game.150.Yards = 0, Rushing.Game.200.Yards = 0),
  rec = list(
    all_pos = TRUE,
    Receptions = 1, Receiving.Yards = 0.1, Receiving.Touchdowns = 6, Forty.Yard.Receptions = 0, Receiving.Game.100.Yards = 0,
    Receiving.Game.150.Yards = 0, Receiving.Game.200.Yards = 0
  ),
  misc = list(
    all_pos = TRUE,
    Fumbles.Lost = -1, Fumbles = 0,
    QB.Sacked = 0, `2PT.Conversion` = 2
  ),
  kick = list(
    FGM.XP = 1.0, FGM.0_19 = 3.0,  FGM.20_29 = 3.0, FGM.30_39 = 3.0, FGM.1_39 = 3.0, FGM.40_49 = 4.0,
    FGM.50. = 5.0,  Field.Goals.Missed = -1.0, Extra.Points.Missed = -1.0
  ),
  ret = list(
    all_pos = TRUE,
    Return.Touchdowns = 6, return_yds = 0
  ),
  idp = list(
    all_pos = TRUE,
    idp_solo = 1, idp_asst = 0.5, idp_sack = 2, idp_int = 3,  idp_fum_force = 3,
    idp_fum_rec = 2,  idp_pd = 1, idp_td = 6,  idp_safety = 2
  ),
  dst = list(
    Fumbles.Recovered = 2,  Defensive.Interceptions = 2, Safeties = 2, Sacks = 1, Defensive.Touchdowns = 6,
    Defensive.Kick.Blocks = 1.5, dst_ret_yds = 0, Points.Allowed = -(5/46), Yards.Allowed = -(6/550)
  ),
  pts_bracket = list(
    list(threshold = 0, points = 10),
    list(threshold = 6, points = 7),
    list(threshold = 20, points = 4),
    list(threshold = 34, points = 0),
    list(threshold = 99, points = -4)
  )
)

Standard = list(
  pass = list(
    Pass.Attempts = 0, Completions = 0, Incompletions = 0, Passing.Yards = 0.04, Passing.Touchdowns = 4,
    Interceptions = -2, Forty.Yard.Passes = 0,  Passing.Game.300.Yards = 0, Passing.Game.350.Yards = 0,
    Passing.Game.400.Yards = 0
  ),
  rush = list(
    all_pos = TRUE,
    Rushing.Yards = 0.1,  Carries = 0, Forty.Yard.Rushes = 0, Rushing.Touchdowns = 6,
    Rushing.Game.100.Yards = 0, Rushing.Game.150.Yards = 0, Rushing.Game.200.Yards = 0),
  rec = list(
    all_pos = TRUE,
    Receptions = 0, Receiving.Yards = 0.1, Receiving.Touchdowns = 6, Forty.Yard.Receptions = 0, Receiving.Game.100.Yards = 0,
    Receiving.Game.150.Yards = 0, Receiving.Game.200.Yards = 0
  ),
  misc = list(
    all_pos = TRUE,
    Fumbles.Lost = -1, Fumbles = 0,
    QB.Sacked = 0, `2PT.Conversion` = 2
  ),
  kick = list(
    FGM.XP = 1.0, FGM.0_19 = 3.0,  FGM.20_29 = 3.0, FGM.30_39 = 3.0, FGM.1_39 = 3.0, FGM.40_49 = 4.0,
    FGM.50. = 5.0,  Field.Goals.Missed = -1.0, Extra.Points.Missed = -1.0
  ),
  ret = list(
    all_pos = TRUE,
    Return.Touchdowns = 6, return_yds = 0
  ),
  idp = list(
    all_pos = TRUE,
    idp_solo = 1, idp_asst = 0.5, idp_sack = 2, idp_int = 3,  idp_fum_force = 3,
    idp_fum_rec = 2,  idp_pd = 1, idp_td = 6,  idp_safety = 2
  ),
  dst = list(
    Fumbles.Recovered = 2,  Defensive.Interceptions = 2, Safeties = 2, Sacks = 1, Defensive.Touchdowns = 6,
    Defensive.Kick.Blocks = 1.5, dst_ret_yds = 0, Points.Allowed = -(5/46), Yards.Allowed = -(6/550)
  ),
  pts_bracket = list(
    list(threshold = 0, points = 10),
    list(threshold = 6, points = 7),
    list(threshold = 20, points = 4),
    list(threshold = 34, points = 0),
    list(threshold = 99, points = -4)
  )
)

Custom = list(
  pass = list(
    Pass.Attempts = 0, Completions = 0, Incompletions = 0, Passing.Yards = 0.04, Passing.Touchdowns = 4,
    Interceptions = -2, Forty.Yard.Passes = 0,  Passing.Game.300.Yards = 0, Passing.Game.350.Yards = 0,
    Passing.Game.400.Yards = 0
  ),
  rush = list(
    all_pos = TRUE,
    Rushing.Yards = 0.1,  Carries = 0, Forty.Yard.Rushes = 0, Rushing.Touchdowns = 6,
    Rushing.Game.100.Yards = 0, Rushing.Game.150.Yards = 0, Rushing.Game.200.Yards = 0),
  rec = list(
    all_pos = TRUE,
    Receptions = 1, Receiving.Yards = 0.1, Receiving.Touchdowns = 6, Forty.Yard.Receptions = 0, Receiving.Game.100.Yards = 0,
    Receiving.Game.150.Yards = 0, Receiving.Game.200.Yards = 0
  ),
  misc = list(
    all_pos = TRUE,
    Fumbles.Lost = -1, Fumbles = 0,
    QB.Sacked = 0, `2PT.Conversion` = 2
  ),
  kick = list(
    FGM.XP = 1.0, FGM.0_19 = 3.0,  FGM.20_29 = 3.0, FGM.30_39 = 3.0, FGM.1_39 = 3.0, FGM.40_49 = 4.0,
    FGM.50. = 5.0,  Field.Goals.Missed = -1.0, Extra.Points.Missed = -1.0
  ),
  ret = list(
    all_pos = TRUE,
    Return.Touchdowns = 6, return_yds = 0
  ),
  idp = list(
    all_pos = TRUE,
    idp_solo = 1, idp_asst = 0.5, idp_sack = 2, idp_int = 3,  idp_fum_force = 3,
    idp_fum_rec = 2,  idp_pd = 1, idp_td = 6,  idp_safety = 2
  ),
  dst = list(
    Fumbles.Recovered = 2,  Defensive.Interceptions = 2, Safeties = 2, Sacks = 1, Defensive.Touchdowns = 6,
    Defensive.Kick.Blocks = 1.5, dst_ret_yds = 0, Points.Allowed = -(5/46), Yards.Allowed = -(6/550)
  ),
  pts_bracket = list(
    list(threshold = 0, points = 10),
    list(threshold = 6, points = 7),
    list(threshold = 20, points = 4),
    list(threshold = 34, points = 0),
    list(threshold = 99, points = -4)
  )
)

