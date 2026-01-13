require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_four_factors_player_stat"
require_relative "box_score_four_factors_team_stat"
require_relative "box_score_v3_helpers"
require_relative "utils"

module NBA
  # Provides methods to retrieve four factors box score statistics using V3 API
  module BoxScoreFourFactorsV3
    # @return [String] JSON key for four factors box score data
    BOX_SCORE_KEY = "boxScoreFourFactors".freeze
    # @return [String] JSON key for player statistics
    PLAYER_STATS = "PlayerStats".freeze
    # @return [String] JSON key for team statistics
    TEAM_STATS = "TeamStats".freeze

    # Retrieves four factors player box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreFourFactorsV3.player_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.player_name}: #{stat.efg_pct}" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player four factors stats
    def self.player_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_player_response(response, game_id)
    end

    # Retrieves four factors team box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreFourFactorsV3.team_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.team_abbreviation}: #{stat.efg_pct}" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team four factors stats
    def self.team_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_team_response(response, game_id)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(game_id, start_period, end_period)
      "boxscorefourfactorsv3?GameID=#{game_id}&StartPeriod=#{start_period}" \
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
    # @return [BoxScoreFourFactorsPlayerStat] the player stat object
    def self.build_player_stat(player, game_id)
      stats = player.fetch("statistics", {})
      BoxScoreFourFactorsPlayerStat.new(
        **BoxScoreV3Helpers.player_identity(player, game_id),
        min: stats["minutes"],
        **four_factors_stats(stats)
      )
    end
    private_class_method :build_player_stat

    # Builds a team stat object from raw data
    # @api private
    # @return [BoxScoreFourFactorsTeamStat] the team stat object
    def self.build_team_stat(team, game_id)
      stats = team.fetch("statistics", {})
      BoxScoreFourFactorsTeamStat.new(
        **BoxScoreV3Helpers.team_identity(team, game_id),
        min: stats["minutes"],
        **four_factors_stats(stats)
      )
    end
    private_class_method :build_team_stat

    # Extracts four factors statistics from raw data
    # @api private
    # @return [Hash] four factors statistics
    def self.four_factors_stats(stats)
      {
        efg_pct: stats["effectiveFieldGoalPercentage"],
        fta_rate: stats["freeThrowAttemptRate"],
        tov_pct: stats["teamTurnoverPercentage"],
        oreb_pct: stats["offensiveReboundPercentage"],
        opp_efg_pct: stats["oppEffectiveFieldGoalPercentage"],
        opp_fta_rate: stats["oppFreeThrowAttemptRate"],
        opp_tov_pct: stats["oppTurnoverPercentage"],
        opp_oreb_pct: stats["oppOffensiveReboundPercentage"]
      }
    end
    private_class_method :four_factors_stats
  end
end
