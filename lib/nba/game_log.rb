require "equalizer"
require "shale"

module NBA
  # Represents a single game log entry for a player or team
  class GameLog < Shale::Mapper
    include Equalizer.new(:game_id, :player_id)

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     game_log.season_id #=> "22024"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     game_log.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     game_log.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_date
    #   Returns the game date
    #   @api public
    #   @example
    #     game_log.game_date #=> "OCT 22, 2024"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] matchup
    #   Returns the matchup description
    #   @api public
    #   @example
    #     game_log.matchup #=> "GSW vs. LAL"
    #   @return [String] the matchup
    attribute :matchup, Shale::Type::String

    # @!attribute [rw] wl
    #   Returns the win/loss result
    #   @api public
    #   @example
    #     game_log.wl #=> "W"
    #   @return [String] the win/loss indicator
    attribute :wl, Shale::Type::String

    # @!attribute [rw] min
    #   Returns the minutes played
    #   @api public
    #   @example
    #     game_log.min #=> 36
    #   @return [Integer] the minutes played
    attribute :min, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     game_log.fgm #=> 10
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     game_log.fga #=> 20
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     game_log.fg_pct #=> 0.5
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made
    #   @api public
    #   @example
    #     game_log.fg3m #=> 4
    #   @return [Integer] three-pointers made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted
    #   @api public
    #   @example
    #     game_log.fg3a #=> 10
    #   @return [Integer] three-pointers attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     game_log.fg3_pct #=> 0.4
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     game_log.ftm #=> 5
    #   @return [Integer] free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     game_log.fta #=> 6
    #   @return [Integer] free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     game_log.ft_pct #=> 0.833
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     game_log.oreb #=> 2
    #   @return [Integer] offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     game_log.dreb #=> 5
    #   @return [Integer] defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     game_log.reb #=> 7
    #   @return [Integer] total rebounds
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     game_log.ast #=> 10
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     game_log.stl #=> 2
    #   @return [Integer] steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     game_log.blk #=> 1
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     game_log.tov #=> 3
    #   @return [Integer] turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     game_log.pf #=> 2
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     game_log.pts #=> 30
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     game_log.plus_minus #=> 12
    #   @return [Integer] plus/minus
    attribute :plus_minus, Shale::Type::Integer

    # Returns whether the game was a win
    #
    # @api public
    # @example
    #   game_log.win? #=> true
    # @return [Boolean] whether the game was a win
    def win?
      wl.eql?("W")
    end

    # Returns whether the game was a loss
    #
    # @api public
    # @example
    #   game_log.loss? #=> false
    # @return [Boolean] whether the game was a loss
    def loss?
      wl.eql?("L")
    end

    # Returns the game object for this log entry
    #
    # @api public
    # @example
    #   game_log.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end

    # Returns the player object for this log entry
    #
    # @api public
    # @example
    #   game_log.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # rubocop:disable Metrics/BlockLength
    json do
      map "season_id", to: :season_id
      map "SEASON_ID", to: :season_id
      map "player_id", to: :player_id
      map "Player_ID", to: :player_id
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
