require "json"
require_relative "client"
require_relative "collection"
require_relative "league_dash_player_clutch_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide clutch player statistics
  module LeagueDashPlayerClutch
    # Result set name for league dash player clutch
    # @return [String] the result set name
    LEAGUE_DASH_PLAYER_CLUTCH = "LeagueDashPlayerClutch".freeze

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

    # Clutch time constant for last 5 minutes
    # @return [String] the clutch time
    LAST_5_MINUTES = "Last 5 Minutes".freeze

    # Clutch time constant for last 4 minutes
    # @return [String] the clutch time
    LAST_4_MINUTES = "Last 4 Minutes".freeze

    # Clutch time constant for last 3 minutes
    # @return [String] the clutch time
    LAST_3_MINUTES = "Last 3 Minutes".freeze

    # Clutch time constant for last 2 minutes
    # @return [String] the clutch time
    LAST_2_MINUTES = "Last 2 Minutes".freeze

    # Clutch time constant for last 1 minute
    # @return [String] the clutch time
    LAST_1_MINUTE = "Last 1 Minute".freeze

    # Ahead/behind constant for ahead or behind
    # @return [String] the ahead/behind value
    AHEAD_OR_BEHIND = "Ahead or Behind".freeze

    # Ahead/behind constant for behind or tied
    # @return [String] the ahead/behind value
    BEHIND_OR_TIED = "Behind or Tied".freeze

    # Ahead/behind constant for ahead or tied
    # @return [String] the ahead/behind value
    AHEAD_OR_TIED = "Ahead or Tied".freeze

    # Retrieves league-wide clutch player statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueDashPlayerClutch.all(season: 2024)
    #   stats.each { |s| puts "#{s.player_name}: #{s.pts} clutch PPG" }
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param clutch_time [String] the clutch time definition
    # @param ahead_behind [String] the ahead/behind filter
    # @param point_diff [Integer] the point differential
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of clutch player stats
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, clutch_time: LAST_5_MINUTES,
      ahead_behind: AHEAD_OR_BEHIND, point_diff: 5, per_mode: PER_GAME, client: CLIENT)
      opts = {season_type: season_type, clutch_time: clutch_time, ahead_behind: ahead_behind,
              point_diff: point_diff, per_mode: per_mode}
      path = build_path(season, opts)
      response = client.get(path)
      parse_response(response, season)
    end

    # Builds the API path
    #
    # @api private
    # @param season [Integer] the season year
    # @param opts [Hash] the request options
    # @return [String] the API path
    def self.build_path(season, opts)
      season_str = Utils.format_season(season)
      "leaguedashplayerclutch?LeagueID=00&Season=#{season_str}&SeasonType=#{opts.fetch(:season_type)}" \
        "&ClutchTime=#{opts.fetch(:clutch_time)}&AheadBehind=#{opts.fetch(:ahead_behind)}" \
        "&PointDiff=#{opts.fetch(:point_diff)}&PerMode=#{opts.fetch(:per_mode)}&MeasureType=Base"
    end
    private_class_method :build_path

    # Parses the API response
    #
    # @api private
    # @param response [String, nil] the JSON response body
    # @param season [Integer] the season year
    # @return [Collection] a collection of clutch player stats
    def self.parse_response(response, season)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      build_stats(result_set, Utils.format_season(season))
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

      result_sets.find { |rs| rs.fetch("name", nil).eql?(LEAGUE_DASH_PLAYER_CLUTCH) }
    end
    private_class_method :find_result_set

    # Builds stats collection from result set
    #
    # @api private
    # @param result_set [Hash] the result set
    # @param season_id [String] the season ID
    # @return [Collection] collection of clutch player stats
    def self.build_stats(result_set, season_id)
      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_stat(headers, row, season_id) }
      Collection.new(stats)
    end
    private_class_method :build_stats

    # Builds a single clutch player stat
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @param season_id [String] the season ID
    # @return [LeagueDashPlayerClutchStat] the clutch player stat
    def self.build_stat(headers, row, season_id)
      data = headers.zip(row).to_h
      LeagueDashPlayerClutchStat.new(**stat_attributes(data, season_id))
    end
    private_class_method :build_stat

    # Extracts all stat attributes
    #
    # @api private
    # @param data [Hash] the stat data
    # @param season_id [String] the season ID
    # @return [Hash] the stat attributes
    def self.stat_attributes(data, season_id)
      identity_attributes(data, season_id).merge(shooting_attributes(data), counting_attributes(data))
    end
    private_class_method :stat_attributes

    # Extracts identity attributes
    #
    # @api private
    # @param data [Hash] the stat data
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
    # @param data [Hash] the stat data
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
    # @param data [Hash] the stat data
    # @return [Hash] the counting attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), tov: data.fetch("TOV", nil), stl: data.fetch("STL", nil),
       blk: data.fetch("BLK", nil), pf: data.fetch("PF", nil), pts: data.fetch("PTS", nil),
       plus_minus: data.fetch("PLUS_MINUS", nil)}
    end
    private_class_method :counting_attributes
  end
end
