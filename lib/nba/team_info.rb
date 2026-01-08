require "equalizer"
require "shale"
require_relative "teams"

module NBA
  # Represents team information from the TeamInfoCommon endpoint
  #
  # @api public
  class TeamInfo < Shale::Mapper
    include Equalizer.new(:team_id, :season_year)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     info.team_id #=> 1610612744
    #   @return [Integer, nil] the team's ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] season_year
    #   Returns the season year
    #   @api public
    #   @example
    #     info.season_year #=> "2024-25"
    #   @return [String, nil] the season year
    attribute :season_year, Shale::Type::String

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     info.team_city #=> "Golden State"
    #   @return [String, nil] the team's city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     info.team_name #=> "Warriors"
    #   @return [String, nil] the team's name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     info.team_abbreviation #=> "GSW"
    #   @return [String, nil] the team's abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] team_conference
    #   Returns the team conference
    #   @api public
    #   @example
    #     info.team_conference #=> "West"
    #   @return [String, nil] the team's conference
    attribute :team_conference, Shale::Type::String

    # @!attribute [rw] team_division
    #   Returns the team division
    #   @api public
    #   @example
    #     info.team_division #=> "Pacific"
    #   @return [String, nil] the team's division
    attribute :team_division, Shale::Type::String

    # @!attribute [rw] team_code
    #   Returns the team code
    #   @api public
    #   @example
    #     info.team_code #=> "warriors"
    #   @return [String, nil] the team's code
    attribute :team_code, Shale::Type::String

    # @!attribute [rw] team_slug
    #   Returns the team slug
    #   @api public
    #   @example
    #     info.team_slug #=> "warriors"
    #   @return [String, nil] the team's slug
    attribute :team_slug, Shale::Type::String

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     info.w #=> 46
    #   @return [Integer, nil] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     info.l #=> 36
    #   @return [Integer, nil] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     info.pct #=> 0.561
    #   @return [Float, nil] win percentage
    attribute :pct, Shale::Type::Float

    # @!attribute [rw] conf_rank
    #   Returns conference rank
    #   @api public
    #   @example
    #     info.conf_rank #=> 4
    #   @return [Integer, nil] conference rank
    attribute :conf_rank, Shale::Type::Integer

    # @!attribute [rw] div_rank
    #   Returns division rank
    #   @api public
    #   @example
    #     info.div_rank #=> 2
    #   @return [Integer, nil] division rank
    attribute :div_rank, Shale::Type::Integer

    # @!attribute [rw] min_year
    #   Returns the minimum year (franchise founding year)
    #   @api public
    #   @example
    #     info.min_year #=> "1946"
    #   @return [String, nil] the minimum year
    attribute :min_year, Shale::Type::String

    # @!attribute [rw] max_year
    #   Returns the maximum year
    #   @api public
    #   @example
    #     info.max_year #=> "2024"
    #   @return [String, nil] the maximum year
    attribute :max_year, Shale::Type::String

    # Returns the team associated with this info
    #
    # @api public
    # @example
    #   info.team #=> #<NBA::Team ...>
    # @return [Team, nil] the Team object
    def team
      Teams.find(team_id)
    end
  end
end
