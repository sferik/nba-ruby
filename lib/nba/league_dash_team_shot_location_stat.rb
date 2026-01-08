require "equalizer"
require "shale"
require_relative "teams"

module NBA
  # Represents league-wide team shot location statistics
  #
  # @api public
  class LeagueDashTeamShotLocationStat < Shale::Mapper
    include Equalizer.new(:team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer, nil] the team's ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Golden State Warriors"
    #   @return [String, nil] the team's name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] restricted_area_fgm
    #   Returns restricted area field goals made
    #   @api public
    #   @example
    #     stat.restricted_area_fgm #=> 15.2
    #   @return [Float, nil] restricted area field goals made
    attribute :restricted_area_fgm, Shale::Type::Float

    # @!attribute [rw] restricted_area_fga
    #   Returns restricted area field goals attempted
    #   @api public
    #   @example
    #     stat.restricted_area_fga #=> 24.8
    #   @return [Float, nil] restricted area field goals attempted
    attribute :restricted_area_fga, Shale::Type::Float

    # @!attribute [rw] restricted_area_fg_pct
    #   Returns restricted area field goal percentage
    #   @api public
    #   @example
    #     stat.restricted_area_fg_pct #=> 0.613
    #   @return [Float, nil] restricted area field goal percentage
    attribute :restricted_area_fg_pct, Shale::Type::Float

    # @!attribute [rw] in_the_paint_non_ra_fgm
    #   Returns in the paint (non-RA) field goals made
    #   @api public
    #   @example
    #     stat.in_the_paint_non_ra_fgm #=> 5.8
    #   @return [Float, nil] in the paint field goals made
    attribute :in_the_paint_non_ra_fgm, Shale::Type::Float

    # @!attribute [rw] in_the_paint_non_ra_fga
    #   Returns in the paint (non-RA) field goals attempted
    #   @api public
    #   @example
    #     stat.in_the_paint_non_ra_fga #=> 14.2
    #   @return [Float, nil] in the paint field goals attempted
    attribute :in_the_paint_non_ra_fga, Shale::Type::Float

    # @!attribute [rw] in_the_paint_non_ra_fg_pct
    #   Returns in the paint (non-RA) field goal percentage
    #   @api public
    #   @example
    #     stat.in_the_paint_non_ra_fg_pct #=> 0.408
    #   @return [Float, nil] in the paint field goal percentage
    attribute :in_the_paint_non_ra_fg_pct, Shale::Type::Float

    # @!attribute [rw] mid_range_fgm
    #   Returns mid-range field goals made
    #   @api public
    #   @example
    #     stat.mid_range_fgm #=> 4.5
    #   @return [Float, nil] mid-range field goals made
    attribute :mid_range_fgm, Shale::Type::Float

    # @!attribute [rw] mid_range_fga
    #   Returns mid-range field goals attempted
    #   @api public
    #   @example
    #     stat.mid_range_fga #=> 11.3
    #   @return [Float, nil] mid-range field goals attempted
    attribute :mid_range_fga, Shale::Type::Float

    # @!attribute [rw] mid_range_fg_pct
    #   Returns mid-range field goal percentage
    #   @api public
    #   @example
    #     stat.mid_range_fg_pct #=> 0.398
    #   @return [Float, nil] mid-range field goal percentage
    attribute :mid_range_fg_pct, Shale::Type::Float

    # @!attribute [rw] left_corner_3_fgm
    #   Returns left corner 3 field goals made
    #   @api public
    #   @example
    #     stat.left_corner_3_fgm #=> 1.2
    #   @return [Float, nil] left corner 3 field goals made
    attribute :left_corner_3_fgm, Shale::Type::Float

    # @!attribute [rw] left_corner_3_fga
    #   Returns left corner 3 field goals attempted
    #   @api public
    #   @example
    #     stat.left_corner_3_fga #=> 3.1
    #   @return [Float, nil] left corner 3 field goals attempted
    attribute :left_corner_3_fga, Shale::Type::Float

    # @!attribute [rw] left_corner_3_fg_pct
    #   Returns left corner 3 field goal percentage
    #   @api public
    #   @example
    #     stat.left_corner_3_fg_pct #=> 0.387
    #   @return [Float, nil] left corner 3 field goal percentage
    attribute :left_corner_3_fg_pct, Shale::Type::Float

    # @!attribute [rw] right_corner_3_fgm
    #   Returns right corner 3 field goals made
    #   @api public
    #   @example
    #     stat.right_corner_3_fgm #=> 1.1
    #   @return [Float, nil] right corner 3 field goals made
    attribute :right_corner_3_fgm, Shale::Type::Float

    # @!attribute [rw] right_corner_3_fga
    #   Returns right corner 3 field goals attempted
    #   @api public
    #   @example
    #     stat.right_corner_3_fga #=> 2.8
    #   @return [Float, nil] right corner 3 field goals attempted
    attribute :right_corner_3_fga, Shale::Type::Float

    # @!attribute [rw] right_corner_3_fg_pct
    #   Returns right corner 3 field goal percentage
    #   @api public
    #   @example
    #     stat.right_corner_3_fg_pct #=> 0.393
    #   @return [Float, nil] right corner 3 field goal percentage
    attribute :right_corner_3_fg_pct, Shale::Type::Float

    # @!attribute [rw] above_the_break_3_fgm
    #   Returns above the break 3 field goals made
    #   @api public
    #   @example
    #     stat.above_the_break_3_fgm #=> 9.2
    #   @return [Float, nil] above the break 3 field goals made
    attribute :above_the_break_3_fgm, Shale::Type::Float

    # @!attribute [rw] above_the_break_3_fga
    #   Returns above the break 3 field goals attempted
    #   @api public
    #   @example
    #     stat.above_the_break_3_fga #=> 25.8
    #   @return [Float, nil] above the break 3 field goals attempted
    attribute :above_the_break_3_fga, Shale::Type::Float

    # @!attribute [rw] above_the_break_3_fg_pct
    #   Returns above the break 3 field goal percentage
    #   @api public
    #   @example
    #     stat.above_the_break_3_fg_pct #=> 0.357
    #   @return [Float, nil] above the break 3 field goal percentage
    attribute :above_the_break_3_fg_pct, Shale::Type::Float

    # @!attribute [rw] backcourt_fgm
    #   Returns backcourt field goals made
    #   @api public
    #   @example
    #     stat.backcourt_fgm #=> 0.0
    #   @return [Float, nil] backcourt field goals made
    attribute :backcourt_fgm, Shale::Type::Float

    # @!attribute [rw] backcourt_fga
    #   Returns backcourt field goals attempted
    #   @api public
    #   @example
    #     stat.backcourt_fga #=> 0.2
    #   @return [Float, nil] backcourt field goals attempted
    attribute :backcourt_fga, Shale::Type::Float

    # @!attribute [rw] backcourt_fg_pct
    #   Returns backcourt field goal percentage
    #   @api public
    #   @example
    #     stat.backcourt_fg_pct #=> 0.0
    #   @return [Float, nil] backcourt field goal percentage
    attribute :backcourt_fg_pct, Shale::Type::Float

    # @!attribute [rw] corner_3_fgm
    #   Returns corner 3 field goals made (combined left and right)
    #   @api public
    #   @example
    #     stat.corner_3_fgm #=> 2.3
    #   @return [Float, nil] corner 3 field goals made
    attribute :corner_3_fgm, Shale::Type::Float

    # @!attribute [rw] corner_3_fga
    #   Returns corner 3 field goals attempted (combined left and right)
    #   @api public
    #   @example
    #     stat.corner_3_fga #=> 5.9
    #   @return [Float, nil] corner 3 field goals attempted
    attribute :corner_3_fga, Shale::Type::Float

    # @!attribute [rw] corner_3_fg_pct
    #   Returns corner 3 field goal percentage (combined left and right)
    #   @api public
    #   @example
    #     stat.corner_3_fg_pct #=> 0.390
    #   @return [Float, nil] corner 3 field goal percentage
    attribute :corner_3_fg_pct, Shale::Type::Float

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
