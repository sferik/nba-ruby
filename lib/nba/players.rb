require "json"
require_relative "client"
require_relative "collection"
require_relative "player"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA players
  module Players
    # Retrieves all NBA players
    #
    # @api public
    # @example
    #   players = NBA::Players.all
    #   players.each { |player| puts player.full_name }
    # @param season [Integer] the season year (defaults to current season)
    # @param only_current [Boolean] whether to only return current players
    # @param client [Client] the API client to use
    # @return [Collection] a collection of all players
    def self.all(season: Utils.current_season, only_current: true, client: CLIENT)
      season_str = "#{season}-#{(season + 1).to_s[-2..]}"
      current_flag = only_current ? 1 : 0
      path = "commonallplayers?LeagueID=00&Season=#{season_str}&IsOnlyCurrentSeason=#{current_flag}"
      response = client.get(path)
      parse_players_response(response)
    end

    # Finds a player by ID
    #
    # @api public
    # @example
    #   roster = NBA::Roster.find(team: NBA::Team::GSW)
    #   curry = roster.find { |p| p.jersey_number == 30 }
    #   player = NBA::Players.find(curry.id)
    # @param player_id [Integer, Player] the player ID or Player object
    # @param client [Client] the API client to use
    # @return [Player, nil] the player with the given ID, or nil if not found
    def self.find(player_id, client: CLIENT)
      id = extract_id(player_id)
      path = "commonplayerinfo?PlayerID=#{id}"
      response = client.get(path)
      parse_player_response(response)
    end

    # Parses the players list API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of players
    def self.parse_players_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = data.dig("resultSets", 0)
      return Collection.new unless result_set

      headers = result_set.fetch("headers")
      rows = result_set.fetch("rowSet")
      return Collection.new unless headers && rows

      players = rows.map { |row| build_player_from_row(headers, row) }
      Collection.new(players)
    end
    private_class_method :parse_players_response

    # Builds a player from a row of data
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [Player] the player object
    def self.build_player_from_row(headers, row)
      data = headers.zip(row).to_h
      full_name = data.fetch("DISPLAY_FIRST_LAST")
      Player.new(
        id: data.fetch("PERSON_ID"),
        full_name: full_name,
        first_name: extract_first_name(full_name),
        last_name: extract_last_name(full_name),
        is_active: roster_status_active?(data.fetch("ROSTERSTATUS"))
      )
    end
    private_class_method :build_player_from_row

    # Extracts the first name from a full name
    #
    # @api private
    # @param full_name [String, nil] the full name
    # @return [String, nil] the first name
    def self.extract_first_name(full_name)
      return unless full_name

      full_name.split.first
    end
    private_class_method :extract_first_name

    # Extracts the last name from a full name
    #
    # @api private
    # @param full_name [String, nil] the full name
    # @return [String, nil] the last name
    def self.extract_last_name(full_name)
      return unless full_name

      full_name.split.last
    end
    private_class_method :extract_last_name

    # Checks if the roster status indicates an active player
    #
    # @api private
    # @param status [Integer, String] the roster status
    # @return [Boolean] true if active
    def self.roster_status_active?(status)
      status == 1 || status.eql?("Active")
    end
    private_class_method :roster_status_active?

    # Parses a single player API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Player, nil] the player or nil if not found
    def self.parse_player_response(response)
      return unless response

      data = JSON.parse(response)
      result_set = data.dig("resultSets", 0)
      return unless result_set

      headers = result_set.fetch("headers")
      row = result_set.dig("rowSet", 0)
      return unless headers && row

      player_data = headers.zip(row).to_h
      build_player_from_info(player_data)
    end
    private_class_method :parse_player_response

    # Builds a player from player info data
    #
    # @api private
    # @param data [Hash] the player info data
    # @return [Player] the player object
    def self.build_player_from_info(data)
      Player.new(**player_info_attributes(data))
    end
    private_class_method :build_player_from_info

    # Combines core and extra player attributes
    #
    # @api private
    # @param data [Hash] the player info data
    # @return [Hash] the combined attributes
    def self.player_info_attributes(data) = player_core_attributes(data).merge(player_extra_attributes(data))
    private_class_method :player_info_attributes

    # Extracts core player attributes from data
    #
    # @api private
    # @param data [Hash] the player info data
    # @return [Hash] the core attributes
    def self.player_core_attributes(data)
      {id: data.fetch("PERSON_ID"), full_name: data.fetch("DISPLAY_FIRST_LAST"),
       first_name: data.fetch("FIRST_NAME"), last_name: data.fetch("LAST_NAME"),
       is_active: roster_status_active?(data.fetch("ROSTERSTATUS")),
       jersey_number: parse_integer(data.fetch("JERSEY")), height: data.fetch("HEIGHT")}
    end
    private_class_method :player_core_attributes

    # Extracts extra player attributes from data
    #
    # @api private
    # @param data [Hash] the player info data
    # @return [Hash] the extra attributes
    def self.player_extra_attributes(data)
      {weight: parse_integer(data.fetch("WEIGHT")), college: data.fetch("SCHOOL"),
       country: data.fetch("COUNTRY"), draft_year: parse_integer(data.fetch("DRAFT_YEAR")),
       draft_round: parse_integer(data.fetch("DRAFT_ROUND")), draft_number: parse_integer(data.fetch("DRAFT_NUMBER"))}
    end
    private_class_method :player_extra_attributes

    # Parses a value as an integer
    #
    # @api private
    # @param value [String, Integer, nil] the value to parse
    # @return [Integer, nil] the parsed integer or nil
    def self.parse_integer(value)
      return if value.to_s.empty?

      Integer(value)
    rescue ArgumentError
      nil
    end
    private_class_method :parse_integer

    # Extracts the ID from a player or integer
    #
    # @api private
    # @param player [Player, Integer] the player or ID
    # @return [Integer] the player ID
    def self.extract_id(player)
      player.instance_of?(Player) ? player.id : player
    end
    private_class_method :extract_id
  end
end
