require_relative "client"
require_relative "response_parser"
require_relative "player"
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
      path = "commonteamroster?TeamID=#{Utils.extract_id(team)}&Season=#{Utils.format_season(season)}"
      ResponseParser.parse(client.get(path)) { |data| build_player(data) }
    end

    # Builds a player from roster data
    #
    # @api private
    # @param data [Hash] the roster row data
    # @return [Player] the player object
    def self.build_player(data)
      Player.new(**player_attributes(data))
    end
    private_class_method :build_player

    # Extracts player attributes from data
    # @api private
    # @return [Hash]
    def self.player_attributes(data)
      {id: data["PLAYER_ID"], height: data["HEIGHT"], college: data["SCHOOL"], is_active: true,
       jersey_number: Utils.parse_integer(data["NUM"]), weight: Utils.parse_integer(data["WEIGHT"]),
       country: extract_country(data["BIRTH_DATE"]), position: build_position(data["POSITION"]),
       **name_attributes(data["PLAYER"])}
    end
    private_class_method :player_attributes

    # Builds a position from abbreviation
    # @api private
    # @return [Position, nil]
    def self.build_position(abbreviation)
      return unless abbreviation

      Position.new(abbreviation: abbreviation)
    end
    private_class_method :build_position

    # Extracts name attributes from full name
    # @api private
    # @return [Hash]
    def self.name_attributes(full_name)
      parts = full_name&.split || []
      {full_name: full_name, first_name: parts.first, last_name: parts.drop(1).join(" ")}
    end
    private_class_method :name_attributes

    # Extracts country from birth date string
    # @api private
    # @return [String, nil]
    def self.extract_country(birth_date)
      return unless birth_date

      birth_date.split(",").last&.strip
    end
    private_class_method :extract_country
  end
end
