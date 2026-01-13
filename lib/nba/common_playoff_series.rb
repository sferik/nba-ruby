require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "playoff_series"

module NBA
  # Provides methods to retrieve playoff series data
  module CommonPlayoffSeries
    # Result set name for playoff series
    # @return [String] the result set name
    PLAYOFF_SERIES = "PlayoffSeries".freeze

    # Retrieves all playoff series for a season
    #
    # @api public
    # @example
    #   series = NBA::CommonPlayoffSeries.all(season: 2024)
    #   series.each { |s| puts "Game #{s.game_num}: #{s.home_team_id} vs #{s.visitor_team_id}" }
    # @param season [Integer] the season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of playoff series
    def self.all(season: Utils.current_season, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(season, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, league_id)
      season_str = Utils.format_season(season)
      "commonplayoffseries?LeagueID=#{league_id}&Season=#{season_str}"
    end
    private_class_method :build_path

    # Parses the API response into playoff series objects
    # @api private
    # @return [Collection] collection of playoff series
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      series = rows.map { |row| build_series(headers, row) }
      Collection.new(series)
    end
    private_class_method :parse_response

    # Finds the playoff series result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(PLAYOFF_SERIES) }
    end
    private_class_method :find_result_set

    # Builds a PlayoffSeries object from raw data
    # @api private
    # @return [PlayoffSeries] the playoff series object
    def self.build_series(headers, row)
      data = headers.zip(row).to_h
      PlayoffSeries.new(**series_attributes(data))
    end
    private_class_method :build_series

    # Extracts series attributes from data
    # @api private
    # @return [Hash] series attributes
    def self.series_attributes(data)
      {game_id: data["GAME_ID"], home_team_id: data["HOME_TEAM_ID"],
       visitor_team_id: data["VISITOR_TEAM_ID"], series_id: data["SERIES_ID"],
       game_num: data["GAME_NUM"]}
    end
    private_class_method :series_attributes
  end
end
