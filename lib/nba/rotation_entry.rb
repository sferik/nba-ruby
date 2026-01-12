module NBA
  # Represents a player's rotation entry in a game
  class RotationEntry < Shale::Mapper
    include Equalizer.new(:game_id, :player_id, :in_time_real)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     entry.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     entry.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     entry.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     entry.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     entry.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_first
    #   Returns the player's first name
    #   @api public
    #   @example
    #     entry.player_first #=> "Stephen"
    #   @return [String] the first name
    attribute :player_first, Shale::Type::String

    # @!attribute [rw] player_last
    #   Returns the player's last name
    #   @api public
    #   @example
    #     entry.player_last #=> "Curry"
    #   @return [String] the last name
    attribute :player_last, Shale::Type::String

    # @!attribute [rw] in_time_real
    #   Returns the time the player checked in (in tenths of seconds from game start)
    #   @api public
    #   @example
    #     entry.in_time_real #=> 0
    #   @return [Integer] the in time
    attribute :in_time_real, Shale::Type::Integer

    # @!attribute [rw] out_time_real
    #   Returns the time the player checked out (in tenths of seconds from game start)
    #   @api public
    #   @example
    #     entry.out_time_real #=> 4320
    #   @return [Integer] the out time
    attribute :out_time_real, Shale::Type::Integer

    # @!attribute [rw] player_pts
    #   Returns the points scored during this stint
    #   @api public
    #   @example
    #     entry.player_pts #=> 12
    #   @return [Integer] the points
    attribute :player_pts, Shale::Type::Integer

    # @!attribute [rw] pt_diff
    #   Returns the point differential during this stint
    #   @api public
    #   @example
    #     entry.pt_diff #=> 8
    #   @return [Integer] the point differential
    attribute :pt_diff, Shale::Type::Integer

    # @!attribute [rw] usg_pct
    #   Returns the usage percentage during this stint
    #   @api public
    #   @example
    #     entry.usg_pct #=> 32.5
    #   @return [Float] the usage percentage
    attribute :usg_pct, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   entry.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   entry.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the game object
    #
    # @api public
    # @example
    #   entry.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end

    # Returns the player's full name
    #
    # @api public
    # @example
    #   entry.player_name #=> "Stephen Curry"
    # @return [String] the full name
    def player_name
      "#{player_first} #{player_last}".strip
    end

    # Returns the stint duration in tenths of seconds
    #
    # @api public
    # @example
    #   entry.duration #=> 4320
    # @return [Integer, nil] the duration
    def duration
      return unless in_time_real && out_time_real

      out_time_real - in_time_real
    end
  end
end
