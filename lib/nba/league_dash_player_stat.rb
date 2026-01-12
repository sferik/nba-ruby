module NBA
  # Represents a player's league dashboard statistics
  class LeagueDashPlayerStat < Shale::Mapper
    include Equalizer.new(:player_id, :season_id)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] age
    #   Returns the player's age
    #   @api public
    #   @example
    #     stat.age #=> 36
    #   @return [Integer] the age
    attribute :age, Shale::Type::Integer

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 72
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
    #     stat.l #=> 26
    #   @return [Integer] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.w_pct #=> 0.639
    #   @return [Float] win percentage
    attribute :w_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns minutes per game
    #   @api public
    #   @example
    #     stat.min #=> 34.7
    #   @return [Float] minutes per game
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made per game
    #   @api public
    #   @example
    #     stat.fgm #=> 9.2
    #   @return [Float] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted per game
    #   @api public
    #   @example
    #     stat.fga #=> 19.4
    #   @return [Float] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.474
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made per game
    #   @api public
    #   @example
    #     stat.fg3m #=> 4.8
    #   @return [Float] three-pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted per game
    #   @api public
    #   @example
    #     stat.fg3a #=> 11.7
    #   @return [Float] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.410
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made per game
    #   @api public
    #   @example
    #     stat.ftm #=> 5.1
    #   @return [Float] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted per game
    #   @api public
    #   @example
    #     stat.fta #=> 5.6
    #   @return [Float] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.911
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds per game
    #   @api public
    #   @example
    #     stat.oreb #=> 0.7
    #   @return [Float] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds per game
    #   @api public
    #   @example
    #     stat.dreb #=> 4.9
    #   @return [Float] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds per game
    #   @api public
    #   @example
    #     stat.reb #=> 5.6
    #   @return [Float] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stat.ast #=> 6.3
    #   @return [Float] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers per game
    #   @api public
    #   @example
    #     stat.tov #=> 2.8
    #   @return [Float] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals per game
    #   @api public
    #   @example
    #     stat.stl #=> 1.3
    #   @return [Float] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks per game
    #   @api public
    #   @example
    #     stat.blk #=> 0.4
    #   @return [Float] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] blka
    #   Returns blocked attempts per game
    #   @api public
    #   @example
    #     stat.blka #=> 0.2
    #   @return [Float] blocked attempts
    attribute :blka, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls per game
    #   @api public
    #   @example
    #     stat.pf #=> 1.8
    #   @return [Float] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pfd
    #   Returns personal fouls drawn per game
    #   @api public
    #   @example
    #     stat.pfd #=> 2.7
    #   @return [Float] personal fouls drawn
    attribute :pfd, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points per game
    #   @api public
    #   @example
    #     stat.pts #=> 28.4
    #   @return [Float] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] plus_minus
    #   Returns plus/minus per game
    #   @api public
    #   @example
    #     stat.plus_minus #=> 7.1
    #   @return [Float] plus/minus
    attribute :plus_minus, Shale::Type::Float

    # @!attribute [rw] nba_fantasy_pts
    #   Returns fantasy points per game
    #   @api public
    #   @example
    #     stat.nba_fantasy_pts #=> 52.3
    #   @return [Float] fantasy points
    attribute :nba_fantasy_pts, Shale::Type::Float

    # @!attribute [rw] dd2
    #   Returns double-doubles
    #   @api public
    #   @example
    #     stat.dd2 #=> 15
    #   @return [Integer] double-doubles
    attribute :dd2, Shale::Type::Integer

    # @!attribute [rw] td3
    #   Returns triple-doubles
    #   @api public
    #   @example
    #     stat.td3 #=> 3
    #   @return [Integer] triple-doubles
    attribute :td3, Shale::Type::Integer

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     stat.season_id #=> "2024-25"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

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
