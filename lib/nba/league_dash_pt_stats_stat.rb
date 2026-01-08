require "equalizer"
require "shale"
require_relative "players"
require_relative "teams"

module NBA
  # Represents league-wide player or team speed and distance tracking statistics
  #
  # @api public
  class LeagueDashPtStatsStat < Shale::Mapper
    include Equalizer.new(:player_id, :team_id)

    # @!attribute [rw] player_id
    #   Returns the player ID (for player mode)
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer, nil] the player's ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name (for player mode)
    #   @api public
    #   @example
    #     stat.player_name #=> "Stephen Curry"
    #   @return [String, nil] the player's name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer, nil] the team's ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String, nil] the team's abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name (for team mode)
    #   @api public
    #   @example
    #     stat.team_name #=> "Golden State Warriors"
    #   @return [String, nil] the team's name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] age
    #   Returns the player's age (for player mode)
    #   @api public
    #   @example
    #     stat.age #=> 36.0
    #   @return [Float, nil] the player's age
    attribute :age, Shale::Type::Float

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 82
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 50
    #   @return [Integer, nil] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 32
    #   @return [Integer, nil] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.min #=> 32.5
    #   @return [Float, nil] minutes played
    attribute :min, Shale::Type::Float

    # @!attribute [rw] dist_feet
    #   Returns distance traveled in feet
    #   @api public
    #   @example
    #     stat.dist_feet #=> 12500.5
    #   @return [Float, nil] distance in feet
    attribute :dist_feet, Shale::Type::Float

    # @!attribute [rw] dist_miles
    #   Returns distance traveled in miles
    #   @api public
    #   @example
    #     stat.dist_miles #=> 2.37
    #   @return [Float, nil] distance in miles
    attribute :dist_miles, Shale::Type::Float

    # @!attribute [rw] dist_miles_off
    #   Returns distance traveled on offense in miles
    #   @api public
    #   @example
    #     stat.dist_miles_off #=> 1.15
    #   @return [Float, nil] distance on offense in miles
    attribute :dist_miles_off, Shale::Type::Float

    # @!attribute [rw] dist_miles_def
    #   Returns distance traveled on defense in miles
    #   @api public
    #   @example
    #     stat.dist_miles_def #=> 1.22
    #   @return [Float, nil] distance on defense in miles
    attribute :dist_miles_def, Shale::Type::Float

    # @!attribute [rw] avg_speed
    #   Returns average speed
    #   @api public
    #   @example
    #     stat.avg_speed #=> 4.25
    #   @return [Float, nil] average speed
    attribute :avg_speed, Shale::Type::Float

    # @!attribute [rw] avg_speed_off
    #   Returns average speed on offense
    #   @api public
    #   @example
    #     stat.avg_speed_off #=> 4.15
    #   @return [Float, nil] average speed on offense
    attribute :avg_speed_off, Shale::Type::Float

    # @!attribute [rw] avg_speed_def
    #   Returns average speed on defense
    #   @api public
    #   @example
    #     stat.avg_speed_def #=> 4.35
    #   @return [Float, nil] average speed on defense
    attribute :avg_speed_def, Shale::Type::Float

    # Returns the player
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player id=201939 ...>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team id=1610612744 ...>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
