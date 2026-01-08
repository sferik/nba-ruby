require "equalizer"
require "shale"
require_relative "teams"

module NBA
  # Represents a lineup visualization statistic
  #
  # @api public
  class LeagueLineupVizStat < Shale::Mapper
    include Equalizer.new(:group_id, :team_id)

    # @!attribute [rw] group_id
    #   Returns the lineup group ID
    #   @api public
    #   @example
    #     stat.group_id #=> "201939-203110-1628369"
    #   @return [String, nil] the group ID
    attribute :group_id, Shale::Type::String

    # @!attribute [rw] group_name
    #   Returns the lineup group name (player names)
    #   @api public
    #   @example
    #     stat.group_name #=> "S. Curry - K. Thompson - A. Wiggins"
    #   @return [String, nil] the group name
    attribute :group_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer, nil] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String, nil] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.min #=> 245.5
    #   @return [Float, nil] minutes played
    attribute :min, Shale::Type::Float

    # @!attribute [rw] off_rating
    #   Returns offensive rating
    #   @api public
    #   @example
    #     stat.off_rating #=> 115.3
    #   @return [Float, nil] offensive rating
    attribute :off_rating, Shale::Type::Float

    # @!attribute [rw] def_rating
    #   Returns defensive rating
    #   @api public
    #   @example
    #     stat.def_rating #=> 108.5
    #   @return [Float, nil] defensive rating
    attribute :def_rating, Shale::Type::Float

    # @!attribute [rw] net_rating
    #   Returns net rating
    #   @api public
    #   @example
    #     stat.net_rating #=> 6.8
    #   @return [Float, nil] net rating
    attribute :net_rating, Shale::Type::Float

    # @!attribute [rw] pace
    #   Returns pace
    #   @api public
    #   @example
    #     stat.pace #=> 101.2
    #   @return [Float, nil] pace
    attribute :pace, Shale::Type::Float

    # @!attribute [rw] ts_pct
    #   Returns true shooting percentage
    #   @api public
    #   @example
    #     stat.ts_pct #=> 0.612
    #   @return [Float, nil] true shooting percentage
    attribute :ts_pct, Shale::Type::Float

    # @!attribute [rw] fta_rate
    #   Returns free throw attempt rate
    #   @api public
    #   @example
    #     stat.fta_rate #=> 0.285
    #   @return [Float, nil] free throw attempt rate
    attribute :fta_rate, Shale::Type::Float

    # @!attribute [rw] tm_ast_pct
    #   Returns team assist percentage
    #   @api public
    #   @example
    #     stat.tm_ast_pct #=> 0.652
    #   @return [Float, nil] team assist percentage
    attribute :tm_ast_pct, Shale::Type::Float

    # @!attribute [rw] pct_fga_2pt
    #   Returns percentage of FGA that are 2-pointers
    #   @api public
    #   @example
    #     stat.pct_fga_2pt #=> 0.545
    #   @return [Float, nil] percentage of FGA that are 2-pointers
    attribute :pct_fga_2pt, Shale::Type::Float

    # @!attribute [rw] pct_fga_3pt
    #   Returns percentage of FGA that are 3-pointers
    #   @api public
    #   @example
    #     stat.pct_fga_3pt #=> 0.455
    #   @return [Float, nil] percentage of FGA that are 3-pointers
    attribute :pct_fga_3pt, Shale::Type::Float

    # @!attribute [rw] pct_pts_2pt_mr
    #   Returns percentage of points from mid-range 2s
    #   @api public
    #   @example
    #     stat.pct_pts_2pt_mr #=> 0.125
    #   @return [Float, nil] percentage of points from mid-range 2s
    attribute :pct_pts_2pt_mr, Shale::Type::Float

    # @!attribute [rw] pct_pts_fb
    #   Returns percentage of points from fast breaks
    #   @api public
    #   @example
    #     stat.pct_pts_fb #=> 0.152
    #   @return [Float, nil] percentage of points from fast breaks
    attribute :pct_pts_fb, Shale::Type::Float

    # @!attribute [rw] pct_pts_ft
    #   Returns percentage of points from free throws
    #   @api public
    #   @example
    #     stat.pct_pts_ft #=> 0.185
    #   @return [Float, nil] percentage of points from free throws
    attribute :pct_pts_ft, Shale::Type::Float

    # @!attribute [rw] pct_pts_paint
    #   Returns percentage of points in paint
    #   @api public
    #   @example
    #     stat.pct_pts_paint #=> 0.425
    #   @return [Float, nil] percentage of points in paint
    attribute :pct_pts_paint, Shale::Type::Float

    # @!attribute [rw] pct_ast_fgm
    #   Returns percentage of FGM that were assisted
    #   @api public
    #   @example
    #     stat.pct_ast_fgm #=> 0.652
    #   @return [Float, nil] percentage of FGM that were assisted
    attribute :pct_ast_fgm, Shale::Type::Float

    # @!attribute [rw] pct_uast_fgm
    #   Returns percentage of FGM that were unassisted
    #   @api public
    #   @example
    #     stat.pct_uast_fgm #=> 0.348
    #   @return [Float, nil] percentage of FGM that were unassisted
    attribute :pct_uast_fgm, Shale::Type::Float

    # @!attribute [rw] opp_fg3_pct
    #   Returns opponent 3-point percentage
    #   @api public
    #   @example
    #     stat.opp_fg3_pct #=> 0.352
    #   @return [Float, nil] opponent 3-point percentage
    attribute :opp_fg3_pct, Shale::Type::Float

    # @!attribute [rw] opp_efg_pct
    #   Returns opponent effective FG percentage
    #   @api public
    #   @example
    #     stat.opp_efg_pct #=> 0.512
    #   @return [Float, nil] opponent effective FG percentage
    attribute :opp_efg_pct, Shale::Type::Float

    # @!attribute [rw] opp_fta_rate
    #   Returns opponent FTA rate
    #   @api public
    #   @example
    #     stat.opp_fta_rate #=> 0.275
    #   @return [Float, nil] opponent FTA rate
    attribute :opp_fta_rate, Shale::Type::Float

    # @!attribute [rw] opp_tov_pct
    #   Returns opponent turnover percentage
    #   @api public
    #   @example
    #     stat.opp_tov_pct #=> 0.132
    #   @return [Float, nil] opponent turnover percentage
    attribute :opp_tov_pct, Shale::Type::Float

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
