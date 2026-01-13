require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_hustle_player_stat"
require_relative "box_score_hustle_team_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve hustle statistics for a game via hustlestatsboxscore endpoint
  module HustleStatsBoxScore
    # Result set name for availability status
    # @return [String] the result set name
    HUSTLE_STATS_AVAILABLE = "HustleStatsAvailable".freeze

    # Result set name for player stats
    # @return [String] the result set name
    PLAYER_STATS = "PlayerStats".freeze

    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # API endpoint path
    # @return [String] the endpoint path
    ENDPOINT = "hustlestatsboxscore".freeze

    # Retrieves hustle statistics for players in a game
    #
    # @api public
    # @example
    #   stats = NBA::HustleStatsBoxScore.player_stats(game: "0022400001")
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player hustle stats
    def self.player_stats(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      parse_stats(client.get("#{ENDPOINT}?GameID=#{game_id}"), game_id, PLAYER_STATS, :build_player_stat)
    end

    # Retrieves hustle statistics for teams in a game
    #
    # @api public
    # @example
    #   stats = NBA::HustleStatsBoxScore.team_stats(game: "0022400001")
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team hustle stats
    def self.team_stats(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      parse_stats(client.get("#{ENDPOINT}?GameID=#{game_id}"), game_id, TEAM_STATS, :build_team_stat)
    end

    # Checks if hustle stats are available for a game
    #
    # @api public
    # @example
    #   NBA::HustleStatsBoxScore.available?(game: "0022400001") #=> true
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Boolean] true if hustle stats are available
    def self.available?(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      stats_available?(client.get("#{ENDPOINT}?GameID=#{game_id}"))
    end

    # Parses hustle stats from API response
    # @api private
    # @param response [String] the API response
    # @param game_id [String] the game ID
    # @param result_set_name [String] the result set name to find
    # @param builder_method [Symbol] the method to build stat objects
    # @return [Collection] collection of stat objects
    def self.parse_stats(response, game_id, result_set_name, builder_method)
      return Collection.new unless response

      result_set = find_result_set(JSON.parse(response), result_set_name)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| __send__(builder_method, headers, row, game_id) })
    end
    private_class_method :parse_stats

    # Checks if hustle stats are available in the response
    # @api private
    # @param response [String] the API response
    # @return [Boolean] true if stats are available
    def self.stats_available?(response)
      return false unless response

      result_set = find_result_set(JSON.parse(response), HUSTLE_STATS_AVAILABLE)
      return false unless result_set

      rows = result_set["rowSet"]
      headers = result_set["headers"]
      return false unless rows && !rows.empty? && headers

      headers.zip(rows.first).to_h["HUSTLE_STATUS"].eql?(1)
    end
    private_class_method :stats_available?

    # Finds a result set by name in the response data
    # @api private
    # @param data [Hash] the parsed JSON data
    # @param name [String] the result set name to find
    # @return [Hash, nil] the result set hash or nil
    def self.find_result_set(data, name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a player stat object from row data
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @param game_id [String] the game ID
    # @return [BoxScoreHustlePlayerStat] the player stat object
    def self.build_player_stat(headers, row, game_id)
      data = headers.zip(row).to_h
      BoxScoreHustlePlayerStat.new(**player_identity(data, game_id), **hustle_stats(data))
    end
    private_class_method :build_player_stat

    # Builds a team stat object from row data
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @param game_id [String] the game ID
    # @return [BoxScoreHustleTeamStat] the team stat object
    def self.build_team_stat(headers, row, game_id)
      data = headers.zip(row).to_h
      BoxScoreHustleTeamStat.new(**team_identity(data, game_id), **hustle_stats(data))
    end
    private_class_method :build_team_stat

    # Extracts player identity attributes from data
    # @api private
    # @param data [Hash] the row data hash
    # @param game_id [String] the game ID
    # @return [Hash] player identity attributes
    def self.player_identity(data, game_id)
      {game_id: game_id, team_id: data.fetch("TEAM_ID"), team_abbreviation: data.fetch("TEAM_ABBREVIATION"),
       team_city: data.fetch("TEAM_CITY"), player_id: data.fetch("PLAYER_ID"), player_name: data.fetch("PLAYER_NAME"),
       start_position: data.fetch("START_POSITION"), comment: data.fetch("COMMENT"),
       min: data.fetch("MINUTES"), pts: data.fetch("PTS")}
    end
    private_class_method :player_identity

    # Extracts team identity attributes from data
    # @api private
    # @param data [Hash] the row data hash
    # @param game_id [String] the game ID
    # @return [Hash] team identity attributes
    def self.team_identity(data, game_id)
      {game_id: game_id, team_id: data.fetch("TEAM_ID"), team_name: data.fetch("TEAM_NAME"),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION"), team_city: data.fetch("TEAM_CITY"),
       min: data.fetch("MINUTES"), pts: data.fetch("PTS")}
    end
    private_class_method :team_identity

    # Extracts hustle stats attributes from data
    # @api private
    # @param data [Hash] the row data hash
    # @return [Hash] hustle stats attributes
    def self.hustle_stats(data)
      {contested_shots: data.fetch("CONTESTED_SHOTS"), contested_shots_2pt: data.fetch("CONTESTED_SHOTS_2PT"),
       contested_shots_3pt: data.fetch("CONTESTED_SHOTS_3PT"), deflections: data.fetch("DEFLECTIONS"),
       charges_drawn: data.fetch("CHARGES_DRAWN"), screen_assists: data.fetch("SCREEN_ASSISTS"),
       screen_ast_pts: data.fetch("SCREEN_AST_PTS"), loose_balls_recovered: data.fetch("LOOSE_BALLS_RECOVERED"),
       off_loose_balls_recovered: data.fetch("OFF_LOOSE_BALLS_RECOVERED"),
       def_loose_balls_recovered: data.fetch("DEF_LOOSE_BALLS_RECOVERED"), box_outs: data.fetch("BOX_OUTS"),
       off_box_outs: data.fetch("OFF_BOXOUTS"), def_box_outs: data.fetch("DEF_BOXOUTS")}
    end
    private_class_method :hustle_stats
  end
end
