require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_hustle_player_stat"
require_relative "box_score_hustle_team_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve hustle statistics for a game
  module BoxScoreHustle
    # Result set name for player stats
    # @return [String] the result set name
    PLAYER_STATS = "PlayerStats".freeze

    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # Retrieves hustle statistics for players in a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreHustle.player_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.player_name}: #{s.deflections} deflections" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player hustle stats
    def self.player_stats(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      path = "boxscorehustlev2?GameID=#{game_id}"
      response = client.get(path)
      parse_player_response(response, game_id)
    end

    # Retrieves hustle statistics for teams in a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreHustle.team_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.team_name}: #{s.deflections} deflections" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team hustle stats
    def self.team_stats(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      path = "boxscorehustlev2?GameID=#{game_id}"
      response = client.get(path)
      parse_team_response(response, game_id)
    end

    # Parses player stats response
    # @api private
    # @param response [String, nil] the JSON response
    # @param game_id [String] the game ID
    # @return [Collection] collection of player stats
    def self.parse_player_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, PLAYER_STATS)
      return Collection.new unless result_set

      build_player_stats(result_set, game_id)
    end
    private_class_method :parse_player_response

    # Parses team stats response
    # @api private
    # @param response [String, nil] the JSON response
    # @param game_id [String] the game ID
    # @return [Collection] collection of team stats
    def self.parse_team_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, TEAM_STATS)
      return Collection.new unless result_set

      build_team_stats(result_set, game_id)
    end
    private_class_method :parse_team_response

    # Finds a result set by name
    # @api private
    # @param data [Hash] the parsed JSON
    # @param name [String] the result set name
    # @return [Hash, nil] the result set
    def self.find_result_set(data, name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(name) }
    end
    private_class_method :find_result_set

    # Builds player stats collection
    # @api private
    # @param result_set [Hash] the result set
    # @param game_id [String] the game ID
    # @return [Collection] collection of player stats
    def self.build_player_stats(result_set, game_id)
      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_player_stat(headers, row, game_id) }
      Collection.new(stats)
    end
    private_class_method :build_player_stats

    # Builds team stats collection
    # @api private
    # @param result_set [Hash] the result set
    # @param game_id [String] the game ID
    # @return [Collection] collection of team stats
    def self.build_team_stats(result_set, game_id)
      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_team_stat(headers, row, game_id) }
      Collection.new(stats)
    end
    private_class_method :build_team_stats

    # Builds a player stat
    # @api private
    # @param headers [Array<String>] the headers
    # @param row [Array] the row data
    # @param game_id [String] the game ID
    # @return [BoxScoreHustlePlayerStat] the player stat
    def self.build_player_stat(headers, row, game_id)
      data = headers.zip(row).to_h
      BoxScoreHustlePlayerStat.new(**player_stat_attributes(data, game_id))
    end
    private_class_method :build_player_stat

    # Builds a team stat
    # @api private
    # @param headers [Array<String>] the headers
    # @param row [Array] the row data
    # @param game_id [String] the game ID
    # @return [BoxScoreHustleTeamStat] the team stat
    def self.build_team_stat(headers, row, game_id)
      data = headers.zip(row).to_h
      BoxScoreHustleTeamStat.new(**team_stat_attributes(data, game_id))
    end
    private_class_method :build_team_stat

    # Combines player stat attributes
    # @api private
    # @param data [Hash] the raw data
    # @param game_id [String] the game ID
    # @return [Hash] the combined attributes
    def self.player_stat_attributes(data, game_id)
      player_identity(data, game_id).merge(hustle_stats(data), loose_ball_stats(data), box_out_stats(data))
    end
    private_class_method :player_stat_attributes

    # Combines team stat attributes
    # @api private
    # @param data [Hash] the raw data
    # @param game_id [String] the game ID
    # @return [Hash] the combined attributes
    def self.team_stat_attributes(data, game_id)
      team_identity(data, game_id).merge(hustle_stats(data), loose_ball_stats(data), box_out_stats(data))
    end
    private_class_method :team_stat_attributes

    # Extracts player identity attributes
    # @api private
    # @param data [Hash] the raw data
    # @param game_id [String] the game ID
    # @return [Hash] identity attributes
    def self.player_identity(data, game_id)
      {game_id: game_id, team_id: data.fetch("TEAM_ID"), team_abbreviation: data.fetch("TEAM_ABBREVIATION"),
       team_city: data.fetch("TEAM_CITY"), player_id: data.fetch("PLAYER_ID"), player_name: data.fetch("PLAYER_NAME"),
       start_position: data.fetch("START_POSITION"), comment: data.fetch("COMMENT"), min: data.fetch("MIN"), pts: data.fetch("PTS")}
    end
    private_class_method :player_identity

    # Extracts team identity attributes
    # @api private
    # @param data [Hash] the raw data
    # @param game_id [String] the game ID
    # @return [Hash] identity attributes
    def self.team_identity(data, game_id)
      {game_id: game_id, team_id: data.fetch("TEAM_ID"), team_name: data.fetch("TEAM_NAME"),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION"), team_city: data.fetch("TEAM_CITY"),
       min: data.fetch("MIN"), pts: data.fetch("PTS")}
    end
    private_class_method :team_identity

    # Extracts hustle stats
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] hustle stats
    def self.hustle_stats(data)
      {contested_shots: data.fetch("CONTESTED_SHOTS"), contested_shots_2pt: data.fetch("CONTESTED_SHOTS_2PT"),
       contested_shots_3pt: data.fetch("CONTESTED_SHOTS_3PT"), deflections: data.fetch("DEFLECTIONS"),
       charges_drawn: data.fetch("CHARGES_DRAWN"), screen_assists: data.fetch("SCREEN_ASSISTS"),
       screen_ast_pts: data.fetch("SCREEN_AST_PTS")}
    end
    private_class_method :hustle_stats

    # Extracts loose ball stats
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] loose ball stats
    def self.loose_ball_stats(data)
      {loose_balls_recovered: data.fetch("LOOSE_BALLS_RECOVERED"),
       off_loose_balls_recovered: data.fetch("OFF_LOOSE_BALLS_RECOVERED"),
       def_loose_balls_recovered: data.fetch("DEF_LOOSE_BALLS_RECOVERED")}
    end
    private_class_method :loose_ball_stats

    # Extracts box out stats
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] box out stats
    def self.box_out_stats(data)
      {box_outs: data.fetch("BOX_OUTS"), off_box_outs: data.fetch("OFF_BOX_OUTS"), def_box_outs: data.fetch("DEF_BOX_OUTS")}
    end
    private_class_method :box_out_stats
  end
end
