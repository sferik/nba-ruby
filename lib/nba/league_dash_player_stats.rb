require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "league_dash_player_stat"

module NBA
  # Provides methods to retrieve league-wide player statistics
  module LeagueDashPlayerStats
    # Result set name for league dash player stats
    # @return [String] the result set name
    LEAGUE_DASH_PLAYER_STATS = "LeagueDashPlayerStats".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Per mode constant for per game stats
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Per mode constant for totals
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Per mode constant for per 36 minutes
    # @return [String] the per mode
    PER_36 = "Per36".freeze

    # Retrieves league-wide player statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueDashPlayerStats.all(season: 2024)
    #   stats.each { |s| puts "#{s.player_name}: #{s.pts} ppg" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player stats
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      path = build_path(season, season_type, per_mode)
      response = client.get(path)
      parse_response(response, season)
    end

    # Builds the API path
    #
    # @api private
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @return [String] the API path
    def self.build_path(season, season_type, per_mode)
      season_str = Utils.format_season(season)
      encoded_type = season_type
      "leaguedashplayerstats?LeagueID=00&Season=#{season_str}&SeasonType=#{encoded_type}&PerMode=#{per_mode}" \
        "&MeasureType=Base&Pace=N&PlusMinus=N&Rank=N"
    end
    private_class_method :build_path

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @param season [Integer] the season year
    # @return [Collection] a collection of player stats
    def self.parse_response(response, season)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      season_id = Utils.format_season(season)
      stats = rows.map { |row| build_player_stat(headers, row, season_id) }
      Collection.new(stats)
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

      result_sets.find { |rs| rs.fetch("name", nil).eql?(LEAGUE_DASH_PLAYER_STATS) }
    end
    private_class_method :find_result_set

    # Builds a player stat from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @param season_id [String] the season ID
    # @return [LeagueDashPlayerStat] the player stat object
    def self.build_player_stat(headers, row, season_id)
      data = headers.zip(row).to_h
      LeagueDashPlayerStat.new(**player_stat_attributes(data, season_id))
    end
    private_class_method :build_player_stat

    # Extracts player stat attributes from row data
    #
    # @api private
    # @param data [Hash] the player stat row data
    # @param season_id [String] the season ID
    # @return [Hash] the player stat attributes
    def self.player_stat_attributes(data, season_id)
      identity_attributes(data, season_id).merge(shooting_attributes(data), counting_attributes(data), advanced_attributes(data))
    end
    private_class_method :player_stat_attributes

    # Extracts identity attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @param season_id [String] the season ID
    # @return [Hash] the identity attributes
    def self.identity_attributes(data, season_id)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       age: data.fetch("AGE", nil), gp: data.fetch("GP", nil), w: data.fetch("W", nil), l: data.fetch("L", nil),
       w_pct: data.fetch("W_PCT", nil), min: data.fetch("MIN", nil), season_id: season_id}
    end
    private_class_method :identity_attributes

    # Extracts shooting attributes
    #
    # @api private
    # @param data [Hash] the player stat data
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
    # @param data [Hash] the player stat data
    # @return [Hash] the counting stats attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), tov: data.fetch("TOV", nil), stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil),
       blka: data.fetch("BLKA", nil), pf: data.fetch("PF", nil), pfd: data.fetch("PFD", nil), pts: data.fetch("PTS", nil)}
    end
    private_class_method :counting_attributes

    # Extracts advanced attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the advanced attributes
    def self.advanced_attributes(data)
      {plus_minus: data.fetch("PLUS_MINUS", nil), nba_fantasy_pts: data.fetch("NBA_FANTASY_PTS", nil),
       dd2: data.fetch("DD2", nil), td3: data.fetch("TD3", nil)}
    end
    private_class_method :advanced_attributes
  end
end
