require "equalizer"
require "shale"

module NBA
  # Represents a draft combine spot shooting result
  class DraftCombineSpotShootingResult < Shale::Mapper
    include Equalizer.new(:player_id)

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

    # @!attribute [rw] fifteen_corner_left_made
    #   Returns 15-foot corner left shots made
    #   @api public
    #   @example
    #     result.fifteen_corner_left_made #=> 3
    #   @return [Integer] shots made
    attribute :fifteen_corner_left_made, Shale::Type::Integer

    # @!attribute [rw] fifteen_corner_left_attempt
    #   Returns 15-foot corner left shot attempts
    #   @api public
    #   @example
    #     result.fifteen_corner_left_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :fifteen_corner_left_attempt, Shale::Type::Integer

    # @!attribute [rw] fifteen_corner_left_pct
    #   Returns 15-foot corner left shooting percentage
    #   @api public
    #   @example
    #     result.fifteen_corner_left_pct #=> 0.600
    #   @return [Float] shooting percentage
    attribute :fifteen_corner_left_pct, Shale::Type::Float

    # @!attribute [rw] fifteen_break_left_made
    #   Returns 15-foot break left shots made
    #   @api public
    #   @example
    #     result.fifteen_break_left_made #=> 4
    #   @return [Integer] shots made
    attribute :fifteen_break_left_made, Shale::Type::Integer

    # @!attribute [rw] fifteen_break_left_attempt
    #   Returns 15-foot break left shot attempts
    #   @api public
    #   @example
    #     result.fifteen_break_left_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :fifteen_break_left_attempt, Shale::Type::Integer

    # @!attribute [rw] fifteen_break_left_pct
    #   Returns 15-foot break left shooting percentage
    #   @api public
    #   @example
    #     result.fifteen_break_left_pct #=> 0.800
    #   @return [Float] shooting percentage
    attribute :fifteen_break_left_pct, Shale::Type::Float

    # @!attribute [rw] fifteen_top_key_made
    #   Returns 15-foot top key shots made
    #   @api public
    #   @example
    #     result.fifteen_top_key_made #=> 5
    #   @return [Integer] shots made
    attribute :fifteen_top_key_made, Shale::Type::Integer

    # @!attribute [rw] fifteen_top_key_attempt
    #   Returns 15-foot top key shot attempts
    #   @api public
    #   @example
    #     result.fifteen_top_key_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :fifteen_top_key_attempt, Shale::Type::Integer

    # @!attribute [rw] fifteen_top_key_pct
    #   Returns 15-foot top key shooting percentage
    #   @api public
    #   @example
    #     result.fifteen_top_key_pct #=> 1.000
    #   @return [Float] shooting percentage
    attribute :fifteen_top_key_pct, Shale::Type::Float

    # @!attribute [rw] fifteen_break_right_made
    #   Returns 15-foot break right shots made
    #   @api public
    #   @example
    #     result.fifteen_break_right_made #=> 3
    #   @return [Integer] shots made
    attribute :fifteen_break_right_made, Shale::Type::Integer

    # @!attribute [rw] fifteen_break_right_attempt
    #   Returns 15-foot break right shot attempts
    #   @api public
    #   @example
    #     result.fifteen_break_right_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :fifteen_break_right_attempt, Shale::Type::Integer

    # @!attribute [rw] fifteen_break_right_pct
    #   Returns 15-foot break right shooting percentage
    #   @api public
    #   @example
    #     result.fifteen_break_right_pct #=> 0.600
    #   @return [Float] shooting percentage
    attribute :fifteen_break_right_pct, Shale::Type::Float

    # @!attribute [rw] fifteen_corner_right_made
    #   Returns 15-foot corner right shots made
    #   @api public
    #   @example
    #     result.fifteen_corner_right_made #=> 4
    #   @return [Integer] shots made
    attribute :fifteen_corner_right_made, Shale::Type::Integer

    # @!attribute [rw] fifteen_corner_right_attempt
    #   Returns 15-foot corner right shot attempts
    #   @api public
    #   @example
    #     result.fifteen_corner_right_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :fifteen_corner_right_attempt, Shale::Type::Integer

    # @!attribute [rw] fifteen_corner_right_pct
    #   Returns 15-foot corner right shooting percentage
    #   @api public
    #   @example
    #     result.fifteen_corner_right_pct #=> 0.800
    #   @return [Float] shooting percentage
    attribute :fifteen_corner_right_pct, Shale::Type::Float

    # @!attribute [rw] college_corner_left_made
    #   Returns college range corner left shots made
    #   @api public
    #   @example
    #     result.college_corner_left_made #=> 3
    #   @return [Integer] shots made
    attribute :college_corner_left_made, Shale::Type::Integer

    # @!attribute [rw] college_corner_left_attempt
    #   Returns college range corner left shot attempts
    #   @api public
    #   @example
    #     result.college_corner_left_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :college_corner_left_attempt, Shale::Type::Integer

    # @!attribute [rw] college_corner_left_pct
    #   Returns college range corner left shooting percentage
    #   @api public
    #   @example
    #     result.college_corner_left_pct #=> 0.600
    #   @return [Float] shooting percentage
    attribute :college_corner_left_pct, Shale::Type::Float

    # @!attribute [rw] college_break_left_made
    #   Returns college range break left shots made
    #   @api public
    #   @example
    #     result.college_break_left_made #=> 4
    #   @return [Integer] shots made
    attribute :college_break_left_made, Shale::Type::Integer

    # @!attribute [rw] college_break_left_attempt
    #   Returns college range break left shot attempts
    #   @api public
    #   @example
    #     result.college_break_left_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :college_break_left_attempt, Shale::Type::Integer

    # @!attribute [rw] college_break_left_pct
    #   Returns college range break left shooting percentage
    #   @api public
    #   @example
    #     result.college_break_left_pct #=> 0.800
    #   @return [Float] shooting percentage
    attribute :college_break_left_pct, Shale::Type::Float

    # @!attribute [rw] college_top_key_made
    #   Returns college range top key shots made
    #   @api public
    #   @example
    #     result.college_top_key_made #=> 5
    #   @return [Integer] shots made
    attribute :college_top_key_made, Shale::Type::Integer

    # @!attribute [rw] college_top_key_attempt
    #   Returns college range top key shot attempts
    #   @api public
    #   @example
    #     result.college_top_key_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :college_top_key_attempt, Shale::Type::Integer

    # @!attribute [rw] college_top_key_pct
    #   Returns college range top key shooting percentage
    #   @api public
    #   @example
    #     result.college_top_key_pct #=> 1.000
    #   @return [Float] shooting percentage
    attribute :college_top_key_pct, Shale::Type::Float

    # @!attribute [rw] college_break_right_made
    #   Returns college range break right shots made
    #   @api public
    #   @example
    #     result.college_break_right_made #=> 3
    #   @return [Integer] shots made
    attribute :college_break_right_made, Shale::Type::Integer

    # @!attribute [rw] college_break_right_attempt
    #   Returns college range break right shot attempts
    #   @api public
    #   @example
    #     result.college_break_right_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :college_break_right_attempt, Shale::Type::Integer

    # @!attribute [rw] college_break_right_pct
    #   Returns college range break right shooting percentage
    #   @api public
    #   @example
    #     result.college_break_right_pct #=> 0.600
    #   @return [Float] shooting percentage
    attribute :college_break_right_pct, Shale::Type::Float

    # @!attribute [rw] college_corner_right_made
    #   Returns college range corner right shots made
    #   @api public
    #   @example
    #     result.college_corner_right_made #=> 4
    #   @return [Integer] shots made
    attribute :college_corner_right_made, Shale::Type::Integer

    # @!attribute [rw] college_corner_right_attempt
    #   Returns college range corner right shot attempts
    #   @api public
    #   @example
    #     result.college_corner_right_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :college_corner_right_attempt, Shale::Type::Integer

    # @!attribute [rw] college_corner_right_pct
    #   Returns college range corner right shooting percentage
    #   @api public
    #   @example
    #     result.college_corner_right_pct #=> 0.800
    #   @return [Float] shooting percentage
    attribute :college_corner_right_pct, Shale::Type::Float

    # @!attribute [rw] nba_corner_left_made
    #   Returns NBA range corner left shots made
    #   @api public
    #   @example
    #     result.nba_corner_left_made #=> 3
    #   @return [Integer] shots made
    attribute :nba_corner_left_made, Shale::Type::Integer

    # @!attribute [rw] nba_corner_left_attempt
    #   Returns NBA range corner left shot attempts
    #   @api public
    #   @example
    #     result.nba_corner_left_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :nba_corner_left_attempt, Shale::Type::Integer

    # @!attribute [rw] nba_corner_left_pct
    #   Returns NBA range corner left shooting percentage
    #   @api public
    #   @example
    #     result.nba_corner_left_pct #=> 0.600
    #   @return [Float] shooting percentage
    attribute :nba_corner_left_pct, Shale::Type::Float

    # @!attribute [rw] nba_break_left_made
    #   Returns NBA range break left shots made
    #   @api public
    #   @example
    #     result.nba_break_left_made #=> 4
    #   @return [Integer] shots made
    attribute :nba_break_left_made, Shale::Type::Integer

    # @!attribute [rw] nba_break_left_attempt
    #   Returns NBA range break left shot attempts
    #   @api public
    #   @example
    #     result.nba_break_left_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :nba_break_left_attempt, Shale::Type::Integer

    # @!attribute [rw] nba_break_left_pct
    #   Returns NBA range break left shooting percentage
    #   @api public
    #   @example
    #     result.nba_break_left_pct #=> 0.800
    #   @return [Float] shooting percentage
    attribute :nba_break_left_pct, Shale::Type::Float

    # @!attribute [rw] nba_top_key_made
    #   Returns NBA range top key shots made
    #   @api public
    #   @example
    #     result.nba_top_key_made #=> 5
    #   @return [Integer] shots made
    attribute :nba_top_key_made, Shale::Type::Integer

    # @!attribute [rw] nba_top_key_attempt
    #   Returns NBA range top key shot attempts
    #   @api public
    #   @example
    #     result.nba_top_key_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :nba_top_key_attempt, Shale::Type::Integer

    # @!attribute [rw] nba_top_key_pct
    #   Returns NBA range top key shooting percentage
    #   @api public
    #   @example
    #     result.nba_top_key_pct #=> 1.000
    #   @return [Float] shooting percentage
    attribute :nba_top_key_pct, Shale::Type::Float

    # @!attribute [rw] nba_break_right_made
    #   Returns NBA range break right shots made
    #   @api public
    #   @example
    #     result.nba_break_right_made #=> 3
    #   @return [Integer] shots made
    attribute :nba_break_right_made, Shale::Type::Integer

    # @!attribute [rw] nba_break_right_attempt
    #   Returns NBA range break right shot attempts
    #   @api public
    #   @example
    #     result.nba_break_right_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :nba_break_right_attempt, Shale::Type::Integer

    # @!attribute [rw] nba_break_right_pct
    #   Returns NBA range break right shooting percentage
    #   @api public
    #   @example
    #     result.nba_break_right_pct #=> 0.600
    #   @return [Float] shooting percentage
    attribute :nba_break_right_pct, Shale::Type::Float

    # @!attribute [rw] nba_corner_right_made
    #   Returns NBA range corner right shots made
    #   @api public
    #   @example
    #     result.nba_corner_right_made #=> 4
    #   @return [Integer] shots made
    attribute :nba_corner_right_made, Shale::Type::Integer

    # @!attribute [rw] nba_corner_right_attempt
    #   Returns NBA range corner right shot attempts
    #   @api public
    #   @example
    #     result.nba_corner_right_attempt #=> 5
    #   @return [Integer] shot attempts
    attribute :nba_corner_right_attempt, Shale::Type::Integer

    # @!attribute [rw] nba_corner_right_pct
    #   Returns NBA range corner right shooting percentage
    #   @api public
    #   @example
    #     result.nba_corner_right_pct #=> 0.800
    #   @return [Float] shooting percentage
    attribute :nba_corner_right_pct, Shale::Type::Float

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
