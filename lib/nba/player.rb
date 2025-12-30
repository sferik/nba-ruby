require "equalizer"
require "shale"
require_relative "team"
require_relative "position"

module NBA
  # Represents an NBA player
  class Player < Shale::Mapper
    include Equalizer.new(:id)

    # @!attribute [rw] id
    #   Returns the unique identifier for the player
    #   @api public
    #   @example
    #     player.id #=> 2544
    #   @return [Integer] the unique identifier for the player
    attribute :id, Shale::Type::Integer

    # @!attribute [rw] full_name
    #   Returns the player's full name
    #   @api public
    #   @example
    #     player.full_name #=> "LeBron James"
    #   @return [String] the player's full name
    attribute :full_name, Shale::Type::String

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     player.first_name #=> "LeBron"
    #   @return [String] the player's first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     player.last_name #=> "James"
    #   @return [String] the player's last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] is_active
    #   Returns whether the player is currently active
    #   @api public
    #   @example
    #     player.is_active #=> true
    #   @return [Boolean] whether the player is currently active
    attribute :is_active, Shale::Type::Boolean

    # @!attribute [rw] jersey_number
    #   Returns the player's jersey number
    #   @api public
    #   @example
    #     player.jersey_number #=> 23
    #   @return [Integer] the player's jersey number
    attribute :jersey_number, Shale::Type::Integer

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     player.position #=> #<NBA::Position>
    #   @return [Position] the player's position
    attribute :position, Position

    # @!attribute [rw] height
    #   Returns the player's height
    #   @api public
    #   @example
    #     player.height #=> "6-9"
    #   @return [String] the player's height
    attribute :height, Shale::Type::String

    # @!attribute [rw] weight
    #   Returns the player's weight
    #   @api public
    #   @example
    #     player.weight #=> 250
    #   @return [Integer] the player's weight
    attribute :weight, Shale::Type::Integer

    # @!attribute [rw] college
    #   Returns the player's college
    #   @api public
    #   @example
    #     player.college #=> "St. Vincent-St. Mary HS (OH)"
    #   @return [String] the player's college
    attribute :college, Shale::Type::String

    # @!attribute [rw] country
    #   Returns the player's country
    #   @api public
    #   @example
    #     player.country #=> "USA"
    #   @return [String] the player's country
    attribute :country, Shale::Type::String

    # @!attribute [rw] draft_year
    #   Returns the year the player was drafted
    #   @api public
    #   @example
    #     player.draft_year #=> 2003
    #   @return [Integer] the year the player was drafted
    attribute :draft_year, Shale::Type::Integer

    # @!attribute [rw] draft_round
    #   Returns the round the player was drafted
    #   @api public
    #   @example
    #     player.draft_round #=> 1
    #   @return [Integer] the round the player was drafted
    attribute :draft_round, Shale::Type::Integer

    # @!attribute [rw] draft_number
    #   Returns the number the player was drafted
    #   @api public
    #   @example
    #     player.draft_number #=> 1
    #   @return [Integer] the number the player was drafted
    attribute :draft_number, Shale::Type::Integer

    # @!attribute [rw] team
    #   Returns the player's current team
    #   @api public
    #   @example
    #     player.team #=> #<NBA::Team>
    #   @return [Team] the player's current team
    attribute :team, Team

    # Returns whether the player is active
    #
    # @api public
    # @example
    #   player.active?
    # @return [Boolean, nil] true if the player is active
    alias_method :active?, :is_active

    json do
      map "id", to: :id
      map "person_id", to: :id
      map "personId", to: :id
      map "full_name", to: :full_name
      map "fullName", to: :full_name
      map "display_first_last", to: :full_name
      map "displayFirstLast", to: :full_name
      map "first_name", to: :first_name
      map "firstName", to: :first_name
      map "last_name", to: :last_name
      map "lastName", to: :last_name
      map "is_active", to: :is_active
      map "isActive", to: :is_active
      map "jersey", to: :jersey_number
      map "jerseyNum", to: :jersey_number
      map "position", to: :position
      map "pos", to: :position
      map "height", to: :height
      map "weight", to: :weight
      map "college", to: :college
      map "country", to: :country
      map "draft_year", to: :draft_year
      map "draftYear", to: :draft_year
      map "draft_round", to: :draft_round
      map "draftRound", to: :draft_round
      map "draft_number", to: :draft_number
      map "draftNumber", to: :draft_number
      map "team", to: :team
    end
  end
end
