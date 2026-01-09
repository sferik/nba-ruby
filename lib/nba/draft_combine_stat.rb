require "equalizer"
require "shale"

module NBA
  # Represents a draft combine stat
  class DraftCombineStat < Shale::Mapper
    include Equalizer.new(:player_id)

    # @!attribute [rw] season
    #   Returns the season
    #   @api public
    #   @example
    #     stat.season #=> "2023-24"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 1630162
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     stat.first_name #=> "Victor"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     stat.last_name #=> "Wembanyama"
    #   @return [String] the last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.player_name #=> "Victor Wembanyama"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     stat.position #=> "C"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] height_wo_shoes
    #   Returns height without shoes in inches
    #   @api public
    #   @example
    #     stat.height_wo_shoes #=> 83.5
    #   @return [Float] height without shoes
    attribute :height_wo_shoes, Shale::Type::Float

    # @!attribute [rw] height_wo_shoes_ft_in
    #   Returns height without shoes in feet and inches
    #   @api public
    #   @example
    #     stat.height_wo_shoes_ft_in #=> "6-11.5"
    #   @return [String] height without shoes
    attribute :height_wo_shoes_ft_in, Shale::Type::String

    # @!attribute [rw] height_w_shoes
    #   Returns height with shoes in inches
    #   @api public
    #   @example
    #     stat.height_w_shoes #=> 84.5
    #   @return [Float] height with shoes
    attribute :height_w_shoes, Shale::Type::Float

    # @!attribute [rw] height_w_shoes_ft_in
    #   Returns height with shoes in feet and inches
    #   @api public
    #   @example
    #     stat.height_w_shoes_ft_in #=> "7-0.5"
    #   @return [String] height with shoes
    attribute :height_w_shoes_ft_in, Shale::Type::String

    # @!attribute [rw] weight
    #   Returns weight in pounds
    #   @api public
    #   @example
    #     stat.weight #=> 209.0
    #   @return [Float] weight
    attribute :weight, Shale::Type::Float

    # @!attribute [rw] wingspan
    #   Returns wingspan in inches
    #   @api public
    #   @example
    #     stat.wingspan #=> 94.0
    #   @return [Float] wingspan
    attribute :wingspan, Shale::Type::Float

    # @!attribute [rw] wingspan_ft_in
    #   Returns wingspan in feet and inches
    #   @api public
    #   @example
    #     stat.wingspan_ft_in #=> "7-10"
    #   @return [String] wingspan
    attribute :wingspan_ft_in, Shale::Type::String

    # @!attribute [rw] standing_reach
    #   Returns standing reach in inches
    #   @api public
    #   @example
    #     stat.standing_reach #=> 112.0
    #   @return [Float] standing reach
    attribute :standing_reach, Shale::Type::Float

    # @!attribute [rw] standing_reach_ft_in
    #   Returns standing reach in feet and inches
    #   @api public
    #   @example
    #     stat.standing_reach_ft_in #=> "9-4"
    #   @return [String] standing reach
    attribute :standing_reach_ft_in, Shale::Type::String

    # @!attribute [rw] body_fat_pct
    #   Returns body fat percentage
    #   @api public
    #   @example
    #     stat.body_fat_pct #=> 6.8
    #   @return [Float] body fat percentage
    attribute :body_fat_pct, Shale::Type::Float

    # @!attribute [rw] hand_length
    #   Returns hand length in inches
    #   @api public
    #   @example
    #     stat.hand_length #=> 9.75
    #   @return [Float] hand length
    attribute :hand_length, Shale::Type::Float

    # @!attribute [rw] hand_width
    #   Returns hand width in inches
    #   @api public
    #   @example
    #     stat.hand_width #=> 10.5
    #   @return [Float] hand width
    attribute :hand_width, Shale::Type::Float

    # @!attribute [rw] standing_vertical_leap
    #   Returns standing vertical leap in inches
    #   @api public
    #   @example
    #     stat.standing_vertical_leap #=> 32.0
    #   @return [Float] standing vertical leap
    attribute :standing_vertical_leap, Shale::Type::Float

    # @!attribute [rw] max_vertical_leap
    #   Returns maximum vertical leap in inches
    #   @api public
    #   @example
    #     stat.max_vertical_leap #=> 40.5
    #   @return [Float] maximum vertical leap
    attribute :max_vertical_leap, Shale::Type::Float

    # @!attribute [rw] lane_agility_time
    #   Returns lane agility time in seconds
    #   @api public
    #   @example
    #     stat.lane_agility_time #=> 10.75
    #   @return [Float] lane agility time
    attribute :lane_agility_time, Shale::Type::Float

    # @!attribute [rw] modified_lane_agility_time
    #   Returns modified lane agility time in seconds
    #   @api public
    #   @example
    #     stat.modified_lane_agility_time #=> 10.5
    #   @return [Float] modified lane agility time
    attribute :modified_lane_agility_time, Shale::Type::Float

    # @!attribute [rw] three_quarter_sprint
    #   Returns three quarter sprint time in seconds
    #   @api public
    #   @example
    #     stat.three_quarter_sprint #=> 3.25
    #   @return [Float] three quarter sprint time
    attribute :three_quarter_sprint, Shale::Type::Float

    # @!attribute [rw] bench_press
    #   Returns bench press repetitions
    #   @api public
    #   @example
    #     stat.bench_press #=> 15
    #   @return [Integer] bench press repetitions
    attribute :bench_press, Shale::Type::Integer

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end
  end
end
