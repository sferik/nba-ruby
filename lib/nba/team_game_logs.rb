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

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
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
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(RESULT_SET_NAME) }
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
      {season_year: data.fetch("SEASON_YEAR", nil), game_id: data.fetch("GAME_ID", nil),
       game_date: data.fetch("GAME_DATE", nil), matchup: data.fetch("MATCHUP", nil),
       wl: data.fetch("WL", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :game_info

    # Extracts team information from data
    #
    # @api private
    # @return [Hash]
    def self.team_info(data)
      {team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       team_name: data.fetch("TEAM_NAME", nil)}
    end
    private_class_method :team_info

    # Extracts shooting statistics from data
    #
    # @api private
    # @return [Hash]
    def self.shooting_stats(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_stats

    # Extracts counting statistics from data
    #
    # @api private
    # @return [Hash]
    def self.counting_stats(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil),
       tov: data.fetch("TOV", nil), pf: data.fetch("PF", nil), pts: data.fetch("PTS", nil),
       plus_minus: data.fetch("PLUS_MINUS", nil)}
    end
    private_class_method :counting_stats
  end
end
