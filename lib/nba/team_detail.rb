require "equalizer"
require "shale"

module NBA
  # Represents detailed team information
  class TeamDetail < Shale::Mapper
    include Equalizer.new(:team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     detail.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     detail.abbreviation #=> "GSW"
    #   @return [String] the abbreviation
    attribute :abbreviation, Shale::Type::String

    # @!attribute [rw] nickname
    #   Returns the team nickname
    #   @api public
    #   @example
    #     detail.nickname #=> "Warriors"
    #   @return [String] the nickname
    attribute :nickname, Shale::Type::String

    # @!attribute [rw] year_founded
    #   Returns the year the team was founded
    #   @api public
    #   @example
    #     detail.year_founded #=> 1946
    #   @return [Integer] the year founded
    attribute :year_founded, Shale::Type::Integer

    # @!attribute [rw] city
    #   Returns the team city
    #   @api public
    #   @example
    #     detail.city #=> "Golden State"
    #   @return [String] the city
    attribute :city, Shale::Type::String

    # @!attribute [rw] arena
    #   Returns the team's home arena
    #   @api public
    #   @example
    #     detail.arena #=> "Chase Center"
    #   @return [String] the arena
    attribute :arena, Shale::Type::String

    # @!attribute [rw] arena_capacity
    #   Returns the arena capacity
    #   @api public
    #   @example
    #     detail.arena_capacity #=> 18064
    #   @return [Integer] the capacity
    attribute :arena_capacity, Shale::Type::Integer

    # @!attribute [rw] owner
    #   Returns the team owner
    #   @api public
    #   @example
    #     detail.owner #=> "Joe Lacob"
    #   @return [String] the owner
    attribute :owner, Shale::Type::String

    # @!attribute [rw] general_manager
    #   Returns the general manager
    #   @api public
    #   @example
    #     detail.general_manager #=> "Mike Dunleavy Jr."
    #   @return [String] the general manager
    attribute :general_manager, Shale::Type::String

    # @!attribute [rw] head_coach
    #   Returns the head coach
    #   @api public
    #   @example
    #     detail.head_coach #=> "Steve Kerr"
    #   @return [String] the head coach
    attribute :head_coach, Shale::Type::String

    # @!attribute [rw] d_league_affiliation
    #   Returns the G League affiliate
    #   @api public
    #   @example
    #     detail.d_league_affiliation #=> "Santa Cruz Warriors"
    #   @return [String] the G League affiliate
    attribute :d_league_affiliation, Shale::Type::String

    # Returns the team object
    #
    # @api public
    # @example
    #   detail.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the full team name
    #
    # @api public
    # @example
    #   detail.full_name #=> "Golden State Warriors"
    # @return [String] the full name
    def full_name
      "#{city} #{nickname}".strip
    end
  end
end
