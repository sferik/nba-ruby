require "shale"

module NBA
  # Represents a player's game streak statistics
  #
  # @api public
  class GameStreak < Shale::Mapper
    include Equalizer.new(:player_id, :start_date, :end_date)

    # @!attribute [rw] player_name
    #   Returns the player's name
    #   @api public
    #   @example
    #     streak.player_name #=> "Curry, Stephen"
    #   @return [String, nil] the player's name in "Last, First" format
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player's unique identifier
    #   @api public
    #   @example
    #     streak.player_id #=> 201939
    #   @return [Integer, nil] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] game_streak
    #   Returns the number of consecutive games in the streak
    #   @api public
    #   @example
    #     streak.game_streak #=> 10
    #   @return [Integer, nil] the streak length
    attribute :game_streak, Shale::Type::Integer

    # @!attribute [rw] start_date
    #   Returns the start date of the streak
    #   @api public
    #   @example
    #     streak.start_date #=> "2024-10-22"
    #   @return [String, nil] the start date
    attribute :start_date, Shale::Type::String

    # @!attribute [rw] end_date
    #   Returns the end date of the streak
    #   @api public
    #   @example
    #     streak.end_date #=> "2024-11-15"
    #   @return [String, nil] the end date
    attribute :end_date, Shale::Type::String

    # @!attribute [rw] active_streak
    #   Returns whether the streak is active
    #   @api public
    #   @example
    #     streak.active_streak #=> 1
    #   @return [Integer, nil] 1 for active, 0 for inactive
    attribute :active_streak, Shale::Type::Integer

    # @!attribute [rw] num_seasons
    #   Returns the number of seasons the streak spans
    #   @api public
    #   @example
    #     streak.num_seasons #=> 1
    #   @return [Integer, nil] the number of seasons
    attribute :num_seasons, Shale::Type::Integer

    # @!attribute [rw] last_season
    #   Returns the last season of the streak
    #   @api public
    #   @example
    #     streak.last_season #=> "2024-25"
    #   @return [String, nil] the last season
    attribute :last_season, Shale::Type::String

    # @!attribute [rw] first_season
    #   Returns the first season of the streak
    #   @api public
    #   @example
    #     streak.first_season #=> "2024-25"
    #   @return [String, nil] the first season
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

    # Returns the player associated with this streak
    #
    # @api public
    # @example
    #   streak.player #=> #<NBA::Player>
    # @return [Player, nil] the player object for this streak
    def player
      Players.find(player_id)
    end
  end
end
