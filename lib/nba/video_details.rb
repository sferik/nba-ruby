require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"
require_relative "video_detail"

module NBA
  # Provides methods to retrieve video details
  module VideoDetails
    # Result set name for video details
    # @return [String] the result set name
    RESULT_SET_NAME = "VideoDetails".freeze

    # Retrieves video details for plays
    #
    # @api public
    # @example
    #   videos = NBA::VideoDetails.find(player: 201939, team: Team::GSW, season: 2023)
    #   videos.each { |v| puts "#{v.description}: #{v.available?}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param context_measure [String] the context measure (default: "FGA")
    # @param season_type [String] the season type (default: "Regular Season")
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of video details
    def self.find(player:, team:, season:, context_measure: "FGA", season_type: "Regular Season", league: League::NBA,
      client: CLIENT)
      player_id = Utils.extract_id(player)
      team_id = Utils.extract_id(team)
      league_id = Utils.extract_league_id(league)
      path = "videodetails?PlayerID=#{player_id}&TeamID=#{team_id}&Season=#{Utils.format_season(season)}" \
             "&ContextMeasure=#{context_measure}&SeasonType=#{season_type}&LeagueID=#{league_id}"
      response = client.get(path)
      parse_response(response)
    end

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of video details
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      videos = rows.map { |row| build_video_detail(headers, row) }
      Collection.new(videos)
    end
    private_class_method :parse_response

    # Finds a result set by name
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(RESULT_SET_NAME) }
    end
    private_class_method :find_result_set

    # Builds a video detail from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [VideoDetail] the video detail object
    def self.build_video_detail(headers, row)
      data = headers.zip(row).to_h
      VideoDetail.new(**video_attributes(data))
    end
    private_class_method :build_video_detail

    # Extracts video attributes from row data
    #
    # @api private
    # @param data [Hash] the video row data
    # @return [Hash] the video attributes
    def self.video_attributes(data)
      identity_attributes(data).merge(video_info_attributes(data))
    end
    private_class_method :video_attributes

    # Extracts identity attributes
    #
    # @api private
    # @param data [Hash] the video data
    # @return [Hash] the identity attributes
    def self.identity_attributes(data)
      {video_id: data.fetch("VIDEO_ID", nil), game_id: data.fetch("GAME_ID", nil),
       game_event_id: data.fetch("GAME_EVENT_ID", nil), player_id: data.fetch("PLAYER_ID", nil),
       team_id: data.fetch("TEAM_ID", nil)}
    end
    private_class_method :identity_attributes

    # Extracts video information attributes
    #
    # @api private
    # @param data [Hash] the video data
    # @return [Hash] the video information attributes
    def self.video_info_attributes(data)
      {description: data.fetch("DESCRIPTION", nil), video_urls: data.fetch("VIDEO_URLS", nil),
       video_available: data.fetch("VIDEO_AVAILABLE", nil)}
    end
    private_class_method :video_info_attributes
  end
end
