require "equalizer"
require "shale"
require_relative "conference"

module NBA
  # Represents an NBA division
  class Division < Shale::Mapper
    include Equalizer.new(:id)

    # @!attribute [rw] id
    #   Returns the unique identifier for the division
    #   @api public
    #   @example
    #     division.id #=> 5
    #   @return [Integer] the unique identifier for the division
    attribute :id, Shale::Type::Integer

    # @!attribute [rw] name
    #   Returns the division name
    #   @api public
    #   @example
    #     division.name #=> "Atlantic"
    #   @return [String] the division name
    attribute :name, Shale::Type::String

    # @!attribute [rw] link
    #   Returns the API link for the division
    #   @api public
    #   @example
    #     division.link #=> "/api/v1/divisions/5"
    #   @return [String] the API link for the division
    attribute :link, Shale::Type::String

    # @!attribute [rw] conference
    #   Returns the conference this division belongs to
    #   @api public
    #   @example
    #     division.conference #=> #<NBA::Conference>
    #   @return [Conference] the conference
    attribute :conference, Conference

    json do
      map "id", to: :id
      map "name", to: :name
      map "link", to: :link
      map "conference", to: :conference
    end
  end
end
