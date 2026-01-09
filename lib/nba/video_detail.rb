require "equalizer"
require "shale"

module NBA
  # Represents a video detail for a play
  class VideoDetail < Shale::Mapper
    include Equalizer.new(:video_id)

    # @!attribute [rw] video_id
    #   Returns the video ID
    #   @api public
    #   @example
    #     video.video_id #=> "abc123"
    #   @return [String] the video ID
    attribute :video_id, Shale::Type::String

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     video.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_event_id
    #   Returns the game event ID
    #   @api public
    #   @example
    #     video.game_event_id #=> 10
    #   @return [Integer] the event ID
    attribute :game_event_id, Shale::Type::Integer

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     video.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     video.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] description
    #   Returns the play description
    #   @api public
    #   @example
    #     video.description #=> "Curry 3PT Jump Shot"
    #   @return [String] the play description
    attribute :description, Shale::Type::String

    # @!attribute [rw] video_urls
    #   Returns the video URLs
    #   @api public
    #   @example
    #     video.video_urls #=> "{\"720p\": \"url1\", \"1080p\": \"url2\"}"
    #   @return [String] the video URLs JSON string
    attribute :video_urls, Shale::Type::String

    # @!attribute [rw] video_available
    #   Returns the video availability flag
    #   @api public
    #   @example
    #     video.video_available #=> 1
    #   @return [Integer] 1 if available, 0 if not
    attribute :video_available, Shale::Type::Integer

    # Returns whether the video is available
    #
    # @api public
    # @example
    #   video.available? #=> true
    # @return [Boolean] true if video is available
    def available?
      video_available.eql?(1)
    end

    # Returns the player object for this video
    #
    # @api public
    # @example
    #   video.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team object for this video
    #
    # @api public
    # @example
    #   video.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
