require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_usage_player_stat"
require_relative "box_score_usage_team_stat"
require_relative "box_score_v3_helpers"
require_relative "utils"

module NBA
  # Provides methods to retrieve usage box score statistics using V3 API
  module BoxScoreUsageV3
    # @return [String] JSON key for usage box score data
    BOX_SCORE_KEY = "boxScoreUsage".freeze
    # @return [String] JSON key for player statistics
    PLAYER_STATS = "PlayerStats".freeze
    # @return [String] JSON key for team statistics
    TEAM_STATS = "TeamStats".freeze

    # Retrieves usage player box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreUsageV3.player_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.player_name}: #{stat.usg_pct}" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player usage stats
    def self.player_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_player_response(response, game_id)
    end

    # Retrieves usage team box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreUsageV3.team_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.team_abbreviation}: #{stat.usg_pct}" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team usage stats
    def self.team_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_team_response(response, game_id)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(game_id, start_period, end_period)
      "boxscoreusagev3?GameID=#{game_id}&StartPeriod=#{start_period}" \
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
    # @return [BoxScoreUsagePlayerStat] the player stat object
    def self.build_player_stat(player, game_id)
      stats = player.fetch("statistics", {})
      BoxScoreUsagePlayerStat.new(
        **BoxScoreV3Helpers.player_identity(player, game_id),
        min: stats.fetch("minutes", nil),
        **usage_stats(stats)
      )
    end
    private_class_method :build_player_stat

    # Builds a team stat object from raw data
    # @api private
    # @return [BoxScoreUsageTeamStat] the team stat object
    def self.build_team_stat(team, game_id)
      stats = team.fetch("statistics", {})
      BoxScoreUsageTeamStat.new(
        **BoxScoreV3Helpers.team_identity(team, game_id),
        min: stats.fetch("minutes", nil),
        **usage_stats(stats)
      )
    end
    private_class_method :build_team_stat

    # Extracts usage statistics from raw data
    # @api private
    # @return [Hash] usage statistics
    def self.usage_stats(stats)
      core_usage(stats).merge(shooting_usage(stats), other_usage(stats))
    end
    private_class_method :usage_stats

    # Extracts core usage statistics from raw data
    # @api private
    # @return [Hash] core usage statistics
    def self.core_usage(stats)
      {
        usg_pct: stats.fetch("usagePercentage", nil),
        pct_fgm: stats.fetch("percentageFieldGoalsMade", nil),
        pct_fga: stats.fetch("percentageFieldGoalsAttempted", nil),
        pct_fg3m: stats.fetch("percentageThreePointersMade", nil),
        pct_fg3a: stats.fetch("percentageThreePointersAttempted", nil),
        pct_ftm: stats.fetch("percentageFreeThrowsMade", nil),
        pct_fta: stats.fetch("percentageFreeThrowsAttempted", nil)
      }
    end
    private_class_method :core_usage

    # Extracts shooting usage statistics from raw data
    # @api private
    # @return [Hash] shooting usage statistics
    def self.shooting_usage(stats)
      {
        pct_oreb: stats.fetch("percentageReboundsOffensive", nil),
        pct_dreb: stats.fetch("percentageReboundsDefensive", nil),
        pct_reb: stats.fetch("percentageReboundsTotal", nil),
        pct_ast: stats.fetch("percentageAssists", nil),
        pct_tov: stats.fetch("percentageTurnovers", nil)
      }
    end
    private_class_method :shooting_usage

    # Extracts other usage statistics from raw data
    # @api private
    # @return [Hash] other usage statistics
    def self.other_usage(stats)
      {
        pct_stl: stats.fetch("percentageSteals", nil),
        pct_blk: stats.fetch("percentageBlocks", nil),
        pct_blka: stats.fetch("percentageBlocksAgainst", nil),
        pct_pf: stats.fetch("percentageFoulsPersonal", nil),
        pct_pfd: stats.fetch("percentageFoulsDrawn", nil),
        pct_pts: stats.fetch("percentagePoints", nil)
      }
    end
    private_class_method :other_usage
  end
end
