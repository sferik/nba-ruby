module NBA
  # Represents team dashboard split statistics
  class TeamDashboardStat < Shale::Mapper
    include Equalizer.new(:team_id, :group_value)

    # @!attribute [rw] group_set
    #   Returns the group set name
    #   @api public
    #   @example
    #     stat.group_set #=> "Overall"
    #   @return [String] the group set
    attribute :group_set, Shale::Type::String

    # @!attribute [rw] group_value
    #   Returns the group value
    #   @api public
    #   @example
    #     stat.group_value #=> "2023-24"
    #   @return [String] the group value
    attribute :group_value, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 82
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 46
    #   @return [Integer] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 36
    #   @return [Integer] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.w_pct #=> 0.561
    #   @return [Float] win percentage
    attribute :w_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns minutes per game
    #   @api public
    #   @example
    #     stat.min #=> 240.0
    #   @return [Float] minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made per game
    #   @api public
    #   @example
    #     stat.fgm #=> 39.6
    #   @return [Float] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted per game
    #   @api public
    #   @example
    #     stat.fga #=> 87.8
    #   @return [Float] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.451
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made per game
    #   @api public
    #   @example
    #     stat.fg3m #=> 14.8
    #   @return [Float] three-pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted per game
    #   @api public
    #   @example
    #     stat.fg3a #=> 40.2
    #   @return [Float] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.368
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made per game
    #   @api public
    #   @example
    #     stat.ftm #=> 17.8
    #   @return [Float] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted per game
    #   @api public
    #   @example
    #     stat.fta #=> 22.1
    #   @return [Float] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.805
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds per game
    #   @api public
    #   @example
    #     stat.oreb #=> 9.1
    #   @return [Float] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds per game
    #   @api public
    #   @example
    #     stat.dreb #=> 34.8
    #   @return [Float] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds per game
    #   @api public
    #   @example
    #     stat.reb #=> 43.9
    #   @return [Float] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stat.ast #=> 27.5
    #   @return [Float] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers per game
    #   @api public
    #   @example
    #     stat.tov #=> 14.1
    #   @return [Float] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals per game
    #   @api public
    #   @example
    #     stat.stl #=> 7.6
    #   @return [Float] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks per game
    #   @api public
    #   @example
    #     stat.blk #=> 4.8
    #   @return [Float] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] blka
    #   Returns blocked attempts per game
    #   @api public
    #   @example
    #     stat.blka #=> 4.2
    #   @return [Float] blocked attempts
    attribute :blka, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls per game
    #   @api public
    #   @example
    #     stat.pf #=> 20.1
    #   @return [Float] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pfd
    #   Returns personal fouls drawn per game
    #   @api public
    #   @example
    #     stat.pfd #=> 18.9
    #   @return [Float] personal fouls drawn
    attribute :pfd, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points per game
    #   @api public
    #   @example
    #     stat.pts #=> 111.8
    #   @return [Float] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] plus_minus
    #   Returns plus/minus per game
    #   @api public
    #   @example
    #     stat.plus_minus #=> 2.5
    #   @return [Float] plus/minus
    attribute :plus_minus, Shale::Type::Float

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
