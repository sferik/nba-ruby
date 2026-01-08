require "equalizer"
require "shale"
require_relative "teams"

module NBA
  # Represents a lineup's league dashboard statistics
  #
  # @api public
  class LeagueDashLineupStat < Shale::Mapper
    include Equalizer.new(:group_id, :team_id)

    # @!attribute [rw] group_set
    #   Returns the group set (e.g., "5-man lineups")
    #   @api public
    #   @example
    #     stat.group_set #=> "5 Man Lineups"
    #   @return [String, nil] the group set
    attribute :group_set, Shale::Type::String

    # @!attribute [rw] group_id
    #   Returns the lineup group ID
    #   @api public
    #   @example
    #     stat.group_id #=> "201939-203110-1628369"
    #   @return [String, nil] the group ID
    attribute :group_id, Shale::Type::String

    # @!attribute [rw] group_name
    #   Returns the lineup group name
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

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 45
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 30
    #   @return [Integer, nil] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 15
    #   @return [Integer, nil] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.w_pct #=> 0.667
    #   @return [Float, nil] win percentage
    attribute :w_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.min #=> 245.5
    #   @return [Float, nil] minutes played
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     stat.fgm #=> 8.5
    #   @return [Float, nil] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     stat.fga #=> 17.2
    #   @return [Float, nil] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.494
    #   @return [Float, nil] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made
    #   @api public
    #   @example
    #     stat.fg3m #=> 3.2
    #   @return [Float, nil] three-pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted
    #   @api public
    #   @example
    #     stat.fg3a #=> 8.5
    #   @return [Float, nil] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.376
    #   @return [Float, nil] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     stat.ftm #=> 3.1
    #   @return [Float, nil] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     stat.fta #=> 3.8
    #   @return [Float, nil] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.816
    #   @return [Float, nil] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     stat.oreb #=> 1.8
    #   @return [Float, nil] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     stat.dreb #=> 6.2
    #   @return [Float, nil] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     stat.reb #=> 8.0
    #   @return [Float, nil] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     stat.ast #=> 5.5
    #   @return [Float, nil] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     stat.tov #=> 2.1
    #   @return [Float, nil] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     stat.stl #=> 1.5
    #   @return [Float, nil] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     stat.blk #=> 0.8
    #   @return [Float, nil] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] blka
    #   Returns blocked attempts
    #   @api public
    #   @example
    #     stat.blka #=> 0.5
    #   @return [Float, nil] blocked attempts
    attribute :blka, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     stat.pf #=> 2.3
    #   @return [Float, nil] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pfd
    #   Returns personal fouls drawn
    #   @api public
    #   @example
    #     stat.pfd #=> 3.1
    #   @return [Float, nil] personal fouls drawn
    attribute :pfd, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     stat.pts #=> 23.3
    #   @return [Float, nil] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     stat.plus_minus #=> 8.5
    #   @return [Float, nil] plus/minus
    attribute :plus_minus, Shale::Type::Float

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
