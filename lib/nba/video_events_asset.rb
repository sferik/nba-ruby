require "json"
require_relative "client"
require_relative "collection"
require_relative "video_event_asset"

module NBA
  # Provides methods to retrieve video events with asset information
  module VideoEventsAsset
    # Result set name
    # @return [String] the result set name
    RESULTS = "resultSets".freeze

    # Retrieves video event assets for a game
    #
    # @api public
    # @example
    #   assets = NBA::VideoEventsAsset.all(game: "0022300001")
    #   assets.each { |a| puts "#{a.video_description}: #{a.video_available?}" }
    # @param game [String, Game] the game ID or Game object
    # @param game_event_id [Integer] the game event ID (default 0)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of video event assets
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
      "videoeventsasset?GameID=#{game_id}&GameEventID=#{game_event_id}"
    end
    private_class_method :build_path

    # Parses the API response into asset objects
    # @api private
    # @return [Collection] collection of assets
    def self.parse_response(response)
      return Collection.new if response.nil? || response.empty?

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      assets = rows.map { |row| build_asset(headers, row) }
      Collection.new(assets)
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

    # Builds a VideoEventAsset object from raw data
    # @api private
    # @return [VideoEventAsset] the asset object
    def self.build_asset(headers, row)
      data = headers.zip(row).to_h
      VideoEventAsset.new(**asset_attributes(data))
    end
    private_class_method :build_asset

    # Extracts asset attributes from data
    # @api private
    # @return [Hash] the asset attributes
    def self.asset_attributes(data)
      game_attributes(data).merge(video_attributes(data))
    end
    private_class_method :asset_attributes

    # Extracts game attributes
    # @api private
    # @return [Hash] the game attributes
    def self.game_attributes(data)
      {game_id: data["GAME_ID"], game_event_id: data["GAME_EVENT_ID"],
       uuid: data["UUID"]}
    end
    private_class_method :game_attributes

    # Extracts video attributes
    # @api private
    # @return [Hash] the video attributes
    def self.video_attributes(data)
      {video_available: data["VIDEO_AVAILABLE_FLAG"],
       video_url: data["VIDEO_URL"],
       video_description: data["DESCRIPTION"],
       file_size: data["FILE_SIZE"],
       aspect_ratio: data["ASPECT_RATIO"],
       video_duration: data["VIDEO_DURATION"]}
    end
    private_class_method :video_attributes
  end
end
