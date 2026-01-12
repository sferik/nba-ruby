module NBA
  module BoxScoreMatchupsV3TestHelpers
    def matchup_data
      team_identity_data.merge(offensive_player_data, defensive_player_data, matchup_stats_data)
    end

    def team_identity_data
      {
        teamId: Team::GSW, teamCity: "Golden State", teamName: "Warriors",
        teamTricode: "GSW", teamSlug: "warriors"
      }
    end

    def offensive_player_data
      {
        personIdOff: 201_939, firstNameOff: "Stephen", familyNameOff: "Curry",
        nameIOff: "S. Curry", playerSlugOff: "stephen-curry", jerseyNumOff: "30"
      }
    end

    def defensive_player_data
      {
        personIdDef: 203_507, firstNameDef: "Giannis", familyNameDef: "Antetokounmpo",
        nameIDef: "G. Antetokounmpo", playerSlugDef: "giannis-antetokounmpo",
        positionDef: "F", commentDef: "", jerseyNumDef: "34"
      }
    end

    def matchup_stats_data
      matchup_time_data.merge(matchup_scoring_data, matchup_shooting_data,
        help_defense_data, free_throw_data)
    end

    def matchup_time_data
      {
        matchupMinutes: "05:30", matchupMinutesSort: 5.5, partialPossessions: 12.5,
        percentageDefenderTotalTime: 0.15, percentageOffensiveTotalTime: 0.18,
        percentageTotalTimeBothOn: 0.25, switchesOn: 3
      }
    end

    def matchup_scoring_data
      {
        playerPoints: 8, teamPoints: 12, matchupAssists: 2,
        matchupPotentialAssists: 3, matchupTurnovers: 1, matchupBlocks: 0
      }
    end

    def matchup_shooting_data
      {
        matchupFieldGoalsMade: 3, matchupFieldGoalsAttempted: 6,
        matchupFieldGoalsPercentage: 0.5, matchupThreePointersMade: 1,
        matchupThreePointersAttempted: 3, matchupThreePointersPercentage: 0.333
      }
    end

    def help_defense_data
      {
        helpBlocks: 1, helpFieldGoalsMade: 2, helpFieldGoalsAttempted: 4,
        helpFieldGoalsPercentage: 0.5
      }
    end

    def free_throw_data
      {matchupFreeThrowsMade: 2, matchupFreeThrowsAttempted: 2, shootingFouls: 1}
    end

    def matchups_v3_response
      {boxScoreMatchups: {homeTeam: home_team_matchups, awayTeam: away_team_matchups}}
    end

    def home_team_matchups
      {
        teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
        teamCity: "Golden State", players: [matchup_data]
      }
    end

    def away_team_matchups
      {
        teamId: Team::MIL, teamName: "Bucks", teamTricode: "MIL",
        teamCity: "Milwaukee", players: []
      }
    end
  end
end
