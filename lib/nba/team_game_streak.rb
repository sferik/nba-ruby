require "equalizer"
require "shale"

module NBA
  # Represents a team's game streak statistics
  #
  # @api public
  class TeamGameStreak < Shale::Mapper
    include Equalizer.new(:team_id, :start_date, :end_date)

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     streak.team_name #=> "Warriors"
    #   @return [String, nil] the team's name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     streak.team_id #=> 1610612744
    #   @return [Integer, nil] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     streak.abbreviation #=> "GSW"
    #   @return [String, nil] the team abbreviation
    attribute :abbreviation, Shale::Type::String

    # @!attribute [rw] game_streak
    #   Returns the number of consecutive games in the streak
    #   @api public
    #   @example
    #     streak.game_streak #=> 10
    #   @return [Integer, nil] the number of consecutive games in the streak
    attribute :game_streak, Shale::Type::Integer

    # @!attribute [rw] start_date
    #   Returns the start date of the streak
    #   @api public
    #   @example
    #     streak.start_date #=> "2024-01-15"
    #   @return [String, nil] the start date of the streak
    attribute :start_date, Shale::Type::String

    # @!attribute [rw] end_date
    #   Returns the end date of the streak
    #   @api public
    #   @example
    #     streak.end_date #=> "2024-02-10"
    #   @return [String, nil] the end date of the streak
    attribute :end_date, Shale::Type::String

    # @!attribute [rw] active_streak
    #   Returns whether the streak is active (1 for active, 0 for inactive)
    #   @api public
    #   @example
    #     streak.active_streak #=> 1
    #   @return [Integer, nil] 1 for active, 0 for inactive
    attribute :active_streak, Shale::Type::Integer

    # @!attribute [rw] num_seasons
    #   Returns the number of seasons the streak spans
    #   @api public
    #   @example
    #     streak.num_seasons #=> 2
    #   @return [Integer, nil] the number of seasons the streak spans
    attribute :num_seasons, Shale::Type::Integer

    # @!attribute [rw] last_season
    #   Returns the last season of the streak
    #   @api public
    #   @example
    #     streak.last_season #=> "2024-25"
    #   @return [String, nil] the last season of the streak
    attribute :last_season, Shale::Type::String

    # @!attribute [rw] first_season
    #   Returns the first season of the streak
    #   @api public
    #   @example
    #     streak.first_season #=> "2023-24"
    #   @return [String, nil] the first season of the streak
    attribute :first_season, Shale::Type::String

    # Returns whether the streak is currently active
    #
    # @api public
    # @example
    #   streak.active? #=> true
    # @return [Boolean] true if the streak is active
    def active?
      active_streak.eql?(1)
    end

    # Returns the team associated with this streak
    #
    # @api public
    # @example
    #   streak.team #=> #<NBA::Team>
    # @return [Team, nil] the team object for this streak
    def team
      Teams.find(team_id)
    end
  end
end
