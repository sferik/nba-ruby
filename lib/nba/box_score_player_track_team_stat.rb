require "equalizer"
require "shale"

module NBA
  # Represents player tracking statistics for a team in a game
  class BoxScorePlayerTrackTeamStat < Shale::Mapper
    include Equalizer.new(:game_id, :team_id)

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

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

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

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.min #=> "240:00"
    #   @return [String] the minutes
    attribute :min, Shale::Type::String

    # @!attribute [rw] speed
    #   Returns team average speed in miles per hour
    #   @api public
    #   @example
    #     stat.speed #=> 4.38
    #   @return [Float] average speed
    attribute :speed, Shale::Type::Float

    # @!attribute [rw] distance
    #   Returns total team distance traveled in miles
    #   @api public
    #   @example
    #     stat.distance #=> 24.5
    #   @return [Float] distance traveled
    attribute :distance, Shale::Type::Float

    # @!attribute [rw] oreb_chances
    #   Returns offensive rebound chances
    #   @api public
    #   @example
    #     stat.oreb_chances #=> 35
    #   @return [Integer] offensive rebound chances
    attribute :oreb_chances, Shale::Type::Integer

    # @!attribute [rw] dreb_chances
    #   Returns defensive rebound chances
    #   @api public
    #   @example
    #     stat.dreb_chances #=> 45
    #   @return [Integer] defensive rebound chances
    attribute :dreb_chances, Shale::Type::Integer

    # @!attribute [rw] reb_chances
    #   Returns total rebound chances
    #   @api public
    #   @example
    #     stat.reb_chances #=> 80
    #   @return [Integer] total rebound chances
    attribute :reb_chances, Shale::Type::Integer

    # @!attribute [rw] touches
    #   Returns total touches
    #   @api public
    #   @example
    #     stat.touches #=> 350
    #   @return [Integer] total touches
    attribute :touches, Shale::Type::Integer

    # @!attribute [rw] secondary_ast
    #   Returns secondary assists
    #   @api public
    #   @example
    #     stat.secondary_ast #=> 12
    #   @return [Integer] secondary assists
    attribute :secondary_ast, Shale::Type::Integer

    # @!attribute [rw] ft_ast
    #   Returns free throw assists
    #   @api public
    #   @example
    #     stat.ft_ast #=> 5
    #   @return [Integer] free throw assists
    attribute :ft_ast, Shale::Type::Integer

    # @!attribute [rw] passes
    #   Returns total passes
    #   @api public
    #   @example
    #     stat.passes #=> 285
    #   @return [Integer] total passes
    attribute :passes, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     stat.ast #=> 28
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] cfgm
    #   Returns contested field goals made
    #   @api public
    #   @example
    #     stat.cfgm #=> 18
    #   @return [Integer] contested field goals made
    attribute :cfgm, Shale::Type::Integer

    # @!attribute [rw] cfga
    #   Returns contested field goals attempted
    #   @api public
    #   @example
    #     stat.cfga #=> 45
    #   @return [Integer] contested field goals attempted
    attribute :cfga, Shale::Type::Integer

    # @!attribute [rw] cfg_pct
    #   Returns contested field goal percentage
    #   @api public
    #   @example
    #     stat.cfg_pct #=> 0.400
    #   @return [Float] contested field goal percentage
    attribute :cfg_pct, Shale::Type::Float

    # @!attribute [rw] ufgm
    #   Returns uncontested field goals made
    #   @api public
    #   @example
    #     stat.ufgm #=> 24
    #   @return [Integer] uncontested field goals made
    attribute :ufgm, Shale::Type::Integer

    # @!attribute [rw] ufga
    #   Returns uncontested field goals attempted
    #   @api public
    #   @example
    #     stat.ufga #=> 35
    #   @return [Integer] uncontested field goals attempted
    attribute :ufga, Shale::Type::Integer

    # @!attribute [rw] ufg_pct
    #   Returns uncontested field goal percentage
    #   @api public
    #   @example
    #     stat.ufg_pct #=> 0.686
    #   @return [Float] uncontested field goal percentage
    attribute :ufg_pct, Shale::Type::Float

    # @!attribute [rw] dfgm
    #   Returns defended field goals made
    #   @api public
    #   @example
    #     stat.dfgm #=> 25
    #   @return [Integer] defended field goals made
    attribute :dfgm, Shale::Type::Integer

    # @!attribute [rw] dfga
    #   Returns defended field goals attempted
    #   @api public
    #   @example
    #     stat.dfga #=> 55
    #   @return [Integer] defended field goals attempted
    attribute :dfga, Shale::Type::Integer

    # @!attribute [rw] dfg_pct
    #   Returns defended field goal percentage
    #   @api public
    #   @example
    #     stat.dfg_pct #=> 0.455
    #   @return [Float] defended field goal percentage
    attribute :dfg_pct, Shale::Type::Float

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
  end
end
