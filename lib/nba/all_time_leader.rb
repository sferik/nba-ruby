require "equalizer"
require "shale"

module NBA
  # Represents an all-time statistical leader
  class AllTimeLeader < Shale::Mapper
    include Equalizer.new(:player_id, :category)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     leader.player_id #=> 2544
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     leader.player_name #=> "LeBron James"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] category
    #   Returns the statistical category
    #   @api public
    #   @example
    #     leader.category #=> "PTS"
    #   @return [String] the category
    attribute :category, Shale::Type::String

    # @!attribute [rw] value
    #   Returns the stat value
    #   @api public
    #   @example
    #     leader.value #=> 40474
    #   @return [Float] the value
    attribute :value, Shale::Type::Float

    # @!attribute [rw] rank
    #   Returns the ranking position
    #   @api public
    #   @example
    #     leader.rank #=> 1
    #   @return [Integer] the rank
    attribute :rank, Shale::Type::Integer

    # @!attribute [rw] is_active
    #   Returns whether the player is active
    #   @api public
    #   @example
    #     leader.is_active #=> true
    #   @return [Boolean] whether active
    attribute :is_active, Shale::Type::Boolean

    # Returns the player object
    #
    # @api public
    # @example
    #   leader.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns whether the player is active
    #
    # @api public
    # @example
    #   leader.active? #=> true
    # @return [Boolean] true if active
    def active?
      is_active
    end
  end
end
