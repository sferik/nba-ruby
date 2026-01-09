require "equalizer"
require "shale"

module NBA
  # Represents cumulative team statistics for a player
  class CumeStatsTeamPlayer < Shale::Mapper
    include Equalizer.new(:person_id)

    # @!attribute [rw] person_id
    #   Returns the player person ID
    #   @api public
    #   @example
    #     player.person_id #=> 201939
    #   @return [Integer] the player person ID
    attribute :person_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     player.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] jersey_num
    #   Returns the jersey number
    #   @api public
    #   @example
    #     player.jersey_num #=> "30"
    #   @return [String] the jersey number
    attribute :jersey_num, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     player.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     player.gp #=> 10
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] gs
    #   Returns games started
    #   @api public
    #   @example
    #     player.gs #=> 10
    #   @return [Integer] games started
    attribute :gs, Shale::Type::Integer

    # @!attribute [rw] actual_minutes
    #   Returns total minutes played
    #   @api public
    #   @example
    #     player.actual_minutes #=> 350
    #   @return [Integer] total minutes played
    attribute :actual_minutes, Shale::Type::Integer

    # @!attribute [rw] actual_seconds
    #   Returns total seconds played
    #   @api public
    #   @example
    #     player.actual_seconds #=> 21000
    #   @return [Integer] total seconds played
    attribute :actual_seconds, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     player.fgm #=> 100
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     player.fga #=> 200
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     player.fg_pct #=> 0.500
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three point field goals made
    #   @api public
    #   @example
    #     player.fg3m #=> 40
    #   @return [Integer] three point field goals made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns three point field goals attempted
    #   @api public
    #   @example
    #     player.fg3a #=> 100
    #   @return [Integer] three point field goals attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns three point field goal percentage
    #   @api public
    #   @example
    #     player.fg3_pct #=> 0.400
    #   @return [Float] three point field goal percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     player.ftm #=> 80
    #   @return [Integer] free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     player.fta #=> 90
    #   @return [Integer] free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     player.ft_pct #=> 0.889
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     player.oreb #=> 10
    #   @return [Integer] offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     player.dreb #=> 50
    #   @return [Integer] defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] tot_reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     player.tot_reb #=> 60
    #   @return [Integer] total rebounds
    attribute :tot_reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     player.ast #=> 70
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     player.pf #=> 20
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     player.stl #=> 15
    #   @return [Integer] steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     player.tov #=> 25
    #   @return [Integer] turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     player.blk #=> 5
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     player.pts #=> 280
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] avg_minutes
    #   Returns average minutes per game
    #   @api public
    #   @example
    #     player.avg_minutes #=> 35.0
    #   @return [Float] average minutes per game
    attribute :avg_minutes, Shale::Type::Float

    # @!attribute [rw] fgm_pg
    #   Returns average field goals made per game
    #   @api public
    #   @example
    #     player.fgm_pg #=> 10.0
    #   @return [Float] average field goals made per game
    attribute :fgm_pg, Shale::Type::Float

    # @!attribute [rw] fga_pg
    #   Returns average field goals attempted per game
    #   @api public
    #   @example
    #     player.fga_pg #=> 20.0
    #   @return [Float] average field goals attempted per game
    attribute :fga_pg, Shale::Type::Float

    # @!attribute [rw] fg3m_pg
    #   Returns average three point field goals made per game
    #   @api public
    #   @example
    #     player.fg3m_pg #=> 4.0
    #   @return [Float] average three point field goals made per game
    attribute :fg3m_pg, Shale::Type::Float

    # @!attribute [rw] fg3a_pg
    #   Returns average three point field goals attempted per game
    #   @api public
    #   @example
    #     player.fg3a_pg #=> 10.0
    #   @return [Float] average three point field goals attempted per game
    attribute :fg3a_pg, Shale::Type::Float

    # @!attribute [rw] ftm_pg
    #   Returns average free throws made per game
    #   @api public
    #   @example
    #     player.ftm_pg #=> 8.0
    #   @return [Float] average free throws made per game
    attribute :ftm_pg, Shale::Type::Float

    # @!attribute [rw] fta_pg
    #   Returns average free throws attempted per game
    #   @api public
    #   @example
    #     player.fta_pg #=> 9.0
    #   @return [Float] average free throws attempted per game
    attribute :fta_pg, Shale::Type::Float

    # @!attribute [rw] oreb_pg
    #   Returns average offensive rebounds per game
    #   @api public
    #   @example
    #     player.oreb_pg #=> 1.0
    #   @return [Float] average offensive rebounds per game
    attribute :oreb_pg, Shale::Type::Float

    # @!attribute [rw] dreb_pg
    #   Returns average defensive rebounds per game
    #   @api public
    #   @example
    #     player.dreb_pg #=> 5.0
    #   @return [Float] average defensive rebounds per game
    attribute :dreb_pg, Shale::Type::Float

    # @!attribute [rw] reb_pg
    #   Returns average rebounds per game
    #   @api public
    #   @example
    #     player.reb_pg #=> 6.0
    #   @return [Float] average rebounds per game
    attribute :reb_pg, Shale::Type::Float

    # @!attribute [rw] ast_pg
    #   Returns average assists per game
    #   @api public
    #   @example
    #     player.ast_pg #=> 7.0
    #   @return [Float] average assists per game
    attribute :ast_pg, Shale::Type::Float

    # @!attribute [rw] pf_pg
    #   Returns average personal fouls per game
    #   @api public
    #   @example
    #     player.pf_pg #=> 2.0
    #   @return [Float] average personal fouls per game
    attribute :pf_pg, Shale::Type::Float

    # @!attribute [rw] stl_pg
    #   Returns average steals per game
    #   @api public
    #   @example
    #     player.stl_pg #=> 1.5
    #   @return [Float] average steals per game
    attribute :stl_pg, Shale::Type::Float

    # @!attribute [rw] tov_pg
    #   Returns average turnovers per game
    #   @api public
    #   @example
    #     player.tov_pg #=> 2.5
    #   @return [Float] average turnovers per game
    attribute :tov_pg, Shale::Type::Float

    # @!attribute [rw] blk_pg
    #   Returns average blocks per game
    #   @api public
    #   @example
    #     player.blk_pg #=> 0.5
    #   @return [Float] average blocks per game
    attribute :blk_pg, Shale::Type::Float

    # @!attribute [rw] pts_pg
    #   Returns average points per game
    #   @api public
    #   @example
    #     player.pts_pg #=> 28.0
    #   @return [Float] average points per game
    attribute :pts_pg, Shale::Type::Float

    # @!attribute [rw] fgm_per_min
    #   Returns field goals made per minute
    #   @api public
    #   @example
    #     player.fgm_per_min #=> 0.286
    #   @return [Float] field goals made per minute
    attribute :fgm_per_min, Shale::Type::Float

    # @!attribute [rw] fga_per_min
    #   Returns field goals attempted per minute
    #   @api public
    #   @example
    #     player.fga_per_min #=> 0.571
    #   @return [Float] field goals attempted per minute
    attribute :fga_per_min, Shale::Type::Float

    # @!attribute [rw] fg3m_per_min
    #   Returns three point field goals made per minute
    #   @api public
    #   @example
    #     player.fg3m_per_min #=> 0.114
    #   @return [Float] three point field goals made per minute
    attribute :fg3m_per_min, Shale::Type::Float

    # @!attribute [rw] fg3a_per_min
    #   Returns three point field goals attempted per minute
    #   @api public
    #   @example
    #     player.fg3a_per_min #=> 0.286
    #   @return [Float] three point field goals attempted per minute
    attribute :fg3a_per_min, Shale::Type::Float

    # @!attribute [rw] ftm_per_min
    #   Returns free throws made per minute
    #   @api public
    #   @example
    #     player.ftm_per_min #=> 0.229
    #   @return [Float] free throws made per minute
    attribute :ftm_per_min, Shale::Type::Float

    # @!attribute [rw] fta_per_min
    #   Returns free throws attempted per minute
    #   @api public
    #   @example
    #     player.fta_per_min #=> 0.257
    #   @return [Float] free throws attempted per minute
    attribute :fta_per_min, Shale::Type::Float

    # @!attribute [rw] oreb_per_min
    #   Returns offensive rebounds per minute
    #   @api public
    #   @example
    #     player.oreb_per_min #=> 0.029
    #   @return [Float] offensive rebounds per minute
    attribute :oreb_per_min, Shale::Type::Float

    # @!attribute [rw] dreb_per_min
    #   Returns defensive rebounds per minute
    #   @api public
    #   @example
    #     player.dreb_per_min #=> 0.143
    #   @return [Float] defensive rebounds per minute
    attribute :dreb_per_min, Shale::Type::Float

    # @!attribute [rw] reb_per_min
    #   Returns rebounds per minute
    #   @api public
    #   @example
    #     player.reb_per_min #=> 0.171
    #   @return [Float] rebounds per minute
    attribute :reb_per_min, Shale::Type::Float

    # @!attribute [rw] ast_per_min
    #   Returns assists per minute
    #   @api public
    #   @example
    #     player.ast_per_min #=> 0.200
    #   @return [Float] assists per minute
    attribute :ast_per_min, Shale::Type::Float

    # @!attribute [rw] pf_per_min
    #   Returns personal fouls per minute
    #   @api public
    #   @example
    #     player.pf_per_min #=> 0.057
    #   @return [Float] personal fouls per minute
    attribute :pf_per_min, Shale::Type::Float

    # @!attribute [rw] stl_per_min
    #   Returns steals per minute
    #   @api public
    #   @example
    #     player.stl_per_min #=> 0.043
    #   @return [Float] steals per minute
    attribute :stl_per_min, Shale::Type::Float

    # @!attribute [rw] tov_per_min
    #   Returns turnovers per minute
    #   @api public
    #   @example
    #     player.tov_per_min #=> 0.071
    #   @return [Float] turnovers per minute
    attribute :tov_per_min, Shale::Type::Float

    # @!attribute [rw] blk_per_min
    #   Returns blocks per minute
    #   @api public
    #   @example
    #     player.blk_per_min #=> 0.014
    #   @return [Float] blocks per minute
    attribute :blk_per_min, Shale::Type::Float

    # @!attribute [rw] pts_per_min
    #   Returns points per minute
    #   @api public
    #   @example
    #     player.pts_per_min #=> 0.800
    #   @return [Float] points per minute
    attribute :pts_per_min, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   player.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(person_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   player.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
