require "json"
require_relative "client"
require_relative "player_info"
require_relative "utils"

module NBA
  # Provides methods to retrieve detailed player information
  module CommonPlayerInfo
    # Result set name for common player info
    # @return [String] the result set name
    COMMON_PLAYER_INFO = "CommonPlayerInfo".freeze

    # Retrieves detailed information for a player
    #
    # @api public
    # @example
    #   info = NBA::CommonPlayerInfo.find(player: 201939)
    #   puts "#{info.display_name} - #{info.position} - #{info.team_name}"
    # @param player [Integer, Player] the player ID or Player object
    # @param client [Client] the API client to use
    # @return [PlayerInfo, nil] the player info
    def self.find(player:, client: CLIENT)
      player_id = extract_player_id(player)
      path = "commonplayerinfo?PlayerID=#{player_id}"
      response = client.get(path)
      parse_response(response)
    end

    # Parses the API response into a PlayerInfo object
    # @api private
    # @param response [String, nil] the JSON response
    # @return [PlayerInfo, nil] the player info
    def self.parse_response(response)
      return unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return unless result_set

      headers = result_set.fetch("headers", nil)
      row = result_set.dig("rowSet", 0)
      return unless headers && row

      build_player_info(headers, row)
    end
    private_class_method :parse_response

    # Finds the common player info result set
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(COMMON_PLAYER_INFO) }
    end
    private_class_method :find_result_set

    # Builds a PlayerInfo object from raw data
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [PlayerInfo] the player info object
    def self.build_player_info(headers, row)
      data = headers.zip(row).to_h
      PlayerInfo.new(**player_info_attributes(data))
    end
    private_class_method :build_player_info

    # Combines all player info attributes
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] the combined attributes
    def self.player_info_attributes(data)
      identity_attributes(data).merge(physical_attributes(data), team_attributes(data), draft_attributes(data))
    end
    private_class_method :player_info_attributes

    # Extracts identity attributes from data
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] identity attributes
    def self.identity_attributes(data)
      {player_id: data.fetch("PERSON_ID", nil), first_name: data.fetch("FIRST_NAME", nil), last_name: data.fetch("LAST_NAME", nil),
       display_name: data.fetch("DISPLAY_FIRST_LAST", nil), birthdate: data.fetch("BIRTHDATE", nil), school: data.fetch("SCHOOL", nil),
       country: data.fetch("COUNTRY", nil), from_year: data.fetch("FROM_YEAR", nil), to_year: data.fetch("TO_YEAR", nil),
       greatest_75_flag: data.fetch("GREATEST_75_FLAG", nil)}
    end
    private_class_method :identity_attributes

    # Extracts physical attributes from data
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] physical attributes
    def self.physical_attributes(data)
      {height: data.fetch("HEIGHT", nil), weight: data.fetch("WEIGHT", nil), season_exp: data.fetch("SEASON_EXP", nil),
       jersey: data.fetch("JERSEY", nil), position: data.fetch("POSITION", nil)}
    end
    private_class_method :physical_attributes

    # Extracts team attributes from data
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] team attributes
    def self.team_attributes(data)
      {team_id: data.fetch("TEAM_ID", nil), team_name: data.fetch("TEAM_NAME", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil), team_city: data.fetch("TEAM_CITY", nil)}
    end
    private_class_method :team_attributes

    # Extracts draft attributes from data
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] draft attributes
    def self.draft_attributes(data)
      {draft_year: parse_draft_value(data.fetch("DRAFT_YEAR", nil)), draft_round: parse_draft_value(data.fetch("DRAFT_ROUND", nil)),
       draft_number: parse_draft_value(data.fetch("DRAFT_NUMBER", nil))}
    end
    private_class_method :draft_attributes

    # Parses draft value, handling "Undrafted" case
    # @api private
    # @param value [String, Integer, nil] the draft value
    # @return [Integer, nil] the parsed draft value
    def self.parse_draft_value(value)
      return if value.eql?("Undrafted")

      value
    end
    private_class_method :parse_draft_value

    # Extracts player ID from player object or integer
    # @api private
    # @param player [Player, Integer] the player
    # @return [Integer, nil] the player ID
    def self.extract_player_id(player)
      player.instance_of?(Player) ? player.id : player
    end
    private_class_method :extract_player_id
  end
end
