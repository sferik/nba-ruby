require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "team_game_log_entry"

module NBA
  # Provides methods to retrieve team game logs
  module TeamGameLog
    # Regular season type
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Playoffs season type
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Retrieves game logs for a team
    #
    # @api public
    # @example
    #   logs = NBA::TeamGameLog.find(team: Team::GSW)
    #   logs.each { |log| puts "#{log.game_date}: #{log.pts} points" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team game logs
    def self.find(team:, season: Utils.current_season, season_type: REGULAR_SEASON, client: CLIENT)
      team_id = extract_team_id(team)
      season_str = Utils.format_season(season)
      path = build_path(team_id, season_str, season_type)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API path for team game log
    #
    # @api private
    # @param team_id [Integer] the team ID
    # @param season_str [String] the season string
    # @param season_type [String] the season type
    # @return [String] the API path
    def self.build_path(team_id, season_str, season_type)
      encoded_type = season_type
      "teamgamelog?TeamID=#{team_id}&Season=#{season_str}&SeasonType=#{encoded_type}"
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
      result_set = data.dig("resultSets", 0)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      logs = rows.map { |row| build_team_game_log(headers, row) }
      Collection.new(logs)
    end
    private_class_method :parse_response

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

    # Combines all team game log attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the combined attributes
    def self.team_game_log_attributes(data)
      game_info_attributes(data).merge(shooting_attributes(data), counting_attributes(data))
    end
    private_class_method :team_game_log_attributes

    # Extracts game info attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the game info attributes
    def self.game_info_attributes(data)
      {team_id: data.fetch("Team_ID", nil), game_id: data.fetch("Game_ID", nil), game_date: data.fetch("GAME_DATE", nil),
       matchup: data.fetch("MATCHUP", nil), wl: data.fetch("WL", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :game_info_attributes

    # Extracts shooting attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the counting stats attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil),
       tov: data.fetch("TOV", nil), pf: data.fetch("PF", nil), pts: data.fetch("PTS", nil),
       plus_minus: data.fetch("PLUS_MINUS", nil)}
    end
    private_class_method :counting_attributes

    # Extracts team ID from a Team object or returns the integer
    #
    # @api private
    # @param team [Team, Integer] the team or team ID
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      case team
      when Team then team.id
      else team
      end
    end
    private_class_method :extract_team_id
  end
end
