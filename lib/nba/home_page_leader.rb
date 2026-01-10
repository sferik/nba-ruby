require "shale"
require "equalizer"

module NBA
  # Represents a home page leader entry
  #
  # @api public
  # @example
  #   leader.rank #=> 1
  #   leader.player #=> "Stephen Curry"
  #   leader.pts #=> 26.4
  class HomePageLeader < Shale::Mapper
    include Equalizer.new(:player_id, :team_id, :rank)

    #   Returns the rank
    #   @api public
    #   @example
    #     leader.rank #=> 1
    #   @return [Integer, nil] the rank
    attribute :rank, Shale::Type::Integer

    #   Returns the player ID
    #   @api public
    #   @example
    #     leader.player_id #=> 201939
    #   @return [Integer, nil] the player ID
    attribute :player_id, Shale::Type::Integer

    #   Returns the player name
    #   @api public
    #   @example
    #     leader.player #=> "Stephen Curry"
    #   @return [String, nil] the player name
    attribute :player, Shale::Type::String

    #   Returns the team ID
    #   @api public
    #   @example
    #     leader.team_id #=> 1610612744
    #   @return [Integer, nil] the team ID
    attribute :team_id, Shale::Type::Integer

    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     leader.team_abbreviation #=> "GSW"
    #   @return [String, nil] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    #   Returns points
    #   @api public
    #   @example
    #     leader.pts #=> 26.4
    #   @return [Float, nil] points
    attribute :pts, Shale::Type::Float

    #   Returns field goal percentage
    #   @api public
    #   @example
    #     leader.fg_pct #=> 0.493
    #   @return [Float, nil] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    #   Returns three-point percentage
    #   @api public
    #   @example
    #     leader.fg3_pct #=> 0.423
    #   @return [Float, nil] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    #   Returns free throw percentage
    #   @api public
    #   @example
    #     leader.ft_pct #=> 0.913
    #   @return [Float, nil] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    #   Returns efficiency rating
    #   @api public
    #   @example
    #     leader.eff #=> 31.5
    #   @return [Float, nil] efficiency rating
    attribute :eff, Shale::Type::Float

    #   Returns assists
    #   @api public
    #   @example
    #     leader.ast #=> 6.1
    #   @return [Float, nil] assists
    attribute :ast, Shale::Type::Float

    #   Returns rebounds
    #   @api public
    #   @example
    #     leader.reb #=> 5.2
    #   @return [Float, nil] rebounds
    attribute :reb, Shale::Type::Float
  end
end
