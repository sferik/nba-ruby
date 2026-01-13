require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "league_wide_shot_stat"

module NBA
  # Provides methods to retrieve league-wide shot chart data
  module ShotChartLeagueWide
    # Result set name for league-wide shot data
    # @return [String] the result set name
    LEAGUE_WIDE = "LeagueWide".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Retrieves league-wide shot statistics
    #
    # @api public
    # @example
    #   stats = NBA::ShotChartLeagueWide.all(season: 2024)
    #   stats.each { |s| puts "#{s.shot_zone_basic}: #{(s.fg_pct * 100).round(1)}%" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of league-wide shot stats
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, client: CLIENT)
      path = build_path(season, season_type)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(season, season_type)
      season_str = Utils.format_season(season)
      "shotchartleaguewide?LeagueID=00&Season=#{season_str}&SeasonType=#{season_type}"
    end
    private_class_method :build_path

    # Parses the API response into shot stat objects
    #
    # @api private
    # @return [Collection] collection of shot stats
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_shot_stat(headers, row) }
      Collection.new(stats)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    #
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(LEAGUE_WIDE) }
    end
    private_class_method :find_result_set

    # Builds a LeagueWideShotStat object from raw data
    #
    # @api private
    # @return [LeagueWideShotStat] the shot stat object
    def self.build_shot_stat(headers, row)
      data = headers.zip(row).to_h
      LeagueWideShotStat.new(**shot_stat_attributes(data))
    end
    private_class_method :build_shot_stat

    # Extracts shot stat attributes from data
    #
    # @api private
    # @return [Hash] shot stat attributes
    def self.shot_stat_attributes(data)
      {grid_type: data["GRID_TYPE"], shot_zone_basic: data["SHOT_ZONE_BASIC"],
       shot_zone_area: data["SHOT_ZONE_AREA"], shot_zone_range: data["SHOT_ZONE_RANGE"],
       fga: data["FGA"], fgm: data["FGM"], fg_pct: data["FG_PCT"]}
    end
    private_class_method :shot_stat_attributes
  end
end
