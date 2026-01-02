require "equalizer"
require "shale"

module NBA
  # Represents a basketball league
  class League < Shale::Mapper
    include Equalizer.new(:id)

    # NBA league ID
    # @return [String] the NBA league ID
    NBA = "00".freeze

    # WNBA league ID
    # @return [String] the WNBA league ID
    WNBA = "10".freeze

    # G League (NBA Development League) ID
    # @return [String] the G League ID
    G_LEAGUE = "20".freeze

    # @!attribute [rw] id
    #   Returns the unique identifier for the league
    #   @api public
    #   @example
    #     league.id #=> "00"
    #   @return [String] the unique identifier for the league
    attribute :id, Shale::Type::String

    # @!attribute [rw] name
    #   Returns the name of the league
    #   @api public
    #   @example
    #     league.name #=> "NBA"
    #   @return [String] the name of the league
    attribute :name, Shale::Type::String
  end
end
