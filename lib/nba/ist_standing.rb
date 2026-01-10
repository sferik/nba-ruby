require "equalizer"
require "shale"
require_relative "teams"

module NBA
  # Represents an In-Season Tournament standing entry
  class IstStanding < Shale::Mapper
    include Equalizer.new(:team_id, :season_id)

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     standing.season_id #=> "2023-24"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     standing.team_id #=> 1610612747
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     standing.team_city #=> "Los Angeles"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     standing.team_name #=> "Lakers"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     standing.team_abbreviation #=> "LAL"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] team_slug
    #   Returns the team slug
    #   @api public
    #   @example
    #     standing.team_slug #=> "lakers"
    #   @return [String] the team slug
    attribute :team_slug, Shale::Type::String

    # @!attribute [rw] conference
    #   Returns the conference
    #   @api public
    #   @example
    #     standing.conference #=> "West"
    #   @return [String] the conference
    attribute :conference, Shale::Type::String

    # @!attribute [rw] ist_group
    #   Returns the IST group
    #   @api public
    #   @example
    #     standing.ist_group #=> "West Group A"
    #   @return [String] the IST group
    attribute :ist_group, Shale::Type::String

    # @!attribute [rw] ist_group_rank
    #   Returns the rank within IST group
    #   @api public
    #   @example
    #     standing.ist_group_rank #=> 1
    #   @return [Integer] the IST group rank
    attribute :ist_group_rank, Shale::Type::Integer

    # @!attribute [rw] wins
    #   Returns the number of wins
    #   @api public
    #   @example
    #     standing.wins #=> 3
    #   @return [Integer] the number of wins
    attribute :wins, Shale::Type::Integer

    # @!attribute [rw] losses
    #   Returns the number of losses
    #   @api public
    #   @example
    #     standing.losses #=> 1
    #   @return [Integer] the number of losses
    attribute :losses, Shale::Type::Integer

    # @!attribute [rw] win_pct
    #   Returns the win percentage
    #   @api public
    #   @example
    #     standing.win_pct #=> 0.750
    #   @return [Float] the win percentage
    attribute :win_pct, Shale::Type::Float

    # @!attribute [rw] pts_for
    #   Returns total points scored
    #   @api public
    #   @example
    #     standing.pts_for #=> 450
    #   @return [Integer] points scored
    attribute :pts_for, Shale::Type::Integer

    # @!attribute [rw] pts_against
    #   Returns total points allowed
    #   @api public
    #   @example
    #     standing.pts_against #=> 420
    #   @return [Integer] points allowed
    attribute :pts_against, Shale::Type::Integer

    # @!attribute [rw] pts_diff
    #   Returns the point differential
    #   @api public
    #   @example
    #     standing.pts_diff #=> 30
    #   @return [Integer] the point differential
    attribute :pts_diff, Shale::Type::Integer

    # @!attribute [rw] clinch_indicator
    #   Returns the clinch indicator
    #   @api public
    #   @example
    #     standing.clinch_indicator #=> "z"
    #   @return [String] the clinch indicator
    attribute :clinch_indicator, Shale::Type::String

    # Returns the team object
    #
    # @api public
    # @example
    #   standing.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    json do
      map "season_id", to: :season_id
      map "team_id", to: :team_id
      map "team_city", to: :team_city
      map "team_name", to: :team_name
      map "team_abbreviation", to: :team_abbreviation
      map "team_slug", to: :team_slug
      map "conference", to: :conference
      map "ist_group", to: :ist_group
      map "ist_group_rank", to: :ist_group_rank
      map "wins", to: :wins
      map "losses", to: :losses
      map "win_pct", to: :win_pct
      map "pts_for", to: :pts_for
      map "pts_against", to: :pts_against
      map "pts_diff", to: :pts_diff
      map "clinch_indicator", to: :clinch_indicator
    end
  end
end
