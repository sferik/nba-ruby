require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_player_track_stat"
require_relative "box_score_player_track_team_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve player tracking statistics for a game
  module BoxScorePlayerTrack
    # Result set name for player stats
    # @return [String] the result set name
    PLAYER_STATS = "PlayerStats".freeze

    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # Retrieves player tracking statistics for players in a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScorePlayerTrack.player_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.player_name}: #{s.distance} miles, #{s.touches} touches" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player tracking stats
    def self.player_stats(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      path = "boxscoreplayertrackv3?GameID=#{game_id}"
      response = client.get(path)
      parse_player_response(response, game_id)
    end

    # Retrieves player tracking statistics for teams in a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScorePlayerTrack.team_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.team_name}: #{s.distance} miles, #{s.touches} touches" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team tracking stats
    def self.team_stats(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      path = "boxscoreplayertrackv3?GameID=#{game_id}"
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
    # @return [BoxScorePlayerTrackStat] the player stat
    def self.build_player_stat(headers, row, game_id)
      data = headers.zip(row).to_h
      BoxScorePlayerTrackStat.new(**player_stat_attributes(data, game_id))
    end
    private_class_method :build_player_stat

    # Builds a team stat
    # @api private
    # @param headers [Array<String>] the headers
    # @param row [Array] the row data
    # @param game_id [String] the game ID
    # @return [BoxScorePlayerTrackTeamStat] the team stat
    def self.build_team_stat(headers, row, game_id)
      data = headers.zip(row).to_h
      BoxScorePlayerTrackTeamStat.new(**team_stat_attributes(data, game_id))
    end
    private_class_method :build_team_stat

    # Combines player stat attributes
    # @api private
    # @param data [Hash] the raw data
    # @param game_id [String] the game ID
    # @return [Hash] the combined attributes
    def self.player_stat_attributes(data, game_id)
      player_identity(data, game_id).merge(tracking_stats(data), passing_stats(data), shooting_stats(data))
    end
    private_class_method :player_stat_attributes

    # Combines team stat attributes
    # @api private
    # @param data [Hash] the raw data
    # @param game_id [String] the game ID
    # @return [Hash] the combined attributes
    def self.team_stat_attributes(data, game_id)
      team_identity(data, game_id).merge(tracking_stats(data), passing_stats(data), shooting_stats(data))
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
       start_position: data.fetch("START_POSITION"), comment: data.fetch("COMMENT"), min: data.fetch("MIN")}
    end
    private_class_method :player_identity

    # Extracts team identity attributes
    # @api private
    # @param data [Hash] the raw data
    # @param game_id [String] the game ID
    # @return [Hash] identity attributes
    def self.team_identity(data, game_id)
      {game_id: game_id, team_id: data.fetch("TEAM_ID"), team_name: data.fetch("TEAM_NAME"),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION"), team_city: data.fetch("TEAM_CITY"), min: data.fetch("MIN")}
    end
    private_class_method :team_identity

    # Extracts tracking stats
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] tracking stats
    def self.tracking_stats(data)
      {speed: data.fetch("SPD"), distance: data.fetch("DIST"), oreb_chances: data.fetch("ORBC"), dreb_chances: data.fetch("DRBC"),
       reb_chances: data.fetch("RBC"), touches: data.fetch("TCHS")}
    end
    private_class_method :tracking_stats

    # Extracts passing stats
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] passing stats
    def self.passing_stats(data)
      {secondary_ast: data.fetch("SAST"), ft_ast: data.fetch("FTAST"), passes: data.fetch("PASS"), ast: data.fetch("AST")}
    end
    private_class_method :passing_stats

    # Extracts shooting stats
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] shooting stats
    def self.shooting_stats(data)
      {cfgm: data.fetch("CFGM"), cfga: data.fetch("CFGA"), cfg_pct: data.fetch("CFG_PCT"),
       ufgm: data.fetch("UFGM"), ufga: data.fetch("UFGA"), ufg_pct: data.fetch("UFG_PCT"),
       dfgm: data.fetch("DFGM"), dfga: data.fetch("DFGA"), dfg_pct: data.fetch("DFG_PCT")}
    end
    private_class_method :shooting_stats
  end
end
