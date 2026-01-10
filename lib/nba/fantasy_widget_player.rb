require "equalizer"
require "shale"

module NBA
  # Represents a player's fantasy statistics from the fantasy widget
  #
  # @api public
  # @example
  #   player.player_name #=> "Stephen Curry"
  #   player.fan_duel_pts #=> 45.2
  class FantasyWidgetPlayer < Shale::Mapper
    include Equalizer.new(:player_id)

    #   Returns the player ID
    #   @api public
    #   @example
    #     player.player_id #=> 201939
    #   @return [Integer, nil] the player ID
    attribute :player_id, Shale::Type::Integer

    #   Returns the player name
    #   @api public
    #   @example
    #     player.player_name #=> "Stephen Curry"
    #   @return [String, nil] the player name
    attribute :player_name, Shale::Type::String

    #   Returns the player position
    #   @api public
    #   @example
    #     player.player_position #=> "G"
    #   @return [String, nil] the player position
    attribute :player_position, Shale::Type::String

    #   Returns the team ID
    #   @api public
    #   @example
    #     player.team_id #=> 1610612744
    #   @return [Integer, nil] the team ID
    attribute :team_id, Shale::Type::Integer

    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     player.team_abbreviation #=> "GSW"
    #   @return [String, nil] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    #   Returns games played
    #   @api public
    #   @example
    #     player.gp #=> 74
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    #   Returns minutes played
    #   @api public
    #   @example
    #     player.min #=> 32.7
    #   @return [Float, nil] minutes played
    attribute :min, Shale::Type::Float

    #   Returns FanDuel points
    #   @api public
    #   @example
    #     player.fan_duel_pts #=> 45.2
    #   @return [Float, nil] FanDuel points
    attribute :fan_duel_pts, Shale::Type::Float

    #   Returns NBA fantasy points
    #   @api public
    #   @example
    #     player.nba_fantasy_pts #=> 52.8
    #   @return [Float, nil] NBA fantasy points
    attribute :nba_fantasy_pts, Shale::Type::Float

    #   Returns points
    #   @api public
    #   @example
    #     player.pts #=> 26.4
    #   @return [Float, nil] points
    attribute :pts, Shale::Type::Float

    #   Returns rebounds
    #   @api public
    #   @example
    #     player.reb #=> 5.1
    #   @return [Float, nil] rebounds
    attribute :reb, Shale::Type::Float

    #   Returns assists
    #   @api public
    #   @example
    #     player.ast #=> 6.3
    #   @return [Float, nil] assists
    attribute :ast, Shale::Type::Float
  end
end
