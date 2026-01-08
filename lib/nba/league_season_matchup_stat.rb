require "equalizer"
require "shale"
require_relative "players"
require_relative "teams"

module NBA
  # Represents a season matchup statistic between offensive and defensive players
  #
  # @api public
  class LeagueSeasonMatchupStat < Shale::Mapper
    include Equalizer.new(:season_id, :off_player_id, :def_player_id)

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     stat.season_id #=> "22024"
    #   @return [String, nil] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] off_player_id
    #   Returns the offensive player ID
    #   @api public
    #   @example
    #     stat.off_player_id #=> 201939
    #   @return [Integer, nil] the offensive player's ID
    attribute :off_player_id, Shale::Type::Integer

    # @!attribute [rw] off_player_name
    #   Returns the offensive player name
    #   @api public
    #   @example
    #     stat.off_player_name #=> "Stephen Curry"
    #   @return [String, nil] the offensive player's name
    attribute :off_player_name, Shale::Type::String

    # @!attribute [rw] def_player_id
    #   Returns the defensive player ID
    #   @api public
    #   @example
    #     stat.def_player_id #=> 203507
    #   @return [Integer, nil] the defensive player's ID
    attribute :def_player_id, Shale::Type::Integer

    # @!attribute [rw] def_player_name
    #   Returns the defensive player name
    #   @api public
    #   @example
    #     stat.def_player_name #=> "Giannis Antetokounmpo"
    #   @return [String, nil] the defensive player's name
    attribute :def_player_name, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 4
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] matchup_min
    #   Returns matchup minutes
    #   @api public
    #   @example
    #     stat.matchup_min #=> 12.5
    #   @return [Float, nil] matchup minutes
    attribute :matchup_min, Shale::Type::Float

    # @!attribute [rw] partial_poss
    #   Returns partial possessions
    #   @api public
    #   @example
    #     stat.partial_poss #=> 45.2
    #   @return [Float, nil] partial possessions
    attribute :partial_poss, Shale::Type::Float

    # @!attribute [rw] player_pts
    #   Returns points scored by offensive player
    #   @api public
    #   @example
    #     stat.player_pts #=> 18.0
    #   @return [Float, nil] player points
    attribute :player_pts, Shale::Type::Float

    # @!attribute [rw] team_pts
    #   Returns team points during matchup
    #   @api public
    #   @example
    #     stat.team_pts #=> 22.0
    #   @return [Float, nil] team points
    attribute :team_pts, Shale::Type::Float

    # @!attribute [rw] matchup_ast
    #   Returns assists during matchup
    #   @api public
    #   @example
    #     stat.matchup_ast #=> 3.0
    #   @return [Float, nil] matchup assists
    attribute :matchup_ast, Shale::Type::Float

    # @!attribute [rw] matchup_tov
    #   Returns turnovers during matchup
    #   @api public
    #   @example
    #     stat.matchup_tov #=> 1.0
    #   @return [Float, nil] matchup turnovers
    attribute :matchup_tov, Shale::Type::Float

    # @!attribute [rw] matchup_blk
    #   Returns blocks during matchup
    #   @api public
    #   @example
    #     stat.matchup_blk #=> 0.5
    #   @return [Float, nil] matchup blocks
    attribute :matchup_blk, Shale::Type::Float

    # @!attribute [rw] matchup_fgm
    #   Returns field goals made during matchup
    #   @api public
    #   @example
    #     stat.matchup_fgm #=> 6.0
    #   @return [Float, nil] matchup field goals made
    attribute :matchup_fgm, Shale::Type::Float

    # @!attribute [rw] matchup_fga
    #   Returns field goals attempted during matchup
    #   @api public
    #   @example
    #     stat.matchup_fga #=> 14.0
    #   @return [Float, nil] matchup field goals attempted
    attribute :matchup_fga, Shale::Type::Float

    # @!attribute [rw] matchup_fg_pct
    #   Returns field goal percentage during matchup
    #   @api public
    #   @example
    #     stat.matchup_fg_pct #=> 0.429
    #   @return [Float, nil] matchup field goal percentage
    attribute :matchup_fg_pct, Shale::Type::Float

    # @!attribute [rw] matchup_fg3m
    #   Returns three-pointers made during matchup
    #   @api public
    #   @example
    #     stat.matchup_fg3m #=> 2.0
    #   @return [Float, nil] matchup three-pointers made
    attribute :matchup_fg3m, Shale::Type::Float

    # @!attribute [rw] matchup_fg3a
    #   Returns three-pointers attempted during matchup
    #   @api public
    #   @example
    #     stat.matchup_fg3a #=> 6.0
    #   @return [Float, nil] matchup three-pointers attempted
    attribute :matchup_fg3a, Shale::Type::Float

    # @!attribute [rw] matchup_fg3_pct
    #   Returns three-point percentage during matchup
    #   @api public
    #   @example
    #     stat.matchup_fg3_pct #=> 0.333
    #   @return [Float, nil] matchup three-point percentage
    attribute :matchup_fg3_pct, Shale::Type::Float

    # @!attribute [rw] help_blk
    #   Returns help blocks
    #   @api public
    #   @example
    #     stat.help_blk #=> 0.0
    #   @return [Float, nil] help blocks
    attribute :help_blk, Shale::Type::Float

    # @!attribute [rw] help_fgm
    #   Returns help field goals made
    #   @api public
    #   @example
    #     stat.help_fgm #=> 1.0
    #   @return [Float, nil] help field goals made
    attribute :help_fgm, Shale::Type::Float

    # @!attribute [rw] help_fga
    #   Returns help field goals attempted
    #   @api public
    #   @example
    #     stat.help_fga #=> 2.0
    #   @return [Float, nil] help field goals attempted
    attribute :help_fga, Shale::Type::Float

    # @!attribute [rw] help_fg_pct
    #   Returns help field goal percentage
    #   @api public
    #   @example
    #     stat.help_fg_pct #=> 0.500
    #   @return [Float, nil] help field goal percentage
    attribute :help_fg_pct, Shale::Type::Float

    # @!attribute [rw] matchup_ftm
    #   Returns free throws made during matchup
    #   @api public
    #   @example
    #     stat.matchup_ftm #=> 4.0
    #   @return [Float, nil] matchup free throws made
    attribute :matchup_ftm, Shale::Type::Float

    # @!attribute [rw] matchup_fta
    #   Returns free throws attempted during matchup
    #   @api public
    #   @example
    #     stat.matchup_fta #=> 5.0
    #   @return [Float, nil] matchup free throws attempted
    attribute :matchup_fta, Shale::Type::Float

    # @!attribute [rw] sfl
    #   Returns shooting fouls drawn
    #   @api public
    #   @example
    #     stat.sfl #=> 2.0
    #   @return [Float, nil] shooting fouls
    attribute :sfl, Shale::Type::Float

    # Returns the offensive player
    #
    # @api public
    # @example
    #   stat.off_player #=> #<NBA::Player id=201939 ...>
    # @return [Player, nil] the offensive player object
    def off_player
      Players.find(off_player_id)
    end

    # Returns the defensive player
    #
    # @api public
    # @example
    #   stat.def_player #=> #<NBA::Player id=203507 ...>
    # @return [Player, nil] the defensive player object
    def def_player
      Players.find(def_player_id)
    end
  end
end
