require "equalizer"
require "shale"

module NBA
  # Represents FanDuel infographic statistics for a player in a game
  class InfographicFanDuelPlayerStat < Shale::Mapper
    include Equalizer.new(:game_id, :player_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     stat.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

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

    # @!attribute [rw] jersey_num
    #   Returns the jersey number
    #   @api public
    #   @example
    #     stat.jersey_num #=> "30"
    #   @return [String] the jersey number
    attribute :jersey_num, Shale::Type::String

    # @!attribute [rw] player_position
    #   Returns the player position
    #   @api public
    #   @example
    #     stat.player_position #=> "G"
    #   @return [String] the player position
    attribute :player_position, Shale::Type::String

    # @!attribute [rw] location
    #   Returns the location (home/away)
    #   @api public
    #   @example
    #     stat.location #=> "Home"
    #   @return [String] the location
    attribute :location, Shale::Type::String

    # @!attribute [rw] fan_duel_pts
    #   Returns the FanDuel fantasy points
    #   @api public
    #   @example
    #     stat.fan_duel_pts #=> 52.3
    #   @return [Float] FanDuel points
    attribute :fan_duel_pts, Shale::Type::Float

    # @!attribute [rw] nba_fantasy_pts
    #   Returns the NBA fantasy points
    #   @api public
    #   @example
    #     stat.nba_fantasy_pts #=> 48.5
    #   @return [Float] NBA fantasy points
    attribute :nba_fantasy_pts, Shale::Type::Float

    # @!attribute [rw] usg_pct
    #   Returns the usage percentage
    #   @api public
    #   @example
    #     stat.usg_pct #=> 0.312
    #   @return [Float] usage percentage
    attribute :usg_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns the minutes played
    #   @api public
    #   @example
    #     stat.min #=> 34.5
    #   @return [Float] minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns the field goals made
    #   @api public
    #   @example
    #     stat.fgm #=> 10
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns the field goals attempted
    #   @api public
    #   @example
    #     stat.fga #=> 20
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns the field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.500
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns the three-pointers made
    #   @api public
    #   @example
    #     stat.fg3m #=> 5
    #   @return [Integer] three-pointers made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns the three-pointers attempted
    #   @api public
    #   @example
    #     stat.fg3a #=> 11
    #   @return [Integer] three-pointers attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns the three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.455
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns the free throws made
    #   @api public
    #   @example
    #     stat.ftm #=> 5
    #   @return [Integer] free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns the free throws attempted
    #   @api public
    #   @example
    #     stat.fta #=> 6
    #   @return [Integer] free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns the free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.833
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns the offensive rebounds
    #   @api public
    #   @example
    #     stat.oreb #=> 1
    #   @return [Integer] offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns the defensive rebounds
    #   @api public
    #   @example
    #     stat.dreb #=> 5
    #   @return [Integer] defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] reb
    #   Returns the total rebounds
    #   @api public
    #   @example
    #     stat.reb #=> 6
    #   @return [Integer] total rebounds
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns the assists
    #   @api public
    #   @example
    #     stat.ast #=> 8
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns the turnovers
    #   @api public
    #   @example
    #     stat.tov #=> 3
    #   @return [Integer] turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns the steals
    #   @api public
    #   @example
    #     stat.stl #=> 2
    #   @return [Integer] steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns the blocks
    #   @api public
    #   @example
    #     stat.blk #=> 0
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] blka
    #   Returns the blocked attempts
    #   @api public
    #   @example
    #     stat.blka #=> 1
    #   @return [Integer] blocked attempts
    attribute :blka, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns the personal fouls
    #   @api public
    #   @example
    #     stat.pf #=> 2
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] pfd
    #   Returns the personal fouls drawn
    #   @api public
    #   @example
    #     stat.pfd #=> 4
    #   @return [Integer] personal fouls drawn
    attribute :pfd, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns the points scored
    #   @api public
    #   @example
    #     stat.pts #=> 30
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] plus_minus
    #   Returns the plus/minus
    #   @api public
    #   @example
    #     stat.plus_minus #=> 15
    #   @return [Integer] plus/minus
    attribute :plus_minus, Shale::Type::Integer

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

    # Returns the game object
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
