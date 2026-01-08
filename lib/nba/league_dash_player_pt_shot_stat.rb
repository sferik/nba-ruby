require "equalizer"
require "shale"
require_relative "players"
require_relative "teams"

module NBA
  # Represents league-wide player tracking shot statistics
  #
  # @api public
  class LeagueDashPlayerPtShotStat < Shale::Mapper
    include Equalizer.new(:player_id, :g)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer, nil] the player's ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.player_name #=> "Stephen Curry"
    #   @return [String, nil] the player's name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] player_last_team_id
    #   Returns the player's last team ID
    #   @api public
    #   @example
    #     stat.player_last_team_id #=> 1610612744
    #   @return [Integer, nil] the team's ID
    attribute :player_last_team_id, Shale::Type::Integer

    # @!attribute [rw] player_last_team_abbreviation
    #   Returns the player's last team abbreviation
    #   @api public
    #   @example
    #     stat.player_last_team_abbreviation #=> "GSW"
    #   @return [String, nil] the team's abbreviation
    attribute :player_last_team_abbreviation, Shale::Type::String

    # @!attribute [rw] age
    #   Returns the player's age
    #   @api public
    #   @example
    #     stat.age #=> 36
    #   @return [Float, nil] the player's age
    attribute :age, Shale::Type::Float

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 74
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] g
    #   Returns number of games
    #   @api public
    #   @example
    #     stat.g #=> 74
    #   @return [Integer, nil] games
    attribute :g, Shale::Type::Integer

    # @!attribute [rw] fga_frequency
    #   Returns field goal attempt frequency
    #   @api public
    #   @example
    #     stat.fga_frequency #=> 0.35
    #   @return [Float, nil] field goal attempt frequency
    attribute :fga_frequency, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     stat.fgm #=> 7.2
    #   @return [Float, nil] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     stat.fga #=> 15.3
    #   @return [Float, nil] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.472
    #   @return [Float, nil] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] efg_pct
    #   Returns effective field goal percentage
    #   @api public
    #   @example
    #     stat.efg_pct #=> 0.561
    #   @return [Float, nil] effective field goal percentage
    attribute :efg_pct, Shale::Type::Float

    # @!attribute [rw] fg2a_frequency
    #   Returns 2-point field goal attempt frequency
    #   @api public
    #   @example
    #     stat.fg2a_frequency #=> 0.45
    #   @return [Float, nil] 2-point field goal attempt frequency
    attribute :fg2a_frequency, Shale::Type::Float

    # @!attribute [rw] fg2m
    #   Returns 2-point field goals made
    #   @api public
    #   @example
    #     stat.fg2m #=> 4.1
    #   @return [Float, nil] 2-point field goals made
    attribute :fg2m, Shale::Type::Float

    # @!attribute [rw] fg2a
    #   Returns 2-point field goals attempted
    #   @api public
    #   @example
    #     stat.fg2a #=> 7.8
    #   @return [Float, nil] 2-point field goals attempted
    attribute :fg2a, Shale::Type::Float

    # @!attribute [rw] fg2_pct
    #   Returns 2-point field goal percentage
    #   @api public
    #   @example
    #     stat.fg2_pct #=> 0.526
    #   @return [Float, nil] 2-point field goal percentage
    attribute :fg2_pct, Shale::Type::Float

    # @!attribute [rw] fg3a_frequency
    #   Returns 3-point field goal attempt frequency
    #   @api public
    #   @example
    #     stat.fg3a_frequency #=> 0.55
    #   @return [Float, nil] 3-point field goal attempt frequency
    attribute :fg3a_frequency, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns 3-point field goals made
    #   @api public
    #   @example
    #     stat.fg3m #=> 4.8
    #   @return [Float, nil] 3-point field goals made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns 3-point field goals attempted
    #   @api public
    #   @example
    #     stat.fg3a #=> 11.2
    #   @return [Float, nil] 3-point field goals attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns 3-point field goal percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.428
    #   @return [Float, nil] 3-point field goal percentage
    attribute :fg3_pct, Shale::Type::Float

    # Returns the player
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player id=201939 ...>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the player's team
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team id=1610612744 ...>
    # @return [Team, nil] the team object
    def team
      Teams.find(player_last_team_id)
    end
  end
end
