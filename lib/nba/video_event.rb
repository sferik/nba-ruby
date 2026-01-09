require "equalizer"
require "shale"

module NBA
  # Represents a video event
  class VideoEvent < Shale::Mapper
    include Equalizer.new(:uuid)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     event.game_id #=> "0022300001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_event_id
    #   Returns the game event ID
    #   @api public
    #   @example
    #     event.game_event_id #=> 1
    #   @return [Integer] the game event ID
    attribute :game_event_id, Shale::Type::Integer

    # @!attribute [rw] video_available
    #   Returns the video availability flag
    #   @api public
    #   @example
    #     event.video_available #=> 1
    #   @return [Integer] the video availability flag
    attribute :video_available, Shale::Type::Integer

    # @!attribute [rw] video_url
    #   Returns the video URL
    #   @api public
    #   @example
    #     event.video_url #=> "https://videos.nba.com/..."
    #   @return [String] the video URL
    attribute :video_url, Shale::Type::String

    # @!attribute [rw] video_description
    #   Returns the video description
    #   @api public
    #   @example
    #     event.video_description #=> "Curry makes 3-pt jump shot"
    #   @return [String] the video description
    attribute :video_description, Shale::Type::String

    # @!attribute [rw] video_category
    #   Returns the video category
    #   @api public
    #   @example
    #     event.video_category #=> "Made Shot"
    #   @return [String] the video category
    attribute :video_category, Shale::Type::String

    # @!attribute [rw] uuid
    #   Returns the unique identifier
    #   @api public
    #   @example
    #     event.uuid #=> "abc123"
    #   @return [String] the unique identifier
    attribute :uuid, Shale::Type::String

    # @!attribute [rw] title
    #   Returns the video title
    #   @api public
    #   @example
    #     event.title #=> "Curry 3PT"
    #   @return [String] the video title
    attribute :title, Shale::Type::String

    # Returns whether video is available
    #
    # @api public
    # @example
    #   event.video_available? #=> true
    # @return [Boolean] true if video is available
    def video_available?
      video_available.eql?(1)
    end
  end
end
