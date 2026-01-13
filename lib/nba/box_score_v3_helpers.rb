module NBA
  # Shared helper methods for V3 box score modules
  # @api private
  module BoxScoreV3Helpers
    # Extracts player identity attributes from V3 API format
    # @api private
    # @return [Hash] player identity attributes
    def self.player_identity(player, game_id)
      {game_id: game_id, team_id: player["teamId"],
       team_abbreviation: player["teamTricode"],
       team_city: player["teamCity"],
       player_id: player["personId"],
       player_name: build_player_name(player),
       start_position: player["position"],
       comment: player["comment"]}
    end

    # Extracts team identity attributes from V3 API format
    # @api private
    # @return [Hash] team identity attributes
    def self.team_identity(team, game_id)
      {game_id: game_id, team_id: team["teamId"],
       team_name: team["teamName"],
       team_abbreviation: team["teamTricode"],
       team_city: team["teamCity"]}
    end

    # Builds player full name from first and family name
    # @api private
    # @param player [Hash] player data from V3 API
    # @return [String] player full name
    def self.build_player_name(player)
      first = player["firstName"]
      last = player["familyName"]
      "#{first} #{last}".strip
    end

    # Extracts all players from box score data
    # @api private
    # @param data [Hash] parsed JSON response
    # @param box_score_key [String] key to access box score data
    # @return [Array, nil] array of player data or nil if not found
    def self.extract_players(data, box_score_key)
      box_score = data[box_score_key]
      return unless box_score

      home = box_score.dig("homeTeam", "players") || []
      away = box_score.dig("awayTeam", "players") || []
      home + away
    end

    # Extracts both teams from box score data
    # @api private
    # @param data [Hash] parsed JSON response
    # @param box_score_key [String] key to access box score data
    # @return [Array, nil] array of team data or nil if not found
    def self.extract_teams(data, box_score_key)
      box_score = data[box_score_key]
      return unless box_score

      [box_score["homeTeam"], box_score["awayTeam"]].compact
    end

    # Extracts shooting statistics from V3 API format
    # @api private
    # @return [Hash] shooting statistics
    def self.shooting_stats(stats)
      field_goal_stats(stats).merge(free_throw_stats(stats))
    end

    # Extracts field goal statistics from V3 API format
    # @api private
    # @param stats [Hash] statistics data from V3 API
    # @return [Hash] field goal statistics
    def self.field_goal_stats(stats)
      {fgm: stats["fieldGoalsMade"], fga: stats["fieldGoalsAttempted"],
       fg_pct: stats["fieldGoalsPercentage"], fg3m: stats["threePointersMade"],
       fg3a: stats["threePointersAttempted"], fg3_pct: stats["threePointersPercentage"]}
    end

    # Extracts free throw statistics from V3 API format
    # @api private
    # @param stats [Hash] statistics data from V3 API
    # @return [Hash] free throw statistics
    def self.free_throw_stats(stats)
      {ftm: stats["freeThrowsMade"], fta: stats["freeThrowsAttempted"],
       ft_pct: stats["freeThrowsPercentage"]}
    end

    # Extracts counting statistics from V3 API format
    # @api private
    # @return [Hash] counting statistics
    def self.counting_stats(stats)
      rebound_stats(stats).merge(other_counting_stats(stats))
    end

    # Extracts rebound and assist statistics from V3 API format
    # @api private
    # @param stats [Hash] statistics data from V3 API
    # @return [Hash] rebound and assist statistics
    def self.rebound_stats(stats)
      {oreb: stats["reboundsOffensive"], dreb: stats["reboundsDefensive"],
       reb: stats["reboundsTotal"], ast: stats["assists"]}
    end

    # Extracts other counting statistics from V3 API format
    # @api private
    # @param stats [Hash] statistics data from V3 API
    # @return [Hash] steals, blocks, turnovers, fouls, points, plus/minus
    def self.other_counting_stats(stats)
      {stl: stats["steals"], blk: stats["blocks"],
       tov: stats["turnovers"], pf: stats["foulsPersonal"],
       pts: stats["points"], plus_minus: stats["plusMinusPoints"]}
    end

    # Extracts advanced rating statistics from V3 API format
    # @api private
    # @return [Hash] rating statistics
    def self.advanced_rating_stats(stats)
      {e_off_rating: stats["estimatedOffensiveRating"], off_rating: stats["offensiveRating"],
       e_def_rating: stats["estimatedDefensiveRating"], def_rating: stats["defensiveRating"],
       e_net_rating: stats["estimatedNetRating"], net_rating: stats["netRating"]}
    end

    # Extracts advanced efficiency statistics from V3 API format
    # @api private
    # @return [Hash] efficiency statistics
    def self.advanced_efficiency_stats(stats)
      {ast_pct: stats["assistPercentage"], ast_tov: stats["assistToTurnover"],
       ast_ratio: stats["assistRatio"], oreb_pct: stats["reboundsOffensivePercentage"],
       dreb_pct: stats["reboundsDefensivePercentage"], reb_pct: stats["reboundsPercentage"],
       tov_pct: stats["turnoverPercentage"], efg_pct: stats["effectiveFieldGoalPercentage"],
       ts_pct: stats["trueShootingPercentage"], pie: stats["playerImpactEstimate"]}
    end

    # Extracts advanced tempo statistics from V3 API format
    # @api private
    # @return [Hash] tempo statistics
    def self.advanced_tempo_stats(stats)
      {e_pace: stats["estimatedPace"], pace: stats["pace"],
       pace_per40: stats["pacePer40"], poss: stats["possessions"]}
    end
  end
end
