require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_scoring_player_stat"
require_relative "box_score_scoring_team_stat"
require_relative "box_score_v3_helpers"
require_relative "utils"

module NBA
  # Provides methods to retrieve scoring box score statistics using V3 API
  module BoxScoreScoringV3
    # @return [String] JSON key for scoring box score data
    BOX_SCORE_KEY = "boxScoreScoring".freeze
    # @return [String] JSON key for player statistics
    PLAYER_STATS = "PlayerStats".freeze
    # @return [String] JSON key for team statistics
    TEAM_STATS = "TeamStats".freeze

    # Retrieves scoring player box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreScoringV3.player_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.player_name}: #{stat.pct_pts_paint}" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player scoring stats
    def self.player_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_player_response(response, game_id)
    end

    # Retrieves scoring team box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreScoringV3.team_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.team_abbreviation}: #{stat.pct_pts_paint}" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team scoring stats
    def self.team_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_team_response(response, game_id)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(game_id, start_period, end_period)
      "boxscorescoringv3?GameID=#{game_id}&StartPeriod=#{start_period}" \
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
    # @return [BoxScoreScoringPlayerStat] the player stat object
    def self.build_player_stat(player, game_id)
      stats = player.fetch("statistics", {})
      BoxScoreScoringPlayerStat.new(
        **BoxScoreV3Helpers.player_identity(player, game_id),
        min: stats.fetch("minutes", nil),
        **scoring_stats(stats)
      )
    end
    private_class_method :build_player_stat

    # Builds a team stat object from raw data
    # @api private
    # @return [BoxScoreScoringTeamStat] the team stat object
    def self.build_team_stat(team, game_id)
      stats = team.fetch("statistics", {})
      BoxScoreScoringTeamStat.new(
        **BoxScoreV3Helpers.team_identity(team, game_id),
        min: stats.fetch("minutes", nil),
        **scoring_stats(stats)
      )
    end
    private_class_method :build_team_stat

    # Extracts scoring statistics from raw data
    # @api private
    # @return [Hash] scoring statistics
    def self.scoring_stats(stats)
      shot_distribution(stats).merge(assist_distribution(stats))
    end
    private_class_method :scoring_stats

    # Extracts shot distribution statistics from raw data
    # @api private
    # @return [Hash] shot distribution statistics
    def self.shot_distribution(stats)
      attempt_distribution(stats).merge(points_distribution(stats))
    end
    private_class_method :shot_distribution

    # Extracts attempt distribution statistics from raw data
    # @api private
    # @return [Hash] attempt distribution statistics
    def self.attempt_distribution(stats)
      {pct_fga_2pt: stats.fetch("percentageFieldGoalsAttempted2pt", nil),
       pct_fga_3pt: stats.fetch("percentageFieldGoalsAttempted3pt", nil),
       pct_pts_2pt: stats.fetch("percentagePoints2pt", nil),
       pct_pts_2pt_mr: stats.fetch("percentagePointsMidrange2pt", nil),
       pct_pts_3pt: stats.fetch("percentagePoints3pt", nil)}
    end
    private_class_method :attempt_distribution

    # Extracts points distribution statistics from raw data
    # @api private
    # @return [Hash] points distribution statistics
    def self.points_distribution(stats)
      {pct_pts_fb: stats.fetch("percentagePointsFastBreak", nil),
       pct_pts_ft: stats.fetch("percentagePointsFreeThrow", nil),
       pct_pts_off_tov: stats.fetch("percentagePointsOffTurnovers", nil),
       pct_pts_paint: stats.fetch("percentagePointsPaint", nil)}
    end
    private_class_method :points_distribution

    # Extracts assist distribution statistics from raw data
    # @api private
    # @return [Hash] assist distribution statistics
    def self.assist_distribution(stats)
      {
        pct_ast_2pm: stats.fetch("percentageAssisted2pt", nil),
        pct_uast_2pm: stats.fetch("percentageUnassisted2pt", nil),
        pct_ast_3pm: stats.fetch("percentageAssisted3pt", nil),
        pct_uast_3pm: stats.fetch("percentageUnassisted3pt", nil),
        pct_ast_fgm: stats.fetch("percentageAssistedFieldGoals", nil),
        pct_uast_fgm: stats.fetch("percentageUnassistedFieldGoals", nil)
      }
    end
    private_class_method :assist_distribution
  end
end
