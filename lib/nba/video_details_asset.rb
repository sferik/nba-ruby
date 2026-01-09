require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"
require_relative "video_details_asset_entry"

module NBA
  # Provides methods to retrieve video details asset data
  module VideoDetailsAsset
    # Result set name
    # @return [String] the result set name
    RESULTS = "VideoDetailsAsset".freeze

    # Retrieves video details assets for a player
    #
    # @api public
    # @example
    #   entries = NBA::VideoDetailsAsset.find(player: 201939, team: 1610612744, season: 2023)
    #   entries.each { |e| puts "#{e.video_description}: #{e.available?}" }
    # @param player [Integer, String, Player] the player ID or Player object
    # @param team [Integer, String, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param context_measure [String] the context measure (default "FGA")
    # @param season_type [String] the season type (default "Regular Season")
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of video details asset entries
    def self.find(player:, team:, season:, context_measure: "FGA", season_type: "Regular Season", league: League::NBA,
      client: CLIENT)
      player_id = Utils.extract_id(player)
      team_id = Utils.extract_id(team)
      league_id = extract_league_id(league)
      season_param = Utils.format_season(season)
      params = {player_id: player_id, team_id: team_id, season: season_param, context_measure: context_measure,
                season_type: season_type, league_id: league_id}
      path = build_path(params)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(params)
      "videodetailsasset?PlayerID=#{params[:player_id]}&TeamID=#{params[:team_id]}&Season=#{params[:season]}" \
        "&ContextMeasure=#{params[:context_measure]}&SeasonType=#{params[:season_type]}&LeagueID=#{params[:league_id]}"
    end
    private_class_method :build_path

    # Parses the API response into entry objects
    # @api private
    # @return [Collection] collection of entries
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      entries = rows.map { |row| build_entry(headers, row) }
      Collection.new(entries)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(RESULTS) }
    end
    private_class_method :find_result_set

    # Builds a VideoDetailsAssetEntry object from raw data
    # @api private
    # @return [VideoDetailsAssetEntry] the entry object
    def self.build_entry(headers, row)
      data = headers.zip(row).to_h
      VideoDetailsAssetEntry.new(**entry_attributes(data))
    end
    private_class_method :build_entry

    # Extracts entry attributes from data
    # @api private
    # @return [Hash] the entry attributes
    def self.entry_attributes(data)
      identifier_attributes(data).merge(video_attributes(data))
    end
    private_class_method :entry_attributes

    # Extracts identifier attributes
    # @api private
    # @return [Hash] the identifier attributes
    def self.identifier_attributes(data)
      {uuid: data.fetch("UUID", nil), game_id: data.fetch("GAME_ID", nil), game_event_id: data.fetch("GAME_EVENT_ID", nil)}
    end
    private_class_method :identifier_attributes

    # Extracts video attributes
    # @api private
    # @return [Hash] the video attributes
    def self.video_attributes(data)
      {video_available: data.fetch("VIDEO_AVAILABLE", nil), video_url: data.fetch("VIDEO_URL", nil),
       file_size: data.fetch("FILE_SIZE", nil), aspect_ratio: data.fetch("ASPECT_RATIO", nil),
       video_duration: data.fetch("VIDEO_DURATION", nil), video_description: data.fetch("VIDEO_DESCRIPTION", nil)}
    end
    private_class_method :video_attributes

    # Extracts the league ID from a League object or string
    #
    # @api private
    # @param league [String, League] the league ID or League object
    # @return [String] the league ID string
    def self.extract_league_id(league)
      case league
      when League then league.id
      else league
      end
    end
    private_class_method :extract_league_id
  end
end
