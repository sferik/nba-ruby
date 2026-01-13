require "json"
require_relative "client"
require_relative "collection"
require_relative "video_event"

module NBA
  # Provides methods to retrieve video events
  module VideoEvents
    # Result set name
    # @return [String] the result set name
    RESULTS = "resultSets".freeze

    # Retrieves video events for a game
    #
    # @api public
    # @example
    #   events = NBA::VideoEvents.all(game: "0022300001")
    #   events.each { |e| puts "#{e.title}: #{e.video_available?}" }
    # @param game [String, Game] the game ID or Game object
    # @param game_event_id [Integer] the game event ID (default 0)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of video events
    def self.all(game:, game_event_id: 0, client: CLIENT)
      game_id = Utils.extract_id(game)
      path = build_path(game_id, game_event_id)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(game_id, game_event_id)
      "videoevents?GameID=#{game_id}&GameEventID=#{game_event_id}"
    end
    private_class_method :build_path

    # Parses the API response into event objects
    # @api private
    # @return [Collection] collection of events
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      events = rows.map { |row| build_event(headers, row) }
      Collection.new(events)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data[RESULTS]
      return unless result_sets

      result_sets.first
    end
    private_class_method :find_result_set

    # Builds a VideoEvent object from raw data
    # @api private
    # @return [VideoEvent] the event object
    def self.build_event(headers, row)
      data = headers.zip(row).to_h
      VideoEvent.new(**event_attributes(data))
    end
    private_class_method :build_event

    # Extracts event attributes from data
    # @api private
    # @return [Hash] the event attributes
    def self.event_attributes(data)
      game_attributes(data).merge(video_attributes(data))
    end
    private_class_method :event_attributes

    # Extracts game attributes
    # @api private
    # @return [Hash] the game attributes
    def self.game_attributes(data)
      {game_id: data["GAME_ID"], game_event_id: data["GAME_EVENT_ID"]}
    end
    private_class_method :game_attributes

    # Extracts video attributes
    # @api private
    # @return [Hash] the video attributes
    def self.video_attributes(data)
      {video_available: data["VIDEO_AVAILABLE_FLAG"],
       video_url: data["VIDEO_URL"],
       video_description: data["DESCRIPTION"],
       video_category: data["CATEGORY"],
       uuid: data["UUID"],
       title: data["TITLE"]}
    end
    private_class_method :video_attributes
  end
end
