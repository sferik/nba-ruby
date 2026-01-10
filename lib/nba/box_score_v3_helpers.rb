module NBA
  # Shared helper methods for V3 box score modules
  # @api private
  module BoxScoreV3Helpers
    # Extracts player identity attributes from V3 API format
    # @api private
    # @return [Hash] player identity attributes
    def self.player_identity(player, game_id)
      {game_id: game_id, team_id: player.fetch("teamId", nil),
       team_abbreviation: player.fetch("teamTricode", nil),
       team_city: player.fetch("teamCity", nil),
       player_id: player.fetch("personId", nil),
       player_name: build_player_name(player),
       start_position: player.fetch("position", nil),
       comment: player.fetch("comment", nil)}
    end

    # Extracts team identity attributes from V3 API format
    # @api private
    # @return [Hash] team identity attributes
    def self.team_identity(team, game_id)
      {game_id: game_id, team_id: team.fetch("teamId", nil),
       team_name: team.fetch("teamName", nil),
       team_abbreviation: team.fetch("teamTricode", nil),
       team_city: team.fetch("teamCity", nil)}
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
      box_score = data.fetch(box_score_key, nil)
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
      box_score = data.fetch(box_score_key, nil)
      return unless box_score

      [box_score.fetch("homeTeam", nil), box_score.fetch("awayTeam", nil)].compact
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
      {fgm: stats.fetch("fieldGoalsMade", nil), fga: stats.fetch("fieldGoalsAttempted", nil),
       fg_pct: stats.fetch("fieldGoalsPercentage", nil), fg3m: stats.fetch("threePointersMade", nil),
       fg3a: stats.fetch("threePointersAttempted", nil), fg3_pct: stats.fetch("threePointersPercentage", nil)}
    end

    # Extracts free throw statistics from V3 API format
    # @api private
    # @param stats [Hash] statistics data from V3 API
    # @return [Hash] free throw statistics
    def self.free_throw_stats(stats)
      {ftm: stats.fetch("freeThrowsMade", nil), fta: stats.fetch("freeThrowsAttempted", nil),
       ft_pct: stats.fetch("freeThrowsPercentage", nil)}
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
      {oreb: stats.fetch("reboundsOffensive", nil), dreb: stats.fetch("reboundsDefensive", nil),
       reb: stats.fetch("reboundsTotal", nil), ast: stats.fetch("assists", nil)}
    end

    # Extracts other counting statistics from V3 API format
    # @api private
    # @param stats [Hash] statistics data from V3 API
    # @return [Hash] steals, blocks, turnovers, fouls, points, plus/minus
    def self.other_counting_stats(stats)
      {stl: stats.fetch("steals", nil), blk: stats.fetch("blocks", nil),
       tov: stats.fetch("turnovers", nil), pf: stats.fetch("foulsPersonal", nil),
       pts: stats.fetch("points", nil), plus_minus: stats.fetch("plusMinusPoints", nil)}
    end

    # Extracts advanced rating statistics from V3 API format
    # @api private
    # @return [Hash] rating statistics
    def self.advanced_rating_stats(stats)
      {e_off_rating: stats.fetch("estimatedOffensiveRating", nil), off_rating: stats.fetch("offensiveRating", nil),
       e_def_rating: stats.fetch("estimatedDefensiveRating", nil), def_rating: stats.fetch("defensiveRating", nil),
       e_net_rating: stats.fetch("estimatedNetRating", nil), net_rating: stats.fetch("netRating", nil)}
    end

    # Extracts advanced efficiency statistics from V3 API format
    # @api private
    # @return [Hash] efficiency statistics
    def self.advanced_efficiency_stats(stats)
      {ast_pct: stats.fetch("assistPercentage", nil), ast_tov: stats.fetch("assistToTurnover", nil),
       ast_ratio: stats.fetch("assistRatio", nil), oreb_pct: stats.fetch("reboundsOffensivePercentage", nil),
       dreb_pct: stats.fetch("reboundsDefensivePercentage", nil), reb_pct: stats.fetch("reboundsPercentage", nil),
       tov_pct: stats.fetch("turnoverPercentage", nil), efg_pct: stats.fetch("effectiveFieldGoalPercentage", nil),
       ts_pct: stats.fetch("trueShootingPercentage", nil), pie: stats.fetch("playerImpactEstimate", nil)}
    end

    # Extracts advanced tempo statistics from V3 API format
    # @api private
    # @return [Hash] tempo statistics
    def self.advanced_tempo_stats(stats)
      {e_pace: stats.fetch("estimatedPace", nil), pace: stats.fetch("pace", nil),
       pace_per40: stats.fetch("pacePer40", nil), poss: stats.fetch("possessions", nil)}
    end
  end
end
