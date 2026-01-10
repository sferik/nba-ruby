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

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
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
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(FAN_DUEL_PLAYER) }
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
      {game_id: game_id, player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_name: data.fetch("TEAM_NAME", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil), jersey_num: data.fetch("JERSEY_NUM", nil),
       player_position: data.fetch("PLAYER_POSITION", nil), location: data.fetch("LOCATION", nil)}
    end
    private_class_method :identity_attributes

    # Extracts fantasy attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the fantasy attributes
    def self.fantasy_attributes(data)
      {fan_duel_pts: data.fetch("FAN_DUEL_PTS", nil), nba_fantasy_pts: data.fetch("NBA_FANTASY_PTS", nil),
       usg_pct: data.fetch("USG_PCT", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :fantasy_attributes

    # Extracts shooting attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the counting stats attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), tov: data.fetch("TOV", nil), stl: data.fetch("STL", nil),
       blk: data.fetch("BLK", nil), blka: data.fetch("BLKA", nil), pf: data.fetch("PF", nil),
       pfd: data.fetch("PFD", nil), pts: data.fetch("PTS", nil), plus_minus: data.fetch("PLUS_MINUS", nil)}
    end
    private_class_method :counting_attributes
  end
end
