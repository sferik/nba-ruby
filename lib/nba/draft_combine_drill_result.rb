require "equalizer"
require "shale"

module NBA
  # Represents a draft combine drill result
  class DraftCombineDrillResult < Shale::Mapper
    include Equalizer.new(:player_id)

    # @!attribute [rw] temp_player_id
    #   Returns the temporary player ID
    #   @api public
    #   @example
    #     result.temp_player_id #=> 1630162
    #   @return [Integer] the temporary player ID
    attribute :temp_player_id, Shale::Type::Integer

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     result.player_id #=> 1630162
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     result.first_name #=> "Victor"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     result.last_name #=> "Wembanyama"
    #   @return [String] the last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     result.player_name #=> "Victor Wembanyama"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     result.position #=> "C"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] standing_vertical_leap
    #   Returns the standing vertical leap measurement in inches
    #   @api public
    #   @example
    #     result.standing_vertical_leap #=> 30.5
    #   @return [Float] standing vertical leap in inches
    attribute :standing_vertical_leap, Shale::Type::Float

    # @!attribute [rw] max_vertical_leap
    #   Returns the maximum vertical leap measurement in inches
    #   @api public
    #   @example
    #     result.max_vertical_leap #=> 37.0
    #   @return [Float] maximum vertical leap in inches
    attribute :max_vertical_leap, Shale::Type::Float

    # @!attribute [rw] lane_agility_time
    #   Returns the lane agility drill time in seconds
    #   @api public
    #   @example
    #     result.lane_agility_time #=> 10.5
    #   @return [Float] lane agility time in seconds
    attribute :lane_agility_time, Shale::Type::Float

    # @!attribute [rw] modified_lane_agility_time
    #   Returns the modified lane agility drill time in seconds
    #   @api public
    #   @example
    #     result.modified_lane_agility_time #=> 10.2
    #   @return [Float] modified lane agility time in seconds
    attribute :modified_lane_agility_time, Shale::Type::Float

    # @!attribute [rw] three_quarter_sprint
    #   Returns the three-quarter court sprint time in seconds
    #   @api public
    #   @example
    #     result.three_quarter_sprint #=> 3.2
    #   @return [Float] three-quarter sprint time in seconds
    attribute :three_quarter_sprint, Shale::Type::Float

    # @!attribute [rw] bench_press
    #   Returns the number of bench press repetitions
    #   @api public
    #   @example
    #     result.bench_press #=> 12
    #   @return [Integer] bench press repetitions
    attribute :bench_press, Shale::Type::Integer

    # Returns the player object
    #
    # @api public
    # @example
    #   result.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end
  end
end
