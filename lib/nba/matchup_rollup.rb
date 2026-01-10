require "equalizer"
require "shale"

module NBA
  # Represents a matchup rollup statistic entry
  #
  # @api public
  # @example
  #   matchup.def_player_name #=> "Jayson Tatum"
  #   matchup.matchup_fg_pct #=> 0.425
  class MatchupRollup < Shale::Mapper
    include Equalizer.new(:season_id, :def_player_id, :position)

    #   Returns the season ID
    #   @api public
    #   @example
    #     matchup.season_id #=> "22023"
    #   @return [String, nil] the season ID
    attribute :season_id, Shale::Type::String

    #   Returns the position
    #   @api public
    #   @example
    #     matchup.position #=> "F"
    #   @return [String, nil] the position
    attribute :position, Shale::Type::String

    #   Returns percent of time
    #   @api public
    #   @example
    #     matchup.percent_of_time #=> 0.15
    #   @return [Float, nil] percent of time
    attribute :percent_of_time, Shale::Type::Float

    #   Returns the defensive player ID
    #   @api public
    #   @example
    #     matchup.def_player_id #=> 1628369
    #   @return [Integer, nil] the defensive player ID
    attribute :def_player_id, Shale::Type::Integer

    #   Returns the defensive player name
    #   @api public
    #   @example
    #     matchup.def_player_name #=> "Jayson Tatum"
    #   @return [String, nil] the defensive player name
    attribute :def_player_name, Shale::Type::String

    #   Returns games played
    #   @api public
    #   @example
    #     matchup.gp #=> 82
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    #   Returns matchup minutes
    #   @api public
    #   @example
    #     matchup.matchup_min #=> 2.5
    #   @return [Float, nil] matchup minutes
    attribute :matchup_min, Shale::Type::Float

    #   Returns partial possessions
    #   @api public
    #   @example
    #     matchup.partial_poss #=> 1.8
    #   @return [Float, nil] partial possessions
    attribute :partial_poss, Shale::Type::Float

    #   Returns player points
    #   @api public
    #   @example
    #     matchup.player_pts #=> 1.2
    #   @return [Float, nil] player points
    attribute :player_pts, Shale::Type::Float

    #   Returns team points
    #   @api public
    #   @example
    #     matchup.team_pts #=> 1.4
    #   @return [Float, nil] team points
    attribute :team_pts, Shale::Type::Float

    #   Returns matchup field goal percentage
    #   @api public
    #   @example
    #     matchup.matchup_fg_pct #=> 0.425
    #   @return [Float, nil] matchup field goal percentage
    attribute :matchup_fg_pct, Shale::Type::Float

    #   Returns matchup 3-point percentage
    #   @api public
    #   @example
    #     matchup.matchup_fg3_pct #=> 0.375
    #   @return [Float, nil] matchup 3-point percentage
    attribute :matchup_fg3_pct, Shale::Type::Float
  end
end
