module NBA
  module BoxScoreV3ScoringUsageTestHelpers
    def scoring_player_data
      {personId: 201_939, firstName: "Stephen", familyName: "Curry",
       teamId: Team::GSW, teamTricode: "GSW", teamCity: "Golden State",
       position: "G", comment: "", statistics: scoring_player_stats}
    end

    def scoring_player_stats
      {minutes: "32:45", percentageFieldGoalsAttempted2pt: 0.35,
       percentageFieldGoalsAttempted3pt: 0.65, percentagePoints2pt: 0.30,
       percentagePointsMidrange2pt: 0.10, percentagePoints3pt: 0.55,
       percentagePointsFastBreak: 0.08, percentagePointsFreeThrow: 0.07,
       percentagePointsOffTurnovers: 0.05, percentagePointsPaint: 0.20,
       percentageAssisted2pt: 0.50, percentageUnassisted2pt: 0.50,
       percentageAssisted3pt: 0.90, percentageUnassisted3pt: 0.10,
       percentageAssistedFieldGoals: 0.85,
       percentageUnassistedFieldGoals: 0.15}
    end

    def scoring_team_stats
      {minutes: "240:00", percentageFieldGoalsAttempted2pt: 0.45,
       percentageFieldGoalsAttempted3pt: 0.55, percentagePoints2pt: 0.40,
       percentagePointsMidrange2pt: 0.15, percentagePoints3pt: 0.45,
       percentagePointsFastBreak: 0.12, percentagePointsFreeThrow: 0.03,
       percentagePointsOffTurnovers: 0.10, percentagePointsPaint: 0.30,
       percentageAssisted2pt: 0.65, percentageUnassisted2pt: 0.35,
       percentageAssisted3pt: 0.80, percentageUnassisted3pt: 0.20,
       percentageAssistedFieldGoals: 0.70,
       percentageUnassistedFieldGoals: 0.30}
    end

    def scoring_v3_response
      {boxScoreScoring: {homeTeam: scoring_home_team,
                         awayTeam: scoring_away_team}}
    end

    def scoring_home_team
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State", statistics: scoring_team_stats,
       players: [scoring_player_data]}
    end

    def scoring_away_team
      {teamId: Team::LAL, teamName: "Lakers", teamTricode: "LAL",
       teamCity: "Los Angeles", statistics: scoring_team_stats, players: []}
    end

    def usage_player_data
      {personId: 201_939, firstName: "Stephen", familyName: "Curry",
       teamId: Team::GSW, teamTricode: "GSW", teamCity: "Golden State",
       position: "G", comment: "", statistics: usage_player_stats}
    end

    def usage_player_stats
      {minutes: "32:45", usagePercentage: 32.4,
       percentageFieldGoalsMade: 0.25, percentageFieldGoalsAttempted: 0.30,
       percentageThreePointersMade: 0.40, percentageThreePointersAttempted: 0.35,
       percentageFreeThrowsMade: 0.20, percentageFreeThrowsAttempted: 0.22,
       percentageReboundsOffensive: 0.10, percentageReboundsDefensive: 0.12,
       percentageReboundsTotal: 0.11, percentageAssists: 0.28,
       percentageTurnovers: 0.25, percentageSteals: 0.15,
       percentageBlocks: 0.05, percentageBlocksAgainst: 0.08,
       percentageFoulsPersonal: 0.18, percentageFoulsDrawn: 0.20,
       percentagePoints: 0.40}
    end

    def usage_team_stats
      {minutes: "240:00", usagePercentage: 100.0,
       percentageFieldGoalsMade: 1.0, percentageFieldGoalsAttempted: 1.0,
       percentageThreePointersMade: 1.0, percentageThreePointersAttempted: 1.0,
       percentageFreeThrowsMade: 1.0, percentageFreeThrowsAttempted: 1.0,
       percentageReboundsOffensive: 1.0, percentageReboundsDefensive: 1.0,
       percentageReboundsTotal: 1.0, percentageAssists: 1.0,
       percentageTurnovers: 1.0, percentageSteals: 1.0,
       percentageBlocks: 1.0, percentageBlocksAgainst: 1.0,
       percentageFoulsPersonal: 1.0, percentageFoulsDrawn: 1.0,
       percentagePoints: 1.0}
    end

    def stub_player_response(player_data)
      response = {
        boxScoreScoring: {
          homeTeam: {players: [player_data]},
          awayTeam: {players: []}
        }
      }
      stub_request(:get, /boxscorescoringv3/)
        .to_return(body: response.to_json)
    end

    def stub_team_response(home_team, away_team = nil)
      response = {boxScoreScoring: {homeTeam: home_team, awayTeam: away_team}}
      stub_request(:get, /boxscorescoringv3/)
        .to_return(body: response.to_json)
    end
  end
end
