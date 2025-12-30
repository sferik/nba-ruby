require "equalizer"
require "shale"

module NBA
  # Represents an NBA conference (Eastern or Western)
  class Conference < Shale::Mapper
    include Equalizer.new(:id)

    # @!attribute [rw] id
    #   Returns the unique identifier for the conference
    #   @api public
    #   @example
    #     conference.id #=> 1
    #   @return [Integer] the unique identifier for the conference
    attribute :id, Shale::Type::Integer

    # @!attribute [rw] name
    #   Returns the conference name
    #   @api public
    #   @example
    #     conference.name #=> "Eastern"
    #   @return [String] the conference name
    attribute :name, Shale::Type::String

    # @!attribute [rw] link
    #   Returns the API link for the conference
    #   @api public
    #   @example
    #     conference.link #=> "/api/v1/conferences/1"
    #   @return [String] the API link for the conference
    attribute :link, Shale::Type::String

    json do
      map "id", to: :id
      map "name", to: :name
      map "link", to: :link
    end
  end
end
