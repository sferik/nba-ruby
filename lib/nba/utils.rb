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
  end
end
