module NBA
  # Represents a single team game log entry
  class TeamGameLogEntry < Shale::Mapper
    include Equalizer.new(:game_id, :team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     log.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

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
    #   Returns the win/loss result
    #   @api public
    #   @example
    #     log.wl #=> "W"
    #   @return [String] the win/loss indicator
    attribute :wl, Shale::Type::String

    # @!attribute [rw] min
    #   Returns the minutes played
    #   @api public
    #   @example
    #     log.min #=> 240
    #   @return [Integer] the minutes played
    attribute :min, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     log.fgm #=> 42
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     log.fga #=> 88
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     log.fg_pct #=> 0.477
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made
    #   @api public
    #   @example
    #     log.fg3m #=> 15
    #   @return [Integer] three-pointers made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted
    #   @api public
    #   @example
    #     log.fg3a #=> 40
    #   @return [Integer] three-pointers attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     log.fg3_pct #=> 0.375
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     log.ftm #=> 20
    #   @return [Integer] free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     log.fta #=> 25
    #   @return [Integer] free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     log.ft_pct #=> 0.800
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     log.oreb #=> 10
    #   @return [Integer] offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     log.dreb #=> 35
    #   @return [Integer] defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     log.reb #=> 45
    #   @return [Integer] total rebounds
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     log.ast #=> 28
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     log.stl #=> 8
    #   @return [Integer] steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     log.blk #=> 5
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     log.tov #=> 12
    #   @return [Integer] turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     log.pf #=> 18
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     log.pts #=> 119
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     log.plus_minus #=> 12
    #   @return [Integer] plus/minus
    attribute :plus_minus, Shale::Type::Integer

    # Returns whether the game was a win
    #
    # @api public
    # @example
    #   log.win? #=> true
    # @return [Boolean] whether the game was a win
    def win?
      wl.eql?("W")
    end

    # Returns whether the game was a loss
    #
    # @api public
    # @example
    #   log.loss? #=> false
    # @return [Boolean] whether the game was a loss
    def loss?
      wl.eql?("L")
    end

    # Returns the team object for this game log
    #
    # @api public
    # @example
    #   log.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the game object for this log entry
    #
    # @api public
    # @example
    #   log.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end
  end
end
