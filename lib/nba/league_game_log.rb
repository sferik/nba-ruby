require "json"
require_relative "client"
require_relative "collection"
require_relative "game_log"
require_relative "team_game_log"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide game logs
  module LeagueGameLog
    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Player or team constant for player logs
    # @return [String] the player/team type
    PLAYER = "P".freeze

    # Player or team constant for team logs
    # @return [String] the player/team type
    TEAM = "T".freeze

    # Result set name for league game log
    # @return [String] the result set name
    LEAGUE_GAME_LOG = "LeagueGameLog".freeze

    # Retrieves league-wide player game logs
    #
    # @api public
    # @example
    #   logs = NBA::LeagueGameLog.player_logs(season: 2024)
    #   logs.each { |l| puts "#{l.game_date}: #{l.matchup} - #{l.pts} pts" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type (Regular Season or Playoffs)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of game logs
    def self.player_logs(season: Utils.current_season, season_type: REGULAR_SEASON, client: CLIENT)
      path = build_path(season, season_type, PLAYER)
      response = client.get(path)
      parse_response(response)
    end

    # Retrieves league-wide team game logs
    #
    # @api public
    # @example
    #   logs = NBA::LeagueGameLog.team_logs(season: 2024)
    #   logs.each { |l| puts "#{l.game_date}: #{l.matchup} - #{l.pts} pts" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type (Regular Season or Playoffs)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of game logs
    def self.team_logs(season: Utils.current_season, season_type: REGULAR_SEASON, client: CLIENT)
      path = build_path(season, season_type, TEAM)
      response = client.get(path)
      parse_team_response(response)
    end

    # Builds the API path
    #
    # @api private
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param player_or_team [String] player or team type
    # @return [String] the API path
    def self.build_path(season, season_type, player_or_team)
      season_str = Utils.format_season(season)
      encoded_type = season_type
      "leaguegamelog?LeagueID=00&Season=#{season_str}&SeasonType=#{encoded_type}&PlayerOrTeam=#{player_or_team}"
    end
    private_class_method :build_path

    # Parses the API response for player logs
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of game logs
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

    # Parses the API response for team logs
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of team game log entries
    def self.parse_team_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      logs = rows.map { |row| build_team_game_log(headers, row) }
      Collection.new(logs)
    end
    private_class_method :parse_team_response

    # Finds the result set
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(LEAGUE_GAME_LOG) }
    end
    private_class_method :find_result_set

    # Builds a game log from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [GameLog] the game log object
    def self.build_game_log(headers, row)
      data = headers.zip(row).to_h
      GameLog.new(**game_log_attributes(data))
    end
    private_class_method :build_game_log

    # Builds a team game log from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [TeamGameLogEntry] the team game log object
    def self.build_team_game_log(headers, row)
      data = headers.zip(row).to_h
      TeamGameLogEntry.new(**team_game_log_attributes(data))
    end
    private_class_method :build_team_game_log

    # Extracts game log attributes from row data
    #
    # @api private
    # @param data [Hash] the game log row data
    # @return [Hash] the game log attributes
    def self.game_log_attributes(data)
      game_info_attributes(data).merge(shooting_attributes(data), counting_attributes(data))
    end
    private_class_method :game_log_attributes

    # Extracts team game log attributes from row data
    #
    # @api private
    # @param data [Hash] the game log row data
    # @return [Hash] the game log attributes
    def self.team_game_log_attributes(data)
      team_info_attributes(data).merge(shooting_attributes(data), counting_attributes(data))
    end
    private_class_method :team_game_log_attributes

    # Extracts game info attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the game info attributes
    def self.game_info_attributes(data)
      {season_id: data.fetch("SEASON_ID"), player_id: data.fetch("PLAYER_ID"),
       game_id: data.fetch("GAME_ID"), game_date: data.fetch("GAME_DATE"),
       matchup: data.fetch("MATCHUP"), wl: data.fetch("WL"), min: data.fetch("MIN")}
    end
    private_class_method :game_info_attributes

    # Extracts team info attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the team info attributes
    def self.team_info_attributes(data)
      {team_id: data.fetch("TEAM_ID"), game_id: data.fetch("GAME_ID"),
       game_date: data.fetch("GAME_DATE"), matchup: data.fetch("MATCHUP"),
       wl: data.fetch("WL"), min: data.fetch("MIN")}
    end
    private_class_method :team_info_attributes

    # Extracts shooting attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM"), fga: data.fetch("FGA"), fg_pct: data.fetch("FG_PCT"),
       fg3m: data.fetch("FG3M"), fg3a: data.fetch("FG3A"), fg3_pct: data.fetch("FG3_PCT"),
       ftm: data.fetch("FTM"), fta: data.fetch("FTA"), ft_pct: data.fetch("FT_PCT")}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the counting stats attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB"), dreb: data.fetch("DREB"), reb: data.fetch("REB"),
       ast: data.fetch("AST"), stl: data.fetch("STL"), blk: data.fetch("BLK"),
       tov: data.fetch("TOV"), pf: data.fetch("PF"), pts: data.fetch("PTS"), plus_minus: data.fetch("PLUS_MINUS")}
    end
    private_class_method :counting_attributes
  end
end
