require "json"
require_relative "client"
require_relative "collection"
require_relative "video_status_entry"

module NBA
  # Provides methods to retrieve video status data
  module VideoStatus
    # Result set name
    # @return [String] the result set name
    RESULTS = "VideoStatus".freeze

    # Retrieves video status for a game date
    #
    # @api public
    # @example
    #   entries = NBA::VideoStatus.all(game_date: "2023-10-24")
    #   entries.each { |e| puts "#{e.home_team_name} vs #{e.visitor_team_name}: #{e.available?}" }
    # @param game_date [String] the game date (format: YYYY-MM-DD)
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of video status entries
    def self.all(game_date:, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(game_date, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(game_date, league_id)
      "videostatus?GameDate=#{game_date}&LeagueID=#{league_id}"
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

    # Builds a VideoStatusEntry object from raw data
    # @api private
    # @return [VideoStatusEntry] the entry object
    def self.build_entry(headers, row)
      data = headers.zip(row).to_h
      VideoStatusEntry.new(**entry_attributes(data))
    end
    private_class_method :build_entry

    # Extracts entry attributes from data
    # @api private
    # @return [Hash] the entry attributes
    def self.entry_attributes(data)
      game_attributes(data).merge(team_attributes(data), availability_attributes(data))
    end
    private_class_method :entry_attributes

    # Extracts game attributes
    # @api private
    # @return [Hash] the game attributes
    def self.game_attributes(data)
      {game_id: data.fetch("GAME_ID", nil), game_date: data.fetch("GAME_DATE", nil),
       game_status: data.fetch("GAME_STATUS", nil), game_status_text: data.fetch("GAME_STATUS_TEXT", nil)}
    end
    private_class_method :game_attributes

    # Extracts team attributes
    # @api private
    # @return [Hash] the team attributes
    def self.team_attributes(data)
      visitor_team_attributes(data).merge(home_team_attributes(data))
    end
    private_class_method :team_attributes

    # Extracts visitor team attributes
    # @api private
    # @return [Hash] the visitor team attributes
    def self.visitor_team_attributes(data)
      {visitor_team_id: data.fetch("VISITOR_TEAM_ID", nil), visitor_team_city: data.fetch("VISITOR_TEAM_CITY", nil),
       visitor_team_name: data.fetch("VISITOR_TEAM_NAME", nil),
       visitor_team_abbreviation: data.fetch("VISITOR_TEAM_ABBREVIATION", nil)}
    end
    private_class_method :visitor_team_attributes

    # Extracts home team attributes
    # @api private
    # @return [Hash] the home team attributes
    def self.home_team_attributes(data)
      {home_team_id: data.fetch("HOME_TEAM_ID", nil), home_team_city: data.fetch("HOME_TEAM_CITY", nil),
       home_team_name: data.fetch("HOME_TEAM_NAME", nil), home_team_abbreviation: data.fetch("HOME_TEAM_ABBREVIATION", nil)}
    end
    private_class_method :home_team_attributes

    # Extracts availability attributes
    # @api private
    # @return [Hash] the availability attributes
    def self.availability_attributes(data)
      {is_available: data.fetch("IS_AVAILABLE", nil), pt_xyz_available: data.fetch("PT_XYZ_AVAILABLE", nil)}
    end
    private_class_method :availability_attributes
  end
end
