require "json"
require_relative "client"
require_relative "collection"
require_relative "team_info"
require_relative "team_season_rank"
require_relative "utils"

module NBA
  # Provides methods to retrieve team information and season rankings
  #
  # @api public
  module TeamInfoCommon
    # Result set name for team info
    # @return [String] the result set name
    TEAM_INFO_COMMON = "TeamInfoCommon".freeze

    # Result set name for team season ranks
    # @return [String] the result set name
    TEAM_SEASON_RANKS = "TeamSeasonRanks".freeze

    # Result set name for available seasons
    # @return [String] the result set name
    AVAILABLE_SEASONS = "AvailableSeasons".freeze

    # Retrieves team information
    #
    # @api public
    # @example
    #   info = NBA::TeamInfoCommon.find(team: NBA::Team::GSW)
    #   puts "#{info.team_city} #{info.team_name}: #{info.w}-#{info.l}"
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer, nil] the season year (defaults to current season)
    # @param season_type [String, nil] the season type
    # @param client [Client] the API client to use
    # @return [TeamInfo, nil] the team information
    def self.find(team:, season: Utils.current_season, season_type: nil, client: CLIENT)
      path = build_path(team, season, season_type)
      response = client.get(path)
      parse_info_response(response)
    end

    # Retrieves team season rankings
    #
    # @api public
    # @example
    #   ranks = NBA::TeamInfoCommon.ranks(team: NBA::Team::GSW)
    #   puts "Points rank: #{ranks.pts_rank} (#{ranks.pts_pg} PPG)"
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer, nil] the season year (defaults to current season)
    # @param season_type [String, nil] the season type
    # @param client [Client] the API client to use
    # @return [TeamSeasonRank, nil] the team season rankings
    def self.ranks(team:, season: Utils.current_season, season_type: nil, client: CLIENT)
      path = build_path(team, season, season_type)
      response = client.get(path)
      parse_ranks_response(response)
    end

    # Retrieves available seasons for a team
    #
    # @api public
    # @example
    #   seasons = NBA::TeamInfoCommon.available_seasons(team: NBA::Team::GSW)
    #   seasons.each { |s| puts s }
    # @param team [Integer, Team] the team ID or Team object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of season IDs
    def self.available_seasons(team:, client: CLIENT)
      path = build_path(team, nil, nil)
      response = client.get(path)
      parse_seasons_response(response)
    end

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(team, season, season_type)
      team_id = Utils.extract_id(team)
      path = "teaminfocommon?TeamID=#{team_id}&LeagueID=00"
      path += "&Season=#{Utils.format_season(season)}" if season
      path += "&SeasonType=#{season_type}" if season_type
      path
    end
    private_class_method :build_path

    # Parses the API response into team info
    #
    # @api private
    # @return [TeamInfo, nil] the team info
    def self.parse_info_response(response)
      return unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, TEAM_INFO_COMMON)
      return unless result_set

      headers = result_set["headers"]
      row = result_set.dig("rowSet", 0)
      return unless headers && row

      build_team_info(headers.zip(row).to_h)
    end
    private_class_method :parse_info_response

    # Parses the API response into team season ranks
    #
    # @api private
    # @return [TeamSeasonRank, nil] the team season ranks
    def self.parse_ranks_response(response)
      return unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, TEAM_SEASON_RANKS)
      return unless result_set

      headers = result_set["headers"]
      row = result_set.dig("rowSet", 0)
      return unless headers && row

      build_team_season_rank(headers.zip(row).to_h)
    end
    private_class_method :parse_ranks_response

    # Parses the API response into available seasons
    #
    # @api private
    # @return [Collection] collection of season IDs
    def self.parse_seasons_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, AVAILABLE_SEASONS)
      return Collection.new unless result_set

      rows = result_set["rowSet"]
      return Collection.new unless rows

      Collection.new(rows.map(&:first))
    end
    private_class_method :parse_seasons_response

    # Finds a result set by name
    #
    # @api private
    # @return [Hash, nil] the result set hash or nil if not found
    def self.find_result_set(data, result_set_name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(result_set_name) }
    end
    private_class_method :find_result_set

    # Builds a team info object from API data
    # @api private
    # @return [TeamInfo] the team info object
    def self.build_team_info(data)
      TeamInfo.new(team_id: data["TEAM_ID"], team_city: data["TEAM_CITY"], team_name: data["TEAM_NAME"],
        team_abbreviation: data["TEAM_ABBREVIATION"], team_conference: data["TEAM_CONFERENCE"],
        team_division: data["TEAM_DIVISION"], team_code: data["TEAM_CODE"], team_slug: data["TEAM_SLUG"],
        w: data["W"], l: data["L"], pct: data["PCT"], conf_rank: data["CONF_RANK"], div_rank: data["DIV_RANK"],
        min_year: data["MIN_YEAR"], max_year: data["MAX_YEAR"], season_year: data["SEASON_YEAR"])
    end
    private_class_method :build_team_info

    # Builds a team season rank object from API data
    # @api private
    # @return [TeamSeasonRank] the team season rank object
    def self.build_team_season_rank(data)
      TeamSeasonRank.new(league_id: data["LEAGUE_ID"], season_id: data["SEASON_ID"], team_id: data["TEAM_ID"],
        pts_rank: data["PTS_RANK"], pts_pg: data["PTS_PG"], reb_rank: data["REB_RANK"], reb_pg: data["REB_PG"],
        ast_rank: data["AST_RANK"], ast_pg: data["AST_PG"], opp_pts_rank: data["OPP_PTS_RANK"], opp_pts_pg: data["OPP_PTS_PG"])
    end
    private_class_method :build_team_season_rank
  end
end
