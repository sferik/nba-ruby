require "equalizer"
require "shale"

module NBA
  # Represents league-wide hustle statistics for a team
  class LeagueHustleStatsTeamStat < Shale::Mapper
    include Equalizer.new(:team_id)

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
    #     stat.team_name #=> "Golden State Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] min
    #   Returns total minutes played
    #   @api public
    #   @example
    #     stat.min #=> 19680.0
    #   @return [Float] total minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] contested_shots
    #   Returns contested shots
    #   @api public
    #   @example
    #     stat.contested_shots #=> 2856
    #   @return [Integer] contested shots
    attribute :contested_shots, Shale::Type::Integer

    # @!attribute [rw] contested_shots_2pt
    #   Returns contested 2-point shots
    #   @api public
    #   @example
    #     stat.contested_shots_2pt #=> 1842
    #   @return [Integer] contested 2-point shots
    attribute :contested_shots_2pt, Shale::Type::Integer

    # @!attribute [rw] contested_shots_3pt
    #   Returns contested 3-point shots
    #   @api public
    #   @example
    #     stat.contested_shots_3pt #=> 1014
    #   @return [Integer] contested 3-point shots
    attribute :contested_shots_3pt, Shale::Type::Integer

    # @!attribute [rw] deflections
    #   Returns deflections
    #   @api public
    #   @example
    #     stat.deflections #=> 1024
    #   @return [Integer] deflections
    attribute :deflections, Shale::Type::Integer

    # @!attribute [rw] charges_drawn
    #   Returns charges drawn
    #   @api public
    #   @example
    #     stat.charges_drawn #=> 42
    #   @return [Integer] charges drawn
    attribute :charges_drawn, Shale::Type::Integer

    # @!attribute [rw] screen_assists
    #   Returns screen assists
    #   @api public
    #   @example
    #     stat.screen_assists #=> 1856
    #   @return [Integer] screen assists
    attribute :screen_assists, Shale::Type::Integer

    # @!attribute [rw] screen_ast_pts
    #   Returns points from screen assists
    #   @api public
    #   @example
    #     stat.screen_ast_pts #=> 3712
    #   @return [Integer] screen assist points
    attribute :screen_ast_pts, Shale::Type::Integer

    # @!attribute [rw] off_loose_balls_recovered
    #   Returns offensive loose balls recovered
    #   @api public
    #   @example
    #     stat.off_loose_balls_recovered #=> 312
    #   @return [Integer] offensive loose balls recovered
    attribute :off_loose_balls_recovered, Shale::Type::Integer

    # @!attribute [rw] def_loose_balls_recovered
    #   Returns defensive loose balls recovered
    #   @api public
    #   @example
    #     stat.def_loose_balls_recovered #=> 428
    #   @return [Integer] defensive loose balls recovered
    attribute :def_loose_balls_recovered, Shale::Type::Integer

    # @!attribute [rw] loose_balls_recovered
    #   Returns total loose balls recovered
    #   @api public
    #   @example
    #     stat.loose_balls_recovered #=> 740
    #   @return [Integer] loose balls recovered
    attribute :loose_balls_recovered, Shale::Type::Integer

    # @!attribute [rw] pct_loose_balls_recovered_off
    #   Returns percentage of offensive loose balls recovered
    #   @api public
    #   @example
    #     stat.pct_loose_balls_recovered_off #=> 0.422
    #   @return [Float] percentage of offensive loose balls recovered
    attribute :pct_loose_balls_recovered_off, Shale::Type::Float

    # @!attribute [rw] pct_loose_balls_recovered_def
    #   Returns percentage of defensive loose balls recovered
    #   @api public
    #   @example
    #     stat.pct_loose_balls_recovered_def #=> 0.578
    #   @return [Float] percentage of defensive loose balls recovered
    attribute :pct_loose_balls_recovered_def, Shale::Type::Float

    # @!attribute [rw] off_boxouts
    #   Returns offensive box outs
    #   @api public
    #   @example
    #     stat.off_boxouts #=> 245
    #   @return [Integer] offensive box outs
    attribute :off_boxouts, Shale::Type::Integer

    # @!attribute [rw] def_boxouts
    #   Returns defensive box outs
    #   @api public
    #   @example
    #     stat.def_boxouts #=> 1256
    #   @return [Integer] defensive box outs
    attribute :def_boxouts, Shale::Type::Integer

    # @!attribute [rw] box_outs
    #   Returns total box outs
    #   @api public
    #   @example
    #     stat.box_outs #=> 1501
    #   @return [Integer] total box outs
    attribute :box_outs, Shale::Type::Integer

    # @!attribute [rw] pct_box_outs_off
    #   Returns percentage of offensive box outs
    #   @api public
    #   @example
    #     stat.pct_box_outs_off #=> 0.163
    #   @return [Float] percentage of offensive box outs
    attribute :pct_box_outs_off, Shale::Type::Float

    # @!attribute [rw] pct_box_outs_def
    #   Returns percentage of defensive box outs
    #   @api public
    #   @example
    #     stat.pct_box_outs_def #=> 0.837
    #   @return [Float] percentage of defensive box outs
    attribute :pct_box_outs_def, Shale::Type::Float

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
