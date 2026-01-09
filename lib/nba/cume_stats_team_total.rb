require "equalizer"
require "shale"

module NBA
  # Represents total cumulative team statistics
  class CumeStatsTeamTotal < Shale::Mapper
    include Equalizer.new(:team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     total.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] city
    #   Returns the city name
    #   @api public
    #   @example
    #     total.city #=> "Golden State"
    #   @return [String] the city name
    attribute :city, Shale::Type::String

    # @!attribute [rw] nickname
    #   Returns the team nickname
    #   @api public
    #   @example
    #     total.nickname #=> "Warriors"
    #   @return [String] the team nickname
    attribute :nickname, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     total.gp #=> 10
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] gs
    #   Returns games started
    #   @api public
    #   @example
    #     total.gs #=> 10
    #   @return [Integer] games started
    attribute :gs, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     total.w #=> 8
    #   @return [Integer] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     total.l #=> 2
    #   @return [Integer] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_home
    #   Returns home wins
    #   @api public
    #   @example
    #     total.w_home #=> 5
    #   @return [Integer] home wins
    attribute :w_home, Shale::Type::Integer

    # @!attribute [rw] l_home
    #   Returns home losses
    #   @api public
    #   @example
    #     total.l_home #=> 1
    #   @return [Integer] home losses
    attribute :l_home, Shale::Type::Integer

    # @!attribute [rw] w_road
    #   Returns road wins
    #   @api public
    #   @example
    #     total.w_road #=> 3
    #   @return [Integer] road wins
    attribute :w_road, Shale::Type::Integer

    # @!attribute [rw] l_road
    #   Returns road losses
    #   @api public
    #   @example
    #     total.l_road #=> 1
    #   @return [Integer] road losses
    attribute :l_road, Shale::Type::Integer

    # @!attribute [rw] team_turnovers
    #   Returns team turnovers
    #   @api public
    #   @example
    #     total.team_turnovers #=> 120
    #   @return [Integer] team turnovers
    attribute :team_turnovers, Shale::Type::Integer

    # @!attribute [rw] team_rebounds
    #   Returns team rebounds
    #   @api public
    #   @example
    #     total.team_rebounds #=> 450
    #   @return [Integer] team rebounds
    attribute :team_rebounds, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     total.fgm #=> 400
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     total.fga #=> 850
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     total.fg_pct #=> 0.471
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three point field goals made
    #   @api public
    #   @example
    #     total.fg3m #=> 150
    #   @return [Integer] three point field goals made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns three point field goals attempted
    #   @api public
    #   @example
    #     total.fg3a #=> 400
    #   @return [Integer] three point field goals attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns three point field goal percentage
    #   @api public
    #   @example
    #     total.fg3_pct #=> 0.375
    #   @return [Float] three point field goal percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     total.ftm #=> 180
    #   @return [Integer] free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     total.fta #=> 220
    #   @return [Integer] free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     total.ft_pct #=> 0.818
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     total.oreb #=> 100
    #   @return [Integer] offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     total.dreb #=> 350
    #   @return [Integer] defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] tot_reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     total.tot_reb #=> 450
    #   @return [Integer] total rebounds
    attribute :tot_reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     total.ast #=> 250
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     total.pf #=> 180
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     total.stl #=> 80
    #   @return [Integer] steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     total.tov #=> 120
    #   @return [Integer] turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     total.blk #=> 45
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     total.pts #=> 1130
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # Returns the team object
    #
    # @api public
    # @example
    #   total.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
