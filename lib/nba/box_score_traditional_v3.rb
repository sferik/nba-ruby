require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_player_stat"
require_relative "box_score_team_stat"
require_relative "box_score_starter_bench_stat"
require_relative "box_score_v3_helpers"
require_relative "utils"

module NBA
  # Provides methods to retrieve traditional box score statistics using V3 API
  module BoxScoreTraditionalV3
    # @return [String] JSON key for traditional box score data
    BOX_SCORE_KEY = "boxScoreTraditional".freeze
    # @return [String] JSON key for player statistics
    PLAYER_STATS = "PlayerStats".freeze
    # @return [String] JSON key for team statistics
    TEAM_STATS = "TeamStats".freeze
    # @return [String] JSON key for starter/bench statistics
    STARTER_BENCH_STATS = "TeamStarterBenchStats".freeze

    # Retrieves player box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreTraditionalV3.player_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.player_name}: #{stat.pts} pts" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player stats
    def self.player_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_player_response(response, game_id)
    end

    # Retrieves team box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreTraditionalV3.team_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.team_abbreviation}: #{stat.pts} pts" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team stats
    def self.team_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_team_response(response, game_id)
    end

    # Retrieves starter vs bench breakdown stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.team_abbreviation} #{stat.starters_bench}: #{stat.pts} pts" }
    # @param game [String, Integer] the game ID
    # @param start_period [Integer] the starting period
    # @param end_period [Integer] the ending period
    # @param client [Client] the API client to use
    # @return [Collection] a collection of starter/bench stats
    def self.starter_bench_stats(game:, start_period: 0, end_period: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id, start_period, end_period))
      parse_starter_bench_response(response, game_id)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(game_id, start_period, end_period)
      "boxscoretraditionalv3?GameID=#{game_id}&StartPeriod=#{start_period}" \
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

    # Parses the API response into starter/bench stat objects
    # @api private
    # @return [Collection] collection of starter/bench stats
    def self.parse_starter_bench_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      stat_data = extract_starter_bench(data)
      return Collection.new unless stat_data

      Collection.new(stat_data.map { |d| build_starter_bench_stat(d, game_id) })
    end
    private_class_method :parse_starter_bench_response

    # Extracts starter/bench data from parsed response
    # @api private
    # @return [Array, nil] array of starter/bench data or nil
    def self.extract_starter_bench(data)
      box_score = data[BOX_SCORE_KEY]
      return unless box_score

      stats = []
      add_team_starter_bench(stats, box_score, "homeTeam")
      add_team_starter_bench(stats, box_score, "awayTeam")
      stats
    end
    private_class_method :extract_starter_bench

    # Adds starter/bench data for a team
    # @api private
    # @return [void]
    def self.add_team_starter_bench(stats, box_score, team_key)
      team = box_score[team_key]
      return unless team

      %w[starters bench].each do |group|
        group_stats = team.dig("statistics", group)
        stats << {team: team, group: group, stats: group_stats} if group_stats
      end
    end
    private_class_method :add_team_starter_bench

    # Builds a player stat object from raw data
    # @api private
    # @return [BoxScorePlayerStat] the player stat object
    def self.build_player_stat(player, game_id)
      stats = player.fetch("statistics", {})
      BoxScorePlayerStat.new(
        **BoxScoreV3Helpers.player_identity(player, game_id),
        min: stats["minutes"],
        **BoxScoreV3Helpers.shooting_stats(stats),
        **BoxScoreV3Helpers.counting_stats(stats)
      )
    end
    private_class_method :build_player_stat

    # Builds a team stat object from raw data
    # @api private
    # @return [BoxScoreTeamStat] the team stat object
    def self.build_team_stat(team, game_id)
      stats = team.fetch("statistics", {})
      BoxScoreTeamStat.new(
        **BoxScoreV3Helpers.team_identity(team, game_id),
        min: stats["minutes"],
        **BoxScoreV3Helpers.shooting_stats(stats),
        **BoxScoreV3Helpers.counting_stats(stats)
      )
    end
    private_class_method :build_team_stat

    # Builds a starter/bench stat object from raw data
    # @api private
    # @return [BoxScoreStarterBenchStat] the starter/bench stat object
    def self.build_starter_bench_stat(data, game_id)
      team = data.fetch(:team)
      stats = data.fetch(:stats)
      BoxScoreStarterBenchStat.new(
        **BoxScoreV3Helpers.team_identity(team, game_id),
        starters_bench: data.fetch(:group), min: stats["minutes"],
        **BoxScoreV3Helpers.shooting_stats(stats),
        **BoxScoreV3Helpers.counting_stats(stats)
      )
    end
    private_class_method :build_starter_bench_stat
  end
end
