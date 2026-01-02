require "shale"
require "equalizer"

module NBA
  # Represents a team's scoring box score statistics for a game
  class BoxScoreScoringTeamStat < Shale::Mapper
    include Equalizer.new(:game_id, :team_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     stat.game_id #=> "0022400565"
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
    #   Returns total minutes played
    #   @api public
    #   @example
    #     stat.min #=> "240:00"
    #   @return [String] the minutes
    attribute :min, Shale::Type::String

    # @!attribute [rw] pct_fga_2pt
    #   Returns percentage of field goals from 2-point range
    #   @api public
    #   @example
    #     stat.pct_fga_2pt #=> 0.52
    #   @return [Float] the percentage
    attribute :pct_fga_2pt, Shale::Type::Float

    # @!attribute [rw] pct_fga_3pt
    #   Returns percentage of field goals from 3-point range
    #   @api public
    #   @example
    #     stat.pct_fga_3pt #=> 0.48
    #   @return [Float] the percentage
    attribute :pct_fga_3pt, Shale::Type::Float

    # @!attribute [rw] pct_pts_2pt
    #   Returns percentage of points from 2-point shots
    #   @api public
    #   @example
    #     stat.pct_pts_2pt #=> 0.42
    #   @return [Float] the percentage
    attribute :pct_pts_2pt, Shale::Type::Float

    # @!attribute [rw] pct_pts_2pt_mr
    #   Returns percentage of points from mid-range 2-point shots
    #   @api public
    #   @example
    #     stat.pct_pts_2pt_mr #=> 0.18
    #   @return [Float] the percentage
    attribute :pct_pts_2pt_mr, Shale::Type::Float

    # @!attribute [rw] pct_pts_3pt
    #   Returns percentage of points from 3-point shots
    #   @api public
    #   @example
    #     stat.pct_pts_3pt #=> 0.45
    #   @return [Float] the percentage
    attribute :pct_pts_3pt, Shale::Type::Float

    # @!attribute [rw] pct_pts_fb
    #   Returns percentage of points from fast break
    #   @api public
    #   @example
    #     stat.pct_pts_fb #=> 0.15
    #   @return [Float] the percentage
    attribute :pct_pts_fb, Shale::Type::Float

    # @!attribute [rw] pct_pts_ft
    #   Returns percentage of points from free throws
    #   @api public
    #   @example
    #     stat.pct_pts_ft #=> 0.13
    #   @return [Float] the percentage
    attribute :pct_pts_ft, Shale::Type::Float

    # @!attribute [rw] pct_pts_off_tov
    #   Returns percentage of points off turnovers
    #   @api public
    #   @example
    #     stat.pct_pts_off_tov #=> 0.16
    #   @return [Float] the percentage
    attribute :pct_pts_off_tov, Shale::Type::Float

    # @!attribute [rw] pct_pts_paint
    #   Returns percentage of points in the paint
    #   @api public
    #   @example
    #     stat.pct_pts_paint #=> 0.38
    #   @return [Float] the percentage
    attribute :pct_pts_paint, Shale::Type::Float

    # @!attribute [rw] pct_ast_2pm
    #   Returns percentage of 2-point makes that were assisted
    #   @api public
    #   @example
    #     stat.pct_ast_2pm #=> 0.70
    #   @return [Float] the percentage
    attribute :pct_ast_2pm, Shale::Type::Float

    # @!attribute [rw] pct_uast_2pm
    #   Returns percentage of 2-point makes that were unassisted
    #   @api public
    #   @example
    #     stat.pct_uast_2pm #=> 0.30
    #   @return [Float] the percentage
    attribute :pct_uast_2pm, Shale::Type::Float

    # @!attribute [rw] pct_ast_3pm
    #   Returns percentage of 3-point makes that were assisted
    #   @api public
    #   @example
    #     stat.pct_ast_3pm #=> 0.88
    #   @return [Float] the percentage
    attribute :pct_ast_3pm, Shale::Type::Float

    # @!attribute [rw] pct_uast_3pm
    #   Returns percentage of 3-point makes that were unassisted
    #   @api public
    #   @example
    #     stat.pct_uast_3pm #=> 0.12
    #   @return [Float] the percentage
    attribute :pct_uast_3pm, Shale::Type::Float

    # @!attribute [rw] pct_ast_fgm
    #   Returns percentage of field goal makes that were assisted
    #   @api public
    #   @example
    #     stat.pct_ast_fgm #=> 0.78
    #   @return [Float] the percentage
    attribute :pct_ast_fgm, Shale::Type::Float

    # @!attribute [rw] pct_uast_fgm
    #   Returns percentage of field goal makes that were unassisted
    #   @api public
    #   @example
    #     stat.pct_uast_fgm #=> 0.22
    #   @return [Float] the percentage
    attribute :pct_uast_fgm, Shale::Type::Float

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the game object for this box score
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
