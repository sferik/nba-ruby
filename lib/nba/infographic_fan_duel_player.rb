require "json"
require_relative "client"
require_relative "collection"
require_relative "infographic_fan_duel_player_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve FanDuel infographic player statistics
  module InfographicFanDuelPlayer
    # Result set name for FanDuel player stats
    # @return [String] the result set name
    FAN_DUEL_PLAYER = "FanDuelPlayer".freeze

    # Retrieves FanDuel infographic statistics for all players in a game
    #
    # @api public
    # @example
    #   stats = NBA::InfographicFanDuelPlayer.find(game: "0022400001")
    #   stats.each { |s| puts "#{s.player_name}: #{s.fan_duel_pts} FD pts" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of FanDuel player stats
    def self.find(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      path = "infographicfanduelplayer?GameID=#{game_id}"
      response = client.get(path)
      parse_response(response, game_id)
    end

    # Parses the API response
    #
    # @api private
    # @param response [String, nil] the JSON response
    # @param game_id [String] the game ID
    # @return [Collection] collection of player stats
    def self.parse_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_player_stat(headers, row, game_id) }
      Collection.new(stats)
    end
    private_class_method :parse_response

    # Finds the result set
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(FAN_DUEL_PLAYER) }
    end
    private_class_method :find_result_set

    # Builds a player stat from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @param game_id [String] the game ID
    # @return [InfographicFanDuelPlayerStat] the player stat object
    def self.build_player_stat(headers, row, game_id)
      data = headers.zip(row).to_h
      InfographicFanDuelPlayerStat.new(**player_stat_attributes(data, game_id))
    end
    private_class_method :build_player_stat

    # Extracts player stat attributes from row data
    #
    # @api private
    # @param data [Hash] the player stat row data
    # @param game_id [String] the game ID
    # @return [Hash] the player stat attributes
    def self.player_stat_attributes(data, game_id)
      identity_attributes(data, game_id).merge(fantasy_attributes(data), shooting_attributes(data), counting_attributes(data))
    end
    private_class_method :player_stat_attributes

    # Extracts identity attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @param game_id [String] the game ID
    # @return [Hash] the identity attributes
    def self.identity_attributes(data, game_id)
      {game_id: game_id, player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       team_id: data["TEAM_ID"], team_name: data["TEAM_NAME"],
       team_abbreviation: data["TEAM_ABBREVIATION"], jersey_num: data["JERSEY_NUM"],
       player_position: data["PLAYER_POSITION"], location: data["LOCATION"]}
    end
    private_class_method :identity_attributes

    # Extracts fantasy attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the fantasy attributes
    def self.fantasy_attributes(data)
      {fan_duel_pts: data["FAN_DUEL_PTS"], nba_fantasy_pts: data["NBA_FANTASY_PTS"],
       usg_pct: data["USG_PCT"], min: data["MIN"]}
    end
    private_class_method :fantasy_attributes

    # Extracts shooting attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the shooting attributes
    def self.shooting_attributes(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
       ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the counting stats attributes
    def self.counting_attributes(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"],
       ast: data["AST"], tov: data["TOV"], stl: data["STL"],
       blk: data["BLK"], blka: data["BLKA"], pf: data["PF"],
       pfd: data["PFD"], pts: data["PTS"], plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :counting_attributes
  end
end
