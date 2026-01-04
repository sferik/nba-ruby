module NBA
  module BoxScoreV3AdvancedTestHelpers
    def player_advanced_data
      {personId: 201_939, firstName: "Stephen", familyName: "Curry",
       teamId: Team::GSW, teamTricode: "GSW", teamCity: "Golden State",
       position: "G", comment: "", statistics: player_advanced_stats}
    end

    def player_advanced_stats
      rating_stats.merge(efficiency_stats, tempo_stats, usage_stats)
    end

    def rating_stats
      {minutes: "32:45", estimatedOffensiveRating: 118.5, offensiveRating: 120.5,
       estimatedDefensiveRating: 108.2, defensiveRating: 106.8,
       estimatedNetRating: 10.3, netRating: 13.7}
    end

    def efficiency_stats
      {assistPercentage: 45.2, assistToTurnover: 2.75, assistRatio: 28.5,
       reboundsOffensivePercentage: 3.2, reboundsDefensivePercentage: 18.6,
       reboundsPercentage: 10.9, turnoverPercentage: 12.3}
    end

    def tempo_stats
      {effectiveFieldGoalPercentage: 0.625, trueShootingPercentage: 0.658,
       estimatedPace: 100.5, pace: 102.3, pacePer40: 101.8,
       possessions: 65, playerImpactEstimate: 18.4}
    end

    def usage_stats
      {usagePercentage: 32.4, estimatedUsagePercentage: 31.8}
    end

    def team_advanced_stats
      {minutes: "240:00", estimatedOffensiveRating: 114.0, offensiveRating: 115.2,
       estimatedDefensiveRating: 106.0, defensiveRating: 105.5,
       estimatedNetRating: 8.0, netRating: 9.7, assistPercentage: 60.0,
       assistToTurnover: 2.0, assistRatio: 20.0}.merge(team_rebound_stats)
    end

    def team_rebound_stats
      {reboundsOffensivePercentage: 25.0, reboundsDefensivePercentage: 75.0,
       reboundsPercentage: 50.0, turnoverPercentage: 12.0,
       effectiveFieldGoalPercentage: 0.55, trueShootingPercentage: 0.58,
       estimatedPace: 100.0, pace: 101.0, pacePer40: 100.5,
       possessions: 100, playerImpactEstimate: 50.0}
    end
  end
end
