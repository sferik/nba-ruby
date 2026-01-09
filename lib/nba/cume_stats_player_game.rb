require "equalizer"
require "shale"

module NBA
  # Represents a single game in cumulative player statistics
  class CumeStatsPlayerGame < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     game.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] matchup
    #   Returns the matchup description
    #   @api public
    #   @example
    #     game.matchup #=> "GSW vs. LAL"
    #   @return [String] the matchup description
    attribute :matchup, Shale::Type::String

    # @!attribute [rw] game_date
    #   Returns the game date
    #   @api public
    #   @example
    #     game.game_date #=> "2024-10-22"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] vs_team_id
    #   Returns the opposing team ID
    #   @api public
    #   @example
    #     game.vs_team_id #=> 1610612747
    #   @return [Integer] the opposing team ID
    attribute :vs_team_id, Shale::Type::Integer

    # @!attribute [rw] vs_team_city
    #   Returns the opposing team city
    #   @api public
    #   @example
    #     game.vs_team_city #=> "Los Angeles"
    #   @return [String] the opposing team city
    attribute :vs_team_city, Shale::Type::String

    # @!attribute [rw] vs_team_name
    #   Returns the opposing team name
    #   @api public
    #   @example
    #     game.vs_team_name #=> "Lakers"
    #   @return [String] the opposing team name
    attribute :vs_team_name, Shale::Type::String

    # @!attribute [rw] min
    #   Returns the minutes played
    #   @api public
    #   @example
    #     game.min #=> 35
    #   @return [Integer] the minutes played
    attribute :min, Shale::Type::Integer

    # @!attribute [rw] sec
    #   Returns the seconds played
    #   @api public
    #   @example
    #     game.sec #=> 42
    #   @return [Integer] the seconds played
    attribute :sec, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns the field goals made
    #   @api public
    #   @example
    #     game.fgm #=> 10
    #   @return [Integer] the field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns the field goals attempted
    #   @api public
    #   @example
    #     game.fga #=> 20
    #   @return [Integer] the field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns the field goal percentage
    #   @api public
    #   @example
    #     game.fg_pct #=> 0.500
    #   @return [Float] the field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns the three-point field goals made
    #   @api public
    #   @example
    #     game.fg3m #=> 3
    #   @return [Integer] the three-point field goals made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns the three-point field goals attempted
    #   @api public
    #   @example
    #     game.fg3a #=> 8
    #   @return [Integer] the three-point field goals attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns the three-point field goal percentage
    #   @api public
    #   @example
    #     game.fg3_pct #=> 0.375
    #   @return [Float] the three-point field goal percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns the free throws made
    #   @api public
    #   @example
    #     game.ftm #=> 7
    #   @return [Integer] the free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns the free throws attempted
    #   @api public
    #   @example
    #     game.fta #=> 8
    #   @return [Integer] the free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns the free throw percentage
    #   @api public
    #   @example
    #     game.ft_pct #=> 0.875
    #   @return [Float] the free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns the offensive rebounds
    #   @api public
    #   @example
    #     game.oreb #=> 2
    #   @return [Integer] the offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns the defensive rebounds
    #   @api public
    #   @example
    #     game.dreb #=> 6
    #   @return [Integer] the defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] reb
    #   Returns the total rebounds
    #   @api public
    #   @example
    #     game.reb #=> 8
    #   @return [Integer] the total rebounds
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns the assists
    #   @api public
    #   @example
    #     game.ast #=> 5
    #   @return [Integer] the assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns the personal fouls
    #   @api public
    #   @example
    #     game.pf #=> 3
    #   @return [Integer] the personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns the steals
    #   @api public
    #   @example
    #     game.stl #=> 2
    #   @return [Integer] the steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns the turnovers
    #   @api public
    #   @example
    #     game.tov #=> 3
    #   @return [Integer] the turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns the blocks
    #   @api public
    #   @example
    #     game.blk #=> 1
    #   @return [Integer] the blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns the points
    #   @api public
    #   @example
    #     game.pts #=> 30
    #   @return [Integer] the points
    attribute :pts, Shale::Type::Integer
  end
end
