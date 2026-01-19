require "equalizer"
require "shale"

module NBA
  # Represents a single game log entry for a player or team
  #
  # @api public
  class GameLog < Shale::Mapper
    include Equalizer.new(:game_id, :player_id)
    include StatHelpers

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     log.season_id #=> "22024"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     log.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     log.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     log.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     log.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     log.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     log.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_date
    #   Returns the game date
    #   @api public
    #   @example
    #     log.game_date #=> "OCT 22, 2024"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] matchup
    #   Returns the matchup description
    #   @api public
    #   @example
    #     log.matchup #=> "GSW vs. LAL"
    #   @return [String] the matchup
    attribute :matchup, Shale::Type::String

    # @!attribute [rw] wl
    #   Returns the win/loss indicator
    #   @api public
    #   @example
    #     log.wl #=> "W"
    #   @return [String] W for win, L for loss
    attribute :wl, Shale::Type::String

    # @!attribute [rw] min
    #   Returns the minutes played
    #   @api public
    #   @example
    #     log.min #=> 34
    #   @return [Integer] the minutes played
    attribute :min, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns the field goals made
    #   @api public
    #   @example
    #     log.fgm #=> 10
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns the field goals attempted
    #   @api public
    #   @example
    #     log.fga #=> 20
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns the field goal percentage
    #   @api public
    #   @example
    #     log.fg_pct #=> 0.500
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns the three-pointers made
    #   @api public
    #   @example
    #     log.fg3m #=> 5
    #   @return [Integer] three-pointers made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns the three-pointers attempted
    #   @api public
    #   @example
    #     log.fg3a #=> 10
    #   @return [Integer] three-pointers attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns the three-point percentage
    #   @api public
    #   @example
    #     log.fg3_pct #=> 0.500
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns the free throws made
    #   @api public
    #   @example
    #     log.ftm #=> 5
    #   @return [Integer] free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns the free throws attempted
    #   @api public
    #   @example
    #     log.fta #=> 6
    #   @return [Integer] free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns the free throw percentage
    #   @api public
    #   @example
    #     log.ft_pct #=> 0.833
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns the offensive rebounds
    #   @api public
    #   @example
    #     log.oreb #=> 1
    #   @return [Integer] offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns the defensive rebounds
    #   @api public
    #   @example
    #     log.dreb #=> 5
    #   @return [Integer] defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] reb
    #   Returns the total rebounds
    #   @api public
    #   @example
    #     log.reb #=> 6
    #   @return [Integer] total rebounds
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns the assists
    #   @api public
    #   @example
    #     log.ast #=> 8
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns the steals
    #   @api public
    #   @example
    #     log.stl #=> 2
    #   @return [Integer] steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns the blocks
    #   @api public
    #   @example
    #     log.blk #=> 0
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns the turnovers
    #   @api public
    #   @example
    #     log.tov #=> 3
    #   @return [Integer] turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns the personal fouls
    #   @api public
    #   @example
    #     log.pf #=> 2
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns the points scored
    #   @api public
    #   @example
    #     log.pts #=> 30
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] plus_minus
    #   Returns the plus/minus
    #   @api public
    #   @example
    #     log.plus_minus #=> 15
    #   @return [Integer] plus/minus
    attribute :plus_minus, Shale::Type::Integer

    # Returns whether the game was a win
    #
    # @api public
    # @example
    #   log.win? #=> true
    # @return [Boolean] true if the game was a win
    def win? = wl.eql?("W")

    # Returns whether the game was a loss
    #
    # @api public
    # @example
    #   log.loss? #=> false
    # @return [Boolean] true if the game was a loss
    def loss? = wl.eql?("L")

    # Returns the game object for this log entry
    #
    # @api public
    # @example
    #   log.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game = Games.find(game_id)

    # Returns the player object for this log entry
    #
    # @api public
    # @example
    #   log.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player = Players.find(player_id)

    # rubocop:disable Metrics/BlockLength
    json do
      map "season_id", to: :season_id
      map "SEASON_ID", to: :season_id
      map "player_id", to: :player_id
      map "Player_ID", to: :player_id
      map "PLAYER_ID", to: :player_id
      map "player_name", to: :player_name
      map "PLAYER_NAME", to: :player_name
      map "team_id", to: :team_id
      map "TEAM_ID", to: :team_id
      map "team_abbreviation", to: :team_abbreviation
      map "TEAM_ABBREVIATION", to: :team_abbreviation
      map "team_name", to: :team_name
      map "TEAM_NAME", to: :team_name
      map "game_id", to: :game_id
      map "Game_ID", to: :game_id
      map "game_date", to: :game_date
      map "GAME_DATE", to: :game_date
      map "matchup", to: :matchup
      map "MATCHUP", to: :matchup
      map "wl", to: :wl
      map "WL", to: :wl
      map "min", to: :min
      map "MIN", to: :min
      map "fgm", to: :fgm
      map "FGM", to: :fgm
      map "fga", to: :fga
      map "FGA", to: :fga
      map "fg_pct", to: :fg_pct
      map "FG_PCT", to: :fg_pct
      map "fg3m", to: :fg3m
      map "FG3M", to: :fg3m
      map "fg3a", to: :fg3a
      map "FG3A", to: :fg3a
      map "fg3_pct", to: :fg3_pct
      map "FG3_PCT", to: :fg3_pct
      map "ftm", to: :ftm
      map "FTM", to: :ftm
      map "fta", to: :fta
      map "FTA", to: :fta
      map "ft_pct", to: :ft_pct
      map "FT_PCT", to: :ft_pct
      map "oreb", to: :oreb
      map "OREB", to: :oreb
      map "dreb", to: :dreb
      map "DREB", to: :dreb
      map "reb", to: :reb
      map "REB", to: :reb
      map "ast", to: :ast
      map "AST", to: :ast
      map "stl", to: :stl
      map "STL", to: :stl
      map "blk", to: :blk
      map "BLK", to: :blk
      map "tov", to: :tov
      map "TOV", to: :tov
      map "pf", to: :pf
      map "PF", to: :pf
      map "pts", to: :pts
      map "PTS", to: :pts
      map "plus_minus", to: :plus_minus
      map "PLUS_MINUS", to: :plus_minus
    end
    # rubocop:enable Metrics/BlockLength
  end
end
