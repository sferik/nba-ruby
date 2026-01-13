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

      headers = result_set["headers"]
      rows = result_set["rowSet"]
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
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(LEAGUE_DASH_PLAYER_STATS) }
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
      {player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"],
       age: data["AGE"], gp: data["GP"], w: data["W"], l: data["L"],
       w_pct: data["W_PCT"], min: data["MIN"], season_id: season_id}
    end
    private_class_method :identity_attributes

    # Extracts shooting attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the shooting attributes
    def self.shooting_attributes(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
       ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the counting stats attributes
    def self.counting_attributes(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"],
       ast: data["AST"], tov: data["TOV"], stl: data["STL"], blk: data["BLK"],
       blka: data["BLKA"], pf: data["PF"], pfd: data["PFD"], pts: data["PTS"]}
    end
    private_class_method :counting_attributes

    # Extracts advanced attributes
    #
    # @api private
    # @param data [Hash] the player stat data
    # @return [Hash] the advanced attributes
    def self.advanced_attributes(data)
      {plus_minus: data["PLUS_MINUS"], nba_fantasy_pts: data["NBA_FANTASY_PTS"],
       dd2: data["DD2"], td3: data["TD3"]}
    end
    private_class_method :advanced_attributes
  end
end
