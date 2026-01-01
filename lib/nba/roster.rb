require "json"
require_relative "client"
require_relative "collection"
require_relative "player"
require_relative "team"
require_relative "utils"

module NBA
  # Provides methods to retrieve team rosters
  module Roster
    # Finds the roster for a team
    #
    # @api public
    # @example
    #   roster = NBA::Roster.find(team: NBA::Team::GSW)
    #   roster.each { |player| puts player.full_name }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year (defaults to current season)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of players on the roster
    def self.find(team:, season: Utils.current_season, client: CLIENT)
      team_id = extract_team_id(team)
      season_str = "#{season}-#{(season + 1).to_s[-2..]}"
      path = "commonteamroster?TeamID=#{team_id}&Season=#{season_str}"
      response = client.get(path)
      parse_roster_response(response)
    end

    # Parses the roster API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of players
    def self.parse_roster_response(response)
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
    private_class_method :parse_roster_response

    # Builds a player from a roster row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [Player] the player object
    def self.build_player_from_row(headers, row)
      data = headers.zip(row).to_h
      Player.new(**roster_player_attributes(data))
    end
    private_class_method :build_player_from_row

    # Extracts player attributes from roster data
    #
    # @api private
    # @param data [Hash] the roster row data
    # @return [Hash] the player attributes
    def self.roster_player_attributes(data)
      full_name = data.fetch("PLAYER")
      name_parts = split_name(full_name)
      {
        id: data.fetch("PLAYER_ID"), full_name: full_name,
        first_name: name_parts.first, last_name: name_parts.drop(1).join(" "),
        jersey_number: parse_integer(data.fetch("NUM")), height: data.fetch("HEIGHT"),
        weight: parse_integer(data.fetch("WEIGHT")), college: data.fetch("SCHOOL"),
        country: extract_country(data.fetch("BIRTH_DATE")), is_active: true
      }
    end
    private_class_method :roster_player_attributes

    # Splits a name into parts
    #
    # @api private
    # @param name [String, nil] the full name
    # @return [Array<String>] the name parts
    def self.split_name(name)
      return [] unless name

      name.split
    end
    private_class_method :split_name

    # Extracts country from birth date string
    #
    # @api private
    # @param birth_date [String, nil] the birth date string
    # @return [String, nil] the country
    def self.extract_country(birth_date)
      return unless birth_date

      birth_date.split(",").last&.strip
    end
    private_class_method :extract_country

    # Parses a string to an integer, returning nil for non-numeric values
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

    # Extracts the team ID from a team or returns the integer directly
    #
    # @api private
    # @param team [Team, Integer] the team or team ID
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_team_id
  end
end
