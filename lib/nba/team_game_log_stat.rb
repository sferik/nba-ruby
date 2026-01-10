require "equalizer"
require "shale"

module NBA
  # Represents a single team game log entry from the batch endpoint
  #
  # @api public
  class TeamGameLogStat < Shale::Mapper
    include Equalizer.new(:game_id, :team_id)

    # @!attribute [rw] season_year
    #   Returns the season year
    #   @api public
    #   @example
    #     log.season_year #=> "2024-25"
    #   @return [String] the season year
    attribute :season_year, Shale::Type::String

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
    #     log.game_date #=> "2024-10-22T00:00:00"
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
    #     log.min #=> 240
    #   @return [Integer] the minutes played
    attribute :min, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns the field goals made
    #   @api public
    #   @example
    #     log.fgm #=> 42
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns the field goals attempted
    #   @api public
    #   @example
    #     log.fga #=> 88
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns the field goal percentage
    #   @api public
    #   @example
    #     log.fg_pct #=> 0.477
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns the three-pointers made
    #   @api public
    #   @example
    #     log.fg3m #=> 15
    #   @return [Integer] three-pointers made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns the three-pointers attempted
    #   @api public
    #   @example
    #     log.fg3a #=> 38
    #   @return [Integer] three-pointers attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns the three-point percentage
    #   @api public
    #   @example
    #     log.fg3_pct #=> 0.395
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns the free throws made
    #   @api public
    #   @example
    #     log.ftm #=> 19
    #   @return [Integer] free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns the free throws attempted
    #   @api public
    #   @example
    #     log.fta #=> 22
    #   @return [Integer] free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns the free throw percentage
    #   @api public
    #   @example
    #     log.ft_pct #=> 0.864
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns the offensive rebounds
    #   @api public
    #   @example
    #     log.oreb #=> 10
    #   @return [Integer] offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns the defensive rebounds
    #   @api public
    #   @example
    #     log.dreb #=> 35
    #   @return [Integer] defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] reb
    #   Returns the total rebounds
    #   @api public
    #   @example
    #     log.reb #=> 45
    #   @return [Integer] total rebounds
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns the assists
    #   @api public
    #   @example
    #     log.ast #=> 28
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns the steals
    #   @api public
    #   @example
    #     log.stl #=> 9
    #   @return [Integer] steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns the blocks
    #   @api public
    #   @example
    #     log.blk #=> 6
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns the turnovers
    #   @api public
    #   @example
    #     log.tov #=> 14
    #   @return [Integer] turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns the personal fouls
    #   @api public
    #   @example
    #     log.pf #=> 20
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns the points scored
    #   @api public
    #   @example
    #     log.pts #=> 118
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] plus_minus
    #   Returns the plus/minus
    #   @api public
    #   @example
    #     log.plus_minus #=> 9
    #   @return [Integer] plus/minus
    attribute :plus_minus, Shale::Type::Integer

    # Returns whether the game was a win
    #
    # @api public
    # @example
    #   log.win? #=> true
    # @return [Boolean] true if the game was a win
    def win?
      wl.eql?("W")
    end

    # Returns whether the game was a loss
    #
    # @api public
    # @example
    #   log.loss? #=> false
    # @return [Boolean] true if the game was a loss
    def loss?
      wl.eql?("L")
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

    # Returns the team object for this log entry
    #
    # @api public
    # @example
    #   log.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
