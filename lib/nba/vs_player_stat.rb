require "equalizer"
require "shale"
require_relative "players"

module NBA
  # Represents player vs player comparison statistics
  #
  # @api public
  class VsPlayerStat < Shale::Mapper
    include Equalizer.new(:player_id, :vs_player_id)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer, nil] the player's ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] vs_player_id
    #   Returns the vs player ID
    #   @api public
    #   @example
    #     stat.vs_player_id #=> 201566
    #   @return [Integer, nil] the vs player's ID
    attribute :vs_player_id, Shale::Type::Integer

    # @!attribute [rw] court_status
    #   Returns the on/off court status
    #   @api public
    #   @example
    #     stat.court_status #=> "On"
    #   @return [String, nil] on/off court status
    attribute :court_status, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 24
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.min #=> 32.5
    #   @return [Float, nil] minutes played
    attribute :min, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     stat.pts #=> 26.4
    #   @return [Float, nil] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns rebounds
    #   @api public
    #   @example
    #     stat.reb #=> 5.7
    #   @return [Float, nil] rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     stat.ast #=> 6.1
    #   @return [Float, nil] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     stat.stl #=> 1.2
    #   @return [Float, nil] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     stat.blk #=> 0.3
    #   @return [Float, nil] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     stat.tov #=> 3.1
    #   @return [Float, nil] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.467
    #   @return [Float, nil] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     stat.plus_minus #=> 8.5
    #   @return [Float, nil] plus/minus
    attribute :plus_minus, Shale::Type::Float

    # Returns the player
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player id=201939 ...>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the vs player
    #
    # @api public
    # @example
    #   stat.vs_player #=> #<NBA::Player id=201566 ...>
    # @return [Player, nil] the vs player object
    def vs_player
      Players.find(vs_player_id)
    end

    # Returns whether the player is on court
    #
    # @api public
    # @example
    #   stat.on_court? #=> true
    # @return [Boolean] true if player is on court
    def on_court?
      court_status.eql?("On")
    end

    # Returns whether the player is off court
    #
    # @api public
    # @example
    #   stat.off_court? #=> true
    # @return [Boolean] true if player is off court
    def off_court?
      court_status.eql?("Off")
    end
  end
end
