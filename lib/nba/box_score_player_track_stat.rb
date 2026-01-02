require "equalizer"
require "shale"

module NBA
  # Represents player tracking statistics for a player in a game
  class BoxScorePlayerTrackStat < Shale::Mapper
    include Equalizer.new(:game_id, :player_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     stat.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     stat.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] start_position
    #   Returns the starting position
    #   @api public
    #   @example
    #     stat.start_position #=> "G"
    #   @return [String] the starting position
    attribute :start_position, Shale::Type::String

    # @!attribute [rw] comment
    #   Returns any comment about the player
    #   @api public
    #   @example
    #     stat.comment #=> "DNP - Rest"
    #   @return [String] the comment
    attribute :comment, Shale::Type::String

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.min #=> "32:45"
    #   @return [String] the minutes
    attribute :min, Shale::Type::String

    # @!attribute [rw] speed
    #   Returns average speed in miles per hour
    #   @api public
    #   @example
    #     stat.speed #=> 4.52
    #   @return [Float] average speed
    attribute :speed, Shale::Type::Float

    # @!attribute [rw] distance
    #   Returns distance traveled in miles
    #   @api public
    #   @example
    #     stat.distance #=> 2.67
    #   @return [Float] distance traveled
    attribute :distance, Shale::Type::Float

    # @!attribute [rw] oreb_chances
    #   Returns offensive rebound chances
    #   @api public
    #   @example
    #     stat.oreb_chances #=> 5
    #   @return [Integer] offensive rebound chances
    attribute :oreb_chances, Shale::Type::Integer

    # @!attribute [rw] dreb_chances
    #   Returns defensive rebound chances
    #   @api public
    #   @example
    #     stat.dreb_chances #=> 12
    #   @return [Integer] defensive rebound chances
    attribute :dreb_chances, Shale::Type::Integer

    # @!attribute [rw] reb_chances
    #   Returns total rebound chances
    #   @api public
    #   @example
    #     stat.reb_chances #=> 17
    #   @return [Integer] total rebound chances
    attribute :reb_chances, Shale::Type::Integer

    # @!attribute [rw] touches
    #   Returns total touches
    #   @api public
    #   @example
    #     stat.touches #=> 65
    #   @return [Integer] total touches
    attribute :touches, Shale::Type::Integer

    # @!attribute [rw] secondary_ast
    #   Returns secondary assists
    #   @api public
    #   @example
    #     stat.secondary_ast #=> 2
    #   @return [Integer] secondary assists
    attribute :secondary_ast, Shale::Type::Integer

    # @!attribute [rw] ft_ast
    #   Returns free throw assists
    #   @api public
    #   @example
    #     stat.ft_ast #=> 1
    #   @return [Integer] free throw assists
    attribute :ft_ast, Shale::Type::Integer

    # @!attribute [rw] passes
    #   Returns total passes
    #   @api public
    #   @example
    #     stat.passes #=> 42
    #   @return [Integer] total passes
    attribute :passes, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     stat.ast #=> 8
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] cfgm
    #   Returns contested field goals made
    #   @api public
    #   @example
    #     stat.cfgm #=> 3
    #   @return [Integer] contested field goals made
    attribute :cfgm, Shale::Type::Integer

    # @!attribute [rw] cfga
    #   Returns contested field goals attempted
    #   @api public
    #   @example
    #     stat.cfga #=> 8
    #   @return [Integer] contested field goals attempted
    attribute :cfga, Shale::Type::Integer

    # @!attribute [rw] cfg_pct
    #   Returns contested field goal percentage
    #   @api public
    #   @example
    #     stat.cfg_pct #=> 0.375
    #   @return [Float] contested field goal percentage
    attribute :cfg_pct, Shale::Type::Float

    # @!attribute [rw] ufgm
    #   Returns uncontested field goals made
    #   @api public
    #   @example
    #     stat.ufgm #=> 5
    #   @return [Integer] uncontested field goals made
    attribute :ufgm, Shale::Type::Integer

    # @!attribute [rw] ufga
    #   Returns uncontested field goals attempted
    #   @api public
    #   @example
    #     stat.ufga #=> 6
    #   @return [Integer] uncontested field goals attempted
    attribute :ufga, Shale::Type::Integer

    # @!attribute [rw] ufg_pct
    #   Returns uncontested field goal percentage
    #   @api public
    #   @example
    #     stat.ufg_pct #=> 0.833
    #   @return [Float] uncontested field goal percentage
    attribute :ufg_pct, Shale::Type::Float

    # @!attribute [rw] dfgm
    #   Returns defended field goals made
    #   @api public
    #   @example
    #     stat.dfgm #=> 4
    #   @return [Integer] defended field goals made
    attribute :dfgm, Shale::Type::Integer

    # @!attribute [rw] dfga
    #   Returns defended field goals attempted
    #   @api public
    #   @example
    #     stat.dfga #=> 10
    #   @return [Integer] defended field goals attempted
    attribute :dfga, Shale::Type::Integer

    # @!attribute [rw] dfg_pct
    #   Returns defended field goal percentage
    #   @api public
    #   @example
    #     stat.dfg_pct #=> 0.400
    #   @return [Float] defended field goal percentage
    attribute :dfg_pct, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the game object
    #
    # @api public
    # @example
    #   stat.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end

    # Returns whether the player started
    #
    # @api public
    # @example
    #   stat.starter? #=> true
    # @return [Boolean] true if starter
    def starter?
      !start_position.nil? && !start_position.empty?
    end
  end
end
