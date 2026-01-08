require "date"
require "uri"

module NBA
  # Utility methods for the NBA gem
  module Utils
    # Returns the current NBA season year
    #
    # @api public
    # @example
    #   NBA::Utils.current_season #=> 2024
    # @return [Integer] the current season year
    def self.current_season
      today = Date.today
      # NBA season typically runs from October to June
      # If we're in January-June, we're in the same season (which started previous year)
      # Otherwise (July-December), return current year
      (today.month <= 6) ? today.year - 1 : today.year
    end

    # Formats a season year into the NBA API format (e.g., "2024-25")
    #
    # @api public
    # @example
    #   NBA::Utils.format_season(2024) #=> "2024-25"
    # @param year [Integer] the season start year
    # @return [String] the formatted season string
    def self.format_season(year)
      "#{year}-#{(year + 1).to_s[-2..]}"
    end

    # Formats a season year into the NBA SeasonID format (e.g., "22024")
    #
    # @api public
    # @example
    #   NBA::Utils.format_season_id(2024) #=> "22024"
    # @param year [Integer] the season start year
    # @return [String] the formatted season ID string
    def self.format_season_id(year)
      "2#{year}"
    end

    # Builds a query string from a hash of parameters
    #
    # @api public
    # @example
    #   NBA::Utils.build_query(season: 2024, team_id: 1) #=> "season=2024&team_id=1"
    # @param params [Hash] the parameters to build into a query string
    # @return [String] the query string
    def self.build_query(**params)
      URI.encode_www_form(params.compact)
    end

    # Extracts an ID from an entity object or returns the value as-is
    #
    # @api public
    # @example
    #   NBA::Utils.extract_id(player) #=> 2544
    #   NBA::Utils.extract_id(2544) #=> 2544
    # @param entity [Player, Team, Game, Integer, String] the entity or ID
    # @return [Integer, String] the extracted ID
    def self.extract_id(entity)
      entity.respond_to?(:id) ? entity.id : entity
    end

    # Parses a value as an integer, returning nil for invalid values
    #
    # @api public
    # @example
    #   NBA::Utils.parse_integer("42") #=> 42
    #   NBA::Utils.parse_integer("N/A") #=> nil
    # @param value [String, Integer, nil] the value to parse
    # @return [Integer, nil] the parsed integer or nil
    def self.parse_integer(value)
      return if value.to_s.empty?

      Integer(value)
    rescue ArgumentError
      nil
    end
  end
end
