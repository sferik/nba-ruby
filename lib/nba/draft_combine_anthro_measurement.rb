require "equalizer"
require "shale"

module NBA
  # Represents a draft combine anthropometric measurement
  class DraftCombineAnthroMeasurement < Shale::Mapper
    include Equalizer.new(:player_id)

    # @!attribute [rw] temp_player_id
    #   Returns the temporary player ID
    #   @api public
    #   @example
    #     measurement.temp_player_id #=> 123456
    #   @return [Integer] the temporary player ID
    attribute :temp_player_id, Shale::Type::Integer

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     measurement.player_id #=> 1630162
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     measurement.first_name #=> "Victor"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     measurement.last_name #=> "Wembanyama"
    #   @return [String] the last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     measurement.player_name #=> "Victor Wembanyama"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     measurement.position #=> "C"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] height_wo_shoes
    #   Returns the height without shoes in inches
    #   @api public
    #   @example
    #     measurement.height_wo_shoes #=> 85.5
    #   @return [Float] height without shoes
    attribute :height_wo_shoes, Shale::Type::Float

    # @!attribute [rw] height_wo_shoes_ft_in
    #   Returns the height without shoes in feet and inches
    #   @api public
    #   @example
    #     measurement.height_wo_shoes_ft_in #=> "7' 1.5\""
    #   @return [String] height without shoes in feet and inches
    attribute :height_wo_shoes_ft_in, Shale::Type::String

    # @!attribute [rw] height_w_shoes
    #   Returns the height with shoes in inches
    #   @api public
    #   @example
    #     measurement.height_w_shoes #=> 86.5
    #   @return [Float] height with shoes
    attribute :height_w_shoes, Shale::Type::Float

    # @!attribute [rw] height_w_shoes_ft_in
    #   Returns the height with shoes in feet and inches
    #   @api public
    #   @example
    #     measurement.height_w_shoes_ft_in #=> "7' 2.5\""
    #   @return [String] height with shoes in feet and inches
    attribute :height_w_shoes_ft_in, Shale::Type::String

    # @!attribute [rw] weight
    #   Returns the weight in pounds
    #   @api public
    #   @example
    #     measurement.weight #=> 209.0
    #   @return [Float] weight in pounds
    attribute :weight, Shale::Type::Float

    # @!attribute [rw] wingspan
    #   Returns the wingspan in inches
    #   @api public
    #   @example
    #     measurement.wingspan #=> 96.0
    #   @return [Float] wingspan in inches
    attribute :wingspan, Shale::Type::Float

    # @!attribute [rw] wingspan_ft_in
    #   Returns the wingspan in feet and inches
    #   @api public
    #   @example
    #     measurement.wingspan_ft_in #=> "8' 0\""
    #   @return [String] wingspan in feet and inches
    attribute :wingspan_ft_in, Shale::Type::String

    # @!attribute [rw] standing_reach
    #   Returns the standing reach in inches
    #   @api public
    #   @example
    #     measurement.standing_reach #=> 114.5
    #   @return [Float] standing reach in inches
    attribute :standing_reach, Shale::Type::Float

    # @!attribute [rw] standing_reach_ft_in
    #   Returns the standing reach in feet and inches
    #   @api public
    #   @example
    #     measurement.standing_reach_ft_in #=> "9' 6.5\""
    #   @return [String] standing reach in feet and inches
    attribute :standing_reach_ft_in, Shale::Type::String

    # @!attribute [rw] body_fat_pct
    #   Returns the body fat percentage
    #   @api public
    #   @example
    #     measurement.body_fat_pct #=> 4.8
    #   @return [Float] body fat percentage
    attribute :body_fat_pct, Shale::Type::Float

    # @!attribute [rw] hand_length
    #   Returns the hand length in inches
    #   @api public
    #   @example
    #     measurement.hand_length #=> 10.25
    #   @return [Float] hand length in inches
    attribute :hand_length, Shale::Type::Float

    # @!attribute [rw] hand_width
    #   Returns the hand width in inches
    #   @api public
    #   @example
    #     measurement.hand_width #=> 12.0
    #   @return [Float] hand width in inches
    attribute :hand_width, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   measurement.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end
  end
end
