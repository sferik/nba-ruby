require "equalizer"
require "shale"
require_relative "players"

module NBA
  # Represents a player's fantasy profile statistics
  #
  # @api public
  class FantasyProfileStat < Shale::Mapper
    include Equalizer.new(:player_id, :player_name)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer, nil] the player's ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
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

    # @!attribute [rw] fan_duel_pts
    #   Returns FanDuel fantasy points
    #   @api public
    #   @example
    #     stat.fan_duel_pts #=> 45.2
    #   @return [Float, nil] FanDuel fantasy points
    attribute :fan_duel_pts, Shale::Type::Float

    # @!attribute [rw] nba_fantasy_pts
    #   Returns NBA Fantasy points
    #   @api public
    #   @example
    #     stat.nba_fantasy_pts #=> 52.1
    #   @return [Float, nil] NBA Fantasy points
    attribute :nba_fantasy_pts, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points per game
    #   @api public
    #   @example
    #     stat.pts #=> 26.4
    #   @return [Float, nil] points per game
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns rebounds per game
    #   @api public
    #   @example
    #     stat.reb #=> 5.7
    #   @return [Float, nil] rebounds per game
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stat.ast #=> 6.1
    #   @return [Float, nil] assists per game
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns 3-point field goals made
    #   @api public
    #   @example
    #     stat.fg3m #=> 4.8
    #   @return [Float, nil] 3-point field goals made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.472
    #   @return [Float, nil] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.908
    #   @return [Float, nil] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals per game
    #   @api public
    #   @example
    #     stat.stl #=> 1.2
    #   @return [Float, nil] steals per game
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks per game
    #   @api public
    #   @example
    #     stat.blk #=> 0.3
    #   @return [Float, nil] blocks per game
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers per game
    #   @api public
    #   @example
    #     stat.tov #=> 3.1
    #   @return [Float, nil] turnovers per game
    attribute :tov, Shale::Type::Float

    # Returns the player
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player id=201939 ...>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end
  end
end
