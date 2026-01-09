require "equalizer"
require "shale"

module NBA
  # Represents cumulative total statistics for a player across multiple games
  class CumeStatsPlayerTotal < Shale::Mapper
    include Equalizer.new(:player_id)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     total.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     total.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] jersey_num
    #   Returns the jersey number
    #   @api public
    #   @example
    #     total.jersey_num #=> "30"
    #   @return [String] the jersey number
    attribute :jersey_num, Shale::Type::String

    # @!attribute [rw] season
    #   Returns the season
    #   @api public
    #   @example
    #     total.season #=> "2024-25"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns the games played
    #   @api public
    #   @example
    #     total.gp #=> 5
    #   @return [Integer] the games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] gs
    #   Returns the games started
    #   @api public
    #   @example
    #     total.gs #=> 5
    #   @return [Integer] the games started
    attribute :gs, Shale::Type::Integer

    # @!attribute [rw] actual_minutes
    #   Returns the total minutes played
    #   @api public
    #   @example
    #     total.actual_minutes #=> 175
    #   @return [Integer] the total minutes played
    attribute :actual_minutes, Shale::Type::Integer

    # @!attribute [rw] actual_seconds
    #   Returns the total seconds played
    #   @api public
    #   @example
    #     total.actual_seconds #=> 42
    #   @return [Integer] the total seconds played
    attribute :actual_seconds, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns the total field goals made
    #   @api public
    #   @example
    #     total.fgm #=> 50
    #   @return [Integer] the total field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns the total field goals attempted
    #   @api public
    #   @example
    #     total.fga #=> 100
    #   @return [Integer] the total field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns the field goal percentage
    #   @api public
    #   @example
    #     total.fg_pct #=> 0.500
    #   @return [Float] the field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns the total three-point field goals made
    #   @api public
    #   @example
    #     total.fg3m #=> 15
    #   @return [Integer] the total three-point field goals made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns the total three-point field goals attempted
    #   @api public
    #   @example
    #     total.fg3a #=> 40
    #   @return [Integer] the total three-point field goals attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns the three-point field goal percentage
    #   @api public
    #   @example
    #     total.fg3_pct #=> 0.375
    #   @return [Float] the three-point field goal percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns the total free throws made
    #   @api public
    #   @example
    #     total.ftm #=> 35
    #   @return [Integer] the total free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns the total free throws attempted
    #   @api public
    #   @example
    #     total.fta #=> 40
    #   @return [Integer] the total free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns the free throw percentage
    #   @api public
    #   @example
    #     total.ft_pct #=> 0.875
    #   @return [Float] the free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns the total offensive rebounds
    #   @api public
    #   @example
    #     total.oreb #=> 10
    #   @return [Integer] the total offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns the total defensive rebounds
    #   @api public
    #   @example
    #     total.dreb #=> 30
    #   @return [Integer] the total defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] tot_reb
    #   Returns the total rebounds
    #   @api public
    #   @example
    #     total.tot_reb #=> 40
    #   @return [Integer] the total rebounds
    attribute :tot_reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns the total assists
    #   @api public
    #   @example
    #     total.ast #=> 25
    #   @return [Integer] the total assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns the total personal fouls
    #   @api public
    #   @example
    #     total.pf #=> 15
    #   @return [Integer] the total personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns the total steals
    #   @api public
    #   @example
    #     total.stl #=> 10
    #   @return [Integer] the total steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns the total turnovers
    #   @api public
    #   @example
    #     total.tov #=> 15
    #   @return [Integer] the total turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns the total blocks
    #   @api public
    #   @example
    #     total.blk #=> 5
    #   @return [Integer] the total blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns the total points
    #   @api public
    #   @example
    #     total.pts #=> 150
    #   @return [Integer] the total points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] avg_min
    #   Returns the average minutes per game
    #   @api public
    #   @example
    #     total.avg_min #=> 35.0
    #   @return [Float] the average minutes per game
    attribute :avg_min, Shale::Type::Float

    # @!attribute [rw] avg_sec
    #   Returns the average seconds per game
    #   @api public
    #   @example
    #     total.avg_sec #=> 8.4
    #   @return [Float] the average seconds per game
    attribute :avg_sec, Shale::Type::Float

    # @!attribute [rw] avg_fgm
    #   Returns the average field goals made per game
    #   @api public
    #   @example
    #     total.avg_fgm #=> 10.0
    #   @return [Float] the average field goals made per game
    attribute :avg_fgm, Shale::Type::Float

    # @!attribute [rw] avg_fga
    #   Returns the average field goals attempted per game
    #   @api public
    #   @example
    #     total.avg_fga #=> 20.0
    #   @return [Float] the average field goals attempted per game
    attribute :avg_fga, Shale::Type::Float

    # @!attribute [rw] avg_fg3m
    #   Returns the average three-point field goals made per game
    #   @api public
    #   @example
    #     total.avg_fg3m #=> 3.0
    #   @return [Float] the average three-point field goals made per game
    attribute :avg_fg3m, Shale::Type::Float

    # @!attribute [rw] avg_fg3a
    #   Returns the average three-point field goals attempted per game
    #   @api public
    #   @example
    #     total.avg_fg3a #=> 8.0
    #   @return [Float] the average three-point field goals attempted per game
    attribute :avg_fg3a, Shale::Type::Float

    # @!attribute [rw] avg_ftm
    #   Returns the average free throws made per game
    #   @api public
    #   @example
    #     total.avg_ftm #=> 7.0
    #   @return [Float] the average free throws made per game
    attribute :avg_ftm, Shale::Type::Float

    # @!attribute [rw] avg_fta
    #   Returns the average free throws attempted per game
    #   @api public
    #   @example
    #     total.avg_fta #=> 8.0
    #   @return [Float] the average free throws attempted per game
    attribute :avg_fta, Shale::Type::Float

    # @!attribute [rw] avg_oreb
    #   Returns the average offensive rebounds per game
    #   @api public
    #   @example
    #     total.avg_oreb #=> 2.0
    #   @return [Float] the average offensive rebounds per game
    attribute :avg_oreb, Shale::Type::Float

    # @!attribute [rw] avg_dreb
    #   Returns the average defensive rebounds per game
    #   @api public
    #   @example
    #     total.avg_dreb #=> 6.0
    #   @return [Float] the average defensive rebounds per game
    attribute :avg_dreb, Shale::Type::Float

    # @!attribute [rw] avg_tot_reb
    #   Returns the average total rebounds per game
    #   @api public
    #   @example
    #     total.avg_tot_reb #=> 8.0
    #   @return [Float] the average total rebounds per game
    attribute :avg_tot_reb, Shale::Type::Float

    # @!attribute [rw] avg_ast
    #   Returns the average assists per game
    #   @api public
    #   @example
    #     total.avg_ast #=> 5.0
    #   @return [Float] the average assists per game
    attribute :avg_ast, Shale::Type::Float

    # @!attribute [rw] avg_pf
    #   Returns the average personal fouls per game
    #   @api public
    #   @example
    #     total.avg_pf #=> 3.0
    #   @return [Float] the average personal fouls per game
    attribute :avg_pf, Shale::Type::Float

    # @!attribute [rw] avg_stl
    #   Returns the average steals per game
    #   @api public
    #   @example
    #     total.avg_stl #=> 2.0
    #   @return [Float] the average steals per game
    attribute :avg_stl, Shale::Type::Float

    # @!attribute [rw] avg_tov
    #   Returns the average turnovers per game
    #   @api public
    #   @example
    #     total.avg_tov #=> 3.0
    #   @return [Float] the average turnovers per game
    attribute :avg_tov, Shale::Type::Float

    # @!attribute [rw] avg_blk
    #   Returns the average blocks per game
    #   @api public
    #   @example
    #     total.avg_blk #=> 1.0
    #   @return [Float] the average blocks per game
    attribute :avg_blk, Shale::Type::Float

    # @!attribute [rw] avg_pts
    #   Returns the average points per game
    #   @api public
    #   @example
    #     total.avg_pts #=> 30.0
    #   @return [Float] the average points per game
    attribute :avg_pts, Shale::Type::Float

    # @!attribute [rw] max_min
    #   Returns the maximum minutes in a game
    #   @api public
    #   @example
    #     total.max_min #=> 42
    #   @return [Integer] the maximum minutes in a game
    attribute :max_min, Shale::Type::Integer

    # @!attribute [rw] max_fgm
    #   Returns the maximum field goals made in a game
    #   @api public
    #   @example
    #     total.max_fgm #=> 15
    #   @return [Integer] the maximum field goals made in a game
    attribute :max_fgm, Shale::Type::Integer

    # @!attribute [rw] max_fga
    #   Returns the maximum field goals attempted in a game
    #   @api public
    #   @example
    #     total.max_fga #=> 25
    #   @return [Integer] the maximum field goals attempted in a game
    attribute :max_fga, Shale::Type::Integer

    # @!attribute [rw] max_fg3m
    #   Returns the maximum three-point field goals made in a game
    #   @api public
    #   @example
    #     total.max_fg3m #=> 8
    #   @return [Integer] the maximum three-point field goals made in a game
    attribute :max_fg3m, Shale::Type::Integer

    # @!attribute [rw] max_fg3a
    #   Returns the maximum three-point field goals attempted in a game
    #   @api public
    #   @example
    #     total.max_fg3a #=> 12
    #   @return [Integer] the maximum three-point field goals attempted in a game
    attribute :max_fg3a, Shale::Type::Integer

    # @!attribute [rw] max_ftm
    #   Returns the maximum free throws made in a game
    #   @api public
    #   @example
    #     total.max_ftm #=> 10
    #   @return [Integer] the maximum free throws made in a game
    attribute :max_ftm, Shale::Type::Integer

    # @!attribute [rw] max_fta
    #   Returns the maximum free throws attempted in a game
    #   @api public
    #   @example
    #     total.max_fta #=> 12
    #   @return [Integer] the maximum free throws attempted in a game
    attribute :max_fta, Shale::Type::Integer

    # @!attribute [rw] max_oreb
    #   Returns the maximum offensive rebounds in a game
    #   @api public
    #   @example
    #     total.max_oreb #=> 5
    #   @return [Integer] the maximum offensive rebounds in a game
    attribute :max_oreb, Shale::Type::Integer

    # @!attribute [rw] max_dreb
    #   Returns the maximum defensive rebounds in a game
    #   @api public
    #   @example
    #     total.max_dreb #=> 10
    #   @return [Integer] the maximum defensive rebounds in a game
    attribute :max_dreb, Shale::Type::Integer

    # @!attribute [rw] max_reb
    #   Returns the maximum total rebounds in a game
    #   @api public
    #   @example
    #     total.max_reb #=> 12
    #   @return [Integer] the maximum total rebounds in a game
    attribute :max_reb, Shale::Type::Integer

    # @!attribute [rw] max_ast
    #   Returns the maximum assists in a game
    #   @api public
    #   @example
    #     total.max_ast #=> 10
    #   @return [Integer] the maximum assists in a game
    attribute :max_ast, Shale::Type::Integer

    # @!attribute [rw] max_pf
    #   Returns the maximum personal fouls in a game
    #   @api public
    #   @example
    #     total.max_pf #=> 5
    #   @return [Integer] the maximum personal fouls in a game
    attribute :max_pf, Shale::Type::Integer

    # @!attribute [rw] max_stl
    #   Returns the maximum steals in a game
    #   @api public
    #   @example
    #     total.max_stl #=> 4
    #   @return [Integer] the maximum steals in a game
    attribute :max_stl, Shale::Type::Integer

    # @!attribute [rw] max_tov
    #   Returns the maximum turnovers in a game
    #   @api public
    #   @example
    #     total.max_tov #=> 5
    #   @return [Integer] the maximum turnovers in a game
    attribute :max_tov, Shale::Type::Integer

    # @!attribute [rw] max_blk
    #   Returns the maximum blocks in a game
    #   @api public
    #   @example
    #     total.max_blk #=> 3
    #   @return [Integer] the maximum blocks in a game
    attribute :max_blk, Shale::Type::Integer

    # @!attribute [rw] max_pts
    #   Returns the maximum points in a game
    #   @api public
    #   @example
    #     total.max_pts #=> 45
    #   @return [Integer] the maximum points in a game
    attribute :max_pts, Shale::Type::Integer
  end
end
