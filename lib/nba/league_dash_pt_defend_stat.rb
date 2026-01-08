require "equalizer"
require "shale"
require_relative "players"
require_relative "teams"

module NBA
  # Represents league-wide player defensive statistics
  #
  # @api public
  class LeagueDashPtDefendStat < Shale::Mapper
    include Equalizer.new(:player_id, :team_id)

    # @!attribute [rw] player_id
    #   Returns the player ID (close defender)
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

    # @!attribute [rw] team_id
    #   Returns the player's last team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer, nil] the team's ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the player's last team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String, nil] the team's abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] player_position
    #   Returns the player's position
    #   @api public
    #   @example
    #     stat.player_position #=> "G"
    #   @return [String, nil] the player's position
    attribute :player_position, Shale::Type::String

    # @!attribute [rw] age
    #   Returns the player's age
    #   @api public
    #   @example
    #     stat.age #=> 36.0
    #   @return [Float, nil] the player's age
    attribute :age, Shale::Type::Float

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 82
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] g
    #   Returns games (alias for games played)
    #   @api public
    #   @example
    #     stat.g #=> 82
    #   @return [Integer, nil] games
    attribute :g, Shale::Type::Integer

    # @!attribute [rw] freq
    #   Returns frequency percentage
    #   @api public
    #   @example
    #     stat.freq #=> 0.089
    #   @return [Float, nil] frequency percentage
    attribute :freq, Shale::Type::Float

    # @!attribute [rw] d_fgm
    #   Returns defended field goals made
    #   @api public
    #   @example
    #     stat.d_fgm #=> 245
    #   @return [Float, nil] defended field goals made
    attribute :d_fgm, Shale::Type::Float

    # @!attribute [rw] d_fga
    #   Returns defended field goals attempted
    #   @api public
    #   @example
    #     stat.d_fga #=> 612
    #   @return [Float, nil] defended field goals attempted
    attribute :d_fga, Shale::Type::Float

    # @!attribute [rw] d_fg_pct
    #   Returns defended field goal percentage
    #   @api public
    #   @example
    #     stat.d_fg_pct #=> 0.400
    #   @return [Float, nil] defended field goal percentage
    attribute :d_fg_pct, Shale::Type::Float

    # @!attribute [rw] normal_fg_pct
    #   Returns normal (uncontested) field goal percentage
    #   @api public
    #   @example
    #     stat.normal_fg_pct #=> 0.450
    #   @return [Float, nil] normal field goal percentage
    attribute :normal_fg_pct, Shale::Type::Float

    # @!attribute [rw] pct_plusminus
    #   Returns percentage plus/minus (difference from normal)
    #   @api public
    #   @example
    #     stat.pct_plusminus #=> -0.050
    #   @return [Float, nil] percentage plus/minus
    attribute :pct_plusminus, Shale::Type::Float

    # Returns the player
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player id=201939 ...>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team id=1610612744 ...>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
