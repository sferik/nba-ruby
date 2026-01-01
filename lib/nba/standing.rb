require "equalizer"
require "shale"
require_relative "teams"

module NBA
  # Represents a team's standing in the league
  class Standing < Shale::Mapper
    include Equalizer.new(:team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     standing.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     standing.team_name #=> "Golden State Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] conference
    #   Returns the conference
    #   @api public
    #   @example
    #     standing.conference #=> "West"
    #   @return [String] the conference
    attribute :conference, Shale::Type::String

    # @!attribute [rw] division
    #   Returns the division
    #   @api public
    #   @example
    #     standing.division #=> "Pacific"
    #   @return [String] the division
    attribute :division, Shale::Type::String

    # @!attribute [rw] wins
    #   Returns the number of wins
    #   @api public
    #   @example
    #     standing.wins #=> 45
    #   @return [Integer] the number of wins
    attribute :wins, Shale::Type::Integer

    # @!attribute [rw] losses
    #   Returns the number of losses
    #   @api public
    #   @example
    #     standing.losses #=> 30
    #   @return [Integer] the number of losses
    attribute :losses, Shale::Type::Integer

    # @!attribute [rw] win_pct
    #   Returns the win percentage
    #   @api public
    #   @example
    #     standing.win_pct #=> 0.600
    #   @return [Float] the win percentage
    attribute :win_pct, Shale::Type::Float

    # @!attribute [rw] conference_rank
    #   Returns the conference rank
    #   @api public
    #   @example
    #     standing.conference_rank #=> 5
    #   @return [Integer] the conference rank
    attribute :conference_rank, Shale::Type::Integer

    # @!attribute [rw] home_record
    #   Returns the home record
    #   @api public
    #   @example
    #     standing.home_record #=> "25-12"
    #   @return [String] the home record
    attribute :home_record, Shale::Type::String

    # @!attribute [rw] road_record
    #   Returns the road record
    #   @api public
    #   @example
    #     standing.road_record #=> "20-18"
    #   @return [String] the road record
    attribute :road_record, Shale::Type::String

    # @!attribute [rw] streak
    #   Returns the current streak
    #   @api public
    #   @example
    #     standing.streak #=> "W3"
    #   @return [String] the current streak
    attribute :streak, Shale::Type::String

    # Returns the team object for this standing
    #
    # @api public
    # @example
    #   standing.team #=> #<NBA::Team>
    #   standing.team.city #=> "San Francisco"
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    json do
      map "team_id", to: :team_id
      map "teamId", to: :team_id
      map "team_name", to: :team_name
      map "teamName", to: :team_name
      map "conference", to: :conference
      map "division", to: :division
      map "wins", to: :wins
      map "losses", to: :losses
      map "win_pct", to: :win_pct
      map "winPct", to: :win_pct
      map "conference_rank", to: :conference_rank
      map "conferenceRank", to: :conference_rank
      map "home_record", to: :home_record
      map "homeRecord", to: :home_record
      map "road_record", to: :road_record
      map "roadRecord", to: :road_record
      map "streak", to: :streak
    end
  end
end
