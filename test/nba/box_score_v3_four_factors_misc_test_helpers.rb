module NBA
  module BoxScoreV3FourFactorsMiscTestHelpers
    def four_factors_player_data
      {personId: 201_939, firstName: "Stephen", familyName: "Curry",
       teamId: Team::GSW, teamTricode: "GSW", teamCity: "Golden State",
       position: "G", comment: "", statistics: four_factors_player_stats}
    end

    def four_factors_player_stats
      {minutes: "32:45", effectiveFieldGoalPercentage: 0.625,
       freeThrowAttemptRate: 0.25, teamTurnoverPercentage: 12.0,
       offensiveReboundPercentage: 25.0, oppEffectiveFieldGoalPercentage: 0.48,
       oppFreeThrowAttemptRate: 0.22, oppTurnoverPercentage: 15.0,
       oppOffensiveReboundPercentage: 20.0}
    end

    def four_factors_team_stats
      {minutes: "240:00", effectiveFieldGoalPercentage: 0.55,
       freeThrowAttemptRate: 0.20, teamTurnoverPercentage: 11.0,
       offensiveReboundPercentage: 28.0, oppEffectiveFieldGoalPercentage: 0.50,
       oppFreeThrowAttemptRate: 0.18, oppTurnoverPercentage: 14.0,
       oppOffensiveReboundPercentage: 22.0}
    end

    def misc_player_data
      {personId: 201_939, firstName: "Stephen", familyName: "Curry",
       teamId: Team::GSW, teamTricode: "GSW", teamCity: "Golden State",
       position: "G", comment: "", statistics: misc_player_stats}
    end

    def misc_player_stats
      {minutes: "32:45", pointsOffTurnovers: 8, pointsSecondChance: 4,
       pointsFastBreak: 6, pointsPaint: 10, oppPointsOffTurnovers: 2,
       oppPointsSecondChance: 2, oppPointsFastBreak: 4, oppPointsPaint: 6,
       blocks: 0, blocksAgainst: 1, foulsPersonal: 2, foulsDrawn: 3}
    end

    def misc_team_stats
      {minutes: "240:00", pointsOffTurnovers: 20, pointsSecondChance: 14,
       pointsFastBreak: 18, pointsPaint: 48, oppPointsOffTurnovers: 12,
       oppPointsSecondChance: 10, oppPointsFastBreak: 14, oppPointsPaint: 40,
       blocks: 5, blocksAgainst: 3, foulsPersonal: 18, foulsDrawn: 22}
    end
  end
end
