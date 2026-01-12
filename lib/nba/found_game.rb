module NBA
  # Represents a found game from the league game finder
  class FoundGame < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     game.season_id #=> "22024"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     game.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     game.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     game.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     game.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_date
    #   Returns the game date
    #   @api public
    #   @example
    #     game.game_date #=> "2024-10-22"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] matchup
    #   Returns the matchup string
    #   @api public
    #   @example
    #     game.matchup #=> "GSW vs. LAL"
    #   @return [String] the matchup
    attribute :matchup, Shale::Type::String

    # @!attribute [rw] wl
    #   Returns win/loss result
    #   @api public
    #   @example
    #     game.wl #=> "W"
    #   @return [String] W or L
    attribute :wl, Shale::Type::String

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     game.min #=> 240
    #   @return [Integer] minutes
    attribute :min, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns points scored
    #   @api public
    #   @example
    #     game.pts #=> 110
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     game.fgm #=> 42
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     game.fga #=> 85
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     game.fg_pct #=> 0.494
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made
    #   @api public
    #   @example
    #     game.fg3m #=> 14
    #   @return [Integer] three-pointers made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted
    #   @api public
    #   @example
    #     game.fg3a #=> 35
    #   @return [Integer] three-pointers attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     game.fg3_pct #=> 0.4
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     game.ftm #=> 12
    #   @return [Integer] free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     game.fta #=> 15
    #   @return [Integer] free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     game.ft_pct #=> 0.8
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     game.oreb #=> 10
    #   @return [Integer] offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     game.dreb #=> 32
    #   @return [Integer] defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     game.reb #=> 42
    #   @return [Integer] total rebounds
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     game.ast #=> 28
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     game.stl #=> 8
    #   @return [Integer] steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     game.blk #=> 5
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     game.tov #=> 12
    #   @return [Integer] turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     game.pf #=> 18
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     game.plus_minus #=> 10
    #   @return [Integer] plus/minus
    attribute :plus_minus, Shale::Type::Integer

    # Returns the team object
    #
    # @api public
    # @example
    #   game.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns whether the game was a win
    #
    # @api public
    # @example
    #   game.win? #=> true
    # @return [Boolean] true if win
    def win?
      wl.eql?("W")
    end

    # Returns whether the game was a loss
    #
    # @api public
    # @example
    #   game.loss? #=> true
    # @return [Boolean] true if loss
    def loss?
      wl.eql?("L")
    end
  end
end
