module NBA
  module BoxScoreV3TraditionalTestHelpers
    def traditional_player_data
      {personId: 201_939, firstName: "Stephen", familyName: "Curry",
       teamId: Team::GSW, teamTricode: "GSW", teamCity: "Golden State",
       position: "G", comment: "", statistics: traditional_player_stats}
    end

    def traditional_player_stats
      {minutes: "32:45", fieldGoalsMade: 10, fieldGoalsAttempted: 20,
       fieldGoalsPercentage: 0.5, threePointersMade: 6, threePointersAttempted: 12,
       threePointersPercentage: 0.5, freeThrowsMade: 6, freeThrowsAttempted: 7,
       freeThrowsPercentage: 0.857, reboundsOffensive: 1, reboundsDefensive: 4,
       reboundsTotal: 5, assists: 8, steals: 2, blocks: 0, turnovers: 3,
       foulsPersonal: 2, points: 32, plusMinusPoints: 12}
    end

    def traditional_team_stats
      {minutes: "240:00", fieldGoalsMade: 42, fieldGoalsAttempted: 88,
       fieldGoalsPercentage: 0.477, threePointersMade: 15, threePointersAttempted: 38,
       threePointersPercentage: 0.395, freeThrowsMade: 13, freeThrowsAttempted: 16,
       freeThrowsPercentage: 0.813, reboundsOffensive: 10, reboundsDefensive: 35,
       reboundsTotal: 45, assists: 28, steals: 8, blocks: 5, turnovers: 12,
       foulsPersonal: 18, points: 112, plusMinusPoints: 8}
    end

    def starter_bench_stats
      {minutes: "120:00", fieldGoalsMade: 25, fieldGoalsAttempted: 50,
       fieldGoalsPercentage: 0.5, threePointersMade: 10, threePointersAttempted: 20,
       threePointersPercentage: 0.5, freeThrowsMade: 10, freeThrowsAttempted: 12,
       freeThrowsPercentage: 0.833, reboundsOffensive: 5, reboundsDefensive: 20,
       reboundsTotal: 25, assists: 14, steals: 4, blocks: 3, turnovers: 6,
       foulsPersonal: 10, points: 70, plusMinusPoints: 5}
    end
  end
end
