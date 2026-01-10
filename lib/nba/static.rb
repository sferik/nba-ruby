require_relative "data"
require_relative "team"

module NBA
  # Provides static data lookup for teams without API calls
  #
  # @api public
  module Static
    # Retrieves all NBA teams
    #
    # @api public
    # @example
    #   teams = NBA::Static.teams
    #   teams.size #=> 30
    # @return [Array<Hash>] array of team hashes
    def self.teams
      Data::TEAMS
    end

    # Finds a team by ID
    #
    # @api public
    # @example
    #   team = NBA::Static.find_team_by_id(1610612744)
    #   team[:full_name] #=> "Golden State Warriors"
    # @param id [Integer] the team ID
    # @return [Hash, nil] the team hash or nil if not found
    def self.find_team_by_id(id)
      Data::TEAMS.find { |t| t.fetch(:id).eql?(id) }
    end

    # Finds a team by abbreviation
    #
    # @api public
    # @example
    #   team = NBA::Static.find_team_by_abbreviation("GSW")
    #   team[:full_name] #=> "Golden State Warriors"
    # @param abbreviation [String] the team abbreviation
    # @return [Hash, nil] the team hash or nil if not found
    def self.find_team_by_abbreviation(abbreviation)
      Data::TEAMS.find { |t| t.fetch(:abbreviation).casecmp?(abbreviation) }
    end

    # Finds teams by city name
    #
    # @api public
    # @example
    #   teams = NBA::Static.find_teams_by_city("Los Angeles")
    #   teams.size #=> 2
    # @param city [String] the city name (case-insensitive, partial match)
    # @return [Array<Hash>] array of matching team hashes
    def self.find_teams_by_city(city)
      pattern = Regexp.new(Regexp.escape(city), Regexp::IGNORECASE)
      Data::TEAMS.select { |t| pattern.match?(t.fetch(:city)) }
    end

    # Finds teams by state name
    #
    # @api public
    # @example
    #   teams = NBA::Static.find_teams_by_state("California")
    #   teams.size #=> 4
    # @param state [String] the state name (case-insensitive, partial match)
    # @return [Array<Hash>] array of matching team hashes
    def self.find_teams_by_state(state)
      pattern = Regexp.new(Regexp.escape(state), Regexp::IGNORECASE)
      Data::TEAMS.select { |t| pattern.match?(t.fetch(:state)) }
    end

    # Finds teams by nickname
    #
    # @api public
    # @example
    #   team = NBA::Static.find_team_by_nickname("Warriors")
    #   team[:city] #=> "San Francisco"
    # @param nickname [String] the team nickname (case-insensitive)
    # @return [Hash, nil] the team hash or nil if not found
    def self.find_team_by_nickname(nickname)
      Data::TEAMS.find { |t| t.fetch(:nickname).casecmp?(nickname) }
    end

    # Finds teams by full name
    #
    # @api public
    # @example
    #   teams = NBA::Static.find_teams_by_full_name("Warriors")
    #   teams.first[:city] #=> "San Francisco"
    # @param name [String] the name to search (case-insensitive, partial match)
    # @return [Array<Hash>] array of matching team hashes
    def self.find_teams_by_full_name(name)
      pattern = Regexp.new(Regexp.escape(name), Regexp::IGNORECASE)
      Data::TEAMS.select { |t| pattern.match?(t.fetch(:full_name)) }
    end

    # Finds teams by year founded
    #
    # @api public
    # @example
    #   teams = NBA::Static.find_teams_by_year_founded(1946)
    #   teams.size #=> 4
    # @param year [Integer] the founding year
    # @return [Array<Hash>] array of matching team hashes
    def self.find_teams_by_year_founded(year)
      Data::TEAMS.select { |t| t.fetch(:year_founded).eql?(year) }
    end
  end
end
