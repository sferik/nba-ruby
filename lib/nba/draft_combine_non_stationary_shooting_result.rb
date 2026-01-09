require "equalizer"
require "shale"

module NBA
  # Represents a draft combine non-stationary shooting result
  class DraftCombineNonStationaryShootingResult < Shale::Mapper
    include Equalizer.new(:player_id)

    # @!attribute [rw] temp_player_id
    #   Returns the temporary player ID
    #   @api public
    #   @example
    #     result.temp_player_id #=> 1
    #   @return [Integer] the temporary player ID
    attribute :temp_player_id, Shale::Type::Integer

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     result.player_id #=> 1630162
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     result.player_name #=> "Victor Wembanyama"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

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

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     result.position #=> "C"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] off_dribble_fifteen_break_left_made
    #   Returns off-dribble 15-foot break left shots made
    #   @api public
    #   @example
    #     result.off_dribble_fifteen_break_left_made #=> 3
    #   @return [Integer] shots made
    attribute :off_dribble_fifteen_break_left_made, Shale::Type::Integer

    # @!attribute [rw] off_dribble_fifteen_break_left_attempt
    #   Returns off-dribble 15-foot break left shot attempts
    #   @api public
    #   @example
    #     result.off_dribble_fifteen_break_left_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :off_dribble_fifteen_break_left_attempt, Shale::Type::Integer

    # @!attribute [rw] off_dribble_fifteen_break_left_pct
    #   Returns off-dribble 15-foot break left shooting percentage
    #   @api public
    #   @example
    #     result.off_dribble_fifteen_break_left_pct #=> 0.600
    #   @return [Float] shooting percentage
    attribute :off_dribble_fifteen_break_left_pct, Shale::Type::Float

    # @!attribute [rw] off_dribble_fifteen_top_key_made
    #   Returns off-dribble 15-foot top key shots made
    #   @api public
    #   @example
    #     result.off_dribble_fifteen_top_key_made #=> 4
    #   @return [Integer] shots made
    attribute :off_dribble_fifteen_top_key_made, Shale::Type::Integer

    # @!attribute [rw] off_dribble_fifteen_top_key_attempt
    #   Returns off-dribble 15-foot top key shot attempts
    #   @api public
    #   @example
    #     result.off_dribble_fifteen_top_key_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :off_dribble_fifteen_top_key_attempt, Shale::Type::Integer

    # @!attribute [rw] off_dribble_fifteen_top_key_pct
    #   Returns off-dribble 15-foot top key shooting percentage
    #   @api public
    #   @example
    #     result.off_dribble_fifteen_top_key_pct #=> 0.800
    #   @return [Float] shooting percentage
    attribute :off_dribble_fifteen_top_key_pct, Shale::Type::Float

    # @!attribute [rw] off_dribble_fifteen_break_right_made
    #   Returns off-dribble 15-foot break right shots made
    #   @api public
    #   @example
    #     result.off_dribble_fifteen_break_right_made #=> 3
    #   @return [Integer] shots made
    attribute :off_dribble_fifteen_break_right_made, Shale::Type::Integer

    # @!attribute [rw] off_dribble_fifteen_break_right_attempt
    #   Returns off-dribble 15-foot break right shot attempts
    #   @api public
    #   @example
    #     result.off_dribble_fifteen_break_right_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :off_dribble_fifteen_break_right_attempt, Shale::Type::Integer

    # @!attribute [rw] off_dribble_fifteen_break_right_pct
    #   Returns off-dribble 15-foot break right shooting percentage
    #   @api public
    #   @example
    #     result.off_dribble_fifteen_break_right_pct #=> 0.600
    #   @return [Float] shooting percentage
    attribute :off_dribble_fifteen_break_right_pct, Shale::Type::Float

    # @!attribute [rw] on_move_fifteen_break_left_made
    #   Returns on-the-move 15-foot break left shots made
    #   @api public
    #   @example
    #     result.on_move_fifteen_break_left_made #=> 2
    #   @return [Integer] shots made
    attribute :on_move_fifteen_break_left_made, Shale::Type::Integer

    # @!attribute [rw] on_move_fifteen_break_left_attempt
    #   Returns on-the-move 15-foot break left shot attempts
    #   @api public
    #   @example
    #     result.on_move_fifteen_break_left_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :on_move_fifteen_break_left_attempt, Shale::Type::Integer

    # @!attribute [rw] on_move_fifteen_break_left_pct
    #   Returns on-the-move 15-foot break left shooting percentage
    #   @api public
    #   @example
    #     result.on_move_fifteen_break_left_pct #=> 0.400
    #   @return [Float] shooting percentage
    attribute :on_move_fifteen_break_left_pct, Shale::Type::Float

    # @!attribute [rw] on_move_fifteen_top_key_made
    #   Returns on-the-move 15-foot top key shots made
    #   @api public
    #   @example
    #     result.on_move_fifteen_top_key_made #=> 3
    #   @return [Integer] shots made
    attribute :on_move_fifteen_top_key_made, Shale::Type::Integer

    # @!attribute [rw] on_move_fifteen_top_key_attempt
    #   Returns on-the-move 15-foot top key shot attempts
    #   @api public
    #   @example
    #     result.on_move_fifteen_top_key_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :on_move_fifteen_top_key_attempt, Shale::Type::Integer

    # @!attribute [rw] on_move_fifteen_top_key_pct
    #   Returns on-the-move 15-foot top key shooting percentage
    #   @api public
    #   @example
    #     result.on_move_fifteen_top_key_pct #=> 0.600
    #   @return [Float] shooting percentage
    attribute :on_move_fifteen_top_key_pct, Shale::Type::Float

    # @!attribute [rw] on_move_fifteen_break_right_made
    #   Returns on-the-move 15-foot break right shots made
    #   @api public
    #   @example
    #     result.on_move_fifteen_break_right_made #=> 2
    #   @return [Integer] shots made
    attribute :on_move_fifteen_break_right_made, Shale::Type::Integer

    # @!attribute [rw] on_move_fifteen_break_right_attempt
    #   Returns on-the-move 15-foot break right shot attempts
    #   @api public
    #   @example
    #     result.on_move_fifteen_break_right_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :on_move_fifteen_break_right_attempt, Shale::Type::Integer

    # @!attribute [rw] on_move_fifteen_break_right_pct
    #   Returns on-the-move 15-foot break right shooting percentage
    #   @api public
    #   @example
    #     result.on_move_fifteen_break_right_pct #=> 0.400
    #   @return [Float] shooting percentage
    attribute :on_move_fifteen_break_right_pct, Shale::Type::Float

    # @!attribute [rw] off_dribble_college_break_left_made
    #   Returns off-dribble college range break left shots made
    #   @api public
    #   @example
    #     result.off_dribble_college_break_left_made #=> 2
    #   @return [Integer] shots made
    attribute :off_dribble_college_break_left_made, Shale::Type::Integer

    # @!attribute [rw] off_dribble_college_break_left_attempt
    #   Returns off-dribble college range break left shot attempts
    #   @api public
    #   @example
    #     result.off_dribble_college_break_left_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :off_dribble_college_break_left_attempt, Shale::Type::Integer

    # @!attribute [rw] off_dribble_college_break_left_pct
    #   Returns off-dribble college range break left shooting percentage
    #   @api public
    #   @example
    #     result.off_dribble_college_break_left_pct #=> 0.400
    #   @return [Float] shooting percentage
    attribute :off_dribble_college_break_left_pct, Shale::Type::Float

    # @!attribute [rw] off_dribble_college_top_key_made
    #   Returns off-dribble college range top key shots made
    #   @api public
    #   @example
    #     result.off_dribble_college_top_key_made #=> 3
    #   @return [Integer] shots made
    attribute :off_dribble_college_top_key_made, Shale::Type::Integer

    # @!attribute [rw] off_dribble_college_top_key_attempt
    #   Returns off-dribble college range top key shot attempts
    #   @api public
    #   @example
    #     result.off_dribble_college_top_key_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :off_dribble_college_top_key_attempt, Shale::Type::Integer

    # @!attribute [rw] off_dribble_college_top_key_pct
    #   Returns off-dribble college range top key shooting percentage
    #   @api public
    #   @example
    #     result.off_dribble_college_top_key_pct #=> 0.600
    #   @return [Float] shooting percentage
    attribute :off_dribble_college_top_key_pct, Shale::Type::Float

    # @!attribute [rw] off_dribble_college_break_right_made
    #   Returns off-dribble college range break right shots made
    #   @api public
    #   @example
    #     result.off_dribble_college_break_right_made #=> 2
    #   @return [Integer] shots made
    attribute :off_dribble_college_break_right_made, Shale::Type::Integer

    # @!attribute [rw] off_dribble_college_break_right_attempt
    #   Returns off-dribble college range break right shot attempts
    #   @api public
    #   @example
    #     result.off_dribble_college_break_right_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :off_dribble_college_break_right_attempt, Shale::Type::Integer

    # @!attribute [rw] off_dribble_college_break_right_pct
    #   Returns off-dribble college range break right shooting percentage
    #   @api public
    #   @example
    #     result.off_dribble_college_break_right_pct #=> 0.400
    #   @return [Float] shooting percentage
    attribute :off_dribble_college_break_right_pct, Shale::Type::Float

    # @!attribute [rw] on_move_college_break_left_made
    #   Returns on-the-move college range break left shots made
    #   @api public
    #   @example
    #     result.on_move_college_break_left_made #=> 1
    #   @return [Integer] shots made
    attribute :on_move_college_break_left_made, Shale::Type::Integer

    # @!attribute [rw] on_move_college_break_left_attempt
    #   Returns on-the-move college range break left shot attempts
    #   @api public
    #   @example
    #     result.on_move_college_break_left_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :on_move_college_break_left_attempt, Shale::Type::Integer

    # @!attribute [rw] on_move_college_break_left_pct
    #   Returns on-the-move college range break left shooting percentage
    #   @api public
    #   @example
    #     result.on_move_college_break_left_pct #=> 0.200
    #   @return [Float] shooting percentage
    attribute :on_move_college_break_left_pct, Shale::Type::Float

    # @!attribute [rw] on_move_college_top_key_made
    #   Returns on-the-move college range top key shots made
    #   @api public
    #   @example
    #     result.on_move_college_top_key_made #=> 2
    #   @return [Integer] shots made
    attribute :on_move_college_top_key_made, Shale::Type::Integer

    # @!attribute [rw] on_move_college_top_key_attempt
    #   Returns on-the-move college range top key shot attempts
    #   @api public
    #   @example
    #     result.on_move_college_top_key_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :on_move_college_top_key_attempt, Shale::Type::Integer

    # @!attribute [rw] on_move_college_top_key_pct
    #   Returns on-the-move college range top key shooting percentage
    #   @api public
    #   @example
    #     result.on_move_college_top_key_pct #=> 0.400
    #   @return [Float] shooting percentage
    attribute :on_move_college_top_key_pct, Shale::Type::Float

    # @!attribute [rw] on_move_college_break_right_made
    #   Returns on-the-move college range break right shots made
    #   @api public
    #   @example
    #     result.on_move_college_break_right_made #=> 1
    #   @return [Integer] shots made
    attribute :on_move_college_break_right_made, Shale::Type::Integer

    # @!attribute [rw] on_move_college_break_right_attempt
    #   Returns on-the-move college range break right shot attempts
    #   @api public
    #   @example
    #     result.on_move_college_break_right_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :on_move_college_break_right_attempt, Shale::Type::Integer

    # @!attribute [rw] on_move_college_break_right_pct
    #   Returns on-the-move college range break right shooting percentage
    #   @api public
    #   @example
    #     result.on_move_college_break_right_pct #=> 0.200
    #   @return [Float] shooting percentage
    attribute :on_move_college_break_right_pct, Shale::Type::Float

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
