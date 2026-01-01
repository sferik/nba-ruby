require_relative "collection"
require_relative "data"
require_relative "team"

module NBA
  # Provides methods to retrieve NBA teams
  module Teams
    # Retrieves all NBA teams
    #
    # @api public
    # @example
    #   teams = NBA::Teams.all
    #   teams.each { |team| puts team.name }
    # @return [Collection] a collection of all NBA teams
    def self.all
      teams = Data::TEAMS.map { |data| Team.new(**data) }
      Collection.new(teams)
    end

    # Finds a team by ID
    #
    # @api public
    # @example
    #   warriors = NBA::Teams.find(NBA::Team::GSW)
    # @param team_id [Integer] the team ID to find
    # @return [Team, nil] the team with the given ID, or nil if not found
    def self.find(team_id)
      id = extract_id(team_id)
      data = Data::TEAMS.find { |t| t.fetch(:id).equal?(id) }
      Team.new(**data) if data
    end

    # Extracts the ID from a team or returns the integer directly
    #
    # @api private
    # @param team [Team, Integer] the team or team ID
    # @return [Integer] the team ID
    def self.extract_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_id
  end
end
