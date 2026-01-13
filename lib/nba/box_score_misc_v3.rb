require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_misc_player_stat"
require_relative "box_score_misc_team_stat"
require_relative "box_score_v3_helpers"
require_relative "utils"

module NBA
  # Provides methods to retrieve miscellaneous box score statistics using V3 API
  module BoxScoreMiscV3
    # @return [String] JSON key for miscellaneous box score data
    BOX_SCORE_KEY = "boxScoreMisc".freeze
    # @return [String] JSON key for player statistics
    PLAYER_STATS = "PlayerStats".freeze
    # @return [String] JSON key for team statistics
    TEAM_STATS = "TeamStats".freeze

    # Retrieves misc player box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreMiscV3.player_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.player_name}: #{stat.pts_paint}" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player misc stats
    def self.player_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_player_response(response, game_id)
    end

    # Retrieves misc team box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreMiscV3.team_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.team_abbreviation}: #{stat.pts_paint}" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team misc stats
    def self.team_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_team_response(response, game_id)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(game_id, start_period, end_period)
      "boxscoremiscv3?GameID=#{game_id}&StartPeriod=#{start_period}" \
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
    # @return [BoxScoreMiscPlayerStat] the player stat object
    def self.build_player_stat(player, game_id)
      stats = player.fetch("statistics", {})
      BoxScoreMiscPlayerStat.new(
        **BoxScoreV3Helpers.player_identity(player, game_id),
        min: stats["minutes"],
        **misc_stats(stats)
      )
    end
    private_class_method :build_player_stat

    # Builds a team stat object from raw data
    # @api private
    # @return [BoxScoreMiscTeamStat] the team stat object
    def self.build_team_stat(team, game_id)
      stats = team.fetch("statistics", {})
      BoxScoreMiscTeamStat.new(
        **BoxScoreV3Helpers.team_identity(team, game_id),
        min: stats["minutes"],
        **misc_stats(stats)
      )
    end
    private_class_method :build_team_stat

    # Extracts miscellaneous statistics from raw data
    # @api private
    # @return [Hash] miscellaneous statistics
    def self.misc_stats(stats)
      points_stats(stats).merge(opponent_stats(stats), block_foul_stats(stats))
    end
    private_class_method :misc_stats

    # Extracts points statistics from raw data
    # @api private
    # @return [Hash] points statistics
    def self.points_stats(stats)
      {
        pts_off_tov: stats["pointsOffTurnovers"],
        pts_2nd_chance: stats["pointsSecondChance"],
        pts_fb: stats["pointsFastBreak"],
        pts_paint: stats["pointsPaint"]
      }
    end
    private_class_method :points_stats

    # Extracts opponent statistics from raw data
    # @api private
    # @return [Hash] opponent statistics
    def self.opponent_stats(stats)
      {
        opp_pts_off_tov: stats["oppPointsOffTurnovers"],
        opp_pts_2nd_chance: stats["oppPointsSecondChance"],
        opp_pts_fb: stats["oppPointsFastBreak"],
        opp_pts_paint: stats["oppPointsPaint"]
      }
    end
    private_class_method :opponent_stats

    # Extracts block and foul statistics from raw data
    # @api private
    # @return [Hash] block and foul statistics
    def self.block_foul_stats(stats)
      {
        blk: stats["blocks"],
        blka: stats["blocksAgainst"],
        pf: stats["foulsPersonal"],
        pfd: stats["foulsDrawn"]
      }
    end
    private_class_method :block_foul_stats
  end
end
