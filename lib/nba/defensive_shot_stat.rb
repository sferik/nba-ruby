require "equalizer"
require "shale"
require_relative "players"

module NBA
  # Represents a player's defensive shot statistics
  #
  # @api public
  class DefensiveShotStat < Shale::Mapper
    include Equalizer.new(:close_def_person_id, :defense_category, :g)

    # @!attribute [rw] close_def_person_id
    #   Returns the defender's player ID
    #   @api public
    #   @example
    #     stat.close_def_person_id #=> 201939
    #   @return [Integer, nil] the defender's player ID
    attribute :close_def_person_id, Shale::Type::Integer

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

    # @!attribute [rw] defense_category
    #   Returns the defensive category
    #   @api public
    #   @example
    #     stat.defense_category #=> "3 Pointers"
    #   @return [String, nil] the defensive category
    attribute :defense_category, Shale::Type::String

    # @!attribute [rw] freq
    #   Returns the frequency
    #   @api public
    #   @example
    #     stat.freq #=> 0.25
    #   @return [Float, nil] frequency
    attribute :freq, Shale::Type::Float

    # @!attribute [rw] d_fgm
    #   Returns defended field goals made
    #   @api public
    #   @example
    #     stat.d_fgm #=> 2.1
    #   @return [Float, nil] defended field goals made
    attribute :d_fgm, Shale::Type::Float

    # @!attribute [rw] d_fga
    #   Returns defended field goals attempted
    #   @api public
    #   @example
    #     stat.d_fga #=> 5.3
    #   @return [Float, nil] defended field goals attempted
    attribute :d_fga, Shale::Type::Float

    # @!attribute [rw] d_fg_pct
    #   Returns defended field goal percentage
    #   @api public
    #   @example
    #     stat.d_fg_pct #=> 0.396
    #   @return [Float, nil] defended field goal percentage
    attribute :d_fg_pct, Shale::Type::Float

    # @!attribute [rw] normal_fg_pct
    #   Returns normal field goal percentage
    #   @api public
    #   @example
    #     stat.normal_fg_pct #=> 0.401
    #   @return [Float, nil] normal field goal percentage
    attribute :normal_fg_pct, Shale::Type::Float

    # @!attribute [rw] pct_plusminus
    #   Returns percentage plus/minus
    #   @api public
    #   @example
    #     stat.pct_plusminus #=> -0.005
    #   @return [Float, nil] percentage plus/minus
    attribute :pct_plusminus, Shale::Type::Float

    # Returns the player who defended the shots
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player id=201939 ...>
    # @return [Player, nil] the player object
    def player
      Players.find(close_def_person_id)
    end
  end
end
