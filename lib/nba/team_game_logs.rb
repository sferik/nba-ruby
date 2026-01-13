require "json"
require_relative "client"
require_relative "collection"
require_relative "team_game_log_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve team game logs in batch
  #
  # @api public
  module TeamGameLogs
    # Regular season type
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Playoffs season type
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Per game mode
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Totals mode
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Result set name
    # @return [String] the result set name
    RESULT_SET_NAME = "TeamGameLogs".freeze

    # Retrieves game logs for all teams matching the criteria
    #
    # @api public
    # @example
    #   logs = NBA::TeamGameLogs.all(season: 2024)
    #   logs.each { |log| puts "#{log.game_date}: #{log.team_name} - #{log.pts} pts" }
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param team [Integer, Team, nil] filter by team ID or Team object
    # @param per_mode [String] the per mode (PerGame, Totals)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team game logs
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, team: nil,
      per_mode: PER_GAME, client: CLIENT)
      path = build_path(season, season_type, team, per_mode)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API path
    #
    # @api private
    # @return [String] the API path
    def self.build_path(season, season_type, team, per_mode)
      path = "teamgamelogs?LeagueID=00&Season=#{Utils.format_season(season)}" \
             "&SeasonType=#{season_type}&PerModeSimple=#{per_mode}"
      path += "&TeamID=#{Utils.extract_id(team)}" if team
      path
    end
    private_class_method :build_path

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of team game logs
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      logs = rows.map { |row| build_game_log(headers, row) }
      Collection.new(logs)
    end
    private_class_method :parse_response

    # Finds the result set
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(RESULT_SET_NAME) }
    end
    private_class_method :find_result_set

    # Builds a game log from API data
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [TeamGameLogStat]
    def self.build_game_log(headers, row)
      data = headers.zip(row).to_h
      TeamGameLogStat.new(**game_log_attributes(data))
    end
    private_class_method :build_game_log

    # Combines all game log attributes
    #
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] combined attributes
    def self.game_log_attributes(data)
      game_info(data).merge(team_info(data), shooting_stats(data), counting_stats(data))
    end
    private_class_method :game_log_attributes

    # Extracts game information from data
    #
    # @api private
    # @return [Hash]
    def self.game_info(data)
      {season_year: data["SEASON_YEAR"], game_id: data["GAME_ID"],
       game_date: data["GAME_DATE"], matchup: data["MATCHUP"],
       wl: data["WL"], min: data["MIN"]}
    end
    private_class_method :game_info

    # Extracts team information from data
    #
    # @api private
    # @return [Hash]
    def self.team_info(data)
      {team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"],
       team_name: data["TEAM_NAME"]}
    end
    private_class_method :team_info

    # Extracts shooting statistics from data
    #
    # @api private
    # @return [Hash]
    def self.shooting_stats(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
       ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_stats

    # Extracts counting statistics from data
    #
    # @api private
    # @return [Hash]
    def self.counting_stats(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"],
       ast: data["AST"], stl: data["STL"], blk: data["BLK"],
       tov: data["TOV"], pf: data["PF"], pts: data["PTS"],
       plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :counting_stats
  end
end
