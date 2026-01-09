require "equalizer"
require "shale"

module NBA
  # Represents a video details asset entry
  class VideoDetailsAssetEntry < Shale::Mapper
    include Equalizer.new(:uuid)

    # @!attribute [rw] uuid
    #   Returns the unique identifier
    #   @api public
    #   @example
    #     entry.uuid #=> "abc123def456"
    #   @return [String] the unique identifier
    attribute :uuid, Shale::Type::String

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     entry.game_id #=> "0022300001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_event_id
    #   Returns the game event ID
    #   @api public
    #   @example
    #     entry.game_event_id #=> 1
    #   @return [Integer] the game event ID
    attribute :game_event_id, Shale::Type::Integer

    # @!attribute [rw] video_available
    #   Returns the video availability flag
    #   @api public
    #   @example
    #     entry.video_available #=> 1
    #   @return [Integer] the video availability flag
    attribute :video_available, Shale::Type::Integer

    # @!attribute [rw] video_url
    #   Returns the video URL
    #   @api public
    #   @example
    #     entry.video_url #=> "https://videos.nba.com/video.mp4"
    #   @return [String] the video URL
    attribute :video_url, Shale::Type::String

    # @!attribute [rw] file_size
    #   Returns the file size in bytes
    #   @api public
    #   @example
    #     entry.file_size #=> 1024000
    #   @return [Integer] the file size in bytes
    attribute :file_size, Shale::Type::Integer

    # @!attribute [rw] aspect_ratio
    #   Returns the aspect ratio
    #   @api public
    #   @example
    #     entry.aspect_ratio #=> "16:9"
    #   @return [String] the aspect ratio
    attribute :aspect_ratio, Shale::Type::String

    # @!attribute [rw] video_duration
    #   Returns the video duration in seconds
    #   @api public
    #   @example
    #     entry.video_duration #=> 12.5
    #   @return [Float] the video duration in seconds
    attribute :video_duration, Shale::Type::Float

    # @!attribute [rw] video_description
    #   Returns the video description
    #   @api public
    #   @example
    #     entry.video_description #=> "3PT Jump Shot by Player"
    #   @return [String] the video description
    attribute :video_description, Shale::Type::String

    # Returns whether video is available
    #
    # @api public
    # @example
    #   entry.available? #=> true
    # @return [Boolean] true if video is available
    def available?
      video_available.eql?(1)
    end
  end
end
