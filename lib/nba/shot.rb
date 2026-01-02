module NBA
  # Represents a single shot attempt
  class Shot < Shale::Mapper
    include Equalizer.new(:game_id, :game_event_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     shot.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_event_id
    #   Returns the game event ID
    #   @api public
    #   @example
    #     shot.game_event_id #=> 10
    #   @return [Integer] the event ID
    attribute :game_event_id, Shale::Type::Integer

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     shot.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     shot.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     shot.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     shot.team_name #=> "Golden State Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] period
    #   Returns the period number
    #   @api public
    #   @example
    #     shot.period #=> 1
    #   @return [Integer] the period
    attribute :period, Shale::Type::Integer

    # @!attribute [rw] minutes_remaining
    #   Returns minutes remaining in period
    #   @api public
    #   @example
    #     shot.minutes_remaining #=> 10
    #   @return [Integer] minutes remaining
    attribute :minutes_remaining, Shale::Type::Integer

    # @!attribute [rw] seconds_remaining
    #   Returns seconds remaining in period
    #   @api public
    #   @example
    #     shot.seconds_remaining #=> 45
    #   @return [Integer] seconds remaining
    attribute :seconds_remaining, Shale::Type::Integer

    # @!attribute [rw] action_type
    #   Returns the shot action type
    #   @api public
    #   @example
    #     shot.action_type #=> "Jump Shot"
    #   @return [String] the action type
    attribute :action_type, Shale::Type::String

    # @!attribute [rw] shot_type
    #   Returns the shot type (2PT or 3PT)
    #   @api public
    #   @example
    #     shot.shot_type #=> "3PT Field Goal"
    #   @return [String] the shot type
    attribute :shot_type, Shale::Type::String

    # @!attribute [rw] shot_zone_basic
    #   Returns the basic shot zone
    #   @api public
    #   @example
    #     shot.shot_zone_basic #=> "Above the Break 3"
    #   @return [String] the zone
    attribute :shot_zone_basic, Shale::Type::String

    # @!attribute [rw] shot_zone_area
    #   Returns the shot zone area
    #   @api public
    #   @example
    #     shot.shot_zone_area #=> "Center(C)"
    #   @return [String] the area
    attribute :shot_zone_area, Shale::Type::String

    # @!attribute [rw] shot_zone_range
    #   Returns the shot zone range
    #   @api public
    #   @example
    #     shot.shot_zone_range #=> "24+ ft."
    #   @return [String] the range
    attribute :shot_zone_range, Shale::Type::String

    # @!attribute [rw] shot_distance
    #   Returns the shot distance in feet
    #   @api public
    #   @example
    #     shot.shot_distance #=> 26
    #   @return [Integer] the distance
    attribute :shot_distance, Shale::Type::Integer

    # @!attribute [rw] loc_x
    #   Returns the X coordinate on the court
    #   @api public
    #   @example
    #     shot.loc_x #=> -22
    #   @return [Integer] the X coordinate
    attribute :loc_x, Shale::Type::Integer

    # @!attribute [rw] loc_y
    #   Returns the Y coordinate on the court
    #   @api public
    #   @example
    #     shot.loc_y #=> 239
    #   @return [Integer] the Y coordinate
    attribute :loc_y, Shale::Type::Integer

    # @!attribute [rw] shot_attempted_flag
    #   Returns whether a shot was attempted
    #   @api public
    #   @example
    #     shot.shot_attempted_flag #=> 1
    #   @return [Integer] 1 if attempted
    attribute :shot_attempted_flag, Shale::Type::Integer

    # @!attribute [rw] shot_made_flag
    #   Returns whether the shot was made
    #   @api public
    #   @example
    #     shot.shot_made_flag #=> 1
    #   @return [Integer] 1 if made, 0 if missed
    attribute :shot_made_flag, Shale::Type::Integer

    # Returns whether the shot was made
    #
    # @api public
    # @example
    #   shot.made? #=> true
    # @return [Boolean] true if made
    def made?
      shot_made_flag.eql?(1)
    end

    # Returns whether the shot was missed
    #
    # @api public
    # @example
    #   shot.missed? #=> false
    # @return [Boolean] true if missed
    def missed?
      shot_made_flag&.zero?
    end

    # Returns whether this is a three-pointer
    #
    # @api public
    # @example
    #   shot.three_pointer? #=> true
    # @return [Boolean] true if 3PT shot
    def three_pointer?
      shot_type&.include?("3PT")
    end

    # Returns the game object for this shot
    #
    # @api public
    # @example
    #   shot.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end
  end
end
