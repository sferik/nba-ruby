require_relative "collection"
require_relative "data"
require_relative "team"
require_relative "utils"

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
      Collection.new(Data::TEAMS.map { |data| Team.new(**data) })
    end

    # Finds a team by ID
    #
    # @api public
    # @example
    #   warriors = NBA::Teams.find(NBA::Team::GSW)
    # @param team_id [Integer] the team ID to find
    # @return [Team, nil] the team with the given ID, or nil if not found
    def self.find(team_id)
      id = Utils.extract_id(team_id)
      data = Data::TEAMS.find { |t| t.fetch(:id).eql?(id) }
      Team.new(**data) if data
    end
  end
end
