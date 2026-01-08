require "equalizer"
require "shale"

module NBA
  # Represents overall team on/off court statistics
  #
  # @api public
  class TeamOnOffOverallStat < Shale::Mapper
    include Equalizer.new(:team_id, :group_value)

    # @!attribute [rw] group_set
    #   Returns the group set name
    #   @api public
    #   @example
    #     stat.group_set #=> "Overall"
    #   @return [String, nil] the group set
    attribute :group_set, Shale::Type::String

    # @!attribute [rw] group_value
    #   Returns the group value
    #   @api public
    #   @example
    #     stat.group_value #=> "On Court"
    #   @return [String, nil] the group value
    attribute :group_value, Shale::Type::String

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

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Warriors"
    #   @return [String, nil] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 82
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 46
    #   @return [Integer, nil] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 36
    #   @return [Integer, nil] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.w_pct #=> 0.561
    #   @return [Float, nil] win percentage
    attribute :w_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns minutes
    #   @api public
    #   @example
    #     stat.min #=> 240.0
    #   @return [Float, nil] minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     stat.fgm #=> 39.6
    #   @return [Float, nil] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     stat.fga #=> 87.8
    #   @return [Float, nil] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.451
    #   @return [Float, nil] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made
    #   @api public
    #   @example
    #     stat.fg3m #=> 14.8
    #   @return [Float, nil] three-pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted
    #   @api public
    #   @example
    #     stat.fg3a #=> 40.2
    #   @return [Float, nil] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.368
    #   @return [Float, nil] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     stat.ftm #=> 17.8
    #   @return [Float, nil] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     stat.fta #=> 22.1
    #   @return [Float, nil] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.805
    #   @return [Float, nil] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     stat.oreb #=> 9.1
    #   @return [Float, nil] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     stat.dreb #=> 34.8
    #   @return [Float, nil] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     stat.reb #=> 43.9
    #   @return [Float, nil] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     stat.ast #=> 27.5
    #   @return [Float, nil] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     stat.tov #=> 14.1
    #   @return [Float, nil] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     stat.stl #=> 7.6
    #   @return [Float, nil] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     stat.blk #=> 4.8
    #   @return [Float, nil] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] blka
    #   Returns blocked attempts
    #   @api public
    #   @example
    #     stat.blka #=> 4.2
    #   @return [Float, nil] blocked attempts
    attribute :blka, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     stat.pf #=> 20.1
    #   @return [Float, nil] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pfd
    #   Returns personal fouls drawn
    #   @api public
    #   @example
    #     stat.pfd #=> 18.9
    #   @return [Float, nil] personal fouls drawn
    attribute :pfd, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     stat.pts #=> 111.8
    #   @return [Float, nil] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     stat.plus_minus #=> 2.5
    #   @return [Float, nil] plus/minus
    attribute :plus_minus, Shale::Type::Float

    # @!attribute [rw] gp_rank
    #   Returns games played rank
    #   @api public
    #   @example
    #     stat.gp_rank #=> 1
    #   @return [Integer, nil] games played rank
    attribute :gp_rank, Shale::Type::Integer

    # @!attribute [rw] w_rank
    #   Returns wins rank
    #   @api public
    #   @example
    #     stat.w_rank #=> 5
    #   @return [Integer, nil] wins rank
    attribute :w_rank, Shale::Type::Integer

    # @!attribute [rw] l_rank
    #   Returns losses rank
    #   @api public
    #   @example
    #     stat.l_rank #=> 8
    #   @return [Integer, nil] losses rank
    attribute :l_rank, Shale::Type::Integer

    # @!attribute [rw] w_pct_rank
    #   Returns win percentage rank
    #   @api public
    #   @example
    #     stat.w_pct_rank #=> 6
    #   @return [Integer, nil] win percentage rank
    attribute :w_pct_rank, Shale::Type::Integer

    # @!attribute [rw] min_rank
    #   Returns minutes rank
    #   @api public
    #   @example
    #     stat.min_rank #=> 15
    #   @return [Integer, nil] minutes rank
    attribute :min_rank, Shale::Type::Integer

    # @!attribute [rw] fgm_rank
    #   Returns field goals made rank
    #   @api public
    #   @example
    #     stat.fgm_rank #=> 10
    #   @return [Integer, nil] field goals made rank
    attribute :fgm_rank, Shale::Type::Integer

    # @!attribute [rw] fga_rank
    #   Returns field goals attempted rank
    #   @api public
    #   @example
    #     stat.fga_rank #=> 12
    #   @return [Integer, nil] field goals attempted rank
    attribute :fga_rank, Shale::Type::Integer

    # @!attribute [rw] fg_pct_rank
    #   Returns field goal percentage rank
    #   @api public
    #   @example
    #     stat.fg_pct_rank #=> 8
    #   @return [Integer, nil] field goal percentage rank
    attribute :fg_pct_rank, Shale::Type::Integer

    # @!attribute [rw] fg3m_rank
    #   Returns three-pointers made rank
    #   @api public
    #   @example
    #     stat.fg3m_rank #=> 3
    #   @return [Integer, nil] three-pointers made rank
    attribute :fg3m_rank, Shale::Type::Integer

    # @!attribute [rw] fg3a_rank
    #   Returns three-pointers attempted rank
    #   @api public
    #   @example
    #     stat.fg3a_rank #=> 5
    #   @return [Integer, nil] three-pointers attempted rank
    attribute :fg3a_rank, Shale::Type::Integer

    # @!attribute [rw] fg3_pct_rank
    #   Returns three-point percentage rank
    #   @api public
    #   @example
    #     stat.fg3_pct_rank #=> 7
    #   @return [Integer, nil] three-point percentage rank
    attribute :fg3_pct_rank, Shale::Type::Integer

    # @!attribute [rw] ftm_rank
    #   Returns free throws made rank
    #   @api public
    #   @example
    #     stat.ftm_rank #=> 14
    #   @return [Integer, nil] free throws made rank
    attribute :ftm_rank, Shale::Type::Integer

    # @!attribute [rw] fta_rank
    #   Returns free throws attempted rank
    #   @api public
    #   @example
    #     stat.fta_rank #=> 16
    #   @return [Integer, nil] free throws attempted rank
    attribute :fta_rank, Shale::Type::Integer

    # @!attribute [rw] ft_pct_rank
    #   Returns free throw percentage rank
    #   @api public
    #   @example
    #     stat.ft_pct_rank #=> 9
    #   @return [Integer, nil] free throw percentage rank
    attribute :ft_pct_rank, Shale::Type::Integer

    # @!attribute [rw] oreb_rank
    #   Returns offensive rebounds rank
    #   @api public
    #   @example
    #     stat.oreb_rank #=> 20
    #   @return [Integer, nil] offensive rebounds rank
    attribute :oreb_rank, Shale::Type::Integer

    # @!attribute [rw] dreb_rank
    #   Returns defensive rebounds rank
    #   @api public
    #   @example
    #     stat.dreb_rank #=> 11
    #   @return [Integer, nil] defensive rebounds rank
    attribute :dreb_rank, Shale::Type::Integer

    # @!attribute [rw] reb_rank
    #   Returns total rebounds rank
    #   @api public
    #   @example
    #     stat.reb_rank #=> 13
    #   @return [Integer, nil] total rebounds rank
    attribute :reb_rank, Shale::Type::Integer

    # @!attribute [rw] ast_rank
    #   Returns assists rank
    #   @api public
    #   @example
    #     stat.ast_rank #=> 4
    #   @return [Integer, nil] assists rank
    attribute :ast_rank, Shale::Type::Integer

    # @!attribute [rw] tov_rank
    #   Returns turnovers rank
    #   @api public
    #   @example
    #     stat.tov_rank #=> 18
    #   @return [Integer, nil] turnovers rank
    attribute :tov_rank, Shale::Type::Integer

    # @!attribute [rw] stl_rank
    #   Returns steals rank
    #   @api public
    #   @example
    #     stat.stl_rank #=> 7
    #   @return [Integer, nil] steals rank
    attribute :stl_rank, Shale::Type::Integer

    # @!attribute [rw] blk_rank
    #   Returns blocks rank
    #   @api public
    #   @example
    #     stat.blk_rank #=> 19
    #   @return [Integer, nil] blocks rank
    attribute :blk_rank, Shale::Type::Integer

    # @!attribute [rw] blka_rank
    #   Returns blocked attempts rank
    #   @api public
    #   @example
    #     stat.blka_rank #=> 22
    #   @return [Integer, nil] blocked attempts rank
    attribute :blka_rank, Shale::Type::Integer

    # @!attribute [rw] pf_rank
    #   Returns personal fouls rank
    #   @api public
    #   @example
    #     stat.pf_rank #=> 25
    #   @return [Integer, nil] personal fouls rank
    attribute :pf_rank, Shale::Type::Integer

    # @!attribute [rw] pfd_rank
    #   Returns personal fouls drawn rank
    #   @api public
    #   @example
    #     stat.pfd_rank #=> 17
    #   @return [Integer, nil] personal fouls drawn rank
    attribute :pfd_rank, Shale::Type::Integer

    # @!attribute [rw] pts_rank
    #   Returns points rank
    #   @api public
    #   @example
    #     stat.pts_rank #=> 2
    #   @return [Integer, nil] points rank
    attribute :pts_rank, Shale::Type::Integer

    # @!attribute [rw] plus_minus_rank
    #   Returns plus/minus rank
    #   @api public
    #   @example
    #     stat.plus_minus_rank #=> 6
    #   @return [Integer, nil] plus/minus rank
    attribute :plus_minus_rank, Shale::Type::Integer

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
