require "equalizer"
require "shale"

module NBA
  # Represents a video event asset with additional asset information
  class VideoEventAsset < Shale::Mapper
    include Equalizer.new(:uuid)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     asset.game_id #=> "0022300001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_event_id
    #   Returns the game event ID
    #   @api public
    #   @example
    #     asset.game_event_id #=> 1
    #   @return [Integer] the game event ID
    attribute :game_event_id, Shale::Type::Integer

    # @!attribute [rw] video_available
    #   Returns the video availability flag
    #   @api public
    #   @example
    #     asset.video_available #=> 1
    #   @return [Integer] the video availability flag
    attribute :video_available, Shale::Type::Integer

    # @!attribute [rw] video_url
    #   Returns the video URL
    #   @api public
    #   @example
    #     asset.video_url #=> "https://videos.nba.com/..."
    #   @return [String] the video URL
    attribute :video_url, Shale::Type::String

    # @!attribute [rw] video_description
    #   Returns the video description
    #   @api public
    #   @example
    #     asset.video_description #=> "Curry makes 3-pt jump shot"
    #   @return [String] the video description
    attribute :video_description, Shale::Type::String

    # @!attribute [rw] uuid
    #   Returns the unique identifier
    #   @api public
    #   @example
    #     asset.uuid #=> "abc123"
    #   @return [String] the unique identifier
    attribute :uuid, Shale::Type::String

    # @!attribute [rw] file_size
    #   Returns the file size in bytes
    #   @api public
    #   @example
    #     asset.file_size #=> 1024000
    #   @return [Integer] the file size
    attribute :file_size, Shale::Type::Integer

    # @!attribute [rw] aspect_ratio
    #   Returns the video aspect ratio
    #   @api public
    #   @example
    #     asset.aspect_ratio #=> "16:9"
    #   @return [String] the aspect ratio
    attribute :aspect_ratio, Shale::Type::String

    # @!attribute [rw] video_duration
    #   Returns the video duration in seconds
    #   @api public
    #   @example
    #     asset.video_duration #=> 15
    #   @return [Integer] the video duration
    attribute :video_duration, Shale::Type::Integer

    # Returns whether video is available
    #
    # @api public
    # @example
    #   asset.video_available? #=> true
    # @return [Boolean] true if video is available
    def video_available?
      video_available.eql?(1)
    end
  end
end
