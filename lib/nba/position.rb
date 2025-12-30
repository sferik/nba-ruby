require "equalizer"
require "shale"

module NBA
  # Represents a player position
  class Position < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the position code
    #   @api public
    #   @example
    #     position.code #=> "PG"
    #   @return [String] the position code
    attribute :code, Shale::Type::String

    # @!attribute [rw] name
    #   Returns the position name
    #   @api public
    #   @example
    #     position.name #=> "Point Guard"
    #   @return [String] the position name
    attribute :name, Shale::Type::String

    # @!attribute [rw] type
    #   Returns the position type
    #   @api public
    #   @example
    #     position.type #=> "Guard"
    #   @return [String] the position type
    attribute :type, Shale::Type::String

    # @!attribute [rw] abbreviation
    #   Returns the position abbreviation
    #   @api public
    #   @example
    #     position.abbreviation #=> "G"
    #   @return [String] the position abbreviation
    attribute :abbreviation, Shale::Type::String

    json do
      map "code", to: :code
      map "name", to: :name
      map "type", to: :type
      map "abbreviation", to: :abbreviation
    end
  end
end
