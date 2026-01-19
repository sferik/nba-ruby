require "equalizer"
require "shale"

module NBA
  # Represents career statistics for a player (season averages)
  class CareerStats < Shale::Mapper
    include Equalizer.new(:player_id, :season_id)
    include StatHelpers

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stats.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     stats.season_id #=> "2024-25"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stats.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stats.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] player_age
    #   Returns the player's age during the season
    #   @api public
    #   @example
    #     stats.player_age #=> 36
    #   @return [Integer] the player's age
    attribute :player_age, Shale::Type::Integer

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stats.gp #=> 74
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] gs
    #   Returns games started
    #   @api public
    #   @example
    #     stats.gs #=> 74
    #   @return [Integer] games started
    attribute :gs, Shale::Type::Integer

    # @!attribute [rw] min
    #   Returns minutes per game
    #   @api public
    #   @example
    #     stats.min #=> 32.7
    #   @return [Float] minutes per game
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made per game
    #   @api public
    #   @example
    #     stats.fgm #=> 8.4
    #   @return [Float] field goals made per game
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted per game
    #   @api public
    #   @example
    #     stats.fga #=> 17.9
    #   @return [Float] field goals attempted per game
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stats.fg_pct #=> 0.473
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made per game
    #   @api public
    #   @example
    #     stats.fg3m #=> 4.8
    #   @return [Float] three-pointers made per game
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted per game
    #   @api public
    #   @example
    #     stats.fg3a #=> 11.7
    #   @return [Float] three-pointers attempted per game
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stats.fg3_pct #=> 0.408
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made per game
    #   @api public
    #   @example
    #     stats.ftm #=> 4.5
    #   @return [Float] free throws made per game
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted per game
    #   @api public
    #   @example
    #     stats.fta #=> 4.9
    #   @return [Float] free throws attempted per game
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stats.ft_pct #=> 0.915
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds per game
    #   @api public
    #   @example
    #     stats.oreb #=> 0.5
    #   @return [Float] offensive rebounds per game
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds per game
    #   @api public
    #   @example
    #     stats.dreb #=> 4.0
    #   @return [Float] defensive rebounds per game
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds per game
    #   @api public
    #   @example
    #     stats.reb #=> 4.5
    #   @return [Float] total rebounds per game
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stats.ast #=> 5.1
    #   @return [Float] assists per game
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals per game
    #   @api public
    #   @example
    #     stats.stl #=> 0.7
    #   @return [Float] steals per game
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks per game
    #   @api public
    #   @example
    #     stats.blk #=> 0.4
    #   @return [Float] blocks per game
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers per game
    #   @api public
    #   @example
    #     stats.tov #=> 3.0
    #   @return [Float] turnovers per game
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls per game
    #   @api public
    #   @example
    #     stats.pf #=> 1.8
    #   @return [Float] personal fouls per game
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points per game
    #   @api public
    #   @example
    #     stats.pts #=> 26.4
    #   @return [Float] points per game
    attribute :pts, Shale::Type::Float
  end
end
