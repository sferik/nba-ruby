require "equalizer"
require "shale"

module NBA
  # Represents a year/season a team participated in the league
  class TeamYear < Shale::Mapper
    include Equalizer.new(:team_id, :year)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     team_year.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] year
    #   Returns the year
    #   @api public
    #   @example
    #     team_year.year #=> 2024
    #   @return [Integer] the year
    attribute :year, Shale::Type::Integer

    # @!attribute [rw] abbreviation
    #   Returns the team abbreviation for that year
    #   @api public
    #   @example
    #     team_year.abbreviation #=> "GSW"
    #   @return [String] the abbreviation
    attribute :abbreviation, Shale::Type::String

    # Returns the team object
    #
    # @api public
    # @example
    #   team_year.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the season string
    #
    # @api public
    # @example
    #   team_year.season #=> "2024-25"
    # @return [String, nil] the season string
    def season
      return unless year

      Utils.format_season(year)
    end
  end
end
