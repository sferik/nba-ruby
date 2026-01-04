require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_advanced_player_stat"
require_relative "box_score_advanced_team_stat"
require_relative "box_score_v3_helpers"
require_relative "utils"

module NBA
  # Provides methods to retrieve advanced box score statistics using V3 API
  module BoxScoreAdvancedV3
    # @return [String] JSON key for advanced box score data
    BOX_SCORE_KEY = "boxScoreAdvanced".freeze
    # @return [String] JSON key for player statistics
    PLAYER_STATS = "PlayerStats".freeze
    # @return [String] JSON key for team statistics
    TEAM_STATS = "TeamStats".freeze

    # Retrieves advanced player box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreAdvancedV3.player_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.player_name}: #{stat.off_rating}" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player advanced stats
    def self.player_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_player_response(response, game_id)
    end

    # Retrieves advanced team box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreAdvancedV3.team_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.team_abbreviation}: #{stat.off_rating}" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team advanced stats
    def self.team_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_team_response(response, game_id)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(game_id, start_period, end_period)
      "boxscoreadvancedv3?GameID=#{game_id}&StartPeriod=#{start_period}" \
        "&EndPeriod=#{end_period}&StartRange=0&EndRange=0&RangeType=0"
    end
    private_class_method :build_path

    # Parses the API response into player stat objects
    # @api private
    # @return [Collection] collection of player stats
    def self.parse_player_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      players = BoxScoreV3Helpers.extract_players(data, BOX_SCORE_KEY)
      return Collection.new unless players

      Collection.new(players.map { |p| build_player_stat(p, game_id) })
    end
    private_class_method :parse_player_response

    # Parses the API response into team stat objects
    # @api private
    # @return [Collection] collection of team stats
    def self.parse_team_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      teams = BoxScoreV3Helpers.extract_teams(data, BOX_SCORE_KEY)
      return Collection.new unless teams

      Collection.new(teams.map { |t| build_team_stat(t, game_id) })
    end
    private_class_method :parse_team_response

    # Builds a player stat object from raw data
    # @api private
    # @return [BoxScoreAdvancedPlayerStat] the player stat object
    def self.build_player_stat(player, game_id)
      stats = player.fetch("statistics", {})
      BoxScoreAdvancedPlayerStat.new(
        **BoxScoreV3Helpers.player_identity(player, game_id),
        min: stats.fetch("minutes", nil),
        **rating_stats(stats), **efficiency_stats(stats),
        **tempo_stats(stats), **player_usage_stats(stats)
      )
    end
    private_class_method :build_player_stat

    # Builds a team stat object from raw data
    # @api private
    # @return [BoxScoreAdvancedTeamStat] the team stat object
    def self.build_team_stat(team, game_id)
      stats = team.fetch("statistics", {})
      BoxScoreAdvancedTeamStat.new(
        **BoxScoreV3Helpers.team_identity(team, game_id),
        min: stats.fetch("minutes", nil),
        **rating_stats(stats), **efficiency_stats(stats), **tempo_stats(stats)
      )
    end
    private_class_method :build_team_stat

    # Extracts rating statistics from raw data
    # @api private
    # @return [Hash] rating statistics
    def self.rating_stats(stats)
      {
        e_off_rating: stats.fetch("estimatedOffensiveRating", nil),
        off_rating: stats.fetch("offensiveRating", nil),
        e_def_rating: stats.fetch("estimatedDefensiveRating", nil),
        def_rating: stats.fetch("defensiveRating", nil),
        e_net_rating: stats.fetch("estimatedNetRating", nil),
        net_rating: stats.fetch("netRating", nil)
      }
    end
    private_class_method :rating_stats

    # Extracts efficiency statistics from raw data
    # @api private
    # @return [Hash] efficiency statistics
    def self.efficiency_stats(stats)
      assist_stats(stats).merge(rebound_pct_stats(stats), shooting_pct_stats(stats))
    end
    private_class_method :efficiency_stats

    # Extracts assist statistics from raw data
    # @api private
    # @return [Hash] assist statistics
    def self.assist_stats(stats)
      {ast_pct: stats.fetch("assistPercentage", nil), ast_tov: stats.fetch("assistToTurnover", nil),
       ast_ratio: stats.fetch("assistRatio", nil)}
    end
    private_class_method :assist_stats

    # Extracts rebound percentage statistics from raw data
    # @api private
    # @return [Hash] rebound percentage statistics
    def self.rebound_pct_stats(stats)
      {oreb_pct: stats.fetch("reboundsOffensivePercentage", nil),
       dreb_pct: stats.fetch("reboundsDefensivePercentage", nil),
       reb_pct: stats.fetch("reboundsPercentage", nil), tov_pct: stats.fetch("turnoverPercentage", nil)}
    end
    private_class_method :rebound_pct_stats

    # Extracts shooting percentage statistics from raw data
    # @api private
    # @return [Hash] shooting percentage statistics
    def self.shooting_pct_stats(stats)
      {efg_pct: stats.fetch("effectiveFieldGoalPercentage", nil),
       ts_pct: stats.fetch("trueShootingPercentage", nil), pie: stats.fetch("playerImpactEstimate", nil)}
    end
    private_class_method :shooting_pct_stats

    # Extracts tempo statistics from raw data
    # @api private
    # @return [Hash] tempo statistics
    def self.tempo_stats(stats)
      {
        e_pace: stats.fetch("estimatedPace", nil),
        pace: stats.fetch("pace", nil),
        pace_per40: stats.fetch("pacePer40", nil),
        poss: stats.fetch("possessions", nil)
      }
    end
    private_class_method :tempo_stats

    # Extracts player usage statistics from raw data
    # @api private
    # @return [Hash] usage statistics
    def self.player_usage_stats(stats)
      {
        usg_pct: stats.fetch("usagePercentage", nil),
        e_usg_pct: stats.fetch("estimatedUsagePercentage", nil)
      }
    end
    private_class_method :player_usage_stats
  end
end
